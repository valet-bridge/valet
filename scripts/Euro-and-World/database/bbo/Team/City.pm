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
  'Boven Digoel',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
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
  'Novi Sad',
  'Piatra Neamt',
  'Reggio Emilia',
  'Saint Petersburg',
  'San Giorgio del Sannio',
  'Semburat Jingga',
  'Seulawah Agam',
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
  Aabenraa Aalborg Adana Adelaide Agresar Ahmedabad Akhisar 
  Alexandria Allahabad Altrincham Alytus Amanora Amarillo Ambon 
  Amsterdam Ankara Annecy Antalya Antony Antwerpen Aral Arendal 
  Asenovgrad Assis Atakum Athens Auckland Ayacucho Ayvalik

  Balikesir Balikpapan Ballerup Bamberg Bandung Bangalore Bangkok 
  Banjarmasin Bansi Barcelona Batam Bath Batu Begues Beijing Bekasi 
  Belgrade Bengkulu Beograd Bereket Bergen Bergues Berlin Bhilwara
  Bhubaneshwar Bielefeld Bikaner Bitung Blitar Bodrum Bodø Bogor 
  Bologna Bonn Bordeaux Braila Brandbu Brasilia Brasov Bremen Brisbane 
  Bromölla Bucharest Budapest Burghausen Bursa Burdur 

  Caen Cairns Canberra Canterbury Caracas Cascais Catania Cerkezkoy 
  Cesme Changzhou Chaville Chelmno Chengdu Chennai Chicago Chongqing 
  Chumphon Clichy Cluj Copenhagen Corlu Coventry Cuenca Cuneo

  Dalian Darmstadt Datca Delft Delhi Denizli Derpt Diyarbakir 
  Dimitrovgrad Dobrich Dombivli Dongguan Düsseldorf

  Eastbourne Edirne Elblag Esbjerg Eskisehir Essen 

  Farsund Fethiye Firenze Flekkefjord Foca Frankfurt Freidorf 

  Gdansk Gdynia Genoa Gent Geyve Gnesta Gorzow Gölcük Gresik 
  Guangzhou Guayaquil Gudbrandsdal Gyor

  Haderslev Hamburg Hangzhou Hannover Harplinge Heimdal Heledia 
  Helsinki Herning Hillerød Hornbæk Huldretråkket 

  Iasi Iskenderun Istanbul Izmir

  Jagodina Jakarta Jember Jessheim Jiamusi Jianshe Jiangyou 
  Jinchang Jincheng Jinjiang Jiujiang 

  Kadirli Kalisz Kalundborg Kalyani Kanpur Karlsruhe Kashi Kastamonu 
  Katowice Kediri Kesten Ketsch Kiel Kielce Kiev Kirkeby Kirklarelý 
  Klabat Kocaeli Kolbotn Kolkata Kornik Kosice Koycegiz Köln Krakow 
  Kristiansand Kudus Kunshan Kuopio Kusadasi Kütahya Kverndalen
  Kyustendil Kølabånn

  Langkat Lanzhou Leiden Lerum Leszno Leuven Leverkusen Lhokseumawe 
  Lille Lima Lincoln Liushu Ljubljana Lodz Lokotok London Lowicz 
  Lucignano Luleburgaz 

  Maastricht Madrid Makassar Malatya Malmö Manado Manchester Manisa 
  Mannheim Marbella Martapura Massy Medan Melbourne Mersin Michalovce 
  Midyat Milan Milas Minsk Montpellier Moradabad Morud Muðla 
  Mumbai Munich 

  Nagpur Nagykanizsa Namsos Nanchang Nanning Napoli Narita Narvik 
  Nashik Nazilli Näsby Nijmegen Ningbo Norrbyskär Norrøna Nürnberg 
  Nyon Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Olsztyn Orhangazi Oslo Ottadalen Otepää 
  Oxford Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pancevo 
  Panzhihua Pariaman Paris Pärnu Pattaya Pecs Pekanbaru Pelotas 
  Penajam Pernik Perth Perula Pesaro Pescara Petersfield Pisa Pleven 
  Plovdiv Pontianak Popovo Potsdam Poznan Prague Pula Pune Puri

  Qingdao

  Radkov Rakvere Rayong Reims Riga Rijeka Rimini Rome 

  Ravnkilde Rzeszow Rødovre

  Saarbrücken Sakarya Salerno Samarinda Samsun Sandefjord Santiago 
  Sanya Sarpsborg Secunderabad Seferihisar Semarang Serang Shanghai 
  Shaoguan Shenyang Shenzhen Shijiazhuang Sibiu Sidoarjo Siena Sindi 
  Singsås Skara Skawina Skien Skopje Slagelse Sleman Sofia Solok 
  Sortland Söke Split Stavanger Steinkjer Storsjöbygden Stureby 
  Stuttgart Sukma Sunndalsøra Surabaya Suzhou Sydney Szeged Sørreisa

  Taicang Tainan Taizhou Takayama Tallinn Targoviste Tarnów Täby 
  Täfteå Tekýrdag Temuco Thane Thanjavur Thessaloniki Tianjin Timisoara 
  Tire Tokyo Tomohon Torino Toulouse Trieste Trondheim Tromsø

  Udaipur Uppsala Usak Utrecht

  Van Varbergshus Varese Varna Vasa Västervik Vestfold Vestvågøy 
  Vienna Vikersund Vilnius Vraca

  Xinyi

  Warsaw Wellington Wisla Worcester Wroclaw Wuhan

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
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Balisekir => ['balikesýr', 'balýkesir',],
  Bangalore => ["b'lore", 'banglore', 'bengalore'],
  Bansi => ["bansi's"],
  Beijing => ['peking'],
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
  Skawina => ['skawia'],
  Singsås => ['singsaas'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Sunndalsøra => ['sunndalsora'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Täfteå => ['taftea'],
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
