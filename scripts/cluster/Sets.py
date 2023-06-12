import pandas as pd
import numpy as np
import glob

class Sets:
  # Directories containing tournament results.
  DATASETS = "datasets"
  DATADIR = "data"

  def __init__(self):
    df = pd.read_csv(self.DATASETS, delimiter = ',', header = None)
    assert df.shape[1] == 2
    self.sets = np.zeros(df.shape[0], dtype = 'object')

    for index, row in df.iterrows():
      self.sets[row[0]] = row[1]


  def name(self, number):
    '''Turn 1 into "data/2006-Euro".'''
    assert number >= 0 and number < len(self.sets)
    return self.DATADIR + "/" + self.sets[number]

  
  def rounds(self, number):
    '''Return a list of round files in the numbered directory.'''
    assert number >= 0 and number < len(self.sets)
    return glob.glob(self.name(number) + "/" + "round*.pbn")

