from dataclasses import dataclass
from copy import deepcopy

from passes.Row import Row
from Composites import (COMPOSITE_PARAMS, COMPOSITE_PARAMS_LOOKUP)


@dataclass
class RowEntry:
  row: Row
  active_flag: bool


class Table:
  '''A set of rows in a table specifying passing probabilities.'''

  def __init__(self):

    self.rows = []
    self.default_flag = True


  def set_default(self):
    '''Use a default HCP-based table.'''
    re1 = RowEntry(Row(), True)
    re1.row.add_upper(COMPOSITE_PARAMS.COMP_HCP.value, 10)
    re1.row.set_overall_prob(1.)
    self.rows.append(re1)

    re2 = RowEntry(Row(), True)
    re2.row.add_equal(COMPOSITE_PARAMS.COMP_HCP.value, 11)
    re2.row.set_overall_prob(0.5)
    self.rows.append(re2)

    re3 = RowEntry(Row(), True)
    re3.row.add_lower(COMPOSITE_PARAMS.COMP_HCP.value, 12)
    re3.row.set_overall_prob(0.)
    self.rows.append(re3)

    self.default_flag = True

  
  def is_default(self):
    '''Self-identifies as default or not.'''
    return default_flag

  
  def parse_int(self, s):
    try:
      return int(s)
    except:
      print(f"'{s}' is not a floating point number")
      assert False


  def parse_components_from(self, row, components, index):
    '''Parse from index.  Return the next unparsed index.'''
    assert index+2 < len(components)

    s = components[index]
    if (not s in COMPOSITE_PARAMS_LOOKUP):
      assert False
    tag = COMPOSITE_PARAMS_LOOKUP[s]

    oper = components[index+1]

    if (oper == "in" or oper == "notin"):
      assert index+3 < len(components)
      value1 = self.parse_int(components[index+2])
      value2 = self.parse_int(components[index+3])
      if (oper == "in"):
        row.add_range(tag, value1, value2)
      else:
        row.add_outside(tag, value1, value2)
      return index+4
    else:
      value1 = self.parse_int(components[index+2])
      if (oper == ">="):
        row.add_lower(tag, value1)
      elif (oper == "<="):
        row.add_upper(tag, value1)
      elif (oper == "=="):
        row.add_equal(tag, value1)
      else:
        assert(False)
      return index+3


  def parse_modify_line(self, components, fn):
    '''Parse a line starting with modify.'''

    # If the new information applies to exactly one inactive line, 
    # we modify that line.
    # If not, we modify all active lines to which it applies.
    # Otherwise, we are presently confused.
 
    # First we parse components into a row called row_core and
    # another one called row_modif.
    num_when = 0
    when_flag = False
    for index in (range(len(components))):
      if (components[index] == "when"):
        num_when = index
        when_flag = True
        break

    assert when_flag

    row_core = Row()
    index = 1
    while (index < num_when):
      index = self.parse_components_from(row_core, components, index)

    row_modif = Row()
    index = num_when + 1
    while (index < len(components)):
      index = self.parse_components_from(row_modif, components, index)

    # Then we check the active and inactive matches.
    list_active = []
    list_inactive = []
    max_inactive_term_count = 0

    for index in (range(len(self.rows))):
      if (self.rows[index].row.contains(row_core) and
          not self.rows[index].row.already_uses(row_modif)):
        if (self.rows[index].active_flag):
          list_active.append(index)
        else:
          list_inactive.append(index)
          tc = self.rows[index].row.term_count()
          if (tc > max_inactive_term_count):
            max_inactive_term_count = tc
    
    if (len(list_active) == 0):
      if (len(list_inactive) == 0):
        assert(False)

      for index in list_inactive:
        # Only the inactive ones that are maximally long.
        if (self.rows[index].row.term_count() < max_inactive_term_count):
          continue

        re_new = deepcopy(self.rows[index])
        re_new.row.add(row_modif)
        re_new.active_flag = True
        re_new.row.add_to_overall_prob(fn)
        self.rows.append(re_new)

      return

    # There are active matches.
    for index in list_active:
      # Make a copy and turn the original inactive.
      re = deepcopy(self.rows[index])
      self.rows[index].active_flag = False

      re.row.add(row_modif)
      re.row.add_to_overall_prob(fn)
      self.rows.append(re)


  def parse_primary_line(self, components, fn):
    '''Parse a normal line.'''
    re = RowEntry(Row(), True)
    re.row.set_overall_prob(fn)
    self.rows.append(re)

    index = 0
    while (index < len(components)):
      index = self.parse_components_from(re.row, components, index)


  def read_file(self, fname):
    '''Read a custom table from a text file.'''
    with open(fname, 'r') as rfile:
      content = rfile.read()
    lines = content.split("\n")

    for line in lines:
      if (line.startswith('#') or line.strip() == ''):
        continue

      fields = line.split(":")
      assert len(fields) == 2

      try:
        fn = float(fields[1])
      except:
        print(f"'{f}' is not a floating point number")
        assert False

      components = fields[0].split()
      if (components[0] == "modify"):
        self.parse_modify_line(components, fn)
      else:
        self.parse_primary_line(components, fn)

    default_flag = False

  
  def lookup(self, valuation):
    '''Look up the passing probability for a given valuation.'''
    for re in self.rows:
      if (not re.active_flag):
        continue

      match_flag, prob = re.row.match(valuation)
      if (match_flag):
        return prob, self.default_flag

    assert False
    return 0., self.default_flag

  
  def str(self):
    '''Return a string description.'''
    s = ""
    for re in self.rows:
      if (re.active_flag):
        s = s + "Active\n"
      else:
        s = s + "Inactive\n"
      s = s + re.row.str()

    return s
        
