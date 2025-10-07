#!perl

package Inspect;

# Can generate the following values of CATEGORY:
# CODE
# COUNTRY
# FLUFF
# LEVEL
# LIST
# MAGIC
# NAMELIKE
# PRIVATE
# SYSTEM
#
# It leaves in place categories that are not overwritten,
# so e.g. OPEN can pass through.


use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($sublines $fluffed_lines $system_lines
  $known_names $late_mails $both_last $both_neither inspect_paragraph
  $study_word);

use lib '../../bbo';
use Util;

use lib './Email';
use Email::Email;

our ($sublines, $fluffed_lines, $system_lines, $known_names, $late_mails,
  $both_last, $both_neither, %PRE_INSPECTED);


my @COUNTRY_ORDER = qw(COUNTRY);
my @CITY_ORDER = qw(CITY);
my @REGION_ORDER = qw(REGION);
my @LOCALITY_ORDER = qw(LOCALITY);
my @LEVEL_ORDER = qw(LEVEL);
my @PRIVATE_ORDER = qw(PRIVATE);
my @FLUFF_ORDER = qw(FLUFF);
my @SYSTEM_ORDER = qw(SYSTEM);

my @MULTI_ORDER = qw(
  COUNTRY
  LEVEL
  PRIVATE
  CITY
  REGION
  LOCALITY
);

my @FIRST_ORDER = qw(
  FIRSTFIRST
  FIRSTMID
  FIRSTBBO
);

my @LAST_ORDER = qw(
  LASTLAST
  LASTMID
  LASTBBO
);


sub init_pre_inspected
{
  my ($fnames) = @_;

  for my $tag (keys %$fnames)
  {
    $PRE_INSPECTED{$tag} = Manual::TargetedLines->new();
    $PRE_INSPECTED{$tag}->read_file($fnames->{$tag});
  }
}


sub look_for_single_tag
{
  # Is $text exactly a tag value, with nothing else in the string?
  my ($whole, $tag_list, $tag, $text) = @_;

  my @tags = (0);
  my @values = ($text);
  my @texts = ($text);

  # Look for multi-word tag value.
  if ($text =~ /[\s-]/)
  {
    Util::split_on_multi($whole, $tag_list, 0, \@tags, \@values, \@texts);
    return '' unless $#tags == 0;
    return $values[0] if $tags[0] eq $tag;
  }

  # Look for single-word tag.
  my $fix = $whole->get_single($tag, lc($text));
  return (defined $fix->{CATEGORY} ? $fix->{VALUE} : '');
}


sub pre_inspect
{
  # A return value of 1 means that we're done inspecting.

  die "Dead code?";
  my ($entry, $handle, $hcount, $eno, $identifier) = @_;

  if ($fluffed_lines->lookup($handle, $hcount, $eno))
  {
    $entry->{CATEGORY} = 'FLUFF';
    $entry->{VALUE} = $entry->{TEXT};
print $identifier;
    return 1;
  }

  if ($system_lines->lookup($handle, $hcount, $eno))
  {
    $entry->{CATEGORY} = 'SYSTEM';
    $entry->{VALUE} = $entry->{TEXT};
    return 1;
  }

  if (my $replace = $sublines->lookup($handle, $hcount, $eno, 
    $entry->{TEXT}))
  {
    # Still fall through and inspect further.
    $entry->{TEXT} = $replace;
  }

  if ($late_mails->lookup($handle, $hcount, $eno))
  {
    my @list;
    Email::Email::looks_like(lc($entry->{TEXT}), \@list);
    if ($#list < 0)
    {
      print $identifier;
      die "Not an email?";
    }

    $entry->{CATEGORY} = 'LIST';
    @{$entry->{LIST}} = @list;
    return 1;
  }

  if ($known_names->lookup($handle, $hcount, $eno))
  {
    $entry->{CATEGORY} = 'NAMELIKE';
    $entry->{VALUE} = $entry->{TEXT};
    return 1;
  }

  if ($both_last->lookup($entry->{TEXT}))
  {
    $entry->{CATEGORY} = 'NAME_LAST';
    return 1;
  }

  return 0;
}


sub study_word
{
  my ($whole_names, $word, $histo) = @_;

  my $token_no = 0;
  my $chain = Chain->new();
  my $first_flag = 0;
  my $last_flag = 0;

  if (singleton_tag_matches_basic($whole_names, \@FIRST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    $first_flag = 1;
  }

  if (singleton_tag_matches_basic($whole_names, \@LAST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    $last_flag = 1;
  }

  if ($first_flag && ! $last_flag)
  {
    return 'NAME_FIRST';
  }
  elsif (! $first_flag && $last_flag)
  {
    return 'NAME_LAST';
  }
  elsif ($first_flag && $last_flag)
  {
    if ($both_neither->lookup($word))
    {
      # Fall through.
      return '';
    }
    elsif ($both_last->lookup($word))
    {
      return 'NAME_LAST';
    }
    else
    {
      return 'NAME_FIRST';
    }
  }
  elsif ($word =~ /^[A-Za-z]$/)
  {
    return 'NAME_INITIAL';
  }
  else
  {
    return '';
  }
}


sub pre_parse
{
  my ($entry, $whole, $identifier, $histo) = @_;

  my @components = split /\|\|/, $entry->{TEXT};
  return 0 unless $#components == 1;

  my @list;
  for my $comp (@components)
  {
    my $found = 0;
    for my $tag (@MULTI_ORDER)
    {
      my $fix = $whole->get_single($tag, lc($comp));
      next unless defined $fix->{CATEGORY};

      push @list, $tag, $fix->{VALUE};
      $found = 1;
      last;
    }
    next if $found;

    my $cat = study_word($whole, $comp, $histo);
    if ($cat && $cat ne 'NAME_INITIAL')
    {
      push @list, $cat, $comp;
      next;
    }

    print "$entry->{TEXT}\n$comp MISS\n---\n\n";
  }

  $entry->{CATEGORY} = 'LIST';
  @{$entry->{LIST}} = @list;
  return 1;
}


sub pre_inspect_NEW
{
  my ($entry, $whole, $handle, $hcount, $eno, $order, 
    $identifier, $histo) = @_;

  if (my $replace = $sublines->lookup($handle, $hcount, $eno, 
    $entry->{TEXT}))
  {
    # Still fall through and inspect further.
    $entry->{TEXT} = $replace;
  }

  if ($entry->{TEXT} =~ /\|\|/)
  {
    return if pre_parse($entry, $whole, $identifier, $histo);
  }

  for my $tag (@$order)
  {
    if ($PRE_INSPECTED{$tag}->lookup($handle, $hcount, $eno))
    {
      if ($tag eq 'MAIL')
      {
        my @list;
        Email::Email::looks_like(lc($entry->{TEXT}), \@list);
        if ($#list < 0)
        {
          print $identifier;
          die "Not an email?";
        }

        $entry->{CATEGORY} = 'LIST';
        @{$entry->{LIST}} = @list;
      }
      else
      {
        $entry->{CATEGORY} = $tag;
        $entry->{VALUE} = $entry->{TEXT};
      }
      return 1;
    }
  }

  if ($both_last->lookup($entry->{TEXT}))
  {
    $entry->{CATEGORY} = 'NAME_LAST';
    return 1;
  }

  return 0;
}


sub guess_private
{
  my ($entry, $text, $private_seen, $mail_seen, $level_seen) = @_;

  if ($level_seen && $private_seen)
  {
    $entry->{CATEGORY} = 'FLUFF';
    $entry->{VALUE} = $entry->{TEXT};
  }
  elsif (! $level_seen &&
      ($private_seen || $mail_seen) && 
      $entry->{TEXT} =~ /^other$/i)
  {
    $entry->{CATEGORY} = 'LEVEL';
    $entry->{VALUE} = 'Other';
    $level_seen = 1;
  }
  elsif (! $level_seen &&
      ($private_seen || $mail_seen) && 
      $entry->{TEXT} =~ /^private$/i)
  {
    $entry->{CATEGORY} = 'LEVEL';
    $entry->{VALUE} = 'Private';
    $level_seen = 1;
  }
  else
  {
    $entry->{CATEGORY} = 'PRIVATE';
    $entry->{VALUE} = $text;
    $private_seen = 1;
  }
}


sub inspect_paragraph
{
  my ($whole, $paragraph, $pre_inspect_order, 
    $handle_counts, $histo) = @_;

  my $country_seen = 0;
  my $private_seen = 0;
  my $magic_seen = 0;
  my $mail_seen = 0;
  my $level_seen = 0;

  my $handle = $paragraph->{HANDLE};
  my $hcount = $handle_counts->{$handle};
  my $eno = -1;
  my $elen = $#{$paragraph->{LINES}};

  # if ($paragraph->{HANDLE} eq 'GHISA')
  # {
    # print "HERE\n";
  # }

  for my $entry (@{$paragraph->{LINES}})
  {
    $eno++;

    # Only needed for debugging.
    # my $identifier = '';
    my $identifier = "YYY $handle, $hcount, $eno\n" .
      $entry->{TEXT} . "\n" .  $entry->{TEXT} . "\n\n";

    # next if pre_inspect($entry, $handle, $hcount, $eno, $identifier);
    next if pre_inspect_NEW($entry, $whole,
      $handle, $hcount, $eno, $pre_inspect_order, $identifier, $histo);

    if (! $country_seen)
    {
      my $c = look_for_single_tag($whole, \@COUNTRY_ORDER, 'COUNTRY',
        $entry->{TEXT});
      if ($c)
      {
        $entry->{CATEGORY} = 'COUNTRY';
        $entry->{VALUE} = $c;
        $country_seen = 1;
        next;
      }

      my $l = look_for_single_tag($whole, \@LEVEL_ORDER, 'LEVEL',
        $entry->{TEXT});
      if ($l)
      {
        $entry->{CATEGORY} = 'LEVEL';
        $entry->{VALUE} = $l;
        $level_seen = 1;
        next;
      }

      my $p = look_for_single_tag($whole, \@PRIVATE_ORDER, 'PRIVATE',
        $entry->{TEXT});
      if ($p)
      {
        guess_private($entry, $p, $private_seen, $mail_seen, $level_seen);
        next;
      }

      my $f = look_for_single_tag($whole, \@FLUFF_ORDER, 'FLUFF',
        $entry->{TEXT});
      if ($f)
      {
        $entry->{CATEGORY} = 'FLUFF';
        $entry->{VALUE} = $f;
        next;
      }

      # Sometimes people give the same mail twice, or two different ones.
      my @list;
      Email::Email::looks_like(lc($entry->{TEXT}), \@list);
      if ($#list >= 0)
      {
        $entry->{CATEGORY} = 'LIST';
        @{$entry->{LIST}} = @list;
        $mail_seen = 1;
        next;
      }

      my $s = look_for_single_tag($whole, \@SYSTEM_ORDER, 'SYSTEM',
        $entry->{TEXT});
      if ($s)
      {
        $entry->{CATEGORY} = 'SYSTEM';
        $entry->{VALUE} = $entry->{TEXT};
        next;
      }
    }

    my $city = look_for_single_tag($whole, \@CITY_ORDER, 'CITY',
      $entry->{TEXT});
    if ($city)
    {
      $entry->{CATEGORY} = 'CITY';
      $entry->{VALUE} = $city;
      next;
    }

    my $region = look_for_single_tag($whole, \@REGION_ORDER, 'REGION',
      $entry->{TEXT});
    if ($region)
    {
      $entry->{CATEGORY} = 'REGION';
      $entry->{VALUE} = $region;
      next;
    }

    my $locality = look_for_single_tag($whole, \@LOCALITY_ORDER, 'LOCALITY',
      $entry->{TEXT});
    if ($locality)
    {
      $entry->{CATEGORY} = 'LOCALITY';
      $entry->{VALUE} = $locality;
      next;
    }

    if (! $magic_seen && $eno+1 >= $elen)
    {
      # Towards the end.
      if ($entry->{TEXT} =~ /^(\d+)$/ && $1 >= 100 && $1 < 200)
      {
        $entry->{CATEGORY} = 'MAGIC';
        $magic_seen = 1;
        next;
      }
    }

    if ($magic_seen && $eno == $elen &&
        $entry->{TEXT} =~ /^(\d+)$/ && $1 >= 100 && $1 < 200)
    {
      # Not clear, but doesn't matter.
      $entry->{CATEGORY} = 'FLUFF';
      $entry->{VALUE} = $entry->{TEXT};
    }

    if ($eno+1 >= $elen &&
        (($entry->{TEXT} =~ /^[0-9]n/ && $magic_seen) || 
        $entry->{TEXT} =~ /^\dy[!|]/ ||
        $entry->{TEXT} =~ /^\dy$/))
    {
      # Some kind of code.
      $entry->{CATEGORY} = 'CODE';
      next;
    }

    if (($country_seen || $mail_seen || $private_seen) && ! $magic_seen)
    {
      $entry->{CATEGORY} = 'SYSTEM';
      next;
    }
  }
}

1;
