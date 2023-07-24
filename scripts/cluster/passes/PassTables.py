from passes.Table import Table
from Distributions import DISTRIBUTION_NAMES

class PassTables:
  '''A set of passing tables.'''
  # We use a 1D list here, where the index is
  # 16 * the distribution index + 4 * the relative player index +
  # the relative vulnerability index.

  def __init__(self):
    self.tables = [Table() for _ in range(16 * len(DISTRIBUTION_NAMES))]

    for i in (range(len(self.tables))):
      self.tables[i].set_default()


  def lookup(self, dist_index, player_rel, vul_rel, valuation):
    '''Look up the passing probability.'''
    index = 16 * dist_index + 4 * player_rel + vul_rel
    return self.tables[index].lookup(valuation)

