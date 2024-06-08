#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Zone;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_zone set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'North America',
  'South America'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  ASEAN
  Balkan
  Eurasia
  Europe
  Global
  Mercosur
  Norden
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_zone
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
