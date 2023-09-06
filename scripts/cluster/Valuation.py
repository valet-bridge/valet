import sys

from enum import Enum
from Composites import (COMPOSITE_PARAMS, COMPOSITE_PARAMS_NAMES, COMPOSITE_PARAMS_SCALES)

# This is more or less a port of the Valuation.cpp in my Build repo.
# See more comments there.

class Valuation:
  # DDS encoding, but without the two bottom 00 bits: ((2 << 13) - 1).
  BRIDGE_TRICKS = 13
  BRIDGE_SUITS = 4
  MAX_HOLDING = 0x2000
  SEP = ','

  POWER = [4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1]
  BITS = [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

  VALUATION_NUM_DISTS = 560

  CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
  TEXTS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  HCP   = [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,   0 ,  1 ,  2 ,  3 ,  4]
  SUIT_NAMES = ["S", "H", "D", "C", "N"]

  class SUITS(Enum):
    BRIDGE_SPADES = 0
    BRIDGE_HEARTS = 1
    BRIDGE_DIAMONDS = 2
    BRIDGE_CLUBS = 3

  class SUIT_PARAMS(Enum):
    SUIT_HCP = 0
    SUIT_AHCP = 1
    SUIT_CCCC = 2
    SUIT_ZP = 3
    SUIT_FL = 4
    SUIT_CONTROLS = 5
    SUIT_PLAY_TRICKS = 6
    SUIT_QUICK_TRICKS = 7
    SUIT_LOSERS = 8
    SUIT_TOP1 = 9
    SUIT_TOP2 = 10
    SUIT_TOP3 = 11
    SUIT_TOP4 = 12
    SUIT_TOP5 = 13
    SUIT_LENGTH = 14
    SUIT_EFF_LENGTH = 15
    SUIT_SPOT_SUM = 16
    SUIT_SPOT_SUM3 = 17
    SUIT_SIZE = 18

  SUIT_PARAMS_NAMES = [
    "HCP", "Adjusted HCP", "CCCC comp.", "Zar comp.", "FL points",
    "Controls", "Play tricks", "Quick tricks", "Losers",
    "Aces", "AK's", "AKQ's", "AKQJ's", "AKQJT's",
    "Length", "Eff. length",
    "Spot sum", "Top-3 spot sum" ]

  SUIT_PARAMS_SCALES = [
    1, 1, 20, 1, 1,
    1, 2, 2, 2,
    1, 1, 1, 1, 1,
    1, 2,
    1, 1 ]
  
  class DIST_PARAMS(Enum):
    DIST_MDIFF = 0
    DIST_MABSDIFF = 1
    DIST_MMAX = 2
    DIST_MMIN = 3
    DIST_mMAX = 4
    DIST_mMIN = 5
    DIST_MPROD = 6
    DIST_PROD = 7
    DIST_L1 = 8
    DIST_L2 = 9
    DIST_L3 = 10
    DIST_L4 = 11
    DIST_VOID = 12
    DIST_LONGEST1 = 13
    DIST_LONGEST2 = 14
    DIST_SHORTEST = 15
    DIST_BAL = 16
    DIST_SBAL = 17
    DIST_ZP = 18
    DIST_SIZE = 19

  DIST_PARAMS_NAMES = [
    "S minus H", "Abs(S-H)", "Max(S,H)", "Min(S,H)", 
    "Max(D,C)", "Min(D,C)", "S * H", "S * H * D * C",
    "Max. length", "2nd length", "3rd length", "Min. length",
    "Void flag", "Longest suit", "2nd longest", "Shortest",
    "Balanced", "Semi-balanced", "Zar" ]
  
  DIST_PARAMS_SCALES = [
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1 ]
  
  SUIT_TO_HCP = {}
  TEXT_TO_HOLDING = {}
  HOLDING_TO_TEXT = []


  def __init__(self):
    '''Set all the look-up tables. Expensive, so keep alive if possible.'''
    self.HOLDING_TO_TEXT = [None] * self.MAX_HOLDING

    self.SUIT_LIST = [[0] * self.SUIT_PARAMS.SUIT_SIZE.value \
      for x in range(self.MAX_HOLDING)]
    self.DIST_LIST = [dict() for x in range(self.VALUATION_NUM_DISTS)]
    self.DIST_CODE_TO_NUMBER = [None] * 65536

    self.suit_values = [[0] * self.SUIT_PARAMS.SUIT_SIZE.value
      for x in range(self.BRIDGE_SUITS)]

    self.dist_values = [[0] * self.DIST_PARAMS.DIST_SIZE.value
      for x in range(self.BRIDGE_SUITS)]

    self.comp_values = [0] * COMPOSITE_PARAMS.COMP_SIZE.value

    self.set_text_tables()
    self.set_suit_tables()
    self.set_dist_tables()
    return


  def set_text_tables(self):
    '''Set the translations from text to holdings.'''
    for h in range(self.MAX_HOLDING):
      suit = ""
      text = ""
      for bit in reversed(range(0, self.BRIDGE_TRICKS)):
        if (h & (1 << bit)):
          suit += self.CARDS[bit]
          text += self.TEXTS[bit] + " "
      
      self.HOLDING_TO_TEXT[h] = text
      self.TEXT_TO_HOLDING[suit] = h
      self.TEXT_TO_HOLDING[suit[::-1]] = h

    # Show a void explicitly.
    self.HOLDING_TO_TEXT[0] = "-"
    return
  

  def set_suit_tables(self):
    '''Set the suit tables.'''
    cards = [None] * (self.BRIDGE_TRICKS+1)
    for h in range(self.MAX_HOLDING):
      # Also sets SPOT_SUM and SPOT_SUM3.
      self.set_suit_length(cards, h)

      # Also sets AHCP.
      self.set_suit_HCP(cards, h)

      # Also sets controls.
      self.set_suit_tops(cards, h)

      # Needs tops and controls.
      self.set_suit_KnR(cards, h)

      self.set_suit_ZP(cards, h)
      self.set_suit_FL(h)
      self.set_suit_play_tricks(cards, h)
      self.set_suit_quick_tricks(cards, h)
      self.set_suit_losers(cards, h)

      # Uses a number of other entries, so comes late in the order.
      self.set_suit_eff_length(h)

    return
    

  def suit_order_data(self, s, h, d, c):
    '''Calculate data related to suit lengths.'''
    res = {}

    udict = { 
      self.SUITS.BRIDGE_SPADES.value: s,
      self.SUITS.BRIDGE_HEARTS.value: h,
      self.SUITS.BRIDGE_DIAMONDS.value: d,
      self.SUITS.BRIDGE_CLUBS.value: c }

    odist = {k: v for k, v in sorted(udict.items(), \
      key = lambda item: item[1], reverse = True)}

    olist = list(odist.values())

    res['L1'] = olist[0]
    res['L2'] = olist[1]
    res['L3'] = olist[2]
    res['L4'] = olist[3]

    klist = list(odist.keys())
    res['LONG1'] = klist[0]
    res['LONG2'] = klist[1]
    res['LONG3'] = klist[2]
    res['LONG4'] = klist[3]

    return res


  def set_dist_tables(self):
    '''Set the distribution-related tables.'''
    no = 0
    for s in range(self.BRIDGE_TRICKS + 1):
      for h in range(self.BRIDGE_TRICKS - s + 1):
        for d in range(self.BRIDGE_TRICKS - s - h + 1):
          c = self.BRIDGE_TRICKS - s - h - d
          dist_code = (s << 12) | (h << 8) | (d << 4) | c
          dlist = self.DIST_LIST[no]
          self.DIST_CODE_TO_NUMBER[dist_code] = no
          no += 1

          dlist[self.DIST_PARAMS.DIST_MDIFF.value] = s-h
          dlist[self.DIST_PARAMS.DIST_MABSDIFF.value] = abs(s-h)
          dlist[self.DIST_PARAMS.DIST_MMAX.value] = max(s, h)
          dlist[self.DIST_PARAMS.DIST_MMIN.value] = min(s, h)
          dlist[self.DIST_PARAMS.DIST_mMAX.value] = max(d, c)
          dlist[self.DIST_PARAMS.DIST_mMIN.value] = min(d, c)
          dlist[self.DIST_PARAMS.DIST_MPROD.value] = s*h
          dlist[self.DIST_PARAMS.DIST_PROD.value] = s*h*d*c

          res = self.suit_order_data(s, h, d, c)

          dlist[self.DIST_PARAMS.DIST_L1.value] = res['L1']
          dlist[self.DIST_PARAMS.DIST_L2.value] = res['L2']
          dlist[self.DIST_PARAMS.DIST_L3.value] = res['L3']
          dlist[self.DIST_PARAMS.DIST_L4.value] = res['L4']
          dlist[self.DIST_PARAMS.DIST_VOID.value] = 1 if res['L4'] == 0 else 0
          dlist[self.DIST_PARAMS.DIST_LONGEST1.value] = res['LONG1']
          dlist[self.DIST_PARAMS.DIST_LONGEST2.value] = res['LONG2']
          dlist[self.DIST_PARAMS.DIST_SHORTEST.value] = res['LONG4']

          # Don't set BAL and SBAL yet
          zp = self.DIST_PARAMS.DIST_ZP.value
          dlist[zp] = 2*dlist[self.DIST_PARAMS.DIST_L1.value] + \
            dlist[self.DIST_PARAMS.DIST_L2.value] - \
            dlist[self.DIST_PARAMS.DIST_L4.value]
          # 4-3-3-3 gets an extra Zar point
          if (dlist[self.DIST_PARAMS.DIST_L4.value] == 3):
            dlist[zp] += 1

    assert no == self.VALUATION_NUM_DISTS, "Bad number of distributions"
    return
  

  def set_suit_length(self, cards, holding):
    '''Set the tables related to suit lengths.'''
    hlist = self.SUIT_LIST[holding]
    hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] = 0
    hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] = 0
    hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM3.value] = 0

    for bit in range(self.BRIDGE_TRICKS):
      # cards[0] is 1 if we hold the ace, and so on.
      cards[bit] = (holding & self.POWER[bit]) >> self.BITS[bit]
      hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] += cards[bit]
    
      if (cards[bit]):
        hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] += \
          self.BRIDGE_TRICKS + 1 - bit
        if (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] <= 3):
          hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM3.value] += \
            self.BRIDGE_TRICKS + 1 - bit

    return
  

  def set_suit_HCP(self, cards, holding):
    '''Set the HCP.'''
    hlist = self.SUIT_LIST[holding]

    hcp = self.SUIT_PARAMS.SUIT_HCP.value
    hlist[hcp] = 0

    # 4-3-2-1.
    if (cards[0]): hlist[hcp] += 4
    if (cards[1]): hlist[hcp] += 3
    if (cards[2]): hlist[hcp] += 2
    if (cards[3]): hlist[hcp] += 1

    ahcp = self.SUIT_PARAMS.SUIT_AHCP.value
    hlist[ahcp] = hlist[hcp]

    if (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] == 1):
      # 4-2-1-0 for stiff honor.
      if (cards[1]): hlist[ahcp] -= 1
      if (cards[2]): hlist[ahcp] -= 1
      if (cards[3]): hlist[ahcp] -= 1

    return
  

  def set_suit_tops(self, cards, holding):
    '''Set the tops.'''
    hlist = self.SUIT_LIST[holding]
    hlist[self.SUIT_PARAMS.SUIT_TOP1.value] = cards[0]
    hlist[self.SUIT_PARAMS.SUIT_TOP2.value] = \
      hlist[self.SUIT_PARAMS.SUIT_TOP1.value] + cards[1]
    hlist[self.SUIT_PARAMS.SUIT_TOP3.value] = \
      hlist[self.SUIT_PARAMS.SUIT_TOP2.value] + cards[2]
    hlist[self.SUIT_PARAMS.SUIT_TOP4.value] = \
      hlist[self.SUIT_PARAMS.SUIT_TOP3.value] + cards[3]
    hlist[self.SUIT_PARAMS.SUIT_TOP5.value] = \
      hlist[self.SUIT_PARAMS.SUIT_TOP4.value] + cards[4]

    hlist[self.SUIT_PARAMS.SUIT_CONTROLS.value] = \
      hlist[self.SUIT_PARAMS.SUIT_TOP1.value] + \
      hlist[self.SUIT_PARAMS.SUIT_TOP2.value]
    return
  

  def set_suit_KnR(self, cards, holding):
    '''CCC by Kaplan and Rubens.'''
    hlist = self.SUIT_LIST[holding]

    cccc = self.SUIT_PARAMS.SUIT_CCCC.value
    length = self.SUIT_PARAMS.SUIT_LENGTH.value

    hlist[cccc] = 0

    # 3-2-1 points to begin with.  Scaled by 20 to get integer scores.
    hlist[cccc] += 60*cards[0] + 40*cards[1] + 20*cards[2]

    # 4-3-2-1 count * length / 10.
    adder = 2 * hlist[self.SUIT_PARAMS.SUIT_HCP.value]

    if (hlist[length] > 8):
      # +2 for no Q, +1 for no J, +0.5 for having the T.
      if (cards[2] == 0): adder += 4
      if (cards[3] == 0): adder += 2
      if (cards[4]): adder += 1
    elif (hlist[length] == 8):
      # +2 for no Q, +1 for Q without J, +0.5 for having the T.
      if (cards[2]):
        adder += 0 if cards[3] else 2
      else:
        adder += 4
      if (cards[4]):
        adder += 1
    elif (hlist[length] == 7):
      # +0.5 for lacking both Q and j, +0.5 for having the T.
      if (cards[2] == 0 and cards[3] == 0): adder += 1
      if (cards[4]): adder += 1
    else:
      # +1, plus +1 for the T with two+ higher or with the J.
      if (cards[4]):
        if (hlist[self.SUIT_PARAMS.SUIT_TOP3.value] >= 2 or cards[3]):
          adder += 2 
        else:
          adder += 1
      
      # +0.5 for the 9 with two+ higher, the T or the 8.
      if (cards[5]):
        if (hlist[self.SUIT_PARAMS.SUIT_TOP3.value] >= 2 and \
          (cards[4] or cards[6])): 
          adder += 1

    hlist[cccc] += adder * hlist[length]

    # +3 for void, +2 for singleton, +1 (in principle) for doubleton.
    if (hlist[length] < 3):
      hlist[cccc] += 20 * (3 - hlist[length])

    # Stiff king only counts 0.5, not 2.
    if (cards[1] and hlist[length] == 1):
      hlist[cccc] -= 30

    if (cards[2]):
      # Qxx counts 0.75, not 1.
      if (hlist[length] >= 3):
        if (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] == 0): 
          hlist[cccc] -= 5 
      elif (hlist[length] == 1):
        # Stiff Q doesn't count at all.
        hlist[cccc] -= 20
      else:
        # AQ or KQ counts 0.5, Qx 0.25.
        if hlist[self.SUIT_PARAMS.SUIT_TOP2.value]:
          hlist[cccc] -= 10 
        else:
          hlist[cccc] -= 15

    if (cards[3]):
      # J with two higher honors counts 0.5, with one, 0.235.
      if (hlist[self.SUIT_PARAMS.SUIT_TOP4.value] == 2):
        hlist[cccc] += 5
      else:
        if (hlist[self.SUIT_PARAMS.SUIT_TOP4.value] == 1 and cards[5]): 
          hlist[cccc] += 5 
    return

  
  def set_suit_ZP(self, cards, holding):
    '''The high-card component of Zar points.'''
    hlist = self.SUIT_LIST[holding]
    
    # For stiff honors, AHCP gets scored as 4-2-1-0.
    # We want to score ZP as 5-2-1-0, so we add one for the stiff ace.
    if (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] == 1):
      hlist[self.SUIT_PARAMS.SUIT_ZP.value] = \
        hlist[self.SUIT_PARAMS.SUIT_AHCP.value] + cards[0]
    else:
      hlist[self.SUIT_PARAMS.SUIT_ZP.value] = \
        hlist[self.SUIT_PARAMS.SUIT_HCP.value] + \
        hlist[self.SUIT_PARAMS.SUIT_CONTROLS.value]
    return


  def set_suit_FL(self, holding):
    '''Add length points for good, long suits.'''
    hlist = self.SUIT_LIST[holding]
    hlist[self.SUIT_PARAMS.SUIT_FL.value] = \
      hlist[self.SUIT_PARAMS.SUIT_HCP.value]

    if (hlist[self.SUIT_PARAMS.SUIT_HCP.value] >= 3 and \
      hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] >= 5):
      hlist[self.SUIT_PARAMS.SUIT_FL.value] += \
        hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] - 4
    return


  def set_suit_play_tricks(self, cards, holding):
    '''Set playing tricks per Pavlicek, scaled up by 2x.'''
    hlist = self.SUIT_LIST[holding]

    pt = self.SUIT_PARAMS.SUIT_PLAY_TRICKS.value
    length = self.SUIT_PARAMS.SUIT_LENGTH.value

    if (hlist[length] == 0):
      hlist[pt] = 0
    elif (hlist[length] == 1):
      if (cards[0]):
        hlist[pt] = 2
      elif (cards[1]):
        hlist[pt] = 1
      else:
        hlist[pt] = 0
    elif (hlist[length] == 2):
      if (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] == 2):
        # AK.
        hlist[pt] = 4
      elif (cards[0]):
        # AQ, AJ, Ax.
        if (hlist[self.SUIT_PARAMS.SUIT_TOP4.value]):
          hlist[pt] = 3 
        else:
          hlist[pt] = 2
      elif (cards[1]):
        # KQ, KJ, Kx.
        hlist[pt] = 2 if hlist[self.SUIT_PARAMS.SUIT_TOP4.value] else 1
      else:
        # Qx, xx.
        if cards[2]: 
          hlist[pt] = 1 
    elif (hlist[length] >= 11):
      hlist[pt] = 2 * (hlist[self.SUIT_PARAMS.SUIT_TOP1.value] + \
        hlist[length] - 1)
    elif (hlist[length] >= 9):
      hlist[pt] = 2 * (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] + \
        hlist[length] - 2)
    elif (hlist[self.SUIT_PARAMS.SUIT_TOP3.value] == 3):
      # AKQ.
      hlist[pt] = 2 * hlist[length]
    elif (hlist[self.SUIT_PARAMS.SUIT_TOP4.value] == 3):
      if (cards[0]):
        # AKJ, AQJ.
        hlist[pt] = 2 * hlist[length] - 1
      else:
        # KQJ.
        hlist[pt] = 2 * hlist[length] - 2
    elif (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] == 2):
      # AKx.
      hlist[pt] = 2 * hlist[length] - 2
    elif (hlist[self.SUIT_PARAMS.SUIT_TOP5.value] <= 1):
      if (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] == 1):
        # Axx, Kxx.
        hlist[pt] = 2 * hlist[length] - 4
      elif (cards[2]):
        # Qxx.
        hlist[pt] = 2 * hlist[length] - 5
      else:
        # Less.
        hlist[pt] = 2 * hlist[length] - 6
    elif (hlist[self.SUIT_PARAMS.SUIT_TOP2.value] == 0):
      if (hlist[self.SUIT_PARAMS.SUIT_TOP4.value] == 2):
        # QJx.
        hlist[pt] = 2 * hlist[length] - 4
      else:
        # QTx, JTx.
        hlist[pt] = 2 * hlist[length] - 5
    elif (cards[0] and cards[2] and cards[4]):
      # AQT.
      hlist[pt] = 2 * hlist[length] - 2
    else:
      # KJT, KQx, AQx, AJx.
      hlist[pt] = 2 * hlist[length] - 3
  
    if  (hlist[length] == 8 and \
      (hlist[self.SUIT_PARAMS.SUIT_TOP4.value] != 2 or \
        hlist[self.SUIT_PARAMS.SUIT_TOP2.value] != 0)):
      # Length 8, not QJx.
      hlist[pt] += 1

    return

  
  def set_suit_quick_tricks(self, cards, holding):
    '''Set quick tricks, scaled by 2x.'''
    hlist = self.SUIT_LIST[holding]

    q = self.SUIT_PARAMS.SUIT_QUICK_TRICKS.value
    length = self.SUIT_PARAMS.SUIT_LENGTH.value

    if (hlist[length] >= 9):
      # Nothing will cash on defense.
      hlist[q] = 0
    elif (hlist[length] >= 7):
      # Only the ace may cash.
      hlist[q] = 2 if cards[0] else 0
    elif (cards[0]):
      # AK = 2.0, AQ = 1.5, Ax = 1.0.
      if (cards[1]):
        hlist[q] = 4
      else:
        hlist[q] = 3 if cards[2] else 2
    elif (cards[1]):
      # KQ = 1.0, Kx = 0.5.
      hlist[q] = 2 if cards[2] else 1
    else:
      hlist[q] = 0
    return
      

  def set_suit_losers(self, cards, holding):
    '''Set suit losers, scaled by 2x.'''
    hlist = self.SUIT_LIST[holding]
    sl = self.SUIT_PARAMS.SUIT_LOSERS.value

    if (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] == 0):
      hlist[sl] = 0
    elif (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] == 1):
      # 1.0 except if we have the ace.
      hlist[sl] = 0 if cards[0] else 2
    elif (hlist[self.SUIT_PARAMS.SUIT_LENGTH.value] == 2):
      if (cards[0]):
        # AK is 0, AQ is 0.5, Ax is 1.
        if (cards[1]):
          hlist[sl] = 0
        else:
          hlist[sl] = 1 if cards[2] else 2
      elif (cards[1]):
        # KQ is 1, Kx is 1.5.
        hlist[sl] = 2 if cards[2] else 3
      else:
        # Qx or worse is 2.
        hlist[sl] = 4
    else:
      # Each missing top card is a loser.
      hlist[sl] = 2 * (3 - hlist[self.SUIT_PARAMS.SUIT_TOP3.value])

      if (cards[0] and cards[1] == 0 and cards[2] == 0 and 
        cards[3] and cards[4]):
        # AJT is only 1.
        hlist[sl] -= 2
      elif (cards[0] == 0 and cards[1] and cards[2] == 0 and
        cards[3] and cards[4]):
        # KJT is only 1.5.
        hlist[sl] -= 1
      elif (cards[0] == 0 and cards[1] == 0 and cards[2] and cards[3] == 0):
        # Qxx is 3.
        hlist[sl] += 2

    return


  def set_suit_eff_length(self, holding):
    '''Attempt to quantify the 'real' length of a suit.'''
    hlist = self.SUIT_LIST[holding]

    # An average suit keeps its length, but lengths can also be
    # judged up or down.  Everything is scaled by 2x.
    e = self.SUIT_PARAMS.SUIT_EFF_LENGTH.value
    length = self.SUIT_PARAMS.SUIT_LENGTH.value

    hlist[e] = 2 * hlist[length]

    if (hlist[length] == 1):
      if (hlist[self.SUIT_PARAMS.SUIT_CONTROLS.value]):
        # Count a stiff A/K as a 2-card suit.
        hlist[e] += 2
    elif (hlist[length] == 4):
      if (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] >= 37):
        # Good enough for a 1L overcall?
        hlist[e] += 2
      elif (hlist[self.SUIT_PARAMS.SUIT_HCP.value] == 0):
        # More like a 3-card suit.
        hlist[e] -= 2
    elif (hlist[length] == 5):
      if (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] >= 43):
        # Good enough for a general weak-two?
        hlist[e] += 2
      elif (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] >= 38):
        # Good enough for a third-hand weak two?
        hlist[e] += 1
      elif (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] < 32):
        # More like a 4-card suit.
        hlist[e] -= 2
    elif (hlist[length] == 6):
      if (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] >= 33):
        # Good enough for a bad 3-level preempt?
        hlist[e] += 2
      elif (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] < 30):
        # More like a 5-card suit.
        hlist[e] -= 2
    elif (hlist[length] == 7):
      if (hlist[self.SUIT_PARAMS.SUIT_SPOT_SUM.value] <= 30):
        # More like a 6-card suit.
        hlist[e] -= 2
      elif (hlist[self.SUIT_PARAMS.SUIT_TOP3.value] >= 2):
        # Top-heavy 7-card suit.
        hlist[e] += 1

    return


  def lookup(self, values):
    '''Set global references to suits and distribution values.'''
    self.suit_values = [self.SUIT_LIST[values[x]] \
      for x in range(self.BRIDGE_SUITS)]

    sl = self.SUIT_PARAMS.SUIT_LENGTH.value
    dist_key = (self.suit_values[0][sl] << 12) | \
      (self.suit_values[1][sl] << 8) | \
      (self.suit_values[2][sl] << 4) | \
      self.suit_values[3][sl]

    dist_number = self.DIST_CODE_TO_NUMBER[dist_key]
    self.dist_values = self.DIST_LIST[dist_number]
    return

  
  def calc_details(self, values):
    '''Calculate hand-level details.'''
    self.suit_values = [self.SUIT_LIST[values[x]] \
      for x in range(self.BRIDGE_SUITS)]
    seff = self.suit_values[0][self.SUIT_PARAMS.SUIT_EFF_LENGTH.value]
    heff = self.suit_values[1][self.SUIT_PARAMS.SUIT_EFF_LENGTH.value]
    deff = self.suit_values[2][self.SUIT_PARAMS.SUIT_EFF_LENGTH.value]
    ceff = self.suit_values[3][self.SUIT_PARAMS.SUIT_EFF_LENGTH.value]

    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_MDIFF.value] = \
      seff-heff
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_MABSDIFF.value] = \
      abs(seff-heff)
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_MMAX.value] = \
      max(seff, heff)
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_MMIN.value] = \
      min(seff, heff)
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_mMAX.value] = \
      max(deff, ceff)
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_mMIN.value] = \
      min(deff, ceff)

    res = self.suit_order_data(seff, heff, deff, ceff)

    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_L1.value] = res['L1']
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_L2.value] = res['L2']
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_L3.value] = res['L3']
    self.comp_values[COMPOSITE_PARAMS.COMP_EFF_L4.value] = res['L4']

    longest1 = self.dist_values[self.DIST_PARAMS.DIST_LONGEST1.value]
    longest2 = self.dist_values[self.DIST_PARAMS.DIST_LONGEST2.value]

    if (self.comp_values[COMPOSITE_PARAMS.COMP_HCP.value] == 0):
      self.comp_values[COMPOSITE_PARAMS.COMP_MCONC.value] = 0
      self.comp_values[COMPOSITE_PARAMS.COMP_TWOCONC.value] = 0

      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_SHORTEST.value] = 0
      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_LONGEST.value] = 0
      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_LONG12.value] = 0
    else:
      shcp = self.SUIT_PARAMS.SUIT_HCP.value

      self.comp_values[COMPOSITE_PARAMS.COMP_MCONC.value] = 100. * \
        (self.suit_values[self.SUITS.BRIDGE_SPADES.value][shcp] + \
        self.suit_values[self.SUITS.BRIDGE_HEARTS.value][shcp]) / \
        self.comp_values[COMPOSITE_PARAMS.COMP_HCP.value]

      self.comp_values[COMPOSITE_PARAMS.COMP_TWOCONC.value] = 100. * \
        (self.suit_values[longest1][shcp] + \
        self.suit_values[longest2][shcp]) / \
        self.comp_values[COMPOSITE_PARAMS.COMP_HCP.value]

      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_LONGEST.value] = \
        self.suit_values[longest1][shcp]
        
      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_LONG12.value] = \
        self.suit_values[longest1][shcp] + self.suit_values[longest2][shcp]

      # Find the shortest non-void suit.  If there are two such,
      # this parameter is not meaningful.
      short_nonzero = sys.maxsize
      short_HCP = sys.maxsize
      for s in range(self.BRIDGE_SUITS):
        sl = self.suit_values[s][self.SUIT_PARAMS.SUIT_LENGTH.value]
        if (sl > 0 and sl < short_nonzero):
          short_nonzero = sl
          short_HCP = self.suit_values[s][shcp]

      assert(short_nonzero < 40)
      self.comp_values[COMPOSITE_PARAMS.COMP_HCP_SHORTEST.value] = short_HCP

    q = COMPOSITE_PARAMS.COMP_OUTTOPS1.value
    for p in range(self.SUIT_PARAMS.SUIT_TOP1.value, \
      self.SUIT_PARAMS.SUIT_TOP5.value + 1):
      self.comp_values[q] = 0
      for s in range(self.BRIDGE_SUITS):
        if (s != longest1):
          self.comp_values[q] += self.suit_values[s][p]
      q += 1
    
    return


  def set_comp_balanced(self):
    '''Set the balanced properties.'''
    prod = self.dist_values[self.DIST_PARAMS.DIST_PROD.value]
    if (prod >= 90):
      # Balanced, hence also semi-balanced.
      self.dist_values[self.DIST_PARAMS.DIST_BAL.value] = 1
      self.dist_values[self.DIST_PARAMS.DIST_SBAL.value] = 1
    elif (prod == 60 or prod == 64):
      # 5-4-3-1, 4-4-4-1.
      # Could do more here, e.g. stiff A/K.
      self.dist_values[self.DIST_PARAMS.DIST_BAL.value] = 0
      self.dist_values[self.DIST_PARAMS.DIST_SBAL.value] = 0
    elif ((prod == 72 or prod == 80) and
      self.dist_values[self.DIST_PARAMS.DIST_MMAX.value] >= 3 and
      self.dist_values[self.DIST_PARAMS.DIST_MMAX.value] <= 5 and
      self.dist_values[self.DIST_PARAMS.DIST_MPROD.value] < 18):
      # (5-2)=(4-2, (4-2)=(5-2), (3-2)=(6-2) are SBAL.
      self.dist_values[self.DIST_PARAMS.DIST_BAL.value] = 0
      self.dist_values[self.DIST_PARAMS.DIST_SBAL.value] = 1
    else:
      self.dist_values[self.DIST_PARAMS.DIST_BAL.value] = 0
      self.dist_values[self.DIST_PARAMS.DIST_SBAL.value] = 0

    return


  def evaluate(self, values, full_flag):
    '''Evaluate the hand by its numerical suit values.'''
    self.lookup(values)

    # Abuse of enum numbering!
    q = COMPOSITE_PARAMS.COMP_HCP.value
    for p in range(self.SUIT_PARAMS.SUIT_HCP.value, \
      self.SUIT_PARAMS.SUIT_TOP5.value+1):
      self.comp_values[q] = 0
      for s in range(self.BRIDGE_SUITS):
        self.comp_values[q] += self.suit_values[s][p]
      q += 1

    self.comp_values[COMPOSITE_PARAMS.COMP_ZP.value] += \
      self.dist_values[self.DIST_PARAMS.DIST_ZP.value]

    self.set_comp_balanced()

    self.comp_values[COMPOSITE_PARAMS.COMP_SPADES.value] = \
      self.suit_values[self.SUITS.BRIDGE_SPADES.value][self.SUIT_PARAMS.SUIT_LENGTH.value] 

    if (full_flag):
      self.calc_details(values)

    return
  

  def dist_tag(self, lengths):
    '''Return "VBAL", ...'''
    max_len = max(lengths)
    min_len = min(lengths)

    if (max_len == 4 and min_len >= 2):
      return "VBAL"
    elif (max_len == 5 and min_len == 2):
      if (lengths[0] == 5 or lengths[1] == 5):
        return "5MajBAL"
      else:
        return "5minBAL"
    elif (min_len == 2):
      return "NOSHORT"
    else:
      return "UNBAL"


  def getHCP(self):
    '''Return the internally stored HCP value.'''
    return self.comp_values[COMPOSITE_PARAMS.COMP_HCP.value]


  def getAHCP(self):
    '''Return the internally stored adjusted-HCP value.'''
    return self.comp_values[COMPOSITE_PARAMS.COMP_AHCP.value]


  def getKnR(self):
    '''Return the internally stored Kaplan-Rubens (4C)  value.'''
    return self.comp_values[COMPOSITE_PARAMS.COMP_CCCC.value]


  def getZP(self):
    '''Return the internally stored Zar point value.'''
    return self.comp_values[COMPOSITE_PARAMS.COMP_ZP.value]


  def getFL(self):
    '''Return the internally stored "Figuren-Längen" value.'''
    return self.comp_values[COMPOSITE_PARAMS.COMP_FL.value]

  
  def get_comp_value(self, index):
    '''Return the internally stored composite value.'''
    return self.comp_values[index]

  
  def str_header(self, text):
    '''Make a header.'''
    s = text + ":\n\n" + ('%20s' % "")
    for suit in range(self.BRIDGE_SUITS):
      s += '%6s' % self.SUIT_NAMES[suit]
    return s + "\n"

  
  def str_entry(self, value, scale):
    '''Make a string of an entry.'''
    if (scale == 1):
      return '%6d' % value
    else:
      return '%6.2f' % (value / scale)

  
  def str(self, detail_flag):
    '''Make a string of all parameters.'''
    s = self.str_header("Single suit parameters")

    for p in range(self.SUIT_PARAMS.SUIT_SIZE.value):
      s += "%-20s" % self.SUIT_PARAMS_NAMES[p]
      for suit in range(self.BRIDGE_SUITS):
        s += self.str_entry(self.suit_values[suit][p], \
          self.SUIT_PARAMS_SCALES[p])
      s += "\n"
    s += "\n"

    s += "Distribution parameters:\n\n"
    for p in range(self.DIST_PARAMS.DIST_SIZE.value):
      s += '%-20s' % self.DIST_PARAMS_NAMES[p]
      s += self.str_entry(self.dist_values[p], \
        self.DIST_PARAMS_SCALES[p]) + "\n"
    s += "\n"

    s += "Overall parameters:\n\n"
    if detail_flag:
      upper = COMPOSITE_PARAMS.COMP_SIZE.value
    else:
      upper = COMPOSITE_PARAMS.COMP_EFF_MDIFF.value

    for p in range(upper):
      s += '%-20s' % COMPOSITE_PARAMS_NAMES[p]
      s += self.str_entry(self.comp_values[p], \
        COMPOSITE_PARAMS_SCALES[p]) + "\n"
    s += "\n"

    return s

  
  def strCSV(self, values, dealer_index, detail_flag):
    '''Make a string suitable for an overall passed-hand CSV line.'''

    # Distributions, HCPs, CCCC, ZP, Pearson
    s_dist = ""
    s_dtag = ""
    s_hcp = ""
    s_cccc = ""
    s_zp = ""

    i_len = self.SUIT_PARAMS.SUIT_LENGTH.value
    i_hcp = COMPOSITE_PARAMS.COMP_HCP.value
    i_cccc = COMPOSITE_PARAMS.COMP_CCCC.value
    i_zp = COMPOSITE_PARAMS.COMP_ZP.value

    for p in range(dealer_index, dealer_index+4):
      pno = p % 4
      self.evaluate(values[pno], 0)

      lengths = [self.SUIT_LIST[values[pno][sno]][i_len] \
        for sno in range(self.BRIDGE_SUITS)]
      s_dist += '-'.join(str(l) for l in lengths) + self.SEP
      s_dtag += self.dist_tag(lengths) + self.SEP

      s_hcp += str(self.comp_values[i_hcp] /
        COMPOSITE_PARAMS_SCALES[i_hcp])
      s_hcp += self.SEP

      s_cccc += str(self.comp_values[i_cccc] /
        COMPOSITE_PARAMS_SCALES[i_cccc])
      s_cccc += self.SEP

      s_zp += str(self.comp_values[i_zp] /
        COMPOSITE_PARAMS_SCALES[i_zp])
      s_zp += self.SEP

    return s_dist + s_dtag + s_hcp + s_cccc + s_zp

