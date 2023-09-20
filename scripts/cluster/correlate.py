import pandas as pd
import numpy as np
import itertools
from itertools import chain

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.Sigmoids import Sigmoids
from passes.Sigmoid import Sigmoid


def set_dist_data(dist_info):
  dno = 0
  hcp = [3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

  for spades in range(BRIDGE_TRICKS + 1):
    for hearts in range(BRIDGE_TRICKS + 1 - spades):
      for diamonds in range(BRIDGE_TRICKS + 1 - spades - hearts):
        clubs = BRIDGE_TRICKS - spades - hearts - diamonds

        dist_info[dno]['text'] = str(spades) + "=" + \
          str(hearts) + "=" + str(diamonds) + "=" + str(clubs)

        dist_info[dno]['hcp'] = hcp[spades] + hcp[hearts] + \
          hcp[diamonds] + hcp[clubs]

        dno += 1


def set_lp_constraints_upper(dominances, A_ub, b_ub):
  for index, dom in enumerate(dominances):
    A_ub[index][dom['dominant']] = 1
    A_ub[index][dom['dominated']] = -1
    b_ub[index] = 0


def set_lp_constraints_equal(suit_info, A_eq, b_eq):
  for sno, si in enumerate(suit_info):
    A_eq[0][sno] = si['count']
  
  b_eq[0] = (2 << BRIDGE_TRICKS) * 10 / 2 # Average of 5 HCP


def set_lp_constraints_box(estimate, step_size, bounds):
  assert estimate.shape == bounds.shape
  lower = np.maximum(estimate - step_size, 0)
  upper = estimate + step_size
  bounds = list(zip(lower, upper))


def set_lp_constraints(suit_info, dominances, estimate, step_size, \
  A_ub, b_ub, A_eq, b_eq, bounds):

  set_lp_constraints_upper(dominances, A_ub, b_ub)
  set_lp_constraints_equal(suit_info, A_eq, b_eq)
  set_lp_constraints_box(estimate, step_size, bounds)


def init_solution(suit_info, dist_info, solution):
  '''Initialize with standard HCP and distribution points.'''
  for sno in range(NUM_SUITS):
    solution[sno] = suit_info.get(sno)['hcp']
  for dno, di in enumerate(dist_info):
    solution[NUM_SUITS + dno] = di['hcp']


def add_strengths(solution, bins, df):
  '''Use solution and bins to add exact and binned strength to df.'''
  suit_indices = np.arange(0, NUM_SUITS)
  dist_indices = np.arange(0, NUM_DIST)

  # Based on the current "solution", set up some lookup tables in order
  # to be able to make a sum column.
  lookup_suit = [solution[index] for index in suit_indices]
  lookup_dist = [solution[NUM_SUITS + index] for index in dist_indices]

  lookup = {
    'dno': pd.Series(lookup_dist, index = dist_indices),
    'sno1': pd.Series(lookup_suit, index = suit_indices),
    'sno2': pd.Series(lookup_suit, index = suit_indices),
    'sno3': pd.Series(lookup_suit, index = suit_indices),
    'sno4': pd.Series(lookup_suit, index = suit_indices)
  }

  df['sum'] = 0
  for field in ['dno', 'sno1', 'sno2', 'sno3', 'sno4']:
    df['sum'] += df[field].map(lookup[field])

  # Discretize the sum column
  df['bin'] = pd.cut(df['sum'], bins = bins, include_lowest = True, \
    right = False, labels = False)



# Set up some data-independent tables.

dist_info = [{} for _ in range(NUM_DIST)]
set_dist_data(dist_info)

suit_info = SuitInfo()


# Initialize the solution with standard HCP and distribution points.
solution = np.zeros(NUM_VAR)
init_solution(suit_info, dist_info, solution)

# Set up the matrix of the linearized LP problem.
'''
c = np.zeros(NUM_VAR)
A_ub = np.zeros((NUM_DOMINANCES, NUM_VAR))
b_ub = np.zeros(NUM_DOMINANCES)
A_eq = np.zeros((1, NUM_VAR))
b_eq = np.zeros(1)
bounds = np.zeros(NUM_VAR)
step_size = 0.01

# TODO Get dominances from SuitInfo somehow.
set_lp_constraints(suit_info, dominances, solution, step_size, \
  A_ub, b_ub, A_eq, b_eq, bounds)
'''

# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])

# Strength is 0..100 in 0.01 steps.
bins = np.arange(0, MAX_STRENGTH, STRENGTH_STEP)

# Add sum and bin columns based on dno, sno1 .. sno4.
add_strengths(solution, bins, df)


# print(df)

# Sum up the passes.
grouped_df_dno = df.groupby(['pos', 'vul', 'dno']).agg({'pass': 'sum'}).unstack(fill_value=0)
pass_matrix_dist = grouped_df_dno.values

# Sum over pos and vul, mostly for statistics.
full_dno_index = pd.Index(range(NUM_DIST))
df_without_dno = grouped_df_dno.groupby(level=['pos', 'vul']).sum()
pass_marginal_series = df_without_dno.sum(axis=0)

# Simplify the index to only contain 'dno' values
pass_marginal_dno_series = pass_marginal_series.droplevel(0)

# Reindexing to get the desired numpy array
pass_marginal_dist = \
  pass_marginal_dno_series.reindex(full_dno_index, fill_value=0).values


sno_melted = df.melt(id_vars=['pos', 'vul', 'pass', 'bin'], value_vars=['sno1', 'sno2', 'sno3', 'sno4'])
grouped_df_sno = sno_melted.groupby(['pos', 'vul', 'value']).agg({'pass':'sum'}).unstack(fill_value=0)
pass_matrix_suit = grouped_df_sno.values

# Again sum over pos and vul, mostly for statistics.
full_sno_index = pd.Index(range(NUM_SUITS))
df_without_sno = grouped_df_sno.groupby(level=['pos', 'vul']).sum()
pass_marginal_sno_series = df_without_sno.sum(axis=0)
pass_marginal_sno_series = pass_marginal_sno_series.droplevel(0)
pass_marginal_suit = \
  pass_marginal_sno_series.reindex(full_sno_index, fill_value=0).values


# Make a histogram of binned strength for each (pos, vul, value).
# hist_dno = df.groupby(['pos', 'vul', 'dno', 'bin']).size().unstack(fill_value=0)
hist_dno = df.pivot_table(index=['pos', 'vul', 'dno'], 
                          columns='bin', 
                          aggfunc='size', 
                          fill_value=0).reset_index()

hist_sno = sno_melted.groupby(['pos', 'vul', 'value', 'bin']).size().unstack(fill_value=0).groupby(level=[0, 1, 2]).sum()
hist_sno_reset = hist_sno.reset_index()
# Easier to call it dno
hist_sno_reset = hist_sno_reset.rename(columns={'value': 'dno'})


# Calculate all sigmoid values that occur in binned histograms.
sigmoids = Sigmoids()

bin_midpoints = (bins[:-1] + bins[1:]) / 2
sigmoids.calc(bin_midpoints)

# This is how to fit and print sigmoids.
# sigmoids.fit_data(df)
# print(sigmoids.str())
# quit()

# Predict the absolute number of passes for each variable number.
# The results are numpy 1D arrays.
results_dno = sigmoids.hist_to_prediction(hist_dno, NUM_DIST)
results_sno = sigmoids.hist_to_prediction(hist_sno_reset, NUM_SUITS)



print("Distribution pass predictions\n")
for dno in range(NUM_DIST):
  if results_dno[dno] == 0 and pass_marginal_dist[dno] == 0: continue
  print("{:4d}".format(dno), \
    "{:10s}".format(dist_info[dno]['text']), \
    "{:10.4f}".format(results_dno[dno]), \
    "{:6d}".format(pass_marginal_dist[dno]))
print("")

print("Suit pass predictions\n")
for sno in range(NUM_SUITS):
  if results_sno[sno] == 0 and pass_marginal_suit[sno] == 0: continue
  print("{:4d}".format(sno), \
    "{:16s}".format(suit_info.get(sno)['text']), \
    "{:16.4f}".format(results_sno[sno]), \
    "{:6d}".format(pass_marginal_suit[sno]))
print("")

# print(final_results_dno)
# print(final_results_sno)


# So it seems we can calculate the number of passes from sigmoids.
# We need the sign vector.  And then we need to calculate the gradients
# by histograms similar to above.  This then gives us the c vector
# for the LP problem.
# Split out into some files and functions.
# Then set up to run
# In the case of box constraints, no lower limit of 0 on the
# values? Keep moving the boxes, recalculating the gradients, until
# the solution is interiot with respect to the box constraints.
# Then make the numpy arrays for adjusting the sigmoid parameters.
