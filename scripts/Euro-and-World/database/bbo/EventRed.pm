#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package EventRed;

use lib '.';
use Separators;

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

  # 2v3.  These is probably the seeding numbers -- kill.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => ['ROMAN'], VALUE => [5] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 4,
    METHOD => \&Patterns::process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 2vs3.  These is probably the seeding numbers -- kill.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'], VALUE => ['vs']},
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['ORDINAL'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => ['ORDINAL'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'],
        VALUE => [qw(And To)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR']},
      { CATEGORY => ['COUNTER'], FIELD => ['LETTER'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['LETTER'] },
      { CATEGORY => ['SEPARATOR'], FIELD => [$SEPARATORS{VIRTUAL}] },
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] }
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
      { CATEGORY => ['COUNTER'], 
        FIELD => [qw(NUMERAL NL N_TO_N ORDINAL)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['PARTICLE'], VALUE => ['Of']},
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL NL)] }
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
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL NL)] },
      { CATEGORY => ['SEPARATOR'], 
        FIELD => [$SEPARATORS{UNDERSCORE}, 
                  $SEPARATORS{UNDERSCORE} | $SEPARATORS{SPACE},
                  $SEPARATORS{SLASH}] }, 
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL NL)] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['LETTER'] },
      { CATEGORY => ['SEPARATOR'] }, 
      { CATEGORY => ['COUNTER'], FIELD => ['N_OF_N'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR'], FIELD => [$SEPARATORS{COLON}] }, 
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL NL N_OF_N)] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['NUMERAL'] },
      { CATEGORY => ['SEPARATOR'], FIELD => [$SEPARATORS{DASH}] },
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_merge_0sep2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Number or Number-letter with space or dash, then N_OF_N.
  # Note that N-N and N-N_N is gone in the previous patterns.
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL ORDINAL ROMAN NL)] },
      { CATEGORY => ['SEPARATOR'], 
        FIELD => [$SEPARATORS{SPACE},
                  $SEPARATORS{DASH},
                  $SEPARATORS{UNDERSCORE}] },
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL N_OF_N)] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['ROMAN'] },
      { CATEGORY => ['SEPARATOR'], 
        FIELD => [$SEPARATORS{SPACE},
                  $SEPARATORS{DASH},
                  $SEPARATORS{UNDERSCORE}] }, 
      { CATEGORY => ['COUNTER'], FIELD => [qw(ROMAN LETTER NL)] }
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
      { CATEGORY => ['SINGLETON'], FIELD => ['LETTER'],
        VALUE => [qw(R r)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'] }
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
      { CATEGORY => ['ITERATOR'], FIELD => [qw(Table Match)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'] }
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
      { CATEGORY => ['SINGLETON'], FIELD => ['EXPANSION'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # Day Month Year
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['MONTH'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['YEAR'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_date,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 1st half -> Half 1 (ITER COUNTER)
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['ORDINAL'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['ITERATOR'] }
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
      { CATEGORY => ['ITERATOR'], FIELD => [qw(Group Match)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => [qw(COUNTER SINGLETON)], FIELD => ['LETTER'] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Some specific locations
  # -----------------------

  # Open and Girls
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['LETTER'],
        VALUE => [qw(O G o g)] },
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_og_front,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1, # Split one Open from the other
    COMPLETION => 1
  },

  # As the previous one  makes a leading Age singleton, we fix this too.
  {
    PATTERN =>
    [
      { CATEGORY => ['SINGLETON'], FIELD => ['AGE'] },
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
      { CATEGORY => ['ITERATOR'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_general,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },


  # Clean-up of length 3
  # --------------------

  # 1, 4th
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL ORDINAL)] }
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
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['ITERATOR'] }
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
      { CATEGORY => ['SINGLETON'], FIELD => ['LETTER'],
        VALUE => [qw(J Q S s W Y R)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['COUNTER'] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&Patterns::process_letter_counter_exact,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Day Month
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['MONTH'] }
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
      { CATEGORY => ['SINGLETON'], FIELD => ['MONTH'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['SINGLETON'], FIELD => ['YEAR'] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&Patterns::process_month_year,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Roman iterator
  {
    PATTERN =>
    [
      { CATEGORY => ['COUNTER'], FIELD => ['ROMAN'] },
      { CATEGORY => ['SEPARATOR'] },
      { CATEGORY => ['ITERATOR'] }
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
      { CATEGORY => ['ITERATOR'] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['ROMAN'], VALUE => [5] }
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
      { CATEGORY => ['COUNTER'], FIELD => ['LETTER'], 
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
      { CATEGORY => ['SINGLETON'], FIELD => ['LETTER'], 
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
      { CATEGORY => ['SINGLETON'], FIELD => ['LETTER'],
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
      { CATEGORY => ['SINGLETON'] },
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
