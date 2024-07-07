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
  TNAME
  DESTROY
  TWORD
  ORIGIN
  MEET
  CLUB

  ORGANIZATION 
  ZONE 
  SPONSOR 
  COUNTRY 
  NATIONALITY
  REGION 
  CITY 
  QUARTER 
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
  DAY
  ORDINAL
  PARTICLE
  AMBIGUOUS
);

my $PREFIX = 'TITLE_';
our $histo_title;


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
  $$token_no++;

  if ($digits ne '')
  {
    # Add the digits if they exist.
    singleton_numeral($digits, $token_no, $chain, 
      $main::histo_title, $PREFIX);
    $$token_no++;
  }
}


sub study
{
  my ($whole, $bbono, $text, $chain, $unknowns) = @_;

  return if $text eq '';

  my $stext = split_on_capitals($text);
  my $ntext = title_specific_inline($stext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($ntext, \@tags, \@values, \@texts, 1);
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
        $texts[$i], $token_no, $main::histo_title, $PREFIX);
      $token_no++;
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
