#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Reductions;

use lib '..';

use Separators;

our @ISA = qw(Exporter);
our @EXPORT = qw(@TITLE_REDUCTIONS);


# ANCHOR specifies where the pattern may match within a chain
# (ANY, BEGIN, END, EXACT).
#
# KEEP_LAST is the last index, relative to the pattern, that is
# kept.  Anything after that is collapsed in terms of origin.
# If it is 0, then only the first element of pattern is kept.
#
# METHOD is a running counter.  
#
# SPLIT_FRONT and SPLIT_BACK (binary) indicate whether the
# chain should be split if possible before the first match and/or
# after the last match.
#
# COMPLETION regulates whether to try to complete the chain.

our @TITLE_REDUCTIONS =
(
  # Get the bulky, global ones out of the way.
  # ------------------------------------------

  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_ROMAN', 'TITLE_ORDINAL'] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  }

);

1;
