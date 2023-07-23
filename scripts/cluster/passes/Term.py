from enum import Enum
from Valuation import Valuation
from Composites import (COMPOSITE_PARAMS, COMPOSITE_PARAMS_TAGS)

class TERM_TYPE(Enum):
  TERM_LOWER = 0
  TERM_UPPER = 1
  TERM_EXACT = 2
  TERM_RANGE = 3
  TERM_OUTSIDE = 4
  TERM_SIZE = 5

TERM_NAMES = [
  "At least",
  "At most",
  "Exactly",
  "In the range",
  "Outside the range"
  ]


class Term:
  '''A single constraint on a valuation.'''

  def __init__(self):
    self.term_type = TERM_TYPE.TERM_SIZE.value
    self.comp_param = COMPOSITE_PARAMS.COMP_SIZE.value
    self.value1 = 0
    self.value2 = 0


  def set_lower(self, comp_param, value):
    '''Set the lower limit (inclusive).'''
    self.term_type = TERM_TYPE.TERM_LOWER.value
    self.comp_param = comp_param
    self.value1 = value


  def set_upper(self, comp_param, value):
    '''Set the upper limit (inclusive).'''
    self.term_type = TERM_TYPE.TERM_UPPER.value
    self.comp_param = comp_param
    self.value1 = value


  def set_exact(self, comp_param, value):
    '''Set the exact value.'''
    self.term_type = TERM_TYPE.TERM_EXACT.value
    self.comp_param = comp_param
    self.value1 = value


  def set_range(self, comp_param, value1, value2):
    '''Set the range (both ends inclusive).'''
    self.term_type = TERM_TYPE.TERM_LOWER.value
    self.comp_param = comp_param
    self.value1 = value1
    self.value2 = value2


  def set_outside(self, comp_param, value1, value2):
    '''Set the range (both ends exclusive).'''
    self.term_type = TERM_TYPE.TERM_LOWER.value
    self.comp_param = comp_param
    self.value1 = value1
    self.value2 = value2

  
  def lower_contains(self, modifier):
    '''Checks whether the modifier is consistent with a lower term.'''
    if (modifier.value1 > self.value1):
      return False
    elif (modifier.term_type == TERM_TYPE.TERM_LOWER.value):
      return True
    elif (modifier.term_type == TERM_TYPE.TERM_EXACT.value):
      return True
    elif (modifier.term_type == TERM_TYPE.TERM_RANGE.value):
      return True
    else:
      return False


  def upper_contains(self, modifier):
    '''Checks whether the modifier is consistent with an upper term.'''
    if (modifier.value1 < self.value1):
      return False
    elif (modifier.term_type == TERM_TYPE.TERM_UPPER.value):
      return True
    elif (modifier.term_type == TERM_TYPE.TERM_EXACT.value):
      return True
    elif (modifier.term_type == TERM_TYPE.TERM_RANGE.value):
      return True
    else:
      return False


  def exact_contains(self, modifier):
    '''Checks whether the modifier is consistent with an exact term.'''
    if (modifier.value1 != self.value1):
      return False
    elif (modifier.term_type == TERM_TYPE.TERM_EXACT.value):
      return True
    else:
      return False


  def range_contains(self, modifier):
    '''Checks whether the modifier is consistent with a range term.'''
    if (modifier.term_type != TERM_TYPE.TERM_RANGE.value):
      return False
    elif (modifier.value1 < self.value1):
      return False
    elif (modifier.value2 > self.value2):
      return False
    else:
      return True


  def outside_contains(self, modifier):
    '''Checks whether the modifier is consistent with an outside term.'''
    if (modifier.term_type != TERM_TYPE.TERM_OUTSIDE.value):
      return False
    elif (modifier.value1 > self.value1):
      return False
    elif (modifier.value2 < self.value2):
      return False
    else:
      return True


  def contains(self, modifier):
    '''Checks whether the modifier is consistent with the term.'''
    if (self.comp_param != modifier.comp_param):
      return False

    if (self.term_type == TERM_TYPE.TERM_LOWER.value):
      return self.lower_contains(modifier)
    elif (self.term_type == TERM_TYPE.TERM_UPPER.value):
      return self.upper_contains(modifier)
    elif (self.term_type == TERM_TYPE.TERM_EXACT.value):
      return self.exact_contains(modifier)
    elif (self.term_type == TERM_TYPE.TERM_RANGE.value):
      return self.range_contains(modifier)
    elif (self.term_type == TERM_TYPE.TERM_OUTSIDE.value):
      return self.outside_contains(modifier)
    else:
      assert False
      return False

  
  def match(self, valuation):
    '''Return a bool match of the term with the valuation.'''
    assert self.term_type != TERM_TYPE.TERM_SIZE.value
    value = valuation.get_comp_value(self.comp_param)

    if (self.term_type == TERM_TYPE.TERM_LOWER.value):
      return (value >= self.value1)
    elif (self.term_type == TERM_TYPE.TERM_UPPER.value):
      return (value <= self.value1)
    elif (self.term_type == TERM_TYPE.TERM_EXACT.value):
      return (value == self.value1)
    elif (self.term_type == TERM_TYPE.TERM_RANGE.value):
      return (value >= self.value1 and value <= self.value2)
    elif (self.term_type == TERM_TYPE.TERM_OUTSIDE.value):
      return (value < self.value1 or value > self.value2)
    else:
      assert False

  
  def str(self):
    '''Return a text description.'''
    assert self.term_type != TERM_TYPE.TERM_SIZE.value

    s = COMPOSITE_PARAMS_TAGS[self.comp_param] + ": " + \
        TERM_NAMES[TERM_TYPE.TERM_LOWER.value];
    if (self.term_type == TERM_TYPE.TERM_LOWER.value or
        self.term_type == TERM_TYPE.TERM_UPPER.value or
        self.term_type == TERM_TYPE.TERM_EXACT.value):
      return s + " " + str(self.value1);
    elif (self.term_type == TERM_TYPE.TERM_RANGE.value or
        self.term_type == TERM_TYPE.TERM_OUTSIDE.value):
      return s + " " + str(self.value1) + "-" + str(self_value2);
    else:
      assert False

