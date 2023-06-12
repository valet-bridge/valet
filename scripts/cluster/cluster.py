import pandas as pd
import numpy as np
from sklearn.cluster import Birch

from Args import Args
from Diagrams import Diagrams
from Tableaux import Tableaux
from Profiles import Profiles


# from PBN import PBN


# Get the command-line arguments.
args = Args()
train, validate, test = args.parse()

diagrams = Diagrams()
diagrams.read(train)

tableaux = Tableaux()
tableaux.read(train)

profiles = Profiles()
profiles.read(train)

profiles.passout(diagrams, tableaux)

# profiles.passout_occasional(diagrams, tableaux)

# tag = "4|1|1"
# print(diagrams.str(tag))

# print(profiles.str("4|1|1"))

# model = Birch(threshold = 0.5, branching_factor = 50, n_clusters = None)

# hands is a numpy array
# model.fit(hands)

# pred = model.predict(hands)
# print(pred)

# p = "N:KJT6.K875.832.Q2 A43.JT42.AKQ9.AJ Q72.6.654.KT7654 985.AQ93.JT7.983"
# pbn = PBN()
# print(pbn.pbn_to_text(p))

# print(sets.rounds(4))

