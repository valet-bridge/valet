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


# Set up some data-independent tables.

dist_info = [{} for _ in range(NUM_DIST)]
set_dist_data(dist_info)

suit_info = [{} for _ in range(NUM_SUITS)]

# There are 864 dominances.
dominances = []

set_suit_data(suit_info, dominances)


# Set up the matrix of the linearized LP problem.
c = np.zeros(NUM_VAR)
A_ub = np.zeros((NUM_DOMINANCES, NUM_VAR))
b_ub = np.zeros(NUM_DOMINANCES)
A_eq = np.zeros((1, NUM_VAR))
b_eq = np.zeros(1)
bounds = np.zeros(NUM_VAR)
step_size = 0.01

solution = np.zeros(NUM_VAR)
for sno, si in enumerate(suit_info):
  solution[sno] = si['hcp']
for dno, di in enumerate(dist_info):
  solution[NUM_SUITS + dno] = di['hcp']

set_lp_constraints(suit_info, dominances, solution, step_size, \
  A_ub, b_ub, A_eq, b_eq, bounds)


# Set up the sigmoids.
sigmoids = [[Sigmoid() for _ in range(NUM_VUL)] for _ in range(NUM_POS)]


# Read in the data of hands.

df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])

# count_matrix[pos][vul] is the number of hands that occur
# in the data for that (pos, vul) combination.

count_matrix = df.groupby(['pos', 'vul']).size().unstack(fill_value = 0)

# pass_matrix[pos][vul] is the number of passed hands for
# that (pos, vul) combination.

pass_matrix = \
  df.groupby(['pos', 'vul'])['pass'].sum().unstack(fill_value = 0)

# histograms['dno'] and ['sno'] is the number of times that the
# distribution number resp. suit number occurs for that
# (pos, vul) combination.

histograms = {}
for field in ['dno', 'sno1', 'sno2', 'sno3', 'sno4']:
  if field == 'dno':
    sfield = 'dno'
  else:
    sfield = 'sno'
  histograms[sfield] = \
    df.groupby(['pos', 'vul', field]).size().unstack(fill_value = 0)

# print("count_matrix")
# print(count_matrix)

# print("pass_matrix")
# print(pass_matrix)

# for field, histogram in histograms.items():
  # print(f"\nHistogram for {field}:")
  # print(histogram)

# Based on the current "solution", set up some lookup tables in order
# to make a histogram of strengths of the hands in the data.

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

# histograms['sum'] is the strength histogram.

histograms['sum'] = \
  df.groupby(['pos', 'vul', 'sum']).size().unstack(fill_value = 0)

print(histograms['sum'])
