import pandas as pd
import numpy as np
import itertools
from itertools import chain

from fit.fitconst import *
from fit.SuitInfo import SuitInfo
from fit.DistInfo import DistInfo
from fit.Variables import Variables
from fit.Sigmoids import Sigmoids
from fit.LPsolver import LPsolver
from passes.Sigmoid import Sigmoid


# Set up some data-independent tables.
suit_info = SuitInfo()
dist_info = DistInfo()

# Initialize the solution with standard HCP and distribution points.
solution = Variables()
solution.init_by_hcp(suit_info, dist_info)

# Set up the constraints of the linearized LP problem.
lp_solver = LPsolver()
lp_solver.set_constraints(suit_info, solution, 0.01)

# Read in the data of hands.
df = pd.read_csv(SUITDATA_FILE, header = None, \
  names = ['tag', 'pos', 'vul', 'pass', 'dno', \
  'sno1', 'sno2', 'sno3', 'sno4'])

# Strength is 0..100 in 0.01 steps.
bins = np.arange(0, MAX_STRENGTH, STRENGTH_STEP)

# Add sum and bin columns to df based on dno, sno1 .. sno4.
solution.add_strengths(bins, df)

# Melt the sno1..sno4 fields into a single sno field.
df_melted = df.melt(\
  id_vars = ['pos', 'vul', 'pass', 'dno', 'bin'], \
  value_vars = ['sno1', 'sno2', 'sno3', 'sno4'], \
  value_name = 'sno')


# Count the actual passes by (pos, vul, sno) and only by sno.
df_pos_vul_sno = df_melted.groupby( \
  ['pos', 'vul', 'sno']).agg({'pass' : 'sum'})

# Rename from sno to dno to fit with Sigmoids (hist_to_prediction).
df_pos_vul_sno.index.names = ['pos', 'vul', 'dno']

# Here we must re-index as some of the NUM_SUITS options may be missing.
df_sno = df_melted.groupby('sno').agg({'pass': 'sum'}).reindex( \
  np.arange(NUM_SUITS), fill_value = 0)

# Count the number of chances to pass by (pos, vul, sno).
hist_pos_vul_sno = df_melted.groupby(['pos', 'vul', 'sno']).size()

# Call it dno as Sigmoids expects this column name in both cases.
hist_pos_vul_sno.index.rename(names = {'sno': 'dno'}, inplace = True)

# The passes as numpy
passes_pos_vul_sno = df_pos_vul_sno.unstack(fill_value = 0).values
passes_sno = df_sno['pass'].values


# Count the actual passes by (pos, vul, dno) and only by dno.
# We start from df, not from df_melted, as df_melted has the same dno
# appearing four times (once for sno1..sno4).
df_pos_vul_dno = df.groupby( \
  ['pos', 'vul', 'dno']).agg({'pass' : 'sum'})

# Here we must re-index as some of the NUM_DIST options may be missing.
df_dno = df.groupby('dno').agg({'pass': 'sum'}).reindex( \
  np.arange(NUM_DIST), fill_value = 0)

# Count the number of chances to pass by (pos, vul, dno).
hist_pos_vul_dno = df.groupby(['pos', 'vul', 'dno']).size()

# The passes as numpy
passes_pos_vul_dno = df_pos_vul_dno.unstack(fill_value = 0).values
passes_dno = df_dno['pass'].values


# Make histograms of binned strength for each (pos, vul, value).
hist_dno = df.pivot_table( \
  index = ['pos', 'vul', 'dno'], \
  columns = 'bin', \
  aggfunc = 'size', \
  fill_value = 0).reset_index()

hist_sno = df_melted.pivot_table( \
  index = ['pos', 'vul', 'sno'], \
  columns = 'bin', \
  aggfunc = 'size', \
  fill_value = 0).reset_index()

hist_sno.rename(columns = {'sno': 'dno'}, inplace = True)


# Calculate all sigmoid values that occur in binned histograms.
sigmoids = Sigmoids()

# Fit the sigmoids.
sigmoids.fit_data(df)
# print(sigmoids.str())

bin_midpoints = (bins[:-1] + bins[1:]) / 2
sigmoids.calc(bin_midpoints)

# Predict the absolute number of passes for each variable number.
# The results are numpy 1D arrays.
results_dno, gradient_dno = \
  sigmoids.hist_to_prediction(hist_dno, df_pos_vul_dno, NUM_DIST)
results_sno, gradient_sno = \
  sigmoids.hist_to_prediction(hist_sno, df_pos_vul_sno, NUM_SUITS)


predictions = Variables()
predictions.concatenate(results_sno, results_dno)
print(predictions.str(suit_info, dist_info, \
  passes_sno, passes_dno))

gradients = Variables()
gradients.concatenate(gradient_sno, gradient_dno)
print(gradients.str(suit_info, dist_info, \
  passes_sno, passes_dno))

# This is how to fit and print sigmoids.
# sigmoids.fit_data(df)
# print(sigmoids.str())
# quit()

'''
do
  First fit sigmoids to our 10-HCP starting point.

  Then an LP fit:
  do
    calculate the gradient around the current solution
    set up the c vector in the LP problem
    solve with +/- 0.01 around the current solution
  until the solution is interior w.r.t. the box bounds

until the LP didn't change anything (much?)

Maybe sigma in the curve_fit is more like sqrt(n) than n?

'''

