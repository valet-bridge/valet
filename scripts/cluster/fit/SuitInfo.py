import os
import csv
import numpy as np

from fit.fitconst import *

class SuitInfo:
  '''Information about each of 512 possible suit holdings.'''

  def __init__(self):
    # Tricks 0..13, 6-card tops.
    self.suit_list = [[{} for _ in range(1 << NUM_TOPS)] \
      for _ in range(BRIDGE_TRICKS + 1)]

    self.suit_info = [{} for _ in range(NUM_SUITS)]

    # For the current parameters there are 864 dominances.
    self.dominances = []
    self.num_dominances = 0

    # Print order.
    self.order = np.zeros(NUM_SUITS, dtype = int)

    # Look up "KQx" into the corresponding suit number.
    self.suit_lookup = {}

    # Equivalences among suit variables can be read in.
    self.equivalences = []

    self.num_skips = 0
    self.num_complete_len_skips = 0
    self.active_by_len = [0 for _ in range(BRIDGE_TRICKS + 1)]

    self.set()


  @staticmethod
  def count_ones(n):
    count = 0
    while n:
        n &= n - 1
        count += 1
    return count


  @staticmethod
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


  @staticmethod
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
    if text == "":
      text = "void"
    return text


  def set_suit_list(self):
    reduced_suit_number = 0
    for holding in range(1 << BRIDGE_TRICKS):
      length = self.count_ones(holding)
      tops = holding >> 7

      if 'count' not in self.suit_list[length][tops]:
        self.suit_list[length][tops]['sno'] = reduced_suit_number
        self.suit_list[length][tops]['count'] = 1
        self.active_by_len[length] += 1
        reduced_suit_number += 1
      else:
        self.suit_list[length][tops]['count'] += 1


  def set_suit_info(self):
    for length, row in enumerate(self.suit_list):
      for tops, cell in enumerate(row):
        if 'sno' not in cell: continue

        sno = cell['sno']
        self.suit_info[sno] = {}
        entry_ref = self.suit_info[sno]

        entry_ref = self. suit_info[sno]
        entry_ref['length'] = length
        entry_ref['tops'] = tops
        entry_ref['count'] = cell['count']
        entry_ref['hcp'] = self.hcp(tops)
        entry_ref['text'] = self.suit_text(length, tops)
        entry_ref['skip'] = False

        self.suit_lookup[entry_ref['text']] = sno

    order_no = 0
    for length in range(BRIDGE_TRICKS+1):
      for tops in range(1 << NUM_TOPS):
        if 'sno' not in self.suit_list[length][tops]: continue
        self.order[order_no] = self.suit_list[length][tops]['sno']
        order_no += 1


  def read_skips(self):
    '''Read suit variables that are too thin to estimate.'''
    if not os.path.exists(SUIT_SKIP_FILE):
      return
    if not os.path.isfile(SUIT_SKIP_FILE):
      return

    with open(SUIT_SKIP_FILE, 'r') as csvfile:
      reader = csv.reader(csvfile, delimiter = ' ', skipinitialspace = True)
      for row in reader:
        assert len(row) == 3
        (sno, text, val) = (int(row[0]), row[1], float(row[2]))

        assert sno >= 0 and sno < len(self.suit_info)
        entry_ref = self.suit_info[sno]

        assert entry_ref['text'] == text
        entry_ref['skip'] = True
        entry_ref['hcp'] = val
        self.active_by_len[entry_ref['length']] -= 1
        self.num_skips += 1

      # Count how many lengths are skipped completely.
      for length in range(BRIDGE_TRICKS + 1):
        assert self.active_by_len[length] >= 0
        if self.active_by_len[length] == 0:
         self.num_complete_len_skips += 1


  def dominance_is_skipped(self, sno0, sno1):
    num_skips = 0
    if self.suit_info[sno0]['skip']:
      num_skips += 1
    if self.suit_info[sno1]['skip']:
      num_skips += 1
      
    if num_skips == 0:
      return False
    elif num_skips == 2:
      return True
    else:
      print("Dominance has mixed skips and non-skips:", sno0, sno1)
      quit()

    return False


  def set_suit_dominances(self):
    for length, row in enumerate(self.suit_list):
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

            sno0 = self.suit_list[length][tops]['sno']
            sno1 = self.suit_list[length][new_tops]['sno']
            if self.dominance_is_skipped(sno0, sno1):
              continue

            self.dominances.append({'dominant': sno0, 'dominated': sno1})
            self.num_dominances += 1
      
        # It is possible to turn a nine into an x when there is an x free.
        if (bits[0] and self.count_ones(tops) > \
            length + NUM_TOPS - BRIDGE_TRICKS):
          new_tops = tops
          new_tops ^= 1;

          sno0 = self.suit_list[length][tops]['sno']
          sno1 = self.suit_list[length][new_tops]['sno']
          if self.dominance_is_skipped(sno0, sno1):
            continue

          self.dominances.append({'dominant': sno0, 'dominated': sno1})
          self.num_dominances += 1


  def equiv_is_skipped(self, row):
    num_skips = 0
    for elem in row:
      if elem not in self.suit_lookup:
        print(elem, "not a known suit")
        quit()

      sno = self.suit_lookup[elem]
      if self.suit_info[sno]['skip']:
        num_skips += 1
      
    if num_skips == 0:
      return False
    elif num_skips == len(row):
      return True
    else:
      print(row, "has mixed skips and non-skips")
      quit()

    return False


  def read_equivalences(self):
    if not os.path.exists(SUIT_EQUIV_FILE):
      return
    if not os.path.isfile(SUIT_EQUIV_FILE):
      return

    with open(SUIT_EQUIV_FILE, 'r') as csvfile:
      reader = csv.reader(csvfile, skipinitialspace = True)
      for row in reader:
        elem0 = row[0]
        if elem0 not in self.suit_lookup:
          print(elem0, "not a known suit")
          quit()

        if self.equiv_is_skipped(row):
          continue

        # The LP solver is a bit finicky about starting from
        # a feasible solution.  If we require two variables to
        # equal that aren't, such as T9x and JTx (just an example)
        # then the starting point won't be feasible.  So first we
        # figure out the weighted HCP for the row.

        sno0 = self.suit_lookup[elem0]
        count0 = self.suit_info[sno0]['count']
        hcp_sum = self.suit_info[sno0]['hcp'] * count0
        count_sum = count0

        for i in range(1, len(row)):
          elem1 = row[i]
          if elem1 not in self.suit_lookup:
            print(elem1, "not a known suit")
            quit
          sno1 = self.suit_lookup[elem1]
          count1 = self.suit_info[sno1]['count']
          hcp_sum += self.suit_info[sno1]['hcp'] * count1
          count_sum += count1

        hcp_average = hcp_sum / count_sum

        # Then we reset each of the equivalences to that same average.
        self.suit_info[sno0]['hcp'] = hcp_average

        for i in range(1, len(row)):
          elem1 = row[i]
          sno1 = self.suit_lookup[elem1]
          self.equivalences.append([sno0, sno1])
          self.suit_info[sno1]['hcp'] = hcp_average


  def set_lp_upper_constraints(self, A_ub, b_ub):
    for index, dom in enumerate(self.dominances):
      # If the jack dominates the ten, then -jack + ten <= 0
      A_ub[index][dom['dominant']] = -1
      A_ub[index][dom['dominated']] = 1
      b_ub[index] = 0

  
  def set_lp_equality_hcp(self, A_eq, b_eq):
    '''Set the equalities for each length unless completely skipped.'''
    num_active_lengths = BRIDGE_TRICKS + 1 - self.num_complete_len_skips
    sum = np.zeros(num_active_lengths)

    # Make an array of the lengths that are not skipped.
    collapsed_lengths = np.zeros(BRIDGE_TRICKS + 1, dtype = int)
    collapsed_len = 0
    for l in range(BRIDGE_TRICKS + 1):
      if self.active_by_len[l]:
        collapsed_lengths[l] = collapsed_len
        collapsed_len += 1
      
    # Add an HCP balance for each length unless completely skipped.
    for sno, si in enumerate(self.suit_info):
      length = si['length']
      if self.active_by_len[length] == False:
        continue

      collapsed_len = collapsed_lengths[length]
      A_eq[collapsed_len][sno] = si['count']
      sum[collapsed_len] += si['hcp'] * si['count']

    for collapsed_len in range(num_active_lengths):
      b_eq[collapsed_len] = sum[collapsed_len]

    return num_active_lengths


  def set_lp_equal_constraints(self, A_eq, b_eq):
    '''Add three kinds of suit equality constraints.'''

    # Add the equalities for each length unless completely skipped.
    index = self.set_lp_equality_hcp(A_eq, b_eq)

    # Add the active equivalences.
    for i in range(len(self.equivalences)):
      equiv = self.equivalences[i]
      A_eq[index + i][equiv[0]] = 1
      A_eq[index + i][equiv[1]] = -1
      b_eq[index + i] = 0

    # Add the skip equalities.
    index += len(self.equivalences)
    for sno, si in enumerate(self.suit_info):
      if si['skip']:
        A_eq[index][sno] = 1
        b_eq[index] = si['hcp']
        index += 1

    '''
    for index in range(self.num_equalities()):
      print("equiv", index, ":")
      for sno in range(NUM_SUITS):
        if (A_eq[index][sno] != 0):
          print("  ", self.suit_info[sno]['text'], ":", A_eq[index][sno])
      print("  == ", b_eq[index])
      '''


  def set(self):
    self.set_suit_list()
    self.set_suit_info()
    self.read_skips()
    self.set_suit_dominances()
    self.read_equivalences()

  
  def get(self, sno):
    assert sno < len(self.suit_info)
    return self.suit_info[sno]

  
  def str_with_variables(self, variables):
    s = "Suit variables\n\n"
    for sno in self.order:
      sv = variables[sno]
      # if sv == 0: continue
      s += "{:4d}".format(sno) + " " + \
        "{:16s}".format(self.suit_info[sno]['text']) + " " + \
        "{:16.4f}".format(sv) + "\n"

    return s

  
  def num_equalities(self):
    # There is an equality constraint for each length unless skipped.
    # There is one for each (active) suit equivalence.  The inactive
    # ones were skipped at read time.
    # There is one for each skip.
    return (BRIDGE_TRICKS + 1 - self.num_complete_len_skips) + \
      len(self.equivalences) + \
      self.num_skips

 
  def get_num_dominances(self):
    return self.num_dominances

  
  def str_with_variables_passes(self, variables, pass_counts):
    s = "Suit pass predictions\n\n"
    for sno in self.order:
      sv = variables[sno]
      if sv == 0 and pass_counts[sno] == 0: continue
      s += "{:4d}".format(sno) + " " + \
        "{:16s}".format(self.suit_info[sno]['text']) + " " + \
        "{:16.4f}".format(sv) + " " + \
        "{:6d}".format(pass_counts[sno]) + "\n"

    return s

