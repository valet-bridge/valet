import os
import csv
import numpy as np
from math import comb

from fit.fitconst import *

class DistInfo:
  '''Information about each of 560 possible distributions.'''

  def __init__(self):
    self.dist_info = [{} for _ in range(NUM_DIST)]

    self.order = np.zeros(NUM_DIST, dtype = int)

    # Look up "3=4=3=3" into the corresponding distribution number.
    self.dist_lookup = {}

    # Equivalences among suit variables can be read in.
    self.equivalences = []

    self.num_skips = 0

    self.set()


  def set(self):
    dno = 0
    hcp = [3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    for spades in range(BRIDGE_TRICKS + 1):
      for hearts in range(BRIDGE_TRICKS + 1 - spades):
        for diamonds in range(BRIDGE_TRICKS + 1 - spades - hearts):
          clubs = BRIDGE_TRICKS - spades - hearts - diamonds

          self.dist_info[dno]['text'] = str(spades) + "=" + \
            str(hearts) + "=" + str(diamonds) + "=" + str(clubs)

          self.dist_info[dno]['hcp'] = hcp[spades] + hcp[hearts] + \
            hcp[diamonds] + hcp[clubs]

          self.dist_info[dno]['comb'] = comb(13, spades) * \
            comb(13, hearts) * comb(13, diamonds) * comb(13, clubs)

          self.dist_info[dno]['skip'] = False
          
          self.dist_lookup[self.dist_info[dno]['text']] = dno

          dno += 1

    comb_values = np.array([item['comb'] for item in self.dist_info])
    self.order = np.argsort(comb_values)[::-1]

  
  def check_skips(self, smallest, largest, cutoff):
    if smallest <= cutoff:
    # if largest <= cutoff:
      return False
    else:
    # elif smallest >= cutoff + 1:
      return True
    # else:
      # print("Inconsistency:", smallest, largest, cutoff)
      # quit()
    
    return False


  def read_skips(self, pos_list):
    '''Read distribution variables that are too thin to estimate.'''
    if not os.path.exists(DIST_SKIP_FILE):
      return
    if not os.path.isfile(DIST_SKIP_FILE):
      return

    # The positions to skip for each dist are specified in the skip file.
    # The possibilities are 3, 23 and 0123 (we also permit 123).  
    # The positions for which we solve are given in pos_list.
    smallest = min(pos_list)
    largest = max(pos_list)

    with open(DIST_SKIP_FILE, 'r') as csvfile:
      reader = csv.reader(csvfile, delimiter = ' ', skipinitialspace = True)
      for row in reader:
        assert len(row) == 4
        (dno, text, val, to_skip) = \
          (int(row[0]), row[1], float(row[2]), row[3])

        skip_flag = False
        if to_skip == "0123":
          skip_flag = True
        elif to_skip == "123":
          skip_flag = self.check_skips(smallest, largest, 0)
        elif to_skip == "23":
          skip_flag = self.check_skips(smallest, largest, 1)
        elif to_skip == "3":
          skip_flag = self.check_skips(smallest, largest, 2)

        if not skip_flag:
          continue

        assert dno >= 0 and dno < len(self.dist_info)
        entry_ref = self.dist_info[dno]

        assert entry_ref['text'] == text
        entry_ref['skip'] = True
        entry_ref['hcp'] = val
        self.num_skips += 1


  def read(self, pos_list):
    self.read_skips(pos_list)
    self.read_equivalences()


  def equiv_is_skipped(self, row):
    num_skips = 0
    for elem in row:
      if elem not in self.dist_lookup:
        print(elem, "not a known distribution")
        quit()

      dno = self.dist_lookup[elem]
      if self.dist_info[dno]['skip']:
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
    if not os.path.exists(DIST_EQUIV_FILE):
      return
    if not os.path.isfile(DIST_EQUIV_FILE):
      return

    with open(DIST_EQUIV_FILE, 'r') as csvfile:
      reader = csv.reader(csvfile, skipinitialspace = True)
      for row in reader:
        if self.equiv_is_skipped(row):
          continue

        elem0 = row[0]

        for i in range(1, len(row)):
          elem1 = row[i]
          if elem1 not in self.dist_lookup:
            print(elem1, "not a known distribution")
            quit()
          self.equivalences.append( \
            [NUM_SUITS + self.dist_lookup[elem0], \
            NUM_SUITS + self.dist_lookup[elem1]])


  def set_to_zero(self):
    for dno in range(NUM_DIST):
      self.dist_info[dno]['hcp'] = 0


  def set_lp_equal_constraints(self, num_suit_equalities, A_eq, b_eq):
    '''Add three kinds of distribution equality constraints.'''

    # Add the overall balance of HCP for all distributions together.
    call = comb(52, 13)
    sum = 0

    index = num_suit_equalities

    for dno in range(NUM_DIST):
      prob = self.dist_info[dno]['comb'] / call
      A_eq[index][NUM_SUITS + dno] = prob
      sum += self.dist_info[dno]['hcp'] * prob

    # The sum it happens to be to begin with
    b_eq[index] = sum

    # Add the active equivalences.
    for i in range(len(self.equivalences)):
      equiv = self.equivalences[i]
      A_eq[index + i + 1][equiv[0]] = 1
      A_eq[index + i + 1][equiv[1]] = -1
      b_eq[index + i + 1] = 0

    # Unlike in SuitInfo we're not moving our initial solution
    # outside of the feasible region by doing this, as long as
    # the distributions we are equating have the same number of
    # initial distribution points.

    # Add the skip equalities.
    index += len(self.equivalences) + 1
    for dno, di in enumerate(self.dist_info):
      if di['skip']:
        A_eq[index][NUM_SUITS + dno] = 1
        b_eq[index] = di['hcp']
        index += 1


  def get(self, dno):
    assert dno < len(self.dist_info)
    return self.dist_info[dno]

  
  # def num_equivalences(self):
    # return len(self.equivalences)

  
  def num_equalities(self):
    # There is one overall equality.
    # There are len(self.equivalences) active equivalances.
    # There are self.num_skips skip equivalences.
    return 1 + len(self.equivalences) + self.num_skips


  def str_with_variables(self, variables, title = "Distribution variables"):
    s = title + "\n\n"
    for dno in self.order:
      dv = variables[dno + NUM_SUITS]
      s += "{:4d}".format(dno) + " " + \
        "{:10s}".format(self.dist_info[dno]['text']) + " " + \
        "{:10.4f}".format(dv) + "\n"

    return s

  
  def str_with_variables_passes(self, variables, pass_counts):
    s = "Distribution pass predictions\n\n"
    for dno in self.order:
      dv = variables[dno + NUM_SUITS]
      if dv == 0 and pass_counts[dno] == 0: continue
      s += "{:4d}".format(dno) + " " + \
        "{:10s}".format(self.dist_info[dno]['text']) + " " + \
        "{:10.4f}".format(dv) + " " + \
        "{:6d}".format(pass_counts[dno]) + "\n"

    return s

