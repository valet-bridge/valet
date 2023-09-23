import pandas as pd
import numpy as np
import time

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables
from fit.Sigmoids import Sigmoids
from fit.LPsolver import LPsolver


def calc_actual_passes(df):
  '''The actual passes are constant across the optimizations.'''

  df_melted = df.melt(\
    id_vars = ['pos', 'vul', 'pass', 'dno'], \
    value_vars = ['sno1', 'sno2', 'sno3', 'sno4'], \
    value_name = 'sno')

  # Count the actual passes by (pos, vul, sno) and only by sno.
  df_pos_vul_sno = df_melted.groupby( \
    ['pos', 'vul', 'sno']).agg({'pass' : 'sum'})

  # Rename from sno to dno to fit with Sigmoids (hist_to_prediction).
  df_pos_vul_sno.index.names = ['pos', 'vul', 'dno']

  # Count the actual passes by (pos, vul, dno) and only by dno.
  # We start from df, not from df_melted, as df_melted has the same dno
  # appearing four times (once for sno1..sno4).
  df_pos_vul_dno = df.groupby( \
    ['pos', 'vul', 'dno']).agg({'pass' : 'sum'})

  return df_pos_vul_sno, df_pos_vul_dno


# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Initialize the solution with standard HCP and distribution points.
solution = Variables()
solution.init_by_hcp(suit_info, dist_info)

# Set up the constraints of the linearized LP problem.
lp_solver = LPsolver()
lp_solver.set_constraints(suit_info, dist_info, solution, 0.01)

# Read in the data of hands.
start_time = time.time()
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])
end_time = time.time()
# print("CSV read time", "{:.4f}".format(end_time - start_time))

df_pos_vul_sno, df_pos_vul_dno = calc_actual_passes(df)

# Strength is 0..100 in 0.01 steps.
bins = np.arange(0, MAX_STRENGTH, STRENGTH_STEP)
bin_midpoints = (bins[:-1] + bins[1:]) / 2

# The sigmoid fits needs this.
solution.add_strengths(bins, df)

sigmoids = Sigmoids()
iter_no = 0

while True: # Sigmoid fit followed by linearized LP
  print("Starting overall iteration", iter_no)
  print("----------------------------\n")

  # Fit the sigmoids.
  start_time = time.time()
  sigmoids.fit_data(df)
  end_time = time.time()
  # print(" Sigmoid fit time", "{:.4f}".format(end_time - start_time))
  print(sigmoids.str())

  # Recalculate all sigmoid values that occur in binned histograms,
  # as the sigmoid parameters have changed.
  sigmoids.calc(bin_midpoints)

  # Run a linearized LP.
  change = lp_solver.run_until_interior(df, df_pos_vul_sno, df_pos_vul_dno,
    sigmoids, bins, solution)

  iter_no += 1

  print(solution.str_simple(suit_info, dist_info))

  # TODO More like a condition on change.
  if iter_no == 200:
    break

# TODO
# Could introduce some manual equalities based on observation.
# Write a file format, e.g. JT9, JTx, Jxx
