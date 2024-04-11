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

my @REDUCTIONS =
(
  # 7 of 9
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
    SPLIT_BACK => 1
  },

  # 1_7, 2/9
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
    SPLIT_BACK => 1
  },

  # 1st half
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
    SPLIT_BACK => 1
  },

  # Group A
  {
    PATTERN =>
    [
      { CATEGORY => [qw(ITERATOR)], FIELD => [qw(Group)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(LETTER)] }
    ],
    ANCHOR => 'ANY',
    KEEP_LAST => 2,
    METHOD => \&process_group_letter_any,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 1
  },


  # Round 5
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
    SPLIT_BACK => 0
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
    SPLIT_BACK => 0
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
    SPLIT_BACK => 1
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
    SPLIT_BACK => 0
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
    SPLIT_BACK => 0
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
    SPLIT_BACK => 0
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
    SPLIT_BACK => 0
  }
);



my @PATTERNS =
(
  # 7 February 2004 (anywhere)
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(MONTH)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(YEAR)] }
    ],
    [ 'DATE', 0, 0, 'VALUE', 2, 'VALUE', 4, 'VALUE'],
    'ANY'
  ],

  # 2v3 (destroy, anywhere)
  [
    [
      { CATEGORY => [qw(NUMERAL )] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(ARTIFICIAL)] },
      { CATEGORY => [qw(ROMAN)], VALUE => [qw(5)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(ARTIFICIAL)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'KILL', 0],
    'ANY'
  ],


  # Final 2 (from the end)
  [
    [
      { CATEGORY => [qw(ITERATOR TABLE)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_SINGLE', 0, 2, 'VALUE'],
    'END'
  ],

  # Final (exact; so an iterator without a value)
  [
    [
      { CATEGORY => [qw(ITERATOR)] }
    ],
    [ 'COUNTER_NONE', 0],
    'EXACT'
  ],

  # Number (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] }
    ],
    [ 'COUNTER_GENERIC', 0, 0, 'VALUE'],
    'EXACT'
  ],

  # 3 Round (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    [ 'COUNTER_SINGLE', 2, 0, 'VALUE'],
    'EXACT'
  ],
);


sub process_no_of_n_any
{
  # 7 of 9, 7th of 9: Mash into one counter.
  my ($chain, $match) = @_;

  my %hash = (BASE => $chain->value($match),
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

      # TODO
      # do .. while change was effected.
      # Only then increase the chain number.
      if ($chain->status() eq 'OPEN')
      {
        my $match = $chain->match(
          $reduction->{PATTERN}, 
          $reduction->{ANCHOR});

        if ($match >= 0)
        {
          $reduction->{METHOD}->($chain, $match);

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
          $chain->complete_if_last_is($reduction->{KEEP_LAST});

          if ($reduction->{SPLIT_BACK} && 
              $match + $reduction->{KEEP_LAST} < $chain->last())
          {
            my $chain2 = $chain->split_on(
              $match + $reduction->{KEEP_LAST} + 2);
            $chain->complete_if_last_is($reduction->{KEEP_LAST});
            $chain2->complete_if_last_is(0);
            splice(@$chains, $chain_no+1, 0, $chain2);
          }

          if ($reduction->{SPLIT_FRONT} && $match > 0)
          {
            my $chain2 = $chain->split_on($match);
            $chain->complete_if_last_is(0);
            $chain2->complete_if_last_is($reduction->{KEEP_LAST});
            splice(@$chains, $chain_no+1, 0, $chain2);
          }
        }
      }
      $chain_no++;
    }
  }
}

1;
