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
  'Bekasi Regency',
  'Bisma Semarang',
  'Boeven Digoel',
  'Bogor Regency',
  'Bone Bolango',
  'Central Districts',
  'Central Celebes',
  'Central Gauteng',
  'Central Java',
  'Central Sulawesi',
  'Cianjur Regency',
  'East Borneo',
  'East Jakarta',
  'East Java',
  'East Kalimantan',
  'Eastern Cape',
  'Garut Regency',
  'Kepulauan Riau',
  'Lower Silesia',
  'Madhya Pradesh',
  'Midt Trøndelag',
  'Møre Romsdal',
  'Nakhon Nayok',
  'New Caledonia',
  'New South Wales',
  'Nord-Norge Omegn',
  'Norte Ilhas',
  'North America',
  'North Minahasa',
  'North Celebes',
  'North Sulawesi',
  'Northern Gauteng',
  'Nusa Tenggara Barat',
  'Pearl River',
  'Samut Prakan',
  'South America',
  'South Australia',
  'South Celebes',
  'South East Celebes',
  'South Jakarta',
  'South Kalimantan',
  'South Minahasa',
  'South Sulawesi',
  'South Sumatra',
  'South Sweden',
  'Suphan Buri',
  'Taihu Lake',
  'Tamil Nadu',
  'Troms og Ofoten',
  'Uttar Pradesh',
  'Val di Magra',
  'Vest Agder',
  'Vest Finnmark',
  'West Bengal',
  'West Borneo',
  'West District',
  'West Java',
  'West Kalimantan',
  'West Sumatra',
  'Western Australia',
  'Western Province',
  'Østfold Follo'
);

my %MULTI_TYPOS =
(
  'Bekasi Regency' => ['kab.bekasi', 'kab. bekasi'],
  'Central Java' => ['jawa tengah', 'jateng'],
  'Bogor Regency' => ['kab bogor', 'kab.bogor pa'],
  'Central Sulawesi' => ['sulawesi tengah'],
  'Cianjur Regency' => ['kab. cianjur', 'kab.cianjur'],
  'East Jakarta' => ['jakarta timur'],
  'East Java' => ['jawa timur', 'jatim'],
  'East Kalimantan' => ['kalimantan timur'],
  'Garut Regency' => ['kab. garut'],
  Guangdong => ['guang dong'],
  Hubei => ['hu bei'],
  Jiangsu => ['jiang su'],
  'Lower Silesia' => ['dolny slask'],
  Marmara => ['g.marm'],
  'North Sulawesi' => ['notth sulawesi', 'north sulawsei',
    'sulawesi utara', 'sulawasi utara', 'sulut'],
  'North Minahasa' => ['minahasa utara'],
  'North Sumatra' => ['sumatera utara'],
  Sichuan => ['si chuan'],
  'South Africa' => ['south frica'],
  'South Jakarta' => ['jakarta selatan'],
  'South Kalimantan' => ['kalimantan selatan', 'kalsel'],
  'South Minahasa' => ['minahasa selatan', 'minsel'],
  'South Sulawesi' => ['sulawesi selatan', 'sulsel'],
  'South Sumatra' => ['south sumatera', 'sumatera selatan', 'sumsel'],
  'Taihu Lake' => ['suzhou taihu'],
  'Vest Agder' => ['vest-agder'],
  'Val di Magra' => ['val magra'],
  'Vest Finnmark' => ['vest-finnmark'],
  'West Kalimantan' => ['kalimantan barat'],
  'West Sumatra' => ['west sumatera', 'sumatera barat', 'west sumatera'],
  'Western Australia' => ['wa'],
  'West Bengal' => ['west bengla', 'westbengal'],
  'West Java' => ['jawa barat', 'jabar'],
);

my @SINGLE_WORDS = qw(
  Angkaew Anhui Ayrshire
  Bali Banten Belitung Bihar Bornholm Bungo Buskerud
  Cappadocia Corsica
  Druts
  Eurasia Europe
  Florida
  Ganges Gansu Global Gorontalo Guangdong Guangxi Guizhou Gujarat
  Hainan Haugaland Hebei Huangshi Hubei Hunan
  Jharkhand Jiangsu Jilin
  Kansai Karimun Karnataka Kawanua Kedungwaru Kepri Kerala Krabi
  Lebak Liaoning Liguria Lombok Lumajang
  Maharashtra Marmara Masal Matopos Mercosur Midtsjælland Mjøsa 
  Muallim Munzur Mysia
  Nordafjells Norden Norrland
  Queensland
  Oberloiben Orontes Otago
  Patagonia Porong Punjab
  Rajputana Ratchaburi Rogaland Rosfjord 
  Salten Shanxi Siberia Sichuan Silesia Silla Skåne Southland Sydvest
  Tasmania Telemark Tigris
  Uttarakhand
  Victoria
  Waikato
  Yunnan
  Zhejiang
);

my %SINGLE_TYPOS =
(
  'Australian Central Territory' => ['act'],
  Cappadocia => ['kapadokya'],
  Eurasia => ['avrasya'],
  Kansai => ['kinki'],
  'Kepulauan Riau' => ['riau', 'kepri'],
  'Midt Trøndelag' => ['midttrøndelag'],
  'Møre Romsdal' => ['moreromsdal'],
  'Nakhon Nayok' => ['nakhonnayok'],
  'New South Wales' => ['nsw'],
  Patagonia => ['patagonya'],
  Queensland => ['qld'],
  'Samut Prakan' => ['samutprakan'],
  'South Australia' => ['sa'],
  'Suphan Buri' => ['suphanburi'],
  'Tamil Nadu' => ['tamilnadu'],
  Uttarakhand => ['uttaranchal'],
  'Victoria' => ['vic'],
  'Østfold Follo' => ['ostfoldfollo']
);


sub set_hashes_team_region
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
