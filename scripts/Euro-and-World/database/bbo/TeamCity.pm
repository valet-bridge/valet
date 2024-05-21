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
  'El-Maadi',
  'Gjøvik og Vardal',
  'Ping An',
  'Kansas City',
  'Kashi Goa',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'La Chaux-de-Fonds',
  'Meilin Qingcheng',
  'Mitra Vihar',
  'Monte Carlo',
  'Novi Sad',
  'Reggio Emilia',
  'San Giorgio del Sannio',
  'Semburat Jingga',
  'Shanghai Yangpu',
  'Siddha Eden Lakeville',
  'Silesia Gliwice',
  'St Louis',
  'Stara Zagora',
  'Tanjung Pinang',
  'The Hague',
  'Udon Thani',
  'Val de Seine',
  'Villa Fabbriche',
  'Vrnjacka Banja',
  'Xin Zhu',
  'Yedi Eylul',
  'Zhong Jian'
);

my %MULTI_TYPOS =
(
  Aceh => ['di aceh'],
  'City of Helsinki' => ['helsinki'],
  Diyarbakir => ['d.baki', 'd.bakir', 'd.bakýr', 'd.baki b.þ',
    'd.bakir b.þ.', 'd.bakir y.þehýr', 'd.bakir yenýþehýr',
    'd.bakýr b.þehir', 'd.bakir sur', 'd.bakýr sur',
    'd.bakýr dicle'],
  Guangzhou => ['guang zhou'],
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kristiansand => ['kr.sand'],
  Nangang => ['nan gang'],
  Ningbo => ['ning bo'],
  'Novi Sad' => ['nowe sady'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Pudong => ['pu dong'],
  Qingdao => ['qing dao'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  Shenzhen => ['shen zhen'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice'],
  Taicang => ['tai cang'],
  Taihu => ['tai hu'],
  Tainan => ['tai nan'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  Yogyakarta => ['di jogjakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adalar Adana Adelaide Agresar Ahmedabad Akaylar
  Akçeşme Akdeniz Akhisar Akkad Alexandria Albena Aliaga Allahabad Altay 
  Altrincham Alytus Amanora Amarillo Ambon Amsterdam Anadolu Ankara 
  Annecy Antalya Antony Antwerpen Aral Arendal Arjasa Asenovgrad Assis 
  Atakoy Atakum Athens Auckland Augsburg Avren Ayacucho Ayan Ayvalik

  Balcova Bahcesehir Balikesir Balikpapan Ballerup Bamberg Bandung 
  Bangalore Bangkok Banjarmasin Bansi Baragnon Barcelona Batam Bath 
  Batman Batu Bayrampaþa Begues Beijing Bekasi Belgrade Bengkalis 
  Bengkulu Beograd Bereket Bergen Bergues Berlin Beroe Bhilwara
  Bhubaneshwar Bielefeld Bieniewo Bikaner Bitung Blitar Bodrum 
  Bodø Bogazici Bogor Bologna Bonn Bordeaux Borivli Bormali 
  Bornova Bozdogan Braila Brandbu Brasilia Brasov Bremen Brisbane 
  Bromölla Brotteaux Buca Bucharest Budapest Buitenhof Burghausen 
  Bursa Burdur Bytom

  Caen Cairns Canakkale Canberra Canterbury Caracas Cascais Catania 
  Çayyolu Cerkezkoy Cesme Changzhou Chaville Chelmno Chelsea Chengdu 
  Chennai Chicago Chislehurst Chongqing Chumphon Cimahi Clichy 
  Copenhagen Corlu Courseulles Coventry Cuenca Cuneo

  Dalian Dalls Daqing Darmstadt Datca Debrecen Delft Delhi Denizli
  Derpt Dersým Diyarbakir Dimitrovgrad Dobrich Dombivli Dongguan 
  Düsseldorf

  Eastbourne Edirne Ege Elblag Esbjerg Esenkent Eskisehir Essen 
  Eyjafjallajokull

  Farsund Farta Fethiye Firenze Flekkefjord Frankfurt Freidorf Førde

  Garches Gdansk Gdynia Genoa Gent Glidice Gnesta Gorontalo Gorzow
  Gölcük Gresik Guangzhou Guayaquil Gudbrandsdal Gundogan Gyor

  Haderslev Hamburg Hangzhou Hannover Harplinge Harstad 
  Hegyvidék Heimdal Heledia Helsinki Herning Hillerød
  Hornbæk Hosguru Huangshi Huldretråkket Hyderabad

  Iasi Iskenderun Isparta Istanbul Izmir

  Jagodina Jaipur Jakarta Jember Jessheim Jiamusi Jiangyou Jilin 
  Jinchang Jincheng Jinjiang Jomtien

  Kadikoy Kadirli Kalisz Kalundborg Kalyani Kanpur Karachi Karlsruhe 
  Kartal Karsiyaka Kastamonu Katok Katowice Kaylaka Kediri Kesten 
  Ketsch Kiel Kielce Kiev Kirkeby Kirklarelý Kocaeli Kocamustafapasa 
  Kolbotn Kolkata Konak Korwin Kosice Koycegiz Köln Krakow Kristiansand 
  Kucukcekmece Kudus Kunshan Kuopio Kusadasi Küp Kütahya Kverndalen
  Kølabånn

  Langkat Lappee Leiden Lemvourgeio Lerum Leszno Leuven Leverkusen 
  Lhokseumawe Lille Lima Lincoln Lindesberg Ljubljana Lodz Lokotok
  London Losari Lowicz Lozenets Lubin Lublin Lucignano Luleburgaz 
  Lumajang

  Maadi Maastricht Madrid Makaliwe Makassar Makus Malatya Malkia Malmö 
  Manahasa Manado Manchester Manisa Mannheim Marbella Martapura 
  Massy Mataram Männiku Medan Melbourne Mersin Meski Michalovce 
  Midyat Milan Milas Minsk Miskolc Montpellier Moradabad Morud
  Moudania Mrzenci Mumbai Munich Muratpasa

  Nagbagan Nagpur Nagykanizsa Namsos Nangang Nanning Napoli
  Narita Narlidere Narvik Nazilli Näsby Nijmegen Ningbo Niski 
  Norrbyskär Norrorts Norrøna Nusantara Nürnberg Nyon Nærbø Næstved 
  Nøtterøy

  Odense Ogndal Oldenburg Olgiata Orhangazi Oslo Ottadalen Otepää
  Oxford Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale 
  Pancevo Panzhihua Pariaman Parioli Paris Pärnu Pasham Pattaya 
  Pekanbaru Pelotas Pernik Perth Perula Pesaro Pescara Peterfield 
  Piloni Pinarbasi Polonezkoy Poncol Popovo Posillipo Poznan Pula

  Qiaoxie Qingdao

  Radkov Rakvere Randers Rayong Recoleta Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pudong Pula Pune Puri

  Rajasthan Ravnkilde Rzeszow Rødovre

  Saarbrücken Sabadel Sakarya Salerno Samarinda Samsun Sandefjord 
  Sansar Santiago Sanya Sarniak Sarpsborg Secunderabad Seferihisar 
  Semarang Senayan Serang Serdika Shanghai Shaoguan Shenyang 
  Shenzhen Shihua Sibiu Sidoarjo Siena Simal Sindi Singsås Skara Skien 
  Skopje Slagelse Slaska Sleman Sliven Sofia Solok Sortland Söke Split 
  Sredec Stavanger Steinkjer Storsjöbygden Stureby Stuttgart 
  Sukma Suleymanpasa Sunndalsøra Surabaya Suzhou Sydney Szeged Sørreisa

  Taicang Taihu Tainan Taizhou Takayama Tallinn Targoviste Tarnów 
  Taskopru Täby Täfteå Tekýrdag Temuco Tequendama Thessaloniki Tianjin 
  Tianya Timisoara Tingling Tire Tokyo Tomohon Torino Toulouse Trieste 
  Trondheim Tromsø

  Uccle Udaipur Unia Unaós Uppsala Usak Utrecht

  Van Varbergshus Varese Varna Vasa Västervik Vejle Vestfold Vestvågøy 
  Vienna Vikersund Vilnius Viþnelik Vraca

  Xiamen Xinghua Xinyi

  Warsaw Wellington Wisla Worcester Wratislavia Wroble Wroclaw Wuhan

  Yalikavak Yambol Yarimada Yatagan Yenisehir Yibin Yildirim Yokohama 
  Yogyakarta

  Zagreb Zeugma Zhenjiang Zhongshan Zhujiang Zhuzhou Zigong Zurich 
  Zyrardow

  Ørland

  Åkirkeby Århus
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Akçeşme => ['akcesme', 'akçeþme'],
  Akdeniz =>['akdenýz'],
  Akhisar => ['Akhýsar'],
  Allahabad => ['alahabad'],
  Ankara => ['ancyra'],
  Antwerpen => ['antwerp'],
  Arendal => ['arendals'],
  Atakoy => ['ataköy'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Bahcesehir => ['bahçeþehýr'],
  Balisekir => ['balikesýr'],
  Balkova => ['balçova'],
  Bangalore => ["b'lore", 'banglore'],
  Bansi => ["bansi's"],
  Beijing => ['peking'],
  Borivli => ['borivali'],
  Canakkale => ['çanakkale'],
  Çayyolu => ['cayyolu'],
  Cerkezkoy => ['çerkezköy'],
  Copenhagen => ['kopenhagen'],
  Corlu => ['çorlu'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Düsseldorf => ['duesseldorf'],
  Genoa => ['genova'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Hegyvidék  => ['hegyvidek'],
  Heimdal => ['heimdalbc'],
  Izmir => ['ýzmir', 'ýzmýr'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Kalundborg => ['kallundborg'],
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta'],
  Kosice => ['cassovia'],
  Koycegiz => ['köyceðýz'],
  Krakow => ['kraków'],
  Kristiansand => ['kristiansands'],
  'Kuala Lumpur' => ['kl'],
  Küp => ['kup'],
  Lhokseumawe => ['lhoeksemawe'],
  Lozenets => ['lozenec'],
  Makassar => ['makasar'],
  Manahasa => ['mnhasa'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitra vihar'],
  'Monte Carlo' => ['montecarlo'],
  Moudania => ['moydania'],
  Mumbai => ['mum'],
  Munich => ['münchen'],
  Nagpur => ['nagpor'],
  Nangang => ['nanggang'],
  Napoli => ['naples'],
  Narlidere => ['narlýdere'],
  Ningbo => ['ningpo'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olgiata => ['ola'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Parioli => ['paroli'],
  Potsdam => ['postdam'],
  Poznan => ['poz'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov'],
  'Reggio Emilia' => ['re'],
  Reykjavik => ['reykjavikur', 'reykjavitur'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  Singsås => ['singsaas'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Sunndalsøra => ['sundalsora', 'sunndalsora'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Täfteå => ['taftea'],
  Tekýrdag => ['tekirdað'],
  Thessaloniki => ['salonica'],
  Tromsø => ['tromso', 'tromsoe'],
  Trondheim => ['trondhei'],
  Udaipir => ['udaypur'],
  'Udon Thani' => ['udonthani'],
  Vienna => ['wien'],
  Warsaw => ['warsow', 'warszawa'],
  Wroble => ['wróble'],
  Wroclaw => ['wr'],
  Yogyakarta => ['jogjakarta', 'diy'],
  'Zhong Jian' => ['zhongjian'],
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
