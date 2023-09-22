import numpy as np
from math import comb

from fit.fitconst import *

class DistInfo:
  '''Information about each of 560 possible distributions.'''

  def __init__(self):
    self.dist_info = [{} for _ in range(NUM_DIST)]

    self.order = np.zeros(NUM_DIST, dtype = int)

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

          dno += 1

    comb_values = np.array([item['comb'] for item in self.dist_info])
    self.order = np.argsort(comb_values)[::-1]


  def set_lp_equal_constraints(self, A_eq, b_eq):
    call = comb(52, 13)
    sum = 0

    for dno in range(NUM_DIST):
      prob = self.dist_info[dno]['comb'] / call
      A_eq[BRIDGE_TRICKS+1][NUM_SUITS + dno] = prob
      sum += self.dist_info[dno]['hcp'] * prob

    # The sum it happens to be to begin with
    b_eq[BRIDGE_TRICKS+1] = sum


  def get(self, dno):
    assert dno < len(self.dist_info)
    return self.dist_info[dno]

  
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

