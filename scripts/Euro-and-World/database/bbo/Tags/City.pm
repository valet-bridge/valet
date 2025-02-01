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
  'Baleal Island',
  'Banda Aceh',
  'Bandar Lampung',
  'Banora Point',
  'Belo Horizonte',
  'Bielsko-Biala',
  'Boven Digoel',
  'Buenos Aires',
  'Buri Ram',
  'Chapel Hill',
  'Courseulles-sur-Mer',
  'Cherven Briag',
  'Czech-Pan',
  'Doliny Narwi',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Gold Coast',
  'Greve Strand',
  'Haskovski Mineralni Bani',
  'Hong Kong City',
  'Indonesia-Pan',
  'Kamphaeng Phet',
  'Kansas City',
  'Khan Yunis',
  'Khon Kaen',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'Kubu Raya',
  'La Baule-Escoublac',
  'La Chaux-de-Fonds',
  'La Marina',
  'La Spezia',
  'Las Palmas',
  'Las Vegas',
  'Le Bouscat',
  'Mandobo Bodi',
  'Maha Sarakham',
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
  'Ponta Delgada',
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
  'Santa Clara',
  'São Paulo',
  'São Vicente',
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
  'Zhong Jian',
  'Zielona Gora'
);

my %MULTI_TYPOS =
(
  Akhisar => ['akhisar belediyesi'],
  'Al-Rabwa' => ['rl-rabwa'],
  'Alba Iulia' => ['a iulia'],
  Banjarmasin => ['ksa banjarmasin'],
  Dalian => ['da lian'],
  Delhi => ['new delhi'],
  Diyarbakir => ['d.baki b.þ', 'd.bakir b.þ.', 'd.bakir y.þehýr', 
    'd.bakir yenýþehýr', 'd.bakýr b.þehir', 'd.bakir sur', 
    'd.bakýr sur', 'd.bakýr dicle'],
  'Doliny Narwi' => ['dolina narwi'],
  'Gaziantep Zeugma' => ['g.antep zeugma'],
  'Greve Strand' => ['greve strands'],
  Guangzhou => ['guang zhou'],
  Helsinki => ['city of helsinki'],
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jak-sel', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kalyani => ["kalyani's"],
  Kristiansand => ['kr.sand'],
  'Miercurea Ciuc' => ['m ciuc', 'm. ciuc', 'm.ciuc',
    'mercurea cinc'],
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
  Shenzhen => ['shen zhen'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice', 'silesia i gliwice'],
  'St Louis' => ['washington st louis'],
  'Stara Zagora' => ['st.zagora'],
  Taicang => ['tai cang'],
  'Taihu Lake' => ['suzhou taihu'],
  Tainan => ['tai nan'],
  Tasikmalaya => ['kota tasikmalaya'],
  Tula => ['tuhla ruse'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  'Vrnjacka Banja' => ['vrnjacka banja - al'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta', 'd i yogyakarta', 'di yogya',
    'di yogyakarta'],
  Zavet => ['obshtina zavet']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aachen Aalborg Adalar Adana Adapazan Adelaide Agresar 
  Ahmedabad Airmadidi Akhisar Aladag Alcobaça Alexandria Aliaga 
  Allahabad Alta Altea Altinova Altrincham Alytus Ambon Amed Amman 
  Amsterdam Ankara Annecy Antakya Antalya Antony Antwerpen Aqaba 
  Aral Arendal Asenovec Asenovgrad Askim Asminderød Assis Atakum 
  Atasehir Athens Atlanta Auckland Augsburg Ayacucho Aydin Ayvalik

  Babaeski Baghdad Balchik Bakauheni Balarampur Balaton 
  Balatonföldvár Balikesir Balikpapan 
  Ballerup Ballymena Bamberg Bandung Bangalore Bangkok Banjarmasin 
  Bansi Barcelona Barlinek Batam Bath Batikent Batman Batu Begues 
  Beihai Beijing Beirut Bekasi Belgrade Belfast Bengkalis Bengkulu 
  Beograd Bereket Bergen Bergues Berkeley Berlin Beyoglu Bhilwara 
  Bhubaneshwar Bialystok Biarritz Bielefeld Bikaner Bitung Blitar 
  Bodrum Bodø Bogor Bogotá Boleslawiec Bologna Bonn Bordeaux Bormali
  Böblingen Braila Brandbu Brasilia Brasov Bremen Brevik Brighton 
  Brisbane Broadbeach Bromölla Bruges Brussels Bucharest Budapest 
  Buffalo Burghausen Bursa Burdur Buzios Bydgoszcz Bytom Bø

  Caen Cairns Cairo Canakkale Canberra Cankaya Cannareggio Canterbury 
  Caracas Casablanca Cascais Catania Cerkezkoy Cesme Changhua Changzhou 
  Chaville Chelmno Chelopech Chengdu Chennai Chepelare Chiayi Chicago 
  Chongqing Chumphon Cimahi Cirebon Claremont Clichy Cluj Coimbra
  Copenhagen Corlu Coventry Craiova Cuenca Cuneo

  Dabrowka Dalaman Dalian Darmstadt Datca Deauville Debrecen Delft 
  Delhi Denizli Depok Derpt Deva Devrek Diyarbakir Dimitrovgrad 
  Dobrich Doha Dombivli Dongguan Dortmund Dörtyol Drammen Dubai 
  Dubrovnik Durban Düsseldorf

  Eastbourne Edinburgh Edirne Egirdir Elblag Elmadag Enschede Erdek
  Eregli Ergene Erzurum Esbjerg Eskisehir Essen Estoril Evanston

  Farsund Fernetti Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt 
  Fredrikstad Freiburg Fritzlar Funchal Fuzhou Førde

  Galway Gajaki Garches Gävle Gdansk Gdynia Gelibolu Genoa Gent Gevgelija 
  Geyve Giresun Giza Glasgow Gnesta Gniezno Gorzow Gölcük Göteborg 
  Gresik Grobogan Grogol Groningen Guangdong Guangzhou Guayaquil 
  Gudbrandsdal Gümüşlük Gyor

  Haderslev Haikou Hamar Hamburg Hammamet Hangzhou Hani Hanko Hannover 
  Harplinge Harmanli Harstad Haskovo Hatay Havirov Hebi Hedemora 
  Heikendorf Heledia Helsinki Hendek Herning Hillerød Hjørring Hobro 
  Hornbæk Hsinchu Huldretråkket Hyderabad

  Iasi Indore Iskenderun Isparta Istanbul Ithaca Izmir

  Jagodina Jaipur Jakarta Jambi Jember Jessheim Jiamusi Jiangsu 
  Jiangyou Jianshe Jinchang Jincheng Jinjiang Jiujiang  Jixiexiang
  Jurmala

  Kadirli Kaisei Kalisz Kalundborg Kalyani Kanchanaburi Kanha Kanpur 
  Kaohsiung Karimun 
  Karlovo Karlsruhe Karsiyaka Kashi Kassel Kastamonu Katowice 
  Kayseri Kediri Kedungwaru Keelung Kemalpasa Kesten Ketsch Kiel 
  Kielce Kiev Kinali Kirkeby Kirklarelý Kirsehir Kista Kiten Kitka 
  Klabat Klepp 
  Kleve Kocaeli Kolbotn Kolkata Konga Kongsberg Konnerud Konya 
  Kópavogur Korfez Kornik Kosice Koszalin Kota Koycegiz Köln Kragerø 
  Krakow Kraljevica Kristiansand Kudus Kunshan Kutno Kuopio Kusadasi 
  Kütahya Kverndalen Kyoto Kyustendil Køge Kølabånn

  Landak Langkat Lanzhou Laodikya Lappeenranta Larnaca Larvik 
  Lausanne Lebork Lecco Leiden Leipzig Leksand Lerum Lesno Leszno 
  Leuven Leverkusen Lhokseumawe Liandui Liepaja Lille Lima Limboto Lincoln 
  Lindesberg Linköping Lisbon Liushu Livane Ljubljana Lodi Lodz 
  Lojdy Lokotok Lom Lomza London Lovech Lowicz Lublin Lubomino 
  Ludvikabygden Lufeng Luleburgaz Lumajang Luzern Lyon

  Maastricht Madrid Magetan Makassar Malang Malatya Malmö 
  Manado Manchester Manila Manisa Manna Mannheim Marbella Marcelli
  Mardin Marijampolė Marrakech Marseille Martapura Massy Mautern Medan 
  Medellin Melawi Melbourne Mersin Miaoli Michalovce Michalowo Midyat 
  Milan Milas Minsk Miramar Miskolc Monticiano Montoro Montpellier 
  Moradabad Morsø Morud Moscow Moss Mragowo Mudanya Muðla Mulund 
  Mumbai Munich 

  Nagari Nagpur Nagykanizsa Namsos Nanchang Nanchong Nancy Nanjing
  Nanning Napoli Narlidere Narvik Nashik Nazilli Näsby Nebakan
  Neijiang Nesodden Newport Nganjuk Nice Nicosia Niedernhausen 
  Nijmegen Nilüfer Ningbo Niš Noida Nonthaburi Norrbyskär Norrøna 
  Nusaybin Nürnberg Nyon Nysa Nærbø Næstved Nøtterøy

  Odense Odmet Ogndal Oldenburg Olrud Olsztyn Oltenita Opatija 
  Opole Ordu Orneta Orhangazi Osaka Ostend Oslo Osnabrück Ottadalen 
  Otepää Oxford Ozarow Örebro Överum

  Pacitan Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale 
  Pancevo Panzhihua Pariaman Paris Pärnu Parvomay Pasuruan Pattaya Pau 
  Pazar Pazardjik Pecs Peebles Pekanbaru Pelotas Penajam Pernik Perth 
  Perula Pervera Pesaro Pescara Petersfield Petrelik Philadelphia 
  Phitsanulok Phokai Phuket Piedimonte Pijnacker Pisa Pitane Pittsburgh 
  Pleven Plock Plovdiv Pontianak Popovo Porto Potsdam Poznan Prague 
  Preslav Priboi Primorsko Probolinggo Protaras Ptuj Pula Pulawy Pune 
  Puri Pushkar Puutalo

  Qingdao

  Radkov Rakovski Rakvere Rastignano Ravnkilde Rayong Reims Rennes 
  Reykjavik Riau Rieneck Riga Rijeka Rimini Romana Rome Roskilde 
  Rotterdam Rottneros Rozanka Rubbestadneset Rugao Ruian Ruse Rzepin 
  Rzeszow Rødovre Rønne

  Saarbrücken Sabadell Salerno Salo Salsomaggiore Samarinda Samobor 
  Sampit Samsun Sandefjord Santiago Sanya Sariyer Sarpsborg 
  Sawahlunto Secunderabad Seferihisar Selfoss Semarang Sendai 
  Senigallia Seoul Serang Shanghai Shangrao Shaoguan Sharjah Shenyang 
  Shenzhen Shijiazhuang Shimla Shouguang Shumen Sibiu Sidoarjo Siena 
  Sieradz Sigulda Silifke Silistra Sindi Singaraja Singkawang
  Singsås Siofok Sivas Skara Skawina Ski Skien Skopje Slagelse Slawa 
  Sleman Smedstad Smolyan Smyrna Snåsa Sofia Solok Songkhla Sopot 
  Sortland Söke Sozopol Split Stanford Stargard Stavanger Steinkjer 
  Stirling Stockholm Stoholm 
  Storsjöbygden Stureby Stuttgart Sukma Sukomoro Sumedang 
  Sunndalsøra Suqian Surabaya Suzhou Svendborg Sydney Szczecinek 
  Szczyrk Szeged Sztum Søborg Sømna Sørreisa Sørvoll

  Taicang Taichung Tainan Taiyuan Taizhou Takayama Tallinn Tambun 
  Tangerang Taoyuan Tarakan Targoviste Tarnów Tarnobrzeg Tasikmalaya 
  Taskopru Täby Täfteå Tczew Tekýrdag Telmessos Temuco Ternopil Thane 
  Thanjavur Thessaloniki Thoisy Tianjin Tilburg Timisoara Tire 
  Tofta Tokyo Tomohon Tonya Torino Toshima Toulouse Tours Trabzon 
  Tralles Trieste Trondheim Tromsø Tula Tübingen 

  Udaipur Uddevalla Ulricehamn Umeå Underberg Uppsala Usak Utrecht 
  Uzunköprü

  Vadsø Van Vancouver Varanasi Varberg Varese Varna Vasa Västervik 
  Västerås Vejle Venice Verdal Verona Vestfold Vestvågøy Viareggio 
  Viborg Vienna Vikersund Villeurbanne Vilnius Vodskov Vorden Vraca
  Våge

  Waldsolms Waltham Wanzhou Warsaw Wellington Wetzlar Wiesbaden 
  Wisla Wolverhampton Worcester Wroclaw Wronie Wuhan Wuxi

  Xiamen Xian Xiantao Xinyi Xuzhou

  Yambol Yancheng Yanshi Yantai Yarýmca Yasothon Yatagan Yaykin 
  Yingshan Yizhuang Yokohama Yogyakarta Yuquan Yuzhou

  Zagreb Zavet Zawady Zegrze Zhaoqing Zhenjiang Zhongshan Zhuzhou 
  Zigong Zonguldak Zuzenberk Zürich Zyrardow

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
  'Baleal Island' => ['baleal', 'balelal'],
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
  Chumphon => ['chumpon'],
  Copenhagen => ['kopenhagen'],
  Corlu => ['çorlu'],
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
  Jiangsu => ['jjiansu'],
  Kalundborg => ['kallundborg'],
  'Kamphaeng Phet' => ['kampangphet', 'kamphaengphet', 'kamphang',
    'kampheangphet'],
  Kanchanaburi => ['Kanjanaburi'],
  Karsiyaka => ['Karþiyaka'],
  'Khon Kaen' => ['khonkaen'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta', 'kolkta', 'kolktata', 'kol'],
  Kosice => ['cassovia'],
  Koycegiz => ['köyceðýz'],
  Krakow => ['kraków', 'cracow'],
  Kristiansand => ['kristiansands'],
  'Kuala Lumpur' => ['kl'],
  'Kubu Raya' => ['kuburaya'],
  Kyustendil => ['kjustend'],
  'La Marina' => ['lamarina'],
  Langkat => ['lankat'],
  Lhokseumawe => ['lhoeksemawe'],
  Linköping => ['linkoping'],
  Livane => ['lývane'],
  Lovech => ['melta'],
  Luleburgaz => ['lüleburgaz'],
  'Maha Sarakham' => ['mahasarakham'],
  Makassar => ['makasar'],
  Malmö => ['malmo', 'malmoe'],
  Manado => ['menado'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitravihar'],
  'Monte Carlo' => ['montecarlo'],
  Mumbai => ['mum', 'bombay'],
  Munich => ['münchen', 'muenchen'],
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
  Pazardjik => ['pazrdzik'],
  Petersfield => ['peterfield'],
  Phuket => ['puket'],
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
  Skopje => ['skopije'],
  Slawa => ['s£awa', 's³awa'],
  Songkhla => ['Songkha'],
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
  Vilnius => ['wilno'],
  Warsaw => ['warsow', 'warszawa'],
  Wroclaw => ['wr'],
  Yogyakarta => ['diy', 'yogya'],
  Zagreb => ['zgb', 'zg'],
  'Zielona Gora' => ['zielona'],
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
