#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package EventRed;

our @ISA = qw(Exporter);
our @EXPORT = qw(@EVENT_REDUCTIONS);

# ANCHOR specifies where the pattern may match within a chain
# (ANY, BEGIN, END, EXACT).
#
# KEEP_LAST is the last index, relative to the pattern, that is
# kept.  Anything after that is collapsed in terms of origin.
# If it is 0, then only the first element of pattern is kept.
#
# METHOD is a running counter.  
# TODO Perhaps this will later be a method pointer.
#
# SPLIT_FRONT and SPLIT_BACK (binary) indicate whether the
# chain should be split if possible before the first match and/or
# after the last match.
#
# COMPLETION regulates whether to try to complete the chain.

our @EVENT_REDUCTIONS =
(
  # Get the bulky, global ones out of the way.
  # ------------------------------------------

  # 2v3 (kill)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [ qw(ROMAN) ],
        VALUE => [ 5 ] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 4,
    METHOD => \&Patterns::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 2vs3 (kill)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(vs)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 4,
    METHOD => \&Patterns::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Merge the simple counters (digits, letters).
  # --------------------------------------------

  # Ordinal ordinal
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ORDINAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of2,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 7 and/to 9
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(And To)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0dash4,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 2 A
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)]},
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_02,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # A2 (with only virtual in between).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [(0x800)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_02,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 7 of 9
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL N_TO_N ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of4,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 7_9, 7/9, 7A_9, 7A/9.  Also underscore with space
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x20, 0x21, 0x80) ] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A-7_9 (where the 'of' is already established).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] },
      { CATEGORY => [qw(SEPARATOR)] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 6:1, 6:1B
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x4) ] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0colon2,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 2-3, 2-3A, 2A-3
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x10) ] }, # TODO Dash
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0sep2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 5-7_9 (where the 'of' is already established).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x10) ] }, # TODO Dash
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Number or Number-letter with space or dash, then N_OF_N.
  # Note that N-N and N-N_N is gone in the previous patterns.
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x01, 0x10) ] }, # TODO Dash
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0sep2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Ordinal followed by N_OF_N.
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x01, 0x20) ] }, 
      # TODO Space or underscore
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0sep2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Roman dash/space counter.
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ROMAN)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x01, 0x10) ] }, 
      # TODO Space or dash
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0sep2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },



  # By here, R (round) and T (table) followed by counter should be clean.
  # And we should be able to take some sequences as dates.
  # ---------------------------------------------------------------------

  # R/r counter
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(R r)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_r_counter,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Table/Match counter
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)], FIELD => [qw(Table Match)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Expansion counter
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(EXPANSION)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Day Month Year -> DATE
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(MONTH)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(YEAR)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_date_any,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 1st half -> Half 1 (ITER COUNTER)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_swap,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Group A
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)], FIELD => [qw(Group Match)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER SINGLETON)], FIELD => [qw(LETTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Open and Girls
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(O G o g)] },
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_og_front,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1, # Split one from the other
    COMPLETION => 1
  },

  # As this generates a leading Age singleton, we fix this too.
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(AGE)] },
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },




  # Round {COUNTER}
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Letter 2 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },


  # 1, 4th
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL ORDINAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 16 boards
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_swap,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # R/S/Q/... counter (finishes, too).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(J Q S s W Y R)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_letter_counter_exact,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },


  # Clean-up of length 3
  # --------------------

  # Day Month
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(MONTH)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_day_month,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Month Year
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(MONTH)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(YEAR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_month_year,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Roman Roman
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ROMAN)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ROMAN)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Roman iterator
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ROMAN)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_swap,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },


  # Clean-up of length 1
  # --------------------

  # Just an iterator
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Just a v (probably left over from a team1 v team2)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(ROMAN)], VALUE => [ 5 ] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_kill,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # ABCD
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)], 
        VALUE => [ qw(A B C D a b c d) ] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_kill,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # QRS
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)], 
        VALUE => [ qw(Q R S q r s) ] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # WJYK
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(W J Y K)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_letter_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # TEMPORAL and YEAR, I guess.
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  }
);

1;
