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

use Token;
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
  PARTICLE
  AMBIGUOUS
);

our $histo_title;

my $PREFIX = 'TITLE_';


sub split_on_some_numbers
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


sub fix_post_date
{
  # Can only do this when it would no longer destroy a date.
  my $text = pop;

  # 20xx/yy, 20xx-yy, 20xx_yy -> 20xx-20yy.
  $text =~ s/20(\d\d)[\/\-_](\d\d)\b/20$1-20$2/;

  # x/y -> x of y.
  $text =~ s/(\d)\/(\d)/$1 of $2/g;

  # x-y -> x to y.
  $text =~ s/\b(\d)-(\d)/$1 to $2/g;

  # 0x -> 200x.
  $text =~ s/\b(0\d)\b/20$1/g;

  # 20xx -> add spaces on either side.
  $text =~ s/(20\d\d)/ $1 /g;

  return $text;
}


sub split_on_capitals
{
  # Split on single capitals, assuming that each "word" has 3+ letters.
  my ($text) = @_;

  my @words = split(/\s+/, $text);
  my @result;

  foreach my $word (@words) 
  {
    if ($word =~ /^[a-zA-Z]+$/ && $word !~ /[A-Z](?:[a-z]{0,1}[A-Z]|\z)/)
    {
      $word =~ s/(?<=[a-z])(?=[A-Z])/ /g;
    }

    # Do not split if the word contains a sub-word of length < 3.
    push @result, $word;
  }

  return join(" ", @result);
}


sub split_on_dates
{
  my ($text, $tags, $values, $texts) = @_;

  @$values = split / - /, $text;
  @$tags = (0) x (1 + $#$values);
  @$texts = @$values;

  for my $i (reverse 0 .. $#$values)
  {
    my @date_values = 
      grep { $_ ne '' } split /(\d\d\d\d[-_]\d\d[-_]\d\d)/, $values->[$i];

    if ($#date_values > 0)
    {
      splice(@$values, $i+1, 0, (0) x $#date_values);
      splice(@$tags, $i+1, 0, (0) x $#date_values);

      for my $j (0 .. $#date_values)
      {
        if ($date_values[$j] =~ /^\d\d\d\d[-_]\d\d[-_]\d\d$/)
        {
          $tags->[$i+$j] = $PREFIX . 'DATE';
          $values->[$i+$j] = $date_values[$j];
          $texts->[$i+$j] = $date_values[$j];
        }
        else
        {
          $tags->[$i+$j] = 0;
          $values->[$i+$j] = fix_post_date($date_values[$j]);
          $texts->[$i+$j] = $date_values[$j];
        }
      }
    }
    else
    {
      $tags->[$i] = 0;
      $values->[$i] = fix_post_date($values->[$i]);
      $texts->[$i] = $values->[$i];
    }

    if ($i > 0)
    {
      # Make sure that elements on different sides of the ' - ' end up
      # in different chains.
      splice(@$tags, $i, 0, $PREFIX . 'DESTROY');
      splice(@$values, $i, 0, '');
      splice(@$texts, $i, 0, '');
    }
  }
}


sub split_on_multi
{
  my ($whole, $tags, $values, $texts) = @_;

  for my $core_tag (@TAG_ORDER)
  {
    my $mregex = $whole->get_multi_regex($core_tag);
    next if $mregex eq '';

    my $tag = $PREFIX . $core_tag;
    for my $i (reverse 0 .. $#$values)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$mregex/, $values->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        my $mp = $whole->get_multi($core_tag, lc($a[0]));
        if (defined $mp)
        {
          $tags->[$i] = $tag;
          $values->[$i] = $mp;
        }
      }
      else
      {
        splice(@$tags, $i, 1, (0) x ($#a+1));
        splice(@$values, $i, 1, @a);
        splice(@$texts, $i, 1, @a);

        for my $j ($i .. $i + $#a)
        {
          my $mp = $whole->get_multi($core_tag, lc($values->[$j]));
          if (defined $mp)
          {
            $tags->[$j] = $tag;
            $values->[$j] = $mp;
          }
        }
      }
    }
  }
}


sub title_specific_hashes
{
  my ($whole, $pos, $text, $chain, $histo) = @_;

  for my $core_tag (@TAG_ORDER)
  {
    my $fix = $whole->get_single($core_tag, lc($text));
    next unless defined $fix->{CATEGORY};

    my $tag = $PREFIX . $fix->{CATEGORY};

    append_singleton($chain, $pos, $tag, $fix->{VALUE}, $text);

    if ($tag eq $PREFIX . 'GENDER' && $fix->{VALUE} eq 'Open')
    {
      # Special case: Add an extra token.
      $tag = $PREFIX . 'AGE';
      append_singleton($chain, $pos, $tag, $fix->{VALUE},  $text);
    }
    elsif ($tag eq $PREFIX . 'AGE' && $fix->{VALUE} eq 'Girls')
    {
      # Special case: Add an extra token.
      $tag = $PREFIX . 'GENDER';
      append_singleton($chain, $pos, $tag, 'Women', $text);
    }

    return 1;
  }
  return 0;
}


sub study_value
{
  my ($whole, $value, $pos, $chain, $histo, $unknown_value_flag) = @_;

  my $token = Token->new();
  if ($value =~ /^\d+$/)
  {
    if ($value >= 1900 && $value < 2100)
    {
      append_singleton($chain, $pos, $PREFIX . 'YEAR', $value, $value);
    }
    else
    {
      append_token($chain, 'COUNTER', 'NUMERAL', $value, $value, $pos);
    }
    return;
  }
  elsif ($value =~ /^[A-HJa-h]$/)
  {
    append_token($chain, 'COUNTER', 'LETTER', $value, $value, $pos);
    return;
  }
  elsif (my $ord = Util::ordinal_to_numeral($value))
  {
    $ord =~ s/^0+//; # Remove leading zeroes
    append_token($chain, 'COUNTER', 'ORDINAL', $ord, $value, $pos);
    return;
  }

  # The general solution.
  return if title_specific_hashes($whole, $pos, $value, $chain, $histo);

  append_token($chain, 'UNKNOWN', '', $value, $value, $pos);

  print "QQQ ", $value, "\n";
  $$unknown_value_flag = 1;
}


sub study_component
{
  my ($whole, $value, $chain, $token_no, $histo, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_value_flag = 0;
  if ($value =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_value($whole, $letters, $token_no, $chain, 
      $histo, \$unknown_value_flag);
    $$token_no++;

    study_value($whole, $digits, $token_no, $chain, 
      $histo, \$unknown_value_flag);
    $$token_no++;
  }
  else
  {
    study_value($whole, $value, $token_no, $chain, 
      $histo, \$unknown_value_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_value_flag;
}


sub append_token
{
  my ($chain, $category, $tag, $value, $text, $pos) = @_;

  $chain->append_general($category, $tag, $value, $text, $pos);

  if ($tag =~ /TITLE/)
  {
    $main::histo_title->incr($tag);
  }
  else
  {
    $main::histo_title->incr($PREFIX . $tag);
  }
}


sub append_singleton
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  if ($tag eq 'TITLE_ROMAN')
  {
    # TODO Kludge.
    append_token($chain, 'COUNTER', $tag, $value, $text, $pos);
  }
  else
  {
    append_token($chain, 'SINGLETON', $tag, $value, $text, $pos);
  }
}


sub study
{
  my ($whole, $bbono, $text, $chain, $histo, $unknowns) = @_;

  return if $text eq '';

  my $ntext = split_on_some_numbers($text);

  my $stext = split_on_capitals($ntext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($stext, \@tags, \@values, \@texts);
  split_on_multi($whole, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._:;&@"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      append_singleton($chain, $i, $tags[$i], $values[$i], $texts[$i]);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $value (@a)
      {
        study_component($whole, $value, $chain, \$token_no, 
          $histo, \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    print "TTT $bbono: $text\n" if $chain->last() > 0;
    print "\n";
  }
}


1;
