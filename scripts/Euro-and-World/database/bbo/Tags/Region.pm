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
  'Biala Podlaska',
  'Bisma Semarang',
  'Boeven Digoel',
  'Bone Bolango',
  'British Columbia',
  'Canary Islands',
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
  'Franche-Comté',
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
  'Kabupaten Tabalong',
  'Kapuas Hulu',
  'Kepulauan Riau',
  'Kepulauan Seribu',
  'Kayong Utara',
  'Khon Kaen',
  'Kotawaringin Timur',
  'Kubu Raya',
  'Kutai Kartanegara',
  'Kutai Timur',
  'KwaZulu Natal',
  'Lofoten og Vesterålen',
  'Lower Silesia',
  'Madhya Pradesh',
  'Maha Sarakham',
  'Mount Mahawu',
  'Midt Trøndelag',
  'Møre Romsdal',
  'Nakhon Nayok',
  'Nakhon Pathom',
  'Nakhon Sawan',
  'Nakhon Si Thammarat',
  'National Capital Region',
  'New Jersey',
  'New South Wales',
  'Nord Trøndelag',
  'Nord-Norge Omegn',
  'Norte Ilhas',
  'North Carolina',
  'North Dakota',
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
  'Rusenski Lom',
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
  'Southern California',
  'Suphan Buri',
  'Suzhou Taihu',
  'Sør-Trøndelag',
  'Tamil Nadu',
  'Tanah Laut',
  'Tonk State',
  'Troms og Ofoten',
  'Uttar Pradesh',
  'Val di Magra',
  'Vest Agder',
  'Vest Finnmark',
  'Warminsko-Mazurskie',
  'West Bengal',
  'West Borneo',
  'West District',
  'West Java',
  'West Kalimantan',
  'West Nusa Tenggara',
  'West Sulawesi',
  'West Sumatra',
  'West Virginia',
  'Western Australia',
  'Western Province',
  'Østfold Follo'
);

my %MULTI_TYPOS =
(
  Aceh => ['di aceh', 'n a d'],
  Borneo => ['borneo banua'],
  Buriram => ['buri ram'],
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
  'Southern California' => ['so cal'],
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
  Aberdeenshire Aceh Agder Akdeniz Akkad Alabama Alaska Algarve
  Altiplano Anatolia Andalusia Anhui Ararat Ardennes Arizona Arkansas 
  Arunachala Auvergne Ayrshire Azores

  Badakhshan Badung Bahia Bairrada Bali Banten Bayern Belitung Benchamas
  Bengal Bengkayang Bihar Bogø Borneo Bornholm Bungo Buriram Buskerud

  California Camargue Cantal Cappadocia Catalonia Charente Chartreuse
  Chengmai Colorado Comandatuba Corfu Corsica Crete

  Dersim Dobruca Dobruja Druts

  Eyjafjallajokull

  Feixiang Fjends Flakstad Florida Fujian Fyn

  Galapagos Ganges Gansu Gauteng Gelderland Gibraltar Goa Gorontalo 
  Guam Guangdong Guangxi Guizhou Gujarat

  Hainan Haixing Hatay Haugaland Hawaii Hebei Hedmark Hegyvidék 
  Heilongjiang Henan Herault Hordaland Huabei Hubei Hunan

  Iberia Idaho Illinois Indiana Iowa Iskele

  Jalisco Java Jharkhand Jiangsu Jiangxi Jilin

  Kaldbakur Kansai Kansas Kanto Karadon Karadeniz Karimata Karnataka 
  Kawanua Kedungwaru Kentucky Kerala Khuzestan Kilimanjaro Kizil Krabi 
  Kurdistan

  Lampung Languedoc Lebak Liaoning Liguria Loire Lombok Louisiana

  Madeira Maharashtra Maine Maluku Malwa Manle Marmara Marne Maryland 
  Matopos Mazovia Menorca Mesopotamia Michigan Midtsjælland Minahasa 
  Minang Minnesota Mississippi Missouri Misya Mjøsa Montana Muallim 
  Munzur Mysia

  Narathiwat Narman Natuna Nebraska Negev Ngawi Nordafjells Normandy 
  Norrland Norrorts Northland Nusantara

  Oberloiben Occitanie Odisha Ohio Oklahoma Olona Ontario Oregon 
  Orontes Otago

  Papua Paros Pasha Pennsylvania Phatthalung Pirojpur Podlaskie
  Pomerania Porong Prachinburi Provence Pudong Pufa Punjab Pyrenees

  Queensland Qiantang

  Rajasthan Rajputana Ratchaburi Rhodes Ringvassøy Rioja Rize Rogaland 
  Rosfjord 

  Sahyadri Sakarya Sallière Salten Sambas Samutsakorn Sanggau Saros
  Saskatchewan Schwyz Shandong Shanxi Siberia Sichuan Sicily Silesia 
  Silla Sindh Sintang Sitaro Skåne Slask Småland Southland Speyside 
  Sulawesi Suvalkija Sørlandet Sydvest

  Tala Tambun Tasmania Telemark Telengana Tenerife Tennessee Texas 
  Tharparkar Thassos Thrace Tianya Tigris Tinglin Transvaal 
  Transylvania Trentino Tunceli Tuscany

  Uludag Utah Uttarakhand Uzungol

  Valsugana Victoria Vojvodina

  Wachau Waikato Wielkopolska Wisconsin Wujin Wyssa

  Xizang Xinjiang

  Yongjia Yongjiang Yonne Yozgat Yunnan

  Zhejiang Zhongshan

);

my %SINGLE_TYPOS =
(
  Aceh => ['nad'],
  'Aegean Sea' => ['aegean'],
  'Australian Central Territory' => ['act'],
  'Bangka Belitung' => ['babel'],
  Buriram => ['burirum'],
  Dersim => ['dersým'],
  'Kabupaten Bekasi' => ['bekasi'],
  Cappadocia => ['kapadokya', 'kapodokya'],
  Catalonia => ['catalunya', 'cataluña'],
  'Central Sulawesi' => ['sulteng'],
  Corsica => ['korsikali'],
  'Gabungan Malaku' => ['gabmin', 'gabmo'],
  Ganges => ['genges'],
  Gujarat => ['gujrat', 'gujrath'],
  Hebei => ['heibei'],
  Hegyvidék  => ['hegyvidek'],
  'Himachal Pradesh' => ['himachal'],
  Hordaland => ['hordland'],
  Hunan => ['hunnan'],
  'Java Bali' => ['jb'],
  'Kabupaten Ketapang' => ['ketapang'],
  'West Kalimantan' => ['kalbar'],
  Karadeniz => ['karadenýz'],
  Kansai => ['kinki'],
  'Kayong Utara' => ['kayong'],
  'Kepulauan Riau' => ['riau', 'kepri'],
  'Kotawaringin Timur' => ['kotim'],
  'Kutai Timur' => ['kutim'],
  'Lofoten og Vesterålen' => ['lofoten'],
  'Maha Sarakham' => ['mahasarakham'],
  Marmara => ['marmar'],
  'Midt Trøndelag' => ['midttrøndelag'],
  Midtsjælland => ['midtsjaelland'],
  Minahasa => ['mnhasa', 'miinahasa'],
  'Mount Mahawu' => ['mahawu'],
  'Møre Romsdal' => ['moreromsdal'],
  'Nakhon Nayok' => ['nakhonnayok', 'nakornnayok'],
  'Nakhon Pathom' => ['nakhonpathom'],
  'National Capital Region' => ['ncr'],
  'New South Wales' => ['nsw'],
  Normandy => ['normandie'],
  'North Sulawesi' => ['sulut'],
  'North Sumatra' => ['sumut'],
  'Northern Territory' => ['nt'],
  Odisha => ['odisa'],
  Prachinburi => ['prajinburi'],
  Queensland => ['qld'],
  Qiantang => ['Qiangtang'],
  Rajasthan => ['rajsthan'],
  Ratchaburi => ['ratchanuri'],
  Rhodes => ['rhodos'],
  'Sa Kaeo' => ['sakaeo'],
  'Samut Prakan' => ['samutprakan', 'sumutprakan'],
  'Samut Sakhon' => ['samutsakhon', 'samutsakorn'],
  'Si Sa Ket' => ['sisaket'],
  Slask => ['l¹sk'],
  'South Australia' => ['sa'],
  'Suphan Buri' => ['suphanburi', 'supanburi'],
  Suvalkija => ['sudovia'],
  'Suzhou Taihu' => ['suzhoutaiho'],
  'Tamil Nadu' => ['tamilnadu'],
  Telengana => ['telangana'],
  Tinglin => ['tingling'],
  Tunceli => ['tuncelý'],
  Tuscany => ['toscana'],
  'Uttar Pradesh' => ['up', 'upba'],
  Uttarakhand => ['uttaranchal'],
  'Victoria' => ['vic', 'viic'],
  Vojvodina => ['voj'],
  'West Sumatra' => ['sumbar'],
  Xizang => ['tibet'],
  Yozgat => ['bozok'],
  'Østfold Follo' => ['ostfoldfollo']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
