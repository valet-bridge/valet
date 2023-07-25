import statsmodels.api as sm


class PassMap:
  '''A 2-D histogram suitable for actual and predicted pass frequencies.'''

  def __init__(self):
    self.x = []
    self.y = []


  def add(self, freq_actual, freq_predicted):
    self.x.append(freq_actual)
    self.y.append(freq_predicted)

  
  def correlate(self, drop00_flag):
    '''Calculate a correlation of the histogram.'''
    # TODO Implement drop00_flag.
    if (len(self.x) == 0):
      return

    # Apparently this is needed
    X = sm.add_constant(self.x)

    model = sm.OLS(self.y, X)
    results = model.fit()

    print("Parameters: actual =", \
      "{:.4f}".format(results.params[0]), "+", \
      "{:.4f}".format(results.params[1]), "* prediction")

    print("R-squared : ", "{:.4f}".format(results.rsquared))
