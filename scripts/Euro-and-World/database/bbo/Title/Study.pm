#!perl

package Title::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(study print_title_stats);

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

my %HIT_STATS;

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
  my ($text, $parts, $tags) = @_;

  @$parts = split / - /, $text;
  @$tags = (0) x (1 + $#$parts);

  for my $i (reverse 0 .. $#$parts)
  {
    my @date_parts = 
      grep { $_ ne '' } split /(\d\d\d\d[-_]\d\d[-_]\d\d)/, $parts->[$i];

    if ($#date_parts > 0)
    {
      splice(@$parts, $i+1, 0, (0) x $#date_parts);
      splice(@$tags, $i+1, 0, (0) x $#date_parts);

      for my $j (0 .. $#date_parts)
      {
        if ($date_parts[$j] =~ /^\d\d\d\d[-_]\d\d[-_]\d\d$/)
        {
          $parts->[$i+$j] = $date_parts[$j];
          $tags->[$i+$j] = $PREFIX . 'DATE';
        }
        else
        {
          $parts->[$i+$j] = fix_post_date($date_parts[$j]);
          $tags->[$i+$j] = 0;
        }
      }
    }
    else
    {
      $parts->[$i] = fix_post_date($parts->[$i]);
      $tags->[$i] = 0;
    }

    if ($i > 0)
    {
      # Make sure that elements on different sides of the ' - ' end up
      # in different chains.
      splice(@$parts, $i, 0, '');
      splice(@$tags, $i, 0, $PREFIX . 'DESTROY');
    }
  }
}


sub split_on_multi
{
  my ($whole, $parts, $tags) = @_;

  for my $core_tag (@TAG_ORDER)
  {
    my $mregex = $whole->get_multi_regex($core_tag);
    next if $mregex eq '';

    my $tag = $PREFIX . $core_tag;
    for my $i (reverse 0 .. $#$parts)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$mregex/, $parts->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        my $mp = $whole->get_multi($core_tag, lc($a[0]));
        if (defined $mp)
        {
          $parts->[$i] = $mp;
          $tags->[$i] = $tag;
        }
      }
      else
      {
        splice(@$parts, $i, 1, @a);
        splice(@$tags, $i, 1, (0) x ($#a+1));

        for my $j ($i .. $i + $#a)
        {
          my $mp = $whole->get_multi($core_tag, lc($parts->[$j]));
          if (defined $mp)
          {
            $parts->[$j] = $mp;
            $tags->[$j] = $tag;
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


sub study_part
{
  my ($whole, $part, $i, $chain, $histo, $unknown_part_flag) = @_;

  my $token = Token->new();
  if ($part =~ /^\d+$/)
  {
    if ($part >= 1900 && $part < 2100)
    {
      append_singleton($chain, $i, 
        $PREFIX . 'YEAR', $part, $part);
    }
    else
    {
      append_numeral($chain, $i, 
        $PREFIX . 'INTEGER', $part, $part);
    }
    return;
  }
  elsif ($part =~ /^[A-HJa-h]$/)
  {
    append_letter($chain, $i, 
      $PREFIX . 'LETTER', $part, $part);
    return;
  }
  elsif (my $ord = Util::ordinal_to_numeral($part))
  {
    $ord =~ s/^0+//; # Remove leading zeroes
    append_ordinal($chain, $i, 
      $PREFIX . 'ORDINAL', $ord, $part);
    return;
  }

  # The general solution.
  return if title_specific_hashes($whole, $i, $part, $chain, $histo);

  append_unknown($chain, $i, $part);

  print "QQQ ", $part, "\n";
  $$unknown_part_flag = 1;
}


sub study_component
{
  my ($whole, $part, $chain, $token_no, $histo, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_part_flag = 0;
  if ($part =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_part($whole, $letters, $token_no, $chain, 
      $histo, \$unknown_part_flag);
    $$token_no++;

    study_part($whole, $digits, $token_no, $chain, 
      $histo, \$unknown_part_flag);
    $$token_no++;
  }
  else
  {
    study_part($whole, $part, $token_no, $chain, 
      $histo, \$unknown_part_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_part_flag;
}


sub append_singleton
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  if ($tag eq 'TITLE_ROMAN')
  {
    # TODO Kludge.
    append_roman($chain, $pos, $tag, $value, $text);
    return;
  }

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_singleton($tag, $value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
  $HIT_STATS{TOTAL}++;
}


sub append_numeral
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_numeral_counter($value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
  $HIT_STATS{TOTAL}++;
}


sub append_ordinal
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_ordinal_counter($value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
  $HIT_STATS{TOTAL}++;
}


sub append_letter
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_letter_counter($value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
  $HIT_STATS{TOTAL}++;
}


sub append_roman
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_roman_counter($value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
  $HIT_STATS{TOTAL}++;
}


sub append_unknown
{
  my ($chain, $pos, $value) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $value);
  $token->set_unknown_full($value);
  $chain->append($token);

  $HIT_STATS{UNMATCHED}++;
  $HIT_STATS{TOTAL}++;
}


sub study
{
  my ($whole, $bbono, $text, $chain, $histo, $unknowns) = @_;

  return if $text eq '';

  my $ntext = split_on_some_numbers($text);

  my $stext = split_on_capitals($ntext);

  my @parts = ();
  my @tags = (0);
  split_on_dates($stext, \@parts, \@tags);
  split_on_multi($whole, \@parts, \@tags);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._:;&@"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#parts)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      append_singleton($chain, $i, $tags[$i], $parts[$i], $parts[$i]);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $parts[$i]);
      foreach my $part (@a)
      {
        study_component($whole, $part, $chain, \$token_no, 
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


sub print_title_stats
{
  for my $key (sort keys %HIT_STATS)
  {
    printf("%-20s %6d\n", $key, $HIT_STATS{$key});
  }

  print "\n";
}


1;
