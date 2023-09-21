import pandas as pd
import numpy as np
import time
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
    self.A_eq = np.zeros((2, NUM_VAR))
    self.b_eq = np.zeros(2)
    self.bounds = []

  
  def set_box_constraints(self, estimate, step_size):
    self.bounds = estimate.set_box_constraints(step_size)


  def set_constraints(self, suit_info, dist_info, estimate, step_size):
    # Dominances
    suit_info.set_lp_upper_constraints(self.A_ub, self.b_ub)

    # Weighted average of 5 points per suit.
    suit_info.set_lp_equal_constraints(self.A_eq, self.b_eq)

    # Sum (unweighted) of distribution HCP to remain constant.
    dist_info.set_lp_equal_constraints(self.A_eq, self.b_eq)

    # Limits of +/- 1 step_size.
    self.set_box_constraints(estimate, step_size)

  
  def set_objective(self, gradient_sno, gradient_dno):
    self.c[:NUM_SUITS] = gradient_sno
    self.c[NUM_SUITS:] = gradient_dno

  
  def calc_gradients(self, df, sigmoids, bins, solution):
    '''Calculate the gradients w.r.t. the variables.'''

    # Melt the sno1..sno4 fields into a single sno field.
    df_melted = df.melt(\
      id_vars = ['pos', 'vul', 'pass', 'dno', 'bin'], \
      value_vars = ['sno1', 'sno2', 'sno3', 'sno4'], \
      value_name = 'sno')

    # Count the actual passes by (pos, vul, sno) and only by sno.
    df_pos_vul_sno = df_melted.groupby( \
      ['pos', 'vul', 'sno']).agg({'pass' : 'sum'})

    # Rename from sno to dno to fit with Sigmoids (hist_to_prediction).
    df_pos_vul_sno.index.names = ['pos', 'vul', 'dno']

    # Here we must re-index as some of the suits may be missing.
    df_sno = df_melted.groupby('sno').agg({'pass': 'sum'}).reindex( \
      np.arange(NUM_SUITS), fill_value = 0)

    # Count the number of chances to pass by (pos, vul, sno).
    hist_pos_vul_sno = df_melted.groupby(['pos', 'vul', 'sno']).size()

    # Call it dno as Sigmoids expects this column name in both cases.
    hist_pos_vul_sno.index.rename(names = {'sno': 'dno'}, inplace = True)

    # The passes as numpy
    passes_pos_vul_sno = df_pos_vul_sno.unstack(fill_value = 0).values
    passes_sno = df_sno['pass'].values


    # Count the actual passes by (pos, vul, dno) and only by dno.
    # We start from df, not from df_melted, as df_melted has the same dno
    # appearing four times (once for sno1..sno4).
    df_pos_vul_dno = df.groupby( \
      ['pos', 'vul', 'dno']).agg({'pass' : 'sum'})

    # Here we must re-index as some of the distributions may be missing.
    df_dno = df.groupby('dno').agg({'pass': 'sum'}).reindex( \
      np.arange(NUM_DIST), fill_value = 0)

    # Count the number of chances to pass by (pos, vul, dno).
    hist_pos_vul_dno = df.groupby(['pos', 'vul', 'dno']).size()

    # The passes as numpy
    passes_pos_vul_dno = df_pos_vul_dno.unstack(fill_value = 0).values
    passes_dno = df_dno['pass'].values


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


    # Predict the absolute number of passes for each variable number.
    # The results are numpy 1D arrays.  Also calculate the gradients.
    results_dno, gradient_dno = \
      sigmoids.hist_to_prediction(hist_dno, df_pos_vul_dno, NUM_DIST)
    results_sno, gradient_sno = \
      sigmoids.hist_to_prediction(hist_sno, df_pos_vul_sno, NUM_SUITS)

    return gradient_sno, gradient_dno


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
    

  def run_until_interior(self, df, sigmoids, bins, solution):
    '''Set up and re-run LP until the box bounds are not right.'''

    # Add sum and bin columns to df based on dno, sno1 .. sno4.
    # These depend on the current solution, so they must be
    # recalculated.

    iter = 0
    solution0 = solution
    new_solution = Variables()

    while True:

      self.set_box_constraints(solution, 0.01)

      start_time = time.time()
      solution.add_strengths(bins, df)
      end_time = time.time()
      # print("add_strengths time", "{:.4f}".format(end_time - start_time))

      start_time = time.time()
      gradient_sno, gradient_dno = self.calc_gradients( \
        df, sigmoids, bins, solution)
      end_time = time.time()
      # print("calc_gradients time", "{:.4f}".format(end_time - start_time))

      self.set_objective(gradient_sno, gradient_dno)

      start_time = time.time()
      new_solution.data = self.run_once()
      end_time = time.time()
      # print("one LP iter time", "{:.4f}".format(end_time - start_time))


      iter += 1
      print("LP iteration", "{:12d}".format(iter))

      num_changes, changes_var, change_obj, num_interior = \
        self.calc_change(solution, new_solution)

      print("num_changes ", "{:12d}".format(num_changes))
      print("changes_var ", "{:12.4f}".format(changes_var))
      print("change_obj  ", "{:12.4f}".format(change_obj))
      print("num_interior", "{:12d}".format(num_interior), "\n")

      solution.data = new_solution.data

      if num_interior == NUM_VAR:
        break

      if iter == 10:
        break

    num_changes, changes_var, change_obj, num_interior = \
      self.calc_change(solution0, new_solution)

    return change_obj


