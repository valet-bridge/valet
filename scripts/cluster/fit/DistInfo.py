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

    self.set()
    self.read_equivalences()


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
          
          self.dist_lookup[self.dist_info[dno]['text']] = dno

          dno += 1

    comb_values = np.array([item['comb'] for item in self.dist_info])
    self.order = np.argsort(comb_values)[::-1]


  def read_equivalences(self):
    if not os.path.exists(DIST_EQUIV_FILE):
      return
    if not os.path.isfile(DIST_EQUIV_FILE):
      return

    with open(DIST_EQUIV_FILE, 'r') as csvfile:
      reader = csv.reader(csvfile, skipinitialspace = True)
      for row in reader:
        elem0 = row[0]
        if elem0 not in self.dist_lookup:
          print(elem0, "not a known distribution")
          quit()

        for i in range(1, len(row)):
          elem1 = row[i]
          if elem1 not in self.dist_lookup:
            print(elem1, "not a known distribution")
            quit
          self.equivalences.append( \
            [NUM_SUITS + self.dist_lookup[elem0], \
            NUM_SUITS + self.dist_lookup[elem1]])


  def set_lp_equal_constraints(self, num_suit_equiv, A_eq, b_eq):
    call = comb(52, 13)
    sum = 0

    index = BRIDGE_TRICKS+1 + num_suit_equiv

    for dno in range(NUM_DIST):
      prob = self.dist_info[dno]['comb'] / call
      A_eq[index][NUM_SUITS + dno] = prob
      sum += self.dist_info[dno]['hcp'] * prob

    # The sum it happens to be to begin with
    b_eq[index] = sum

    # Then add the equivalences.
    for i in range(len(self.equivalences)):
      equiv = self.equivalences[i]
      A_eq[index + i + 1][equiv[0]] = 1
      A_eq[index + i + 1][equiv[1]] = -1
      b_eq[index + i + 1] = 0

    # Unlike in SuitInfo we're not moving our initial solution
    # outside of the feasible region by doing this, as long as
    # the distributions we are equating have the same number of
    # initial distribution points.


  def get(self, dno):
    assert dno < len(self.dist_info)
    return self.dist_info[dno]

  
  def num_equivalences(self):
    return len(self.equivalences)


  def str_with_variables(self, variables):
    s = "Distribution variables\n\n"
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

