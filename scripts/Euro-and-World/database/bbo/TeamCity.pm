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
  'Aix en Provence',
  'Banda Aceh',
  'Bandar Lampung',
  'Belo Horizonte',
  'Ping An',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Novi Sad',
  'Reggio Emilia',
  'Silesia Gliwice',
  'Villa Fabbriche',
  'Vrnjacka Banja'
);

my %MULTI_TYPOS =
(
  Istanbul => ['ýstanbul'],
  Ningbo => ['ning bo'],
  'Reggio Emilia' => ['r.e.', 'reggio e'],
  Pudong => ['pu dong'],
  Qingdao => ['qing dao'],
  'Silesia Gliwice' => ['silezia gliwice'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adana Adelaide Agresar Ahmedabad Akçeşme 
  Akdeniz Akhisar Alexandria Allahabad Altay Alytus Amarillo Ambon 
  Amsterdam Anadolu Ankara Annecy Antalya Antony Antwerpen 
  Asenovgrad Assis Atakoy Athens Auckland Augsburg Ayacucho Ayvalik

  Balcova Balikpapan Balisekir Ballerup Bamberg Bandung 
  Bangalore Bangkok Banjarmasin Baragnon Barcelona Batam Bath Batman Batu 
  Beijing Bekasi Belgrade Bengkalis Bengkulu Beograd Bergen Bergues Berlin 
  Bhubaneshwar Bielefeld Bitung Blitar Bodrum Bodø Bogazici 
  Bogor Bologna Bonn 
  Bordeaux Borivli Bornova Bozdogan
  Braila Brasov Bremen Brisbane Brotteaux 
  Buca Bucharest Budapest Burghausen Bursa Burdur Bytom

  Caen Cairns Canakkale Canberra Caracas Catania Çayyolu 
  Cerkezkoy Changzhou Chelsea Chengdu Chennai Chicago Chongqing 
  Chumphon Cimahi Clichy Corlu Courseulles Coventry Cuenca
  Dalian Dalls Daqing Darmstadt Debrecen Delft Delhi Denizli
  Dimitrovgrad Dobrich Dombivli Dongguan Düsseldorf
  Eastbourne Edirne Ege Esbjerg Essen
  Fethiye Firenze
  Garches Gdynia Gent Glidice Gorontalo Gölcük Gresik Guangzhou Guayaquil

  Haderslev Hamburg Hangzhou Hannover Harplinge Harstad 
  Hegyvidék Heimdal Helsinki Herning Hillerød
  Hornbæk Hosguru Huangshi Hyderabad

  Iasi Isparta Istanbul Izmir
  Jaipur Jakarta Jember Jessheim Jiamusi Jiangyou Jilin Jinchang 
  Jincheng Jinjiang
  Kadirli Kalisz Kalyani Kanpur Karachi Karlsruhe Kastamonu Katowice
  Kaylaka Kediri Ketsch Kiel Kielce Kiev Kolkata Konak Köln 
  Krakow Kristiansand Kudus Kunshan Kuopio Kütahya
  Leiden Leszno Leuven Leverkusen Lhokseumawe Lille Lima Lincoln
  Ljubljana London Lubin Lublin Lumajang
  Maastricht Madrid Makassar Malmö Manahasa Manado Manchester 
  Manisa Mannheim Marbella Martapura Malatya Massy Mataram 
  Medan Melbourne Mersin Midyat Milan Minsk Miskolc 
  Montpellier Moradabad Mumbai Munich
  Nagpur Nagykanizsa Nanning Narita Nazilli Näsby 
  Nijmegen Ningbo Niski Norrøna Nürnberg Nyon Nærbø Næstved

  Odense Oldenburg Orhangazi Oslo Oxford

  Padang Padova Palembang Palermo Palma Palu Pamukkale Pariaman 
  Paris Pärnu
  Pekanbaru Pelotas Pernik Perth Pesaro Pescara Posillipo
  Pula

  Qingdao

  Radkov Randers Rayong Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pudong Pula Pune Puri

  Rajasthan Rødovre
  Saarbrücken Salerno Samarinda Samsun Santiago Sanya Sarpsborg
  Secunderabad Semarang Serang Shanghai Shaoguan Shenyang Shenzhen
  Shihua Sibiu Sidoarjo Skien Skopje Sleman Sliven Sofia Sortland Split
  Stavanger Stuttgart Sunndalsøra Surabaya Suzhou Sydney Szeged
  Taizhou Takayama Tallinn Tarnów Täby Temuco Tianjin Tianya
  Tokyo Toulouse Trieste Trondheim Tromsø
  Udaipur Uppsala Utrecht
  Varese Varna Vejle Vilnius Vraca
  Xiamen Xinghua Xinyi

  Warsaw Wellington Worcester Wratislavia Wroclaw Wuhan

  Yambol Yibin Yokohama Yogyakarta
  Zagreb Zhenjiang Zhongshan Zhuzhou Zigong Zurich
  Åkirkeby Århus
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Akçeşme => ['akcesme'],
  Akdeniz =>['akdenýz'],
  Antwerpen => ['antwerp'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Balisekir => ['balikesýr'],
  Balkova => ['balçova'],
  Bangalore => ["b'lore", 'banglore'],
  Borivli => ['borivali'],
  Canakkale => ['çanakkale'],
  Çayyolu => ['cayyolu'],
  Cerkezkoy => ['çerkezköy'],
  Corlu => ['çorlu'],
  Izmir => ['ýzmir'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Kolkata => ['calcutta'],
  Krakow => ['kraków'],
  Makassar => ['makasar'],
  Manahasa => ['mnhasa'],
  Munich => ['münchen'],
  Pamukkale => ['pamuk'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov'],
  Sunndalsøra => ['sundalsora'],
  Tarnów => ['tarnow'],
  Tromsø => ['tromso', 'tromsoe'],
  Warsaw => ['warsow'],
  Åkirkeby => ['aakirkeby'],
  Århus => ['aarhus', 'arhus']
);


sub set_hashes_team_city
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
