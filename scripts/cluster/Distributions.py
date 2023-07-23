from enum import Enum

class DISTRIBUTIONS(Enum):
  DIST_4432 = 0

  DIST_5MAJ332 = 1
  DIST_5MIN332 = 2

  DIST_5MAJ431 = 3
  DIST_5MIN431 = 4

  DIST_5MAJ422 = 5
  DIST_5MIN422 = 6

  DIST_4333 = 7

  DIST_6MAJ322 = 8
  DIST_6MIN332 = 9

  DIST_6MAJ421 = 10
  DIST_6MIN421 = 11

  DIST_6MAJ331 = 12
  DIST_6MIN331 = 13

  DIST_55MAJ21 = 14
  DIST_5MAJ5MIN21 = 15
  DIST_55MIN21 = 16

  DIST_4441 = 17

  DIST_7MAJ321 = 18
  DIST_7MIN321 = 19

  DIST_6MAJ430 = 20
  DIST_6MIN430 = 21

  DIST_54MAJ40 = 22
  DIST_50MAJ44 = 23
  DIST_44MAJ50 = 24
  DIST_40MAJ54 = 25

  DIST_55MAJ30 = 26
  DIST_53MAJ50 = 27
  DIST_50MAJ53 = 28
  DIST_55MIN30 = 29

  DIST_65MAJ11 = 30
  DIST_61MAJ51 = 31
  DIST_51MAJ61 = 32
  DIST_65MIN11 = 33

  DIST_65MAJ20 = 34
  DIST_6MAJ5MIN20 = 35
  DIST_5MAJ6MIN20 = 36
  DIST_65MIN20 = 37

  DIST_7MAJ222 = 38
  DIST_7MIN222 = 39

  DIST_74MAJ11 = 40
  DIST_71MAJ41 = 41
  DIST_74MIN11 = 42
  DIST_71MIN41 = 43

  DIST_74MAJ20 = 44
  DIST_7MAJ4MIN20 = 45
  DIST_4MAJ7MIN20 = 46
  DIST_74MIN20 = 47

  DIST_7MAJ330 = 48
  DIST_7MIN330 = 49

  DIST_8MAJ221 = 50
  DIST_8MIN221 = 51

  DIST_8MAJ311 = 52
  DIST_8MIN311 = 53

  DIST_75MAJ10 = 54
  DIST_7MAJ5MIN10 = 55
  DIST_5MAJ7MIN10 = 56
  DIST_75MIN10 = 57

  DIST_8MAJ320 = 58
  DIST_8MIN320 = 59

  DIST_66MAJ10 = 60
  DIST_6MAJ6MIN10 = 61
  DIST_66MIN10 = 62

  DIST_84MAJ10 = 63
  DIST_8MAJ4MIN10 = 64
  DIST_4MAJ8MIN10 = 65
  DIST_84MIN10 = 66

  DIST_9MAJ211 = 67
  DIST_9MIN211 = 68

  DIST_9MAJ310 = 69
  DIST_9MIN310 = 70

  DIST_9MAJ220 = 71
  DIST_9MIN220 = 72

  DIST_76MAJ00 = 73
  DIST_7MAJ6MIN = 74
  DIST_6MAJ7MIN = 75
  DIST_76MIN00 = 76

  DIST_85MAJ00 = 77
  DIST_8MAJ5MIN = 78
  DIST_5MAJ8MIN = 79
  DIST_85MIN00 = 80

  DIST_10MAJ210 = 81
  DIST_10MIN210 = 82

  DIST_94MAJ00 = 83
  DIST_9MAJ4MIN = 84
  DIST_4MAJ9MIN = 85
  DIST_94MIN00 = 86

  DIST_10MAJ111 = 87
  DIST_10MIN111 = 88

  DIST_10MAJ300 = 89
  DIST_10MIN300 = 90

  DIST_11MAJ110 = 91
  DIST_11MIN110 = 92

  DIST_11MAJ200 = 93
  DIST_11MIN200 = 94

  DIST_12MAJ100 = 95
  DIST_12MIN100 = 96

  DIST_13MAJ000 = 97
  DIST_13MIN000 = 98


DISTRIBUTION_NAMES = [
  "4432",
  "5MAJ332", "5MIN332",
  "5MAJ431", "5MIN431",
  "5MAJ422", "5MIN422",
  "4333",
  "6MAJ322", "6MIN332",
  "6MAJ421", "6MIN421",
  "6MAJ331", "6MIN331",
  "55MAJ21", "5MAJ5MIN21", "55MIN21",
  "4441",
  "7MAJ321", "7MIN321",
  "6MAJ430", "6MIN430",
  "54MAJ40", "50MAJ44", "44MAJ50", "40MAJ54",
  "55MAJ30", "53MAJ50", "50MAJ53", "55MIN30",
  "65MAJ11", "61MAJ51", "51MAJ61", "65MIN11",
  "65MAJ20", "6MAJ5MIN20", "5MAJ6MIN20", "65MIN20",
  "7MAJ222", "7MIN222",
  "74MAJ11", "71MAJ41", "74MIN11", "71MIN41",
  "74MAJ20", "7MAJ4MIN20", "4MAJ7MIN20", "74MIN20",
  "7MAJ330", "7MIN330",
  "8MAJ221", "8MIN221",
  "8MAJ311", "8MIN311",
  "75MAJ10", "7MAJ5MIN10", "5MAJ7MIN10", "75MIN10",
  "8MAJ320", "8MIN320",
  "66MAJ10", "6MAJ6MIN10", "66MIN10",
  "84MAJ10", "8MAJ4MIN10", "84MIN10",
  "9MAJ211", "9MIN211",
  "9MAJ310", "9MIN310",
  "9MAJ220", "9MIN220",
  "76MAJ00", "7MAJ6MIN", "6MAJ7MIN", "76MIN00",
  "85MAJ00", "8MAJ5MIN", "5MAJ8MIN", "85MIN00",
  "10MAJ210", "10MIN210",
  "94MAJ00", "9MAJ4MIN", "4MAJ9MIN", "94MIN00",
  "10MAJ111", "10MIN111",
  "10MAJ300", "10MIN300",
  "11MAJ110", "11MIN110",
  "11MAJ200", "11MIN200",
  "12MAJ100", "12MIN100",
  "13MAJ000", "13MIN000",
  ]


class Distribution:

  def __init__(self):
    self.name2number = {}
    for d in (range(DISTRIBUTION_NAMES)):
      self.name2number[DISTRIBUTION_NAMES[d]] = d

  
  def number4(self, min_len):
    if (min_len == 1):
      return DISTRIBUTIONS.DIST_4441.value
    elif (min_len == 2):
      return DISTRIBUTIONS.DIST_4432.value
    else:
      return DISTRIBUTIONS.DIST_4333.value

  
  def number5major(self, min_len, max_minor, min_minor):
    if (min_len == 0):
      if (min_major == 5):
        return DISTRIBUTIONS.DIST_55MAJ30.value
      elif (min_major == 4):
        return DISTRIBUTIONS.DIST_54MAJ40.value
      elif (min_major == 3):
        return DISTRIBUTIONS.DIST_53MAJ50.value
      elif (max_minor == 5):
        return DISTRIBUTIONS.DIST_50MAJ53.value
      elif (max_minor == 4):
        return DISTRIBUTIONS.DIST_50MAJ44.value
      else:
        assert(False)
    elif (min_len == 1):
      if (min_major == 5):
        return DISTRIBUTIONS.DIST_55MAJ21.value
      elif (min_minor == 5):
        return DISTRIBUTIONS.DIST_5MAJ5MIN21.value
      else:
        return DISTRIBUTIONS.DIST_5MAJ431.value
    elif (min_len == 2):
      if (min_major == 4 or min_minor == 4):
        return DISTRIBUTIONS.DIST_5MAJ422.value
      else:
        return DISTRIBUTIONS.DIST_5MAJ332.value
    else:
      assert False


  def number5minor(self, min_len, max_major, min_major, min_minor):
    if (min_len == 0):
      if (min_major == 4):
        return DISTRIBUTIONS.DIST_44MAJ50.value
      elif (min_minor == 5):
        return DISTRIBUTIONS.DIST_55MIN30.value
      elif (min_minor == 4):
        return DISTRIBUTIONS.DIST_40MAJ54.value
      else:
        assert False
    elif (min_len == 1):
      if (min_minor == 5):
        return DISTRIBUTIONS.DIST_55MIN21.value
      else:
        return DISTRIBUTIONS.DIST_5MIN431.value
    elif (min_len == 2):
      if (max_major == 4 or min_minor == 4):
        return DISTRIBUTIONS.DIST_5MIN422.value
      else:
        return DISTRIBUTIONS.DIST_5MIN332.value
    else:
      assert False

  
  def number6major(self, min_len, max_minor, min_minor):
    if (min_len == 2):
      return DISTRIBUTIONS.DIST_6MAJ322.value
    elif (min_len == 1):
      if (max_minor == 5):
        return DISTRIBUTIONS.DIST_61MAJ51.value
      elif (max_minor == 3):
        return DISTRIBUTIONS.DIST_6MAJ331.value
      elif (max_minor == 1):
        return DISTRIBUTIONS.DIST_65MAJ11.value
      else:
        return DISTRIBUTIONS.DIST_6MAJ421.value
    elif (max_minor == 6):
      return DISTRIBUTIONS.DIST_6MAJ6MIN10.value
    elif (max_minor == 5):
      return DISTRIBUTIONS.DIST_6MAJ5MIN20.value
    elif (max_minor == 2):
      return DISTRIBUTIONS.DIST_65MAJ20.value
    elif (max_minor == 1):
      return DISTRIBUTIONS.DIST_66MAJ10.value
    else:
      return DISTRIBUTIONS.DIST_6MAJ430.value


  def number6minor(self, min_len, max_major, min_major, min_minor):
    if (min_len == 2):
      return DISTRIBUTIONS.DIST_6MIN332.value
    elif (min_len == 1):
      if (max_major == 5):
        return DISTRIBUTIONS.DIST_51MAJ61.value
      elif (max_major == 1):
        return DISTRIBUTIONS.DIST_65MIN11.value
      elif (max_major == 3):
        return DISTRIBUTIONS.DIST_6MIN331.value
      else:
        return DISTRIBUTIONS.DIST_6MIN421.value
    elif (max_major == 5):
      return DISTRIBUTIONS.DIST_5MAJ6MIN20.value
    elif (max_major == 2):
      return DISTRIBUTIONS.DIST_65MIN20.value
    elif (max_major == 1):
      return DISTRIBUTIONS.DIST_66MIN10.value
    else:
      return DISTRIBUTIONS.DIST_6MIN430.value


  def number7major(self, min_len, max_minor, min_minor):
    if (min_len == 2):
      return DISTRIBUTIONS.DIST_7MAJ222.value
    elif (min_len == 1):
      if (max_minor == 4):
        return DISTRIBUTIONS.DIST_71MAJ41.value
      elif (max_minor == 1):
        return DISTRIBUTIONS.DIST_74MAJ11.value
      else:
        return DISTRIBUTIONS.DIST_7MAJ321.value
    elif (max_minor == 6):
      return DISTRIBUTIONS.DIST_7MAJ6MIN.value
    elif (max_minor == 5):
      return DISTRIBUTIONS.DIST_7MAJ5MIN10.value
    elif (max_minor == 4):
      return DISTRIBUTIONS.DIST_7MAJ4MIN20.value
    elif (max_minor == 3):
      return DISTRIBUTIONS.DIST_7MAJ330.value
    elif (max_minor == 2):
      return DISTRIBUTIONS.DIST_74MAJ20.value
    elif (max_minor == 1):
      return DISTRIBUTIONS.DIST_75MAJ10.value
    else:
      return DISTRIBUTIONS.DIST_76MAJ00.value


  def number7minor(self, min_len, max_major, min_major, min_minor):
    if (min_len == 2):
      return DISTRIBUTIONS.DIST_7MIN222.value
    elif (min_len == 1):
      if (max_major == 4):
        return DISTRIBUTIONS.DIST_71MIN41.value
      elif (max_major == 1):
        return DISTRIBUTIONS.DIST_74MIN11.value
      else:
        return DISTRIBUTIONS.DIST_7MIN321.value
    if (max_major == 6):
      return DISTRIBUTIONS.DIST_6MAJ7MIN.value
    elif (max_major == 5):
      return DISTRIBUTIONS.DIST_5MAJ7MIN10.value
    elif (max_major == 4):
      return DISTRIBUTIONS.DIST_4MAJ7MIN20.value
    elif (max_major == 3):
      return DISTRIBUTIONS.DIST_7MIN330.value
    elif (max_major == 2):
      return DISTRIBUTIONS.DIST_74MIN20.value
    elif (max_major == 1):
      return DISTRIBUTIONS.DIST_75MIN10.value
    else:
      return DISTRIBUTIONS.DIST_76MIN00.value


  def number8major(self, min_len, max_minor, min_minor):
    if (min_len == 1):
      if (max_minor == 2):
        return DISTRIBUTIONS.DIST_8MAJ221.value
      else:
        return DISTRIBUTIONS.DIST_8MAJ311.value
    elif (max_minor == 5):
      return DISTRIBUTIONS.DIST_8MAJ5MIN.value
    elif (max_minor == 4):
      return DISTRIBUTIONS.DIST_8MAJ4MIN10.value
    elif (max_minor == 1):
      return DISTRIBUTIONS.DIST_84MAJ10.value
    elif (max_minor == 0):
      return DISTRIBUTIONS.DIST_85MAJ00.value
    else:
      return DISTRIBUTIONS.DIST_8MAJ320.value


  def number8minor(self, min_len, max_major, min_major, min_minor):
    if (min_len == 1):
      if (max_major == 2):
        return DISTRIBUTIONS.DIST_8MIN221.value
      else:
        return DISTRIBUTIONS.DIST_8MIN311.value
    elif (max_major == 5):
      return DISTRIBUTIONS.DIST_5MAJ8MIN.value
    elif (max_major == 4):
      return DISTRIBUTIONS.DIST_4MAJ8MIN10.value
    elif (max_major == 1):
      return DISTRIBUTIONS.DIST_84MIN10.value
    elif (max_major == 0):
      return DISTRIBUTIONS.DIST_85MIN00.value
    else:
      return DISTRIBUTIONS.DIST_8MIN320.value


  def number9major(self, min_len, max_minor, min_minor):
    if (min_len == 1):
      return DISTRIBUTIONS.DIST_9MAJ211.value
    elif (max_minor == 4):
      return DISTRIBUTIONS.DIST_9MAJ4MIN.value
    elif (max_minor == 2):
      return DISTRIBUTIONS.DIST_9MAJ220.value
    elif (max_minor == 0):
      return DISTRIBUTIONS.DIST_94MAJ00.value
    else:
      return DISTRIBUTIONS.DIST_9MAJ310.value


  def number9minor(self, min_len, max_major, min_major, min_minor):
    if (min_len == 1):
      return DISTRIBUTIONS.DIST_9MIN211.value
    elif (max_major == 4):
      return DISTRIBUTIONS.DIST_4MAJ9MIN.value
    elif (max_major == 2):
      return DISTRIBUTIONS.DIST_9MIN220.value
    elif (max_major == 0):
      return DISTRIBUTIONS.DIST_94MIN00.value
    else:
      return DISTRIBUTIONS.DIST_9MIN310.value


  def number(self, spades, hearts, diamonds, clubs):
    max_len = max(spades, hearts, diamonds, clubs)
    min_len = min(spades, hearts, diamonds, clubs)
    max_major = max(spades, hearts)
    min_major = min(spades, hearts)
    max_minor = max(diamonds, clubs)
    min_minor = min(diamonds, clubs)

    if (max_len == 4):
      return self.number4(min_len)
    elif (max_len == 5):
      if (max_major == 5):
        return number5major(min_len, max_minor, min_minor)
      else:
        return number5minor(min_len, max_major, min_major, min_minor)
    elif (max_len == 6):
      if (max_major == 6):
        return number6major(min_len, max_minor, min_minor)
      else:
        return number6minor(min_len, max_major, min_major, min_minor)
    elif (max_len == 7):
      if (max_major == 7):
        return number7major(min_len, max_minor, min_minor)
      else:
        return number7minor(min_len, max_major, min_major, min_minor)
    elif (max_len == 8):
      if (max_major == 8):
        return number8major(min_len, max_minor, min_minor)
      else:
        return number8minor(min_len, max_major, min_major, min_minor)
    elif (max_len == 9):
      if (max_major == 9):
        return number9major(min_len, max_minor, min_minor)
      else:
        return number9minor(min_len, max_major, min_major, min_minor)
    elif (max_len == 10):
      if (max_major == 10):
        if (min_len == 1):
          return DISTRIBUTIONS.DIST_10MAJ111.value
        elif (max_minor == 1 or max_minor == 2):
          return DISTRIBUTIONS.DIST_10MAJ210.value
        else:
          return DISTRIBUTIONS.DIST_10MAJ300.value
      elif (min_len == 1):
        return DISTRIBUTIONS.DIST_10MIN111.value
      elif (max_major == 1 or max_major == 2):
        return DISTRIBUTIONS.DIST_10MIN210.value
      else:
        return DISTRIBUTIONS.DIST_10MIN300.value
    elif (max_len == 11):
      if (max_major == 11):
        if (max_minor == 1):
          return DISTRIBUTIONS.DIST_11MAJ110.value
        else:
          return DISTRIBUTIONS.DIST_11MAJ200.value
      elif (max_major == 1):
        return DISTRIBUTIONS.DIST_11MIN110.value
      else:
        return DISTRIBUTIONS.DIST_11MIN200.value

    elif (max_len == 12):
      if (max_major == 12):
        return DISTRIBUTIONS.DIST_12MAJ100.value
      else:
        return DISTRIBUTIONS.DIST_12MIN100.value
    elif (max_len == 13):
      if (max_major == 13):
        return DISTRIBUTIONS.DIST_13MAJ000.value
      else:
        return DISTRIBUTIONS.DIST_13MIN000.value

    else:
      assert False

      
  def number(self, name):
    assert name in self.name2number
    return self.name2number[name]

