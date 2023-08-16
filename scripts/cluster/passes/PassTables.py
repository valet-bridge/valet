import os
import glob
import re

from passes.Table import Table
from Distributions import (Distribution, DISTRIBUTION_NAMES)
from Vulnerability import (Vulnerability, VUL_RELATIVE)

TABLE_DIR = "passes/tables"
POSITIONS = dict(first = 0, second = 1, third = 2, fourth = 3)


class PassTables:
  '''A set of passing tables.'''
  # We use a 1D list here, where the index is
  # 16 * the distribution index + 4 * the relative player index +
  # the relative vulnerability index.

  def read_any_pos_vul(self, txt_file, parts, distribution):
    '''Read an Any.txt file directly in the distribution directory.'''
    dist = distribution.name_to_number(parts[2])
    assert parts[3] == "Any"
    assert parts[4] == "txt"

    base_index = 16 * dist
    self.tables[base_index].read_file(txt_file)

    print("ANY pos-vul parts", parts)

    # Make up the other positions and vulnerabilities.
    for index in range(base_index+1, base_index+16):
      self.tables[index]= self.tables[base_index]

  
  def read_any_vul(self, txt_file, parts, distribution):
    '''Read an Any.txt file in a distribution/position directory.'''
    dist = distribution.name_to_number(parts[2])
    pos = POSITIONS[parts[3]]
    assert parts[4] == "Any"
    assert parts[5] == "txt"

    base_index = 16 * dist + 4 * pos
    self.tables[base_index].read_file(txt_file)

    print("ANY vul parts", parts)

    # Make up the other vulnerabilities.
    for index in range(base_index+1, base_index+4):
      self.tables[index]= self.tables[base_index]

  
  def read_one(self, txt_file, parts, distribution, vulnerability):
    '''Read one file in a distribution/position dir, one vul.'''
    dist = distribution.name_to_number(parts[2])
    assert parts[3] in POSITIONS
    pos = POSITIONS[parts[3]]
    vul = vulnerability.tag_to_relative(parts[4])
    assert parts[5] == "txt"

    index = 16 * dist + 4 * pos + vul
    self.tables[index].read_file(txt_file)


  def __init__(self):
    self.tables = [Table() for _ in range(16 * len(DISTRIBUTION_NAMES))]

    distribution = Distribution()
    vulnerability = Vulnerability()

    for txt_file in self.find_txt_files():
      parts = re.split('[/.]', txt_file)

      if len(parts) == 5:
        self.read_any_pos_vul(txt_file, parts, distribution)
      elif len(parts) == 6:
        if parts[4] == "Any":
          self.read_any_vul(txt_file, parts, distribution)
        else:
          self.read_one(txt_file, parts, distribution, vulnerability)
      else:
        print("parts", parts)
        assert False

    for i in (range(len(self.tables))):
      if self.tables[i].is_default():
        self.tables[i].set_default()

  
  def find_txt_files(self):
    for root, dirs, files  in os.walk(TABLE_DIR):
      for file in glob.glob(os.path.join(root, '*.txt')):
        yield file


  def lookup(self, dist_index, player_rel, vul_rel, holding, valuation):
    '''Look up the passing probability.'''
    index = 16 * dist_index + 4 * player_rel + vul_rel
    valuation.evaluate(holding, False)
    return self.tables[index].lookup(valuation)

