import re

from Sets import Sets
from PBN import PBN


class Diagrams:
  # Reads PBN round files and stores them as text diagrams.'''

  def __init__(self):
    self.diagrams = {}


  def parse_lines(self, no, rno, lines):
    '''Parse the lines of PBN file.'''
    board_no = ""
    dealer = ""
    vul = ""

    for line in lines:
      bmatch = re.search("\[Board \"(\d+)\"\]", line)
      if bmatch:
        board_no = bmatch.group(1)
        continue

      dmatch = re.search("\[Dealer \"(.+)\"\]", line)
      if dmatch:
        dealer = dmatch.group(1)
        continue

      vmatch = re.search("\[Vulnerable \"(.+)\"\]", line)
      if vmatch:
        vul = vmatch.group(1)
        continue

      deal_match = re.search("\[Deal \"(.+)\"\]", line)
      if deal_match:
        diagram = {}
        diagram["dealer"] = dealer
        diagram["vul"] = vul
        diagram["pbn"] = deal_match.group(1)
          
        tag = str(no) + "|" + rno + "|" + board_no
        self.diagrams[tag] = diagram


  def read(self, number_list):
    '''Read all diagram files in the directories of the number list.'''
    sets = Sets()
    for no in number_list:
      round_list = sets.rounds(no)
      for rname in round_list:
        rmatch = re.search("round(.+).pbn", rname)
        assert rmatch
        rno = rmatch.group(1)

        with open(rname, 'r') as rfile:
          content = rfile.read()

        lines = content.split("\n")
        self.parse_lines(no, rno, lines)


  def lookup(self, tag):
    '''Look up the diagram corresponding to the tag which must exist.'''
    assert tag in self.diagrams
    return self.diagrams[tag]

  
  def str(self, tag):
    '''Make a pretty string of the diagram corresponding to the tag.'''
    assert tag in self.diagrams
    diagram = self.diagrams[tag]

    s = str("BOARD  " + tag + "\n")
    s += "Dealer " + diagram["dealer"] + "\n"
    s += "Vul    " + diagram["vul"] + "\n\n"

    pbn = PBN()
    s += pbn.pbn_to_text(diagram["pbn"])

    return s

  
  def strCSV(self, pbn, suits, tag):
    '''Make a string suitable for an overall CSV line.'''
    if tag not in self.diagrams:
      print("diagrams about to fail on tag", tag)
    assert tag in self.diagrams
    return pbn.strCSV(self.diagrams[tag], suits)

