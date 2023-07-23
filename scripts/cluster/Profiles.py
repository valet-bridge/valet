import pandas as pd
import numpy as np
from enum import Enum

from Sets import Sets
from Valuation import Valuation
from PBN import PBN
from Distributions import (DISTRIBUTIONS, Distribution)
from passes.Table import Table

class Profiles:
  # Reads the percentage vectors for a directory.
  PROFILE = "learn.txt"

  BRIDGE_PLAYERS = 4
  BRIDGE_SUITS = 4
  PLAYER_NUMBERS_SHORT = {"N": 0, "E": 1, "S": 2, "W": 3}

  class Vtypes(Enum):
    WE_PARTIAL_UNDOUBLED = 0
    WE_PARTIAL_DOUBLED_NOT_GAME = 1
    WE_PARTIAL_DOUBLED_GAME = 2
    WE_PARTIAL_REDOUBLED_NOT_GAME = 3
    WE_PARTIAL_REDOUBLED_GAME = 4
    WE_GAME_UNDOUBLED = 5
    WE_GAME_DOUBLED = 6
    WE_GAME_REDOUBLED = 7
    WE_SMALL_SMALL_UNDOUBLED = 8
    WE_SMALL_SLAM_DOUBLED = 9
    WE_SMALL_SLAM_REDOUBLED = 10
    WE_GRAND_SLAM__UNDOUBLED = 11
    WE_GRAND_SLAM_DOUBLED = 12
    WE_GRAND_SLAM_REDOUBLED = 13
    THEY_PARTIAL_UNDOUBLED = 14
    THEY_PARTIAL_DOUBLED_NOT_GAME = 15
    THEY_PARTIAL_DOUBLED_GAME = 16
    THEY_PARTIAL_REDOUBLED_NOT_GAME = 17
    THEY_PARTIAL_REDOUBLED_GAME = 18
    THEY_GAME_UNDOUBLED = 19
    THEY_GAME_DOUBLED = 20
    THEY_GAME_REDOUBLED = 21
    THEY_SMALL_SMALL_UNDOUBLED = 22
    THEY_SMALL_SLAM_DOUBLED = 23
    THEY_SMALL_SLAM_REDOUBLED = 24
    THEY_GRAND_SLAM__UNDOUBLED = 25
    THEY_GRAND_SLAM_DOUBLED = 26
    THEY_GRAND_SLAM_REDOUBLED = 27
    PASSED_OUT = 28
  
  Vnames = [
    "We partial",
    "We partial doubled",
    "We partial doubled into game",
    "We partial redoubled",
    "We partial redoubled into game",
    "We game",
    "We game doubled",
    "We game redoubled",
    "We small slam",
    "We small slam doubled",
    "We small slam redoubled",
    "We grand slam",
    "We grand slam doubled",
    "We grand slam redoubled",
    "They partial",
    "They partial doubled",
    "They partial doubled into game",
    "They partial redoubled",
    "They partial redoubled into game",
    "They game",
    "They game doubled",
    "They game redoubled",
    "They small slam",
    "They small slam doubled",
    "They small slam redoubled",
    "They grand slam",
    "They grand slam doubled",
    "They grand slam redoubled",
    "Passed out"
    ]

  PASSOUT = [
    # P   Px  PxG Pr  PrG G   Gx  Gxx s   sx  sxx S   Sx  Sxx
    0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    1 ]

  PASSOUT_OCCASIONAL = [
    # P   Px  PxG Pr  PrG G   Gx  Gxx s   sx  sxx S   Sx  Sxx
    0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    1 ]


  def __init__(self):
    self.profiles = {}
    self.seen = {}


  def read(self,  number_list):
    '''Read all diagram files in the directories of the number_list.'''
    sets = Sets()
    for no in number_list:
      fname = sets.name(no) + "/" + self.PROFILE
      full = pd.read_csv(fname, delimiter = ',', header = None)

      # The first entry is the round|board tag.
      board_tags = full[full.columns[0]].to_numpy()
      vectors = full[full.columns[1:]].to_numpy()

      for i in range(board_tags.shape[0]):
        tag = str(no) + "|" + board_tags[i]
        self.profiles[tag] = vectors[i]

  
  def passout(self, diagrams, tableaux):
    '''Filter out some hands that tend to get passed out.'''

    table = Table()
    table.read_file("test.txt")
    print("TABLE\n")
    print(table.str())
    print("ENDTABLE\n")

    pbn = PBN()
    valuation = Valuation()
    for tag, profile in self.profiles.items():
      if tag in self.seen:
        continue

      sum = 0.
      for vtype in self.Vtypes:
        k = vtype.value
        sum += self.PASSOUT[k] * profile[k]
      
      # TODO Can vary:
      if sum > 0.0:
        # print("hand", suits[0])
        # print(valuation.str(1))

        # print(diagrams.str(tag))
        # print(pbn.strHCP(diagrams.lookup(tag)))
        # print(tableaux.lookup(tag))
        # print(self.str(tag))
        print(self.strCSV(tableaux, diagrams, pbn, valuation, tag, sum))
        self.seen[tag] = 1


  def passout_occasional(self, diagrams, tableaux):
    '''Filter out some hands that get passed out occasionally.'''
    for tag, profile in self.profiles.items():
      if tag in self.seen:
        continue

      sum = 0.
      for vtype in self.Vtypes:
        k = vtype.value
        sum += self.PASSOUT_OCCASIONAL[k] * profile[k]
      
      if sum > 0:
        # print("tag")
        # print(tag)
        print(diagrams.str(tag))
        print(tableaux.lookup(tag))
        print(self.str(tag))
        self.seen[tag] = 1


  def lookup(self, tag):
    '''Look up the profile corresponding to the tag which must exist.'''
    assert tag in self.profiles
    return self.profiles[tag]


  def str(self, tag):
    '''Return the profile as a string.'''
    assert tag in self.profiles
    s = ""
    for vtype in self.Vtypes:
      k = vtype.value
      n = self.profiles[tag][k]
      if n:
        s += "%5.2f%% %-20s\n" % (100. * n, self.Vnames[k])

    return s

  
  def strCSV(self, tableaux, diagrams, pbn, valuation, tag, pass_fraction):
    '''Make a string suitable for an overall CSV line.'''
    assert tag in self.profiles

    suits = [["" for p in range(self.BRIDGE_PLAYERS)]
      for s in range(self.BRIDGE_SUITS)]

    pbn.pbn_to_suits(diagrams.lookup(tag)["pbn"], suits)

    holdings = [["" for p in range(self.BRIDGE_PLAYERS)]
      for s in range(self.BRIDGE_SUITS)]

    pbn.suits_to_holdings(suits, holdings)

    dealer_index = self.PLAYER_NUMBERS_SHORT[diagrams.lookup(tag)["dealer"]]

    s = tag + "," + diagrams.strCSV(pbn, suits, tag) + \
      valuation.strCSV(holdings, dealer_index, 1) + \
      tableaux.str_pass_CSV(tag, pass_fraction)

    return s

