class PBN:
  # DDS encoding, but without the two bottom 00 bits: ((2 << 13) - 1).
  BRIDGE_TRICKS = 13
  BRIDGE_PLAYERS = 4
  BRIDGE_SUITS = 4
  MAX_HOLDING = 0x2000
  SEP = ','

  CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
  TEXTS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  HCP   = [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,   0 ,  1 ,  2 ,  3 ,  4 ]

  HOLDING_TO_TEXT = [None] * MAX_HOLDING
  SUIT_TO_HCP = {}
  PBN_TO_HOLDING = {}

  # DDS encoding.
  PLAYER_NAMES_SHORT = ["N", "E", "S", "W"]
  PLAYER_NAMES_LONG = ["North", "East", "South", "West"]
  PLAYER_NUMBERS_SHORT = {"N": 0, "E": 1, "S": 2, "W": 3}


  def __init__(self):
    for h in range(self.MAX_HOLDING):
      suit = ""
      text = ""
      hcp = 0
      for bit in reversed(range(0, self.BRIDGE_TRICKS)):
        if (h & (1 << bit)):
          suit += self.CARDS[bit]
          text += self.TEXTS[bit] + " "
          hcp += self.HCP[bit]
      
      self.HOLDING_TO_TEXT[h] = text
      self.PBN_TO_HOLDING[suit] = h
      self.PBN_TO_HOLDING[suit[::-1]] = h
      self.SUIT_TO_HCP[suit] = hcp

    # Show a void explicitly.
    self.HOLDING_TO_TEXT[0] = "-"


  def pbn_to_suits(self, pbn, suits):
    '''Turn N:KJT6.K875.832.Q2 etc. into 4x4 array of strings.'''
    first, cards = pbn.split(":")
    hands = cards.split(" ")
    index = self.PLAYER_NUMBERS_SHORT[first]

    # Split into individual suit strings.
    # North is 0, East is 1 etc.
    for p in range(self.BRIDGE_PLAYERS):
      absno = (p + index) % 4
      suits[absno] = hands[p].split(".")
    return

  
  def suits_to_holdings(self, suits, holdings):
    '''Turn a 4x4 array of strings into a 4x4 array of holdings.'''
    for absno in range(self.BRIDGE_PLAYERS):
      for s in range(len(suits[absno])):
        holdings[absno][s] = self.PBN_TO_HOLDING[suits[absno][s]]
    return


  def texts_to_text(self, texts):
    '''Turn a 4x4 array of strings into a nice diagram.'''
    text = ""

    # North
    text += "%14s%s\n" % ("", self.PLAYER_NAMES_LONG[0])
    for s in range(self.BRIDGE_SUITS):
      text += "%14s%s\n" % ("", texts[0][s])

    # West, East
    text += "%-14s%14s%s\n" % (self.PLAYER_NAMES_LONG[3], "",
      self.PLAYER_NAMES_LONG[1])
    for s in range(self.BRIDGE_SUITS):
      text += "%-14s%14s%s\n" % (texts[3][s], "", texts[1][s])

    # South
    text += "%14s%s\n" % ("", self.PLAYER_NAMES_LONG[2])
    for s in range(self.BRIDGE_SUITS):
      text += "%14s%s\n" % ("", texts[2][s])

    return text


  def pbn_to_text(self, pbn):
    '''Turn N:KJT6.K875.832.Q2 etc. into a hand diagram as text.'''
    suits = [["" for p in range(self.BRIDGE_PLAYERS)] 
      for s in range(self.BRIDGE_SUITS)]

    self.pbn_to_suits(pbn, suits)

    texts = [["" for p in range(self.BRIDGE_PLAYERS)] 
      for s in range(self.BRIDGE_SUITS)]

    # Split into individual suit strings.
    for absno in range(self.BRIDGE_PLAYERS):
      for s in range(len(suits[absno])):
        h = self.PBN_TO_HOLDING[suits[absno][s]]
        texts[absno][s] += self.HOLDING_TO_TEXT[h]

    return self.texts_to_text(texts)


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

  
  def str_vul(self, vulPBN, fourth_index):
    '''Turn the PBN vulnerability and position into a relative string.'''
    v_we = ""
    v_op = ""
    if (fourth_index == 0 or fourth_index == 2):
      v_we = "white" if (vulPBN == "None" or vulPBN == "EW") else "red"
      v_op = "white" if (vulPBN == "None" or vulPBN == "NS") else "red"
    else:
      v_we = "white" if (vulPBN == "None" or vulPBN == "NS") else "red"
      v_op = "white" if (vulPBN == "None" or vulPBN == "EW") else "red"

    return v_we + "/" + v_op

  
  def calcHCP(self, player_suits):
    '''Calculate the HCP from the player's suits.'''
    hcp = 0
    for s in range(self.BRIDGE_SUITS):
      hcp += self.SUIT_TO_HCP[player_suits[s]]

    return hcp
  

  def calc_maxHCP(self, suits):
    '''Calculate the maximum HCP of any player.'''
    maxHCP = 0
    for s in range(self.BRIDGE_SUITS):
      maxHCP = max(maxHCP, self.calcHCP(suits[s]))

    return maxHCP

  
  def strHCP(self, diagram):
    '''Make a string of HCP such 12-8-10-10.'''
    suits = [["" for p in range(self.BRIDGE_PLAYERS)] 
      for s in range(self.BRIDGE_SUITS)]

    self.pbn_to_suits(diagram["pbn"], suits)

    sHCP = ''
    for s in range(self.BRIDGE_SUITS):
      sHCP += str(self.calcHCP(suits[s])) + ' '

    return sHCP


  def strCSV(self, diagram, suits):
    '''Make a string suitable for an overall passed-hand CSV line.'''

    dealer_index = self.PLAYER_NUMBERS_SHORT[diagram["dealer"]]
    fourth_index = (dealer_index + 3) % 4
    fourth_suits = suits[fourth_index]
    void_suits = [fourth_suits[s] if fourth_suits[s] != "" else "-"
      for s in range(self.BRIDGE_SUITS)]

    # Start with the hand itself.
    s = ' '.join(void_suits) + self.SEP

    # Add vulnerability.
    s += self.str_vul(diagram["vul"], fourth_index) + ","

    # Make lengths.
    lengths = [len(fourth_suits[sno]) for sno in range(self.BRIDGE_SUITS)]

    # Add distribution.
    # s += '-'.join(str(l) for l in lengths) + self.SEP

    # Add distribution tag (VBAL, ...).
    # s += self.dist_tag(lengths) + self.SEP

    # Add HCP.
    hcp = self.calcHCP(fourth_suits)
    # s += str(hcp) + self.SEP

    # Add spade length.
    s += str(lengths[0]) + self.SEP

    # Add Pearson points.
    s += str(hcp + lengths[0]) + self.SEP

    # Add an alarm flag when other players have >= 13 HCP.
    # if (self.calc_maxHCP(suits) >= 13):
      # s += "1"
    # else:
      # s += "0"

    return s

