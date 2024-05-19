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
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  bric
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
  Selected Stars
  Table Tennis Tricks
  United
  Various
);

my %SINGLE_TYPOS =
(
  Challengers => ['chalengers'],
  International => ['internat', 'internationa'],
  Leaders => ['leader', 'leders'],
  National => ['nasional'],
  Pacific => ['pacyfic']
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
