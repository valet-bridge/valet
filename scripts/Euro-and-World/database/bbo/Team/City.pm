#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::City;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_city);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Aix en Provence',
  'Al-Rabwa',
  'Banda Aceh',
  'Bandar Lampung',
  'Belo Horizonte',
  'Buenos Aires',
  'Boven Digoel',
  'Courseulles-sur-Mer',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Greve Strand',
  'Kansas City',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'La Chaux-de-Fonds',
  'La Marina',
  'Le Bouscat',
  'Mandobo Bodi',
  'Meilin Qingcheng',
  'Mitra Vihar',
  'Monte Carlo',
  'Muara Bungo',
  'Nea Moudonia',
  'New Taipei City',
  'New York City',
  'Nové Město',
  'Novi Sad',
  'Piatra Neamt',
  'Reggio Emilia',
  'Saint Petersburg',
  'San Giorgio del Sannio',
  'São Paulo',
  'Semburat Jingga',
  'Seulawah Agam',
  'Siddha Eden Lakeville',
  'Silesia Gliwice',
  'Singapore City',
  'St Louis',
  'Stara Zagora',
  'Tanjung Pinang',
  'Taipei City',
  'The Hague',
  'Udon Thani',
  'Urbana-Champaign',
  'Val de Seine',
  'Villa Fabbriche',
  'Vrnjacka Banja',
  'Xin Zhu',
  'Ye Shi',
  'Yedi Eylul',
  'Zhong Jian'
);

my %MULTI_TYPOS =
(
  Aceh => ['di aceh'],
  Akhisar => ['akhisar belediyesi'],
  'Al-Rabwa' => ['rl-rabwa'],
  'City of Helsinki' => ['helsinki'],
  Diyarbakir => ['d.baki b.þ', 'd.bakir b.þ.', 'd.bakir y.þehýr', 
    'd.bakir yenýþehýr', 'd.bakýr b.þehir', 'd.bakir sur', 
    'd.bakýr sur', 'd.bakýr dicle'],
  'Gaziantep Zeugma' => ['g.antep zeugma'],
  Guangzhou => ['guang zhou'],
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jak-sel', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kalyani => ["kalyani's"],
  Kristiansand => ['kr.sand'],
  Ningbo => ['ning bo'],
  'Piatra Neamt' => ['p. neamt', 'p.neamt'],
  Porto => ['invicta', 'cidade invicta'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Qingdao => ['qing dao'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice'],
  Taicang => ['tai cang'],
  Tainan => ['tai nan'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  'Vrnjacka Banja' => ['vrnjacka banja - al'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adana Adelaide Agresar Ahmedabad Airmadidi Akhisar 
  Alexandria Allahabad Altrincham Alytus Amanora Amarillo Ambon 
  Amsterdam Ankara Annecy Antalya Antony Antwerpen Aral Arendal 
  Asenovec Asenovgrad Assis Atakum Athens Auckland Ayacucho Aydin 
  Ayvalik

  Baghdad Balchik Balikesir Balikpapan Ballerup Bamberg Bandung 
  Bangalore Bangkok Banjarmasin Bansi Barcelona Batam Bath Batu Begues 
  Beijing Bekasi Belgrade Bengkulu Beograd Bereket Bergen Bergues 
  Berkeley Berlin Bhilwara Bhubaneshwar Bielefeld Bikaner Bitung 
  Blitar Bodrum Bodø Bogor Bogotá Bologna Bonn Bordeaux Braila Brandbu 
  Brasilia Brasov Bremen Brisbane Bromölla Brussels Bucharest Budapest 
  Burghausen Bursa Burdur 

  Caen Cairns Cairo Canakkale Canberra Canterbury Caracas Cascais 
  Catania Cerkezkoy Cesme Changhua Changzhou Chaville Chelmno Chengdu 
  Chennai Chiayi Chicago Chongqing Chumphon Cirebon Clichy Cluj 
  Copenhagen Corlu Coventry Cuenca Cuneo

  Dalian Darmstadt Datca Delft Delhi Denizli Depok Derpt Diyarbakir 
  Dimitrovgrad Dobrich Dombivli Dongguan Durban Düsseldorf

  Eastbourne Edirne Elblag Esbjerg Eskisehir Essen Evanston

  Farsund Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt Freidorf 

  Gdansk Gdynia Genoa Gent Gevgelija Geyve Gnesta Gorzow Gölcük Gresik 
  Guangzhou Guayaquil Gudbrandsdal Gyor

  Haderslev Hamar Hamburg Hangzhou Hannover Harplinge Hatay Heimdal 
  Heledia Helsinki Herning Hillerød Hordaland Hornbæk Hsinchu 
  Huldretråkket 

  Iasi Iskenderun Istanbul Ithaca Izmir

  Jagodina Jakarta Jalisco Jember Jessheim Jiamusi Jiangsu Jiangyou 
  Jianshe Jinchang Jincheng Jinjiang Jiujiang 

  Kadirli Kalisz Kalundborg Kalyani Kanpur Karlsruhe Kashi Kastamonu 
  Katowice Kayseri Kediri Kedungwaru Keelung Kesten Ketsch Kiel Kielce 
  Kiev Kirkeby Kirklarelý Kirsehir Klabat Kocaeli Kolbotn Kolkata Konya
  Kornik Kosice Kota Koycegiz Köln Krakow Kristiansand Kudus Kunshan 
  Kuopio Kusadasi Kütahya Kverndalen Kyustendil Kølabånn

  Langkat Lanzhou Lappeenranta Leiden Lerum Leszno Leuven Leverkusen 
  Lhokseumawe Lille Lima Lincoln Liushu Ljubljana Lodz Lokotok London 
  Lowicz Lublin Lucignano Luleburgaz Lumajang Lyon

  Maastricht Madrid Magetan Makassar Malang Malatya Malmö Manado 
  Manchester Manisa Mannheim Marbella Martapura Massy Medan Melbourne 
  Mersin Miaoli Michalovce Midyat Milan Milas Minsk Monticiano Montpellier 
  Moradabad Morud Muðla Mumbai Munich 

  Nagpur Nagykanizsa Namsos Nanchang Nancy Nanning Napoli Narita Narvik 
  Nashik Nazilli Näsby Nicosia Nijmegen Ningbo Niš Norrbyskär Norrøna 
  Nürnberg Nyon Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Olsztyn Orhangazi Oslo Ottadalen Otepää 
  Oxford Överum

  Padang Padova Paimado Palaiseau Palembang Palermo Palma Palu Pancevo 
  Panzhihua Pariaman Paris Pärnu Pattaya Pecs Pekanbaru Pelotas 
  Penajam Pernik Perth Perula Pesaro Pescara Petersfield Pisa Pleven 
  Plovdiv Pontianak Popovo Porto Potsdam Poznan Prague Pula Pune Puri

  Qingdao

  Radkov Rakvere Rayong Reims Riga Rijeka Rimini Rome 

  Ravnkilde Rzeszow Rødovre

  Saarbrücken Sabadell Sakarya Salerno Samarinda Samsun Sandefjord 
  Santiago Sanya Sarpsborg Secunderabad Seferihisar Semarang Serang 
  Shanghai Shaoguan Shenyang Shenzhen Shijiazhuang Sibiu Sidoarjo Siena 
  Sindi Singsås Skara Skien Skopje Slagelse Sleman Sofia Solok 
  Sortland Söke Split Stanford Stavanger Steinkjer Storsjöbygden Stureby 
  Stuttgart Sukma Sukomoro Sumedang Sunndalsøra Surabaya Suzhou Sydney 
  Szeged Sørreisa

  Taicang Taichung Tainan Taizhou Takayama Tallinn Targoviste Tarnów 
  Täby Täfteå Tekýrdag Temuco Thane Thanjavur Thessaloniki Tianjin 
  Timisoara Tire Tokyo Tomohon Torino Toulouse Trieste Trondheim Tromsø
  Tyoyuan

  Udaipur Uddevalla Umeå Uppsala Usak Utrecht

  Van Varberg Varese Varna Vasa Västervik Vestfold Vestvågøy 
  Vienna Vikersund Vilnius Vraca

  Waltham Warsaw Wellington Wisla Worcester Wroclaw Wuhan Wuxi

  Xinyi

  Yambol Yanshi Yarýmca Yatagan Yizhuang Yokohama Yogyakarta Yuquan

  Zagreb Zhaoqing Zhongshan Zhuzhou Zigong Zyrardow

  Ørland

  Åkirkeby Århus
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Akhisar => ['Akhýsar'],
  Allahabad => ['alahabad'],
  'Al-Rabwa' => ['rabwa'],
  Ankara => ['ancyra'],
  Antwerpen => ['antwerp'],
  Arendal => ['arendals'],
  Asenovec => ['asenovets'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Balisekir => ['balikesýr', 'balýkesir',],
  Bangalore => ["b'lore", 'banglore', 'bengalore'],
  Bansi => ["bansi's"],
  Beijing => ['peking'],
  Canakkale => ['çanakkale'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Copenhagen => ['kopenhagen'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Düsseldorf => ['duesseldorf'],
  'Gaziantep Zeugma' => ['zeugma'],
  Genoa => ['genova'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Heimdal => ['heimdalbc'],
  Hordaland => ['hordland'],
  Iskenderun => ['iskendurun'],
  Izmir => ['ýzmýr'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Jianshe => ['js'],
  Kalundborg => ['kallundborg'],
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta'],
  Kosice => ['cassovia'],
  Koycegiz => ['köyceðýz'],
  Krakow => ['kraków'],
  Kristiansand => ['kristiansands'],
  'Kuala Lumpur' => ['kl'],
  Kyustendil => ['kjustend'],
  'La Marina' => ['lamarina'],
  Langkat => ['lankat'],
  Lhokseumawe => ['lhoeksemawe'],
  Makassar => ['makasar'],
  Manado => ['menado'],
  Manahasa => ['mnhasa'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitravihar'],
  'Monte Carlo' => ['montecarlo'],
  Mumbai => ['mum'],
  Munich => ['münchen'],
  Nagpur => ['nagpor'],
  Nanchang => ['nancang'],
  Nashik => ['nasik'],
  Ningbo => ['ningpo'],
  Niš => ['niski'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olsztyn => ['olo'],
  Palembang => ['plg'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Petersfield => ['peterfield'],
  'Piatra Neamt' => ['neamt'],
  Potsdam => ['postdam'],
  Poznan => ['poz'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov', 'rxdkov'],
  'Reggio Emilia' => ['re'],
  Reykjavik => ['reykjavikur', 'reykjavitur'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  'Saint Petersburg' => ['spb'],
  Shenzhen => ['sz'],
  Singsås => ['singsaas'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Sunndalsøra => ['sunndalsora'],
  'Taipei City' => ['taipei'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Täfteå => ['taftea'],
  Tekýrdag => ['tekirdağ'],
  Thane => ['tane'],
  Thanjavur => ["tanjorian's"],
  Thessaloniki => ['salonica'],
  Tromsø => ['tromso', 'tromsoe'],
  Trondheim => ['trondhei'],
  Udaipir => ['udaypur'],
  'Udon Thani' => ['udonthani'],
  Vienna => ['wien'],
  Warsaw => ['warsow', 'warszawa'],
  Wroclaw => ['wr'],
  Yildirim => ['yýldýrým'],
  Yogyakarta => ['diy'],
  Zagreb => ['zgb', 'zg'],
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
