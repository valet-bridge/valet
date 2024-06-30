#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::DestroyTeam;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_destroy);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '>',
  'City of',
  'nat. champio',
  'Premier League',
  'Pra PON',
  'Undecipherable Team',
);

my %MULTI_TYPOS =
(
  'Undecipherable Team' => ['fx', 'm', 't'],
);

my @SINGLE_WORDS = qw(
  1st 2nd 3rd 4th 5th 6th 7th 24th
  1z 2a 5a 6a 7a 8a 9a u2 
  a Alumni April
  European Event
  Festival Field
  Group Groupe
  Indi Inter International Invit Invitational
  June
  Match
  National
  Olympiad
  Pacific PON Prima Pusat
  Section Selection Squad 
  Sunday Swiss
  Table Trials Tricks
);

my %SINGLE_TYPOS =
(
  Group => ['istis'],
  International => ['internat', 'internationa'],
  National => ['nasional'],
  Pacific => ['pacyfic'],
  'Pra PON' => ['prapon', 'pon'],
  Squad => ['squadra', 'takim', 'tim'],
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
