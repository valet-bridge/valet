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

my %FIELD_SUBS;
reverse_aliases(\%FIELD_ALIASES, \%FIELD_SUBS);

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

my %NAMED_TEAM_SUBS;
reverse_aliases(\%NAMED_TEAM_ALIASES, \%NAMED_TEAM_SUBS);

my %MONIKER_SUBS;
reverse_aliases(\%MONIKER_ALIASES, \%MONIKER_SUBS);

my %ORIGIN_SUBS;
reverse_aliases(\%ORIGIN_ALIASES, \%ORIGIN_SUBS);

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
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = $n1;
      $list_ref->[$i+1] = 'of';
      $list_ref->[$i+2] = $n2;
    }
    elsif ($part =~ /^of(\d+)$/i)
    {
      # of3
      my $n2 = $1;
      splice(@$list_ref, $i, 0, ('') x 1);
      $list_ref->[$i] = 'of';
      $list_ref->[$i+1] = $n2;
    }
    elsif ($part =~ /^([^0-9]+)(\d+)$/ &&
      defined $FIELD_SUBS{lc($1)})
    {
      # seg3
      my ($tag, $n) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 1);
      $list_ref->[$i] = $FIELD_SUBS{lc($1)};
      $list_ref->[$i+1] = $n;
    }
    elsif ($part =~ /^([^0-9]+)(\d+)$/ &&
      defined $SPELL_SUBS{lc($1)})
    {
      # session1
      my ($tag, $n) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 1);
      $list_ref->[$i] = $SPELL_SUBS{lc($1)};
      $list_ref->[$i+1] = $n;
    }
    elsif ($part =~ /^r(\d+)t(\d+)$/i)
    {
      # R10T1
      my ($round, $table) = ($1, $2);
      $round =~ s/^0+//; # Remove leading zeroes
      splice(@$list_ref, $i, 0, ('') x 3);
      $list_ref->[$i  ] = 'Round';
      $list_ref->[$i+1] = $round;
      $list_ref->[$i+2] = 'Table';
      $list_ref->[$i+3] = $table;
    }
    elsif ($part =~ /^t(\d+)$/i)
    {
      # T1
      my $table = $1;
      splice(@$list_ref, $i, 0, ('') x 1);
      $list_ref->[$i  ] = 'Table';
      $list_ref->[$i+1] = $table;
    }
    elsif ($part =~ /^s(\d+)r(\d+)$/i)
    {
      # S10R4
      my ($seg, $round) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 3);
      $list_ref->[$i  ] = 'Segment';
      $list_ref->[$i+1] = $seg;
      $list_ref->[$i+2] = 'Round';
      $list_ref->[$i+3] = $round;
    }
    elsif ($part =~ /^(\d\d)(.+)$/ && defined $MONTH_SUBS{lc($2)})
    {
      # 10Jan
      # We could in principle remember that the day and month go 
      # together.
      my ($day, $month) = ($1, $2);
      splice(@$list_ref, $i, 0, ('') x 1);
      $list_ref->[$i] = $day;
      $list_ref->[$i+1] = $MONTH_SUBS{lc($2)};
    }
  }
}


sub kill_part
{
  my ($list_ref) = @_;

  # Some entries should be skipped.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    if (defined $KILL_SUBS{lc($part)})
    {
      splice(@$list_ref, $i, 1);
    }
  }
}


sub study_part
{
  my ($part, $study_ref) = @_;

  my $lc_part = lc($part);
  my $flag = 0;
  if (defined $FIELD_SUBS{$lc_part})
  {
    $study_ref->{CLASS} = $FIELD_SUBS{$lc_part};
    $flag = 1;
  }
  elsif (defined $SPELL_SUBS{$lc_part})
  {
    $study_ref->{KEYWORD} = $SPELL_SUBS{$lc_part};
    $flag = 1;
  }

  return if is_separator($part, $study_ref);
  return if is_year($part, $study_ref);
  return if is_small_integer($part, $study_ref);
  return if is_small_ordinal($part, $study_ref);
  return if is_in_hash($part, \%NAMED_TEAM_SUBS, 'NAMED_TEAM', $study_ref);
  return if is_in_hash($part, \%MONTH_SUBS, 'MONTH', $study_ref);
  return if is_in_hash($part, \%COUNTRY_SUBS, 'COUNTRY', $study_ref);
  return if is_in_hash($part, \%CITY_SUBS, 'CITY', $study_ref);
  return if is_in_hash($part, \%WEEKDAY_SUBS, 'WEEKDAY', $study_ref);
  return if is_in_hash($part, \%ORDINAL_SUBS, 'ORDINAL', $study_ref);
  return if is_in_hash($part, \%MONIKER_SUBS, 'MONIKER', $study_ref);
  return if is_in_hash($part, \%ORIGIN_SUBS, 'RESTRICTION_ORIGIN', 
    $study_ref);

  return if $flag;

  print "UNKNOWN $part\n";
}


sub study_event
{
  my ($text, $cref) = @_;

  # First mash some adjacent, separate words together because
  # they obviously belong together.
  my $mashed = mash($text);

  my @parts = grep {$_ ne ''} split /([.\-_:\/\(\)]|\s+)/, $mashed;

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


sub parse_date
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/(\d\d\d\d).(\d\d).(\d\d)//)
  {
    # 1999.01.15
    my ($year, $month, $day) = ($1, $2, $3);
    $cref->{DATE} = "$year-$month-$day";
  }
  if ($fix =~ s/(\d\d)_(\d\d)_(\d\d\d\d)//)
  {
    # 01_03_2013
    my ($day, $month, $year) = ($1, $2, $3);
    $cref->{DATE} = "$year-$month-$day";
  }

  $fix =~ s/^\s+//;
  return $fix;
}


sub parse_finals
{
  my ($text, $cref) = @_;
  my $fix = $text;

  $fix =~ s/\bf i n a l\b/final/i;

  $fix =~ s/^1_2\s*final\b/SF/i;
  $fix =~ s/^1_2 finale\b/SF/i;
  $fix =~ s/^1_2 finales\b/SF/i;
  $fix =~ s/^1_2\s*F\b/SF/i;
  $fix =~ s/^1\/2\s*F\b/SF/i;
  $fix =~ s/\bsemifinal\b/SF/i;
  $fix =~ s/\bsemif\b/SF/i;
  $fix =~ s/\bsemis\b/SF/i;
  $fix =~ s/\bsemfin\b/SF/i;
  $fix =~ s/\bsemifinale\b/SF/i;
  $fix =~ s/\bdemi-finale\b/SF/i;
  $fix =~ s/\bdemi-finales\b/SF/i;
  $fix =~ s/\bsemifinali\b/SF/i;
  $fix =~ s/\bsemifinals\b/SF/i;
  $fix =~ s/\bsemi finals\b/SF/i;
  $fix =~ s/\bsemi-final\b/SF/i;
  $fix =~ s/\bdemi-final\b/SF/i;
  $fix =~ s/\bsemi-finals\b/SF/i;
  $fix =~ s/\bsemi final\b/SF/i;
  $fix =~ s/\bsemi finals\b/SF/i;
  $fix =~ s/\bmeias finais\b/SF/i;
  $fix =~ s/\bmeia final\b/SF/i;

  $fix =~ s/^1_4 final\b/QF/i;
  $fix =~ s/^1_4 finale\b/QF/i;
  $fix =~ s/^1_4 finals\b/QF/i;
  $fix =~ s/^1_4 finales\b/QF/i;
  $fix =~ s/^1_4\s*F\b/QF/i;
  $fix =~ s/^1\/4\s*Final\b/QF/i;
  $fix =~ s/^1\/4\s*F\b/QF/i;
  $fix =~ s/\bquarterf\b/QF/i;
  $fix =~ s/\bquarterfinal\b/QF/i;
  $fix =~ s/\bquarterfinals\b/QF/i;
  $fix =~ s/\bq-final\b/QF/i;
  $fix =~ s/\bq_fb/QF/i;
  $fix =~ s/\bq_f_b/QF/i;
  $fix =~ s/\bquarter[- ]final\b/QF/i;

  $fix =~ s/\bround of 128\b/Rof128/i;
  $fix =~ s/\bround of 64\b/Rof64/i;
  $fix =~ s/\bround of 32\b/Rof32/i;
  $fix =~ s/\bround of 16\b/Rof16/i;
  $fix =~ s/\bround of 8\b/QF/i;

  $fix =~ s/\b1_64\s+KO\b/Rof64/i;
  $fix =~ s/\bR of 64\s+KO\b/Rof64/i;
  $fix =~ s/\bR of 64\b/Rof64/i;

  $fix =~ s/\b1_32\s+KO\b/Rof32/i;
  $fix =~ s/\bR of 32\s+KO\b/Rof32/i;
  $fix =~ s/\bR of 32\b/Rof32/i;

  $fix =~ s/\b1_16\s+KO\b/Rof16/i;
  $fix =~ s/\bR of 16\s+KO\b/Rof16/i;
  $fix =~ s/\bR of 16\b/Rof16/i;

  $fix =~ s/\bR of 8\s+KO\b/Rof8/i;
  $fix =~ s/\bR of 8\b/Rof8/i;

  return $fix;
}


sub parse_origin
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\binter club\b//i ||
      $fix =~ s/\binterclub\b//i ||
      $fix =~ s/\binter-club\b//i ||
      $fix =~ s/\binter-clubs\b//i)
  {
    $cref->{RESTRICTION_ORIGIN} = 'Club';
  }
  elsif ($fix =~ s/\binter province\b//i ||
         $fix =~ s/\binter-province\b//i ||
         $fix =~ s/\binter-provinces\b//i ||
         $fix =~ s/\binter provinces\b//i)
  {
    $cref->{RESTRICTION_ORIGIN} = 'Province';
  }
  elsif ($fix =~ s/\binter-region\b//i)
  {
    $cref->{RESTRICTION_ORIGIN} = 'Region';
  }
  elsif ($fix =~ s/\binter-regional\b//i)
  {
    $cref->{RESTRICTION_ORIGIN} = 'Region';
  }
  elsif ($fix =~ s/\bintercity\b//i)
  {
    $cref->{RESTRICTION_ORIGIN} = 'City';
  }

  $fix =~ s/^\s+//;
  return $fix;
}


sub parse_foreign
{
  my ($text, $cref) = @_;
  my $fix = $text;

  $fix =~ s/\bfinali\b/final/i;
  $fix =~ s/\bfinale\b/final/i;
  $fix =~ s/\bfinals\b/final/i;
  $fix =~ s/\bFÝNAL\b/final/i;
  $fix =~ s/\bfin\b/final/i;
  $fix =~ s/\bfin als\b/final/i;
  $fix =~ s/\bfin_\b/final/i;
  $fix =~ s/\bfina\b/final/i;

  $fix =~ s/\bquarti\b/QF/i;

  $fix =~ s/\bknock out\b/KO/i;
  $fix =~ s/\bknockout\b/KO/i;

  $fix =~ s/\bsektion\b/Section/i;

  $fix =~ s/Segm\./Segment /gi;
  $fix =~ s/Segm_/Segment /gi;
  $fix =~ s/\bseg\b/Segment/gi;
  $fix =~ s/\bsegm\b/Segment/gi;
  $fix =~ s/Segment(\d+)/Segment $1/gi;
  $fix =~ s/\bsegement\b/Segment/i;
  $fix =~ s/\bsegmen\b/Segment/i;
  $fix =~ s/\bsegemt\b/Segment/i;
  $fix =~ s/\bsengemt\b/Segment/i;
  $fix =~ s/\bsgment\b/Segment/i;
  $fix =~ s/\bsegmant\b/Segment/i;
  $fix =~ s/\bsegmento\b/Segment/i;
  $fix =~ s/\bstanza\b/Segment/i;
  $fix =~ s/\bstsnza\b/Segment/i;
  $fix =~ s/\bset\b/Segment/i;
  $fix =~ s/\bstanza(\d+)/Segment $1/i;

  $fix =~ s/\bqtr\b/Quarter/i;

  $fix =~ s/\bsessió\b/Session/i;
  $fix =~ s/\bsesion\b/Session/i;
  $fix =~ s/\bsesión\b/Session/i;
  $fix =~ s/\bsess\b/Session/i;

  $fix =~ s/\bclasificatoria\b/Qualifying/i;
  $fix =~ s/\bqualif\b/Qualifying/i;

  $fix =~ s/\bturno\b/Round/i;
  $fix =~ s/\bdevre\b/Round/i;
  $fix =~ s/\bronda\b/Round/i;
  $fix =~ s/\brd\b/Round/i;
  $fix =~ s/\btour\b/Round/i;
  $fix =~ s/\bturul\b/Round/i;

  $fix =~ s/\bhalvleg\b/half/i;
  $fix =~ s/_halvleg\b/_half/i;

  $fix =~ s/\bincontro\b/Match/i;
  $fix =~ s/\bmathc\b/Match/i;
  $fix =~ s/\bkamp\b/Match/i;

  $fix =~ s/\bparejas\b/Pairs/i;

  $fix =~ s/\brnd\b/Round/i;
  $fix =~ s/\btound\b/Round/i;
  $fix =~ s/\brueda\b/Round/i;
  $fix =~ s/\brunde\b/Round/i;
  $fix =~ s/\bruond\b/Round/i;
  $fix =~ s/\brd(\d+)\b/Round $1/i;

  $fix =~ s/\bround robin\b/RR/i;
  $fix =~ s/\bround-robin\b/RR/i;
  $fix =~ s/\br-robin\b/RR/i;
  $fix =~ s/\br robin\b/RR/i;

  $fix =~ s/\bdamas\b/Women/i;
  $fix =~ s/\bladies\b/Women/i;

  $fix =~ s/\bspil\b/boards/i;
  $fix =~ s/\bbrds\b/boards/i;
  $fix =~ s/\bdonnes\b/boards/i;
  $fix =~ s/\bBOards\b/boards/i;

  $fix =~ s/\bultimo\b/last/i;

  $fix =~ s/\bmix\b/mixed/i;
  $fix =~ s/\bmixte\b/mixed/i;

  $fix =~ s/\b1er\b/First/i;
  $fix =~ s/\b2e\b/Second/i;
  $fix =~ s/\bsegundo\b/Second/i;
  $fix =~ s/\bsegunda\b/Second/i;
  $fix =~ s/\b3eme\b/Third/i;
  $fix =~ s/\b3e\b/Third/i;

  $fix =~ s/\bout of\b/of/i;
  $fix =~ s/\baf\b/of/i;

  # Destroy some words.
  $fix =~ s/\btournament\b//gi;
  $fix =~ s/\btournoi\b//gi;
  $fix =~ s/\btounoi\b//gi;
  
  return $fix;
}


sub parse_form
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bpairs\b//i ||
      $fix =~ s/\bpair\b//i)
  {
    $cref->{FORM} = 'Pairs';
  }
  elsif ($fix =~ s/\bmixedpairs\<//i)
  {
    $cref->{GENDER} = 'Mixed';
    $cref->{FORM} = 'Pairs';
  }
  elsif ($fix =~ s/\bmixedteam\<//i)
  {
    $cref->{GENDER} = 'Mixed';
    $cref->{FORM} = 'Teams';
  }
  elsif ($fix =~ s/\bteams\b//i ||
      $fix =~ s/\bteam\b//i ||
      $fix =~ s/\bequipos\b//i ||
      $fix =~ s/\bopenteams\b//i ||
      $fix =~ s/\bopenteams-//i)
  {
    $cref->{FORM} = 'Teams';
  }
  elsif ($fix =~ s/\bindividual\b//i ||
         $fix =~ s/\bindiv\b//i)
  {
    $cref->{FORM} = 'Individual';
  }

  $fix =~ s/^\s+//;
  return $fix;
}


sub parse_bbo
{
  my ($text, $cref) = @_;
  my $fix = $text;

  $fix =~ s/Bridge Base Online//i;
  $fix =~ s/\bBBO\d\b//i;
  $fix =~ s/\bBBO\d[oc]\b//i;
  $fix =~ s/\bBBOVG\d\b//i;
  $fix =~ s/\bBBOVG\b//i;
  $fix =~ s/\bBBVG\b//i;

  return $fix;
}


sub parse_moniker
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bBB\b//i ||
      $fix =~ s/^BB-//i ||
      $fix =~ s/bermuda bowl//i)
  {
    $cref->{MONIKER} = 'Bermuda Bowl';
  }
  elsif ($fix =~ s/\bVC\b//i ||
      $fix =~ s/^VC-//i ||
      $fix =~ s/venice cup//i)
  {
    $cref->{MONIKER} = 'Venice Cup';
  }

  return $fix;
}


sub parse_gender
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bwomen\b//gi)
  {
    $cref->{GENDER} = 'Women';
  }
  elsif ($fix =~ s/\bmixed\b//gi)
  {
    $cref->{GENDER} = 'Mixed';
  }
  elsif ($fix =~ s/\bgirls\b//gi)
  {
    $cref->{GENDER} = 'Women';
    $cref->{AGE} = 'Juniors';
  }

  return $fix;
}


sub parse_age
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bseniors\b//gi ||
      $fix =~ s/\bsenior\b//gi)
  {
    $cref->{AGE} = 'Seniors';
  }
  elsif ($fix =~ s/\bjuniors\b//gi)
  {
    $cref->{AGE} = 'Juniors';
  }
  elsif ($fix =~ s/\bjunior\b//gi)
  {
    $cref->{AGE} = 'Juniors';
  }
  elsif ($fix =~ s/\byouth\b//gi)
  {
    $cref->{AGE} = 'Youth';
  }
  elsif ($fix =~ s/\bschools\b//gi)
  {
    $cref->{AGE} = 'Schools';
  }
  elsif ($fix =~ s/\bu(\d\d)\b//gi)
  {
    $cref->{AGE} = 'U' . $1;
  }

  return $fix;
}


sub parse_group
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bgroup [a-zA-Z1-9]\b//gi)
  {
    $cref->{GROUP} = $1;
  }

  return $fix;
}


sub parse_movement
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ s/\bswiss\b//gi)
  {
    $cref->{MOVEMENT} = 'Swiss';
  }
  elsif ($fix =~ s/\bdanish\b//gi)
  {
    $cref->{MOVEMENT} = 'Danish';
  }
  elsif ($fix =~ s/\bpatton\b//gi)
  {
    $cref->{MOVEMENT} = 'Patton';
  }
  elsif ($fix =~ s/\btriangle\b//gi)
  {
    $cref->{MOVEMENT} = 'Triangle';
  }

  return $fix;
}


sub parse_pure_numbers
{
  my ($text, $cref) = @_;
  my $fix = $text;

  if ($fix =~ /^\s*(\d+)\s*$/)
  {
    # 3
    $cref->{COUNTER} = $1;
    return 1;
  }
  elsif ($fix =~ /^\s*(\d+)\s*[o0]f\s*(\d+)\s*$/i)
  {
    # 1 of 4
    $cref->{COUNTER} = $fix;
    return 1;
  }
  elsif ($fix =~ /^\s*(\d+)\s*[_\/]\s*(\d+)\s*$/)
  {
    # 1_9, 1/9
    $cref->{COUNTER} = "$1 of $2";
    return 1;
  }

  return 0;
}


sub ordinal
{
  my ($text, $res_ref) = @_;

  if ($text =~ /^(\d+)th$/)
  {
    $$res_ref = 1;
    return 1;
  }
  elsif ($text =~ /^(\d+)ª$/)
  {
    $$res_ref = 1;
    return 1;
  }
  elsif ($text =~ /^(\d+)°$/)
  {
    $$res_ref = 1;
    return 1;
  }

  return 0;
}


sub parse_compact_number
{
  # Can be a single number, or something like 22/38.

  my ($text, $cref, $res_ref) = @_;
  my $fix = $text;

  if ($fix =~ /^(\d+)$/ ||
      $fix =~ /^(\d+)[a-zA-Z]$/i ||
      $fix =~ /^#(\d+)$/i)
  {
    # 6, 6a, #6
    $$res_ref = $1;
    return 1;
  }
  elsif ($fix =~ /^(\d+)[_\/](\d+)$/)
  {
    # 4/9, 4_9
    $$res_ref = "$1 of $2";
    return 1;
  }
  elsif (ordinal($fix, $res_ref))
  {
    return 1;
  }

  return 0;
}


sub status_word
{
  my ($text, $word_ref, $stage_flag_ref, $stage_ref) = @_;

  if ($text =~ /segment/i)
  {
    $$word_ref = 'SEGMENT';
    return 1;
  }
  elsif ($text =~ /quarter/i)
  {
    $$word_ref = 'QUARTER';
    return 1;
  }
  elsif ($text =~ /round/i ||
      $text =~ /r/i)
  {
    $$word_ref = 'ROUND';
    return 1;
  }
  elsif ($text =~ /rr/i)
  {
    $$word_ref = 'ROUND';
    $$stage_flag_ref = 1;
    $$stage_ref = 'RR';
    return 1;
  }
  elsif ($text =~ /final/i ||
      lc($text) eq 'f')
  {
    $$word_ref = 'COUNTER';
    $$stage_flag_ref = 1;
    $$stage_ref = 'Final';
    return 1;
  }
  else
  {
    return 0;
  }
}


sub simple_remainder
{
  my ($text, $cref) = @_;

  my @list = split /\s+/, $text;
  return 0 unless $#list == 1;

  my $word = '';
  my $stage_flag = 0;
  my $stage;

  my $ok_flag = 0;
  my $remainder = '';

  if (status_word($list[0], \$word, \$stage_flag, \$stage))
  {
    $ok_flag = 1;
    $remainder = $list[1];
  }
  elsif (status_word($list[1], \$word, \$stage_flag, \$stage))
  {
    $ok_flag = 1;
    $remainder = $list[0];
  }

  return 0 unless $ok_flag;
  return 0 if $word eq '';

  my $res;
  if (parse_compact_number($remainder, $cref, \$res))
  {
    if ($word eq 'QUARTER')
    {
      if ($res =~ /of/)
      {
        die "Confused: $res, $remainder";
      }

      $cref->{SEGMENT} = "$res of 4";
    }
    else
    {
      $cref->{$word} = $res;

      if ($stage_flag)
      {
        $cref->{STAGE} = $stage;
      }
    }
    return 1;
  }
  else
  {
    print "REMAINDER $remainder\n";
    return 0;
  }
}


sub parse_number_pairs
{
  my $text = pop;
  my $fix = $text;

  # 2_3
  $fix =~ s/\b(\d+)_(\d+)\b/$1 of $2/g;

  # 2/3
  $fix =~ s/\b(\d+)\/(\d+)\b/$1 of $2/g;

  # 2 af 3 [so in Danish etc.]
  $fix =~ s/\b(\d+)\s*af\s*(\d+)\b/$1 of $2/gi;

  # 2 OF 3 [capital letters, also no space needed]
  $fix =~ s/\b(\d+)\s*of\s*(\d+)\b/$1 of $2/gi;

  return $fix;
}


sub parse_event
{
  my ($text, $cref) = @_;

  # Try to translate foreign words.
  my $fix = parse_foreign($text, $cref);

  $fix = parse_date($fix, $cref);
  return if $fix =~ /^\s*$/;

  # Try to parse out quarter finals and semi finals.
  $fix = parse_finals($fix, $cref);

  # Try to parse out inter-club, inter-regional, inter-province.
  $fix = parse_origin($fix, $cref);

  # Try to parse out pair, pairs, individual, team, teams.
  $fix = parse_form($fix, $cref);

  # Try to parse out BBO fluff.
  $fix = parse_bbo($fix, $cref);

  # Try to parse out BB, VC.
  $fix = parse_moniker($fix, $cref);

  # Try to parse out gender.
  $fix = parse_gender($fix, $cref);

  # Try to parse out age.
  $fix = parse_age($fix, $cref);

  # Try to parse out age.
  $fix = parse_group($fix, $cref);

  # Try to parse movement: Swiss, Danish.
  $fix = parse_movement($fix, $cref);

  # Remove boards.
  $fix =~ s/\(\d+\s+boards\)//gi;
  $fix =~ s/boards \d+-\d+//gi;

  # Clean up.
  $fix =~ s/'s\s+/ /g;
  $fix =~ s/-\s*-/-/g;
  $fix =~ s/^\s+//g;
  $fix =~ s/^-\s*//g;
  $fix =~ s/\(\s*\)//g;
  $fix =~ s/\s+/ /g;

  # Try to find forms of "a of b" in the text.
  # my $fix3 = parse_number_pairs($fix2);

  return if parse_pure_numbers($fix, $cref);

  # Effectively first word Quarter, Segment, Round
  # Followed by a single number indication.
  return if simple_remainder($fix, $cref);

  $cref->{EVENT} = $fix;
  return;
}

