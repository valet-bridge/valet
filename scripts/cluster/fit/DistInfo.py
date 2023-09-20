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

          dno += 1


  def get(self, dno):
    assert dno < len(self.dist_info)
    return self.dist_info[dno]
