#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Region;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Aegean Sea',
  'Australian Central Territory',
  'Bekasi Regency',
  'Bisma Semarang',
  'Boeven Digoel',
  'Bogor Regency',
  'Bone Bolango',
  'Central Anatolia',
  'Central Districts',
  'Central Celebes',
  'Central Gauteng',
  'Central Java',
  'Central Sulawesi',
  'Cianjur Regency',
  'Datca Yarimada',
  'District of Columbia',
  'Dogu Akdeniz',
  'East Borneo',
  'East Jakarta',
  'East Java',
  'East Kalimantan',
  'Eastern Cape',
  'Gabungan Malaku',
  'Garut Regency',
  'Java Bali',
  'Kepulauan Riau',
  'Kutai Kartanegara',
  'KwaZulu Natal',
  'Lower Silesia',
  'Madhya Pradesh',
  'Midt Trøndelag',
  'Møre Romsdal',
  'Nakhon Nayok',
  'New Caledonia',
  'New South Wales',
  'Nord-Norge Omegn',
  'Norte Ilhas',
  'North Minahasa',
  'North Celebes',
  'North Sulawesi',
  'Northern Gauteng',
  'Northern Territory',
  'Nusa Tenggara Barat',
  'Pearl River',
  'Ren Shou',
  'Rio de Janeiro State',
  'Samut Prakan',
  'Samut Sakhon',
  'South Australia',
  'South Celebes',
  'South East Celebes',
  'South Jakarta',
  'South Kalimantan',
  'South Sulawesi',
  'South Sumatra',
  'South Sweden',
  'Suphan Buri',
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
  'West Nusa Tenggara',
  'West Sumatra',
  'Western Australia',
  'Western Province',
  'Østfold Follo'
);

my %MULTI_TYPOS =
(
  Aceh => ['di aceh'],
  'Bekasi Regency' => ['kab.bekasi', 'kab. bekasi'],
  'Central Java' => ['jawa tengah', 'jateng'],
  'Bogor Regency' => ['kab bogor', 'kab.bogor pa'],
  'Central Anatolia' => ['ic anadolu'],
  'Central Sulawesi' => ['sulawesi tengah'],
  'Cianjur Regency' => ['kab. cianjur', 'kab.cianjur'],
  'Dogu Akdeniz' => ['dogu akdeniz region', 'akdeniz region'],
  'East Jakarta' => ['jakarta timur'],
  'East Java' => ['jawa timur', 'jatim'],
  'East Kalimantan' => ['kalimantan timur'],
  'Garut Regency' => ['kab. garut'],
  Guangdong => ['guangdong province', 'guang dong'],
  Hubei => ['hu bei'],
  Jiangsu => ['jiang su'],
  'Kutai Kartanegara' => ['kutai kartanega'],
  'Lower Silesia' => ['dolny slask'],
  Maharashtra => ['maharashtra e', 'maharashtra f',
    'maharashtra state'],
  Marmara => ['g.marm'],
  'North Sulawesi' => ['notth sulawesi', 'north sulawsei',
    'sulawesi utara', 'sulawasi utara'],
  'North Minahasa' => ['minahasa utara'],
  'North Sumatra' => ['sumatera utara'],
  'Pearl River' => ['pearl riv', 'pearl r'],
  Sichuan => ['si chuan'],
  'South Jakarta' => ['jakarta selatan'],
  'South Kalimantan' => ['kalimantan selatan', 'kalsel'],
  'South Sulawesi' => ['sulawesi selatan', 'sulsel'],
  'South Sumatra' => ['south sumatera', 'sumatera selatan', 'sumsel'],
  'Uttar Pradesh' => ['u.p.', 'up state'],
  'Vest Agder' => ['vest-agder'],
  'Val di Magra' => ['val magra'],
  'Vest Finnmark' => ['vest-finnmark'],
  'West Kalimantan' => ['kalimantan barat'],
  'West Nusa Tenggara' => ['lombok tengah'],
  'West Sumatra' => ['west sumatera', 'sumatera barat', 'west sumatera'],
  'Western Australia' => ['wa'],
  'West Bengal' => ['west bengla', 'westbengal'],
  'West Java' => ['jawa barat', 'jabar'],
);

my @SINGLE_WORDS = qw(
  Aceh Agder Akdeniz Akkad Anhui Ayrshire
  Bali Banten Belitung Bengkayang Bihar Bornholm Bungo Buskerud
  Cappadocia Catalonia Corsica
  Dersým Druts
  Eyjafjallajokull
  Fjends Florida Fukien
  Ganges Gansu Gauteng Goa Gorontalo Guangdong Guangxi 
  Guizhou Gujarat
  Hainan Haixing Hatay Haugaland Hebei Hedmark Hegyvidék Hordaland
  Hubei Hunan
  Jalisco Jharkhand Jiangsu Jilin
  Kansai Kanto Karnataka Kawanua Kayong Kedungwaru Kepri Kerala 
  Kinali Krabi
  Lampung Lebak Liaoning Liguria Lombok 
  Madeira Maharashtra Maluku Marmara Matopos Midtsjælland 
  Minahasa Missouri Mjøsa Muallim Munzur Mysia
  Nordafjells Norrland Norrorts Nusantara
  Queensland
  Oberloiben Olona Orontes Otago
  Papua Pomerania Porong Punjab
  Rajasthan Rajputana Ratchaburi Rhodes Rogaland Rosfjord 
  Sakarya Salten Shanxi Siberia Sichuan Silesia Silla Sindh Sintang 
  Skåne Slask Southland Sydvest
  Tambun Taskopru Tasmania Telemark Tianya
  Tigris Tinglin Tuncelý
  Uttarakhand
  Victoria Vojvodina
  Wachau Waikato Wujin
  Yongjia Yunnan
  Zhejiang
);

my %SINGLE_TYPOS =
(
  'Aegean Sea' => ['aegean'],
  'Australian Central Territory' => ['act'],
  'Bekasi Regency' => ['bekasi'],
  Cappadocia => ['kapadokya', 'kapodokya'],
  Catalonia => ['catalunya', 'cataluña'],
  'Central Sulawesi' => ['sulteng'],
  Corsica => ['korsikali'],
  'Gabungan Malaku' => ['gabmin', 'gabmo'],
  Ganges => ['genges'],
  Hegyvidék  => ['hegyvidek'],
  Hordaland => ['hordland'],
  Hunan => ['hunnan'],
  'Java Bali' => ['jb'],
  Kansai => ['kinki'],
  'Kepulauan Riau' => ['riau', 'kepri'],
  Marmara => ['marmar'],
  'Midt Trøndelag' => ['midttrøndelag'],
  Minahasa => ['mnhasa'],
  'Møre Romsdal' => ['moreromsdal'],
  'Nakhon Nayok' => ['nakhonnayok'],
  'New South Wales' => ['nsw'],
  'North Sulawesi' => ['sulut'],
  'North Sumatra' => ['sumut'],
  'Northern Territory' => ['nt'],
  Queensland => ['qld'],
  Rajasthan => ['rajsthan'],
  'Samut Prakan' => ['samutprakan'],
  'Samut Sakhon' => ['samutsakhon'],
  Slask => ['l¹sk'],
  'South Australia' => ['sa'],
  'Suphan Buri' => ['suphanburi'],
  'Tamil Nadu' => ['tamilnadu'],
  Taskopru => ['tasköprü'],
  Tinglin => ['tingling'],
  'Uttar Pradesh' => ['up', 'upba'],
  Uttarakhand => ['uttaranchal'],
  'Victoria' => ['vic', 'viic'],
  Vojvodina => ['voj'],
  'Østfold Follo' => ['ostfoldfollo']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
