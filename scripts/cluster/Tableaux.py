import re

from Sets import Sets

class Tableaux:
  # Reads tableaux.
  TABLEAU = "tableau.txt"
  SEP = ','

  def __init__(self):
    self.tableaux = {}

  
  def parse_chunks(self, number, chunks):
    '''Parse the chunks of a tableau file.'''
    for chunk in chunks:
      # First chunk will be empty.
      if not chunk:
        continue

      cmatch = re.search(".+\|\d+\n", chunk)
      assert cmatch

      tag = (str(number) + "|" + cmatch.group()).rstrip()

      self.tableaux[tag] = chunk.replace(cmatch.group(), "")


  def read(self, number_list):
    '''Read the tableau file in the directories of the number list.'''
    sets = Sets()
    for number in number_list:
      name = sets.name(number) + "/" + self.TABLEAU

      with open(name, 'r') as tfile:
        content = tfile.read()

      chunks = content.split("BOARD ")
      self.parse_chunks(number, chunks)


  def lookup(self, tag):
    '''Look up the tableau corresponding to the tag which must exist.'''
    assert tag in self.tableaux
    return self.tableaux[tag]


  def str_pass_CSV(self, tag, pass_fraction):
    '''Turn the tableau into some passed-hand data.'''
    tableau = self.lookup(tag)
    
    f = 0.
    for line in tableau.splitlines():
      if ("pass (NS)" in line):
        for poss in line[24:].split():
          try:
            f = float(poss)
            break
          except ValueError:
            pass

        break

    if (pass_fraction < 1.):
      # The scores for bidding and passing must balance:
      # pass_fraction * f + (1 - pass_fraction) * x = 0
      rest = -f * pass_fraction / (1. - pass_fraction)
      s = ('%0.2f' % pass_fraction) + \
        self.SEP + ('%0.2f' % f) + \
        self.SEP + ('%0.2f' % rest)
    else:
      s = '0.00' + self.SEP + '0.00' + self.SEP + '000'

    return s

