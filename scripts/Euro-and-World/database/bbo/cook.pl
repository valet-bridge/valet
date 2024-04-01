#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib '..';
use Cookbook;
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
    [ 'COUNTER_SINGLE_OF', 2, 'VALUE', 6, 'VALUE']
  ]
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
      if ($chunk{BBONO} == 20489)
      {
        print "HERE\n";
      }

      my (%event_chains, %event_solved);
      study_event($chunk{EVENT}, \%chunk, \%event_chains);

      process_event(\%event_chains, \%event_solved);

      while (my ($key, $chain) = each %event_chains)
      {
        $chain_stats[$#$chain + 1]++;

        for my $elem (@$chain)
        {
          $event_stats{$elem->{CATEGORY}}++;
        }
      }

      $solved_count += scalar keys %event_solved;

      print_chunk(\%chunk);

      print_solved(\%event_solved);

      print_chains(\%event_chains);
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


sub parse_teams
{
  my ($text, $cref) = @_;

  $text =~ s/\- npc//g;
  $text =~ s/\(npc\)//g;

  if ($text =~ /(.*) vs. (.*)/)
  {
    my ($team1, $team2) = ($1, $2);
    $team1 =~ s/\s*\(\d+\)\s*$//; # (69)
    $team2 =~ s/\s*\(\d+\)\s*$//;
    $team1 =~ s/^\s+|\s+$//g; # Leading and trailing space
    $team2 =~ s/^\s+|\s+$//g;

    my $fix1 = $FIX_HASH{lc($team1)};
    if (defined $fix1 && $fix1->{CATEGORY} eq 'COUNTRY')
    {
      $team1 = $fix1->{VALUE};
    }

    my $fix2 = $FIX_HASH{lc($team2)};
    if (defined $fix2 && $fix2->{CATEGORY} eq 'COUNTRY')
    {
      $team2 = $fix2->{VALUE};
    }

    $chunk{TEAM1} = $team1;
    $chunk{TEAM2} = $team2;
  }
  else
  {
    print "Can't parse team line $text\n";
  }
}


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


sub print_chains
{
  my $chains_ref = pop;

  my $chain_max = -1 + scalar keys %$chains_ref;

  for my $c (0 .. $chain_max)
  {
    my $chain = $chains_ref->{$c};
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{text} } @$chain), "\n";
    print "Chain $c (", 1 + $#$chain, "): ", 
      join('|', map { $_->{VALUE} } @$chain), "\n";
  }
  print "\n";
}



sub unteam
{
  my ($text, $team1, $team2) = @_;

  my $res = $text;
  $res =~ s/\Q$team1\E// if defined $team1;
  $res =~ s/\Q$team2\E// if defined $team2;
  return $res;
}


sub mash
{
  my $text = pop;
  my $res = $text;
  $res =~ s/$MERGE_REGEX/$MERGE_HASH{lc($1)}/ge;
  return $res;
}


sub split_on_known_words
{
  my ($list_ref) = @_;

  # Some entries may be mashed together.  It's easier to split them
  # out than to try to recognize them later.
  # As there can be several layers of this, we do it recursively.
  # Not very efficiently implemented: Don't have to reexamine elements
  # that could not be split once.
  
  my $hit = 1;
  my $ctr = 0;
  while ($hit)
  {
    $ctr++;
    $hit = 0;
    for my $i (reverse 0 .. $#$list_ref)
    {
      my $part = lc($list_ref->[$i]);
      my $fix = $FIX_HASH{$part};
      next if defined $fix->{VALUE};

      if ($part =~ $FRONT_REGEX)
      {
        my ($front, $back) = ($1, $2);
        splice(@$list_ref, $i, 0, ('') x 2);
        $list_ref->[$i  ] = $front;
        $list_ref->[$i+1] = '|';
        $list_ref->[$i+2] = $back;
        $hit = 1;
        last;
      }

      next if $hit;

      if ($part =~ $BACK_REGEX)
      {
        my ($front, $back) = ($1, $2);
        splice(@$list_ref, $i, 0, ('') x 2);
        $list_ref->[$i  ] = $front;
        $list_ref->[$i+1] = '|';
        $list_ref->[$i+2] = $back;
        $hit = 1;
        last;
      }
    }
  }
}


sub split_on_digit_groups
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];

    if ($part =~ /\d/ && $part =~ /[^\d]/ &&
      ! is_small_ordinal($part))
    {
      my @a = grep {$_ ne ''} split /(\d+)/, $part;
      die "No real split: $part" unless $#a > 0;

      if ($#a == 1 && $a[0] =~ /^rof$/i)
      {
        # Don't split Rof128 etc.
        next;
      }

      my $add = 2 * $#a - 1;
      splice(@$list_ref, $i, 0, ('') x $add);
      for my $j (0 .. $#a)
      {
        $list_ref->[$i + 2*$j] = $a[$j];
        $list_ref->[$i + 2*$j + 1] = '|';
      }
    }
  }
}


sub split_on_pre_group
{
  my ($list_ref, $part, $i) = @_;

  if ($part =~ $PRE_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);
    splice(@$list_ref, $i, 0, ('') x 2);

    my $fix = $FIX_HASH{lc($front)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $front";
    }

    $list_ref->[$i  ] = $fix->{VALUE};
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $back;
    return 1;
  }
  return 0;
}


sub split_on_post_group
{
  my ($list_ref, $part, $i) = @_;

  if ($part =~ $POST_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);
    splice(@$list_ref, $i, 0, ('') x 2);

    my $fix = $FIX_HASH{lc($back)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $back";
    }

    $list_ref->[$i  ] = ($front eq 'W' ? 'Women' : 'Open');
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $fix->{VALUE};
    return 1;
  }
  return 0;
}


sub split_on_tournament_group
{
  my ($list_ref) = @_;

  # A number of words are commonly followed by A or B.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];

    next if split_on_pre_group($list_ref, $part, $i);

    next if split_on_post_group($list_ref, $part, $i);

    # Kludge.
    if ($part eq 'OR')
    {
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'Open';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = 'Room';
      
    }
    elsif ($part eq 'or')
    {
      $list_ref->[$i  ] = 'Of'; # Typically a typo
    }
  }
}


sub split_on_date
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];

    next unless $part =~ /^\d+$/ && $part > 19000000;

    if ($part =~ /^(\d\d\d\d)(\d\d)(\d\d)0(\d)$/)
    {
      # Only really used once.
      my ($year, $month, $day, $r) = ($1, $2, $3, $4);
      splice(@$list_ref, $i, 0, ('') x 4);
      $list_ref->[$i  ] = "$year-$month-$day";
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = "Round";
      $list_ref->[$i+3] = '|';
      $list_ref->[$i+4] = $r;
    }
    else
    {
      die "Probably a date? $part";
    }
  }
}


sub is_separator
{
  my ($part, $study_ref) = @_;

  if ($part =~ /^\s+$/)
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SPACE';
    return 1;
  }
  elsif ($part eq '.')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'DOT';
    return 1;
  }
  elsif ($part eq ':')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'COLON';
    return 1;
  }
  elsif ($part eq ';')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SEMICOLON';
    return 1;
  }
  elsif ($part eq '-')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'DASH';
    return 1;
  }
  elsif ($part eq '_')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'UNDERSCORE';
    return 1;
  }
  elsif ($part eq '+')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'PLUS';
    return 1;
  }
  elsif ($part eq '/')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SLASH';
    return 1;
  }
  elsif ($part eq '(')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'LEFT_PAREN';
    return 1;
  }
  elsif ($part eq ')')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'RIGHT_PAREN';
    return 1;
  }
  elsif ($part eq '"')
  {
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'QUOTE';
    return 1;
  }
  elsif ($part eq '|')
  {
    # Artificial separator made when unmashing.
    $study_ref->{CATEGORY} = 'SEPARATOR';
    $study_ref->{VALUE} = 'ARTIFICIAL';
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_small_integer
{
  my ($part, $study_ref) = @_;

  # Up to 100
  if ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $study_ref->{CATEGORY} = 'NUMERAL';
    $part =~ s/^0+//; # Remove leading zeroes
    $study_ref->{VALUE} = $part;
    return 1;
  }
  elsif ($part =~ /^#(\d+)$/ && $1 >= 0 && $1 < 100)
  {
    # #10
    my $n = $1;
    $n =~ s/^0+//; # Remove leading zeroes

    $study_ref->{CATEGORY} = 'NUMERAL';
    $study_ref->{VALUE} = $n;
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_small_ordinal
{
  my $part = pop;
  if
     ($part =~ /^(\d+)th$/i ||
      $part =~ /^(\d+)rth$/i ||
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rst$/i ||
      $part =~ /^(\d+)rd$/i ||
      $part =~ /^(\d+)er$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    return $1;
  }
  else
  {
    return 0;
  }
}


sub fix_small_ordinal
{
  my ($part, $study_ref) = @_;
  if (my $ord = is_small_ordinal($part))
  {
    # We don't check whether the ending matches the number.
    if ($ord >= 0 && $ord < 100)
    {
      $study_ref->{CATEGORY} = 'ORDINAL';
      $ord =~ s/^0+//; # Remove leading zeroes
      $study_ref->{VALUE} = $ord;
      return 1;
    }
    else
    {
      die "Large ordinal? $part";
    }
  }
  else
  {
    return 0;
  }
}


sub is_letter
{
  my ($part, $study_ref) = @_;

  if ($part =~ /^[A-Za-z]$/)
  {
    $study_ref->{CATEGORY} = 'LETTER';
    $study_ref->{VALUE} = $part;
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_date
{
  my ($part, $study_ref) = @_;

  if ($part =~ /^\d\d\d\d$/)
  {
    if ($part >= 1900 && $part <= 2100)
    {
      $study_ref->{CATEGORY} = 'YEAR';
      $study_ref->{VALUE} = $part;
      return 1;
    }
    else
    {
      die "Not a year? $part";
    }
  }
  elsif ($part =~ /^\d\d\d\d-\d\d-\d\d$/)
  {
    $study_ref->{CATEGORY} = 'DATE';
    $study_ref->{VALUE} = $part;
    return 1;
  }
  else
  {
    return 0;
  }
}


sub kill_studied
{
  my ($list_ref) = @_;

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
}


sub study_part
{
  # Returns 1 if it is a kill.

  my ($part, $study_ref) = @_;

  return if is_separator($part, $study_ref);

  my $fix = $FIX_HASH{lc($part)};
  if (defined $fix->{CATEGORY})
  {
    $study_ref->{CATEGORY} = $fix->{CATEGORY};
    $study_ref->{VALUE} = $fix->{VALUE};
    return ($fix->{CATEGORY} eq 'KILL');
  }

  return 0 if is_small_integer($part, $study_ref);
  return 0 if fix_small_ordinal($part, $study_ref);
  return 0 if is_letter($part, $study_ref);
  return 0 if is_date($part, $study_ref);

  print "UNKNOWN $part\n";
  $unknown++;
  $study_ref->{CATEGORY} = 'UNKNOWN';
  $study_ref->{VALUE} = $part;
  return 0;
}


sub study_event
{
  my ($text, $cref, $chains_ref) = @_;

  if ($cref->{BBONO} >= 4790 && $cref->{BBONO} <= 4860 &&
      $cref->{TITLE} =~ /^Buffet/)
  {
    # I think we can discard these.
    return;
  }

  # First remove team names that are entirely duplicated.
  my $mashed = unteam($text, $cref->{TEAM1}, $cref->{TEAM2});

  # Then mash some adjacent, separate words together because
  # they obviously belong together.
  $mashed = mash($mashed);

  # Split on separators.
  my @parts = grep {$_ ne ''} split /([.\-\+_:;"\/\(\)]|\s+)/, $mashed;

  # Separate words that runs into each other.
  split_on_known_words(\@parts);

  # Split on groups of digits.
  split_on_digit_groups(\@parts);

  # Split some known words + A or B at the end.
  split_on_tournament_group(\@parts);

  # Split on ISO date.
  split_on_date(\@parts);

  # Make a semantic, studied version of the event.
  my $kill_flag = 0;

  for my $i (0 .. $#parts)
  {
    $chains_ref->{0}[$i]{text} = $parts[$i];
    $chains_ref->{0}[$i]{position_first} = $i;
    $chains_ref->{0}[$i]{position_last} = $i;

    $kill_flag = 1 if study_part($parts[$i], \%{$chains_ref->{0}[$i]});

    my $elem = $chains_ref->{0}[$i];
    if ($elem->{CATEGORY} eq 'COUNTRY' &&
       ($elem->{VALUE} eq $cref->{TEAM1} ||
        $elem->{VALUE} eq $cref->{TEAM2}))
    {
      # It could be that the country name is spelled differently
      # in EVENT and TEAMS.
      $elem->{CATEGORY} = 'KILL';
    }
  }

  kill_studied(\@{$chains_ref->{0}}) if $kill_flag;
}


sub split_chain_on
{
  my ($chains_ref, $chain_no, $chain_max_ref, $elem, $elem_no) = @_;

  my $chain_length = $#{$chains_ref->{$chain_no}};

  if ($elem_no < $chain_length)
  {
    die "Expected separator" unless 
      $chains_ref->{$chain_no}[$elem_no+1]{CATEGORY} eq 'SEPARATOR';

    $elem->{position_last}++;
    $elem->{text} .= $chains_ref->{$chain_no}[$elem_no+1]{VALUE};

    if ($elem_no +1 < $chain_length)
    {
      # Make the number of the new partial chain.
      $$chain_max_ref++;

      # Skip the trailing separator.
      @{$chains_ref->{$$chain_max_ref}} = 
        @{$chains_ref->{$chain_no}}[$elem_no+2 .. $chain_length];
    }
  }

  # Remove elements in the original chain.
  my $last;
  if ($elem_no > 0)
  {
    die "Expected separator" unless
      $chains_ref->{$chain_no}[$elem_no-1]{CATEGORY} eq 'SEPARATOR';
    
    $last = $elem_no-1;

    $elem->{position_first}--;
    $elem->{text} = $chains_ref->{$chain_no}[$elem_no-1]{VALUE} .
      $elem->{text};
  }
  else
  {
    $last = 0;
  }

  splice (@{$chains_ref->{$chain_no}}, $elem_no);
}


sub process_singletons
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = 0;

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
  my ($elem, $chain, $start_index, $plen) = @_;

  # Before we splice out the matched elements, we keep some
  # information from them.

  for my $p (1 .. $plen)
  {
    $elem->{text} .= $chain->[$start_index + $p]{text};
  }

  $elem->{position_last} = $chain->[$start_index + $plen]{position_last};
}


sub make_arg_list
{
  my ($chain, $start_index, $reaction, $arg_list_ref) = @_;

  for (my $r = 1; $r <= $#$reaction; $r += 2)
  {
    my $pos = $start_index + $reaction->[$r];
    push @$arg_list_ref, $chain->[$pos]{$reaction->[$r+1]};
  }
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

      my $start_index = 0;
      while ($start_index + $plen <= $#$chain)
      {
        if (pattern_match($chain, $start_index, $pattern->[0], $plen))
        {
          my $cat = $chain->[$start_index]{VALUE};
          die "Category $cat already seen" if exists $solved_ref->{$cat};
          $solved_ref->{$cat} = Tchar->new();

          my $reaction = $pattern->[1];

          my @arg_list;
          make_arg_list($chain, $start_index, $reaction, \@arg_list);

          my $elem = $chain->[$start_index];
          collapse_elements($elem, $chain, $start_index, $plen);

          splice(@$chain, $start_index+1, $plen);

          $solved_ref->{$cat}->set($reaction->[0], $elem, @arg_list);

          split_chain_on($chains_ref, $chain_no, \$chain_max,
            $elem, $start_index);
        }

        $start_index += 2;
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub process_event
{
  my ($chains_ref, $solved_ref) = @_;

  process_singletons($chains_ref, $solved_ref);
  process_separators($chains_ref);
  process_patterns($chains_ref, $solved_ref);
}
