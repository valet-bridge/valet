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

  
  def calc_sigmoid_parallel(self, x):
    '''Calculate the sigmoid term above the intercept.'''
    return 1. - 1. / (1. + np.exp(-(x - self.mean) / self.divisor))

  
  def calc_derivative_np(self, x):
    assert self.divisor > 0.
    sv = self._sigmoid(x, self.mean, self.divisor)
    return - sv * (1 - sv) / self.divisor


  @staticmethod
  def _sigmoid(x, mean, divisor):
    '''Static sigmoid function to be used by curve_fit.'''
    return 1. - 1. / (1. + np.exp(-(x - mean) / divisor))

   
  def fit_data(self, x_data, y_data):
    '''Fit the sigmoid parameters to the provided numpy data.'''
    params, _ = curve_fit(self._sigmoid, x_data, y_data, \
      p0 = [self.mean, self.divisor])
    self.mean, self.divisor = params


  def calc(self, x):
    '''Calculate the overall value.'''
    if (x <= self.intercept):
      return self.calc_linear(x)
    else:
      return self.calc_sigmoid(x)

