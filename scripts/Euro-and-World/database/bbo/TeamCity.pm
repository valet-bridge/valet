#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamCity;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_city);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Belo Horizonte',
  'Ping An',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Novi Sad',
  'Silesia Gliwice',
  'Villa Fabbriche'
);

my %MULTI_TYPOS =
(
  Istanbul => ['ýstanbul'],
  Ningbo => ['ning bo'],
  'Silesia Gliwice' => ['silezia gliwice'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adana Adelaide Ahmedabad Akhisar Alexandria Alytus
  Amarillo Ambon Amsterdam Ankara Antalya Antony Antwerpen
  Asenovgrad Assis Athens Auckland Augsburg Ayacucho
  Balikpapan Bamberg Bandung Bangalore Bangkok Banjarmasin Barcelona
  Bath Batman Batu Beijing Bekasi Belgrade Bengkulu Beograd Bergen Berlin 
  Bhubaneshwar Bielefeld Bitung Blitar Bogor Bologna Bonn Bordeaux Borivli
  Bremen Brisbane Bucharest Budapest Bursa Burdur Bytom
  Caen Cairns Canberra Caracas Catania Changzhou Chelsea
  Chengdu Chennai Chicago Chongqing Chumphon Cimahi Clichy
  Coventry Cuenca
  Dalian Dalls Daqing Darmstadt Debrecen Delft Delhi Denizli
  Dimitrovgrad Dobrich Dombivli Dongguan Düsseldorf
  Eastbourne Edirne Esbjerg Essen
  Fethiye Firenze
  Gdynia Gent Glidice Gorontalo Gölcük Gresik Guangzhou Guayaquil
  Hamburg Hangzhou Hannover Helsinki Hornbæk Huangshi Hyderabad
  Isparta Istanbul Izmir
  Jaipur Jakarta Jember Jiamusi Jiangyou Jilin Jinchang Jincheng Jinjiang
  Kadirli Kalisz Kalyani Kanpur Karachi Karlsruhe Kastamonu Katowice
  Kediri Kiel Kielce Kiev Kolkata Köln Krakow Kristiansand
  Kudus Kunshan Kuopio Kütahya
  Leiden Leszno Leuven Leverkusen Lhokseumawe Lille Lima Lincoln
  Ljubljana London Lubin Lublin Lumajang
  Maastricht Madrid Makassar Malmö Manahasa Manado Manchester 
  Manisa Mannheim Marbella Martapura Malatya Mataram Medan Melbourne
  Midyat Milan Minsk Miskolc Montpellier Mumbai Munich
  Nagpur Nagykanizsa Nanning Narita Nazilli Nijmegen Ningbo Nürnberg
  Odense Oldenburg Orhangazi Oslo Oxford
  Padang Padova Palembang Palermo Palma Palu Pariaman Paris
  Pekanbaru Pelotas Pernik Perth Pesaro Pescara
  Radkov Randers Rayong Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pula Pune Puri
  Rødovre
  Saarbrücken Salerno Samarinda Samsun Santiago Sanya Sarpsborg
  Secunderabad Semarang Serang Shanghai Shaoguan Shenyang Shenzhen
  Sibiu Sidoarjo Skien Skopje Sleman Sliven Sofia Split
  Stavanger Stuttgart Surabaya Suzhou Sydney Szeged
  Taizhou Takayama Tallinn Tarnów Täby Temuco Tianjin Tokyo Toulouse
  Trieste Trondheim Tromsø
  Udaipur Uppsala Utrecht
  Varese Varna Vejle Vilnius
  Xiamen Xinghua Xinyi
  Warsaw Wellington Worcester Wroclaw Wuhan
  Yambol Yibin Yokohama Yogyakarta
  Zagreb Zhenjiang Zhongshan Zhuzhou Zigong Zurich
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Antwerpen => ['antwerp'],
  Bangalore => ["b'lore", 'banglore'],
  Izmir => ['ýzmir'],
  Jakarta => ['dki'],
  Kolkata => ['calcutta'],
  Krakow => ['kraków'],
  Manahasa => ['mnhasa'],
  Munich => ['münchen'],
  Tarnów => ['tarnow'],
  Warsaw => ['warsow']
);


sub set_hashes_team_city
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
