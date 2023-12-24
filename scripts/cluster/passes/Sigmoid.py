import numpy as np
from scipy.optimize import curve_fit
import math

class Sigmoid:
  '''A sigmoid, turning into a line on the left.'''

  def __init__(self):
    self.mean = 10.
    self.divisor = 1.
    self.intercept = 0.
    self.slope = 0.
    self.crossover = 0.

    self.sdev = np.zeros(2)
    self.errsq = 0.

  
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


  def calc(self, x):
    '''Calculate the sigmoid term above the intercept.'''
    return 1. / (1. + np.exp(-(x - self.mean) / self.divisor))

  
  def calc_derivative(self, x):
    assert self.divisor > 0.
    sv = self.calc(x)
    return sv * (1 - sv) / self.divisor

  
  def calc_derivative_from_values(self, values):
    assert self.divisor > 0.
    return values * (1 - values) / self.divisor

  
  @staticmethod
  def _calc(x, mean, divisor):
    return 1. / (1. + np.exp(-(x - mean) / divisor))


  def fit_data(self, x_data, sigma, y_data):
    '''Fit the sigmoid parameters to the provided numpy data.'''
    params, pcov = curve_fit(self._calc, x_data, y_data, \
      sigma = sigma,
      p0 = [self.mean, self.divisor],
      bounds=([1, 0.1], [float('inf'), float('inf')]))
    self.mean, self.divisor = params

    self.sdev = np.sqrt(np.diag(pcov))
    sum = np.sum(np.reciprocal(sigma))
    self.errsq = \
      np.sqrt(np.sum(((y_data - self.calc(x_data)) / sigma) ** 2)) / sum


  def calc_both(self, x):
    '''Calculate the overall value.'''
    if (x <= self.intercept):
      return self.calc_linear(x)
    else:
      return self.calc(x)

  
  def str_header(self):
    '''Returns a header.'''
    s = "{:>8s}".format("Mean") + "{:>8s}".format("Sigma") + \
      "{:>8s}".format("sd1") + "{:>8s}".format("sd2") + \
      "{:>8s}".format("averr")
    return s
  

  def str(self):
    '''Returns a string of parameters.'''
    s = "{:8.3f}".format(self.mean) + \
      "{:8.3f}".format(self.divisor) + \
      "{:8.3f}".format(self.sdev[0]) + \
      "{:8.3f}".format(self.sdev[1]) + \
      "{:8.3f}".format(self.errsq)
    return s

