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
  'Amnat Charoen',
  'Andhra Pradesh',
  'Australian Central Territory',
  'Bangka Belitung',
  'Bisma Semarang',
  'Boeven Digoel',
  'Bone Bolango',
  'Central Anatolia',
  'Central Districts',
  'Central Celebes',
  'Central Gauteng',
  'Central Java',
  'Central Sulawesi',
  'Kabupaten Cianjur',
  'Datca Yarimada',
  'District of Columbia',
  'Dogu Akdeniz',
  'East Borneo',
  'East Jakarta',
  'East Java',
  'East Kalimantan',
  'East Nusa Tenggara',
  'Eastern Cape',
  'Fylke Innlandet',
  'Gabungan Malaku',
  'Himachal Pradesh',
  'Indragiri Hulu',
  'Java Bali',
  'Kabupaten Bekasi',
  'Kabupaten Blitar',
  'Kabupaten Bogor',
  'Kabupaten Garut',
  'Kabupaten Gresik',
  'Kabupaten Jember',
  'Kabupaten Karawang',
  'Kabupaten Kepulauan Talaud',
  'Kabupaten Ketapang',
  'Kabupaten Kudus',
  'Kabupaten Langkat',
  'Kabupaten Lumajang',
  'Kabupaten Minahasa',
  'Kabupaten Nganjuk',
  'Kabupaten Pacitan',
  'Kabupaten Palu',
  'Kabupaten Pamekasan',
  'Kabupaten Pasuruan',
  'Kabupaten Pessel',
  'Kabupaten Sidoarjo',
  'Kabupaten Sijunjung',
  'Kabupaten Solok',
  'Kapuas Hulu',
  'Kepulauan Riau',
  'Kepulauan Seribu',
  'Kayong Utara',
  'Khon Kaen',
  'Kotawaringin Timur',
  'Kutai Kartanegara',
  'KwaZulu Natal',
  'Lofoten og Vesterålen',
  'Lower Silesia',
  'Madhya Pradesh',
  'Mount Mahawu',
  'Midt Trøndelag',
  'Møre Romsdal',
  'Nakhon Nayok',
  'Nakhon Pathom',
  'Nakhon Sawan',
  'Nakhon Si Thammarat',
  'National Capital Region',
  'New Caledonia',
  'New South Wales',
  'Nord Trøndelag',
  'Nord-Norge Omegn',
  'Norte Ilhas',
  'North Minahasa',
  'North Celebes',
  'North Sulawesi',
  'Northern Gauteng',
  'Northern Norway',
  'Northern Territory',
  'Nusa Tenggara Barat',
  'Park Firtina',
  'Pearl River',
  'Ren Shou',
  'Rio de Janeiro State',
  'Sa Kaeo',
  'Samut Prakan',
  'Samut Sakhon',
  'Si Sa Ket',
  'South Australia',
  'South Bulgaria',
  'South Celebes',
  'South East Celebes',
  'South Jakarta',
  'South Kalimantan',
  'South Sulawesi',
  'South Sumatra',
  'South Sweden',
  'Southeast Sulawesi',
  'Suphan Buri',
  'Sør-Trøndelag',
  'Tamil Nadu',
  'Tanah Laut',
  'Tonk State',
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
  'West Sulawesi',
  'West Sumatra',
  'Western Australia',
  'Western Province',
  'Østfold Follo'
);

my %MULTI_TYPOS =
(
  Aceh => ['di aceh', 'n a d'],
  Borneo => ['borneo banua'],
    'Central Java' => ['jawa tengah', 'jawah tengah', 'jateng'],
    'Central Anatolia' => ['ic anadolu'],
    'Central Sulawesi' => ['sulawesi tengah'],
    'Dogu Akdeniz' => ['dogu akdeniz region', 'akdeniz region'],
    'East Jakarta' => ['jakarta timur'],
    'East Java' => ['jawa timur', 'jatim'],
    'East Kalimantan' => ['kalimantan timur'],
    'Fylke Innlandet' => ['hedmark og oppland'],
  'East Nusa Tenggara' => ['nusa tenggara timur'],
  Guangdong => ['guangdong province', 'guang dong'],
  Hainan => ['hai nan'],
  Huabei => ['hua bei'],
  Hubei => ['hu bei'],
  Jiangsu => ['jiang su'],
  Jiangxi => ['jiang xi'],
  Jilin => ['ji lin'],
    'Kabupaten Bekasi' => ['bekasi regency', 'kab bekasi',
    'kab.bekasi', 'kab. bekasi'],
  'Kabupaten Blitar' => ['kab blitar', 'kab. blitar'],
  'Kabupaten Bogor' => ['kab. bogor', 'bogor regency',
    'kab bogor', 'kab.bogor pa'],
  'Kabupaten Cianjur' => ['cianjur regency',
    'kab. cianjur', 'kab.cianjur'],
  'Kabupaten Garut' => ['garut regency', 'kab. garut'],
  'Kabupaten Gresik' => ['kab gresik', 'kab. gresik'],
  'Kabupaten Jember' => ['kab jember', 'kab. jember'],
  'Kabupaten Karawang' => ['kab. karawang'],
  'Kabupaten Kepulauan Talaud' => ['kab. kep. talaud',
    'kep. talaud'],
  'Kabupaten Ketapang' => ['kab ketapang'],
  'Kabupaten Kudus' => ['kab. kudus'],
  'Kabupaten Langkat' => ['kab. langkat'],
  'Kabupaten Lumajang' => ['kab lumajang', 'kab. lumajang'],
  'Kabupaten Minahasa' => ['kab.minahasa', 'kab. minahasa'],
  'Kabupaten Nganjuk' => ['kab nganjuk', 'kab. nganjuk'],
  'Kabupaten Pacitan' => ['kab pacitan', 'kab. pacitan'],
  'Kabupaten Palu' => ['kab palu'],
  'Kabupaten Pamekasan' => ['kab pamekasan',
    'kab. pamekasan'],
  'Kabupaten Pasuruan' => ['kab pasuruan', 'kab. pasuruan',
    'kab.pasuruan'],
  'Kabupaten Sidoarjo' => ['kab sidoarjo', 'kab. sidoarjo'],
  'Kabupaten Sijunjung' => ['kab.sijunjung'],
  'Kabupaten Solok' => ['kab.solok'],
  'Kepulauan Seribu' => ['kep.seribu'],
  'Kutai Kartanegara' => ['kutai kartanega'],
  'Lofoten og Vesterålen' => ['lofoten og veste'],
  'Lower Silesia' => ['dolny slask'],
  Maharashtra => ['maharashtra e', 'maharashtra f',
    'maharashtra state'],
  Marmara => ['g.marm'],
  'Midt Trøndelag' => ['midt-trøndelag', 'midt-trondelag'],
  'Møre Romsdal' => ['more og romsdal'],
  'Nakhon Pathom' => ['nakhom prathom', 'nakhon prathom'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'North Sulawesi' => [
    'north sulawsei',
    'notth sulawesi', 
    'sulawasi utara', 
    'sulawesi utara', 
    'sulawusi utara',
    'suluwesi utara'],
  'North Minahasa' => ['minahasa utara'],
  'North Sumatra' => ['sumatera utara'],
  'Pearl River' => ['pearl riv', 'pearl r'],
  Prachinburi => ['prachin buri'],
  Qiantang => ['qian tang'],
  Sichuan => ['si chuan'],
  'South Jakarta' => ['jakarta selatan'],
  'South Kalimantan' => ['kalimantan selatan', 'kalsel'],
  'South Sulawesi' => ['sulawesi selatan', 'sulsel'],
  'South Sumatra' => ['south sumatera', 'sumatera selatan', 'sumsel'],
  'South Sweden' => ['south swden'],
  'Southeast Sulawesi' => ['sulawesi tenggara'],
  'Uttar Pradesh' => ['u.p.', 'up state'],
  'Vest Agder' => ['vest-agder'],
  'Val di Magra' => ['val magra'],
  'Vest Finnmark' => ['vest-finnmark'],
  'West Kalimantan' => ['kalimantan barat'],
  'West Nusa Tenggara' => ['lombok tengah'],
  'West Sulawesi' => ['sulawesi barat'],
  'West Sumatra' => ['west sumatera', 'sumatera barat', 'west sumatera'],
  'Western Australia' => ['wa'],
  'West Bengal' => ['west bengla', 'westbengal'],
  'West Java' => ['jawa barat', 'jabar'],
  Zhejiang => ['zhe jiang']
);

my @SINGLE_WORDS = qw(
  Aceh Agder Akdeniz Akkad Anhui Ayrshire
  Badung Bairrada Bali Banten Belitung Bengkayang Bihar Borneo 
  Bornholm Bungo Buskerud
  Cappadocia Catalonia Corsica Crete
  Dersým Druts
  Eyjafjallajokull
  Feixiang Fjends Florida
  Ganges Gansu Gauteng Goa Gorontalo Guangdong Guangxi 
  Guizhou Gujarat
  Hainan Haixing Hatay Haugaland Hebei Hedmark Hegyvidék Henan
  Hordaland Huabei Hubei Hunan
  Iberia
  Jalisco Jharkhand Jiangsu Jiangxi Jilin
  Kansai Kanto Karadeniz Karnataka Kawanua Kedungwaru Kerala 
  Krabi
  Lampung Lebak Liaoning Liguria Lombok 
  Madeira Maharashtra Maluku Marmara Matopos Midtsjælland 
  Minahasa Minang Missouri Mjøsa Muallim Munzur Mysia
  Natuna Nordafjells Norrland Norrorts Northland Nusantara
  Queensland Qiantang
  Oberloiben Olona Orontes Otago
  Papua Pomerania Porong Prachinburi Punjab
  Rajasthan Rajputana Ratchaburi Rhodes Rogaland Rosfjord 
  Sakarya Salten Sambas Sanggau Shandong Shanxi Siberia Sichuan 
  Silesia Silla Sindh Sintang Skåne Slask Southland Suvalkija 
  Sydvest
  Tala Tambun Tasmania Telemark Telengana Thrace Tianya
  Tigris Tinglin Tuncelý
  Uttarakhand
  Victoria Vojvodina
  Wachau Waikato Wujin
  Xinjiang
  Yongjia Yongjiang Yunnan
  Zhejiang
);

my %SINGLE_TYPOS =
(
  Aceh => ['nad'],
  'Aegean Sea' => ['aegean'],
  'Australian Central Territory' => ['act'],
  'Bangka Belitung' => ['babel'],
  'Kabupaten Bekasi' => ['bekasi'],
  Cappadocia => ['kapadokya', 'kapodokya'],
  Catalonia => ['catalunya', 'cataluña'],
  'Central Sulawesi' => ['sulteng'],
  Corsica => ['korsikali'],
  'Gabungan Malaku' => ['gabmin', 'gabmo'],
  Ganges => ['genges'],
  Hegyvidék  => ['hegyvidek'],
  'Himachal Pradesh' => ['himachal'],
  Hordaland => ['hordland'],
  Hunan => ['hunnan'],
  'Java Bali' => ['jb'],
  Karadeniz => ['karadenýz'],
  Kansai => ['kinki'],
  'Kayong Utara' => ['kayong'],
  'Kepulauan Riau' => ['riau', 'kepri'],
  'Kotawaringin Timur' => ['kotim'],
  Marmara => ['marmar'],
  'Midt Trøndelag' => ['midttrøndelag'],
  Minahasa => ['mnhasa'],
  'Mount Mahawu' => ['mahawu'],
  'Møre Romsdal' => ['moreromsdal'],
  'Nakhon Nayok' => ['nakhonnayok'],
  'National Capital Region' => ['ncr'],
  'New South Wales' => ['nsw'],
  'North Sulawesi' => ['sulut'],
  'North Sumatra' => ['sumut'],
  'Northern Territory' => ['nt'],
  Queensland => ['qld'],
  Qiantang => ['Qiangtang'],
  Rajasthan => ['rajsthan'],
  'Samut Prakan' => ['samutprakan'],
  'Samut Sakhon' => ['samutsakhon'],
  Slask => ['l¹sk'],
  'South Australia' => ['sa'],
  'Suphan Buri' => ['suphanburi'],
  Suvalkija => ['sudovia'],
  'Tamil Nadu' => ['tamilnadu'],
  Tinglin => ['tingling'],
  'Uttar Pradesh' => ['up', 'upba'],
  Uttarakhand => ['uttaranchal'],
  'Victoria' => ['vic', 'viic'],
  Vojvodina => ['voj'],
  'West Sumatra' => ['sumbar'],
  'Østfold Follo' => ['ostfoldfollo']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
