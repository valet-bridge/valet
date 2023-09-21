import pandas as pd
import numpy as np
import itertools
from itertools import chain

from fit.fitconst import *
from passes.Sigmoid import Sigmoid

class Sigmoids:
  '''16 sigmoids, one for each pos and vul.'''

  def __init__(self):
    self.sigmoids = \
      [[Sigmoid() for _ in range(NUM_VUL)] for _ in range(NUM_POS)]
    self.df = pd.DataFrame()

  
  def calc(self, x_data):
    '''Calculate the sigmoids at the discretized x_data values.'''
    values = [[pos_val_sigmoid.calc(x_data)
      for pos_val_sigmoid in pos_sigmoids] \
      for pos_sigmoids in self.sigmoids]

    # The derivatives can actually also be calculates from the 
    # sigmoid values.  Check later on whether this is a speed issue.
    derivatives = [[pos_val_sigmoid.calc_derivative(x_data)
      for pos_val_sigmoid in pos_sigmoids] \
      for pos_sigmoids in self.sigmoids]

    # Generate all combinations of pos, vul, and bin_midpoints
    pos_vul_bin_combinations = list(itertools.product( \
      range(NUM_POS), range(NUM_VUL), range(len(x_data))))

    # Flatten the 3D sigmoid_values list into a 1D list
    self.df = pd.DataFrame({
        'pos': [item[0] for item in pos_vul_bin_combinations],
        'vul': [item[1] for item in pos_vul_bin_combinations],
        'bin': [item[2] for item in pos_vul_bin_combinations],
        'sigmoid': list(chain.from_iterable(chain.from_iterable(values))),
        'deriv': list(chain.from_iterable(chain.from_iterable(derivatives)))
    })

  
  def hist_to_prediction(self, hist_df, actual_df, num_vars):
    '''Adds up sigmoid values for each (pos, vul, dno) in dataframe.'''

    # Make another dataframe where the bin counts go into hist_value
    # and the bin numbers go into bin.
    melted_df = hist_df.melt(id_vars=['pos', 'vul', 'dno'], \
      value_name = 'hist_value', var_name = 'bin')

    # Align the sigmoid values in self.df with the melted frame.
    merged_df = melted_df.merge(self.df, 
      on = ['pos', 'vul', 'bin'], 
      how ='left')

    # Multiply 'hist_value' by 'sigmoid' to get the result for each row
    merged_df['result'] = merged_df['hist_value'] * merged_df['sigmoid']

    # Add them up.  For each (pos, vul, dno) we now have a result.
    sum_var_no_df = merged_df.groupby(['dno']).agg({'result': 'sum'})

    prediction = \
      sum_var_no_df['result'].reindex(range(num_vars), fill_value = 0) \
      .values

    # Same for the derivative.
    merged_df['derivative'] = \
      merged_df['hist_value'] * merged_df['deriv']

    # Add up the derivatives for (pos, vul, dno).
    gradient_df = merged_df \
      .groupby(['pos', 'vul', 'dno']) \
      .agg({'derivative': 'sum', 'result': 'sum'})

    remerged_df = gradient_df.merge(actual_df.reset_index(),
      on = ['pos', 'vul', 'dno'], 
      how ='left')

    # Explanation of polarity: Let's say 'result' is 100 and 'pass' is 80.
    # There are more predicted than actual passes.  Therefore if we 
    # increase the value of the corresponding value, we move further to
    # the right on the sigmoid which decreases the prediction and brings
    # it closer to the actual value.  
    # The LP optimization is a minimization.  Therefore inreasing the
    # variable should make the LP objective function more negative.
    # Therefore the gradient should be negative.
    # But the actual sigmoid gradient is always negative, so we
    # make the sign positive in this case.

    remerged_df['sign'] = \
      np.sign(remerged_df['result'] - remerged_df['pass'])

    remerged_df['gradient'] = remerged_df['sign'] * \
      remerged_df['derivative']

    # Add them up.  For each (pos, vul, dno) we now have a result.
    gradient_df = remerged_df.groupby(['dno']).agg({'gradient': 'sum'})

    gradient = \
      gradient_df['gradient'].reindex(range(num_vars), fill_value = 0) \
      .values

    return prediction, gradient

  
  def extract_vectors(self, grouped_df):
    '''Extracts vectors for a given pos, vul grouping.'''
    df = grouped_df.groupby('bin').agg(
      pass_count = ('pass', 'sum'),
      total_count = ('pass', 'size')).reset_index()

    x_data = df['bin'].values / 100.
    sigma = (1 / df['total_count']).values
    y_data = (df['pass_count'] / df['total_count']).values

    return x_data, sigma, y_data


  def fit_data(self, df):
    '''Fits the sigmoids to a dataframe with pos, vul, bin and pass.'''
    results = df.groupby(['pos', 'vul']).apply(self.extract_vectors)

    for (pos, vul), (x_data, sigma, y_data) in results.items():
      self.sigmoids[pos][vul].fit_data(x_data, sigma, y_data)
  

  def str(self):
    '''Returns a string of the sigmoid parameters.'''
    s = "{:>6s}".format("pos") + \
      "{:>6s}".format("vul") + \
      self.sigmoids[0][0].str_header() + "\n"

    for pos in range(NUM_POS):
      for vul in range(NUM_VUL):
        s += "{:6d}".format(pos) + "{:6d}".format(vul) + \
          self.sigmoids[pos][vul].str() + "\n"

    return s
        
