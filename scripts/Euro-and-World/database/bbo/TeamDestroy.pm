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
  GD GLPD
  KB KDK KRS
  Leaders
  Mr
  npc
  Opponent Opponents Others
  pc
  Tricks
  Various
);

my %SINGLE_TYPOS =
(
  Challengers => ['chalengers'],
  Leaders => ['leader', 'leders']
);


sub set_hashes_team_destroy
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
