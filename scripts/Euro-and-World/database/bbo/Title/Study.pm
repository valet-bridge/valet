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
  # { START => , END => , TEXT => '',
    # CORR => '' },

  { START => 3620, END => 3631, TEXT => 'Pula', 
    CORR => 'Pula Bridge Festival' },
  { START => 3708, END => 3728, TEXT => 'CCBA Championships', 
    CORR => 'Chinese Open Teams' },
  { START => 3729, END => 3738, TEXT => 'Stara Zagora 2007 Open Teams',
    CORR => 'Stara Zagora Open Teams 2007' },
  { START => 4339, END => 4346, TEXT => 'Canadian National Championships',
    CORR => 'Canadian Open Teams' },
  { START => 4339, END => 4346, TEXT => 'Canadian Championship',
    CORR => 'Canadian Open Teams' },
  { START => 4392, END => 4407, TEXT => 'Indonesia Qual Multievent',
    CORR => 'Indonesian Open Trials' },
  { START => 6268, END => 6279, TEXT => 'Selection Senior', 
    CORR => 'French Senior Trials' },
  { START => 6856, END => 6975, TEXT => 'Cap Gemini', 
    CORR => 'Cap Gemini World Top Tournament' },
  { START => 7843, END => 7865, TEXT => 'ACBL 1999 Open Team Trials', 
    CORR => '1999 USA International Team Trials' },
  { START => 8123, END => 8127, TEXT => 'MONBU Kanto-Final',
    CORR => 'MONBU Kanto Teams - Final' },
  { START => 8182, END => 8185, TEXT => 'Vic Playoff',
    CORR => 'Victorian Open Teams - Playoff' },
  { START => 8186, END => 8199, TEXT => 'White House', 
    CORR => 'White House International' },
  { START => 8236, END => 8242, TEXT => 'Selection Francaise', 
    CORR => 'French Open Trials' },
  { START => 8324, END => 8331, TEXT => 'Canadian Team',
    CORR => 'Canadian Open Teams' },
  { START => 8489, END => 8503, TEXT => 'Selection Francaise', 
    CORR => 'French Open Trials' },
  { START => 8652, END => 8656, TEXT => 'Team Orange - Ireland',
    CORR => 'Friendly Match' },
  { START => 8680, END => 8688, TEXT => 'Estoril',
    CORR => 'Estoril Swiss Teams' },
  { START => 8802, END => 8807, TEXT => 'Interclub',
    CORR => 'French Cup' },
  { START => 8808, END => 8813, TEXT => 'Zone 7',
    CORR => 'South Pacific Zone 7 Championship' },
  { START => 8967, END => 8982, TEXT => 'England v Netherlands Open',
    CORR => 'Friendly Match' },
  { START => 9728, END => 9770, TEXT => 'Indonesian Final Premier League',
    CORR => 'Indonesian Premier League Final' },
  { START => 9866, END => 9902, TEXT => 'Netherlands - Poland',
    CORR => 'Friendly Match' },
  { START => 9951, END => 9986, TEXT => 'Lozenets', 
    CORR => 'Lozenets Bridge Festival' },
  { START => 11116, END => 11159, TEXT => 'Pula',
    CORR => 'Pula Bridge Festival' },
  { START => 11683, END => 11873, TEXT => 'Premier League', 
    CORR => 'English Premier League' },
  { START => 12378, END => 12400, TEXT => 'National Seniors Teams',
    CORR => 'Australian Seniors Teams' },
  { START => 12878, END => 12914, TEXT => 'Selection Ostende',
    CORR => 'French Open Trials' },
  { START => 13235, END => 13242, TEXT => 'Top Individual',
    CORR => 'Polish Top Individual' },
  { START => 13270, END => 13276, TEXT => 'Selection Ostende',
    CORR => 'French Open Trials' },
  { START => 13279, END => 13297, TEXT => 'Selection Open Ostende',
    CORR => 'French Open Trials' },
  { START => 13279, END => 13297, TEXT => 'Selection Dames Ostende',
    CORR => 'French Women Trials' },
  { START => 13598, END => 13615, 
    TEXT => 'Indonesia Bridge Champs - Inter Province',
    CORR => 'Indonesian Inter-Province Championship' },
  { START => 13748, END => 13840, TEXT => 'Selection Dame Ostende',
    CORR => 'French Women Trials' },
  { START => 20118, END => 20186, TEXT => 'S[eé]l[eé]ction',
    CORR => 'French Open Trials' },
  { START => 21056, END => 21126, TEXT => 'Sélection',
    CORR => 'French Open Trials' },
  { START => 21266, END => 21273, TEXT => 'Senior KO',
    CORR => 'United States Seniors Bridge Championship' },
  { START => 22117, END => 22135, TEXT => 'Maharashtra State Championship',
    CORR => 'Maharashtra State Pairs' },
  { START => 22149, END => 22252, TEXT => 'Zurich',
    CORR => 'Zurich Open Teams' },
  { START => 22390, END => 22404, 
    TEXT => 'Teams Tournament - Cracow Poland',
    CORR => 'Krakow Teams' },
  { START => 22408, END => 22415, TEXT => 'Cracow Poland',
    CORR => 'Krakow Teams' },
  { START => 22522, END => 22532, 
    TEXT => 'Turkish 2012 Inter-Universities Bridge Champ_',
    CORR => 'Turkish Universities Championship' },
  { START => 22649, END => 22671, TEXT => 'S[eé]lection Dame',
    CORR => "French Women's Trials" },
  { START => 23831, END => 23991, TEXT => 'Euro Teams',
    CORR => 'European Bridge Teams Championship' },
  { START => 23831, END => 23991, TEXT => 'Euro Team',
    CORR => 'European Team Championship' },
  { START => 27188, END => 27220, TEXT => 'Zurich',
    CORR => 'Zurich Open Teams' },
  { START => 27811, END => 27838, TEXT => 'Yeh Bros',
    CORR => 'Yeh Bros Cup' },
  { START => 30147, END => 30160, TEXT => 'Pula',
    CORR => 'Pula Bridge Festival' },
  { START => 31259, END => 31335, TEXT => 'Sélection Open',
    CORR => 'French Open Trials' },
  { START => 31273, END => 31748, TEXT => 'Winter Nationals',
    CORR => 'Turkish Winter Open Teams' },
  { START => 32082, END => 32122, TEXT => 'Lalit Mohanka',
    CORR => 'Lalit Mohanka Memorial' },
  { START => 32176, END => 32226, TEXT => 'Australian Playoffs',
    CORR => 'Australian Open Teams - Playoffs' },
  { START => 32309, END => 32327, TEXT => 'Seniors Trials',
    CORR => 'Polish Senior Trials' },
  { START => 33067, END => 33142, TEXT => 'S[eé]lection Open',
    CORR => 'French Open Trials' },
  { START => 35315, END => 35394, TEXT => 'Pula',
    CORR => 'Pula Bridge Festival' },
  { START => 33426, END => 33457, TEXT => 'Sweden vs Poland',
    CORR => 'Friendly Match' },
  { START => 35459, END => 35512, 
    TEXT => 'Finale Nationale - Interclubs Division 1',
    CORR => 'French First Division' },
  { START => 35487, END => 35547, TEXT => 'Inter Province',
    CORR => 'Indonesian Inter-Province Championship' },
  { START => 35548, END => 35630, TEXT => 'Inter Club',
    CORR => 'Indonesian Inter-Club Championship' },
  { START => 37442, END => 37466, TEXT => 'Bulgarian Group A',
    CORR => 'Bulgarian Open Teams - Group A' },
  { START => 37652, END => 37712, TEXT => 'Lalit Mohanka',
    CORR => 'Lalit Mohanka Memorial' },
  { START => 37680, END => 37707, TEXT => 'Denmark Team Training',
    CORR => 'Training Match' },
  { START => 37718, END => 37724, TEXT => 'Denmark Women Team Training',
    CORR => 'Training Match' },
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


sub local_substitutions
{
  my ($text, $bbono) = @_;

  for my $entry (@LOCAL_SUBS)
  {
    if ($bbono >= $entry->{START} && $bbono <= $entry->{END})
    {
      $text =~ s/$entry->{TEXT}/$entry->{CORR}/i;
    }
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
