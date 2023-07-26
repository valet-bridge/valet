from passes.Term import Term

# In the simplest case, each row consists of a single term or
# a sequence of terms that must all be fulfilled for the row to match.
# But we also want to be able to build up a row from this:
#
# HCP = 10: 0.80
# modify HCP = 10 when controls <= 3: -0.05
# modify HCP = 10 when controls >= 4: +0.10
#
# So we must be able to check whether a row is consistent with
# the conditions for a modification.
#
# Later on we may also modify:
#
# modify HCP = 10 when spades = 2: -0.10
#
# and this should modify HCP = 10, controls <= 3 as well as
# HCP = 10, controls >= 4.  So consistency means that the modifier
# does not contradict the row.  It does not mean that the two are
# identical.


class Row:
  '''A row is a set of AND'ed terms and an overall probability.'''

  def __init__(self):
    self.terms = []
    self.prob = -1.


  def add_lower(self, comp_param, value):
    '''Add a term with a lower limit (inclusive).'''
    term = Term()
    term.set_lower(comp_param, value)
    self.terms.append(term)


  def add_upper(self, comp_param, value):
    '''Add a term with an upper limit (inclusive).'''
    term = Term()
    term.set_upper(comp_param, value)
    self.terms.append(term)


  def add_equal(self, comp_param, value):
    '''Add a term with an exact value.'''
    term = Term()
    term.set_exact(comp_param, value)
    self.terms.append(term)


  def add_range(self, comp_param, value1, value2):
    '''Add a term with a range (inclusive).'''
    term = Term()
    term.set_range(comp_param, value1, value2)
    self.terms.append(term)


  def add_outside(self, comp_param, value1, value2):
    '''Add a term with an excluded range (so 4-5 means exluding 4, 5).'''
    term = Term()
    term.set_outside(comp_param, value1, value2)
    self.terms.append(term)

  
  def set_overall_prob(self, prob):
    '''Sets the overall probability of the row.'''
    self.prob = prob

  
  def add(self, row_new):
    '''Add the conditions in row_new to this row.'''
    for term in row_new.terms:
      self.terms.append(term)

  
  def add_to_overall_prob(self, prob):
    '''Adds to the overall probability of the row.'''
    self.prob = self.prob + prob

  
  def saturate(self):
    '''Limit the probability to [0, 1] in case it has moved outside.'''
    if (self.prob < 0.):
      print("Warning", self.prob)
      self.prob = 0.
    elif (self.prob > 1.):
      print("Warning", self.prob)
      self.prob = 1.

  
  def term_count(self):
    '''Returns the number of terms in the row.'''
    return len(self.terms)

  
  def contains(self, modifier):
    '''Checks whether the modifier row is consistent with the row.'''
    if (len(modifier.terms) > len(self.terms)):
      return False

    # Make a record of which of our own terms have been seen.
    seen = [False] * len(self.terms)

    for i in range(len(modifier.terms)):
      found_flag = False
      for j in range(len(self.terms)):
        if (seen[j]):
          continue
        if (self.terms[j].contains(modifier.terms[i])):
          seen[j] = True
          found_flag = True
          break
      
      if (not found_flag):
        return False

    return True

  
  def already_uses(self, modifier):
    '''Checks whether the modifier is already used in the row.'''

    for i in range(len(modifier.terms)):
      for j in range(len(self.terms)):
        if (self.terms[j].uses(modifier.terms[i])):
          return True
      
    return False

  
  def match(self, valuation):
    '''Return a bool match with the valuation, and the probability.'''
    for term in self.terms:
      if (not term.match(valuation)):
        return False, 0.

    assert self.prob >= 0.
    return True, self.prob


  def str(self):
    '''Return a string description.'''
    s = "Probability " + str(self.prob) + "\n"
    for term in self.terms:
      s = s + term.str() + "\n"
    return s + "\n"
