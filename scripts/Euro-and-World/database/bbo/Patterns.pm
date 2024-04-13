#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Patterns;

our @ISA = qw(Exporter);
our @EXPORT = qw(process_patterns);

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


my @REDUCTIONS =
(
  # |Day Month Year -> DATE
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(MONTH)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(YEAR)] }
    ],
    ANCHOR => 'BEGIN',
    KEEP_LAST => 0,
    METHOD => \&process_date_any,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 7 of 9, 7th of 9 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_no_of_n_any,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 7 A of 9 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(A B C D)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(PARTICLE)],
        VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_n_letter_of_n_any,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 1_7, 2/9 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      # TODO Use Separators.pm
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x20, 0x80) ] }, 
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_n_n_any,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 1A_7, 2A/9 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(A B C D)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ (0x20, 0x80) ] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_n_letter_n_any,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 1st half -> Half 1 (ITER COUNTER)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&process_ord_iter_any,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 2A/B -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], FIELD => [ 0x800 ] }, # TODO Virtual
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(A B C D)] },
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 0,
    METHOD => \&process_nl_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 0
  },


  # Group A
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)], FIELD => [qw(Group Match)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&process_group_letter_any,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },

  # 2v3 (destroy, anywhere)
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [ qw(ROMAN) ],
        VALUE => [ 5 ] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 4,
    METHOD => \&process_kill,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1,
    COMPLETION => 1
  },


  # Round 5 -> ITER COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&process_iter_n_end,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
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
    METHOD => \&process_iter_counter_end,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Letter 2 -> COUNTER
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&process_letter_n_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 0
  },


  # Open
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(TOURNAMENT)],
        VALUE => [qw(Open)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_open_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1, # Split one Open from the other
    COMPLETION => 1
  },

  # O
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(O)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_open_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 1, # Split one Open from the other
    COMPLETION => 1
  },

  # W
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(W)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_women_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # J
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(J)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_juniors_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Y
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(Y)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_youngsters_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 1, 4th
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL ORDINAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 0,
    METHOD => \&process_no_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # 16 boards
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&process_no_iter_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Final 2
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(STAGE)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&process_stage_n_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Boards 19-21
  {
    PATTERN =>
    [
      { CATEGORY => [ qw(ITERATOR)] },
      { CATEGORY => [ qw(SEPARATOR)] },
      { CATEGORY => [ qw(SINGLETON) ], FIELD => [ qw(NUMERAL)] },
      { CATEGORY => [ qw(SEPARATOR) ], FIELD => [ 0x10 ] }, # TODO Dash
      { CATEGORY => [ qw(SINGLETON) ], FIELD => [ qw(NUMERAL)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&process_iter_n_n_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # Letter 2A/B (only turns the data into a counter).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(A B C D)] },
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => \&process_letter_nl_exact,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0,
    COMPLETION => 0
  },

  # R/S/Q/... counter (finishes, too).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(J Q S W Y R)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(COUNTER)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&process_letter_counter_exact,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  },

  # R/S/Q/... number (finishes, too).
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)],
        VALUE => [qw(J Q S W Y R)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] }
    ],
    ANCHOR => 'END',
    KEEP_LAST => 2,
    METHOD => \&process_letter_counter_exact,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0,
    COMPLETION => 1
  }
);


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


sub process_no_of_n_any
{
  # 7 of 9, 7th of 9: Mash into one counter.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match),
    OF => $chain->value($match+4));

  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
}


sub process_n_letter_of_n_any
{
  # 7 A of 9.
  my ($chain, $match) = @_;

  my %hash = (
    BASE => $chain->value($match) . $chain->value($match+2),
    OF => $chain->value($match+6));

  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
}


sub process_n_letter_n_any
{
  # 7 A / 9.
  my ($chain, $match) = @_;

  my %hash = (
    BASE => $chain->value($match) . $chain->value($match+2),
    OF => $chain->value($match+4));

  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
}


sub process_n_n_any
{
  # 7_9, 7/9: Mash into one counter.
  # TODO Effectively the same as the previous method (with an arg).
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match),
    OF => $chain->value($match+2));

  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
}


sub process_ord_iter_any
{
  # 1st half: Swap them.
  # TODO Could mash into the iterator.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match));

  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
  
  $chain->swap($match, $match+2);
}


sub process_group_letter_any
{
  # Group A.
  # TODO Could mash into the iterator.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match+2));

  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_iter_n_end
{
  # Round 5.
  # TODO Could mash into the iterator.
  # TODO Same as previous method.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match+2));

  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_iter_counter_end
{
  # Round {counter}: Nothing to do.
  # TODO Could mash into the iterator.
}


sub process_kill
{
}


sub process_open_exact
{
  # Exactly the entry 'Open'.
  # Take it to mean open gender, open age.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  $token->set_singleton('GENDER', 'Open');

  my $token2 = Token->new();
  $token2->copy_origin_from($token);
  $token2->set_separator('VIRTUAL');
  $chain->append($token2);

  my $token3 = Token->new();
  $token3->copy_origin_from($token);
  $token3->set_singleton('AGE', 'Open');

  $chain->append($token3);
}


sub process_women_exact
{
  # Exactly the entry 'W'.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  $token->set_singleton('GENDER', 'Women');
}


sub process_juniors_exact
{
  # Exactly the entry 'J'.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  $token->set_singleton('AGE', 'Juniors');
}


sub process_youngsters_exact
{
  # Exactly the entry 'Y'.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  $token->set_singleton('AGE', 'Youngsters');
}


sub process_no_exact
{
  # Number or ordinal.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value(0));
  my $token = $chain->check_out(0);
  $token->set_counter(\%hash);
}


sub process_no_iter_exact
{
  # Number or ordinal with iterator, such as 16 boards.
  # Swap them around.  Could mash.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match));
  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
            
  $chain->swap($match, $match+2);
}


sub process_letter_n_exact
{
  # R 3
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match+2));
  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_nl_exact
{
  # R 3A
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match) . $chain->value($match+2));
  my $token = $chain->check_out($match);
  $token->set_counter(\%hash);
}


sub process_letter_nl_exact
{
  # R 3A
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match+2) . $chain->value($match+4));
  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_letter_counter_exact
{
  # R 3
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  my $letter = uc($token->value($match));

  if ($letter eq 'R')
  {
    $token->reset_iterator_field('ROUND');
  }
  else
  {
    $token->reset_iterator_field($letter);
  }
}


sub process_stage_n_exact
{
  # Final 2.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match+2));
  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_iter_n_n_exact
{
  # Boards 19-21.
  my ($chain, $match) = @_;

  my $n1 = $chain->value($match+2);
  my $n2 = $chain->value($match+4);

  my %hash;
  if ($n1 <= $n2)
  {
    # Heuristic, may not be true.
    my %hash = (BASE => $n1, TO => $n2);
  }
  else
  {
    my %hash = (MAJOR => $n1, MINOR => $n2);
  }

  my $token = $chain->check_out($match+2);
  $token->set_counter(\%hash);
}


sub process_patterns
{
  my ($chains) = @_;

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
  }
}

1;
