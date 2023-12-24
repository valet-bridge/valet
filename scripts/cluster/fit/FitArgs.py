import argparse

class FitArgs:
  # Reads command-line arguments.

  def __init__(self):
    self.pos = []
    self.vul = []

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
      prog = "correlate",
      description = "Optimizer of valuation variables")
    parser.add_argument('-p', '--pos')
    parser.add_argument('-v', '--vul')
    
    args = parser.parse_args()

    self.pos = self.expand(args.pos)
    self.vul = self.expand(args.vul)

    return self.pos, self.vul

