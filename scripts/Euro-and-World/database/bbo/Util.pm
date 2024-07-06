#!perl

package Util;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(ordinal_to_numeral ordinalize unteam 
  split_on_dates split_on_capitals split_on_multi
  append_token 
  singleton_non_tag_matches singleton_tag_matches);


sub ordinal_to_numeral
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
    my $ord = $1;
    $ord =~ s/^0+//; # Remove leading zeroes
    if ($ord < 0 || $ord >= 100)
    {
      die "Large ordinal? $ord";
    }
    return $1;
  }
  # elsif (lc($part) eq 'first')
  # {
    # return 1;
  # }
  # elsif (lc($part) eq 'second')
  # {
    # return 2;
  # }
  else
  {
    return 0;
  }
}


sub ordinalize
{
  my ($value) = @_;

  my $last = substr($value, -1);

  if ($last == 1)
  {
    return $value . 'st';
  }
  elsif ($last == 2)
  {
    return $value . 'nd';
  }
  elsif ($last == 3)
  {
    return $value . 'rd';
  }
  else
  {
    return $value . 'th';
  }
}


sub unteam
{
  my ($text, $result) = @_;

  my $res = $text;
  my $team1 = $result->{TEAM1};
  my $team2 = $result->{TEAM2};

  $res =~ s/\Q$team1\E//i if defined $team1 && length($team1) > 1;
  $res =~ s/\Q$team2\E//i if defined $team2 && length($team2) > 1;
  return $res;
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


sub split_on_dates
{
  my ($text, $tags, $values, $texts, $post_fix_flag) = @_;

  $text =~ s/(\d{4})(\d{2})(\d{2})0(\d)/$1-$2-$3 Round $4 /g;

  @$values = split / - /, $text;
  @$tags = (0) x (1 + $#$values);
  @$texts = @$values;

  my $regex1 = qr/(\d{4}[-._]\d{2}[-._]\d{2})/;
  my $regex2 = qr/(\d{4})[-._](\d{2})[-._](\d{2})/;

  for my $i (reverse 0 .. $#$values)
  {
    my @date_values = grep { $_ ne '' } split /$regex1/, $values->[$i];

    if ($#date_values > 0)
    {
      splice(@$values, $i+1, 0, (0) x $#date_values);
      splice(@$tags, $i+1, 0, (0) x $#date_values);

      for my $j (0 .. $#date_values)
      {
        if ($date_values[$j] =~ /^$regex2$/)
        {
          my ($year, $month, $day) = ($1, $2, $3);

          $tags->[$i+$j] = 'DATE';
          $values->[$i+$j] = "$year-$month-$day";
          $texts->[$i+$j] = $date_values[$j];
        }
        else
        {
          $tags->[$i+$j] = 0;
          if ($post_fix_flag)
          {
            $values->[$i+$j] = fix_post_date($date_values[$j]);
          }
          else
          {
            $values->[$i+$j] = $date_values[$j];
          }
          $texts->[$i+$j] = $date_values[$j];
        }
      }
    }
    elsif ($values->[$i] =~ /^$regex2$/)
    {
      my ($year, $month, $day) = ($1, $2, $3);

      $tags->[$i] = 'DATE';
      $values->[$i] = "$year-$month-$day";
      $texts->[$i] = $values->[$i];
    }
    else
    {
      $tags->[$i] = 0;
      if ($post_fix_flag)
      {
        $values->[$i] = fix_post_date($values->[$i]);
      }
      $texts->[$i] = $values->[$i];
    }

    if ($i > 0)
    {
      # Make sure that elements on different sides of the ' - ' end up
      # in different chains.

      # TODO post_fix_flag really indicates TITLE and not EVENT.
     
      if ($post_fix_flag)
      {
        splice(@$tags, $i, 0, 'DESTROY');
        splice(@$values, $i, 0, '');
        splice(@$texts, $i, 0, '');
      }
      else
      {
        splice(@$tags, $i, 0, ('SEPARATOR', 'DESTROY', 'SEPARATOR'));
        splice(@$values, $i, 0, ('|', '', '|'));
        splice(@$texts, $i, 0, ('', '', ''));
      }
    }
  }
}


sub split_on_capitals
{
  # Split on single capitals, assuming that each "word" has 3+ letters.
  my ($text) = @_;

  # my @words = split(/\s+/, $text);
  $text =~ s/\s+/ /g;
  my @words = split(/([\s-])/, $text);
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

  return join('', @result);
}


sub split_on_multi
{
  my ($whole, $tag_order, $sep_flag, $tags, $values, $texts) = @_;

  for my $tag (@$tag_order)
  {
    my $mregex = $whole->get_multi_regex($tag);
    next if $mregex eq '';

    for my $i (reverse 0 .. $#$values)
    {
      next if $tags->[$i] ne '0';
      my @a = grep { $_ ne '' } split /$mregex/, $values->[$i];

      if ($#a == 0)
      {
        # Optimize for this frequent special case.
        my $mp = $whole->get_multi($tag, lc($a[0]));
        if (defined $mp)
        {
          $tags->[$i] = $tag;
          $values->[$i] = $mp;
        }
      }
      elsif ($sep_flag)
      {
        # Put separators between each element.
        my $ad = 2 * ($#a + 1) - 1;
        splice(@$tags, $i, 1, (0) x $ad);
        splice(@$values, $i, 1, ('') x $ad);
        splice(@$texts, $i, 1, ('') x $ad);

        for my $ai (0 .. $#a)
        {
          my $j = $i + 2 * $ai;
          my $mp = $whole->get_multi($tag, lc($a[$ai]));
          if (defined $mp)
          {
            $tags->[$j] = $tag;
            $values->[$j] = $mp;
            $texts->[$j] = $a[$ai];
          }
          else
          {
            $values->[$j] = $a[$ai];
            $texts->[$j] = $a[$ai];
          }

          $tags->[$j+1] = 'SEPARATOR';
          $values->[$j+1] = '|';
          $texts->[$j+1] = '';
        }
      }
      else
      {
        splice(@$tags, $i, 1, (0) x ($#a+1));
        splice(@$values, $i, 1, @a);
        splice(@$texts, $i, 1, @a);

        for my $j ($i .. $i + $#a)
        {
          my $mp = $whole->get_multi($tag, lc($values->[$j]));
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


sub append_token
{
  my ($chain, $category, $tag, $value, $text, $pos, $histo, $prefix) = @_;

  if ($tag eq 'ROMAN' || $tag eq 'ORDINAL')
  {
    # As Tag::Roman finds this, it appears as a SINGLETON.
    $category = 'COUNTER';
  }
  elsif ($tag eq 'ITERATOR' || $tag eq 'AMBIGUOUS')
  {
    $category = $tag;
    $tag = uc($value);
  }

  $chain->append_general($category, $tag, $value, $text, $pos);

  $histo->incr($prefix . $tag);
}


sub singleton_non_tag_matches
{
  my ($value, $pos, $chain, $histo, $prefix) = @_;

  if ($value =~ /^\d+$/)
  {
    if ($value >= 1900 && $value < 2100)
    {
      append_token($chain, 'SINGLETON', 'YEAR', $value, $value,
        $pos, $histo, $prefix);
    }
    else
    {
      $value =~ s/^0+// unless $value == 0;
      append_token($chain, 'COUNTER', 'NUMERAL', $value, $value,
        $pos, $histo, $prefix);
    }
    return 1;
  }
  elsif ($value =~ /^[A-EHa-eh]$/)
  {
    append_token($chain, 'COUNTER', 'LETTER', $value, $value,
      $pos, $histo, $prefix);
    return 1;
  }
  elsif (my $ord = Util::ordinal_to_numeral($value))
  {
    append_token($chain, 'COUNTER', 'ORDINAL', $ord, $value,
      $pos, $histo, $prefix);
    return 1;
  }
  return 0;
}


sub singleton_tag_matches
{
  my ($whole, $tag_order, $pos, $text, $sep_flag, $chain,
    $histo, $prefix) = @_;

  for my $core_tag (@$tag_order)
  {
    my $fix = $whole->get_single($core_tag, lc($text));
    next unless defined $fix->{CATEGORY};

    my $tag = $fix->{CATEGORY};

    append_token($chain, 'SINGLETON', $tag, $fix->{VALUE}, $text, 
      $pos, $histo, $prefix);

    if ($tag eq 'GENDER' && $fix->{VALUE} eq 'Open')
    {
      # Special case: Add an extra token.
      if ($sep_flag)
      {
        append_token($chain, 'SEPARATOR', 'VIRTUAL', '|', '', 
          $pos, $histo, $prefix);
      }

      append_token($chain, 'SINGLETON', 'AGE', $fix->{VALUE}, $text, 
        $pos, $histo, $prefix);
    }
    elsif ($tag eq 'AGE' && $fix->{VALUE} eq 'Girls')
    {
      # Special case: Add an extra token.
      if ($sep_flag)
      {
        append_token($chain, 'SEPARATOR', 'VIRTUAL', '|', '', 
          $pos, $histo, $prefix);
      }

      append_token($chain, 'SINGLETON', 'GENDER', 'Women', $text, 
        $pos, $histo, $prefix);
    }

    return 1;
  }
  return 0;
}

1;
