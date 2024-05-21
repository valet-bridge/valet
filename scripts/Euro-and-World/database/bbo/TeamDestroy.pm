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
  'Bridge Team',
  'No Name'
);

my %MULTI_TYPOS =
(
  'Bridge Team' => ['bridge tem', 'bridge tea']
);

my @SINGLE_WORDS = qw(
  Bridge
  Challenger
  European
  GD GLPD
  International
  KB KDK KRS
  Leaders
  Mr
  National NONAME npc
  og Opponent Opponents Others
  Pacific pc Players
  Selected Squad Stars
  Table Tennis Tournament Tricks
  United
  Various
);

my %SINGLE_TYPOS =
(
  Bridge => ['bric'],
  Challengers => ['chalengers'],
  International => ['internat', 'internationa'],
  Leaders => ['leader', 'leders'],
  National => ['nasional'],
  'No Name' => ['noname'],
  Pacific => ['pacyfic'],
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
