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

    # Print order.
    self.order = np.zeros(NUM_SUITS, dtype = int)

    # Look up "KQx" into the corresponding suit number.
    self.suit_lookup = {}

    # Equivalences among suit variables can be read in.
    self.equivalences = []

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
    return text


  def set_suit_list(self):
    reduced_suit_number = 0
    for holding in range(1 << BRIDGE_TRICKS):
      length = self.count_ones(holding)
      tops = holding >> 7

      if 'count' not in self.suit_list[length][tops]:
        self.suit_list[length][tops]['sno'] = reduced_suit_number
        self.suit_list[length][tops]['count'] = 1
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

        self.suit_lookup[entry_ref['text']] = sno

    order_no = 0
    for length in range(BRIDGE_TRICKS+1):
      for tops in range(1 << NUM_TOPS):
        if 'sno' not in self.suit_list[length][tops]: continue
        self.order[order_no] = self.suit_list[length][tops]['sno']
        order_no += 1


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

            self.dominances.append({ \
              'dominant': self.suit_list[length][tops]['sno'], \
              'dominated': self.suit_list[length][new_tops]['sno']})
      
        # It is possible to turn a nine into an x when there is an x free.
        if (bits[0] and self.count_ones(tops) > \
            length + NUM_TOPS - BRIDGE_TRICKS):
          new_tops = tops
          new_tops ^= 1;
          self.dominances.append({ \
            'dominant': self.suit_list[length][tops]['sno'], \
            'dominated': self.suit_list[length][new_tops]['sno']})


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

        for i in range(1, len(row)):
          elem1 = row[i]
          if elem1 not in self.suit_lookup:
            print(elem1, "not a known suit")
            quit
          self.equivalences.append([self.suit_lookup[elem0], \
            self.suit_lookup[elem1]])


  def set_lp_upper_constraints(self, A_ub, b_ub):
    for index, dom in enumerate(self.dominances):
      # If the jack dominates the ten, then -jack + ten <= 0
      A_ub[index][dom['dominant']] = -1
      A_ub[index][dom['dominated']] = 1
      b_ub[index] = 0

  
  def set_lp_equal_constraints(self, A_eq, b_eq):
    sum = np.zeros(BRIDGE_TRICKS+1)

    for sno, si in enumerate(self.suit_info):
      A_eq[si['length']][sno] = si['count']
      sum[si['length']] += si['hcp'] * si['count']

    for length in range(BRIDGE_TRICKS+1):
      b_eq[length] = sum[length]

    '''
    for length in range(BRIDGE_TRICKS+1):
      for sno in range(NUM_SUITS):
        if (A_eq[length][sno] > 0):
          print(length, sno, ":", A_eq[length][sno])
      if (b_eq[length] >0):
        print(length, "sum", b_eq[length])
    quit()
    '''


  def set(self):
    self.set_suit_list()
    self.set_suit_info()
    self.set_suit_dominances()
    self.read_equivalences()

  
  def get(self, sno):
    assert sno < len(self.suit_info)
    return self.suit_info[sno]

  
  def str_with_variables(self, variables):
    s = "Suit variables\n\n"
    for sno in self.order:
      sv = variables[sno]
      if sv == 0: continue
      s += "{:4d}".format(sno) + " " + \
        "{:16s}".format(self.suit_info[sno]['text']) + " " + \
        "{:16.4f}".format(sv) + "\n"

    return s

  
  def num_equivalences(self):
    return len(self.equivalences)

  
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

