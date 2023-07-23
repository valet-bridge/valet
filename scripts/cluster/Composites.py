from enum import Enum

class COMPOSITE_PARAMS(Enum):
  COMP_HCP = 0
  COMP_AHCP = 1
  COMP_CCCC = 2
  COMP_ZP = 3
  COMP_FL = 4
  COMP_CONTROLS = 5
  COMP_PLAY_TRICKS = 6
  COMP_QUICK_TRICKS = 7
  COMP_LOSERS = 8
  COMP_OUTTOPS1 = 9
  COMP_OUTTOPS2 = 10
  COMP_OUTTOPS3 = 11
  COMP_OUTTOPS4 = 12
  COMP_OUTTOPS5 = 13
  COMP_BAL = 14
  COMP_UNBAL = 15
  COMP_SBAL = 16
  COMP_UNSBAL = 17
  COMP_EFF_MDIFF = 18
  COMP_EFF_MABSDIFF = 19
  COMP_EFF_MMAX = 20
  COMP_EFF_MMIN = 21
  COMP_EFF_mMAX = 22
  COMP_EFF_mMIN = 23
  COMP_EFF_L1 = 24
  COMP_EFF_L2 = 25
  COMP_EFF_L3 = 26
  COMP_EFF_L4 = 27
  COMP_MCONC = 28
  COMP_TWOCONC = 29
  COMP_SIZE = 30

COMPOSITE_PARAMS_NAMES = [
  "HCP", "Adjusted HCP", "CCCC points", "Zar points", "FL points",
  "Controls", "Play tricks", "Quick tricks", "Losers",
  "Outside tops1", "Outside tops2", "Outside tops3",
  "Outside tops4", "Outside tops5",
  "Balanced", "Unbalanced", "Semi-balanced", "Not semi-BAL",
  "Eff. S-H", "Eff. abs(S-H)", "Eff. max(S,H)", "Eff. min(S,H)",
  "Eff. max(D,C)", "Eff. min(D,C)",
  "Eff. 1st len", "Eff. 2nd len", "Eff. 3rd len", "Eff. 4th len",
  "Major conc.", "Top-2 conc." ]

COMPOSITE_PARAMS_TAGS = [
  "HCP", "AHCP", "CCCC", "ZP", "FL",
  "Controls", "Playtricks", "Quicktricks", "Losers",
  "Outtops1", "Outtops2", "Outtops3", "Outtops4", "Outtops5",
  "BAL", "UNBAL", "SBAL", "notSBAL",
  "EffSH", "EffSHdiff", "EffSHmax", "EffSHmin",
  "EffDCmax", "EffDCmin",
  "Eff1", "Eff2", "Eff3", "Eff4", "Mconc", "Top2conc" ]

COMPOSITE_PARAMS_LOOKUP = {}
for i in range(len(COMPOSITE_PARAMS_NAMES)):
  COMPOSITE_PARAMS_LOOKUP[COMPOSITE_PARAMS_TAGS[i]] = i

COMPOSITE_PARAMS_SCALES = [
  1, 1, 20, 1, 1,
  1, 2, 2, 2,
  1, 1, 1, 1, 1,
  1, 1, 1, 1,
  2, 2, 2, 2, 2, 2,
  2, 2, 2, 2,
  1, 1 ]

