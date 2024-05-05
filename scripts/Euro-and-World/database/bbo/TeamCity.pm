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
  'Gjøvik og Vardal',
  'Ping An',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Novi Sad',
  'Reggio Emilia',
  'Silesia Gliwice',
  'Val de Seine',
  'Villa Fabbriche',
  'Vrnjacka Banja',
  'Xin Zhu'
);

my %MULTI_TYPOS =
(
  'City of Helsinki' => ['helsinki'],
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
  Aabenraa Aalborg Adalar Adana Adelaide Agresar Ahmedabad Akaylar
  Akçeşme Akdeniz Akhisar Akkad Alexandria Aliaga Allahabad Altay 
  Altrincham Alytus Amanora Amarillo Ambon Amsterdam Anadolu Ankara 
  Annecy Antalya Antony Antwerpen Arendal Arjasa Asenovgrad Assis 
  Atakoy Atakum Athens Auckland Augsburg Avren Ayacucho Ayan Ayvalik

  Balcova Balikesir Balikpapan Ballerup Bamberg Bandung Bangalore 
  Bangkok Banjarmasin Baragnon Barcelona Batam Bath Batman Batu Bayrampaþa
  Begues Beijing Bekasi Belgrade Bengkalis Bengkulu Beograd 
  Bergen Bergues Berlin 
  Bhubaneshwar Bielefeld Bitung Blitar Bodrum Bodø Bogazici 
  Bogor Bologna Bonn Bordeaux Borivli Bornova Bozdogan
  Braila Brasov Bremen Brisbane Brotteaux 
  Buca Bucharest Budapest Burghausen Bursa Burdur Bytom

  Caen Cairns Canakkale Canberra Caracas Catania Çayyolu 
  Cerkezkoy Changzhou Chelsea Chengdu Chennai Chicago Chongqing 
  Chumphon Cimahi Clichy Corlu Courseulles Coventry Cuenca

  Dalian Dalls Daqing Darmstadt Debrecen Delft Delhi Denizli
  Diyarbakir Dimitrovgrad Dobrich Dombivli Dongguan Düsseldorf

  Eastbourne Edirne Ege Esbjerg Eskisehir Essen

  Fethiye Firenze Flekkefjord Førde

  Garches Gdynia Gent Glidice Gorontalo Gölcük Gresik 
  Guangzhou Guayaquil Gudbrandsdal

  Haderslev Hamburg Hangzhou Hannover Harplinge Harstad 
  Hegyvidék Heimdal Helsinki Herning Hillerød
  Hornbæk Hosguru Huangshi Hyderabad

  Iasi Iskenderun Isparta Istanbul Izmir

  Jaipur Jakarta Jember Jessheim Jiamusi Jiangyou Jilin Jinchang 
  Jincheng Jinjiang Jomtien

  Kadirli Kalisz Kalyani Kanpur Karachi Karlsruhe Kartal Karsiyaka
  Kastamonu Katowice Kaylaka Kediri Ketsch Kiel Kielce Kiev 
  Kirklarelý Kocaeli Kocamustafapasa Kolkata Konak Koycegiz Köln 
  Krakow Kristiansand Kucukcekmece Kudus Kunshan Kuopio Kusadasi Kütahya

  Leiden Leszno Leuven Leverkusen Lhokseumawe Lille Lima Lincoln
  Ljubljana London Lubin Lublin Luleburgaz Lumajang

  Maastricht Madrid Makassar Malatya Malmö Manahasa Manado Manchester 
  Manisa Mannheim Marbella Martapura Malatya Massy Mataram 
  Medan Melbourne Mersin Midyat Milan Minsk Miskolc 
  Montpellier Moradabad Mumbai Munich Muratpasa

  Nagbagan Nagpur Nagykanizsa Namsos Nanning Narita Narlidere 
  Nazilli Näsby Nijmegen Ningbo Niski Norrøna Nusantara Nürnberg 
  Nyon Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Orhangazi Oslo Oxford

  Padang Padova Palembang Palermo Palma Palu Pamukkale Pariaman 
  Paris Pärnu
  Pekanbaru Pelotas Pernik Perth Pesaro Pescara Posillipo
  Pula

  Qingdao

  Radkov Randers Rayong Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pudong Pula Pune Puri

  Rajasthan Rødovre

  Saarbrücken Sakarya Salerno Samarinda Samsun Sandefjord 
  Santiago Sanya Sarpsborg Secunderabad Seferihisar Semarang 
  Senayan Serang Shanghai Shaoguan Shenyang 
  Shenzhen Shihua Sibiu Sidoarjo Skara Skien Skopje Sleman Sliven 
  Sofia Solok Sortland Söke Split Stavanger Steinkjer 
  Storsjöbygden Stuttgart Sunndalsøra Surabaya Suzhou Sydney 
  Szeged Sørreisa

  Taizhou Takayama Tallinn Targoviste Tarnów Täby Tekýrdag Temuco 
  Thessaloniki Tianjin Tianya Timisoara Tire Tokyo Toulouse 
  Trieste Trondheim Tromsø

  Udaipur Uppsala Usak Utrecht

  Varese Varna Vasa Västervik Vejle Vestfold Vestvågøy Vienna 
  Vikersund Vilnius Vraca

  Xiamen Xinghua Xinyi

  Warsaw Wellington Worcester Wratislavia Wroclaw Wuhan

  Yalikavak Yambol Yibin Yildirim Yokohama Yogyakarta

  Zagreb Zhenjiang Zhongshan Zhuzhou Zigong Zurich Zyrardow

  Åkirkeby Århus
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Akçeşme => ['akcesme', 'akçeþme'],
  Akdeniz =>['akdenýz'],
  Akhisar => ['Akhýsar'],
  Ankara => ['ancyra'],
  Antwerpen => ['antwerp'],
  Arendal => ['arendals'],
  Atakoy => ['ataköy'],
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
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta'],
  Krakow => ['kraków'],
  Kristiansand => ['kristiansands'],
  Makassar => ['makasar'],
  Manahasa => ['mnhasa'],
  Mumbai => ['mum'],
  Munich => ['münchen'],
  Narlidere => ['narlýdere'],
  Pamukkale => ['pamuk'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov'],
  Rome => ['roma'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Sunndalsøra => ['sundalsora'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Tekýrdag => ['tekirdað'],
  Thessaloniki => ['salonica'],
  Tromsø => ['tromso', 'tromsoe'],
  Vienna => ['wien'],
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
