#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib '..';

use Tokens;
use Tchar;

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

# Turn the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63
# into a cleaner version:
# 1. Leave out the block with Input, Valuation, Pass stats
# 2. Leave out fields that are empty
# 3. Split TEAMS into TEAM1, TEAM2 when there are (real) teams.
# 4. Try to parse the event string in detail.

my %CATEGORIES;
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

my @PATTERNS =
(
  # Segment 3 of 7 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(PARTICLE)], VALUE => 'Of' },
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

  # Segment 3/7 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => 'SLASH' },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_SINGLE_OF', 0, 2, 'VALUE', 4, 'VALUE'],
    'ANY'
  ],

  # RR3_3 (anywhere)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => 'ARTIFICIAL' },
      { CATEGORY => [qw(NUMERAL)] },
      { CATEGORY => [qw(SEPARATOR)], VALUE => 'UNDERSCORE' },
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

  # Final 2 (from the end)
  [
    [
      { CATEGORY => [qw(ITERATOR)] },
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

  # 2 of 4 (exact)
  [
    [
      { CATEGORY => [qw(NUMERAL ORDINAL)] },
      { CATEGORY => [qw(SEPARATOR)] },
      { CATEGORY => [qw(PARTICLE)], VALUE => 'Of' },
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
      { CATEGORY => [qw(SEPARATOR)], VALUE => 'SLASH' },
      { CATEGORY => [qw(NUMERAL)] }
    ],
    [ 'COUNTER_GENERIC_OF', 0, 0, 'VALUE', 2, 'VALUE'],
    'EXACT'
  ],
);

my @FIELDS = qw(BBONO TITLE MONIKER DATE LOCATION EVENT 
  SEGMENT ROUND COUNTER
  RESTRICTION_ORIGIN FORM GENDER AGE
  SESSION SCORING TEAMS TEAM1 TEAM2);

die "perl cook.pl raw.txt" unless $#ARGV == 0;

my $file = $ARGV[0];

open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;
my $lno = 0;
my $unknown = 0;

my %event_stats;
my @chain_stats;
my $solved_count = 0;

my $time1 = 0;

while ($line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  if ($line =~ /^\s*$/)
  {
    if (defined $chunk{Input} || ! defined $chunk{BBONO})
    {
      %chunk = ();
      next;
    }
    else
    {
      if ($chunk{BBONO} == 1345)
      {
        print "HERE\n";
      }

      my (%event_chains, %event_solved);
      study_event($chunk{EVENT}, \%chunk, \%event_chains, \$unknown);

      process_event(\%event_chains, \%event_solved);

      post_process_event(\%event_chains, \%event_solved);

      while (my ($key, $chain) = each %event_chains)
      {
        $chain_stats[$#$chain + 1]++ if $#$chain >= 0;

        for my $elem (@$chain)
        {
          $event_stats{$elem->{CATEGORY}}++;
        }
      }

      $solved_count += scalar keys %event_solved;

      if (open_chains(\%event_chains))
      {
        print_chunk(\%chunk);

        print_solved(\%event_solved);

        print_chains(\%event_chains);
      }
    }
  }
  else
  {
    if ($line !~ /^([A-Za-z]+)\s+(.*)$/)
    {
      print "$lno: CAN'T PARSE $line\n";
      next;
    }

    if ($1 eq 'TEAMS')
    {
      parse_teams($2, \%chunk);
    }
    else
    {
      $chunk{$1} = $2;
    }
  }
}

close $fh;
print "TOTAL $unknown\n\n";

print "Category stats\n";
my $cat_sum = 0;
for my $key (sort keys %event_stats)
{
  printf("%6d %s\n", $event_stats{$key}, $key);
  $cat_sum += $event_stats{$key} unless $key eq 'SEPARATOR';
}
print '-' x 20, "\n";
printf "%6d Effective sum\n\n", $cat_sum;

print "Chain stats\n";
my $chain_count = 0;
my $chain_prod = 0;
for my $i (0 .. $#chain_stats)
{
  my $count = $chain_stats[$i] // 0;
  printf "%4d %6d\n", $i, $count;
  $chain_count += $count;
  $chain_prod += $count * $i;
}
print '-' x 11, "\n";
printf "%4s %6.2f\n\n", "Avg", $chain_prod / $chain_count;

print "Solved $solved_count\n";


sub print_chunk
{
  my $cref = pop;

  for my $field (@FIELDS)
  {
    if (defined $cref->{$field} && $cref->{$field} ne '')
    {
      print "$field $cref->{$field}\n";
    }
  }
  print "\n";
}


sub print_solved
{
  my $solved_ref = pop;

  my $num_keys = scalar keys %$solved_ref;
  if ($num_keys == 0)
  {
    print "Solved: Nothing\n";
    return;
  }

  print "Solved:\n";
  for my $key (sort keys %$solved_ref)
  {
    print $solved_ref->{$key}->str();
  }
  print "\n";
}


sub open_chains
{
  my $chains_ref = pop;

  my $chain_max = -1 + scalar keys %$chains_ref;

  for my $c (0 .. $chain_max)
  {
    my $chain = $chains_ref->{$c};
    return 1 if $#$chain >= 0;
  }
  return 0;
}


sub print_chains
{
  my $chains_ref = pop;

  my $chain_max = -1 + scalar keys %$chains_ref;

  my $hit = 0;
  for my $c (0 .. $chain_max)
  {
    my $chain = $chains_ref->{$c};
    next unless $#$chain >= 0;
    $hit = 1;

    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{text} } @$chain), "\n";
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{VALUE} } @$chain), "\n";
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{CATEGORY} } @$chain), "\n";
  }
  print "\n" if $hit;
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
  return ($chain_elem->{VALUE} eq $pattern_elem->{VALUE});
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
  die "Category $cat already seen" if exists $solved_ref->{$cat};
  $solved_ref->{$cat} = Tchar->new();

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
  process_patterns($chains_ref, $solved_ref);
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

