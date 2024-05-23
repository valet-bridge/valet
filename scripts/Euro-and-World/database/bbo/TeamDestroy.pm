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
  'nat. champio',
  'No Name',
  'Pra PON'
);

my %MULTI_TYPOS =
(
  'Bridge Team' => ['bridge tem', 'bridge tea']
);

my @SINGLE_WORDS = qw(
  and Any Away
  Best Bridge
  Center Challenger City Commercial Commune
  Development Dist
  Earth European Festival
  GD GLPD Group Groupe
  Home Host
  Indi Inter International Invitational
  KB KDK KRS
  Leaders
  Mates Mr
  National NC No NONAME npc nr
  og Opponent Opponents Other Others
  Pacific pc PairNo Players Plus Point PON Prima Pusat
  Rank River
  Section Selected Sponsor Squad Stars Sunday
  Table Tennis Test Times Tournament Tricks
  United
  Visit
  World
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
