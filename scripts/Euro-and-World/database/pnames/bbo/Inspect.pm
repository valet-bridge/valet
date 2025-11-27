#!perl

package Inspect;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($sublines $both_first $both_last 
  inspect_paragraph lines_to_list list_to_units 
  list_to_units_no_punctuation study_word study_name);

use lib '../../bbo';
use Util;

use Butil;

use lib './Email';
use Email::Email;

our ($sublines, $both_first, $both_last);
my %PRE_INSPECTED;

my $debug_study_name = 1;
my $debug_pre_parse = 0;

my @MULTI_ORDER = qw(
  COUNTRY
  LEVEL
  PRIVATE
  CITY
  REGION
  LOCALITY
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

my %DYNASTS = (
  'jr' => 'Jr.',
  'sr' => 'Sr.',
  'ii' => 'II',
  'iii' => 'III',
  'iv' => 'IV'
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


sub kludge_given_names
{
  my ($datum, $parts) = @_;

  # Skip _ in order not to destroy NAME_LAST etc.
  my $sep = qr/(\d+|[\s\-\+\.\?,:;=&@#*%\$^~"\/\\()<>|\[\]\{\}])/;

  my @a = split /::/, $datum;

  my $straggler = '';
  if ($a[0] =~ /^[A-Z]+_[A-Z]+$/)
  {
    $straggler = $a[0];
    shift @a;
  }

  for my $elem (@a)
  {
    my @sub_parts = grep { $_ ne '' } split /$sep/, $elem;

    my $start = 0;
    if ($straggler)
    {
      push @$parts, $straggler . '::' . $sub_parts[0];
      $straggler = '';
      $start = 1;
    }

    if ($start < $#sub_parts)
    {
      push @$parts, @sub_parts[$start .. $#sub_parts-1];
      $straggler = $sub_parts[-1];
    }
  }

  if ($straggler)
  {
    push @$parts, $straggler;
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
  my ($whole, $list, $units, $histo, $chain_stats) = @_;

  my @markup;

  for my $datum (@$list)
  {
    $chain_stats->{DATA}++;

    if ($datum =~ /#fake@/)
    {
      $units->push('FLUFF', $datum, $datum, 0, $chain_stats);
      return;
    }

    my @parts;
    my $kludge_flag = 0;
    if ($datum =~ /::/)
    {
      kludge_given_names($datum, \@parts);
      $kludge_flag = 1;
    }
    else
    {
      my $sep = qr/(\d+|[\s\-\+\.\?_,:;=&@#*%\$^~"\/\\()<>|\[\]\{\}])/;
      @parts = grep { $_ ne '' } split /$sep/, $datum;
    }


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
      elsif ($kludge_flag && $part =~ /::/)
      {
        my @a = split /::/, $part;
        die "Kludge syntax: $part" unless $#a == 1;
        $used_pos++;
        $markup[$used_pos]{CATEGORY} = $a[0];
        $markup[$used_pos]{TEXT} = $a[1];
        $markup[$used_pos]{UPPER}= ($part eq uc($part) ? 1 : 0);
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

  if (singleton_tag_matches_basic($whole_names, ['NAMEPARTICLE'],
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_PARTICLE';
  }

  if (singleton_tag_matches_basic($whole_names, ['NAMEFIRST'],
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_FIRST';
  }
  elsif (singleton_tag_matches_basic($whole_names, ['NAMELAST'],
    \$token_no, $word, 0, $chain, $histo, ''))
  {
    return 'NAME_LAST';
  }
  elsif (singleton_tag_matches_basic($whole_names, ['NAMEBOTH'],
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
    # TODO These probably don't get scanned further.
    # But if I set them to UNKNOWN, they do?
    return 'UNKNOWN';
    # return '';
  }
}


sub normalize_first
{
  my ($str) = @_;
  $str =~ s/^(\p{L})(.*)$/\u$1\L$2/;
  return $str;
}


sub normalize_first_hyphenated
{
  my ($val) = @_;

  my @a = split '-', $val;
  if ($#a != 1)
  {
    die "Funny hyphenated first name: $val";
  }
  my $n1 = normalize_first($a[0]);
  my $n2 = normalize_first($a[1]);
  return "$n1-$n2";
}


sub normalize_last
{
  my ($str) = @_;
  $str = uc($str);
  $str =~ s/^MC/Mc/;
  return $str;
}


sub push_onto_list
{
  my ($list, $cat, $val) = @_;

  if ($cat eq 'NAME_FIRST')
  {
    if ($val =~ /\-/ && $val !~ / /)
    {
      push @$list, $cat, normalize_first_hyphenated($val);
    }
    else
    {
      push @$list, $cat, normalize_first($val);
    }
  }
  elsif ($cat eq 'NAME_NICK')
  {
    push @$list, $cat, normalize_first($val);
  }
  elsif ($cat eq 'NAME_INITIAL')
  {
    push @$list, $cat, normalize_last($val);
  }
  elsif ($cat eq 'NAME_PARTICLE' ||
      $cat eq 'NAME_LAST')
  {
    push @$list, $cat, normalize_last($val);
  }
  elsif ($cat eq 'NAME_DYNAST')
  {
    push @$list, $cat, $val;
  }
  else
  {
    # TODO What is this?
    push @$list, $cat, $val;
  }
}


sub study_name_two
{
  my ($word1, $cat1, $word2, $cat2, $list, $histo) = @_;

  # Simple screen for names.

  if ($cat1 eq 'NAME_FIRST' && $cat2 eq 'NAME_FIRST')
  {
    push_onto_list($list, $cat1, $word1);
    push_onto_list($list, $cat2, $word2);
    return 1;
  }
  elsif ($cat1 eq 'NAME_FIRST' && $cat2 eq 'NAME_LAST')
  {
    push_onto_list($list, $cat1, $word1);
    push_onto_list($list, $cat2, $word2);
    return 1;
  }
  elsif ($cat1 eq 'NAME_FIRST' && $cat2 eq 'NAME_INITIAL')
  {
    push_onto_list($list, $cat1, $word1);
    push_onto_list($list, $cat2, $word2 . '.');
    return 1;
  }
  elsif ($cat1 eq 'NAME_INITIAL' && $cat2 eq 'NAME_LAST')
  {
    push_onto_list($list, $cat1, $word1 . '.');
    push_onto_list($list, $cat2, $word2);
    return 1;
  }
  elsif ($cat1 eq 'NAME_PARTICLE' && $cat2 eq 'NAME_LAST')
  {
    push_onto_list($list, $cat1, $word1);
    push_onto_list($list, $cat2, $word2);
    return 1;
  }
  elsif ($cat1 eq 'NAME_INITIAL' && $cat2 eq 'NAME_INITIAL')
  {
    push_onto_list($list, $cat1, $word1 . '.');
    push_onto_list($list, $cat2, $word2 . '.');
    return 1;
  }

  return 0;
}


sub study_name_three
{
  my ($word1, $cat1, $word2, $cat2, $word3, $cat3, $list, $histo) = @_;

  if ($cat1 eq 'NAME_FIRST' && 
     ($cat2 eq 'NAME_PARTICLE' || $cat2 eq 'NAME_INITIAL' ||
      $cat2 eq 'NAME_LAST') &&
      $cat3 eq 'NAME_LAST')
  {
    my $u2 = uc($word2);
    $u2 .= '.' if $cat2 eq 'NAME_INITIAL';
    my $u3 = uc($word3);
    push @$list, 
      $cat1, normalize_first($word1), 
      $cat2, $u2, 
      $cat3, $u3;
    return 1;
  }
  elsif ($cat1 eq 'NAME_FIRST' && 
      $cat2 eq 'NAME_FIRST' &&
      $cat3 eq 'NAME_LAST')
  {
    push @$list, 
      $cat1, normalize_first($word1), 
      $cat2, normalize_first($word2), 
      $cat3, normalize_last($word3);
    return 1;
  }

  return 0;
}


sub rename_two
{
  my ($units, $first1_names, $last3_names) = @_;

  my $cat0 = $units->category(0);
  my $val0 = $units->value(0);
  my $cat1 = $units->category(1);
  my $val1 = $units->value(1);
  my $upper0 = ($val0 eq uc($val0) ? 1 : 0);
  my $upper1 = ($val1 eq uc($val1) ? 1 : 0);

  if (($cat0 eq '' || $cat0 eq 'UNKNOWN') && $first1_names->lookup($val0))
  {
    $cat0 = 'NAME_FIRST';
    $units->reset_unit(0, 'NAME_FIRST', $first1_names->fix($val0));
  }

  if (($cat1 eq '' || $cat1 eq 'UNKNOWN') && $last3_names->lookup($val1))
  {
    $cat1 = 'NAME_LAST';
    $units->reset_unit(1, 'NAME_LAST', $last3_names->fix($val1));
  }

  if ($cat0 eq 'NAME_BOTH' && $cat1 eq 'NAME_LAST')
  {
    $cat0 = 'NAME_FIRST';
    $units->reset_unit(0, 'NAME_FIRST', normalize_first($val0));
  }
  elsif ($cat0 eq 'NAME_BOTH' && ! $upper0 && $cat1 eq 'NAME_INITIAL')
  {
    $cat0 = 'NAME_FIRST';
    $units->reset_unit(0, 'NAME_FIRST', normalize_first($val0));
  }
  elsif ($cat0 eq 'NAME_FIRST' && $cat1 eq 'NAME_BOTH')
  {
    $cat1 = 'NAME_LAST';
    $units->reset_unit(1, 'NAME_LAST', normalize_last($val1));
  }
  elsif ($cat0 eq 'NAME_INITIAL' && $upper1 && $cat1 eq 'NAME_BOTH')
  {
    $cat1 = 'NAME_LAST';
    $units->reset_unit(1, 'NAME_LAST', normalize_last($val1));
  }
  elsif ($cat0 eq 'NAME_BOTH' && $cat1 eq 'NAME_FIRST' &&
      ! $upper0 && ! $upper1)
  {
    $cat0 = 'NAME_FIRST';
    $cat1 = 'NAME_FIRST';
    $units->reset_unit(0, 'NAME_FIRST', normalize_first($val0));
    $units->reset_unit(1, 'NAME_FIRST', normalize_first($val1));
  }
}


sub mixed_consistent_cases_strict
{
  my ($units) = @_;

  my $upper_seen = 0;
  my $lower_seen = 0;

  for my $i (0 .. $units->last())
  {
    my $cat = $units->category($i);
    my $val = $units->value($i);
    my $upper = ($val eq uc($val) ? 1 : 0);
    if ($upper)
    {
      $upper_seen = 1;
    }
    else
    {
      $lower_seen = 1;
    }

    return 0 if $cat eq 'NAME_BOTH';
    return 0 if ($cat eq 'NAME_FIRST' && $upper);
    return 0 if ($cat eq 'NAME_PARTICLE' && ! $upper);
    return 0 if ($cat eq 'NAME_LAST' && ! $upper);
  }

  return ($lower_seen && $upper_seen);
}


sub plausible_only_upper
{
  my ($units) = @_;

  for my $i (0 .. $units->last())
  {
    my $cat = $units->category($i);
    return 0 unless ($cat eq 'NAME_INITIAL' ||
      $cat eq 'NAME_PARTICLE' || $cat eq 'NAME_LAST');

    my $val = $units->value($i);
    return 0 unless $val eq uc($val);
  }

  return 1;
}


sub mixed_with_fixable_both
{
  my ($units, $list) = @_;

  my $upper_seen = 0;
  my $lower_seen = 0;

  my @cases;
  for my $i (0 .. $units->last())
  {

    my $cat = $units->category($i);
    my $val = $units->value($i);
    next if $cat eq 'NAME_DYNAST';

    my $upper = ($val eq uc($val) ? 1 : 0);
    if ($upper)
    {
      if ($cat ne 'NAME_INITIAL')
      {
        $upper_seen = 1;
      }
    }
    else
    {
      # Lower, then upper, not the other way round.
      return 0 if $upper_seen;
      $lower_seen = 1;
    }

    return 0 if ($cat eq 'NAME_FIRST' && $upper);
    return 0 if ($cat eq 'NAME_PARTICLE' && ! $upper);
    return 0 if ($cat eq 'NAME_INITIAL' && ! $upper);
    return 0 if ($cat eq 'NAME_LAST' && ! $upper);
    return 0 unless (
      $cat eq 'NAME_FIRST' || $cat eq 'NAME_PARTICLE' ||
      $cat eq 'NAME_INITIAL' || $cat eq 'NAME_LAST' || 
      $cat eq 'NAME_BOTH');

    $cases[$i] = $upper;
  }

  return 0 unless ($lower_seen && $upper_seen);

  for my $i (0 .. $units->last())
  {
    my $cat = $units->category($i);
    my $val = $units->value($i);

    if ($cat ne 'NAME_BOTH')
    {
      push_onto_list($list, $cat, $val);
    }
    elsif ($cases[$i])
    {
      push_onto_list($list, 'NAME_LAST', $val);
    }
    else
    {
      push_onto_list($list, 'NAME_FIRST', $val);
    }
  }

  return 1;
}


sub look_for_dynast
{
  my ($units) = @_;

  my $l = $units->last();
  return unless ($l > 0);
  return unless ($units->category(0) =~ /^NAME_/);
  return unless ($units->category($l) eq 'UNKNOWN');
  my $val = lc($units->value($l));
  return unless (exists $DYNASTS{$val});

  $units->reset_unit($l, 'NAME_DYNAST', $DYNASTS{$val});
}


sub print_list
{
  my ($list, $identifier) = @_;

  my $n = $#$list;
  return unless $n >= 0;

  my (@cats, @values);

  for (my $i = 0; $i <= $n; $i += 2)
  {
    my $cat = $list->[$i];
    $cat = "''" unless $cat;

    my $val = $list->[$i+1];
    $val = "''" unless $val;

    push @cats, $cat;
    push @values, $val;
  }

  my $cstr = join ' - ', @cats;
  my $vstr = join ' - ', @values;

# if ($#cats >= 0)
{
  print $cstr, "\n";
  for my $v (@values) { print $v, "\n"; } print "\n"; 

  # print $vstr, "\n";

  print $identifier;
  # print "-----\n\n";
}
# print "-------------\n\n";
}


sub study_name
{
  my ($units, $whole_names, 
    $first1_names, $last3_names,
    $known_name_flag, $list, $identifier, $histo) = @_;

  if ($units->last() == 0)
  {
    my $cat = $units->category(0);
    my $val = $units->value(0);

    if ($cat eq 'NAME_FIRST')
    {
      push @$list, $cat, normalize_first($val);
      return 1;
    }
    elsif ($cat eq 'NAME_INITIAL' || $cat eq 'NAME_LAST')
    {
      push @$list, $cat, normalize_last($val);
      return 1;
    }
    elsif (($cat eq '' || $cat eq 'UNKNOWN') && 
        $last3_names->lookup($val))
    {
      $units->reset_unit(0, 'NAME_LAST', $val);
      push @$list, 'NAME_LAST', $last3_names->fix($val);
      return 1;
    }
    elsif (($cat eq '' || $cat eq 'UNKNOWN') && 
        $first1_names->lookup($val))
    {
      $units->reset_unit(0, 'NAME_FIRST', $val);
      push @$list, 'NAME_FIRST', $first1_names->fix($val);
      return 1;
    }
    elsif ($cat eq 'NAME_BOTH')
    {
      # This only works due to heavy curation.
      $units->reset_unit(0, 'NAME_FIRST', $val);
      push @$list, 'NAME_FIRST', normalize_first($val);
      return 1;
    }
  }

  if ($units->last() == 1)
  {
    # Various heuristics.
    rename_two($units, $first1_names, $last3_names);

    if (study_name_two($units->value(0), $units->category(0), 
      $units->value(1), $units->category(1), $list, $histo))
    {
      return 1;
    }
  }

  if ($known_name_flag)
  {
    # Only do this when we know we won't have collisions with
    # non-names.
    for my $i (0 .. $units->last())
    {
      my $cat = $units->category($i);
      my $val = $units->value($i);

      if ($cat eq 'NAME_FIRST')
      {
        $units->reset_unit($i, 'NAME_FIRST', normalize_first($val));
        next;
      }
      elsif ($cat eq 'NAME_LAST')
      {
        $units->reset_unit($i, 'NAME_LAST', normalize_last($val));
        next;
      }

      next unless ($cat eq '' || $cat eq 'UNKNOWN');

      if ($first1_names->lookup($val))
      {
        $units->reset_unit($i, 'NAME_FIRST', $first1_names->fix($val));
      }
      elsif ($last3_names->lookup($val))
      {
        $units->reset_unit($i, 'NAME_LAST', $last3_names->fix($val));
      }
    }

    look_for_dynast($units);
  }

  if ($units->last() == 2)
  {
    if (study_name_three(
      $units->value(0), $units->category(0), 
      $units->value(1), $units->category(1), 
      $units->value(2), $units->category(2), 
      $list, $histo))
    {
      return 1;
    }
  }


  if (mixed_consistent_cases_strict($units) ||
      plausible_only_upper($units))
  {
    for my $i (0 .. $units->last())
    {
      push @$list, $units->category($i), $units->value($i);
    }
    return 1;
  }

  if (mixed_with_fixable_both($units, $list))
  {
    # Look for mixed cases that are consistent with their categories,
    # AND strictly from lower to upper.  Then BOTH is fixed according
    # to its case.
    return 1;
  }

  for my $i (0 .. $units->last())
  {
    push @$list, $units->category($i), $units->value($i);
  }

  return 0;
}


sub study_text_as_name
{
  my ($whole_names, $text, $first1_names, $last3_names,
    $list, $identifier, $histo, $chain_stats) = @_;

  my @battery;
  $battery[0] = Units->new();

  list_to_units_no_punctuation($whole_names, [$text],
    $battery[0], $histo, $chain_stats);

  my @clist;

  if (study_name($battery[0], $whole_names, 
      $first1_names, $last3_names,
      1, \@clist, $identifier, $histo))
  {
    push @$list, @clist;
    return 1;
  }
  else
  {
    push @$list, @clist;
    return 0;
  }
}


sub pre_parse
{
  my ($entry, $whole_names, $whole_system, $first1_names, $last3_names, 
    $handle, $hcount, $eno, $identifier, $histo, $chain_stats) = @_;

  # TODO: Must not be a known_names
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
    if ($cat && $cat ne 'NAME_INITIAL' && $cat ne 'UNKNOWN')
    {
      push_onto_list(\@list, $cat, $comp);
      # push @list, $cat, $comp;
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
    if (study_text_as_name($whole_names, $comp, 
      $first1_names, $last3_names, \@clist,
      $identifier, $histo, $chain_stats))
    {
      push @list, @clist;
      next;
    }
    elsif ($PRE_INSPECTED{FINAL}->lookup($handle, $hcount, $eno) &&
        list_looks_final(\@clist))
    {
      push @list, @clist;
      next;
    }
    elsif ($debug_study_name)
    {
      print_list(\@clist, $identifier);
    }
  }

  $entry->{CATEGORY} = 'LIST';
  @{$entry->{LIST}} = @list;
  return 1;
}


sub list_looks_final
{
  my $list = shift;
  my $n = $#$list;
  return 0 if $n < 0;

  for (my $i = 0; $i <= $n; $i += 2)
  {
    my $elem = $list->[$i];
    if ($elem ne 'NAME_FIRST' &&
        $elem ne 'NAME_INITIAL' &&
        $elem ne 'NAME_NICK' &&
        $elem ne 'NAME_PARTICLE' &&
        $elem ne 'NAME_LAST' &&
        $elem ne 'NAME_DYNAST')
    {
      return 0;
    }
  }
  return 1;
}


sub pre_inspect
{
  my ($entry, $whole_names, $whole_system, 
    $first1_names, $last3_names,
    $handle, $hcount, $eno, $order, $identifier, 
    $histo, $chain_stats) = @_;

  if (my $replace = $sublines->lookup($handle, $hcount, $eno, 
    $entry->{TEXT}))
  {
    # Still fall through and inspect further.
    $entry->{TEXT} = $replace;
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
      elsif ($tag eq 'NAMELIKE')
      {
        my $identifier = "YYY $handle, $hcount, $eno\n" .
          $entry->{TEXT} . "\n" .  $entry->{TEXT} . "\n\n";

if ($entry->{TEXT} =~ /\|\|/)
{
  print "FENCE\n";
  print $identifier;
}

        my @list;
        if (study_text_as_name($whole_names, $entry->{TEXT}, 
          $first1_names, $last3_names,
          \@list, $identifier, $histo, $chain_stats))
        {
          $entry->{CATEGORY} = 'LIST';
          @{$entry->{LIST}} = @list;
          return 1;
        }
        elsif ($PRE_INSPECTED{FINAL}->lookup($handle, $hcount, $eno))
        {
          if (list_looks_final(\@list))
          {
            $entry->{CATEGORY} = 'LIST';
            @{$entry->{LIST}} = @list;
            return 1;
          }
          else
          {
            warn "Should be FINAL?";
            warn $identifier;
            print_list(\@list, $identifier);

            $entry->{CATEGORY} = $tag;
            $entry->{VALUE} = $entry->{TEXT};
          }
        }
        else
        {
          # TODO
          $entry->{CATEGORY} = $tag;
          $entry->{VALUE} = $entry->{TEXT};

          if ($debug_study_name)
          {
            $identifier = "YYY $handle, $hcount, $eno\n" .
              $entry->{TEXT} . "\n" .  $entry->{TEXT} . "\n\n";
            print_list(\@list, $identifier);
          }
        }
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
    $entry->{VALUE} = normalize_last($entry->{TEXT});
    return 1;
  }

  if ($entry->{TEXT} =~ /\|\|/)
  {
    return 1 if pre_parse($entry, $whole_names, $whole_system, 
      $first1_names, $last3_names, 
      $handle, $hcount, $eno,
      $identifier, $histo, $chain_stats);
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


sub inspect_for_tag
{
  my ($whole_names, $tag, $entry) = @_;

  my $result = look_for_single_tag($whole_names, 
      [$tag], $tag, $entry->{TEXT});

  return 0 unless $result;

  $entry->{CATEGORY} = $tag;
  $entry->{VALUE} = $result;
  return 1;
}


sub inspect_paragraph
{
  my ($whole_names, $whole_system, 
    $first1_names, $last3_names,
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
    my $identifier = "YYY $handle, $hcount, $eno\n" .
      $entry->{TEXT} . "\n" .  $entry->{TEXT} . "\n\n";

    next if pre_inspect($entry, $whole_names, $whole_system, 
      $first1_names, $last3_names,
      $handle, $hcount, $eno, $pre_inspect_order, $identifier, 
      $histo, $chain_stats);

    if (! $country_seen)
    {
      if (inspect_for_tag($whole_names, 'COUNTRY', $entry))
      {
        $country_seen = 1;
        next;
      }

      if (inspect_for_tag($whole_names, 'LEVEL', $entry))
      {
        $level_seen = 1;
        next;
      }

      my $p = look_for_single_tag($whole_names, 
        ['PRIVATE'], 'PRIVATE', $entry->{TEXT});
      if ($p)
      {
        guess_private($entry, $p, $private_seen, $mail_seen, $level_seen);
        next;
      }

      next if inspect_for_tag($whole_names, 'FLUFF', $entry);

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

      next if inspect_for_tag($whole_names, 'SYSTEM', $entry);
    }

    next if inspect_for_tag($whole_names, 'CITY', $entry);
    next if inspect_for_tag($whole_names, 'REGION', $entry);
    next if inspect_for_tag($whole_names, 'LOCALITY', $entry);

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

    if ($entry->{TEXT} !~ / /)
    {
      my $cat = study_word($whole_names, $entry->{TEXT}, $histo);
      next unless $cat;

      my $val = $entry->{TEXT};
      if ($cat eq 'NAME_BOTH' && $both_first->lookup($val))
      {
        $entry->{CATEGORY} = 'NAME_FIRST';
        $entry->{VALUE} = $both_first->fix($val);
      }
      elsif ($cat eq 'NAME_FIRST')
      {
        if ($val =~ /\-/ && $val !~ / /)
        {
          $entry->{CATEGORY} = $cat;
          $entry->{VALUE} = normalize_first_hyphenated($val);
        }
        else
        {
          $entry->{CATEGORY} = $cat;
          $entry->{VALUE} = normalize_first($val);
        }
      }
      elsif ($cat eq 'NAME_LAST')
      {
        $entry->{CATEGORY} = $cat;
        $entry->{VALUE} = normalize_last($val);
      }
      else
      {
        $entry->{CATEGORY} = $cat;
      }
    }
  }
}

1;
