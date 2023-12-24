import pandas as pd
import numpy as np
import time

from fit.FitArgs import FitArgs
from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables
from fit.Sigmoids import Sigmoids
from fit.Weaks import Weaks
from fit.LPsolver import LPsolver


fit_args = FitArgs()
pos_list, vul_list = fit_args.parse()

# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Read in suit defaults (different from HCP count).
suit_info.read_values(SUIT_VALUE_FILE)

# Set the distribution values to zero to isolate the strength aspect.
dist_info.set_to_zero()

# Read in the opening categories of hands.
df = pd.read_csv(OPENING_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'open', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])

# Limit df to the positions and vulnerabilities from the command line.
# sigmoids.init(len(pos_list), len(vul_list))

weaks = Weaks()
weaks.init(len(pos_list), len(vul_list))
df = df[df['pos'].isin(pos_list)]
df = df[df['vul'].isin(vul_list)]

# Only keep rows with the corresponding pos and vul values.
map_pos = {old: new for new, old in enumerate(pos_list)}
map_vul = {old: new for new, old in enumerate(vul_list)}
df['pos'] = df['pos'].replace(map_pos)
df['vul'] = df['vul'].replace(map_vul)

# Filter out some distributions that are likely to be weak two openings
# in spades.
# 6=1=3=3, 6=3=1=3, 6=3=3=1, 6=2=2=3, 6=2=3=2, 6=3=2=2.
weak_two_spades = [451, 462, 464, 457, 458, 463]
weak_two_hearts = [171, 326, 328, 255, 256, 327]
weak_two_diamonds = [147, 291, 310, 225, 235, 301]
weak_two_major = [451, 462, 464, 457, 458, 463, \
  171, 326, 328, 255, 256, 327]
weak_two_shc = [451, 462, 464, 457, 458, 463, \
  171, 326, 328, 255, 256, 327, \
  147, 291, 310, 225, 235, 301]

filtered_df = df[df['dno'].isin(weak_two_shc)].copy()

# Set the weak openings as 1, the others as 0.
# These include heart weak twos, but we have filtered out the distributions.
# We include weak-three openings as well -- the important thing is that
# these distributions are preempted, not how they are preempted.
weak_major_open = [601, 702, 800, 802, 900, 906, \
  1105, 1201, 1300, 1301, 1400]
weak_minor_open = [600, 606, 700, 701, \
  807, 905, 1001, 1100, 1101, 1200]
weak_23_open = [601, 702, 800, 802, 900, 906, \
  1105, 1201, 1300, 1301, 1400, \
  600, 606, 700, 701, \
  807, 905, 1001, 1100, 1101, 1200]

filtered_df['w2sp'] = \
  np.where(filtered_df['open'].isin(weak_23_open), 1, 0)

# filtered_rows = filtered_df[filtered_df['w2sp'] == 1]
# for index, row in filtered_rows.iterrows():
  # print( \
    # suit_info.get(row['sno1'])['text'], \
    # suit_info.get(row['sno2'])['text'], \
    # suit_info.get(row['sno3'])['text'], \
    # suit_info.get(row['sno4'])['text'])
  

dist_info.read(pos_list)

solution = Variables()

# Set up the constraints of the linearized LP problem.
# Also set a feasible starting point for the LP problem.
lp_solver = LPsolver()
lp_solver.resize_eq(suit_info, dist_info)
lp_solver.set_constraints(suit_info, dist_info, solution, 0.01)

# Read in the data of hands.
# df = pd.read_csv(SUITDATA_FILE, header = None, \
  # names = ['tag', 'pos', 'vul', 'open', 'dno', \
  # 'sno1', 'sno2', 'sno3', 'sno4'])

# Strength is 0..100 in 0.01 steps.
bins = np.arange(0, MAX_STRENGTH, STRENGTH_STEP)
bin_midpoints = (bins[:-1] + bins[1:]) / 2

# sigmoids = Sigmoids()

# The sigmoid and other fits needs this.
solution.add_strengths(bins, filtered_df)

weaks.calc(bin_midpoints)

weaks.fit_data(filtered_df)

print(weaks.str(pos_list, vul_list))
exit()


iter_no = 0

while True: # Sigmoid fit followed by linearized LP
  print("Starting overall iteration", iter_no)
  print("----------------------------\n")

  # Fit the sigmoids.
  sigmoids.fit_data(df)
  print(sigmoids.str(pos_list, vul_list))

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
    step_size = 0.0102
    num_iters = 100

  change = lp_solver.run_until_interior(df, \
    sigmoids, bins, step_size, 100, solution, suit_info, dist_info)

  iter_no += 1

  print(solution.str_simple(suit_info, dist_info))

  # TODO More like a condition on change.
  if iter_no == 7:
    break
