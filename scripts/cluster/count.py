import pandas as pd
import numpy as np
import time

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables


# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])


# 0: all 16 combinations of pos and vul.
# 1: only fourth position, all vul.
# 2: only first through third position, all vul.
# 3: only third position, all vuls.
# 4: only first-second position
mode = 1


if (mode == 0):
  sigmoids.init(NUM_POS)
elif (mode == 1):
  # Keep only rows where pos is 3.
  df = df[df['pos'] == 3]

  # Relabel the 'pos' values from 3 to 0.
  df['pos'] = 0
elif (mode == 2):
  # Delete all rows where pos is 3.
  df = df[df['pos'] != 3]
elif (mode == 3):
  # Keep only rows where pos is 2.
  df = df[df['pos'] == 2]

  # Relabel the 'pos' values from 2 to 0.
  df['pos'] = 0
elif (mode == 4):
  # Delete all rows where pos is 3.
  df = df[df['pos'] != 3]

  # Delete all rows where pos is 2.
  df = df[df['pos'] != 2]
else:
  assert(False)


df_melted = df.melt(\
  id_vars = ['pos', 'vul', 'pass', 'dno'], \
  value_vars = ['sno1', 'sno2', 'sno3', 'sno4'], \
  value_name = 'sno')

suit_index = pd.RangeIndex(start=0, stop=NUM_SUITS)
dist_index = pd.RangeIndex(start=0, stop=NUM_DIST)

sno_histogram = df_melted['sno'].value_counts().sort_index()
sno_histogram = sno_histogram.reindex(suit_index, fill_value=0)
sno_array = sno_histogram.values

dno_histogram = df_melted['dno'].value_counts().sort_index()
dno_histogram = dno_histogram.reindex(dist_index, fill_value=0)
dno_array = dno_histogram.values

var = Variables()
var.concatenate(sno_array, dno_array/4)

print(var.str_simple(suit_info, dist_info))

