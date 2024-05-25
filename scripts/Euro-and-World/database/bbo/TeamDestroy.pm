#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamDestroy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_destroy);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '>',
  'ÀA¬ü',
  'Bridge Team',
  'City of',
  'nat. champio',
  'No Name',
  'Premier League',
  'Pra PON'
);

my %MULTI_TYPOS =
(
  'Bridge Team' => ['bridge tem', 'bridge tea']
);

my @SINGLE_WORDS = qw(
  1st 2nd 3rd 4th 5th 6th 7th 24th
  and Any Away
  Best Bridge
  Center Challenger City Commercial Commune
  Development Dist
  Earth East ENC European Event
  Festival Field
  GD GLPD Group Groupe
  Home Host
  Indi Inter International Invit Invitational
  KB KDK KRS
  Leaders
  Match Mates Milli Mr
  National NC No NONAME North npc nr
  og Opponent Opponents Other Others
  Pacific pc PairNo Players Plus Point PON Prima Pusat
  Rank River
  Section Selected South Sponsor Squad Stars Sunday Swiss
  Table Tennis Test Times Top Tournament Tricks
  United
  Visit
  West World
  Various
);

my %SINGLE_TYPOS =
(
  Bridge => ['bric'],
  Center => ['merkezi'],
  Challengers => ['chalengers'],
  International => ['internat', 'internationa'],
  Leaders => ['leader', 'leders'],
  National => ['nasional'],
  'No Name' => ['noname'],
  North => ['nord'],
  Pacific => ['pacyfic'],
  'Pra PON' => ['prapon', 'pon'],
  South => ['syd'],
  Squad => ['squadra', 'takim'],
  Tournament => ['tounament', 'tourney']
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
