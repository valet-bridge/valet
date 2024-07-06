#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Study;

our @ISA = qw(Exporter);
our @EXPORT = qw(clean_teams study_team
  print_team_stats init_hashes);

use lib '.';
use lib '..';
use lib './Team';
use lib './Event';
use lib './Tags';

use Token;
use Util;

use Event::Cookbook;

use Separators;

use Team::Suggestors;


use Team::Matrix;
use Team::Repeats;

my @TAG_ORDER = qw(
  FUN 
  FIRST 
  SPONSOR 
  ORGANIZATION 
  COUNTRY 
  REGION 
  ZONE 
  CLUB 
  OTHER 
  QUARTER 
  CITY 
  ABBR 
  CAPTAIN
  BOT
  NATIONALITY
  UNIVERSITY 
  GENDER
  AGE
  COLOR
  SCORING
  FORM
  TWORD
  MEET
  TIME
  MONTH
  DAY
  DESTROY
);

my $PREFIX = 'TEAM_';
our $histo_team;


my (%MULTI_HITS);

# Links between different tags, e.g. club to city.
my %MATRIX;

# BBOVG numbers for which repeated, but different fields are OK.
my %REPEATS;


sub clean_team
{
  my ($whole, $team) = @_;
  $team =~ s/\(\d+\)\s*$//; # (69)
  $team =~ s/^\s+|\s+$//g; # Leading and trailing space

  # Fix some parentheses with age and gender.
  fix_some_parentheses($whole, \$team);

  # my $fix = $FIX_HASH{lc($team)};
  my $fix = $whole->get_single('COUNTRY', lc($team));
  # if (defined $fix && $fix->{CATEGORY} eq 'COUNTRY')
  if (exists $fix->{VALUE})
  {
    return $fix->{VALUE};
  }
  elsif ($team =~ /^\s*$/)
  {
    return '';
  }
  else
  {
    return $team;
  }
}


sub clean_teams
{
  my ($whole, $text, $result) = @_;

  return unless defined $text;
  if ($text =~ /(.*) vs\. (.*)/)
  {
    ($result->{TEAM1}, $result->{TEAM2}) = ($1, $2);
    $result->{TEAM1} = clean_team($whole, $result->{TEAM1});
    $result->{TEAM2} = clean_team($whole, $result->{TEAM2});

    # Kludge for event matches.
    $result->{TEAM1} =~ s/\s*- npc$//;
    $result->{TEAM2} =~ s/\s*- npc$//;
  }
  elsif ($text =~ /^\s*$/ || $text =~ /^\s*vs\.\s*$/)
  {
    $result->{TEAM1} = '';
    $result->{TEAM2} = '';
    return;
  }
  else
  {
    die "Can't parse team line $text\n";
  }
}



my %HIT_STATS;
my %FORM_SCORES;


sub init_hashes
{
  set_matrix();
  set_repeats(\%REPEATS);
}


sub set_link_matrix
{
  # 'to' might be TEAM_COUNTRY, 'from' might be TEAM_REGION.
  my ($link, $to, $from) = @_;

  my $mlink = \%{$MATRIX{$from}{$to}};
  for my $key (keys %$link)
  {
    for my $entry (@{$link->{$key}})
    {
      $mlink->{lc($entry)} = $key;
    }
  }
}


sub make_field_record
{
  my ($text, $chain, $bbono, $record, $dupl_flag) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    if (! exists $record->{$field})
    {
      $record->{$field} = $val;
    }
    elsif ($dupl_flag && 
        $field ne 'DESTROY' && 
        $record->{$field} ne $val)
    {
      print "$bbono, $text, $field: $record->{$field} vs $val\n";
    }
  }
}


sub make_complete_field_record
{
  my ($text, $chain, $bbono, $record) = @_;

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    my $field = $token->field();
    my $val = $token->value();

    push @{$record->{$field}}, $val;
  }
}


sub check_consistency_pair
{
  my ($text, $bbono, $record, $from, $to) = @_;

  return unless exists $record->{$from};
  return unless exists $record->{$to};

  my $c = $MATRIX{$from}{$to}{lc($record->{$from})};
  if (! defined $c)
  {
    print "$bbono, $text, $to: ",
      "$record->{$from} not in matrix ($from, $to)\n";
  }
  elsif ($c eq $record->{$to})
  {
    return;
  }
  elsif ($from eq 'CLUB' && $to eq 'CITY' && $c =~ /-Pan$/)
  {
    # Special case.
    return;
  }
  else
  {
    print "$bbono, $text, $to: ",
      "$record->{$to} vs $c\n";
  }
}


sub check_consistency
{
  my ($text, $chain, $bbono) = @_;

  return if exists $REPEATS{$bbono};

  my %record;
  make_field_record($text, $chain, $bbono, \%record, 1);

  check_consistency_pair($text, $bbono, \%record,
    'REGION', 'COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'CITY', 'COUNTRY');
  check_consistency_pair($text, $bbono, \%record,
    'QUARTER', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'UNIVERSITY', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'CLUB', 'CITY');
  check_consistency_pair($text, $bbono, \%record,
    'SPONSOR', 'COUNTRY');
}


sub fix_some_parentheses
{
  my ($whole, $team_ref) = @_;

  return unless $$team_ref =~ /\((.*)\)/;
  my $t = $1;

  my $fix = $whole->get_single('AGE', lc($t));
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  $fix = $whole->get_single('GENDER', lc($t));
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  if ($t eq 'O')
  {
    $$team_ref = 'Open';
  }
  elsif ($t eq 'W')
  {
    $$team_ref = 'Women';
  }
  elsif ($t eq 'S')
  {
    $$team_ref = 'Seniors';
  }
  elsif ($t eq 'L')
  {
    $$team_ref = 'Ladies';
  }
  elsif ($t eq 'J')
  {
    $$team_ref = 'Juniors';
  }
}


sub eliminate_districts
{
  my ($team_ref) = @_;

  if ($$team_ref =~ s/district \d+//i)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
  }
  elsif ($$team_ref =~ s/\(D\d+\)//)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
  }
  elsif ($$team_ref =~ s/\bD\d+\b//)
  {
    return ($$team_ref =~ /^\s*$/ ? 1 : 0);
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


sub study_part
{
  my ($whole, $part, $i, $chain, $unknown_part_flag) = @_;

  my $token = Token->new();

  $HIT_STATS{TOTAL}++;

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
    $token->set_origin($i, $part);
    $chain->append($token);
    if ($part >= 1900 && $part < 2100)
    {
      $token->set_singleton('YEAR', $part);
      $HIT_STATS{TEAM_YEAR}++;
    }
    else
    {
      $token->set_numeral_counter($part);
      $HIT_STATS{TEAM_INTEGER}++;
    }
    return;
  }
  elsif ($part =~ /^[A-D]$/)
  {
    $token->set_origin($i, $part);
    $chain->append($token);
    $token->set_letter_counter($part);
    $HIT_STATS{TEAM_LETTER}++;
    return;
  }

  # The general solution.

  return if singleton_tag_matches($whole, \@TAG_ORDER, 
    $i, $part, 0, $chain, $main::histo_team, 'TEAM_');

  $token->set_origin($i, $part);
  $chain->append($token);

  # Some use of other hashes.
  my $fix_event = $FIX_HASH{lc($part)};

  if (defined $fix_event->{CATEGORY})
  {
    my $category = $fix_event->{CATEGORY};
    if ($category eq 'NUMERAL' || $category eq 'ROMAN')
    {
      $token->set_singleton($category, $fix_event->{VALUE});
      $HIT_STATS{'TEAM_' . $category}++;
      return;
    }
  }

  $token->set_unknown($part);
  $HIT_STATS{UNMATCHED}++;
  print $part, "\n";
  $$unknown_part_flag = 1;
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


sub fix_heuristics
{
  my ($text, $chain, $bbono) = @_;

  my %record;
  make_complete_field_record($text, $chain, $bbono, \%record);

  # Destroy Bridge Club if there is also Sporting Club.
  if (exists $record{ABBR} && $#{$record{ABBR}} == 1)
  {
    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      if ($token->field() eq 'ABBR' &&
          $token->value() eq 'Bridge Club')
      {
        $token->set_singleton('DESTROY', 'Bridge Club');
      }
    }
  }

  # Turn Orange White into Netherlands White.
  if (exists $record{COLOR} && $#{$record{COLOR}} == 1)
  {
    my $token = $chain->check_out(0);
    if (lc($token->value()) eq 'orange')
    {
      $token->set_singleton('COUNTRY', 'Netherlands');
    }
  }

  # Destroy two numerals.
  if (exists $record{NUMERAL} && $#{$record{NUMERAL}} == 1)
  {
    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      if ($token->field() eq 'NUMERAL')
      {
        $token->set_singleton('DESTROY', $token->value());
      }
    }
  }
}


sub study_team
{
  my ($whole, $text, $chain, $bbono) = @_;

  return if $text eq '';
  if (my $s = suggest_form($text, \%FORM_SCORES))
  {
    append_token($chain, 'SINGLETON', 'FORM', $s, $text, 0,
      $main::histo_team, $PREFIX);
    return;
  }

  return if eliminate_districts(\$text);

  my @tags = (0);
  my @values = ($text);
  my @texts = ();
  split_on_multi($whole, \@TAG_ORDER, 0, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/[\s+\-\+\._;&"\/\(\)\|]/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a multi-word hit.
      my $token = Token->new();
      $token->set_origin($i, $values[$i]);
      $token->set_singleton($tags[$i], $values[$i]);
      $chain->append($token);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $part (@a)
      {
        study_component($whole, $part, $chain, \$token_no, \$unsolved_flag);
      }
    }
  }

  print "UUU $bbono: $text\n" if ($unsolved_flag && $chain->last() > 0);
  print "\n" if $unsolved_flag;

  fix_heuristics($text, $chain, $bbono);
}


sub print_team_stats
{
  for my $key (sort keys %HIT_STATS)
  {
    printf("%-20s %6d\n", $key, $HIT_STATS{$key});
  }

  print "\n";

  for my $key (sort keys %FORM_SCORES)
  {
    printf("%-20s %6d\n", $key, $FORM_SCORES{$key});
  }
}


1;
