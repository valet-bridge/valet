import numpy as np

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables

class LPsolver:
  '''Set up and solve an incremental LP problem.'''

  def __init__(self):
    self.c = np.zeros(NUM_VAR)
    self.A_ub = np.zeros((NUM_DOMINANCES, NUM_VAR))
    self.b_ub = np.zeros(NUM_DOMINANCES)
    self.A_eq = np.zeros((1, NUM_VAR))
    self.b_eq = np.zeros(1)
    self.bounds = np.zeros(NUM_VAR)

  
  def set_constraints(self, suit_info, estimate, step_size):
    # Dominances
    suit_info.set_lp_upper_constraints(self.A_ub, self.b_ub)

    # Weighted average of 5 points per suit.
    suit_info.set_lp_equal_constraints(self.A_eq, self.b_eq)

    # Limits of +/- 1 step_size.
    estimate.set_box_constraints(step_size, self.bounds)

