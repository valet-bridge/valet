import pandas as pd
import numpy as np
import itertools
from itertools import chain

from fit.fitconst import *
from passes.Sigmoid import Sigmoid

class Sigmoids:
  '''16 sigmoids, one for each pos and vul.'''

  def __init__(self):
    self.sigmoids = []
    self.df = pd.DataFrame()

  
  def init(self, num_pos, num_vul):
    self.num_pos = num_pos
    self.num_vul = num_vul
    self.sigmoids = \
      [[Sigmoid() for _ in range(num_vul)] for _ in range(num_pos)]

  
  def calc(self, x_data):
    '''Calculate the sigmoids at the discretized x_data values.'''

    # The derivatives can actually also be calculated from the 
    # sigmoid values.  Check later on whether this is a speed issue.
    values = np.empty(self.num_vul * self.num_pos * len(x_data))
    derivatives = np.empty(self.num_vul * self.num_pos * len(x_data))

    for pos in range(self.num_pos):
      for vul in range(self.num_vul):
       start = (self.num_vul * pos + vul) * len(x_data)
       s = slice(start, start + len(x_data))
       values[s] = self.sigmoids[pos][vul].calc(x_data)
       derivatives[s] = self.sigmoids[pos][vul].calc_derivative(x_data)
        
    # Generate all combinations of pos, vul, and bin_midpoints
    pos_vul_bin_combinations = list(itertools.product( \
      range(self.num_pos), range(self.num_vul), range(len(x_data))))

    # Flatten the 3D sigmoid_values list into a 1D list
    self.df = pd.DataFrame({
        'pos': [item[0] for item in pos_vul_bin_combinations],
        'vul': [item[1] for item in pos_vul_bin_combinations],
        'bin': [item[2] for item in pos_vul_bin_combinations],
        'sigmoid': values,
        'deriv': derivatives
    })

  
  def hist_to_gradients(self, hist_df, actual_df, num_vars):
    '''Turns the histogram frame into a vector of gradients.'''

    # Make another dataframe where the bin counts go into bin_counts
    # and the bin numbers stay in bin.
    melted_df = hist_df.melt(id_vars=['pos', 'vul', 'dno'], \
      value_name = 'bin_counts', var_name = 'bin')

    # Align the sigmoid values in self.df with the melted frame.
    merged_df = melted_df.merge(self.df, 
      on = ['pos', 'vul', 'bin'], 
      how ='left')

    # The gradient is more or less
    # the sum of deriv * (bin_counts * sigmoid - pass number in bin).

    remerged_df = merged_df.merge(actual_df.reset_index(),
      on = ['pos', 'vul', 'dno', 'bin'], 
      how ='left')

    remerged_df['pass'].fillna(0, inplace = True)

    remerged_df['prediction'] = \
      remerged_df['bin_counts'] * remerged_df['sigmoid']

    remerged_df['gradient'] = \
      remerged_df['deriv'] * (remerged_df['prediction'] - remerged_df['pass'])

    # Add up the derivatives for (pos, vul, dno).
    gradient_df = remerged_df.groupby(['dno']).agg({'gradient': 'sum'})

    # Explanation of polarity: Say 'prediction' is 100 and 'pass' is 80.
    # There are more predicted than actual passes.  Therefore if we 
    # increase the value of the corresponding variable, we move further to
    # the right on the sigmoid which decreases the prediction and brings
    # it closer to the actual value.  
    # The LP optimization is a minimization.  Therefore increasing the
    # variable should make the LP objective function more negative.
    # Therefore the gradient should be negative.
    # The actual sigmoid gradient is always negative.
    # Putting this together: If prediction > pass and deriv < 0,
    # then gradient < 0.

    gradient = \
      gradient_df['gradient'].reindex(range(num_vars), fill_value = 0) \
      .values

    # This is going to be very jumpy no matter how good we get,
    # as there won't always be a lot of passes for a single combination
    # of pos, vul, dno and bin.  I suppose we could instead aggregate
    # over bins, and only then square and add up.
    error_df = remerged_df.groupby(['dno']) \
      .agg({'prediction': 'sum', 'pass': 'sum'})

    total_error = ((error_df['prediction'] - error_df['pass']) ** 2).sum()

    return gradient, total_error / num_vars

  
  def extract_vectors(self, grouped_df):
    '''Extracts vectors for a given pos, vul grouping.'''
    df = grouped_df.groupby('bin').agg(
      pass_count = ('pass', 'sum'),
      total_count = ('pass', 'size')).reset_index()

    x_data = df['bin'].values / 100.
    sigma = (1 / np.sqrt(df['total_count'])).values
    y_data = (df['pass_count'] / df['total_count']).values

    return x_data, sigma, y_data


  def fit_data(self, df):
    '''Fits the sigmoids to a dataframe with pos, vul, bin and pass.'''
    results = df.groupby(['pos', 'vul']).apply(self.extract_vectors)

    for (pos, vul), (x_data, sigma, y_data) in results.items():
      self.sigmoids[pos][vul].fit_data(x_data, sigma, y_data)
  

  def str(self, pos_list, vul_list):
    '''Returns a string of the sigmoid parameters.'''
    s = "{:>6s}".format("pos") + \
      "{:>6s}".format("vul") + \
      self.sigmoids[0][0].str_header() + "\n"

    for pos in range(self.num_pos):
      for vul in range(self.num_vul):
        s += "{:6d}".format(pos_list[pos]) + \
          "{:6d}".format(vul_list[vul]) + \
          self.sigmoids[pos][vul].str() + "\n"

    return s
        
