#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamRegion;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_region);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Central Java',
  'East Java',
  'Vest Agder',
  'West Borneo',
  'West Java',
  'West Sumatra',
  'Western Australia'
);

my %MULTI_TYPOS =
(
  'Vest Agder' => ['vest-agder'],
  'West Sumatra' => ['west sumatera'],
  'Western Australia' => ['wa']
);

my @SINGLE_WORDS = qw(
  Bali Bornholm
  Florida
  Kepri
  Kedungwaru
  Lumajang
  Ratchaburi
  Victoria
);

my %SINGLE_TYPOS =
(
);


sub set_hashes_team_region
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
