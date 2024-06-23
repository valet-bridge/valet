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

  # A date range.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_DATE'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_PARTICLE'],
        VALUE => ['to'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_DATE'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Event::Patterns::process_general,
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
        FIELD => ['TITLE_TNAME', 'TITLE_TWORD', 'TITLE_MEET', 
          'TITLE_PERSON', 'TITLE_YEAR', 'TITLE_DATE',
          'TITLE_ZONE', 'TITLE_NATIONALITY',
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

  # Team match-ups that really shouldn't be in the title.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_CAPTAIN', 'TITLE_CLUB', 'TITLE_COUNTRY',
          'TITLE_REGION', 'TITLE_CITY', 'TITLE_SPONSOR'] },
      { CATEGORY => ['SINGLETON', 'COUNTER'], 
        FIELD => ['TITLE_PARTICLE', 'ROMAN'],
        VALUE => ['vs', '5'] },
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_CAPTAIN', 'TITLE_CLUB', 'TITLE_COUNTRY',
          'TITLE_REGION', 'TITLE_CITY', 'TITLE_SPONSOR'] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Event::Patterns::process_matchup,
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
        FIELD => ['TITLE_CAPTAIN', 'TITLE_CLUB', 'TITLE_COUNTRY',
          'TITLE_SPONSOR', 'TITLE_UNIVERSITY', 'TITLE_FORM'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A leading ordinal with an iterator following it.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['ORDINAL'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_ITERATOR'] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 1,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # n of m
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_PARTICLE'],
        VALUE => ['of'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
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
    METHOD => \&Event::Patterns::process_merge_01,
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
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_STAGE', 'TITLE_FORM'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A numeral or ordinal followed by an iterator/stage at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL', 'ORDINAL'] },
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_ITERATOR', 'TITLE_STAGE'] },
    ],
    ANCHOR => 'END',
    KEEP_LAST => 1,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # An iterator or stage followed by a letter or an integer.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], 
        FIELD => ['TITLE_ITERATOR', 'TITLE_STAGE'] },
      { CATEGORY => ['COUNTER'], 
        FIELD => ['LETTER', 'NUMERAL', 'N_OF_N', 'NL'] },
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 1,
    METHOD => \&Event::Patterns::process_general,
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
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A blank stage.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_STAGE'] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Event::Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },



  # A time indication followed by an integer at the end.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['TITLE_TIME'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
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
