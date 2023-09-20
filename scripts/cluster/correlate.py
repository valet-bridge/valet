import pandas as pd
import numpy as np

from passes.Sigmoid import Sigmoid

# SUITDATA_FILE = "suitdata100.csv"
SUITDATA_FILE = "suitdata.csv"
BRIDGE_TRICKS = 13
NUM_DIST = 560
NUM_SUITS = 512
NUM_VAR = NUM_DIST + NUM_SUITS
NUM_TOPS = 6
NUM_DOMINANCES = 864
NUM_POS = 4
NUM_VUL = 4


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


def count_ones(n):
  count = 0
  while n:
      n &= n - 1
      count += 1
  return count


def hcp(tops):
  points = 0
  if (tops & 0x20):
    points += 4
  if (tops & 0x10):
    points += 3
  if (tops & 0x08):
    points += 2
  if (tops & 0x04):
    points += 1
  return points


def suit_text(length, tops):
  text = ""
  top_count = 0
  if (tops & 0x20):
    text += 'A';
    top_count += 1
  if (tops & 0x10):
    text += 'K';
    top_count += 1
  if (tops & 0x08):
    text += 'Q';
    top_count += 1
  if (tops & 0x04):
    text += 'J';
    top_count += 1
  if (tops & 0x02):
    text += 'T';
    top_count += 1
  if (tops & 0x01):
    text += '9';
    top_count += 1

  text += 'x' * (length - top_count)
  return text


def set_suit_list(suit_list):
  reduced_suit_number = 0
  for holding in range(1 << BRIDGE_TRICKS):
    length = count_ones(holding)
    tops = holding >> 7

    if 'count' not in suit_list[length][tops]:
      suit_list[length][tops]['sno'] = reduced_suit_number
      suit_list[length][tops]['count'] = 1
      reduced_suit_number += 1
    else:
      suit_list[length][tops]['count'] += 1


def set_suit_info(suit_list, suit_info):
  for length, row in enumerate(suit_list):
    for tops, cell in enumerate(row):
      if 'sno' not in cell: continue

      suit_info[cell['sno']] = {}
      entry_ref = suit_info[cell['sno']]

      entry_ref = suit_info[cell['sno']]
      entry_ref['length'] = length
      entry_ref['tops'] = tops
      entry_ref['count'] = cell['count']
      entry_ref['hcp'] = hcp(tops)
      entry_ref['text'] = suit_text(length, tops)


def set_suit_dominances(suit_list, dominances):
  for length, row in enumerate(suit_list):
    for tops, cell in enumerate(row):
      if 'sno' not in cell: continue

      bits = [0] * NUM_TOPS
      for bit in range(NUM_TOPS):
        bits[bit] = tops & (1 << bit)

      for bit in range(1, NUM_TOPS):
        if (bits[bit] and not bits[bit-1]):
          new_tops = tops
          new_tops ^= 1 << bit
          new_tops |= 1 << (bit-1)

          dominances.append({'dominant': suit_list[length][tops]['sno'], \
            'dominated': suit_list[length][new_tops]['sno']})
      
      # It is possible to turn a nine into an x when there is an x free.
      if (bits[0] and count_ones(tops) > length + BRIDGE_TRICKS - NUM_TOPS):
        new_tops = tops
        new_tops ^= 1;
        dominances.append({'dominant': suit_list[length][tops]['sno'], \
          'dominated': suit_list[length][new_tops]['sno']})


def set_suit_data(suit_info, dominances):
  # Tricks 0..13, 6-cards tops.
  suit_list = [[{} for _ in range(64)] for _ in range(14)]

  set_suit_list(suit_list)
  set_suit_info(suit_list, suit_info)
  set_suit_dominances(suit_list, dominances)


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


def apply_sigmoid(hist, sigmoids, bin_midpoints, extended_midpoints):
  # This function computes the sum of the bin count times the sigmoid 
  # function for each bin.  It expects the histogram to be indexed by 
  # (pos, vul, field_value, bin), where bin represents the discretized 
  # 'sum' value.
    
  # Compute the sigmoid function for the midpoint of each bin
  results = []
  for (pos, vul), group in hist.groupby(level=[0, 1]):
    sigmoid_result = sigmoids[pos][vul](extended_midpoints)
    result = (group.values * sigmoid_result).sum(axis=1)
    results.append(pd.Series(result, index=group.index.droplevel([0, 1])))
    
  # Concatenate the results and return
  return pd.concat(results)


# Set up some data-independent tables.

dist_info = [{} for _ in range(NUM_DIST)]
set_dist_data(dist_info)

suit_info = [{} for _ in range(NUM_SUITS)]

# There are 864 dominances.
dominances = []

set_suit_data(suit_info, dominances)


# Set up a vector that will become the solution.
solution = np.zeros(NUM_VAR)
for sno, si in enumerate(suit_info):
  solution[sno] = si['hcp']
for dno, di in enumerate(dist_info):
  solution[NUM_SUITS + dno] = di['hcp']

# Set up the matrix of the linearized LP problem.
'''
c = np.zeros(NUM_VAR)
A_ub = np.zeros((NUM_DOMINANCES, NUM_VAR))
b_ub = np.zeros(NUM_DOMINANCES)
A_eq = np.zeros((1, NUM_VAR))
b_eq = np.zeros(1)
bounds = np.zeros(NUM_VAR)
step_size = 0.01

set_lp_constraints(suit_info, dominances, solution, step_size, \
  A_ub, b_ub, A_eq, b_eq, bounds)
'''

# Set up the sigmoids.
sigmoids = [[Sigmoid() for _ in range(NUM_VUL)] for _ in range(NUM_POS)]


# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])


# Based on the current "solution", set up some lookup tables in order
# to be able to make a sum column.

suit_indices = np.arange(0, NUM_SUITS)
dist_indices = np.arange(0, NUM_DIST)

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
sum_fields = ['dno', 'sno1', 'sno2', 'sno3', 'sno4']
for field in sum_fields:
  df['sum'] += df[field].map(lookup[field])


# Discretize the sum column

# Strength is 0..100 in 0.01 steps.
bins = np.arange(0, 100, 0.01)
bin_midpoints = (bins[:-1] + bins[1:]) / 2

df['bin'] = pd.cut(df['sum'], bins=bins, include_lowest=True, \
  right=False, labels=False)

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

# Apply Sigmoid to histograms
sigmoids = [[Sigmoid() for _ in range(NUM_VUL)] for _ in range(NUM_POS)]

sigmoid_values = [[[sig.calc_sigmoid_parallel(b) for b in bin_midpoints] for sig in pos_sigmoids] for pos_sigmoids in sigmoids]

sigmoid_df = pd.DataFrame({
    'pos': \
      [p for p in range(NUM_POS) for _ in range(NUM_VUL * len(bin_midpoints))],
    'vul': \
      [v for _ in range(NUM_POS) for v in range(NUM_VUL) \
        for _ in range(len(bin_midpoints))],
    'bin': list(range(len(bin_midpoints))) * (NUM_POS * NUM_VUL),

    'sigmoid': [value for sublist1 in sigmoid_values \
      for sublist2 in sublist1 for value in sublist2]
})

def apply_sigmoid_to_histogram(hist_df, sigmoid_series):
  # Merging to align the indices
  melted_hist_df = hist_df.melt(id_vars=['pos', 'vul', 'dno'], value_name='hist_value', var_name='bin')

  merged_df = melted_hist_df.merge(
      sigmoid_series,
      on=['pos', 'vul', 'bin'], 
      how='left'
  )

  # Multiply 'hist_value' by 'sigmoid' to get the result for each row
  merged_df['result'] = merged_df['hist_value'] * merged_df['sigmoid']
    
  return merged_df.groupby(['pos', 'vul', 'dno']).agg({'result': 'sum'})


results_dno_df = apply_sigmoid_to_histogram(hist_dno, sigmoid_df)
results_sno_df = apply_sigmoid_to_histogram(hist_sno_reset, sigmoid_df)

sum_dno = results_dno_df.groupby('dno')['result'].sum()
results_dno = sum_dno.reindex(range(NUM_DIST), fill_value = 0).values

sum_sno = results_sno_df.groupby('dno')['result'].sum()
results_sno = sum_sno.reindex(range(NUM_SUITS), fill_value = 0).values

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
    "{:16s}".format(suit_info[sno]['text']), \
    "{:16.4f}".format(results_sno[sno]), \
    "{:6d}".format(pass_marginal_suit[sno]))
print("")

# print(final_results_dno)
# print(final_results_sno)


