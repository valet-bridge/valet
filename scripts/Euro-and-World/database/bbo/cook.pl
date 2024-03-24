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

my %MERGE_SUBS;
reverse_aliases(\%MERGE_ALIASES, \%MERGE_SUBS);

my %SPELL_SUBS;
reverse_aliases(\%SPELL_ALIASES, \%SPELL_SUBS);

my %COUNTRY_SUBS;
reverse_aliases(\%COUNTRY_ALIASES, \%COUNTRY_SUBS);

my %CITY_SUBS;
reverse_aliases(\%CITY_ALIASES, \%CITY_SUBS);

my %MONTH_SUBS;
reverse_aliases(\%MONTH_ALIASES, \%MONTH_SUBS);

my %WEEKDAY_SUBS;
reverse_aliases(\%WEEKDAY_ALIASES, \%WEEKDAY_SUBS);

my %ORDINAL_SUBS;
reverse_aliases(\%ORDINAL_ALIASES, \%ORDINAL_SUBS);

my %NUMERAL_SUBS;
reverse_aliases(\%NUMERAL_ALIASES, \%NUMERAL_SUBS);

my %NAMED_TEAM_SUBS;
reverse_aliases(\%NAMED_TEAM_ALIASES, \%NAMED_TEAM_SUBS);

my %TOURNAMENT_SUBS;
reverse_aliases(\%TOURNAMENT_ALIASES, \%TOURNAMENT_SUBS);

my %STAGE_SUBS;
reverse_aliases(\%STAGE_ALIASES, \%STAGE_SUBS);

my %MODE_SUBS;
reverse_aliases(\%MODE_ALIASES, \%MODE_SUBS);

my %MONIKER_SUBS;
reverse_aliases(\%MONIKER_ALIASES, \%MONIKER_SUBS);

my %ORIGIN_SUBS;
reverse_aliases(\%ORIGIN_ALIASES, \%ORIGIN_SUBS);

my %SPONSOR_SUBS;
reverse_aliases(\%SPONSOR_ALIASES, \%SPONSOR_SUBS);

my %MEMORIAL_SUBS;
reverse_aliases(\%MEMORIAL_ALIASES, \%MEMORIAL_SUBS);

my %KILL_SUBS;
reverse_aliases(\%KILL_ALIASES, \%KILL_SUBS);

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
    elsif ($1 eq 'EVENT')
    {
      if ($chunk{BBONO} == 10534)
      {
        print "HERE\n";
      }

      study_event($2, \%chunk);

      # parse_event($2, \%chunk);
    }
    else
    {
      $chunk{$1} = $2;
    }
  }
}

close $fh;


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


sub reverse_aliases
{
  my ($aliases_ref, $subst_ref) = @_;
  for my $key (keys %$aliases_ref)
  {
    for my $alias (@{$aliases_ref->{$key}})
    {
      $subst_ref->{lc($alias)} = $key;
    }
  }
}


sub is_separator
{
  my ($part, $study_ref) = @_;

  if ($part =~ /^\s+$/)
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SPACE';
    return 1;
  }
  elsif ($part eq '.')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'DOT';
    return 1;
  }
  elsif ($part eq ':')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'COLON';
    return 1;
  }
  elsif ($part eq ';')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SEMICOLON';
    return 1;
  }
  elsif ($part eq '-')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'DASH';
    return 1;
  }
  elsif ($part eq '_')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'UNDERSCORE';
    return 1;
  }
  elsif ($part eq '/')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'SLASH';
    return 1;
  }
  elsif ($part eq '(')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'LEFT_PAREN';
    return 1;
  }
  elsif ($part eq ')')
  {
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'RIGHT_PAREN';
    return 1;
  }
  elsif ($part eq '|')
  {
    # Artificial separator made when unmashing.
    $study_ref->{CLASS} = 'SEPARATOR';
    $study_ref->{VALUE} = 'ARTIFICIAL';
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_capital_letter
{
  my ($part, $study_ref) = @_;

  if ($part =~ /^[A-Z]$/)
  {
    $study_ref->{CLASS} = 'LETTER';
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
      $study_ref->{CLASS} = 'YEAR';
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


sub is_small_integer
{
  my ($part, $study_ref) = @_;

  # Up to 100
  if ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $study_ref->{CLASS} = 'SMALL_INT';
    $part =~ s/^0+//; # Remove leading zeroes
    $study_ref->{VALUE} = $part;
    return 1;
  }
  elsif ($part =~ /^#(\d+)$/ && $1 >= 0 && $1 < 100)
  {
    # #10
    my $n = $1;
    $n =~ s/^0+//; # Remove leading zeroes

    $study_ref->{CLASS} = 'SMALL_INT';
    $study_ref->{VALUE} = $n;
    return 1;
  }
  elsif (defined $NUMERAL_SUBS{lc($part)})
  {
    # third
    $study_ref->{CLASS} = 'SMALL_INT';
    $study_ref->{VALUE} = $NUMERAL_SUBS{lc($part)};
  }
  else
  {
    return 0;
  }
}


sub is_small_ordinal
{
  my ($part, $study_ref) = @_;
  if ($part =~ /^(\d+)th$/i ||
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rd$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    # We don't check whether the ending matches the number.
    my $ord = $1;
    if ($ord >= 0 && $ord < 100)
    {
      $study_ref->{CLASS} = 'ORDINAL';
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


sub is_in_hash
{
  my ($part, $hash_ref, $tag, $study_ref) = @_;

  if (defined $hash_ref->{lc($part)})
  {
    $study_ref->{CLASS} = $tag;
    $study_ref->{VALUE} = $part;
    return 1;
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
  for my $key (keys %MERGE_SUBS)
  {
    $res =~s/\b$key\b/$MERGE_SUBS{$key}/gi;
  }
  return $res;
}


sub unmash
{
  my ($list_ref) = @_;

  # Some entries may be mashed together.  It's easier to split them
  # out than to try to recognize them later.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    if ($part =~ /^(\d+)of(\d+)$/i)
    {
      # 2of3
      my ($n1, $n2) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 4);
      $list_ref->[$i  ] = $n1;
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = 'of';
      $list_ref->[$i+3] = '|';
      $list_ref->[$i+4] = $n2;
    }
    elsif ($part =~ /^of(\d+)$/i)
    {
      # of3
      my $n2 = $1;
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'of';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $n2;
    }
    elsif ($part =~ /^([^0-9]+)(\d+)$/ &&
      defined $SPELL_SUBS{lc($1)})
    {
      # session1
      my ($tag, $n) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = $SPELL_SUBS{lc($1)};
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $n;
    }
    elsif ($part =~ /^r(\d+)t(\d+)$/i)
    {
      # R10T1
      my ($round, $table) = ($1, $2);
      $round =~ s/^0+//; # Remove leading zeroes
      splice(@$list_ref, $i, 0, ('') x 6);
      $list_ref->[$i  ] = 'Round';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $round;
      $list_ref->[$i+3] = '|';
      $list_ref->[$i+4] = 'Table';
      $list_ref->[$i+5] = '|';
      $list_ref->[$i+6] = $table;
    }
    elsif ($part =~ /^t(\d+)$/i)
    {
      # T1
      my $table = $1;
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'Table';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $table;
    }
    elsif ($part =~ /^s(\d+)r(\d+)$/i)
    {
      # S10R4
      my ($seg, $round) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 6);
      $list_ref->[$i  ] = 'Segment';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $seg;
      $list_ref->[$i+3] = '|';
      $list_ref->[$i+4] = 'Round';
      $list_ref->[$i+5] = '|';
      $list_ref->[$i+6] = $round;
    }
    elsif ($part =~ /^(\d\d)(.+)$/ && defined $MONTH_SUBS{lc($2)})
    {
      # 10Jan
      # We could in principle remember that the day and month go 
      # together.
      my ($day, $month) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = $day;
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = $MONTH_SUBS{lc($2)};
    }
  }
}


sub kill_part
{
  my ($list_ref) = @_;

  # Some entries should be skipped.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    # Can happen when deleting from the back
    next unless $i <= $#$list_ref; 

    my $part = $list_ref->[$i];
    if (defined $KILL_SUBS{lc($part)})
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
      elsif ($list_ref->[$i-1] =~ /^\s+$/ &&
          $list_ref->[$i+1] =~ /^\s+$/)
      {
        # Surrounded by spaces, so kill one of them.
        splice(@$list_ref, $i, 2);
      }
      elsif ($list_ref->[$i-1] eq '(' &&
          $list_ref->[$i+1] eq ')')
      {
        # Surrounded by parentheses.
        splice(@$list_ref, $i, 2);
        $list_ref->[$i-1] = ' ';
      }
      else
      {
        die "Don't know how to kill this: $part";
      }
    }
  }
}


sub study_part
{
  my ($part, $study_ref) = @_;

  return if is_separator($part, $study_ref);
  return if is_capital_letter($part, $study_ref);

  my $lc_part = lc($part);
  if (defined $SPELL_SUBS{$lc_part})
  {
    $study_ref->{KEYWORD} = $SPELL_SUBS{$lc_part};
    return;
  }

  return if is_year($part, $study_ref);
  return if is_small_integer($part, $study_ref);
  return if is_small_ordinal($part, $study_ref);
  return if is_in_hash($part, \%NAMED_TEAM_SUBS, 'NAMED_TEAM', $study_ref);
  return if is_in_hash($part, \%MONTH_SUBS, 'MONTH', $study_ref);
  return if is_in_hash($part, \%COUNTRY_SUBS, 'COUNTRY', $study_ref);
  return if is_in_hash($part, \%CITY_SUBS, 'CITY', $study_ref);
  return if is_in_hash($part, \%WEEKDAY_SUBS, 'WEEKDAY', $study_ref);
  return if is_in_hash($part, \%ORDINAL_SUBS, 'ORDINAL', $study_ref);
  return if is_in_hash($part, \%TOURNAMENT_SUBS, 'TTYPE', $study_ref);
  return if is_in_hash($part, \%MONIKER_SUBS, 'MONIKER', $study_ref);
  return if is_in_hash($part, \%ORIGIN_SUBS, 'RESTRICTION_ORIGIN', 
    $study_ref);
  return if is_in_hash($part, \%STAGE_SUBS, 'STAGE', $study_ref);
  return if is_in_hash($part, \%MODE_SUBS, 'MODE', $study_ref);
  return if is_in_hash($part, \%SPONSOR_SUBS, 'SPONSOR', $study_ref);
  return if is_in_hash($part, \%MEMORIAL_SUBS, 'MEMORIAL', $study_ref);

  print "UNKNOWN $part\n";
}


sub study_event
{
  my ($text, $cref) = @_;

  # First mash some adjacent, separate words together because
  # they obviously belong together.
  my $mashed = mash($text);

  my @parts = grep {$_ ne ''} split /([.\-_:;\/\(\)]|\s+)/, $mashed;

  unmash(\@parts);
  kill_part(\@parts);

  my @studied;
  for my $i (0 .. $#parts)
  {
    study_part($parts[$i], \%{$studied[$i]});
  }
}


sub parse_teams
{
  my ($text, $cref) = @_;

  if ($text =~ /(.*) vs. (.*)/)
  {
    my ($team1, $team2) = ($1, $2);
    $team1 =~ s/\(\d+\)\s*$//;
    $team2 =~ s/\(\d+\)\s*$//;
    $chunk{TEAM1} = $team1;
    $chunk{TEAM2} = $team2;
  }
  else
  {
    print "Can't parse team line $text\n";
  }
}

