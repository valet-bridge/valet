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
  'ÀA¬ü',
  'Bridge Team',
  'nat. champio',
  'No Name',
  'Pra PON'
);

my %MULTI_TYPOS =
(
  'Bridge Team' => ['bridge tem', 'bridge tea']
);

my @SINGLE_WORDS = qw(
  Any
  Bridge
  Center Challenger City Commune
  Development
  European Festival
  GD GLPD Groupe
  Host
  Inter International Invitational
  KB KDK KRS
  Leaders
  Mates Mr
  National NONAME npc
  og Opponent Opponents Others
  Pacific pc Players Plus Point PON Prima Pusat
  Section Selected Sponsor Squad Stars
  Table Tennis Test Tournament Tricks
  United
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
  Pacific => ['pacyfic'],
  'Pra PON' => ['prapon', 'pon'],
  Squad => ['squadra'],
  Tournament => ['tounament']
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
