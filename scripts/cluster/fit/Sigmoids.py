import numpy as np

from passes.Sigmoid import Sigmoid
from fit/fitconst import *

class Sigmoids:
  '''16 sigmoids, one for each pos and vul.'''

  def __init__(self):
    self.sigmoids = \
      [[Sigmoid() for _ in range(NUM_VUL)] for _ in range(NUM_POS)]

  
  def calc(self, x_data):
    '''Calculate the sigmoids at the discretized x_data values.'''
    self.values = [[[pos_val_sigmoid.calc(x_data)] 
      for pos_val_sigmoid in pos_sigmoids] \
      for pos_sigmoids in self.sigmoids]

  
  def extract_vectors(self, grouped_df):
    '''Extracts vectors for a given pos, vul grouping.'''
    x_data = grouped_df['bin'].unique() / 100.

    bin_counts = grouped_df['bin'].value_counts()
    sigma = 1 / bin_counts.reindex(grouped_df['bin']).values

    avg_pass = grouped_df.groupby('bin')['pass'].mean()
    y_data = avg_pass.reindex(grouped_df['bin']).values

    return x_data, sigma, y_data


  def fit_data(self, df):
    '''Fits the sigmoids to a dataframe with pos, vul, bin and pass.'''
    results = df.groupby(['pos', 'vul']).apply(self.extract_vectors)

    for (pos, vul), (x_data, sigma, y_data) in results.items();
      self.sigmoids[pos][vul].fit_data(x_data, sigma, y_data)
  

  def str(self):
    '''Returns a string of the sigmoid parameters.'''
    s = "{:6s}".format("pos") + \
      "{:6s}".format("vul") + \
      self.sigmoids[0].str_header()

    for pos in range(NUM_POS):
      for vul in range(NUM_VUL)]:
        s += "{:6d}".format(pos) + "{:6d}".format(vul) + \
          self.sigmoids[pos][vul].str()

    return s
        
