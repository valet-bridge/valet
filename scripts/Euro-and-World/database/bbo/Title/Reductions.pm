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

  # A destruction.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_DESTROY'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Lots of fields anywhere:
  # - TNAME, TWORD, MEET, SPONSOR, PERSON, CLUB, CAPTAIN
  # - Also YEAR
  # - ZONE, COUNTRY, NATIONALITY, REGION, CITY, QUARTER
  # - GENDER, AGE
  # - ORGANIZATION
  # - SCORING
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_TNAME', 'TITLE_TWORD',
          'TITLE_MEET', 'TITLE_SPONSOR', 'TITLE_PERSON', 'TITLE_CAPTAIN',
          'TITLE_CLUB',
          'TITLE_YEAR',
          'TITLE_ZONE', 'TITLE_COUNTRY', 'TITLE_NATIONALITY',
          'TITLE_REGION', 'TITLE_CITY', 'TITLE_QUARTER',
          'TITLE_GENDER', 'TITLE_AGE',
          'TITLE_ORGANIZATION', 'TITLE_SCORING'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A leading roman numeral, ordinal or letter.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_ROMAN', 'TITLE_ORDINAL', 'TITLE_LETTER'] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A single stage (without a number).
  # Also a form.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'],
        FIELD => ['TITLE_STAGE', 'TITLE_FORM'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A stage followed by a letter or an integer at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_STAGE'] },
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_LETTER', 'TITLE_INTEGER'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 1,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A time indication followed by an integer at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_TIME'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_INTEGER'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 1,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

);

1;
