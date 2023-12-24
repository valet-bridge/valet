# SUITDATA_FILE = "suitdata100.csv"
SUITDATA_FILE = "labels/original/passes.csv"
OPENING_FILE = "labels/original/detail.csv"

BRIDGE_TRICKS = 13
NUM_POS = 4
NUM_VUL = 4

NUM_TOPS = 6

NUM_DIST = 560
NUM_SUITS = 512
NUM_VAR = NUM_DIST + NUM_SUITS

MAX_STRENGTH = 30
STRENGTH_STEP = 0.01
NUM_STRENGTH_STEPS = int(MAX_STRENGTH / STRENGTH_STEP)

SUIT_EQUIV_FILE = "fit/suit_equiv.txt"
DIST_EQUIV_FILE = "fit/dist_equiv.txt"

SUIT_SKIP_FILE = "out/suit_skip.txt"
DIST_SKIP_FILE = "out/dist_skip.txt"

SUIT_VALUE_FILE = "fit/suit_map.txt"
