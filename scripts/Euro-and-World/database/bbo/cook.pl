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

use Age;
use Sponsor;

# Turn the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63
# into a cleaner version:
# 1. Leave out the block with Input, Valuation, Pass stats
# 2. Leave out fields that are empty
# 3. Split TEAMS into TEAM1, TEAM2 when there are (real) teams.
# 4. Try to parse the event string in detail.

my $age = Age->new();
my $sponsor = Sponsor->new();

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
      if ($chunk{BBONO} == 19947)
      {
        print "HERE\n";
      }

      my @studied_event;
      study_event($chunk{EVENT}, \%chunk, \@studied_event);

      process_event(\@studied_event);

      for my $elem (@studied_event)
      {
        if ($elem->{CATEGORY} eq 'AGE')
        {
          print "HERE\n";
        }
        $event_stats{$elem->{CATEGORY}}++ unless exists $elem->{STATUS};
      }


      print_chunk(\%chunk);
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

for my $key (sort keys %event_stats)
{
  printf("%6d %s\n", $event_stats{$key}, $key);
}


sub parse_teams
{
  my ($text, $cref) = @_;

  if ($text =~ /(.*) vs. (.*)/)
  {
    my ($team1, $team2) = ($1, $2);
    $team1 =~ s/\s*\(\d+\)\s*$//;
    $team2 =~ s/\s*\(\d+\)\s*$//;
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
        splice(@$list_ref, $i-1, 2);
      }
      elsif ($i == 0)
      {
        # From the front
        splice(@$list_ref, $i, 2);
      }
      elsif ($list_ref->[$i-1]{VALUE} eq 'SPACE' ||
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
  my ($text, $cref, $sref) = @_;

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
    $sref->[$i]{TEXT} = $parts[$i];
    $kill_flag = 1 if study_part($parts[$i], \%{$sref->[$i]});
  }

  kill_studied($sref) if $kill_flag;
}


sub process_singletons
{
  my ($sref) = @_;

  for my $elem (@$sref)
  {
    if ($elem->{CATEGORY} eq 'AGE')
    {
      $elem->{VALUE} = $age->guess($elem->{VALUE});
      $elem->{STATUS} = 'FINAL';
    }
    elsif ($elem->{CATEGORY} eq 'SPONSOR')
    {
      die "No sponsor $elem->{VALUE}" unless 
        $sponsor->valid($elem->{VALUE});
      $elem->{STATUS} = 'FINAL';
    }
  }
}


sub process_event
{
  my ($sref) = @_;

  process_singletons($sref);
}
