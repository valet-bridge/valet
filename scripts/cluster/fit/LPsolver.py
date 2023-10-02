import pandas as pd
import numpy as np
import time
import sys
from scipy.optimize import linprog

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables
from fit.Sigmoids import Sigmoids


class LPsolver:
  '''Set up and solve an incremental LP problem.'''

  def __init__(self):
    self.c = np.zeros(NUM_VAR)
    self.A_ub = np.zeros((NUM_DOMINANCES, NUM_VAR))
    self.b_ub = np.zeros(NUM_DOMINANCES)
    self.A_eq = np.zeros((0, 0))
    self.b_eq = np.zeros(0)
    self.bounds = []

  
  def resize_eq(self, suit_equiv, dist_equiv):
    '''Only know the size of A_eq and B_eq when we've read the files.'''
    self.A_eq = np.zeros((BRIDGE_TRICKS + 2 + suit_equiv + dist_equiv, \
      NUM_VAR))
    self.b_eq = np.zeros(BRIDGE_TRICKS + 2 + suit_equiv + dist_equiv)

  
  def set_box_constraints(self, estimate, step_size):
    self.bounds = estimate.set_box_constraints(step_size)


  def set_constraints(self, suit_info, dist_info, estimate, step_size):
    # Dominances
    suit_info.set_lp_upper_constraints(self.A_ub, self.b_ub)

    # Weighted average points within each suit length.
    # Also the suit equivalences.
    # So BRIDGE_TRICKS+1 + num_equivalences in total.
    suit_info.set_lp_equal_constraints(self.A_eq, self.b_eq)

    # Sum (unweighted) of distribution HCP to remain constant.
    # Also the distribution equivalences.
    dist_info.set_lp_equal_constraints(suit_info.num_equivalences(), \
      self.A_eq, self.b_eq)

    # Limits of +/- 1 step_size.
    self.set_box_constraints(estimate, step_size)

  
  def set_objective(self, gradient_sno, gradient_dno):
    self.c[:NUM_SUITS] = gradient_sno
    self.c[NUM_SUITS:] = gradient_dno

  
  def calc_gradients(self, df, \
    # df_pos_vul_sno, df_pos_vul_dno, \
    sigmoids, bins, solution):
    '''Calculate the gradients w.r.t. the variables.'''

    # Melt the sno1..sno4 fields into a single sno field.
    df_melted = df.melt(\
      id_vars = ['pos', 'vul', 'pass', 'dno', 'bin'], \
      value_vars = ['sno1', 'sno2', 'sno3', 'sno4'], \
      value_name = 'sno')

    # Make histograms of binned strength for each (pos, vul, value).
    hist_dno = df.pivot_table( \
      index = ['pos', 'vul', 'dno'], \
      columns = 'bin', \
      aggfunc = 'size', \
      fill_value = 0).reset_index()

    hist_sno = df_melted.pivot_table( \
      index = ['pos', 'vul', 'sno'], \
      columns = 'bin', \
      aggfunc = 'size', \
      fill_value = 0).reset_index()

    hist_sno.rename(columns = {'sno': 'dno'}, inplace = True)

    # Have to recalculate the pass bins for (pos, vul, sno, bin), 
    # as the strengths have changed.
    df_pos_vul_sno = df_melted.groupby( \
      ['pos', 'vul', 'sno', 'bin']).agg({'pass' : 'sum'})

    # Rename from sno to dno to fit with Sigmoids (hist_to_prediction).
    df_pos_vul_sno.index.names = ['pos', 'vul', 'dno', 'bin']

    # Count the actual passes by (pos, vul, dno, bin).
    # We start from df, not from df_melted, as df_melted has the same dno
    # appearing four times (once for sno1..sno4).
    df_pos_vul_dno = df.groupby( \
      ['pos', 'vul', 'dno', 'bin']).agg({'pass' : 'sum'})


    # Predict the absolute number of passes for each variable number.
    # The results are numpy 1D arrays.  Also calculate the gradients.
    # results_dno, gradient_dno, total_error_dno = \
    gradient_dno, total_error_dno = \
      sigmoids.hist_to_gradients(hist_dno, df_pos_vul_dno, NUM_DIST)
    # results_sno, gradient_sno, total_error_sno = \
    gradient_sno, total_error_sno = \
      sigmoids.hist_to_gradients(hist_sno, df_pos_vul_sno, NUM_SUITS)

    return gradient_sno, gradient_dno, total_error_sno, total_error_dno


  def run_once(self):
    '''
    print("c vector")
    for i in range(len(self.c)):
      if self.c[i]:
        print(i, self.c[i])
    print("\n")

    print("A_ub")
    for i in range(len(self.A_ub)):
      for j in range(len(self.A_ub[0])):
        if (self.A_ub[i][j]):
          print(i, j, self.A_ub[i][j])
    print("\n")

    print("b_ub")
    for i in range(len(self.b_ub)):
      if self.b_ub[i]:
        print(i, self.b_ub[i])
    print("\n")

    print("A_eq")
    print(self.A_eq)
    print("\n")

    print("b_eq")
    print(self.b_eq)
    for i in range(len(self.b_eq)):
      if self.b_eq[i]:
        print(i, self.b_eq[i])
    print("\n")

    print("bounds")
    for i in range(len(self.bounds)):
      print(i, self.bounds[i])
    print("\n")
    '''

    '''
    print("A_eq")
    for i in range(len(self.A_eq)):
      for j in range(len(self.A_eq[i])):
        if self.A_eq[i][j] != 0:
          print(i, j, self.A_eq[i][j])

    print("b_eq")
    for i in range(len(self.b_eq)):
      print(i, self.b_eq[i])
    '''
    
    result = linprog(self.c, A_ub = self.A_ub, b_ub = self.b_ub, \
      A_eq = self.A_eq, b_eq = self.b_eq, bounds = self.bounds)
    print(result.message)

    return np.array(result.x)


  def calc_change(self, solution, new_solution):
    
    num_changes = 0
    changes_var = 0
    change_obj = 0
    num_interior = 0

    for i in range(NUM_VAR):
      s0 = solution.data[i]
      s1 = new_solution.data[i]
      b0 = self.bounds[i][0]
      b1 = self.bounds[i][1]

      delta = abs(s0-s1)
      if (delta > 1.e-6):
        num_changes += 1
      
      changes_var += delta
      if (s1-b0 > 1.e-6 and b1-s1 > 1.e-6):
        num_interior += 1

    change_obj = self.c @ (solution.data - new_solution.data)

    return num_changes, changes_var, change_obj, num_interior
    

  def run_until_interior(self, df, \
    # df_pos_vul_sno, df_pos_vul_dno, \
    sigmoids, bins, step_size, num_iters, solution, suit_info, dist_info):
    '''Set up and re-run LP until the box bounds are not right.'''

    # Add sum and bin columns to df based on dno, sno1 .. sno4.
    # These depend on the current solution, so they must be
    # recalculated.

    iter = 0
    solution0 = solution
    new_solution = Variables()

    while True:

      self.set_box_constraints(solution, step_size)

      solution.add_strengths(bins, df)

      gradient_sno, gradient_dno, error_sno, error_dno = \
        self.calc_gradients(df, \
        # df_pos_vul_sno, df_pos_vul_dno, \
        sigmoids, bins, solution)

      self.set_objective(gradient_sno, gradient_dno)

      '''
      print("equality constraints right now")
      slack = self.b_eq - (self.A_eq @ solution.data)
      for i in range(len(slack)):
        if abs(slack[i]) > 1.e-6: 
          print("slack at", i, slack[i])
          for j in range(len(self.A_eq[i])):
            if (self.A_eq[i][j] != 0):
              print('A_eq', j, self.A_eq[i][j])
              print("var value", solution.data[j])
          print('b_eq', self.b_eq[i])
          '''

      new_solution.data = self.run_once()

      '''
      print("equality constraints after LP")
      slack = self.b_eq - (self.A_eq @ solution.data)
      for i in range(len(slack)):
        if abs(slack[i]) > 1.e-6: 
          print("slack at", i, slack[i])
          for j in range(len(self.A_eq[i])):
            if (self.A_eq[i][j] != 0):
              print('A_eq', j, self.A_eq[i][j])
          print('b_eq', self.b_eq[i])
      quit()
      '''

      iter += 1
      print("LP iteration", "{:12d}".format(iter))

      num_changes, changes_var, change_obj, num_interior = \
        self.calc_change(solution, new_solution)

      print("error suit  ", "{:12.4f}".format(error_sno))
      print("error dist  ", "{:12.4f}".format(error_dno))
      print("error total ", "{:12.4f}".format(error_sno + error_dno))
      print("changes_var ", "{:12.4f}".format(changes_var))
      print("num_changes ", "{:12d}".format(num_changes))
      print("change_obj  ", "{:12.4f}".format(change_obj))
      print("num_interior", "{:12d}".format(num_interior), "\n")

      print(new_solution.str_simple(suit_info, dist_info))
      sys.stdout.flush()

      solution.data = new_solution.data

      if num_interior == NUM_VAR:
        break

      if iter == num_iters:
        break

    num_changes, changes_var, change_obj, num_interior = \
      self.calc_change(solution0, new_solution)

    return change_obj


