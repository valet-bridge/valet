import pandas as pd
import numpy as np
from sklearn.cluster import Birch


def get_data(filename):
  """Reads in the basic data."""
  full = pd.read_csv(filename, delimiter = ',', header=None)

  # Drop the first entry indicating where the hand came from.
  hands = full[full.columns[1:]].to_numpy()
  print(hands.shape)
  return full, hands


full, hands = get_data('learn.txt')

model = Birch(threshold = 0.5, branching_factor = 50, n_clusters = None)

model.fit(hands)

pred = model.predict(hands)
print(pred)
