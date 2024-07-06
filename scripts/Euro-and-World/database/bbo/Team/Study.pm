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
  ROMAN
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
  NUMERAL
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

  $$team_ref =~ s/district \d+//i;
  $$team_ref =~ s/\(D\d+\)//;
  $$team_ref =~ s/\bD\d+\b//;
  return ($$team_ref =~ /^\s*$/ ? 1 : 0);
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


sub study_value
{
  my ($whole, $value, $pos, $chain, $unsolved_flag) = @_;

  return if singleton_non_tag_matches($value, $$pos, $chain,
    $main::histo_team, $PREFIX);

  return if singleton_tag_matches($whole, \@TAG_ORDER, 
    $$pos, $value, 0, $chain, $main::histo_team, $PREFIX);

  my $token = Token->new();
  $token->set_origin($$pos, $value);
  $chain->append($token);
  $$pos++;

  return if Separators::set_token($value, $token);

  print "UUU value $value\n";
  $$unsolved_flag = 1;

  $token->set_unknown($value);
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
      $main::histo_team, $PREFIX);
    $$token_no++;
  }
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
      append_token($chain, 'SINGLETON', $tags[$i], $values[$i],
        $texts[$i], $token_no, $main::histo_title, $PREFIX);
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $part (@a)
      {
        study_component($whole, $part, $chain, \$token_no, 
          \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    print "UUU $bbono: $text\n" if $chain->last() > 0;
    print "\n";
  }

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
