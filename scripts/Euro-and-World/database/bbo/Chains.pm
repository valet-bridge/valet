#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

package Chains;

use lib '.';
use lib '..';

use Tchar;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  process_event
  post_process_event
  split_chain_on
  %CATEGORIES);

use Age;
use City;
use Country;
use Form;
use Gender;
use Memorial;
use Movement;
use Organizer;
use Origin;
use Scoring;
use Sponsor;
use Tname;
use Weekday;

our %CATEGORIES;
$CATEGORIES{AGE} = Age->new();
$CATEGORIES{CITY} = City->new();
$CATEGORIES{COUNTRY} = Country->new();
$CATEGORIES{FORM} = Form->new();
$CATEGORIES{GENDER} = Gender->new();
$CATEGORIES{MEMORIAL} = Memorial->new();
$CATEGORIES{MOVEMENT} = Movement->new();
$CATEGORIES{ORGANIZER} = Organizer->new();
$CATEGORIES{ORIGIN} = Origin->new();
$CATEGORIES{SCORING} = Scoring->new();
$CATEGORIES{SPONSOR} = Sponsor->new();
$CATEGORIES{TNAME} = Tname->new();
$CATEGORIES{WEEKDAY} = Weekday->new();


my @SIMPLE_LIST = qw(NUMERAL ORDINAL LETTER SEPARATOR);
my %SIMPLE_CATEGORIES = map { $_ => 1} @SIMPLE_LIST;


sub split_chain_on
{
  my ($chains_ref, $chain_no, $chain_max_ref, $elem, $elem_no) = @_;

  my $chain_length = $#{$chains_ref->{$chain_no}};

  if ($elem_no < $chain_length)
  {
    my $next_real_elem;
    if ($chains_ref->{$chain_no}[$elem_no+1]{CATEGORY} eq 'SEPARATOR')
    {
      $elem->{position_last} =
       $chains_ref->{$chain_no}[$elem_no+1]{position_last};
      $elem->{text} .= 
        $chains_ref->{$chain_no}[$elem_no+1]{VALUE};

      $next_real_elem = $elem_no + 2;
    }
    else
    {
      $next_real_elem = $elem_no + 1;
    }

    if ($next_real_elem <= $chain_length)
    {
      # Make the number of the new partial chain.
      $$chain_max_ref++;

      # Skip the trailing separator.
      @{$chains_ref->{$$chain_max_ref}} = 
        @{$chains_ref->{$chain_no}}[$next_real_elem .. $chain_length];
    }
  }

  # Remove elements in the original chain.
  my $first_removed_elem;
  if ($elem_no > 0)
  {
    if ($chains_ref->{$chain_no}[$elem_no-1]{CATEGORY} eq 'SEPARATOR')
    {
      $elem->{position_first} =
        $chains_ref->{$chain_no}[$elem_no-1]{position_first};
      $elem->{text} = $chains_ref->{$chain_no}[$elem_no-1]{VALUE} .
        $elem->{text};

      $first_removed_elem = $elem_no - 1;
    }
    else
    {
      $first_removed_elem = $elem_no;
    }
  }
  else
  {
    $first_removed_elem = 0;
  }

  splice (@{$chains_ref->{$chain_no}}, $first_removed_elem);
}


sub split_on_space_dashes
{
  my ($chains_ref) = @_;

  my $chain_no = 0;
  my $chain_max = 0;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    my $elem_no = 0;
    for my $elem (@$chain)
    {
      if ($elem_no > 0 && $elem_no < $#$chain)
      {
        # Don't split on ends -- they get removed later anyway.
        if ($elem->{CATEGORY} eq 'SEPARATOR' &&
            $elem->{VALUE} eq 'DASH')
        {
          my $first = $elem_no;
          my $last = $elem_no;

          my $pred = $chain->[$elem_no-1];
          if ($pred->{CATEGORY} eq 'SEPARATOR' &&
              $pred->{VALUE} eq 'SPACE')
          {
            $first--;
          }

          my $succ = $chain->[$elem_no+1];
          if ($succ->{CATEGORY} eq 'SEPARATOR' &&
              $succ->{VALUE} eq 'SPACE')
          {
            $last++;
          }

          if ($first != $last)
          {
            # Found at least one neighboring space.
            splice(@$chain, $first+1, $last-$first);
           
            split_chain_on($chains_ref, $chain_no, \$chain_max, 
              $elem, $first);
          }
          last;
        }
      }

      $elem_no++;
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub split_on_most_parentheses
{
  my ($chains_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    my $elem_no = 0;
    for my $elem (@$chain)
    {
      if ($elem_no > 0 && $elem_no < $#$chain)
      {
        # Don't split on ends -- they get removed later anyway.
        if ($elem->{CATEGORY} eq 'SEPARATOR' &&
            $elem->{VALUE} eq 'LEFT_PAREN')
        {
          # Special case: Don't split on "(of".
          my $succ = $chain->[$elem_no+1];
          next if ($succ->{CATEGORY} eq 'PARTICLE' &&
              $succ->{VALUE} eq 'Of');

          my $last_real = $elem_no+1;
          while ($last_real <= $#$chain && 
            ($chain->[$last_real]{CATEGORY} ne 'SEPARATOR' ||
             $chain->[$last_real]{VALUE} ne 'RIGHT_PAREN'))
          {
            $last_real++;
          }

          my $last_paren;
          if ($last_real > $#$chain)
          {
            $last_real = $#$chain;
            $last_paren = $last_real; # No closing parenthesis
          }
          else
          {
            $last_paren = $last_real;
            $last_real--;
          }

          # So now the content is in [elem_no+1, last_real],
          # and the whole parenthesis construct is in 
          # [elem_no, last_paren].

          # Move the content to a new chain.
          $chain_max++;
          @{$chains_ref->{$chain_max}} = 
            @{$chains_ref->{$chain_no}}[$elem_no+1 .. $last_real];

          # Delete the whole range.
          splice(@$chain, $elem_no, $last_paren - $elem_no + 1);

          last;
        }
      }
      $elem_no++;
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub split_on_some_iterators
{
  my ($chains_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    my $elem = $chain->[0];

    # Look for a string of elements starting with ITERATOR
    # and only using ORDINAL, NUMERAL, PARTICLE and LETTER
    # until the next ITERATOR.

    if ($#$chain >= 1 && $elem->{CATEGORY} eq 'ITERATOR')
    {
      my $ok = 1;
      my $elem_no = 1;
      while ($elem_no <= $#$chain)
      {
        my $cat = $chain->[$elem_no]{CATEGORY};
        last if $cat eq 'ITERATOR';

        if (! exists $SIMPLE_CATEGORIES{$cat})
        {
          $ok = 0;
          last;
        }
        $elem_no++;
      }

      if ($ok && $elem_no < $#$chain)
      {
        # Split from $elem_no onward into a new chain.
        $chain_max++;
        @{$chains_ref->{$chain_max}} = 
          @{$chains_ref->{$chain_no}}[$elem_no .. $#$chain];

        # Delete the corresponding range from this chain.
        splice(@$chain, $elem_no-1);
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub process_singletons
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $elem_no = 0;
    for my $elem (@{$chains_ref->{$chain_no}})
    {
      my $hit = 0;
      if ($elem->{CATEGORY} eq 'AGE')
      {
        $elem->{VALUE} = $CATEGORIES{AGE}->guess($elem->{VALUE});
        $hit = 1;
      }
      elsif ($elem->{CATEGORY} eq 'DATE')
      {
        $hit = 1;
      }
      elsif (defined $CATEGORIES{$elem->{CATEGORY}})
      {
        if (! $CATEGORIES{$elem->{CATEGORY}}->valid($elem->{VALUE}))
        {
          die "No " . lc($elem->{CATEGORY}) . ": $elem->{VALUE}";
        }
        $hit = 1;
      }

      if ($hit)
      {
        split_chain_on($chains_ref, $chain_no, \$chain_max,
          $elem, $elem_no);

        # Copy out the element that has been solved.
        my $cat = $elem->{CATEGORY};
        warn "Category $cat already seen" if exists $solved_ref->{$cat};
        $solved_ref->{$cat} = Tchar->new();
        $solved_ref->{$cat}->set('SINGLETON', $elem);

        last;
      }

      $elem_no++;
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub process_separators
{
  my ($chains_ref) = @_;

  # Don't start or end with one.
  # Don't have two next to one another.

  while (my ($key, $chain) = each %$chains_ref)
  {
    next if ($#$chain == -1);

    # Leading separators.
    while ($chain->[0]{CATEGORY} eq 'SEPARATOR')
    {
      if ($#$chain >= 1)
      {
        $chain->[1]{text} = $chain->[0]{text} . $chain->[1]{text};
        $chain->[1]{position_first} = $chain->[0]{position_first};
        if ($chain->[1]{CATEGORY} eq 'SEPARATOR')
        {
          $chain->[1]{VALUE} = 'ARTIFICIAL';
        }
      }
      splice(@$chain, 0, 1);
      last if ($#$chain == -1);
    }
    next if ($#$chain <= 0);

    # Trailing separators.
    while ($chain->[-1]{CATEGORY} eq 'SEPARATOR')
    {
      if ($#$chain >= 1)
      {
        $chain->[-2]{text} .= $chain->[-1]{text};
        $chain->[-2]{position_last} = $chain->[-1]{position_last};
        if ($chain->[-2]{CATEGORY} eq 'SEPARATOR')
        {
          $chain->[-2]{VALUE} = 'ARTIFICIAL';
        }
      }
      splice(@$chain, -1);
      last if ($#$chain == -1);
    }
    next if ($#$chain <= 0);

    for my $i (reverse 0 .. $#$chain)
    {
      # The chain now does not start nor end with a separator,
      # and it has at least two elements.
      if ($chain->[$i]{CATEGORY} eq 'SEPARATOR' &&
          $chain->[$i-1]{CATEGORY} eq 'SEPARATOR')
      {
        $chain->[$i-1]{text} .= $chain->[$i]{text};
        $chain->[$i-1]{position_last} = $chain->[$i]{position_last};
        $chain->[$i-1]{VALUE} = 'ARTIFICIAL';
        splice(@$chain, $i, 1);
      }
    }
  }
}


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
    $cat = $chain->[$index]{VALUE};
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


sub process_event
{
  my ($chains_ref, $solved_ref) = @_;

  # Split on a dash with a space to its left and/or right.
  # This seems quite reliable.
  split_on_space_dashes($chains_ref);

  # In general turn parenthesis-enclosed text into a chain,
  # but not e.g. "of 7".
  split_on_most_parentheses($chains_ref);

  process_singletons($chains_ref, $solved_ref);
  process_separators($chains_ref);

  split_on_some_iterators($chains_ref);
}


sub synthetic_singleton
{
  my ($solved_ref, $elem, $category, $die_flag) = @_;

  if (exists $solved_ref->{$category})
  {
    die "Already $category?" if $die_flag;
    return;
  }

  $elem->{CATEGORY} = $category;

  $solved_ref->{$category} = Tchar->new();
  $solved_ref->{$category}->set('SINGLETON', $elem);
}


sub fix_some_singletons_manually
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    if ($#$chain == 0)
    {
      my $elem = $chain->[0];
      if (($elem->{CATEGORY} eq 'TOURNAMENT' && $elem->{VALUE} eq 'Open') ||
          ($elem->{CATEGORY} eq 'LETTER' && $elem->{VALUE} eq 'O'))
      {
        $elem->{VALUE} = 'Open';

        # This should mean no gender nor age restriction.
        synthetic_singleton($solved_ref, $elem, 'AGE', 0);
        synthetic_singleton($solved_ref, $elem, 'GENDER', 0);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'GENDER')
      {
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'LETTER' && $elem->{VALUE} eq 'W')
      {
        $elem->{VALUE} = 'Women';
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'LETTER' && $elem->{VALUE} eq 'J')
      {
        $elem->{VALUE} = 'Juniors';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'LETTER' && $elem->{VALUE} eq 'Y')
      {
        $elem->{VALUE} = 'Youngsters';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'LETTER' &&
        $elem->{VALUE} =~ /^[A-Fa-f]$/)
      {
        # This should mean no group.
        synthetic_singleton($solved_ref, $elem, 'GROUP', 1);

        splice(@$chain, 0);
      }
      elsif ($elem->{CATEGORY} eq 'YEAR')
      {
        synthetic_singleton($solved_ref, $elem, 'YEAR', 1);

        splice(@$chain, 0);
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub post_process_event
{
  my ($chains_ref, $solved_ref) = @_;
  
  # More manual processing of some short chains.

  fix_some_singletons_manually($chains_ref, $solved_ref);
}

1;
