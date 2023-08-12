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

  def __init__(self):
    self.tables = [Table() for _ in range(16 * len(DISTRIBUTION_NAMES))]

    distribution = Distribution()
    vulnerability = Vulnerability()

    for txt_file in self.find_txt_files():
      parts = re.split('[/.]', txt_file)
      if len(parts) != 6:
        print("parts", parts)
      assert len(parts) == 6
      assert parts[3] in POSITIONS
      assert parts[5] == "txt"

      dist = distribution.name_to_number(parts[2])
      pos = POSITIONS[parts[3]]
      vul = vulnerability.tag_to_relative(parts[4])
      index = 16 * dist + 4 * pos + vul

      self.tables[index].read_file(txt_file)

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

