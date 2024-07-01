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
use lib './Event';

use Token;
use Separators;

use Event::Cookbook;

my @TAG_ORDER = qw(
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
      $part =~ /^(\d+)e$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    return $1;
  }
  elsif (lc($part) eq 'first')
  {
    return 1;
  }
  elsif (lc($part) eq 'second')
  {
    return 2;
  }
  else
  {
    return 0;
  }
}


sub fix_small_ordinal
{
  my ($part, $i, $chain) = @_;
  if (my $ord = is_small_ordinal($part))
  {
    # We don't check whether the ending matches the number.
    if ($ord >= 0 && $ord < 100)
    {
      $ord =~ s/^0+//; # Remove leading zeroes
      my $token = Token->new();
      $token->set_origin($i, $part);
      $chain->append($token);
      $token->set_ordinal_counter($ord);
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


sub split_on_trailing_digits
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    next unless $part =~ /^(.*[a-z])(\d+)$/i;

    my ($letters, $digits) = ($1, $2);
    next if $letters eq 'U' || $letters eq 'D';
    next if $digits > 50;

    splice(@$list_ref, $i, 0, ('') x 2);
    $list_ref->[$i] = $letters;
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $digits;
  }
}


sub title_specific_hashes
{
  my ($whole, $pos, $text, $chain) = @_;

  for my $tag (@TAG_ORDER)
  {
    my $fix = $whole->get_single($tag, lc($text));
    next unless defined $fix->{CATEGORY};

    my $tag = $PREFIX . $fix->{CATEGORY};

    append_singleton($chain, $pos, $tag, $fix->{VALUE}, $text);

    if ($tag eq 'TITLE_GENDER' && $fix->{VALUE} eq 'Open')
    {
      # Special case: Add an extra token.
      $tag = $PREFIX . 'AGE';
      append_singleton($chain, $pos, $tag, $fix->{VALUE},  $text);
    }
    elsif ($tag eq 'TITLE_AGE' && $fix->{VALUE} eq 'Girls')
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
  my ($whole, $part, $i, $chain, $unknown_part_flag) = @_;

  $HIT_STATS{TOTAL}++;

  my $token = Token->new();
  if (set_token($part, $token))
  {
    $token->set_origin($i, $part);
    $chain->append($token);

    $token->set_singleton('SEPARATOR', $part);
    $HIT_STATS{SEPARATOR}++;
    return;
  }
  elsif ($part =~ /^\d+$/)
  {
    if ($part >= 1900 && $part < 2100)
    {
      append_singleton($chain, $i, 'TITLE_YEAR', $part, $part);
    }
    else
    {
      $token->set_origin($i, $part);
      $chain->append($token);
      $token->set_numeral_counter($part);
      $HIT_STATS{TITLE_INTEGER}++;
    }
    return;
  }
  elsif ($part =~ /^[A-HJa-h]$/)
  {
    $token->set_origin($i, $part);
    $chain->append($token);
    $token->set_letter_counter($part);
    $HIT_STATS{TITLE_LETTER}++;
    return;
  }
  elsif (fix_small_ordinal($part, $i, $chain))
  {
    $HIT_STATS{TITLE_ORDINAL}++;
    return;
  }

  # The general solution.
  return if title_specific_hashes($whole, $i, $part, $chain);

  # Some use of other hashes.
  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'NUMERAL')
    {
      $token->set_origin($i, $part);
      $chain->append($token);
      $token->set_numeral_counter($fix_event->{VALUE});
      $HIT_STATS{TITLE_NUMERAL}++;
      return;
    }
    elsif ($category eq 'ROMAN')
    {
      $token->set_origin($i, $part);
      $chain->append($token);
      $token->set_roman_counter($fix_event->{VALUE});
      $HIT_STATS{TITLE_ROMAN}++;
      return;
    }
  }

  append_unknown($chain, $i, $part);
  $HIT_STATS{UNMATCHED}++;

  print "QQQ ", $part, "\n";
  $$unknown_part_flag = 1;
}


sub split_on_some_numbers
{
  my ($text) = @_;

  if ($text =~ /1[\/_](\d)\s+final/i)
  {
    my $n = $1;
    warn "Haven't learned this yet: $text" unless $n == 2 || $n == 4;
    $text =~ s/1\/4 finale*/quarterfinal/;
    $text =~ s/1\/2 finale*/semifinal/;
  }

  # Years.
  $text =~ s/'(9\d)/19$1/g;
  $text =~ s/'(0\d)/20$1/g;
  $text =~ s/'(1\d)/20$1/g;

  # Nameless teams.
  $text =~ s/#\d+\s+vs*\s+#*\d+//;
  $text =~ s/tm\s+\d+\s+vs\s+tm\s+\d+//i;
  $text =~ s/team\s+\d+\s+vs\s+team\s+\d+//i;
  $text =~ s/- \d+ v \d+//i;

  $text =~ s/^(\d+)th([a-z])/$1th $2/i;
  $text =~ s/^([01]\d)([A-SU-Z])/20$1 $2/; # Kludge, avoid th
  $text =~ s/\b([1-9])([A-D])\b/$1 $2/gi;
  $text =~ s/\b(\d)of(\d)\b/$1 of $2/g;
  
  if ($text =~ /(\d+)[_&](\d+)/ && $1 <= $2 && $1 < 1990)
  {
    $text =~ s/(\d+)_(\d+)/$1 of $2/;
    $text =~ s/(\d+)&(\d+)/$1 to $2/;
  }

  # Doesn't really belong here.
  $text =~ s/pokal([a-z])/pokal $1/i;
  $text =~ s/-th\b/th/g;
  $text =~ s/(\d) th\b/$1th/g;
  $text =~ s/2 nd\b/2nd/g;
  $text =~ s/\bUSA[12]/USA/g;
  $text =~ s/\bUSA 2\b/USA/g;
  $text =~ s/II-nd/2nd/g;
  $text =~ s/\b(\d\d) _$/Rof$1/g;
  $text =~ s/\bF([12])\b/Final $1/g;

# my $t = $text;
# print "XERE $t | $text\n" unless $t eq $text;

  return $text;
}


sub split_on_capitals
{
  my ($text) = @_;

  my @words = split(/\s+/, $text);
  my @result;

  foreach my $word (@words) 
  {
    if ($word =~ /^[a-zA-Z]+$/ && $word !~ /[A-Z](?:[a-z]{0,1}[A-Z]|\z)/)
    {
      $word =~ s/(?<=[a-z])(?=[A-Z])/ /g;
    }

    # Do not split if the word contains a sub-word of length < 3
    push @result, $word;
  }

  return join(" ", @result);
}


sub split_on_multi
{
  my ($whole, $text, $parts, $tags) = @_;

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
          $tags->[$i+$j] = 'TITLE_DATE';
          $HIT_STATS{TITLE_DATE}++;
        }
        else
        {
          # Couldn't do this sooner, as it would destroy the date.
          my $t = $date_parts[$j];

          $t =~ s/20(\d\d)[\/\-_](\d\d)/20$1-20$2/;
          $t =~ s/(\d)\/(\d)/$1 of $2/g;
          $t =~ s/\b(\d)-(\d)/$1 to $2/g;
          $t =~ s/\b(0\d)\b/20$1/g;
          $t =~ s/(20\d\d)/ $1 /g;

          $parts->[$i+$j] = $t;
          $tags->[$i+$j] = 0;
        }
      }
    }
    else
    {
      my $t = $parts->[$i];

      $t =~ s/20(\d\d)[\/\-_](\d\d)\b/20$1-20$2/;
      $t =~ s/(\d)\/(\d)/$1 of $2/g;
      $t =~ s/\b(\d)-(\d)/$1 to $2/g;
      $t =~ s/\b(0\d)\b/20$1/g;
      $t =~ s/(20\d\d)/ $1 /g;

      $parts->[$i] = $t;
      $tags->[$i] = 0;
    }

    if ($i > 0)
    {
      # Make sure that elements on different sides of the ' - ' end up
      # in different chains.
      splice(@$parts, $i, 0, '');
      splice(@$tags, $i, 0, 'TITLE_DESTROY');
    }
  }

  for my $core_tag (@TAG_ORDER)
  {
    my $tag = $PREFIX . $core_tag;
    my $mregex = $whole->get_multi_regex($core_tag);

    next if $mregex eq '';
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

sub study_component
{
  my ($whole, $part, $chain, $token_no, $unsolved_flag) = @_;

  # Split on trailing digits.
  my $unknown_part_flag = 0;
  if ($part =~ /^(.*[a-z])(\d+)$/i &&
      $1 ne 'U' && $1 ne 'D')
  {
    my ($letters, $digits) = ($1, $2);

    study_part($whole, $letters, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;

    study_part($whole, $digits, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }
  else
  {
    study_part($whole, $part, $token_no, $chain, \$unknown_part_flag);
    $$token_no++;
  }

  $$unsolved_flag = 1 if $unknown_part_flag;
}


sub append_singleton
{
  my ($chain, $pos, $tag, $value, $text) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_singleton($tag, $value);
  $chain->append($token);

  $HIT_STATS{$tag}++;
}


sub append_unknown
{
  my ($chain, $pos, $value) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $value);
  $token->set_unknown_full($value);
  $chain->append($token);
}


sub study
{
  my ($whole, $bbono, $text, $chain, $unknowns) = @_;

  return if $text eq '';

  my $ntext = split_on_some_numbers($text);

  my $stext = split_on_capitals($ntext);

  my @parts = ();
  my @tags = (0);
  split_on_multi($whole, $stext, \@parts, \@tags);

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
        study_component($whole, $part, $chain, \$token_no, \$unsolved_flag);
      }
    }
  }

  print "TTT $bbono: $text\n" if ($unsolved_flag && $chain->last() > 0);
  print "\n" if $unsolved_flag;
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
