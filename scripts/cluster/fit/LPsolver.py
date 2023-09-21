import pandas as pd
import numpy as np

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
    self.A_eq = np.zeros((1, NUM_VAR))
    self.b_eq = np.zeros(1)
    self.bounds = np.zeros(NUM_VAR)

  
  def set_box_constraints(self, estimate, step_size):
    estimate.set_box_constraints(step_size, self.bounds)


  def set_constraints(self, suit_info, estimate, step_size):
    # Dominances
    suit_info.set_lp_upper_constraints(self.A_ub, self.b_ub)

    # Weighted average of 5 points per suit.
    suit_info.set_lp_equal_constraints(self.A_eq, self.b_eq)

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
    

  def run_until_interior(self, df, sigmoids, bins, solution):
    '''Set up and re-run LP until the box bounds are not right.'''

    # Add sum and bin columns to df based on dno, sno1 .. sno4.
    # These depend on the current solution, so they must be
    # recalculated.

    iter = 0

    while True:

      self.set_box_constraints(solution, 0.01)

      solution.add_strengths(bins, df)

      gradient_sno, gradient_dno = self.calc_gradients( \
        df, sigmoids, bins, solution)

      self.set_objective(gradient_sno, gradient_dno)

      new_solution = self.run()

      iter += 1
      print("LP iteration", iter, "complete")

      change = self.calc_change(solution, new_solution)

      if self.is_interior(new_solution):
        break


    return change


