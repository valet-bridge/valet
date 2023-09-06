import math

class Sigmoid:
  '''A sigmoid, turning into a line on the left.'''

  def __init__(self):
    self.mean = 0.
    self.divisor = 0.
    self.intercept = 0.
    self.slope = 0.
    self.crossover = 0.

  
  def set(self, mean, divisor, intercept, slope):
    '''Set the parameters.'''
    self.mean = mean
    self.divisor = divisor
    self.intercept = intercept
    self.slope = slope
    self.crossover = self.calc_sigmoid(intercept)


  def calc_linear(self, x):
    '''Calculate the linear term(s) below the intercept.'''

    value = self.crossover - self.slope * (x - self.intercept)
    if value > 1.:
      return 1.
    else:
      return value


  def calc_sigmoid(self, x):
    '''Calculate the sigmoid term above the intercept.'''
    return 1. - 1. / (1. + math.exp(-(x - self.mean) / self.divisor))


  def calc(self, x):
    '''Calculate the overall value.'''
    if (x <= self.intercept):
      return self.calc_linear(x)
    else:
      return self.calc_sigmoid(x)

