#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Reductions::Team;

use lib '..';

use Separators;

our @ISA = qw(Exporter);
our @EXPORT = qw(@TEAM_REDUCTIONS);


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

our @TEAM_REDUCTIONS =
(
  # A destruction.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['DESTROY'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Splitting on other fields, including some that could be part of 
  # stray team names.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['CAPTAIN', 'CLUB', 'ZONE', 'COUNTRY', 'NATIONALITY',
          'LOCALITY', 'REGION', 'CITY', 'SPONSOR', 'ORIGIN',
          'FUN', 'FIRST', 'OTHER', 'BOT', 'SCORING', 'MEET',
          'UNIVERSITY', 'FORM', 'STAGE', 'ORGANIZATION', 'COLOR',
          'GENDER', 'AGE', 'ABBR'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Kill the stand-alone word 'bridge'.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TWORD'],
        VALUE => ['Bridge', 'Challenge', 'Championship',
          'Commercial', 'Sunday', 'Trial'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_kill,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  }

);

1;
