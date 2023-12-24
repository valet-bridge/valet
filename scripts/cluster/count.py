import pandas as pd
import numpy as np
import time

from fit.FitArgs import FitArgs
from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables

fit_args = FitArgs()
pos_list, vul_list = fit_args.parse()


# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'open', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])


# Limit df to the positions and vulnerabilities from the command line.
df = df[df['pos'].isin(pos_list)]
df = df[df['vul'].isin(vul_list)]

# Only keep rows with the corresponding pos and vul values.
map_pos = {old: new for new, old in enumerate(pos_list)}
map_vul = {old: new for new, old in enumerate(vul_list)}
df['pos'] = df['pos'].replace(map_pos)
df['vul'] = df['vul'].replace(map_vul)


df_melted = df.melt(\
  id_vars = ['pos', 'vul', 'open', 'dno'], \
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

