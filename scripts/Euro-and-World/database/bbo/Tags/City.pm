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
  'Alba Iulia',
  'Bad Griesbach',
  'Banda Aceh',
  'Bandar Lampung',
  'Banora Point',
  'Belo Horizonte',
  'Bielsko-Biala',
  'Buenos Aires',
  'Boven Digoel',
  'Chapel Hill',
  'Courseulles-sur-Mer',
  'Cherven Briag',
  'Czech-Pan',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Gold Coast',
  'Greve Strand',
  'Haskovski Mineralni Bani',
  'Hong Kong City',
  'Indonesia-Pan',
  'Kansas City',
  'Khan Yunis',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'La Baule-Escoublac',
  'La Chaux-de-Fonds',
  'La Marina',
  'La Spezia',
  'Las Palmas',
  'Las Vegas',
  'Le Bouscat',
  'Mandobo Bodi',
  'Mar del Plata',
  'Meilin Qingcheng',
  'Mian Yang',
  'Miercurea Ciuc',
  'Mitra Vihar',
  'Mo i Rana',
  'Monte Carlo',
  'Muara Bungo',
  'Nea Moudania',
  'New Taipei City',
  'New York City',
  'Nové Město',
  'Novi Sad',
  'Palangka Raya',
  'Piatra Neamt',
  'Piggs Peak',
  'Reggio Calabria',
  'Reggio Emilia',
  'Rio de Janeiro',
  'Russia-Pan',
  "'s-Hertogenbosch",
  'Saint Petersburg',
  'Salt Lake City',
  'San Giorgio del Sannio',
  'San Luis',
  'San Marino City',
  'San Servolo',
  'São Paulo',
  'Schwäbisch Hall',
  'Seine-et-Marne',
  'Semburat Jingga',
  'Seulawah Agam',
  'Siddha Eden Lakeville',
  'Silesia Gliwice',
  'Singapore City',
  'South Tangerang',
  'St Louis',
  'Stara Zagora',
  'Taihu Lake',
  'Tanjung Pinang',
  'Taipei City',
  'Tel Aviv',
  'The Hague',
  'Tweed Heads',
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
  'Miercurea Ciuc' => ['m ciuc', 'm. ciuc'],
  Milas => ['milas beledýyesi', 'mýlas beledýyespor'],
  'Monte Carlo' => ['monte-carlo'],
  'Nea Moudania' => ['moydania'],
  Ningbo => ['ning bo'],
  Pasuruan => ['kota pasuruan'],
  'Piatra Neamt' => ['p. neamt', 'p.neamt'],
  Porto => ['cidade invicta'],
  Probolinggo => ['kota probolinggo'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Qingdao => ['qing dao'],
  Rome => ['città di roma'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  'São Paulo' => ['sao paulo'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice', 'silesia i gliwice'],
  Taicang => ['tai cang'],
  'Taihu Lake' => ['suzhou taihu'],
  Tainan => ['tai nan'],
  Tasikmalaya => ['kota tasikmalaya'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  'Vrnjacka Banja' => ['vrnjacka banja - al'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta', 'd i yogyakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aachen Aalborg Adalar Adana Adapazan Adelaide Agresar 
  Ahmedabad Airmadidi Akhisar Aladag Alcobaça Alexandria Aliaga 
  Allahabad Alta Altinova Altrincham Alytus Ambon Amman Amsterdam 
  Ankara Annecy Antalya Antony Antwerpen Aqaba Aral Arendal 
  Asenovec Asenovgrad Askim Asminderød Assis Atakum Atasehir 
  Athens Atlanta Auckland Augsburg Ayacucho Aydin Ayvalik

  Babaeski Baghdad Balchik Balaton Balatonföldvár Balikesir Balikpapan 
  Ballerup Ballymena Bamberg Bandung Bangalore Bangkok Banjarmasin 
  Bansi Barcelona Barlinek Batam Bath Batikent Batman Batu Begues 
  Beijing Beirut Bekasi Belgrade Belfast
  Bengkalis Bengkulu Beograd Bereket Bergen Bergues Berkeley Berlin 
  Bhilwara Bhubaneshwar Biarritz Bielefeld Bikaner Bitung Blitar Bodrum 
  Bodø Bogor Bogotá Boleslawiec Bologna Bonn Bordeaux Böblingen 
  Braila Brandbu Brasilia Brasov Bremen Brevik Brighton Brisbane 
  Broadbeach Bromölla Bruges Brussels Bucharest Budapest Burghausen 
  Bursa Burdur Buzios Bydgoszcz Bytom

  Caen Cairns Cairo Canakkale Canberra Cankaya Cannareggio Canterbury 
  Caracas Casablanca Cascais Catania Cerkezkoy Cesme Changhua Changzhou 
  Chaville Chelmno Chelopech Chengdu Chennai Chepelare Chiayi Chicago 
  Chongqing Chumphon Cimahi Cirebon Claremont Clichy Cluj Coimbra
  Copenhagen Corlu Coventry Craiova Cuenca Cuneo

  Dabrowka Dalaman Dalian Darmstadt Datca Deauville Debrecen Delft 
  Delhi Denizli Depok Derpt Deva Devrek Diyarbakir Dimitrovgrad 
  Dobrich Doha Dombivli Dongguan Dortmund Dörtyol Drammen Dubai 
  Dubrovnik Durban Düsseldorf

  Eastbourne Edinburgh Edirne Elblag Elmadag Enschede Eregli 
  Ergene Erzurum Esbjerg Eskisehir Essen Estoril Evanston

  Farsund Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt 
  Fredrikstad Freiburg Fritzlar Fuzhou Førde

  Galway Garches Gdansk Gdynia Gelibolu Genoa Gent Gevgelija Geyve 
  Giresun Giza Glasgow Gnesta Gniezno Gorzow Gölcük Göteborg Gresik 
  Grogol Groningen Guangdong Guangzhou Guayaquil Gudbrandsdal 
  Gümüşlük Gyor

  Haderslev Haikou Hamar Hamburg Hammamet Hangzhou Hanko Hannover 
  Harplinge 
  Harstad Hatay Havirov Hedemora Heikendorf Heledia Helsinki Hendek 
  Herning Hillerød Hobro Hornbæk Hsinchu Huldretråkket Hyderabad

  Iasi Indore Iskenderun Isparta Istanbul Ithaca Izmir

  Jagodina Jaipur Jakarta Jember Jessheim Jiamusi Jiangsu 
  Jiangyou Jianshe Jinchang Jincheng Jinjiang Jiujiang  Jixiexiang
  Jurmala

  Kadirli Kaisei Kalisz Kalundborg Kalyani Kanpur Kaohsiung Karimun 
  Karlovo Karlsruhe Karsiyaka Kashi Kassel Kastamonu Katowice 
  Kayseri Kediri Kedungwaru Keelung Kemalpasa Kesten Ketsch Kiel 
  Kielce Kiev Kinali Kirkeby Kirklarelý Kirsehir Klabat Klepp 
  Kleve Kocaeli Kolbotn Kolkata Konga Konya Kópavogur Korfez 
  Kornik Kosice Kota Koycegiz Köln Kragerø Krakow Kraljevica 
  Kristiansand Kudus Kunshan Kutno Kuopio Kusadasi Kütahya 
  Kverndalen Kyoto Kyustendil Køge Kølabånn

  Langkat Lanzhou Laodikya Lappeenranta Larnaca Larvik Lecco 
  Leiden Leipzig Leksand 
  Lerum Leszno Leuven Leverkusen Lhokseumawe Liepaja Lille Lima 
  Lincoln Lindesberg Linköping Lisbon Liushu Ljubljana Lodi Lodz 
  Lojdy Lokotok Lom London Lowicz Lublin Lufeng Luleburgaz Lumajang 
  Lyon

  Maastricht Madrid Magetan Makassar Malang Malatya Malmö Manado 
  Manchester Manisa Manna Mannheim Marbella Mardin Marijampolė 
  Marrakech Marseille 
  Martapura Massy Mautern Medan Medellin Melbourne Mersin Miaoli 
  Michalovce Midyat Milan Milas Minsk Miskolc Monticiano Montpellier 
  Moradabad Morud Moscow Moss Mragowo Mudanya Muðla Mulund 
  Mumbai Munich 

  Nagari Nagpur Nagykanizsa Namsos Nanchang Nanchong Nancy Nanning 
  Napoli Narlidere Narvik Nashik Nazilli Näsby Newport Nice 
  Nicosia Niedernhausen Nijmegen Nilüfer Ningbo Niš Noida 
  Norrbyskär Norrøna Nürnberg Nyon Nysa Nærbø Næstved Nøtterøy

  Odense Ogndal Oldenburg Olrud Olsztyn Oltenita Opatija Ordu
  Orhangazi Osaka Ostend Oslo Osnabrück Ottadalen Otepää Oxford 
  Ozarow Örebro Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale Pancevo 
  Panzhihua Pariaman Paris Pärnu Pasuruan Pattaya Pau Pecs Peebles 
  Pekanbaru Pelotas Penajam Pernik Perth Perula Pesaro Pescara 
  Petersfield Philadelphia Pisa Pittsburgh Pleven Plock Plovdiv 
  Pontianak Popovo Porto Potsdam Poznan Prague Preslav Probolinggo 
  Protaras Ptuj Pula Pulawy Pune Puri Pushkar Puutalo

  Qingdao

  Radkov Rakvere Rastignano Ravnkilde Rayong Reims Rennes Reykjavik 
  Riau Rieneck Riga Rijeka Rimini Romana Rome Roskilde Rotterdam 
  Rottneros Rubbestadneset Rzeszow Rødovre

  Saarbrücken Sabadell Salerno Salo Salsomaggiore Samarinda Samobor 
  Samsun Sandefjord Santiago Sanya Sariyer Sarpsborg Sawahlunto
  Secunderabad 
  Seferihisar Semarang Sendai Senigallia Serang Shanghai Shangrao 
  Shaoguan Sharjah Shenyang Shenzhen Shijiazhuang Shumen Sibiu 
  Sidoarjo Siena Sigulda Silifke Sindi Singsås Siofok 
  Sivas Skara Skawina 
  Ski Skien Skopje Slagelse Slawa Sleman Smedstad Smolyan Snåsa 
  Sofia Solok Sopot Sortland Söke Split Stanford Stargard Stavanger 
  Steinkjer Stirling Stockholm Stoholm Storsjöbygden Stureby 
  Stuttgart Sukma Sukomoro Sumedang Sunndalsøra Surabaya Suzhou 
  Svendborg Sydney Szczecinek Szczyrk Szeged Søborg Sørreisa

  Taicang Taichung Tainan Taizhou Takayama Tallinn Tambun Taoyuan
  Tarakan Targoviste Tarnów Tasikmalaya Taskopru Täby Täfteå 
  Tekýrdag Telmessos Temuco Thane Thanjavur Thessaloniki Thoisy Tianjin 
  Tilburg Timisoara Tire Tofta Tokyo Tomohon Tonya Torino 
  Toshima Toulouse Tours Trabzon Trieste Trondheim Tromsø Tübingen 

  Udaipur Uddevalla Umeå Underberg Uppsala Usak Utrecht Uzunköprü

  Vadsø Van Vancouver Varanasi Varberg Varese Varna Vasa Västervik 
  Västerås Vejle Venice Verona Vestfold Vestvågøy Viareggio Vienna 
  Vikersund Vilnius Vorden Vraca

  Waldsolms Waltham Wanzhou Warsaw Wellington Wetzlar Wiesbaden 
  Wisla Worcester Wroclaw Wronie Wuhan Wuxi

  Xiamen Xian Xiantao Xinyi Xuzhou

  Yambol Yanshi Yarýmca Yatagan Yizhuang Yokohama Yogyakarta Yuquan

  Zagreb Zegrze Zhaoqing Zhenjiang Zhongshan Zhuzhou Zigong Zonguldak
  Zürich Zyrardow

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
  Cankaya => ['Çankaya'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Chennai => ['madras'],
  Copenhagen => ['kopenhagen'],
  Deauville => ['deauille'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Düsseldorf => ['duesseldorf'],
  Eregli => ['ereðlý'],
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
  Padang => ['padan'],
  Palembang => ['plg', 'palemb'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Pau => ['puau'],
  Petersfield => ['peterfield'],
  'Piatra Neamt' => ['neamt'],
  Porto => ['invicta', 'oporto'],
  Potsdam => ['postdam'],
  Poznan => ['poz', 'poznañ'],
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
  'South Tangerang' => ['tangsel'],
  Storsjöbygden => ['storsjöbygdens'],
  Söke => ['soke'],
  Stockholm => ['stockholms'],
  Sunndalsøra => ['sunndalsora'],
  'Taipei City' => ['taipei'],
  Targoviste => ['tg'],
  Tarnów => ['tarnow'],
  Taskopru => ['tasköprü'],
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
