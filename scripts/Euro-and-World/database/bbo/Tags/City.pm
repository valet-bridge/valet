#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::City;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Aix en Provence',
  'Al-Rabwa',
  'Banda Aceh',
  'Bandar Lampung',
  'Belo Horizonte',
  'Bielsko-Biala',
  'Buenos Aires',
  'Boven Digoel',
  'Chapel Hill',
  'Courseulles-sur-Mer',
  'Czech-Pan',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Greve Strand',
  'Indonesia-Pan',
  'Kansas City',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'La Chaux-de-Fonds',
  'La Marina',
  'La Spezia',
  'Las Palmas',
  'Le Bouscat',
  'Mandobo Bodi',
  'Mar del Plata',
  'Meilin Qingcheng',
  'Mitra Vihar',
  'Mo i Rana',
  'Monte Carlo',
  'Muara Bungo',
  'Nea Moudania',
  'New Taipei City',
  'New York City',
  'Nové Město',
  'Novi Sad',
  'Piatra Neamt',
  'Reggio Calabria',
  'Reggio Emilia',
  'Rio de Janeiro',
  'Russia-Pan',
  'Saint Petersburg',
  'San Giorgio del Sannio',
  'San Luis',
  'São Paulo',
  'Schwäbisch Hall',
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
  'Tel Aviv',
  'The Hague',
  'Udon Thani',
  'Urbana-Champaign',
  'Val de Seine',
  'Villa Fabbriche',
  'Vrnjacka Banja',
  'Xin Zhu',
  'Yedi Eylul',
  'Zhong Jian'
);

my %MULTI_TYPOS =
(
  Akhisar => ['akhisar belediyesi'],
  'Al-Rabwa' => ['rl-rabwa'],
  Banjarmasin => ['ksa banjarmasin'],
  Helsinki => ['city of helsinki'],
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
  'Nea Moudania' => ['moydania'],
  Ningbo => ['ning bo'],
  'Piatra Neamt' => ['p. neamt', 'p.neamt'],
  Porto => ['cidade invicta'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Qingdao => ['qing dao'],
  Rome => ['città di roma'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  'São Paulo' => ['sao paulo'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice'],
  Taicang => ['tai cang'],
  'Taihu Lake' => ['suzhou taihu'],
  Tainan => ['tai nan'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  'Vrnjacka Banja' => ['vrnjacka banja - al'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta', 'd i yogyakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aachen Aalborg Adalar Adana Adapazan Adelaide Agresar 
  Ahmedabad Airmadidi Akhisar Aladag Alexandria Allahabad Altrincham 
  Alytus Ambon Amman Amsterdam Ankara Annecy Antalya Antony Antwerpen 
  Aral Arendal Asenovec Asenovgrad Assis Atakum Athens Atlanta 
  Auckland Augsburg Ayacucho Aydin Ayvalik

  Baghdad Balchik Balaton Balatonföldvár Balikesir Balikpapan Ballerup 
  Ballymena Bamberg Bandung Bangalore Bangkok Banjarmasin Bansi Barcelona 
  Batam Bath Batman Batu Begues Beijing Beirut Belgrade Bengkalis
  Bengkulu Beograd Bereket Bergen Bergues Berkeley Berlin Bhilwara 
  Bhubaneshwar Biarritz Bielefeld Bikaner Bitung Blitar Bodrum Bodø 
  Bogor Bogotá Boleslawiec Bologna Bonn Bordeaux Braila Brandbu 
  Brasilia Brasov Bremen Brighton Brisbane Bromölla Bruges Brussels 
  Bucharest Budapest Burghausen Bursa Burdur Buzios Bydgoszcz Bytom

  Caen Cairns Cairo Canakkale Canberra Cannareggio Canterbury Caracas 
  Casablanca Cascais Catania Cerkezkoy Cesme Changhua Changzhou 
  Chaville Chelmno Chengdu Chennai Chepelare Chiayi Chicago 
  Chongqing Chumphon Cimahi Cirebon Clichy Cluj Copenhagen Corlu 
  Coventry Cuenca Cuneo

  Dalian Darmstadt Datca Deauville Debrecen Delft Delhi Denizli Depok 
  Derpt Diyarbakir Dimitrovgrad Dobrich Doha Dombivli Dongguan Drammen 
  Durban Düsseldorf

  Eastbourne Edinburgh Edirne Elblag Enschede Erzurum Esbjerg 
  Eskisehir Essen Estoril Evanston

  Farsund Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt 
  Fredrikstad Førde

  Garches Gdansk Gdynia Gelibolu Genoa Gent Gevgelija Geyve Giza Glasgow 
  Gnesta Gniezno Gorzow Gölcük Göteborg Gresik Groningen Guangzhou 
  Guayaquil Gudbrandsdal Gyor

  Haderslev Hamar Hamburg Hammamet Hangzhou Hanko Hannover Harplinge 
  Harstad Hatay Havirov Heledia Helsinki Hendek Herning Hillerød 
  Hornbæk Hsinchu Huldretråkket Hyderabad

  Iasi Indore Iskenderun Isparta Istanbul Ithaca Izmir

  Jagodina Jaipur Jakarta Jember Jessheim Jiamusi Jiangsu 
  Jiangyou Jianshe Jinchang Jincheng Jinjiang Jiujiang 

  Kadirli Kalisz Kalundborg Kalyani Kanpur Kaohsiung Karimun Karlovo 
  Karlsruhe Karsiyaka Kashi Kastamonu Katowice Kayseri Kediri 
  Kedungwaru Keelung Kesten Ketsch Kiel Kielce Kiev Kirkeby 
  Kirklarelý Kirsehir Klabat Kocaeli Kolbotn Kolkata Konya Kornik 
  Kosice Kota Koycegiz Köln Krakow Kristiansand Kudus Kunshan 
  Kuopio Kusadasi Kütahya Kverndalen Kyustendil Kølabånn

  Langkat Lanzhou Lappeenranta Lecco Leiden Leksand Lerum Leszno Leuven 
  Leverkusen Lhokseumawe Liepaja Lille Lima Lincoln Lindesberg
  Linköping Lisbon Liushu Ljubljana Lodi Lodz Lojdy Lokotok Lom
  London Lowicz Lublin Luleburgaz Lumajang Lyon

  Maastricht Madrid Magetan Makassar Malang Malatya Malmö Manado 
  Manchester Manisa Manna Mannheim Marbella Mardin Marrakech Marseille 
  Martapura Massy Mautern Medan Medellin Melbourne Mersin Miaoli 
  Michalovce Midyat Milan Milas Minsk Miskolc Monticiano Montpellier 
  Moradabad Morud Moscow Moss Mragowo Muðla Mulund Mumbai Munich 

  Nagpur Nagykanizsa Namsos Nanchang Nanchong Nancy Nanning Napoli 
  Narvik Nashik Nazilli Näsby Nice Nicosia Nijmegen Nilüfer Ningbo 
  Niš Noida Norrbyskär Norrøna Nürnberg Nyon Nysa Nærbø Næstved 
  Nøtterøy

  Odense Ogndal Oldenburg Olrud Olsztyn Oltenita Opatija Orhangazi 
  Oslo Ostend Ottadalen Otepää Oxford Ozarow Örebro Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale Pancevo 
  Panzhihua Pariaman Paris Pärnu Pattaya Pau Pecs Pekanbaru Pelotas 
  Penajam Pernik Perth Perula Pesaro Pescara Petersfield Philadelphia
  Pisa Pleven Plovdiv Pontianak Popovo Porto Potsdam Poznan Prague 
  Preslav Pula Pulawy Pune Puri Pushkar

  Qingdao

  Radkov Rakvere Ravnkilde Rayong Reims Rennes Reykjavik Rieneck 
  Riga Rijeka Rimini Romana Rome Rotterdam Rzeszow Rødovre

  Saarbrücken Sabadell Salerno Samarinda Samobor Samsun Sandefjord 
  Santiago Sanya Sarpsborg Secunderabad Seferihisar Semarang Senigallia
  Serang Shanghai Shaoguan Sharjah Shenyang Shenzhen Shijiazhuang Shumen 
  Sibiu Sidoarjo Siena Sindi Singsås Siofok Sivas Skara Skawina Ski Skien 
  Skopje Slagelse Slawa Sleman Snåsa Sofia Solok Sopot Sortland 
  Söke Split Stanford Stavanger Steinkjer Stockholm Stoholm 
  Storsjöbygden Stureby Stuttgart Sukma Sukomoro Sumedang 
  Sunndalsøra Surabaya Suzhou Sydney Szczyrk Szeged Søborg Sørreisa

  Taicang Taichung Tainan Taizhou Takayama Tallinn Tambun Tarakan 
  Targoviste Tarnów Täby Täfteå Tekýrdag Temuco Thane Thanjavur 
  Thessaloniki Tianjin Timisoara Tire Tofta Tokyo Tomohon Tonya
  Torino Toulouse Tours Trieste Trondheim Tromsø Taoyuan

  Udaipur Uddevalla Umeå Uppsala Usak Utrecht

  Van Vancouver Varanasi Varberg Varese Varna Vasa Västervik Västerås
  Vejle Venice Verona Vestfold Vestvågøy Vienna Vikersund Vilnius 
  Vorden Vraca

  Waltham Warsaw Wellington Wisla Worcester Wroclaw Wronie Wuhan Wuxi

  Xian Xiantao Xinyi

  Yambol Yanshi Yarýmca Yatagan Yizhuang Yokohama Yogyakarta Yuquan

  Zagreb Zhaoqing Zhongshan Zhuzhou Zigong Zürich Zyrardow

  Ørland Østerdal

  Åkirkeby Ålesund Århus Åsane
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
  Balikesir => ['balikesýr', 'balýkesir'],
  Bangalore => ["b'lore", 'banglore', 'bengalore', 'bangaluru',
    'benglore', 'bengluru', 'bengalu', 'bengaluru'],
  Bansi => ["bansi's"],
  Barcelona => ['bcn'],
  Beijing => ['peking', 'pekin', 'pékin', 'bijing'],
  Buzios => ['bruzios'],
  Canakkale => ['çanakkale'],
  Canberra => ['canbera'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Chennai => ['madras'],
  Copenhagen => ['kopenhagen'],
  Deauville => ['deauille'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Düsseldorf => ['duesseldorf'],
  Estoril => ['estoral'],
  'Gaziantep Zeugma' => ['zeugma'],
  Gdansk => ['gdañsk'],
  Genoa => ['genova'],
  Göteborg => ['goteborg', 'gothenburg'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Indore => ['indor'],
  Iskenderun => ['iskendurun'],
  Izmir => ['ýzmýr', 'izmýr', 'ýzmir'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Jianshe => ['js'],
  Kalundborg => ['kallundborg'],
  Karsiyaka => ['Karþiyaka'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta', 'kolkta', 'kolktata', 'kol'],
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
  Luleburgaz => ['lüleburgaz'],
  Makassar => ['makasar'],
  Malmö => ['malmo', 'malmoe'],
  Manado => ['menado'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitravihar'],
  'Monte Carlo' => ['montecarlo'],
  Mumbai => ['mum', 'bombay'],
  Munich => ['münchen'],
  Nagpur => ['nagpor'],
  Nanchang => ['nancang'],
  Napoli => ['naples'],
  Nashik => ['nasik'],
  Ningbo => ['ningpo'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olsztyn => ['olo'],
  Ostend => ['ostende'],
  Ozarow => ['ożarów'],
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
  Radkov => ['radkow', 'kadkov', 'rxdkov', 'tadkov'],
  'Reggio Emilia' => ['re'],
  Reykjavik => ['reykjavikur', 'reykjavitur', 'reykavik'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  'Saint Petersburg' => ['spb'],
  Samsun => ['amisos'],
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
  Udaipur => ['udaypur'],
  'Udon Thani' => ['udonthani'],
  Varanasi => ['baranasi'],
  Verona => ['veron'],
  Vienna => ['wien'],
  Warsaw => ['warsow', 'warszawa'],
  Wroclaw => ['wr'],
  Yogyakarta => ['diy'],
  Zagreb => ['zgb', 'zg'],
  Zürich => ['zurich'],
  'Zhong Jian' => ['zhongjian'],
  Åkirkeby => ['aakirkeby'],
  Århus => ['aarhus', 'arhus']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
