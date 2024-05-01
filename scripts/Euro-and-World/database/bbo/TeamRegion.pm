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
  'Boeven Digoel',
  'Bone Bolango',
  'Central Celebes',
  'Central Gauteng',
  'Central Java',
  'Central Sulawesi',
  'East Borneo',
  'East Jakarta',
  'East Java',
  'Kepulauan Riau',
  'New Caledonia',
  'New South Wales',
  'North Celebes',
  'North Sulawesi',
  'Northern Gauteng',
  'South Australia',
  'South Celebes',
  'South East Celebes',
  'South Jakarta',
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
  'Central Java' => ['jawa tengah'],
  'Central Sulawesi' => ['sulawesi tengah'],
  'East Jakarta' => ['jakarta timur'],
  'East Java' => ['jawa timur'],
  'North Sulawesi' => ['notth sulawesi', 'north sulawsei',
    'sulawesi utara', 'sulawasi utara'],
  'North Sumatra' => ['sumatera utara'],
  'Vest Agder' => ['vest-agder'],
  'West Sumatra' => ['west sumatera'],
  'South Africa' => ['south frica'],
  'Vest Agder' => ['vest-agder'],
  'South Jakarta' => ['jakarta selatan'],
  'South Sulawesi' => ['sulawesi selatan', 'sulsel'],
  'South Sumatra' => ['south sumatera', 'sumatera selatan'],
  'Vest Finnmark' => ['vest-finnmark'],
  'West Sumatra' => ['sumatera barat', 'west sumatera'],
  'Western Australia' => ['wa'],
  'West Bengal' => ['west bengla', 'westbengal'],
  'West Java' => ['jawa barat'],
);

my @SINGLE_WORDS = qw(
  Anhui
  Bali Bornholm Buskerud
  Florida
  Hebei
  Karimun Kepri Kedungwaru
  Lumajang
  Queensland
  Ratchaburi Rogaland
  Victoria
  Zhejiang
);

my %SINGLE_TYPOS =
(
  'Australian Central Territory' => ['act'],
  'Kepulauan Riau' => ['riau', 'kepri'],
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
