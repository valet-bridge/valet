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
  'Australian Central Territory',
  'Central Celebes',
  'Central Java',
  'East Java',
  'New Caledonia',
  'New South Wales',
  'North Sulawesi',
  'Northern Gauteng',
  'South Australia',
  'South Celebes',
  'South East Celebes',
  'South Sulawesi',
  'South Sumatra',
  'South Sweden',
  'Vest Agder',
  'Vest Finnmark',
  'West Bengal',
  'West Borneo',
  'West Java',
  'West Sumatra',
  'Western Australia',
  'Western Province'
);

my %MULTI_TYPOS =
(
  'North Sulawesi' => ['notth sulawesi', 'north sulawsei'],
  'Vest Agder' => ['vest-agder'],
  'West Sumatra' => ['west sumatera'],
  'South Africa' => ['south frica'],
  'Vest Agder' => ['vest-agder'],
  'South Sumatra' => ['south sumatera'],
  'Vest Finnmark' => ['vest-finnmark'],
  'Western Australia' => ['wa'],
  'West Bengal' => ['west bengla', 'westbengal']
);

my @SINGLE_WORDS = qw(
  Bali Bornholm
  Florida
  Kepri
  Kedungwaru
  Lumajang
  Queensland
  Ratchaburi
  Victoria
);

my %SINGLE_TYPOS =
(
  'Australian Central Territory' => ['act'],
  'New South Wales' => ['nsw'],
  Queensland => ['qld'],
  'Victoria' => ['vic']
);


sub set_hashes_team_region
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
