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
  lines_to_list list_to_units list_to_units_no_punctuation
  study_word study_name study_name_two);

use lib '../../bbo';
use Util;

use Butil;

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
  NAMEFIRST
);

my @PARTICLE_ORDER = qw(
  NAMEPARTICLE
);

my @LAST_ORDER = qw(
  NAMELAST
);

my @NAME_BOTH = qw(
  NAMEBOTH
);

my @SYSTEM_TAGS = qw(
  DENOMINATIONS
  LENGTHS
  RANKS
  SHAPES
  STRENGTHS

  BASES
  OPENINGS
  CONSTRUCTIVE
  COMPETITIVE
  BLACKWOOD
  BERGEN
  MISC
  KEYCARD
  STAYMAN
  CARDING
);

my %PUNCTUATION =
(
  '-' => 'DASH',
  '+' => 'PLUS',
  '.' => 'POINT',
  '?' => 'QUESTION',
  '_' => 'UNDERSCORE',
  ',' => 'COMMA',
  ':' => 'COLON',
  ';' => 'SEMICOLON',
  '=' => 'EQUAL',
  '&' => 'AMPERSAND',
  '@' => 'AT_SIGN',
  '#' => 'HASH',
  '*' => 'ASTERISK',
  '%' => 'PERCENT',
  '$' => 'DOLLAR',
  '^' => 'CARET',
  '~' => 'TILDE',
  '"' => 'DOUBLEQUOTE',
  '/' => 'SLASH',
  '\\' => 'BACKSLASH',
  '(' => 'PAREN_LEFT',
  ')' => 'PAREN_RIGHT',
  '<' => 'LESS_THAN',
  '>' => 'GREATER_THAN',
  '|' => 'PIPE',
  '[' => 'SQUARE_LEFT',
  ']' => 'SQUARE_RIGHT',
  '{' => 'CURLY_LEFT',
  '}' => 'CURLY_RIGHT',
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


sub lines_to_list
{
  my ($entry, $list) = @_;

  if ($entry->{CATEGORY} eq 'LIST')
  {
    my $len = $#{$entry->{LIST}};
    for (my $i = 0; $i <= $len; $i += 2)
    {
      if ($entry->{LIST}[$i] eq 'OPEN' ||
          $entry->{LIST}[$i] eq 'SYSTEM')
      {
        push @$list, $entry->{LIST}[$i+1];
      }
    }
  }
  elsif ($entry->{CATEGORY} eq 'OPEN' || $entry->{CATEGORY} eq 'SYSTEM')
  {
    my $datum = $entry->{VALUE} // $entry->{TEXT};
    push @$list, $datum;
  }
}


sub list_to_units
{
  my ($whole, $unit_tags, $list, $units, $text, $histo, $chain_stats) = @_;

  for my $datum (@$list)
  {
    $chain_stats->{DATA}++;

    if ($datum =~ /#fake@/)
    {
      $units->push('FLUFF', $datum, $datum, 0, $chain_stats);
      return;
    }

    my $sep = qr/(\d+|[\s\-\+\.\?_,:;=&@#*%\$^~"\/\\()<>|\[\]\{\}])/;
    my @parts = grep { $_ ne '' } split /$sep/, $datum;

    my $pos = -1;
    my @splits;
    for my $part (@parts)
    {
      $pos++;
      $chain_stats->{PARTS}++;

      if (exists $PUNCTUATION{$part})
      {
        $units->push('PUNCTUATION', $part, $PUNCTUATION{$part},
          $pos, $chain_stats);
        next;
      }
      elsif ($part eq ' ')
      {
        $units->push('PUNCTUATION', $part, 'SPACE', $pos, $chain_stats);
        next;
      }
      elsif ($part =~ /^\d+$/)
      {
        $units->push_integer($part, $pos, $chain_stats);
        next;
      }
      else
      {
        my ($category, $value);
        categorize($whole, $unit_tags, $part, \$category, \$value);

        $units->push($category, $part, $value, $pos, $chain_stats);
      }
    }
  }
}


sub merge_component_run
{
  my ($markup, $tag) = @_;

  # Look for a first initial.
  my $found = 0;
  my $p0;
  for my $pos (0 .. $#$markup)
  {
    if ($markup->[$pos]{CATEGORY} eq $tag)
    {
      $found = 1;
      $p0 = $pos;
      last;
    }
  }
  return unless $found;

  my $merge = '';
  my $p1;
  for my $pos ($p0 .. $#$markup)
  {
    last unless $markup->[$pos]{CATEGORY} eq $tag;

    $p1 = $pos;
    $merge .= ' ' if $p1 > $p0;
    $merge .= uc($markup->[$pos]{TEXT});
    $merge .= '.' if $tag eq 'NAME_INITIAL';
  }

  $markup->[$p0]{TEXT} = $merge;
  splice @$markup, $p0+1, $p1-$p0 if $p1 > $p0;
}


sub use_name_capitalization
{
  my $markup = shift;

  my $initial_seen = 0;
  my $lower_seen = 0;
  my $upper_seen = 0;

  for my $m (@$markup)
  {
    my $cat = $m->{CATEGORY};
    return unless $cat =~ /^NAME_/;

    if ($cat eq 'NAME_INITIAL')
    {
      # If there are multiple initials at this point, it is because
      # they are not next to each other (see merge_initials), and we
      # don't want to deal with that here.
      return if $initial_seen;
      $initial_seen = 1;
      next;
    }

    my $upper = $m->{UPPER};
    if ($upper)
    {
      # Might be an override.
      $upper_seen = 1;
    }
    elsif ($upper_seen)
    {
      # We are going back from upper to lower, which we don't want
      # to entertain.
      return;
    }
    else
    {
      # Might be an override.
      $lower_seen = 1;
    }
  }

  return unless ($upper_seen && $lower_seen);

  # We only consider capitalization when there is (a) either initials
  # or a lower-case name, as well as (b) an upper-case name, and
  # (c) we go linearly from lower-case to upper-case.
  # In that case we consider (a) to be first names and (b) to be
  # last names, no matter what the category says.

  for my $m (@$markup)
  {
    if (($m->{CATEGORY} eq 'NAME_FIRST' ||
        $m->{CATEGORY} eq 'NAME_BOTH') && 
        $m->{UPPER})
    {
      $m->{CATEGORY} = 'NAME_LAST';
    }
    elsif (($m->{CATEGORY} eq 'NAME_LAST' ||
        $m->{CATEGORY} eq 'NAME_BOTH') && 
        ! $m->{UPPER})
    {
      $m->{CATEGORY} = 'NAME_FIRST';
    }
  }
}


sub list_to_units_no_punctuation
{
  my ($whole, $list, $units, $text, $histo, $chain_stats) = @_;

  my @markup;

  for my $datum (@$list)
  {
    $chain_stats->{DATA}++;

    if ($datum =~ /#fake@/)
    {
      $units->push('FLUFF', $datum, $datum, 0, $chain_stats);
      return;
    }

    my $sep = qr/(\d+|[\s\-\+\.\?_,:;=&@#*%\$^~"\/\\()<>|\[\]\{\}])/;
    my @parts = grep { $_ ne '' } split /$sep/, $datum;

    my $pos = -1;
    my $used_pos = -1;
    my @splits;
    for my $part (@parts)
    {
      $pos++;
      $chain_stats->{PARTS}++;

      next if exists $PUNCTUATION{$part};

      next if $part eq ' ';

      if ($part =~ /^\d+$/)
      {
        $units->push_integer($part, $pos, $chain_stats);
        next;
      }
      else
      {
        $used_pos++;
        my $category = study_word($whole, $part, $histo);
        $markup[$used_pos]{CATEGORY} = $category;
        $markup[$used_pos]{TEXT} = $part;
        $markup[$used_pos]{UPPER}= ($part eq uc($part) ? 1 : 0);
      }
    }
  }

  # Combine initials and particles into one.
  merge_component_run(\@markup, 'NAME_INITIAL');
  merge_component_run(\@markup, 'NAME_PARTICLE');

  # Sometimes use an upper-case last name as a hint.
  use_name_capitalization(\@markup);

  for my $pos (0 .. $#markup)
  {
    my $e = $markup[$pos];
    $units->push($e->{CATEGORY}, $e->{TEXT}, $e->{TEXT}, $pos,
      $chain_stats);
  }
}


sub study_word
{
  my ($whole_names, $word, $histo) = @_;

  my $token_no = 0;
  my $chain = Chain->new();

  if (singleton_tag_matches_basic($whole_names, \@PARTICLE_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_PARTICLE';
  }

  if (singleton_tag_matches_basic($whole_names, \@FIRST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_FIRST';
  }
  elsif (singleton_tag_matches_basic($whole_names, \@LAST_ORDER,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_LAST';
  }
  elsif (singleton_tag_matches_basic($whole_names, \@NAME_BOTH,
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_BOTH';
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


sub study_name_two
{
  my ($word1, $cat1, $word2, $cat2, $list, $histo) = @_;

  # Simple screen for names.

  if ($cat1 eq 'NAME_FIRST' && 
      ($cat2 eq 'NAME_FIRST' || $cat2 eq 'NAME_LAST'))
  {
    push @$list, $cat1, $word1, $cat2, $word2;
    return 1;
  }
  elsif ($cat1 eq 'NAME_FIRST' && $cat2 eq 'NAME_INITIAL')
  {
    my $u2 = uc($word2) . '.';
    push @$list, $cat1, $word1, $cat2, $u2;
    return 1;
  }
  elsif ($cat1 eq 'NAME_INITIAL' && $cat2 eq 'NAME_FIRST')
  {
    if ($word2 eq 'CASPER' || $word2 eq 'BALA' || $word2 eq 'MURAT')
    {
      # Rather a kludge to make these few entries go away.
      my $u1 = uc($word1) . '.';
      push @$list, $cat1, $u1, 'NAME_LAST', $word2;
      return 1;
    }
  }
  elsif ($cat1 eq 'NAME_INITIAL' && $cat2 eq 'NAME_LAST')
  {
    my $u1 = uc($word1) . '.';
    push @$list, $cat1, $u1, $cat2, $word2;
    return 1;
  }
  elsif ($cat1 eq 'NAME_PARTICLE' && $cat2 eq 'NAME_LAST')
  {
    push @$list, $cat1, $word1, $cat2, $word2;
    return 1;
  }
  elsif ($cat1 eq 'NAME_INITIAL' && $cat2 eq 'NAME_INITIAL')
  {
    my $u1 = uc($word1) . '.';
    my $u2 = uc($word2) . '.';
    push @$list, $cat1, $u1, $cat2, $u2;
    return 1;
  }

  return 0;
}


sub study_name_three
{
  my ($units, $list, $histo) = @_;

  # Simple screen for names.

  my $cat1 = $units->category(0);
  my $cat2 = $units->category(1);
  my $cat3 = $units->category(2);

  if ($cat1 eq 'NAME_FIRST' && 
      ($cat2 eq 'NAME_FIRST' || $cat2 eq 'NAME_INITIAL' ||
       $cat2 eq 'NAME_PARTICLE' || $cat2 eq 'NAME_LAST') &&
      $cat3 eq 'NAME_LAST')
  {
    push @$list, $cat1, $units->value(0), 
        $cat2, $units->value(1),
        $cat3, $units->value(2);
    return 1;
  }

  return 0;
}


sub study_name
{
  my ($units, $whole_names, $last3_names, $list, 
    $identifier, $histo) = @_;

  # This is a feeble start of a more general method.

  if ($units->last() == 0)
  {
    my $cat = $units->category(0);
    if ($cat eq 'NAME_INITIAL')
    {
      return 1;
    }
  }

  if ($units->last() == 1)
  {
    # TODO Move to rename_two
    my $cat0 = $units->category(0);
    my $val0 = $units->value(0);
    my $cat1 = $units->category(1);
    my $val1 = $units->value(1);
    my $upper0 = ($val0 eq uc($val0) ? 1 : 0);
    my $upper1 = ($val1 eq uc($val1) ? 1 : 0);

    if ($cat1 eq '' && $last3_names->lookup($val1))
    {
      $cat1 = 'NAME_LAST';
      $units->reset_unit(1, $cat1, $val1);
    }

    if ($cat0 eq 'NAME_BOTH' && $cat1 eq 'NAME_LAST')
    {
      $cat0 = 'NAME_FIRST';
      $units->reset_unit(0, $cat0, $val0);
    }
    elsif ($cat0 eq 'NAME_BOTH' && ! $upper0 && $cat1 eq 'NAME_INITIAL')
    {
      $cat0 = 'NAME_FIRST';
      $units->reset_unit(0, $cat0, $val0);
    }
    elsif ($cat0 eq 'NAME_FIRST' && $cat1 eq 'NAME_BOTH')
    {
      $cat1 = 'NAME_LAST';
      $units->reset_unit(1, $cat1, $val1);
    }
    elsif ($cat0 eq 'NAME_INITIAL' && $upper1 && $cat1 eq 'NAME_BOTH')
    {
      $cat1 = 'NAME_LAST';
      $units->reset_unit(1, $cat1, $val1);
    }

    if (study_name_two($val0, $cat0, $val1, $cat1, $list, $histo))
    {
      return 1;
    }
  }

  if ($units->last() == 2)
  {
    if (study_name_three($units, $list, $histo))
    {
      return 1;
    }
  }

  # Another big kludge.
  if ($units->last() == 3 &&
      $units->value(0) eq 'Delia' &&
      $units->value(1) eq 'Cane' &&
      $units->value(2) eq 'de' &&
      $units->value(3) eq 'Biquard')
  {
    push @$list, 
      'NAME_FIRST', 'Delia',
      'NAME_FIRST', 'Cane',
      'NAME_PARTICLE', 'DE',
      'NAME_LAST', 'BIQUARD';
    return 1;
  }

  if ($units->last() == 2 &&
      $units->value(0) eq 'Jan' &&
      $units->value(1) eq 'Erik' &&
      $units->value(2) eq 'AAS')
  {
    push @$list, 
      'NAME_FIRST', 'Jan',
      'NAME_FIRST', 'Erik',
      'NAME_LAST', 'AAS';
    return 1;
  }

  # return 0;

  # If we wanted to debug.
  my (@cats, @values);
  for my $i (0 .. $units->last())
  {
    my $cat = $units->category($i);
    $cat = "''" unless $cat;

    my $val = $units->value($i);
    $val = "''" unless $val;

    push @cats, $cat;
    push @values, $val;
  }

  print $identifier;
  my $cstr = join ' - ', @cats;
  my $vstr = join ' - ', @values;
  print $cstr, "\n";
  print $vstr, "\n";
  print "-------------\n\n";

  return 0;
}


sub pre_parse
{
  my ($entry, $whole_names, $whole_system, $last3_names, 
    $identifier, $histo, $chain_stats) = @_;

  my @components = split /\|\|/, $entry->{TEXT};
  return 0 unless $#components == 1;

  my @list;
  for my $comp (@components)
  {
    my $found = 0;
    for my $tag (@MULTI_ORDER)
    {
      my $fix = $whole_names->get_single($tag, lc($comp));
      next unless defined $fix->{CATEGORY};

      push @list, $tag, $fix->{VALUE};
      $found = 1;
      last;
    }
    next if $found;

    my $cat = study_word($whole_names, $comp, $histo);
    if ($cat && $cat ne 'NAME_INITIAL')
    {
      push @list, $cat, $comp;
      next;
    }

    if ($comp =~ /^\d+$/ && $comp >= 1920 && $comp <= 2005)
    {
      push @list, 'YEAR_BIRTH', $comp;
      next;
    }

    if ($comp =~ /@/ && $comp !~ /\s/)
    {
      my @elist;
      Email::Email::looks_like(lc($comp), \@elist);
      if ($#elist >= 0)
      {
        push @list, @elist;
        next;
      }
    }

    my @clist;
    $clist[0] = $comp;

    my @battery;
    $battery[0] = Units->new();
    list_to_units_no_punctuation($whole_names,
      \@clist, $battery[0], $comp, $histo, $chain_stats);
    if (study_name($battery[0], $whole_names, $last3_names, 
      \@clist, $identifier, $histo))
    {
      push @list, @clist;
      next;
    }

    # This would be another place to debug.
    # print "$entry->{TEXT}\n$comp MISS\n---\n\n";
  }

  $entry->{CATEGORY} = 'LIST';
  @{$entry->{LIST}} = @list;
  return 1;
}


sub pre_inspect
{
  my ($entry, $whole_names, $whole_system, $last3_names, 
    $handle, $hcount, $eno, $order, $identifier, $histo, $chain_stats) = @_;

  if (my $replace = $sublines->lookup($handle, $hcount, $eno, 
    $entry->{TEXT}))
  {
    # Still fall through and inspect further.
    $entry->{TEXT} = $replace;
  }

  if ($entry->{TEXT} =~ /\|\|/)
  {
    return if pre_parse($entry, $whole_names, $whole_system, $last3_names,
      $identifier, $histo, $chain_stats);
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
  my ($whole_names, $whole_system, $last3_names, 
    $paragraph, $pre_inspect_order, $handle_counts, 
    $histo, $chain_stats) = @_;

  my $country_seen = 0;
  my $private_seen = 0;
  my $magic_seen = 0;
  my $mail_seen = 0;
  my $level_seen = 0;

  my $handle = $paragraph->{HANDLE};
  my $hcount = $handle_counts->{$handle};
  my $eno = -1;
  my $elen = $#{$paragraph->{LINES}};

  # if ($paragraph->{HANDLE} eq 'NJANERI')
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

    next if pre_inspect($entry, $whole_names, $whole_system, $last3_names,
      $handle, $hcount, $eno, $pre_inspect_order, $identifier, 
      $histo, $chain_stats);

    if (! $country_seen)
    {
      my $c = look_for_single_tag($whole_names, 
        \@COUNTRY_ORDER, 'COUNTRY', $entry->{TEXT});
      if ($c)
      {
        $entry->{CATEGORY} = 'COUNTRY';
        $entry->{VALUE} = $c;
        $country_seen = 1;
        next;
      }

      my $l = look_for_single_tag($whole_names, 
        \@LEVEL_ORDER, 'LEVEL', $entry->{TEXT});
      if ($l)
      {
        $entry->{CATEGORY} = 'LEVEL';
        $entry->{VALUE} = $l;
        $level_seen = 1;
        next;
      }

      my $p = look_for_single_tag($whole_names, 
        \@PRIVATE_ORDER, 'PRIVATE', $entry->{TEXT});
      if ($p)
      {
        guess_private($entry, $p, $private_seen, $mail_seen, $level_seen);
        next;
      }

      my $f = look_for_single_tag($whole_names, 
        \@FLUFF_ORDER, 'FLUFF', $entry->{TEXT});
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

      my $s = look_for_single_tag($whole_names, 
        \@SYSTEM_ORDER, 'SYSTEM', $entry->{TEXT});
      if ($s)
      {
        $entry->{CATEGORY} = 'SYSTEM';
        $entry->{VALUE} = $entry->{TEXT};
        next;
      }
    }

    my $city = look_for_single_tag($whole_names, 
      \@CITY_ORDER, 'CITY', $entry->{TEXT});
    if ($city)
    {
      $entry->{CATEGORY} = 'CITY';
      $entry->{VALUE} = $city;
      next;
    }

    my $region = look_for_single_tag($whole_names, 
      \@REGION_ORDER, 'REGION', $entry->{TEXT});
    if ($region)
    {
      $entry->{CATEGORY} = 'REGION';
      $entry->{VALUE} = $region;
      next;
    }

    my $locality = look_for_single_tag($whole_names, 
      \@LOCALITY_ORDER, 'LOCALITY',
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
