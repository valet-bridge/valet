#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Patterns;

our @ISA = qw(Exporter);
our @EXPORT = qw(process_patterns @RMATCH);

use lib '.';
use lib '..';
use Tchar;
use Chains;

my @SIMPLE_LIST = qw(NUMERAL ORDINAL LETTER SEPARATOR);
my %SIMPLE_CATEGORIES = map { $_ => 1} @SIMPLE_LIST;

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

my %MONTHS = (
  'January' => '01',
  'Jan' => '01',
  'February' => '02',
  'March' => '03',
  'April' => '04',
  'May' => '05',
  'June' => '06',
  'July' => '07',
  'August' => '08',
  'September' => '09',
  'October' => '10',
  'November' => '11',
  'December' => '12');

our @RMATCH;

my @REDUCTIONS =
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
    METHOD => \&process_kill,
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
    METHOD => \&process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Merge the simple counters (digits, letters).
  # --------------------------------------------

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
    METHOD => \&process_merge_0dash4,
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
    METHOD => \&process_merge_02,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 7 of 9
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL N_TO_N)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_merge_0of4,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 7_9, 7/9, 7A_9, 7A/9
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x20, 0x80) ] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # A-7_9 (where the 'of' is already established).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(N_OF_N)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_merge_0of2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 6:1
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x4) ] }, 
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL NL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_merge_0colon2,
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
    METHOD => \&process_merge_0dash2,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # By here, R (round) and T (table) followed by counter should be clean.
  # And we should be able to take some sequences as dates.
  # ---------------------------------------------------------------------

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
    METHOD => \&process_r_counter,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)], FIELD => [qw(Table Match)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&process_general,
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
    METHOD => \&process_date_any,
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
    METHOD => \&process_swap,
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
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&process_general,
    SPLIT_FRONT => 1,
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
    METHOD => \&process_general,
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
    METHOD => \&process_general,
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
    METHOD => \&process_general,
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
    METHOD => \&process_swap,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # R/S/Q/... counter (finishes, too).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(J Q S W Y R)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&process_letter_counter_exact,
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
    METHOD => \&process_day_month,
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
    METHOD => \&process_month_year,
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
    METHOD => \&process_merge_0of2,
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
    METHOD => \&process_swap,
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
    METHOD => \&process_general,
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
    METHOD => \&process_kill,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Open and Girls
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(O G o g)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_og_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1, # Split one from the other
    COMPLETION => 1
  },

  # ABC
  {
    PATTERN =>
    [
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(LETTER)], 
        VALUE => [ qw(A B C D a b c d) ] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_kill,
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
    METHOD => \&process_general,
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
    METHOD => \&process_letter_exact,
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
    METHOD => \&process_general,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  }
);


sub process_general
{
  # Nothing to do.
}


sub process_date_any
{
  # 13 December 2004.
  my ($chain, $match) = @_;

  my $month = $chain->value($match+2);
  die "$month not a month" unless defined $MONTHS{$month};

  my $day = $chain->value($match);
  $day = '0' . $day if $day < 10;

  my $str = $chain->value($match+4) . '-' . $MONTHS{$month} . '-' . $day;

  my $token = $chain->check_out($match);
  $token->set_singleton('DATE', $str);
}


sub process_day_month
{
  # 13 December 2004.
  my ($chain, $match) = @_;

  my $month = $chain->value($match+2);
  die "$month not a month" unless defined $MONTHS{$month};

  my $day = $chain->value($match);
  $day = '0' . $day if $day < 10;

  my $str = $MONTHS{$month} . '-' . $day;

  my $token = $chain->check_out($match);
  $token->set_singleton('MONTH_DAY', $str);
}


sub process_month_year
{
  # December 2004.
  my ($chain, $match) = @_;

  my $month = $chain->value($match);
  die "$month not a month" unless defined $MONTHS{$month};

  my $str = $chain->value($match+2) . '-' . $MONTHS{$month};

  my $token = $chain->check_out($match);
  $token->set_singleton('YEAR_MONTH', $str);
}


sub process_swap
{
  my ($chain, $match) = @_;
  $chain->swap($match, $match+2);
}


sub process_merge_02
{
  # R 3A
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('', $chain->check_out($match+2));
}


sub process_merge_0of2
{
  # 7_9, 7/9: Mash into one counter.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('of', $chain->check_out($match+2));
}


sub process_merge_0colon2
{
  # 6:1.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters(':', $chain->check_out($match+2));
}


sub process_merge_0of4
{
  # 7 of 9, 7th of 9: Mash into one counter.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('of', $chain->check_out($match+4));
}


sub process_merge_0dash2
{
  # 19-21 with a dash.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('-', $chain->check_out($match+2));
}


sub process_merge_0dash4
{
  # 19-21 with a particle.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('-', $chain->check_out($match+4));
}


sub process_merge_2dash4
{
  # Boards 19-21.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match+2);
  $token->merge_counters('-', $chain->check_out($match+4));
}


sub process_kill
{
}


sub process_r_counter
{
  # R counter.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  my $letter = uc($token->value());

  if ($letter eq 'R')
  {
    $token->reset_iterator_field('ROUND');
  }
  elsif ($letter eq 'T')
  {
    $token->reset_iterator_field('TABLE');
  }
  else
  {
    die "Unexpected letter $letter";
  }
}


sub process_og_exact
{
  # Exactly the entry 'Open' or 'G' for Girls.
  # Take it to mean open gender, open age / juniors.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  my $letter = uc($token->value());

  $token->set_singleton('GENDER', 'Open');

  my $token2 = Token->new();
  $token2->copy_origin_from($token);
  $token2->set_separator('VIRTUAL');
  $chain->append($token2);

  my $token3 = Token->new();
  $token3->copy_origin_from($token);

  if ($letter eq 'O')
  {
    $token3->set_singleton('AGE', 'Open');
  }
  elsif ($letter eq 'G')
  {
    $token3->set_singleton('AGE', 'Juniors');
  }
  else
  {
    die "Unknown OG";
  }

  $chain->append($token3);
}


sub process_letter_exact
{
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  my $letter = uc($token->value());

  if ($letter eq 'J')
  {
    $token->set_singleton('AGE', 'Juniors');
  }
  elsif ($letter eq 'Y')
  {
    $token->set_singleton('AGE', 'Youngsters');
  }
  elsif ($letter eq 'K')
  {
    $token->set_singleton('AGE', 'Kids');
  }
  elsif ($letter eq 'W')
  {
    $token->set_singleton('GENDER', 'Women');
  }
  else
  {
    die "Unexpected letter $letter";
  }
}


sub process_letter_counter_exact
{
  # R 3
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  my $letter = uc($token->value());

  if ($letter eq 'R')
  {
    $token->reset_iterator_field('ROUND');
  }
  else
  {
    $token->reset_iterator_field($letter);
  }
}


sub process_patterns
{
  my ($chains) = @_;

  my $rno = 0;
  for my $reduction (@REDUCTIONS)
  {
    my $plen = $#{$reduction->{PATTERN}};
    my $chain_no = 0;

    while ($chain_no <= $#$chains)
    {
      my $chain = $chains->[$chain_no];

      while ($chain->status() eq 'OPEN' &&
        (my $match = $chain->match(
          $reduction->{PATTERN}, 
          $reduction->{ANCHOR})) >= 0)
      {
        $RMATCH[$rno]++;
        $reduction->{METHOD}->($chain, $match);

        my $cstatus;
        if ($reduction->{METHOD} eq \&process_kill)
        {
          $cstatus = 'KILLED';
        }
        else
        {
          $cstatus = 'COMPLETE';
        }

        if ($reduction->{KEEP_LAST} < $plen)
        {
          $chain->collapse_elements(
            $match + $reduction->{KEEP_LAST}, 
            $match + $plen);

          $chain->delete(
            $match + $reduction->{KEEP_LAST} + 1, 
            $match + $plen);
        }

        # This is probably the same as match == 0.
        $chain->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) if
          $reduction->{COMPLETION};

        if ($reduction->{SPLIT_BACK} && 
            $match + $reduction->{KEEP_LAST} < $chain->last())
        {
          my $chain2 = $chain->split_on(
            $match + $reduction->{KEEP_LAST} + 2);
          $chain->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) if
            $reduction->{COMPLETION};
          $chain2->complete_if_last_is(0, 'COMPLETE');
          splice(@$chains, $chain_no+1, 0, $chain2);
        }

        if ($reduction->{SPLIT_FRONT} && $match > 0)
        {
          my $chain2 = $chain->split_on($match);
          $chain->complete_if_last_is(0, 'COMPLETE');
          $chain2->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) 
            if $reduction->{COMPLETION};
          splice(@$chains, $chain_no+1, 0, $chain2);
        }
      }
      $chain_no++;
    }
    $rno++;
  }
}

1;
