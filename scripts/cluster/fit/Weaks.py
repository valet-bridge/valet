import pandas as pd
import numpy as np
import itertools
from itertools import chain

from fit.fitconst import *
from passes.Weak import Weak

class Weaks:
  '''16 Weak's, one for each pos and vul.'''

  def __init__(self):
    self.weaks = []
    self.df = pd.DataFrame()

  
  def init(self, num_pos, num_vul):
    self.num_pos = num_pos
    self.num_vul = num_vul
    self.weaks = \
      [[Weak() for _ in range(num_vul)] for _ in range(num_pos)]

    # for i in range(150):
      # x = i / 10.
      # print(f"{x:8.2f}{self.weaks[0][0].calc_scalar(x):8.2f}{self.weaks[0][0].calc_deriv_scalar(x):8.2f}")
    # exit()

  
  def calc(self, x_data):
    '''Calculate the weak's at the discretized x_data values.'''

    values = np.empty(self.num_vul * self.num_pos * len(x_data))
    derivatives = np.empty(self.num_vul * self.num_pos * len(x_data))

    for pos in range(self.num_pos):
      for vul in range(self.num_vul):
       start = (self.num_vul * pos + vul) * len(x_data)
       s = slice(start, start + len(x_data))
       values[s] = self.weaks[pos][vul].calc_vectorized(x_data)
       derivatives[s] = self.weaks[pos][vul].calc_deriv_vectorized(x_data)
        
    # Generate all combinations of pos, vul, and bin_midpoints
    pos_vul_bin_combinations = list(itertools.product( \
      range(self.num_pos), range(self.num_vul), range(len(x_data))))

    # Flatten the 3D results into a 1D list
    self.df = pd.DataFrame({
        'pos': [item[0] for item in pos_vul_bin_combinations],
        'vul': [item[1] for item in pos_vul_bin_combinations],
        'bin': [item[2] for item in pos_vul_bin_combinations],
        'weak': values,
        'deriv': derivatives
    })

  
  def hist_to_gradients(self, hist_df, actual_df, num_vars):
    '''Turns the histogram frame into a vector of gradients.'''

    # Make another dataframe where the bin counts go into bin_counts
    # and the bin numbers stay in bin.
    melted_df = hist_df.melt(id_vars=['pos', 'vul', 'dno'], \
      value_name = 'bin_counts', var_name = 'bin')

    # Align the values in self.df with the melted frame.
    merged_df = melted_df.merge(self.df, 
      on = ['pos', 'vul', 'bin'], 
      how ='left')

    # The gradient is more or less
    # the sum of deriv * (bin_counts * weak - open number in bin).

    remerged_df = merged_df.merge(actual_df.reset_index(),
      on = ['pos', 'vul', 'dno', 'bin'], 
      how ='left')

    remerged_df['open'].fillna(0, inplace = True)

    remerged_df['prediction'] = \
      remerged_df['bin_counts'] * remerged_df['weak']

    # This is not used for optimization, and it is only a measure of
    # the error.
    remerged_df['sq_err'] = \
      remerged_df['prediction'] * remerged_df['weak'] + \
      remerged_df['open'] * (1 - 2 * remerged_df['weak'])

    remerged_df['gradient'] = \
      remerged_df['deriv'] * \
        (remerged_df['prediction'] - remerged_df['open'])

    # Add up the derivatives for (pos, vul, dno).
    gradient_df = remerged_df.groupby(['dno']).agg({'gradient': 'sum'})

    # Do the same for the prediction errors.
    sqerr_df = remerged_df.groupby(['dno']).agg({'sq_err': 'sum'})

    # Explanation of polarity: Say 'prediction' is 100 and 'open' is 80.
    # We are on the falling part of the weak curve.
    # There are more predicted than actual openings.  Therefore if we 
    # increase the value of the corresponding variable, we move further to
    # the right on the curve which decreases the prediction and brings
    # it closer to the actual value.  
    # The LP optimization is a minimization.  Therefore increasing the
    # variable should make the LP objective function more negative.
    # Therefore the gradient should be negative.
    # The actual weak gradient is always negative here.
    # Putting this together: If prediction > open and deriv < 0,
    # then gradient < 0.

    gradient = \
      gradient_df['gradient'].reindex(range(num_vars), fill_value = 0) \
      .values

    sq_error = \
      sqerr_df['sq_err'].reindex(range(num_vars), fill_value = 0) \
      .values

    # As we have aggregated by dno, we can add up the squares here
    # without making the error too jumpy.
    # total_error = pred_error @ pred_error

    # This is going to be very jumpy no matter how good we get,
    # as there won't always be a lot of opens for a single combination
    # of pos, vul, dno and bin.  I suppose we could instead aggregate
    # over bins, and only then square and add up.
    # error_df = remerged_df.groupby(['dno']) \
      # .agg({'prediction': 'sum', 'open': 'sum'})

    # total_error = ((error_df['prediction'] - error_df['open']) ** 2).sum()

    # return gradient, total_error / num_vars
    return gradient, sq_error

  
  def extract_vectors(self, grouped_df):
    '''Extracts vectors for a given pos, vul grouping.'''
    # TODO This is specific to one opening (weak two in spades) for now.
    df = grouped_df.groupby('bin').agg(
      open_count = ('w2sp', 'sum'),
      total_count = ('w2sp', 'size')).reset_index()

    x_data = df['bin'].values / 100.
    sigma = (1 / np.sqrt(df['total_count'])).values
    y_data = (df['open_count'] / df['total_count']).values

    # for i in range(len(x_data)):
      # print(f"{x_data[i]:8.2f}{sigma[i]:8.2f}{y_data[i]:8.2f}")
    # exit()

    return x_data, sigma, y_data


  def fit_data(self, df):
    '''Fits the weaks to a dataframe with pos, vul, bin and open.'''
    results = df.groupby(['pos', 'vul']).apply(self.extract_vectors)

    for (pos, vul), (x_data, sigma, y_data) in results.items():
      self.weaks[pos][vul].fit_data(x_data, sigma, y_data)
  

  def str(self, pos_list, vul_list):
    '''Returns a string of the weak parameters.'''
    s = "{:>6s}".format("pos") + \
      "{:>6s}".format("vul") + \
      self.weaks[0][0].str_header() + "\n"

    for pos in range(self.num_pos):
      for vul in range(self.num_vul):
        s += "{:6d}".format(pos_list[pos]) + \
          "{:6d}".format(vul_list[vul]) + \
          self.weaks[pos][vul].str() + "\n"

    return s
        
