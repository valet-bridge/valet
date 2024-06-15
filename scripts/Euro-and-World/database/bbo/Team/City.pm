#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::City;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_city set_hashes);

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
  'Mar del Plata',
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
  'Rio de Janeiro',
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
  'Taihu Lake',
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
  Banjarmasin => ['ksa banjarmasin'],
  'City of Helsinki' => ['helsinki'],
  Delhi => ['new delhi'],
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
  'Monte Carlo' => ['monte-carlo'],
  Ningbo => ['ning bo'],
  'Piatra Neamt' => ['p. neamt', 'p.neamt'],
  Porto => ['cidade invicta'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Qingdao => ['qing dao'],
  Rome => ['città di roma'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  'São Paulo' => ['sao paulo', 's o paulo', 'sap paulo'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice'],
  Taicang => ['tai cang'],
  'Taihu Lake' => ['suzhou taihu'],
  Tainan => ['tai nan'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  'Vrnjacka Banja' => ['vrnjacka banja - al'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adana Adelaide Agresar Ahmedabad Airmadidi Akhisar 
  Alexandria Allahabad Altrincham Alytus Amanora Ambon Amman
  Amsterdam Ankara Annecy Antalya Antony Antwerpen Aral Arendal 
  Asenovec Asenovgrad Assis Atakum Athens Atlanta Auckland Ayacucho 
  Aydin Ayvalik

  Baghdad Balchik Balaton Balatonföldvár Balikesir Balikpapan Ballerup 
  Bamberg Bandung Bangalore Bangkok Banjarmasin Bansi Barcelona Batam 
  Bath Batu Begues Beijing Bekasi Belgrade Bengkulu Beograd 
  Bereket Bergen Bergues Berkeley Berlin Bhilwara Bhubaneshwar Biarritz 
  Bielefeld Bikaner Bitung Blitar Bodrum Bodø Bogor Bogotá Boleslawiec
  Bologna Bonn Bordeaux Braila Brandbu Brasilia Brasov Bremen Brighton
  Brisbane Bromölla Bruges Brussels Bucharest Budapest Burghausen 
  Bursa Burdur Bydgoszcz

  Caen Cairns Cairo Canakkale Canberra Canterbury Caracas Casablanca
  Cascais Catania Cerkezkoy Cesme Changhua Changzhou Chaville Chelmno 
  Chengdu Chennai Chepelare Chiayi Chicago Chongqing Chumphon Clichy 
  Cluj Copenhagen Corlu Coventry Cuenca Cuneo

  Dalian Darmstadt Datca Deauville Delft Delhi Denizli Depok Derpt 
  Diyarbakir Dimitrovgrad Dobrich Dombivli Dongguan Durban Düsseldorf

  Eastbourne Edinburgh Edirne Elblag Esbjerg Eskisehir Essen Estoril
  Evanston

  Farsund Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt Fredrikstad
  Freidorf 

  Gdansk Gdynia Gelibolu Genoa Gent Gevgelija Geyve Glasgow Gnesta 
  Gniezno Gorzow Gölcük Göteborg Gresik Guangzhou Guayaquil 
  Gudbrandsdal Gyor

  Haderslev Hamar Hamburg Hammamet Hangzhou Hannover Harplinge Hatay 
  Heledia Helsinki Hendek Herning Hillerød Hordaland Hornbæk Hsinchu 
  Huldretråkket Hyderabad

  Iasi Indore Iskenderun Istanbul Ithaca Izmir

  Jagodina Jaipur Jakarta Jalisco Jember Jessheim Jiamusi Jiangsu 
  Jiangyou Jianshe Jinchang Jincheng Jinjiang Jiujiang 

  Kadirli Kalisz Kalundborg Kalyani Kanpur Karimun Karlsruhe Kashi 
  Kastamonu Katowice Kayseri Kediri Kedungwaru Keelung Kesten Ketsch 
  Kiel Kielce Kiev Kirkeby Kirklarelý Kirsehir Klabat Kocaeli Kolbotn 
  Kolkata Konya Kornik Kosice Kota Koycegiz Köln Krakow Kristiansand 
  Kudus Kunshan Kuopio Kusadasi Kütahya Kverndalen Kyustendil Kølabånn

  Langkat Lanzhou Lappeenranta Leiden Lerum Leszno Leuven Leverkusen 
  Lhokseumawe Liepaja Lille Lima Lincoln Linköping Lisbon Liushu 
  Ljubljana Lodz Lojdy Lokotok London Lowicz Lublin Luleburgaz Lumajang 
  Lyon

  Maastricht Madrid Madras Magetan Makassar Malang Malatya Malmö Manado 
  Manchester Manisa Mannheim Marbella Mardin Marrakech Martapura Massy 
  Mautern Medan Medellin Melbourne Mersin Miaoli Michalovce Midyat 
  Milan Milas Minsk Monticiano Montpellier Moradabad Morud Muðla 
  Mulund Mumbai Munich 

  Nagpur Nagykanizsa Namsos Nanchang Nancy Nanning Napoli Narvik 
  Nashik Nazilli Näsby Nicosia Nijmegen Ningbo Niš Noida Norrbyskär 
  Norrøna Nürnberg Nyon Nysa Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Olrud Olsztyn Opatija Orhangazi Oslo Ostend
  Ottadalen Otepää Oxford Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pancevo 
  Panzhihua Pariaman Paris Pärnu Pattaya Pau Pecs Pekanbaru Pelotas 
  Penajam Pernik Perth Perula Pesaro Pescara Petersfield Philadelphia
  Pisa Pleven Plovdiv Pontianak Popovo Porto Potsdam Poznan Prague 
  Pula Pulawy Pune Puri Pushkar

  Qingdao

  Radkov Rakvere Rayong Reims Riga Rijeka Rimini Rome 

  Ravnkilde Reykjavik Rzeszow Rødovre

  Saarbrücken Sabadell Salerno Samarinda Samobor Samsun Sandefjord 
  Santiago Sanya Sarpsborg Secunderabad Seferihisar Semarang Serang 
  Shanghai Shaoguan Shenyang Shenzhen Shijiazhuang Shumen Sibiu Sidoarjo 
  Siena Sindi Singsås Siofok Skara Skien Skopje Slagelse Slawa Sleman 
  Snåsa Sofia Solok Sopot Sortland Söke Split Stanford Stavanger 
  Steinkjer Stockholm Storsjöbygden Stureby Stuttgart Sukma Sukomoro 
  Sumedang Sunndalsøra Surabaya Suzhou Sydney Szczyrk Szeged Sørreisa

  Taicang Taichung Tainan Taizhou Takayama Tallinn Tarakan Targoviste 
  Tarnów Täby Täfteå Tekýrdag Temuco Thane Thanjavur Thessaloniki Tianjin 
  Timisoara Tire Tofta Tokyo Tomohon Torino Toulouse Trieste Trondheim 
  Tromsø Tyoyuan

  Udaipur Uddevalla Umeå Uppsala Usak Utrecht

  Van Varanasi Varberg Varese Varna Vasa Västervik Verona Vestfold 
  Vestvågøy Vienna Vikersund Vilnius Vraca

  Waltham Warsaw Wellington Wisla Worcester Wroclaw Wronie Wuhan Wuxi

  Xian Xiantao Xinyi

  Yambol Yanshi Yarýmca Yatagan Yizhuang Yokohama Yogyakarta Yuquan

  Zagreb Zhaoqing Zhongshan Zhuzhou Zigong Zürich Zyrardow

  Ørland

  Åkirkeby Århus
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Ahmedabad => ['ahemadabad'],
  Akhisar => ['Akhýsar'],
  Allahabad => ['alahabad'],
  'Al-Rabwa' => ['rabwa'],
  Ankara => ['ancyra'],
  Antwerpen => ['antwerp'],
  Arendal => ['arendals'],
  Asenovec => ['asenovets'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Balatonföldvár => ['balatonfoldvar'],
  Balisekir => ['balikesýr', 'balýkesir',],
  Bangalore => ["b'lore", 'banglore', 'bengalore', 'bangaluru',
    'benglore', 'bengluru', 'bengalu'],
  Bansi => ["bansi's"],
  Beijing => ['peking', 'pekin', 'pékin', 'bijing'],
  Canakkale => ['çanakkale'],
  Canberra => ['canbera'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Copenhagen => ['kopenhagen'],
  Deauville => ['deauille'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Düsseldorf => ['duesseldorf'],
  Estoril => ['estoral'],
  Fredrikstad => ['ftrediklstad'],
  'Gaziantep Zeugma' => ['zeugma'],
  Gdansk => ['gdañsk'],
  Genoa => ['genova'],
  Göteborg => ['goteborg', 'gothenburg'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Hordaland => ['hordland'],
  Indore => ['indor'],
  Iskenderun => ['iskendurun'],
  Izmir => ['ýzmýr', 'izmýr'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Jianshe => ['js'],
  Kalundborg => ['kallundborg'],
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta', 'kolkta', 'kolktata'],
  Kosice => ['cassovia'],
  Koycegiz => ['köyceðýz'],
  Krakow => ['kraków', 'cracow'],
  Kristiansand => ['kristiansands'],
  'Kuala Lumpur' => ['kl'],
  Kyustendil => ['kjustend'],
  'La Marina' => ['lamarina'],
  Langkat => ['lankat'],
  Lhokseumawe => ['lhoeksemawe'],
  Linköping => ['linkoping'],
  Makassar => ['makasar'],
  Malmö => ['malmo', 'malmoe'],
  Manado => ['menado'],
  Manahasa => ['mnhasa'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitravihar'],
  'Monte Carlo' => ['montecarlo'],
  Mumbai => ['mum', 'bombay', 'bomay'],
  Munich => ['münchen'],
  Nagpur => ['nagpor'],
  Nanchang => ['nancang'],
  Nashik => ['nasik'],
  Ningbo => ['ningpo'],
  Niš => ['niski'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olsztyn => ['olo'],
  Ostend => ['ostende'],
  Palembang => ['plg'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Pau => ['puau'],
  Petersfield => ['peterfield'],
  'Piatra Neamt' => ['neamt'],
  Porto => ['invicta', 'oporto'],
  Potsdam => ['postdam'],
  Poznan => ['poz'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov', 'rxdkov'],
  'Reggio Emilia' => ['re'],
  Reykjavik => ['reykjavikur', 'reykjavitur', 'reykavik'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  'Saint Petersburg' => ['spb'],
  Shenzhen => ['sz'],
  Singsås => ['singsaas'],
  Slawa => ['s£awa', 's³awa'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Stockholm => ['stockholms'],
  Sunndalsøra => ['sunndalsora'],
  'Taipei City' => ['taipei'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Täfteå => ['taftea'],
  Tekýrdag => ['tekirdağ'],
  Thane => ['tane'],
  Thanjavur => ["tanjorian's"],
  'The Hague' => ['hague'],
  Thessaloniki => ['salonica'],
  Tromsø => ['tromso', 'tromsoe'],
  Trondheim => ['trondhei'],
  Udaipir => ['udaypur'],
  'Udon Thani' => ['udonthani'],
  Varanasi => ['baranasi'],
  Verona => ['veron'],
  Vienna => ['wien'],
  Warsaw => ['warsow', 'warszawa', 'warszawy'],
  Wroclaw => ['wr'],
  Yildirim => ['yýldýrým'],
  Yogyakarta => ['diy'],
  Zagreb => ['zgb', 'zg'],
  Zürich => ['zurich'],
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


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
