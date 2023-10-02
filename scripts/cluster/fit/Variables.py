import pandas as pd
import numpy as np

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo

class Variables:
  '''Can be used e.g. for the 512 + 560 variables in a solution.'''

  def __init__(self):
    self.data = np.zeros(NUM_VAR)


  def init_by_hcp(self, suit_info, dist_info):
    '''Initialize with standard HCP and distribution points.'''
    for sno in range(NUM_SUITS):
      self.data[sno] = suit_info.get(sno)['hcp']
    for dno in range(NUM_DIST):
      self.data[NUM_SUITS + dno] = dist_info.get(dno)['hcp']


  def add_strengths(self, bins, df):
    '''Use data and bins to add exact and binned strength to df.'''
    suit_indices = np.arange(0, NUM_SUITS)
    dist_indices = np.arange(0, NUM_DIST)

    # Based on the current "solution", set up some lookup tables in order
    # to be able to make a sum column.
    lookup_suit = self.data[:NUM_SUITS]
    lookup_dist = self.data[NUM_SUITS:]

    lookup = {
      'dno': pd.Series(lookup_dist, index = dist_indices),
      'sno1': pd.Series(lookup_suit, index = suit_indices),
      'sno2': pd.Series(lookup_suit, index = suit_indices),
      'sno3': pd.Series(lookup_suit, index = suit_indices),
      'sno4': pd.Series(lookup_suit, index = suit_indices)
    }

    df['sum'] = 0
    for field in ['dno', 'sno1', 'sno2', 'sno3', 'sno4']:
      df['sum'] += df[field].map(lookup[field])

    # Discretize the sum column
    df['bin'] = pd.cut(df['sum'], bins = bins, include_lowest = True, \
      right = False, labels = False)

  
  def set_box_constraints(self, step_size):
    '''Set bounds to +/- step_size around variables.'''

    # In case we want >= 0 as well.
    # lower = np.maximum(self.data - step_size, 0)
    return list(zip(self.data - step_size, self.data + step_size))

  
  def concatenate(self, suit_variables, dist_variables):
    assert self.data.shape[0] == \
      suit_variables.shape[0] + dist_variables.shape[0]
    self.data[:NUM_SUITS] = suit_variables
    self.data[NUM_SUITS:] = dist_variables


  def str(self, suit_info, dist_info, pass_suit_counts, pass_dist_counts):
    s = dist_info.str_with_variables_passes(self.data, pass_dist_counts)
    s += "\n"
    s += suit_info.str_with_variables_passes(self.data, pass_suit_counts)
    
    return s


  def str_simple(self, suit_info, dist_info):
    s = dist_info.str_with_variables(self.data) + "\n" + \
      suit_info.str_with_variables(self.data)
    
    return s


