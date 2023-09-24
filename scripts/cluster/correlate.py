import pandas as pd
import numpy as np
import time

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables
from fit.Sigmoids import Sigmoids
from fit.LPsolver import LPsolver


# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Initialize the solution with standard HCP and distribution points.
solution = Variables()
solution.init_by_hcp(suit_info, dist_info)

# Set up the constraints of the linearized LP problem.
lp_solver = LPsolver()
lp_solver.resize_eq(suit_info.num_equivalences(), \
  dist_info.num_equivalences())
lp_solver.set_constraints(suit_info, dist_info, solution, 0.01)

# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])

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
  sigmoids.fit_data(df)
  print(sigmoids.str())

  # Recalculate all sigmoid values that occur in binned histograms,
  # as the sigmoid parameters have changed.
  sigmoids.calc(bin_midpoints)

  # Run a linearized LP.
  # Could probably do the first LP iteration as:
  # 30 * 0.10
  # 10 * 0.05
  # 15 * 0.025
  # 20 * 0.01

  if (iter_no == 0):
    step_size = 0.05
    num_iters = 100
  else:
    step_size = 0.01
    num_iters = 100

  change = lp_solver.run_until_interior(df, \
    sigmoids, bins, step_size, 100, solution, suit_info, dist_info)

  iter_no += 1

  print(solution.str_simple(suit_info, dist_info))

  # TODO More like a condition on change.
  if iter_no == 200:
    break
