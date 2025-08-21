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
  'Bilhorod-Dnistrovskyi',
  "Bois-d'Amont",
  'Bora Bora',
  'Boven Digoel',
  'Buenos Aires',
  'Buri Ram',
  'Chapel Hill',
  'Chiang Rai',
  'Courseulles-sur-Mer',
  'Cherven Briag',
  'Cluj-Napoca',
  'Czech-Pan',
  'Doliny Narwi',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Gold Coast',
  'Gorzow Wielkopolski',
  'Greve Strand',
  'Hat Tai',
  'Haskovski Mineralni Bani',
  'Hong Kong City',
  "Huai'an",
  'Indonesia-Pan',
  'Kabupaten Bandung Barat',
  'Kamphaeng Phet',
  'Kansas City',
  'Khan Yunis',
  'Khon Kaen',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Krosno Odrzanskie',
  'Kuala Lumpur',
  'Kubu Raya',
  'La Baule-Escoublac',
  'La Chaux-de-Fonds',
  'La Marina',
  'La Spezia',
  'Las Palmas',
  'Las Vegas',
  'Le Bouscat',
  'Lidzbark Warmiński',
  'Mandobo Bodi',
  'Maha Sarakham',
  'Mar del Plata',
  'Meilin Qingcheng',
  'Mian Yang',
  'Miercurea Ciuc',
  'Mitra Vihar',
  'Mo i Rana',
  'Moonee Ponds',
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
  'Saint-Aubin',
  'Saint-Gelais',
  'Saint-Ours',
  'Saint Petersburg',
  'Salt Lake City',
  'San Giorgio del Sannio',
  'San Luis',
  'San Marino City',
  'San Servolo',
  'Santa Clara',
  'São Paulo',
  'São Vicente',
  'Sarp-Hopa',
  'Schwäbisch Hall',
  'Seine-et-Marne',
  'Semburat Jingga',
  'Seulawah Agam',
  'Sheung Wan',
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
  'Yangzhong Shi',
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
  'Haskovski Mineralni Bani' => ['mineralni bani'],
  Helsinki => ['city of helsinki'],
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jak-sel', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kalyani => ["kalyani's"],
  Kristiansand => ['kr.sand'],
  'Miercurea Ciuc' => ['m ciuc', 'm. ciuc', 'm.ciuc',
    'mercurea cinc'],
  Milas => [
    'milas beledýyesi', 
    'mýlas beledýyespor'],
  'Monte Carlo' => ['monte-carlo'],
  'Nea Moudania' => ['moydania'],
  Ningbo => ['ning bo'],
  Padang => ['kota padang'],
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
  Aabenraa Aachen Aalborg Adak Adalar Adana Adapazan Adelaide Agadir
  Agresar Ahmedabad Airmadidi Akhisar Akyaka Akyazi Aladag Alcobaça 
  Alexandria Aliaga Allahabad Alta Altea Altinoluk Altinova Altrincham 
  Alytus Ambon Amed Amman Amsterdam Ankara Annecy Antakya Antalya 
  Antony Antwerpen Aqaba Aral Ardesen Arendal Artvin Asenovec Asenovgrad 
  Askim Asminderød Assis Assos Atakum Atasehir Athens Atlanta Aubagne
  Auckland Augsburg Ayacucho Aydin Ayvalik Ayvansaray

  Babaeski Babayagmur Baghdad Baglarbasi Bagodi Baimao Balchik Bakauheni 
  Bakirköy Balarampur Balaton Balatonföldvár Balikesir Balikpapan Ballerup 
  Ballymena Bamberg Bandung Bangalore Bangkok Banjarmasin Bansi Bansko 
  Barcelona Barlinek Batam Bath Batikent Batman Batu Batununggal Bayramiç 
  Begues 
  Beihai Beijing Beirut Bekasi Belene Belgrade Belfast Bengkalis Bengkulu 
  Beograd Bereket Bergen Bergues Bergule Berkeley Berlin Besiktas 
  Bevagna Beyoglu Bhatpara Bhilwara Bhubaneswar Bialystok Biarritz 
  Bielefeld Bikaner Bilecik Birolo Bismil Bistrita Bitung Blitar Bodrum 
  Bodø Bogor 
  Bogotá Boleslawiec Bologna Bolu Bonn Bordeaux Borlänge Bormali Bornova
  Böblingen Braila Brandbu Braniewo Brasilia Brasov Bremen Brevik 
  Brighton Brisbane Broadbeach Bromölla Bruges Brussels Bucharest 
  Budapest Buffalo Bulancak Buonconvento Burghausen Bursa 
  Burdur Buyukada Buzios Bydgoszcz Bytom Bø

  Caen Cairns Cairo Cali Canakkale Canberra Cankaya Cannareggio Cannes
  Canterbury Caracas Casablanca Cascais Catania Cerkezkoy Cesme Chandigarh 
  Changhua Changsha Changzhou Chavdar Chaville Chelmno Chelopech Chengdu 
  Chennai Chepelare Chiayi Chicago Chongqing Chumphon Cigli Cimahi Cirebon 
  Civril Claremont Clichy Cluj Coimbra Comandatuba Copenhagen Corlu 
  Coventry Craiova Csapi Cuenca Cuneo

  Dabrowka Dalaman Dalian Darmstadt Datca Deauville Debrecen Delft 
  Delhi Denizli Depok Derpt Deva Devrek Dikili Diyarbakir Dimitrovgrad 
  Dobrich Doha Doki Dombivli Dongguan Dortmund Dörtyol Drammen Dubai 
  Dubrovnik Durban Düsseldorf Düzce

  Eastbourne Edinburgh Edirne Edremit Egemen Egirdir Elblag Elmadag 
  Enschede Erdek Eregli Ergene Erzurum Esbjerg Esenler Eskisehir Essen 
  Estoril Evanston

  Farsund Fernetti Fethiye Firenze Flekkefjord Foca Fosnavåg Frankfurt 
  Fredrikstad Freiburg Fritzlar Funchal Fuzhou Førde

  Gainesville Galway Gajaki Garches Gaziemir Gävle Gdansk Gdynia 
  Gelibolu Geneva Genoa Gent Gevgelija Geyve Giresun Giza Glasgow 
  Gnesta Gniezno Gölcük Göteborg Graz Gresik Grobogan Grogol Groningen 
  Guangdong Guangzhou Guayaquil Gudbrandsdal Gudivada Guoxing Gümüşlük 
  Gyor

  Haderslev Haikou Hamar Hamburg Hammamet Hangzhou Hani Hanko Hannover 
  Harplinge Harmanli Harstad Haskovo Hatay Havirov Hayrabolu Hebi 
  Hedemora Heikendorf Heledia Helsinki Hendek Herning Hillerød 
  Hjørring Hobart Hobro Hornbæk Houston Hsinchu Huayin Huldretråkket 
  Hurepoix Huwei Hyderabad

  Iasi Indore Iskenderun Isparta Istanbul Ithaca Izmir

  Jagodina Jaipur Jakarta Jambi Jember Jermen Jessheim Jiamusi Jiangsu 
  Jiangyin Jiangyou Jianshe Jinchang Jincheng Jinjiang Jiujiang 
  Jixiexiang Jurmala

  Kadirli Kaisei Kalisz Kalundborg Kalyani Kanchanaburi Kanha Kanpur 
  Kaohsiung Karacasu Karaman Karasu Karimun Karlovo Karlsruhe Karsiyaka 
  Kartal Kashi Kassel Kastamonu Katowice Kavakdibi Kayseri Kazanlak Kediri
  Kedungwaru Keelung Kemalpasa Kesap Kesten Ketsch Kiel Kielce Kiev 
  Kinali Kirkeby Kirklarelý Kirsehir Kista Kiten Kitka Klabat Klepp 
  Kleve Kocaeli Kolbotn Kolkata Konga Kongsberg Konnerud Konya Kópavogur 
  Korfez Kornik Kosice Kostroma Koszalin Kota Koycegiz Köln Kragerø Krakow 
  Kraljevica Kristiansand Kucukbakkalkoy Kudus Kunshan Kuopio Kusadasi 
  Kutno Kuzguncuk Kütahya Kverndalen Kyoto Kyustendil Køge Kølabånn

  Lahore Landak Langkat Lanzhou Laodikya Lappeenranta Larnaca Larvik 
  Lausanne Lebork Lecco Leiden Leipzig Leksand Lerum Lesno Leszno Leuven 
  Leverkusen Lhokseumawe Liandui Liège Liepaja Lille Lillehammer Lima 
  Limboto Lincoln Lindesberg Linköping Lisbon Liushu Livane Ljubljana 
  Lodi Lodz Lojdy Lokotok Lom Lomza London Lovech Lowicz Lublin 
  Lubomino Ludhiana Ludvikabygden Lufeng Luleburgaz Lumajang Luzern 
  Lyon

  Maastricht Madrid Magetan Makassar Malaga Malang Malatya Malmö Manado 
  Manchester Manila Manisa Manna Mannheim Marbella Marcelli Mardin 
  Marijampolė Marrakech Marseille Martapura Massy Mautern Medan 
  Medellin Melawi Melbourne Mersin Miaoli Michalovce Michalowo Midyat 
  Milan Milas Minsk Miramar Miskolc Monticiano Montoro Montpellier 
  Montreal
  Moradabad Mordogan Morsø Morud Moscow Moss Mragowo Mudanya Muðla 
  Mulund Mumbai Munich Myndos Mysore

  Nagari Nagpur Nagykanizsa Namsos Nanchang Nanchong Nancy Nanjing
  Nanning Nantong Napoli Narlidere Narvik Nashik Nazilli Näsby Nebakan
  Neijiang Nesodden Newport Nganjuk Nice Nicosia Niedernhausen 
  Nijmegen Nilüfer Ningbo Niš Noida Nonthaburi Norrbyskär Norrøna 
  Nusaybin Nürnberg Nykøbing Nyon Nysa Nærbø Næstved Nøtterøy

  Odense Oderzo Odmet Ogndal Oldenburg Olrud Olsztyn Oltenita Opatija 
  Opole Ordu Orneta Orhangazi Osaka Ostend Oslo Osnabrück Ottadalen 
  Otepää Oxford Ozarow Örebro Överum

  Pacitan Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale 
  Panagyurishte Panaji Pancevo Panzhihua Pariaman Paris Pärnu Parvomay 
  Pasuruan Pattaya Pau Pazar Pazardjik Pecs Peebles Pekanbaru Pelitli 
  Pelotas Pemangkat Penajam Pernik Perpignan Perth Perula Pervera 
  Pesaro Pescara Petersfield Petrelik Philadelphia Phitsanulok Phokai 
  Phuket Piedimonte Pijnacker Pisa Pitane Pittsburgh Pleven Pliska Plock 
  Plovdiv Pontianak Popovo Porto Potsdam Poznan Prague Preslav Priboi 
  Primorsko Probolinggo Protaras Ptuj Pula Pulawy Pune Puri Pushkar 
  Puutalo

  Qingdao

  Rabat Radkov Rakovski Rakvere Randers Rastignano Ravnkilde Rayong 
  Razgrad Reims Rennes Reykjavik Riau Rieneck Riga Rijeka Rimini Romana 
  Rome Ronneby Roskilde Rotterdam Rottneros Royan Rozanka Rubbestadneset 
  Ruen Rugao Ruian Ruse Rzepin Rzeszow Rødovre Rønne

  Saarbrücken Sabadell Safranbolu Salerno Salo Salsomaggiore Samarinda 
  Samobor Sampit Samsun Sandefjord Sansepolcro Santiago Sanya Sariyer 
  Sarpsborg Sawahlunto Secunderabad Seferihisar Selfoss Semarang Sendai 
  Senigallia Seoul Serang Shanghai Shangrao Shaoguan Sharjah Shenyang 
  Shenzhen Shijiazhuang Shimla Shouguang Shumen Sibiu Sidoarjo Siena 
  Sieradz Siglufjordur Sigulda Silifke Silistra Simav Sindi Singaraja 
  Singkawang Singsås Sinop Siofok Sivas Skara Skarvemellen Skawina Ski 
  Skien Skopje Slagelse Slavyanovo Slawa Sleman Smedstad Smolyan Smyrna 
  Snåsa Sofia Solapur Solo Solok Songkhla Sopot Sortland Söke Sozopol 
  Split Stanford Stargard Stavanger Steinkjer Stirling Stockholm Stokke 
  Stoholm Storsjöbygden Strasbourg Stureby Stuttgart Szczecin Sukma 
  Sukomoro Sumedang Sunndalsøra Suqian Surabaya Suzhou Svendborg 
  Svinninge Sydney Szczecinek Szczyrk Szeged Sztum Søborg Sømna 
  Sørreisa Sørvoll

  Tabarka Taicang Taichung Tainan Taiyuan Taizhou Takayama Tallinn Tambun 
  Tangerang Taoyuan Tarakan Targoviste Tarnów Tarnobrzeg Tasikmalaya 
  Taskopru Tavsanli Täby Täfteå Tczew Tekkekoy Tekýrdag Telmessos 
  Temuco Ternopil Thane Thanjavur Thessaloniki Thoisy Tianjin Tilburg 
  Timisoara Tire Tofta Tokyo Tomohon Tondano Tonya Torino Toronto 
  Toshima Toulouse Tours Trabzon Tralles Trang Treviso Trieste Trondheim 
  Tromsø Tula Turunc Tübingen 

  Udaipur Uddevalla Ulricehamn Umeå Underberg Uppsala Urla Usak Utrecht 
  Uzunköprü

  Vadsø Valencia Van Vancouver Varanasi Varberg Varese Varna Vasa 
  Västervik Västerås Vejle Veldhoven Venice Verdal Verona Vestfold 
  Vestvågøy Viareggio Viborg Vienna Vikersund Villeurbanne Vilnius 
  Vishakhapatanam Vodskov Vorden Vraca Våge Vålerenga

  Walbrzych Waldsolms Waltham Wanzhou Warsaw Wellington Wetzlar 
  Wiesbaden Wisla Wolverhampton Worcester Wroclaw Wronie Wuhan Wuxi 
  Wuzhishan

  Xiamen Xian Xiantao Xinyi Xuzhou

  Yalikavak Yalova Yambol Yancheng Yanshi Yantai Yarýmca Yasothon 
  Yatagan Yaykin Yekaterinburg Yingshan Yizhuang Yokohama Yogyakarta 
  Yuquan Yuzhou

  Zagreb Zavet Zawady Zegrze Zhaoqing Zhenjiang Zhongshan Zhuzhou 
  Zigong Zonguldak Zuzenberk Zürich Zyrardow

  Ørland Østerdal

  Åkirkeby Ålesund Århus Åsane
);

my %SINGLE_TYPOS =
(
  Adelaide => ['adeliade'],
  Ahmedabad => ['ahemadabad', 'ahmadabad'],
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
  Bhubaneswar => ['Bhubaneshwar'],
  Buyukada => ['büyükada'],
  Buzios => ['bruzios'],
  Canakkale => ['çanakkale'],
  Canberra => ['canbera'],
  Cankaya => ['Çankaya'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Chelopech => ['chelopec'],
  Chennai => ['madras'],
  'Chiang Rai' => ['chaengrai', 'chiangrai'],
  Chumphon => ['chumpon'],
  Copenhagen => ['kopenhagen'],
  Corlu => ['çorlu'],
  Datca => ['datça'],
  Deauville => ['deauille'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Dörtyol => ['dortyol'],
  Düsseldorf => ['duesseldorf'],
  Elmadag => ['elmadað'],
  Eregli => ['ereðlý'],
  Estoril => ['estoral'],
  'Gaziantep Zeugma' => ['zeugma'],
  Gdansk => ['gdañsk'],
  Genoa => ['genova'],
  'Gorzow Wielkopolski' => ['gorzow'],
  Gölcük => ['golcuk'],
  Göteborg => ['goteborg', 'gothenburg'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Indore => ['indor'],
  Iskenderun => ['iskendurun'],
  Izmir => ['ýzmýr', 'izmýr', 'ýzmir'],
  Jaipur => ['jaipu'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Jianshe => ['js'],
  Jiangsu => ['jjiansu'],
  'Kabupaten Bandung Barat' => ['kbb'],
  Kalundborg => ['kallundborg'],
  'Kamphaeng Phet' => ['kampangphet', 'kamphaengphet', 'kamphang',
    'kampheangphet'],
  Kanchanaburi => ['Kanjanaburi'],
  Karsiyaka => ['Karþiyaka'],
  'Khon Kaen' => ['khonkaen'],
  Kiev => ['kyiv'],
  Kocaeli => ['Kocaelý'],
  Kolkata => ['calcutta', 'kolkta', 'kolktata', 'kol'],
  Kosice => ['cassovia'],
  'Kota Mataram' => ['mataram'],
  Koycegiz => ['köyceðýz', 'köycegiz'],
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
  Lubomino => ['lubominie'],
  Ludvikabygden => ['ludvika'],
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
  Muðla => ['mugla'],
  Mumbai => ['mum', 'bombay'],
  Munich => ['münchen', 'muenchen'],
  Nagpur => ['nagpor'],
  Nanchang => ['nancang'],
  Napoli => ['naples'],
  Nashik => ['nasik'],
  Nilüfer => ['nilufer'],
  Ningbo => ['ningpo'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olsztyn => ['olo'],
  Ostend => ['ostende'],
  Ozarow => ['ożarów'],
  Padang => ['padan'],
  Palembang => ['plg', 'palemb'],
  Pamukkale => ['pamuk'],
  Panaji => ['panjim'],
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
  Rødovre => ['rodovre'],
  Rønne => ['roenne'],
  Saarbrücken => ['saarbruecken'],
  'Saint Petersburg' => ['spb'],
  Samsun => ['amisos'],
  Shanghai => ['shntbc'],
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
  Tekýrdag => ['tekirdağ','tekirdag'],
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
  Vishakhapatanam => ['yzac', 'vizag', 'vizac',
    'vishakhapatnam'],
  Warsaw => ['warsow', 'warszawa'],
  Wroclaw => ['wr'],
  Wuzhishan => ['wuzishan'],
  'Yangzhong Shi' => ['yangzhongshi'],
  Yarýmca => ['yarimca'],
  'Yedi Eylul' => ['yedieylul'],
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
