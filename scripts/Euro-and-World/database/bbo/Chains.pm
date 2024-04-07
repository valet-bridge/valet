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
  kill_studied
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


sub kill_studied
{
  my ($list_ref, $chains) = @_;

  # Some entries should be skipped.

  for my $i (reverse 0 .. $#$list_ref)
  {
    # Can happen when deleting from the back
    next unless $i <= $#$list_ref;

    my $part = $list_ref->[$i];
    if ($part->{CATEGORY} eq 'KILL')
    {
      if ($i == $#$list_ref)
      {
        # From the back
        if ($i == 0)
        {
          splice(@$list_ref, 0);
        }
        else
        {
          splice(@$list_ref, $i-1, 2);
        }
      }
      elsif ($i == 0)
      {
        # From the front
        splice(@$list_ref, $i, 2);
      }
      elsif ($list_ref->[$i-1]{VALUE} eq 'SPACE' ||
             $list_ref->[$i-1]{VALUE} eq 'SLASH' ||
             $list_ref->[$i-1]{VALUE} eq 'ARTIFICIAL')
      {
        # Surrounded by spaces, so kill one of them.
        splice(@$list_ref, $i, 2);
      }
      elsif ($list_ref->[$i-1]{VALUE} eq 'LEFT_PAREN' &&
             $list_ref->[$i+1]{VALUE} eq 'RIGHT_PAREN')
      {
        # Surrounded by parentheses.
        splice(@$list_ref, $i, 2);
        $list_ref->[$i-1]{VALUE} = 'SPACE';
      }
      else
      {
        die "Don't know how to kill this: $part->{VALUE}";
      }
    }
  }

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];

    $chain->clean_separators();

    for my $index (0 .. $chain->last())
    {
      next unless $chain->category($index) eq 'KILL';

      my $chain2 = $chain->kill_on($index);
      if (defined $chain2)
      {
        splice(@$chains, $chain_no+1, 0, $chain2);
        last;
      }
    }
    $chain_no++;
  }
}


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
      if ($elem->{CATEGORY} eq 'DATE')
      {
        # TODO Maybe also gets a valid() method
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
  my ($chains_ref, $solved_ref, $chains) = @_;

  # TODO More like split_on_kill
  kill_studied(\@{$chains_ref->{0}}, $chains);

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
      my $cat = $elem->{CATEGORY};
      my $value = $elem->{VALUE};

      if (($cat eq 'TOURNAMENT' && $value eq 'Open') ||
          ($cat eq 'LETTER' && $value eq 'O'))
      {
        $elem->{VALUE} = 'Open';

        # This should mean no gender nor age restriction.
        synthetic_singleton($solved_ref, $elem, 'AGE', 0);
        synthetic_singleton($solved_ref, $elem, 'GENDER', 0);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'TOURNAMENT')
      {
        if ($value ne 'Super')
        {
          synthetic_singleton($solved_ref, $elem, 'TOURNAMENT', 1);
        }

        splice(@$chain, 0);
      }
      elsif ($cat eq 'GROUP' || $cat eq 'BOARDS')
      {
        splice(@$chain, 0);
      }
      elsif ($cat eq 'GENDER' || $cat eq 'TEMPORAL')
      {
        synthetic_singleton($solved_ref, $elem, $cat, 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'W')
      {
        $elem->{VALUE} = 'Women';
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'J')
      {
        $elem->{VALUE} = 'Juniors';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'Y')
      {
        $elem->{VALUE} = 'Youngsters';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'K')
      {
        $elem->{VALUE} = 'Kids';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($chain_no == 0 && $cat eq 'LETTER' && $value eq 'G')
      {
        $elem->{VALUE} = 'Juniors';
        synthetic_singleton($solved_ref, $elem, 'AGE', 0);

        $elem->{VALUE} = 'Women';
        synthetic_singleton($solved_ref, $elem, 'GENDER', 0);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value =~ /^[A-Ha-h]$/)
      {
        # This should mean no group.
        synthetic_singleton($solved_ref, $elem, 'GROUP', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'ROMAN' && ($value == 1 || $value == 5))
      {
        # Tends to be a leftover from A v B.
        # Not sure about I, but it's rare.

        splice(@$chain, 0);
      }
      elsif ($cat eq 'YEAR')
      {
        synthetic_singleton($solved_ref, $elem, 'YEAR', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'PARTICLE' && 
          ($elem->{text} eq 'OF' || $elem->{text} eq 'FO'))
      {
        # Tends to be OF for Open Final.

        $elem->{VALUE} = 'Open';

        # This should mean no gender nor age restriction.
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        die "Already $cat?" if exists $solved_ref->{Final};

        $elem->{CATEGORY} = 'ITERATOR';
        $elem->{VALUE} = 'Final';
        $solved_ref->{Final} = Tchar->new();
        $solved_ref->{Final}->set('COUNTER_NONE', $elem);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'PARTICLE' && $value eq 'vs')
      {
        # Delete
        splice(@$chain, 0);
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub fix_some_tripletons_manually
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    if ($#$chain == 2)
    {
      my $elem0 = $chain->[0];
      my $elem1 = $chain->[1];
      my $elem2 = $chain->[2];

      if ($elem0->{CATEGORY} eq 'NUMERAL' &&
          $elem2->{CATEGORY} eq 'LETTER')
      {
        # 2 B: Treat this as a generic counter with two values.

        my $category = 'Generic';
        die "Already $category?" if exists $solved_ref->{$category};

        $elem0->{CATEGORY} = $category;

        $solved_ref->{$category} = Tchar->new();
        $solved_ref->{$category}->set('COUNTER_DOUBLE', $elem0,
          $elem0->{VALUE}, $elem2->{VALUE});

        splice(@$chain, 0);
      }
      elsif ($elem0->{CATEGORY} eq 'LETTER' &&
          $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # B 2.

        my $category = 'Generic';
        die "Already $category?" if exists $solved_ref->{$category};

        $elem0->{CATEGORY} = $category;

        $solved_ref->{$category} = Tchar->new();
        $solved_ref->{$category}->set('COUNTER_DOUBLE', $elem0,
          $elem2->{VALUE}, $elem0->{VALUE});

        splice(@$chain, 0);
      }
      elsif ($elem0->{CATEGORY} eq 'MONTH' &&
             $elem2->{CATEGORY} eq 'YEAR')
      {
        # YEAR_MONTH
        # About 5 cases
        print "XXX2\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ORDINAL' &&
             $elem2->{CATEGORY} eq 'ORDINAL')
      {
        # 5th eighth, so generic counter 5 of 8.
        # About 26 cases
        print "XXX3\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem1->{CATEGORY} eq 'SEPARATOR' &&
             $elem1->{text} =~ /_/ &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 2 _ 2, so generic counter 2 of 2.
        # About 84 cases
        print "XXX4\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem1->{CATEGORY} eq 'SEPARATOR' &&
             $elem1->{VALUE} eq 'COLON' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 5:2, so round 5 segment 2.
        # About 250 cases
        print "XXX5\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 140
        print "XXX6\n";
      }
      elsif ($elem0->{CATEGORY} eq 'TOURNAMENT' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 86
        print "XXX7\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem2->{CATEGORY} eq 'TOURNAMENT')
      {
        # 4
        print "XXX7a\n";
      }
      elsif ($elem0->{CATEGORY} eq 'TOURNAMENT' &&
             $elem2->{CATEGORY} eq 'ITERATOR')
      {
        # 26
        print "XXX8\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'TOURNAMENT')
      {
        # 36
        print "XXX9\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'ITERATOR')
      {
        # 79
        print "XXX10\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'LETTER')
      {
        # 292
        print "XXX11\n";
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
  fix_some_tripletons_manually($chains_ref, $solved_ref);
}

1;
