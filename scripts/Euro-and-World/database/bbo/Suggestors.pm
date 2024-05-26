#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Suggestors;

our @ISA = qw(Exporter);
our @EXPORT = qw(suggest_form);

use lib '.';

# Only if it is a complete team entry.
my @TEAMS_SUGGESTORS = (
  'team 1', 'team 2', 'team1', 'team2', 'team one', 'team two',
  'team a', 'team b', 'teama1',
  'home', 'away', 'visiting', 'away team',
  'table 1', 'table 2',
  'table8hom', 'table8vis',
  'table9hom', 'table9vis',
  't1-home', 't1-visit', 't2-home', 't2-visit',
  't11-home', 't11-visit', 't12-home', 't12-visit',
  'ev sahibi takým'
);

my %TEAMS_SUGGESTORS_HASH = map {$_ => 1} @TEAMS_SUGGESTORS;

# Only if it is a complete team entry.
my @PAIRS_SUGGESTORS = (
  'cross-imps', 'cross/imps', 'no imps',
  'pairs', 'pair 1', 'pair 2', 'pair1', 'pair2', 'pair event',
  'pair a', 'pair b', 'no teams', 'not teams',
  'pair ns', 'pair ew', 'pairs a', 'pairs b',
  'pairs 1', 'pairs 2', 'pair tournament', 'pairs tournament',
  'pairs event',
  'a_pair1', 'a_pair2', 'b_pair1', 'b_pair2',
  'c_pair1', 'c_pair2', 'd_pair1', 'd_pair2',
  'e_pair1', 'e_pair2',
  'f_pair1', 'f_pair2', 'g_pair1', 'g_pair2',
  'h_pair1', 'h_pair2'
);

my %PAIRS_SUGGESTORS_HASH = map {$_ => 1} @PAIRS_SUGGESTORS;

# Only if it is a complete team entry.
my @INDIVIDUAL_SUGGESTORS = (
  'individual'
);

my %INDIVIDUAL_SUGGESTORS_HASH = map {$_ => 1} @INDIVIDUAL_SUGGESTORS;

# Only if it is a complete team entry.
my @NEUTRAL_SUGGESTORS = (
  'tournament', 'event',
  'a', 'b', 'x', 'y',
  'ns', 'ew', 'n-s', 'e-w', 'eo', 'north - south', 'east - west',
  'none', 'none 1', 'none 2', 1, 2
);

my %NEUTRAL_SUGGESTORS_HASH = map {$_ => 1} @NEUTRAL_SUGGESTORS;



sub suggest_form
{
  my ($text, $form_scores) = @_;

  if (exists $TEAMS_SUGGESTORS_HASH{lc($text)})
  {
    # Make this per BBO file.
    $form_scores->{teams}++;
    return 1;
  }
  elsif (exists $PAIRS_SUGGESTORS_HASH{lc($text)})
  {
    $form_scores->{pairs}++;
    return 1;
  }
  elsif (exists $INDIVIDUAL_SUGGESTORS_HASH{lc($text)})
  {
    $form_scores->{individual}++;
    return 1;
  }
  elsif (exists $NEUTRAL_SUGGESTORS_HASH{lc($text)})
  {
    $form_scores->{neutral}++;
    return 1;
  }
  else
  {
    return 0;
  }
}

1;
