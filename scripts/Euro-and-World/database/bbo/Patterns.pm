#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Patterns;

our @ISA = qw(Exporter);
our @EXPORT = qw(process_patterns process_patterns_new);

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
  # 3 of 7 (anywhere).

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
    METHOD => 0,
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
    METHOD => 1,
    SPLIT_FRONT => 0,
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
    METHOD => 2,
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
    METHOD => 3,
    SPLIT_FRONT => 1,
    SPLIT_BACK => 0
  },

  # 16 boards
  {
    PATTERN =>
    [
      { CATEGORY => [qw(SINGLETON)], FIELD => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] }
    ],
    ANCHOR => 'EXACT',
    KEEP_LAST => 2,
    METHOD => 98,
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
    METHOD => 99,
    SPLIT_FRONT => 0,
    SPLIT_BACK => 0
  }
);

my @PATTERNS =
(
  # Segment 3 of 7 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(PARTICLE)], VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    # Argument list:
    # (0) The Tchar type
    # (1) The pattern element whose category and value are used in Tchar
    # (2,3), (4,5) etc. The arguments passed to Tchar
    #          (0)        (1)(2)   (3)   (4)   (5)
    [ 'COUNTER_SINGLE_OF', 0, 2, 'VALUE', 6, 'VALUE'],
    'ANY'
  ],

  # Segment 3/7 or 3_7 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR TABLE)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(SLASH UNDERSCORE)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_SINGLE_OF', 0, 2, 'VALUE', 4, 'VALUE'],
    'ANY'
  ],

  # RR3_3 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(ARTIFICIAL)] },
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(UNDERSCORE)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_SINGLE_OF', 0, 2, 'VALUE', 4, 'VALUE'],
    'ANY'
  ],

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


  # 7th Match (from the front)
  [
    [
      { CATEGORY => [qw(ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(ITERATOR)] },
    ],
    [ 'COUNTER_SINGLE', 2, 0, 'VALUE'],
    'BEGIN'
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

  # 3_4 (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(UNDERSCORE)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_GENERIC_OF', 0, 0, 'VALUE', 2, 'VALUE'],
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

  # 2 of 4 (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(PARTICLE)], VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_GENERIC_OF', 0, 0, 'VALUE', 4, 'VALUE'],
    'EXACT'
  ],

  # 2/4 (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => [qw(SLASH)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_GENERIC_OF', 0, 0, 'VALUE', 2, 'VALUE'],
    'EXACT'
  ],
);


sub pattern_elem_match
{
  my ($chain_elem, $pattern_elem) = @_;

  my $category = $chain_elem->{CATEGORY};

  my $hit = 0;
  for my $cand (@{$pattern_elem->{CATEGORY}})
  {
    if ($category eq $cand)
    {
      $hit = 1;
      last;
    }
  }

  return 0 unless $hit;
  return 1 unless defined $pattern_elem->{VALUE};

  my $value = $chain_elem->{VALUE};

  for my $cand (@{$pattern_elem->{VALUE}})
  {
    if ($value eq $cand)
    {
      return 1;
    }
  }
  return 0;
}


sub pattern_match
{
  my ($chain, $start_index, $elem_pattern, $plen) = @_;

  for my $p (0 .. $plen)
  {
    return 0 unless pattern_elem_match(
        $chain->[$start_index + $p], $elem_pattern->[$p]);
  }
  return 1;
}


sub collapse_elements
{
  my ($elem, $chain, $start_index, $anchor_count, $plen) = @_;

  # Before we splice out the matched elements, we keep some
  # information from them.

  $elem->{CATEGORY} = $chain->[$start_index + $anchor_count]{CATEGORY};
  $elem->{VALUE} = $chain->[$start_index + $anchor_count]{VALUE};

  for my $p (1 .. $plen)
  {
    $elem->{text} .= $chain->[$start_index + $p]{text};
  }

  $elem->{position_last} = $chain->[$start_index + $plen]{position_last};
}


sub make_arg_list
{
  my ($chain, $start_index, $reaction, $arg_list_ref) = @_;

  for (my $r = 2; $r <= $#$reaction; $r += 2)
  {
    my $pos = $start_index + $reaction->[$r];
    push @$arg_list_ref, $chain->[$pos]{$reaction->[$r+1]};
  }
}


sub index_match
{
  my ($chain, $index, $pattern, $plen, 
    $chains_ref, $chain_no, $chain_max_ref, $solved_ref) = @_;

  return unless pattern_match($chain, $index, $pattern->[0], $plen);

  if ($pattern->[1][0] eq 'KILL')
  {
    # Special case.
    my $elem = $chain->[$index];
    splice(@$chain, $index+1, $plen);
    split_chain_on($chains_ref, $chain_no, $chain_max_ref, $elem, $index);
    return;
  }

  my $cat;
  if ($pattern->[1][0] =~ /^COUNTER_GENERIC/)
  {
    # Make a unique extension if needed.
    my $cat0 = $pattern->[1][0];
    $cat = $cat0;
    my $try = 1;
    while (exists $solved_ref->{$cat})
    {
      $cat = $cat0 . "_$try";
      $try++;
    }
  }
  else
  {
    $cat = $chain->[$index + $pattern->[1][1]]{VALUE};
  }

  $solved_ref->{$cat} = Tchar->new() unless exists $solved_ref->{$cat};

  my $reaction = $pattern->[1];

  my @arg_list;
  make_arg_list($chain, $index, $reaction, \@arg_list);

  my $elem = $chain->[$index];
  collapse_elements($elem, $chain, $index, $reaction->[1], $plen);

  splice(@$chain, $index+1, $plen);

  $solved_ref->{$cat}->set($reaction->[0], $elem, @arg_list);

  split_chain_on($chains_ref, $chain_no, $chain_max_ref, $elem, $index);
}


sub process_patterns
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    # TODO Skip over empty chain -- how?

    for my $pattern (@PATTERNS)
    {
      my $plen = $#{$pattern->[0]};
      my $anchor = $pattern->[2];

      if ($anchor eq 'ANY')
      {
        my $start_index = 0;
        while ($start_index + $plen <= $#$chain)
        {
          index_match($chain, $start_index, $pattern, $plen,
            $chains_ref, $chain_no, \$chain_max, $solved_ref);

          $start_index += 2;
        }
      }
      elsif ($anchor eq 'BEGIN')
      {
        if ($plen <= $#$chain)
        {
          index_match($chain, 0, $pattern, $plen,
            $chains_ref, $chain_no, \$chain_max, $solved_ref);
        }
      }
      elsif ($anchor eq 'END')
      {
        if ($plen <= $#$chain)
        {
          index_match($chain, $#$chain - $plen, $pattern, $plen,
            $chains_ref, $chain_no, \$chain_max, $solved_ref);
        }
      }
      elsif ($anchor eq 'EXACT')
      {
        if ($plen == $#$chain)
        {
          index_match($chain, 0, $pattern, $plen,
            $chains_ref, $chain_no, \$chain_max, $solved_ref);
        }
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub process_patterns_new
{
  my ($chains) = @_;

  for my $reduction (@REDUCTIONS)
  {
    my $plen = $#{$reduction->{PATTERN}};
    my $chain_no = 0;

    while ($chain_no <= $#$chains)
    {
      my $chain = $chains->[$chain_no];
      if ($chain->status() eq 'OPEN')
      {
        my $match = $chain->match(
          $reduction->{PATTERN}, 
          $reduction->{ANCHOR});

        if ($match >= 0)
        {
          if ($reduction->{METHOD} == 0)
          {
            my %hash = ( 
              BASE => $chain->value($match),
              OF => $chain->value($match+4));

            my $token = $chain->check_out($match);
            $token->set_counter(\%hash);
          }
          elsif ($reduction->{METHOD} == 1)
          {
            my %hash = ( 
              BASE => $chain->value($match),
              OF => $chain->value($match+2));

            my $token = $chain->check_out($match);
            $token->set_counter(\%hash);
          }
          elsif ($reduction->{METHOD} == 2)
          {
            my %hash = (BASE => $chain->value($match+2));
            my $token = $chain->check_out($match+2);
            $token->set_counter(\%hash);

            # TODO Actually have to mash them into the iterator
          }
          elsif ($reduction->{METHOD} == 3)
          {
            # TODO Actually have to mash them into the iterator
          }
          elsif ($reduction->{METHOD} == 98)
          {
            # 16 boards (numeral/iterator).
            # Like method 2, but probably don't mash.
            my %hash = (BASE => $chain->value($match));
            my $token = $chain->check_out($match);
            $token->set_counter(\%hash);
            
            $chain->swap($match, $match+2);
          }
          elsif ($reduction->{METHOD} == 99)
          {
            # Like method 2, but probably don't mash.
            my %hash = (BASE => $chain->value($match+2));
            my $token = $chain->check_out($match+2);
            $token->set_counter(\%hash);
          }
          else
          {
            die "Unknown action $reduction->{METHOD}";
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

          $chain->complete_if_last_is($reduction->{KEEP_LAST});

          if ($reduction->{SPLIT_BACK} && $match < $chain->last())
          {
            my $chain2 = $chain->split_on($match + 2);
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
