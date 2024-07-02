#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Reductions::Title;

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
      { CATEGORY => ['SINGLETON'], FIELD => ['DESTROY'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A date range.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['DATE'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'],
        VALUE => ['to'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['DATE'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Some preliminary splitting on fields that should not be part of
  # stray team names in the title.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TNAME', 'TWORD', 'MEET', 
          'PERSON', 'YEAR', 'DATE',
          'ZONE', 'NATIONALITY',
          'QUARTER', 'GENDER', 'AGE',
          'ORGANIZATION', 'SCORING'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Team match-ups that really shouldn't be in the title.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['CAPTAIN', 'CLUB', 'COUNTRY',
          'REGION', 'CITY', 'SPONSOR'] },
      { CATEGORY => ['SINGLETON', 'COUNTER'], 
        FIELD => ['PARTICLE', 'ROMAN'],
        VALUE => ['vs', '5'] },
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['CAPTAIN', 'CLUB', 'COUNTRY',
          'REGION', 'CITY', 'SPONSOR'] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Patterns::Chainify::process_matchup,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Splitting on other fields, including some that could be part of 
  # stray team names.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['CAPTAIN', 'CLUB', 'COUNTRY',
          'REGION', 'CITY', 'SPONSOR', 
          'UNIVERSITY', 'FORM', 'STAGE'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A leading ordinal with an iterator following it.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['ORDINAL'] },
      { CATEGORY => ['ITERATOR'] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 1,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # n to m
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'],
        VALUE => ['to'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL', 'NL'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_merge_0to2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # n of m
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], 
        FIELD => ['NUMERAL', 'ORDINAL', 'N_TO_N'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'],
        VALUE => ['of'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A defective n of m: only "of m"
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'],
        VALUE => ['of'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 1,
    METHOD => \&Patterns::Chainify::process_kill,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A number followed by a letter at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['COUNTER'], FIELD => ['LETTER'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_merge_01,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A single stage (without a number).
  # - SCORING
  # Also a form.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['STAGE', 'FORM'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A numeral or ordinal followed by an iterator/stage at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] },
      { CATEGORY => ['ITERATOR'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 1,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # An iterator, stage or ambiguous followed by a letter or an integer.
  {
    PATTERN =>
    [
      { CATEGORY => ['ITERATOR', 'AMBIGUOUS'] },
      { CATEGORY => ['COUNTER'], 
        FIELD => ['LETTER', 'NUMERAL', 'N_OF_N', 
          'N_TO_N', 'NL', 'N_TO_N_OF_N'] },
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 1,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A leading roman numeral, ordinal or letter.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], 
        FIELD => ['ROMAN', 'ORDINAL', 'LETTER'] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A time indication followed by an integer at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TIME'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 1,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Certain counters at the ends of chains.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], 
        FIELD => ['NUMERAL', 'N_OF_N', 'ORDINAL', 'LETTER', 'ROMAN',
          'NL', 'N_TO_N_OF_N'] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 0,
    METHOD => \&Patterns::Chainify::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  }

);

1;
