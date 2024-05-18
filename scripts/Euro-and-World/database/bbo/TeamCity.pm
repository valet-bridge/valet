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
  'Monte Carlo',
  'Novi Sad',
  'Reggio Emilia',
  'San Giorgio del Sannio',
  'Semburat Jingga',
  'Shanghai Yangpu',
  'Siddha Eden Lakeville',
  'Silesia Gliwice',
  'Stara Zagora',
  'Tanjung Pinang',
  'Val de Seine',
  'Villa Fabbriche',
  'Vrnjacka Banja',
  'Xin Zhu',
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
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kristiansand => ['kr.sand'],
  Nangang => ['nan gang'],
  Ningbo => ['ning bo'],
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
  Annecy Antalya Antony Antwerpen Arendal Arjasa Asenovgrad Assis 
  Atakoy Atakum Athens Auckland Augsburg Avren Ayacucho Ayan Ayvalik

  Balcova Balikesir Balikpapan Ballerup Bamberg Bandung Bangalore 
  Bangkok Banjarmasin Baragnon Barcelona Batam Bath Batman Batu Bayrampaþa
  Begues Beijing Bekasi Belgrade Bengkalis Bengkulu Beograd 
  Bergen Bergues Berlin 
  Bhubaneshwar Bielefeld Bikaner Bitung Blitar Bodrum Bodø Bogazici 
  Bogor Bologna Bonn Bordeaux Borivli Bormali Bornova Bozdogan
  Braila Brandbu Brasilia Brasov Bremen Brisbane Bromölla Brotteaux 
  Buca Bucharest Budapest Buitenhof Burghausen Bursa Burdur Bytom

  Caen Cairns Canakkale Canberra Caracas Catania Çayyolu 
  Cerkezkoy Changzhou Chelsea Chengdu Chennai Chicago Chongqing 
  Chumphon Cimahi Clichy Copenhagen Corlu Courseulles Coventry Cuenca

  Dalian Dalls Daqing Darmstadt Datca Debrecen Delft Delhi Denizli
  Diyarbakir Dimitrovgrad Dobrich Dombivli Dongguan Düsseldorf

  Eastbourne Edirne Ege Esbjerg Esenkent Eskisehir Essen Eyjafjallajokull

  Farsund Fethiye Firenze Flekkefjord Frankfurt Førde

  Garches Gdansk Gdynia Genoa Gent Glidice Gorontalo Gölcük Gresik 
  Guangzhou Guayaquil Gudbrandsdal Gyor

  Haderslev Hamburg Hangzhou Hannover Harplinge Harstad 
  Hegyvidék Heimdal Helsinki Herning Hillerød
  Hornbæk Hosguru Huangshi Huldretråkket Hyderabad

  Iasi Iskenderun Isparta Istanbul Izmir

  Jaipur Jakarta Jember Jessheim Jiamusi Jiangyou Jilin Jinchang 
  Jincheng Jinjiang Jomtien

  Kadikoy Kadirli Kalisz Kalyani Kanpur Karachi Karlsruhe Kartal Karsiyaka
  Kastamonu Katowice Kaylaka Kediri Ketsch Kiel Kielce Kiev Kirklarelý 
  Kocaeli Kocamustafapasa Kolkata Konak Korwin Kosice Koycegiz Köln Krakow 
  Kristiansand Kucukcekmece Kudus Kunshan Kuopio Kusadasi Küp Kütahya
  Kverndalen

  Langkat Leiden Leszno Leuven Leverkusen Lhokseumawe Lille Lima 
  Lincoln Lindesberg Ljubljana Lodz London Losari Lowicz Lozenets 
  Lubin Lublin Lucignano Luleburgaz Lumajang

  Maastricht Madrid Makassar Malatya Malmö Manahasa Manado Manchester 
  Manisa Mannheim Marbella Martapura Malatya Massy Mataram 
  Medan Melbourne Mersin Meski Michalovce Midyat Milan Milas 
  Minsk Miskolc Montpellier Moradabad Mumbai Munich Muratpasa

  Nagbagan Nagpur Nagykanizsa Namsos Nangang Nanning Napoli
  Narita Narlidere Narvik Nazilli Näsby Nijmegen Ningbo Niski 
  Norrbyskär Norrøna Nusantara Nürnberg Nyon Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Olgiata Orhangazi Oslo Ottadalen Oxford Överum

  Padang Padova Palembang Palermo Palma Palu Pamukkale Panzhihua Pariaman 
  Parioli Paris Pärnu
  Pekanbaru Pelotas Pernik Perth Pesaro Pescara Posillipo Poznan
  Pula

  Qiaoxie Qingdao

  Radkov Rakvere Randers Rayong Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pudong Pula Pune Puri

  Rajasthan Rødovre

  Saarbrücken Sakarya Salerno Samarinda Samsun Sandefjord 
  Santiago Sanya Sarniak Sarpsborg Secunderabad Seferihisar Semarang 
  Senayan Serang Shanghai Shaoguan Shenyang 
  Shenzhen Shihua Sibiu Sidoarjo Siena Singsås Skara Skien Skopje 
  Slagelse Sleman Sliven Sofia Solok Sortland Söke Split 
  Stavanger Steinkjer Storsjöbygden Stureby Stuttgart Sunndalsøra 
  Surabaya Suzhou Sydney Szeged Sørreisa

  Täfteå Taicang Taihu Tainan Taizhou Takayama Tallinn Targoviste 
  Tarnów Täby Tekýrdag Temuco Tequendama Thessaloniki Tianjin 
  Tianya Timisoara Tingling Tire Tokyo Torino Toulouse Trieste 
  Trondheim Tromsø

  Uccle Udaipur Unia Unaós Uppsala Usak Utrecht

  Varbergshus Varese Varna Vasa Västervik Vejle Vestfold Vestvågøy Vienna 
  Vikersund Vilnius Viþnelik Vraca

  Xiamen Xinghua Xinyi

  Warsaw Wellington Worcester Wratislavia Wróble Wroclaw Wuhan

  Yalikavak Yambol Yarimada Yenisehir Yibin Yildirim Yokohama Yogyakarta

  Zagreb Zhenjiang Zhongshan Zhuzhou Zigong Zurich Zyrardow

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
  Balisekir => ['balikesýr'],
  Balkova => ['balçova'],
  Bangalore => ["b'lore", 'banglore'],
  Beijing => ['peking'],
  Borivli => ['borivali'],
  Canakkale => ['çanakkale'],
  Çayyolu => ['cayyolu'],
  Cerkezkoy => ['çerkezköy'],
  Copenhagen => ['kopenhagen'],
  Corlu => ['çorlu'],
  Diyarbakir => ['Dýyarbakir'],
  Düsseldorf => ['duesseldorf'],
  Genoa => ['genova'],
  Guangzhou => ['gz', 'gaungzhou'],
  Hegyvidék  => ['hegyvidek'],
  Heimdal => ['heimdalbc'],
  Izmir => ['ýzmir', 'ýzmýr'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta'],
  Kosice => ['cassovia'],
  Koycegiz => ['köyceðýz'],
  Krakow => ['kraków'],
  Kristiansand => ['kristiansands'],
  'Kuala Lumpur' => ['kl'],
  Küp => ['kup'],
  Lozenets => ['lozenec'],
  Makassar => ['makasar'],
  Manahasa => ['mnhasa'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Monte Carlo' => ['montecarlo'],
  Mumbai => ['mum'],
  Munich => ['münchen'],
  Napoli => ['naples'],
  Narlidere => ['narlýdere'],
  Norrbyskär => ['norrbyskar'],
  Olgiata => ['ola'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Parioli => ['paroli'],
  Potsdam => ['postdam'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov'],
  'Reggio Emilia' => ['re'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  Singsås => ['singsaas'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Sunndalsøra => ['sundalsora',' sunndalsora'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Täfteå => ['taftea'],
  Tekýrdag => ['tekirdað'],
  Thessaloniki => ['salonica'],
  Tromsø => ['tromso', 'tromsoe'],
  Trondheim => ['trondhei'],
  Vienna => ['wien'],
  Warsaw => ['warsow'],
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
