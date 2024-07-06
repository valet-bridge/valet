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

  # Nameless teams.
  $text =~ s/#\d+\s+vs*\s+#*\d+//;
  $text =~ s/tm\s+\d+\s+vs\s+tm\s+\d+//i;
  $text =~ s/team\s+\d+\s+vs\s+team\s+\d+//i;
  $text =~ s/- \d+ v \d+//i;

  # Add some spacing.
  $text =~ s/^(\d+)th([a-z])/$1th $2/i;
  $text =~ s/^([01]\d)([A-SU-Z])/20$1 $2/; # Kludge, avoid th
  $text =~ s/\b([1-9])([A-D])\b/$1 $2/gi;
  $text =~ s/\b(\d)of(\d)\b/$1 of $2/g;
  
  # n_n (n of n), n&n (n to n).
  if ($text =~ /(\d+)[_&](\d+)/ && $1 <= $2 && $1 < 1990)
  {
    $text =~ s/(\d+)_(\d+)/$1 of $2/;
    $text =~ s/(\d+)&(\d+)/$1 to $2/;
  }

  # A hodge-podge, mostly of spacing.
  $text =~ s/pokal([a-z])/pokal $1/i;
  $text =~ s/-th\b/th/g;
  $text =~ s/(\d) th\b/$1th/g;
  $text =~ s/2 nd\b/2nd/g;
  $text =~ s/\bUSA[12]/USA/g;
  $text =~ s/\bUSA 2\b/USA/g;
  $text =~ s/II-nd/2nd/g;
  $text =~ s/\b(\d\d) _$/Rof$1/g;
  $text =~ s/\bF([12])\b/Final $1/g;

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
  my $unknown_value_flag = 0;
  if ($value =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_value($whole, $letters, $token_no, $chain, \$unknown_value_flag);
    $$token_no++;

    study_value($whole, $digits, $token_no, $chain, \$unknown_value_flag);
    $$token_no++;
  }
  else
  {
    study_value($whole, $value, $token_no, $chain, \$unknown_value_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_value_flag;
}


sub study
{
  my ($whole, $bbono, $text, $chain, $unknowns) = @_;

  return if $text eq '';

  my $ntext = title_specific_inline($text);
  my $stext = split_on_capitals($ntext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($stext, \@tags, \@values, \@texts, 1);

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
