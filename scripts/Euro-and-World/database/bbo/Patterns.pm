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

my @PATTERNS_NEW =
(
  # 3 of 7 (anywhere).
  # 1. The pattern.
  # 2. The anchor.
  # 3. The index of the method used to react.
  # 4. 1 if we split on the front.
  # 5. 1 if we split after the back.
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(SINGLETON)], 
        FIELD => [qw(Particle)],
        VALUE => [qw(Of)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    'ANY',
    0,
    0,
    1
  ]
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

  for my $overall_pattern (@PATTERNS_NEW)
  {
    my $pattern = $overall_pattern->[0];
    my $anchor = $overall_pattern->[1];
    my $action = $overall_pattern->[2];
    my $split_front = $overall_pattern->[3];
    my $split_back = $overall_pattern->[4];
    my $plen = $#$pattern;

    my $chain_no = 0;
    while ($chain_no <= $#$chains)
    {
      my $chain = $chains->[$chain_no];
      if ($chain->status() eq 'OPEN')
      {
        my $match = $chain->match($pattern, $anchor);
        if ($match >= 0)
        {
          if ($action == 0)
          {
            my %hash = ( 
              BASE => $chain->value($match),
              OF => $chain->value($match+4));

            my $token = $chain->check_out($match);
            $token->set_counter(\%hash);
          }
          else
          {
            die "Unknown action $action";
          }

          $chain->collapse_elements($match, $match + $plen);
          $chain->delete($match+1, $match + $plen);
          $chain->complete_if_one();

          if ($split_back && $match < $chain->last())
          {
            my $chain2 = $chain->split_on($match + $plen + 2);
            $chain->complete_if_one();
            $chain2->complete_if_one();
            splice(@$chains, $chain_no+1, 0, $chain2);
          }

          if ($split_front && $match > 0)
          {
            my $chain2 = $chain->split_on($match);
            $chain->complete_if_one();
            $chain2->complete_if_one();
            splice(@$chains, $chain_no+1, 0, $chain2);
          }
        }
      }
    }
  }
}

1;
