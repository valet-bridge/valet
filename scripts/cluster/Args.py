import argparse

class Args:
  # Reads command-line arguments.

  def __init__(self):
    self.train = []
    self.validate = []
    self.test = []

  def expand(self, text):
    '''Expand 1,6-8 to (1, 6, 7, 8).'''
    if not text:
      return []

    elems = text.split(",")

    res = []
    for e in elems:
      if "-" in e:
        ends = e.split("-")
        assert len(ends) == 2
        assert(ends[0].isnumeric())
        assert(ends[1].isnumeric())
        for i in range(int(ends[0]), int(ends[1])+1):
          res.append(i)
      else:
        assert(e.isnumeric())
        res.append(int(e))

    res.sort()
    return res


  def parse(self):
    '''Parse the command-line arguments.'''
    parser = argparse.ArgumentParser(
      prog = "cluster",
      description = "Scratch pad for classifying bridge hands")
    parser.add_argument('-t', '--train')
    parser.add_argument('-v', '--validate')
    parser.add_argument('-T', '--test')
    
    args = parser.parse_args()

    self.train = self.expand(args.train)
    self.validate = self.expand(args.validate)
    self.test = self.expand(args.test)

    return self.train, self.validate, self.test

