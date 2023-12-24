import numpy as np
from scipy.stats import norm
from scipy.optimize import curve_fit
import math

class Weak:
  '''A Gaussian pdf on the left, a dropping parabola on the right.'''

  def __init__(self):
    # Up to center, the curve is a Gaussian pdf with mean 'center'
    # and standard deviation 'sigma', scaled such that the value
    # at the mean is 'peak' and not 1 / [sigma * sqrt(2 pi)].
    # From 'center' to 'cutoff', the curve is a parabola branch
    # that starts out flat and decreases to zero at 'cutoff'.
    # This is often a decent fit to the probability that a hand
    # is opened as a weak two.
    
    # Sensible defaults for a weak two.
    self.set(8., 2., 0.8, 11.)

    self.calc_vectorized = np.vectorize(self.calc_scalar)
    self.calc_deriv_vectorized = np.vectorize(self.calc_deriv_scalar)

    self.errsq = 0.

  
  def set(self, center, sigma, peak, cutoff):
    '''Set the parameters.'''
    self.center = center
    self.sigma = sigma
    self.peak = peak
    self.cutoff = cutoff

    # These are conveniences.
    self.gauss_factor = self.peak * sigma * math.sqrt(2. * math.pi)
    self.gauss_deriv_factor = self.gauss_factor / self.sigma ** 2
    self.parabola_factor = 1. / (self.cutoff - self.center) ** 2


  def calc_scalar(self, scalar):
    '''Calculate the two-branched likelihood of a weak opening.'''
    if (scalar < self.center):
      return self.gauss_factor * \
        norm.pdf(scalar, loc = self.center, scale = self.sigma)
    elif scalar >= self.cutoff:
      return 0.
    else:
      return self.peak * \
        (1. - self.parabola_factor * (scalar - self.center) ** 2)

  
  def calc_deriv_scalar(self, scalar):
    '''Calculate the analytical derivative of the fit.'''
    if (scalar < self.center):
      return -(scalar - self.center) * self.gauss_deriv_factor * \
        norm.pdf(scalar, loc = self.center, scale = self.sigma)
    elif scalar >= self.cutoff:
      # Discontinuity at self.cutoff
      return 0.
    else:
      return -2. * self.peak * self.parabola_factor * (scalar - self.center)

  
  def calc_wrapper(self, x, center, sigma, peak, cutoff):
    self.set(center, sigma, peak, cutoff)
    return self.calc_vectorized(x)


  def fit_data(self, x_data, sigma, y_data):
    '''Fit the sigmoid parameters to the provided numpy data.'''
    params, pcov = curve_fit(self.calc_wrapper, x_data, y_data, \
      sigma = sigma,
      p0 = [self.center, self.sigma, self.peak, self.cutoff],
      bounds = ([1., 0.1, 0.1, 5.], [12., 10., 1., 15.]))

    self.set(params[0], params[1], params[2], params[3])

    self.sdev = np.sqrt(np.diag(pcov))
    sum = np.sum(np.reciprocal(sigma))
    self.errsq = \
      np.sqrt(np.sum(((y_data - self.calc_vectorized(x_data)) / sigma) ** 2)) / sum


  def str_header(self):
    '''Returns a header.'''
    s = "{:>8s}".format("Center") + "{:>8s}".format("Peak") + \
      "{:>8s}".format("Sigma") + "{:>8s}".format("Cutoff") + \
      "{:>8s}".format("averr")
    return s
  

  def str(self):
    '''Returns a string of parameters.'''
    s = "{:8.3f}".format(self.center) + \
      "{:8.3f}".format(self.peak) + \
      "{:8.3f}".format(self.sigma) + \
      "{:8.3f}".format(self.cutoff) + \
      "{:8.3f}".format(self.errsq)
    return s

