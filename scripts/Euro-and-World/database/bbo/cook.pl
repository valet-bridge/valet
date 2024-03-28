#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Cookbook;

# Turn the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63
# into a cleaner version:
# 1. Leave out the block with Input, Valuation, Pass stats
# 2. Leave out fields that are empty
# 3. Split TEAMS into TEAM1, TEAM2 when there are (real) teams.
# 4. Try to parse the event string in detail.

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
      if ($chunk{BBONO} == 5925)
      {
        print "HERE\n";
      }

      study_event($chunk{EVENT}, \%chunk);

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
print "TOTAL $unknown\n";


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
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rd$/i ||
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


sub is_year
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
  else
  {
    return 0;
  }
}


sub mash
{
  my $text = pop;

  my $res = $text;
  for my $key (keys %MERGE_HASH)
  {
    $res =~s/\b$key\b/$MERGE_HASH{$key}/gi;
  }
  return $res;
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


sub unmash
{
  my ($list_ref) = @_;

  # Some entries may be mashed together.  It's easier to split them
  # out than to try to recognize them later.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];

    if ($part =~ /\b([A-Z][a-z]+)([A-Z][a-z]+)$/)
    {
      # One capitalized word followed by another: LastRound
      my ($word1, $word2) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = $word1;
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $word2;
    }
    else
    {
      my $hit = 0;
      for my $front (@PEEL_FRONT)
      {
        if ($part =~ /^$front(.+)$/i)
        {
          my $back = $1;
          splice(@$list_ref, $i, 0, ('') x 2);
          $list_ref->[$i  ] = $front;
          $list_ref->[$i+1] = '|';
          $list_ref->[$i+2] = $back;
          $hit = 1;
          last;
        }
      }

      next if $hit;

      for my $back (@PEEL_BACK)
      {
        if ($part =~ /^(.+)$back$/i)
        {
          my $front = $1;
          splice(@$list_ref, $i, 0, ('') x 2);
          $list_ref->[$i  ] = $front;
          $list_ref->[$i+1] = '|';
          $list_ref->[$i+2] = $back;
          last;
        }
      }
    }
  }
}


sub unteam
{
  my ($text, $team1, $team2) = @_;

  my $res = $text;
  $res =~ s/\Q$team1\E// if defined $team1;
  $res =~ s/\Q$team2\E// if defined $team2;
  return $res;
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
  return 0 if is_year($part, $study_ref);

  print "UNKNOWN $part\n";
  $unknown++;
  $study_ref->{CATEGORY} = 'UNKNOWN';
  $study_ref->{VALUE} = $part;
  return 0;
}


sub study_event
{
  my ($text, $cref) = @_;

  # First remove team names that are entirely duplicated.
  my $mashed = unteam($text, $cref->{TEAM1}, $cref->{TEAM2});

  # Then mash some adjacent, separate words together because
  # they obviously belong together.
  $mashed = mash($mashed);

  my @parts = grep {$_ ne ''} split /([.\-\+_:;\/\(\)]|\s+)/, $mashed;
  split_on_digit_groups(\@parts);
  unmash(\@parts);

  my @studied;
  my $kill_flag = 0;

  for my $i (0 .. $#parts)
  {
    if (study_part($parts[$i], \%{$studied[$i]}))
    {
      $kill_flag = 1;
    }
  }

  kill_studied(\@studied) if $kill_flag;
}

