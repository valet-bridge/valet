#!perl

package Title::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(study);

use lib '.';

use Util;

my @TAG_ORDER = qw(
  ROMAN
  MEET
  TNAME
  DESTROY
  TWORD
  ORIGIN
  CLUB

  ORGANIZATION 
  ZONE 
  SPONSOR 
  COUNTRY 
  NATIONALITY
  REGION 
  CITY 
  LOCALITY 
  UNIVERSITY 
  FORM 
  MOVEMENT
  CAPTAIN 
  GENDER
  AGE
  SCORING
  PERSON
  ITERATOR
  STAGE
  TIME
  MONTH
  WEEKDAY
  ORDINAL
  PARTICLE
  AMBIGUOUS
);

my $PREFIX = 'TITLE_';
our $histo_title;

my @LOCAL_SUBS =
(
  { START => 3620, END => 3631, TEXT => 'Pula', 
    CORR => 'Pula Bridge Festival' },
  { START => 3708, END => 3728, TEXT => 'CCBA Championships', 
    CORR => 'Chinese Open Teams' },
  { START => 3729, END => 3738, TEXT => 'Stara Zagora 2007 Open Teams',
    CORR => 'Stara Zagora Open Teams 2007' },
  { START => 6268, END => 6279, TEXT => 'Selection Senior', 
    CORR => 'French Senior Trials' },
  { START => 6856, END => 6975, TEXT => 'Cap Gemini', 
    CORR => 'Cap Gemini World Top Tournament' },
  { START => 7843, END => 7865, TEXT => 'ACBL 1999 Open Team Trials', 
    CORR => '1999 USA International Team Trials' },
  { START => 8186, END => 8199, TEXT => 'White House', 
    CORR => 'White House International' },
  { START => 8236, END => 8242, TEXT => 'Selection Francaise', 
    CORR => 'French Open Trials' },
  { START => 8489, END => 8503, TEXT => 'Selection Francaise', 
    CORR => 'French Open Trials' },
  { START => 9728, END => 9770, TEXT => 'Indonesian Final Premier League',
    CORR => 'Indonesian Premier League Final' },
  { START => 11683, END => 11873, TEXT => 'Premier League', 
    CORR => 'English Premier League' },
  { START => 38376, END => 38436, TEXT => 'Swedish Trials', 
    CORR => 'Swedish Open Trials' },
  { START => 38594, END => 38652, TEXT => 'Turkish Open Championship', 
    CORR => 'Turkish Open Teams Championship' },
  { START => 38594, END => 38652, TEXT => 'Turkish Open Championships', 
    CORR => 'Turkish Open Teams Championship' },
  { START => 39162, END => 39309, TEXT => 'I National Bridge Tournament', 
    CORR => '1st Bulgarian Open Teams' },
  { START => 39501, END => 39525, TEXT => 'Lozenets Tournament Teams', 
    CORR => 'Lozenets Bridge Festival - Open Teams' },
  { START => 39501, END => 39525, TEXT => 'Lozenets Team Tournament', 
    CORR => 'Lozenets Bridge Festival - Open Teams' },
  { START => 40702, END => 40802, TEXT => 'Inter State Championship', 
    CORR => 'Indian Inter-State Teams' },
  { START => 40702, END => 40802, TEXT => 'Inter State Nationals', 
    CORR => 'Indian Inter-State Teams' },
  { START => 40702, END => 40802, TEXT => 'Interstate Nationals', 
    CORR => 'Indian Inter-State Teams' },
  { START => 40926, END => 40955, TEXT => 'Selection Open', 
    CORR => 'French Open Trials' },
  { START => 41719, END => 41744, TEXT => 'National Student Championship', 
    CORR => 'Indonesian Student Championship' },
  { START => 41967, END => 42044, 
    TEXT => 'Campeonato Nacional Equipas Open',
    CORR => 'Portuguese Open Teams' },
  { START => 41967, END => 42044, 
    TEXT => 'Campeonato Nacional\s+de Equipas Open',
    CORR => 'Portuguese Open Teams' },
  { START => 43070, END => 43154, TEXT => 'Bulgaria Group A', 
    CORR => 'Bulgarian Open Teams - Group A' },
  { START => 43195, END => 43235, TEXT => 'Open Playoff', 
    CORR => 'Australian Open Team Trials - Playoff' }
);


sub local_substitutions2
{
  my ($text, $bbono) = @_;

  for my $entry (@LOCAL_SUBS)
  {
    if ($bbono >= $entry->{START} && $bbono <= $entry->{END})
    {
      $text =~ s/$entry->{TEXT}/$entry->{CORR}/i;
    }
  }
}


sub local_substitutions
{
  my ($text, $bbono) = @_;

  # if ($bbono >= && $bbono <= )
  # {
    # $text =~ s///;
  # }

  if ($bbono >= 3620 && $bbono <= 3631)
  {
    $text =~ s/PULA/Pula Bridge Festival/;
  }

  if ($bbono >= 3729 && $bbono <= 3738)
  {
    $text =~ s/Stara Zagora 2007 Open Teams/Stara Zagora Open Teams 2007/;
  }

  if ($bbono >= 9728 && $bbono <= 9770)
  {
    $text =~ 
      s/Indonesian Final Premier League/Indonesian Premier League Final/;
  }

  if ($bbono >= 3708 && $bbono <= 3728)
  {
    $text =~ s/CCBA Championships/Chinese Open Teams/;
  }

  if ($bbono >= 6268 && $bbono <= 6279)
  {
    $text =~ s/Selection Senior/French Senior Trials/i;
  }

  if ($bbono >= 6856 && $bbono <= 6975)
  {
    $text =~ s/Cap Gemini/Cap Gemini World Top Tournament/;
  }

  if ($bbono >= 7843 && $bbono <= 7865)
  {
    $text =~ 
      s/ACBL 1999 Open Team Trials/1999 USA International Team Trials/;
  }

  if ($bbono >= 8236 && $bbono <= 8242)
  {
    $text =~ s/Selection Francaise/French Open Trials/;
  }

  if ($bbono >= 8186 && $bbono <= 8199)
  {
    $text =~ s/White House/White House International/;
  }

  if ($bbono >= 8489 && $bbono <= 8503)
  {
    $text =~ s/Selection Francaise/French Open Trials/;
  }

  if ($bbono >= 11683 && $bbono <= 11873)
  {
    $text =~ s/Premier League/English Premier League/;
  }

  if ($bbono >= 38376 && $bbono <= 38436)
  {
    $text =~ s/Swedish Trials/Swedish Open Trials/i;
  }

  if ($bbono >= 38594 && $bbono <= 38652)
  {
    $text =~ s/Turkish Open Championship/Turkish Open Teams Championship/i;
    $text =~ s/Turkish Open Championships/Turkish Open Teams Championship/i;
  }

  if ($bbono >= 39501 && $bbono <= 39525)
  {
    $text =~ 
      s/Lozenets Tournament Teams/Lozenets Bridge Festival - Open Teams/i;
    $text =~ 
      s/Lozenets Team Tournament/Lozenets Bridge Festival - Open Teams/i;
  }

  if ($bbono >= 39162 && $bbono <= 39309)
  {
    $text =~ s/I National Bridge Tournament/1st Bulgarian Open Teams/;
  }

  if ($bbono >= 40702 && $bbono <= 40802)
  {
    $text =~ s/Inter State Championship/Indian Inter-State Teams/;
    $text =~ s/Inter State Nationals/Indian Inter-State Teams/;
    $text =~ s/Interstate Nationals/Indian Inter-State Teams/;
  }

  if ($bbono >= 40926 && $bbono <= 40955)
  {
    $text =~ s/Selection Open/French Open Trials/i;
  }

  if ($bbono >= 41719 && $bbono <= 41744)
  {
    $text =~ 
      s/National Student Championship/Indonesian Student Championship/;
  }

  if ($bbono >= 41967 && $bbono <= 42044)
  {
    $text =~ 
      s/Campeonato Nacional Equipas Open/Portuguese Open Teams/;
    $text =~ 
      s/Campeonato Nacional\s+de Equipas Open/Portuguese Open Teams/;
  }

  if ($bbono >= 43070 && $bbono <= 43154)
  {
    $text =~ s/Bulgaria Group A/Bulgarian Open Teams - Group A/;
  }

  if ($bbono >= 43195 && $bbono <= 43235)
  {
    $text =~ s/Open Playoff/Australian Open Team Trials - Playoff/;
  }

  return $text;
}


sub title_specific_inline
{
  my ($text) = @_;

  if ($text =~ /1[\/_](\d)\s+final/i)
  {
    # 1/4 final(e), 1/2 final(e).
    my $n = $1;
    warn "Haven't learned this yet: $text" unless $n == 2 || $n == 4;
    $text =~ s/1\/4 finale*/quarterfinal/;
    $text =~ s/1\/2 finale*/semifinal/;
  }

  # Years: '9x, '0x, '1x.
  $text =~ s/'(9\d)/19$1/g;
  $text =~ s/'(0\d)/20$1/g;
  $text =~ s/'(1\d)/20$1/g;

  # Remove nameless teams.
  $text =~ s/#\d+\s+vs*\s+#*\d+//;
  $text =~ s/tm\s+\d+\s+vs\s+tm\s+\d+//i;
  $text =~ s/team\s+\d+\s+vs\s+team\s+\d+//i;
  $text =~ s/- \d+ v \d+//i;

  # Add some spacing.
  $text =~ s/^(\d+)th([a-z])/$1th $2/i; # 8th|letter
  $text =~ s/^([01]\d)([A-SU-Z])/20$1 $2/; # Year. Avoid th
  $text =~ s/\b([1-9])([A-D])\b/$1 $2/gi; # 1|A
  $text =~ s/\b(\d)of(\d)\b/$1 of $2/g; # 1|of|2
  
  # n_n (n of n), n&n (n to n).
  if ($text =~ /(\d+)[_&](\d+)/ && $1 <= $2 && $1 < 1990)
  {
    $text =~ s/(\d+)_(\d+)/$1 of $2/;
    $text =~ s/(\d+)&(\d+)/$1 to $2/;
  }

  # A hodge-podge, mostly of spacing.
  $text =~ s/pokal([a-z])/pokal $1/i; # pokal|a
  $text =~ s/(d[ae]nmark) - pokal/$1 Pokal/i;
  $text =~ s/-th\b/th/g; # 4-th
  $text =~ s/(\d) th\b/$1th/g; # 4 th
  $text =~ s/2 nd\b/2nd/g; #  2nd
  $text =~ s/\bUSA[12]/USA/g; # USA1
  $text =~ s/\bUSA 2\b/USA/g; # USA 2
  $text =~ s/II-nd/2nd/g; # II-nd
  $text =~ s/\b(\d\d) _$/Rof$1/g; # Line ending on 16 _
  $text =~ s/\bF([12])\b/Final $1/g; # F1

  return $text;
}


sub study_value
{
  my ($whole, $value, $pos, $chain, $unknown_value_flag) = @_;

  return if singleton_non_tag_matches($value, $pos, $chain,
    $main::histo_title, $PREFIX);

  return if singleton_tag_matches($whole, \@TAG_ORDER, $pos, $value, 
    0, $chain, $main::histo_title, $PREFIX);

  append_token($chain, 'UNKNOWN', '', $value, $value, 
    $pos, $main::histo_title, $PREFIX);

  print "SSS value $value \n";
  $$unknown_value_flag = 1;
}


sub study_component
{
  my ($whole, $value, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $digits = '';
  if ($value =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    ($value, $digits) = ($1, $2);
  }

  study_value($whole, $value, $token_no, $chain, $unsolved_flag);

  if ($digits ne '')
  {
    # Add the digits if they exist.
    singleton_numeral($digits, $token_no, $chain, 
      $main::histo_title, $PREFIX);
  }
}


sub study
{
  my ($whole, $bbono, $text, $chain, $unknowns) = @_;

  return if $text eq '';

  $text = local_substitutions($text, $bbono);
  my $stext = split_on_capitals($text);
  my $ntext = title_specific_inline($stext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($ntext, \@tags, \@values, \@texts, 0);
  split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._:;&@"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      append_token($chain, 'SINGLETON', $tags[$i], $values[$i], 
        $texts[$i], \$token_no, $main::histo_title, $PREFIX);
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $value (@a)
      {
        study_component($whole, $value, $chain, \$token_no, 
          \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    $$unknowns++;
    print "SSS $bbono: $text\n" if $chain->last() > 0;
    print "\n";
  }
}


1;
