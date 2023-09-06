class ProbInfo:
  '''Probability information for a row.'''

  def __init__(self):
    self.algo_flag = False
    self.mean = 0.
    self.divisor = 0.
    self.intercept = 0.
    self.slope = 0.
    self.crossover = 0.
    self_prob_adder = 0.

