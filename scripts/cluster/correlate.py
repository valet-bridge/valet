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
  ['pos', 'vul', 'sno']).agg({'pass' : 'sum'}).unstack(fill_value = 0)

# Here we must re-index as some of the NUM_SUITS options may be missing.
df_sno = df_melted.groupby('sno').agg({'pass': 'sum'}).reindex( \
  np.arange(NUM_SUITS), fill_value = 0)

# Count the number of chances to pass by (pos, vul, sno).
hist_pos_vul_sno = df_melted.groupby(['pos', 'vul', 'sno']).size()

# Call it dno as Sigmoids expects this column name in both cases.
hist_pos_vul_sno.index.rename(names = {'sno': 'dno'}, inplace = True)

# The passes as numpy
passes_pos_vul_sno = df_pos_vul_sno.values
passes_sno = df_sno['pass'].values


# Count the actual passes by (pos, vul, dno) and only by dno.
# We start from df, not from df_melted, as df_melted has the same dno
# appearing four times (once for sno1..sno4).
df_pos_vul_dno = df.groupby( \
  ['pos', 'vul', 'dno']).agg({'pass' : 'sum'}).unstack(fill_value = 0)

# Here we must re-index as some of the NUM_DIST options may be missing.
df_dno = df.groupby('dno').agg({'pass': 'sum'}).reindex( \
  np.arange(NUM_DIST), fill_value = 0)

# Count the number of chances to pass by (pos, vul, dno).
hist_pos_vul_dno = df.groupby(['pos', 'vul', 'dno']).size()

# The passes as numpy
passes_pos_vul_dno = df_pos_vul_dno.values
passes_dno = df_dno['pass'].values




sno_melted = df.melt(id_vars=['pos', 'vul', 'pass', 'bin'], value_vars=['sno1', 'sno2', 'sno3', 'sno4'])


# Make a histogram of binned strength for each (pos, vul, value).
# hist_dno = df.groupby(['pos', 'vul', 'dno', 'bin']).size().unstack(fill_value=0)
hist_dno = df.pivot_table(index=['pos', 'vul', 'dno'], 
                          columns='bin', 
                          aggfunc='size', 
                          fill_value=0).reset_index()

hist_sno = sno_melted.groupby(['pos', 'vul', 'value', 'bin']).size().unstack(fill_value=0).groupby(level=[0, 1, 2]).sum()
hist_sno_reset = hist_sno.reset_index()
# Easier to call it dno
hist_sno_reset = hist_sno_reset.rename(columns={'value': 'dno'})



# Calculate all sigmoid values that occur in binned histograms.
sigmoids = Sigmoids()

bin_midpoints = (bins[:-1] + bins[1:]) / 2
sigmoids.calc(bin_midpoints)

# Predict the absolute number of passes for each variable number.
# The results are numpy 1D arrays.
results_dno = sigmoids.hist_to_prediction(hist_dno, NUM_DIST)
results_sno = sigmoids.hist_to_prediction(hist_sno_reset, NUM_SUITS)


predictions = Variables()
predictions.concatenate(results_sno, results_dno)
print(predictions.str(suit_info, dist_info, \
  passes_sno, passes_dno))

# This is how to fit and print sigmoids.
# sigmoids.fit_data(df)
# print(sigmoids.str())
# quit()

# So it seems we can calculate the number of passes from sigmoids.
# We need the sign vector.  And then we need to calculate the gradients
# by histograms similar to above.  This then gives us the c vector
# for the LP problem.
# In the case of box constraints, no lower limit of 0 on the
# values? Keep moving the boxes, recalculating the gradients, until
# the solution is interiot with respect to the box constraints.
# Then make the numpy arrays for adjusting the sigmoid parameters.
# Probably need to update the strengths in df before adjusting.
