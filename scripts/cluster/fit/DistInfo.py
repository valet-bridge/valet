from math import comb

from fit.fitconst import *

class DistInfo:
  '''Information about each of 560 possible distributions.'''

  def __init__(self):
    self.dist_info = [{} for _ in range(NUM_DIST)]

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


  def set_lp_equal_constraints(self, A_eq, b_eq):
    call = comb(52, 13)
    sum = 0

    for dno in range(NUM_DIST):
      A_eq[1][NUM_SUITS + dno] = self.dist_info[dno]['comb'] / call
      sum += self.dist_info[dno]['hcp'] * A_eq[1][NUM_SUITS + dno]

    # The sum it happens to be to begin with
    b_eq[1] = sum
    print("dist sum", sum)


  def get(self, dno):
    assert dno < len(self.dist_info)
    return self.dist_info[dno]
