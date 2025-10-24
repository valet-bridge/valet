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
  'Beaulieu-sur-Mer',
  'Belo Horizonte',
  'Bielsko-Biala',
  'Bilhorod-Dnistrovskyi',
  "Bois-d'Amont",
  'Bora Bora',
  'Boven Digoel',
  'Buenos Aires',
  'Buri Ram',
  'Cape Town',
  'Chapel Hill',
  'Chiang Rai',
  'Corpus Christi',
  'Costa Mesa',
  'Courseulles-sur-Mer',
  'Cherven Briag',
  'Cluj-Napoca',
  'Czech-Pan',
  'Den Haag',
  'Doliny Narwi',
  'El-Maadi',
  'Garden Ridge',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Gold Coast',
  'Gorzow Wielkopolski',
  'Grande Motte',
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
  'La Rochelle',
  'La Spezia',
  'Lake Iseo',
  'Las Palmas',
  'Las Vegas',
  'Le Bouscat',
  'Lidzbark Warmiński',
  'Little Rock',
  'Long Island',
  'Los Angeles',
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
  'New Orleans',
  'New Taipei City',
  'New Westminster',
  'New York City',
  'Niagara Falls',
  'North Garden',
  'Nové Město',
  'Novi Sad',
  'Nowa Ruda',
  'Nowa Sol',
  'Palangka Raya',
  'Palo Alto',
  'Piatra Neamt',
  'Piggs Peak',
  'Ponta Delgada',
  'Punta Arenas',
  'Punta del Este',
  'Reggio Calabria',
  'Reggio Emilia',
  'Rio Claro',
  'Rio de Janeiro',
  'Rostov-on-Don',
  'Russia-Pan',
  "'s-Hertogenbosch",
  'Saint-Aubin',
  'Saint-Gelais',
  'Saint-Ours',
  'Saint Louis',
  'Saint Petersburg',
  'Salt Lake City',
  'San Antonio',
  'San Diego',
  'San Francisco',
  'San Giorgio del Sannio',
  'San Jose',
  'San Juan',
  'San Luis',
  'San Marino City',
  'San Miguel',
  'San Remo',
  'San Sebastian',
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
  'Stara Zagora',
  'Taihu Lake',
  'Tanjung Pinang',
  "Tain l'Hermitage",
  'Taipei City',
  'Tel Aviv',
  'The Hague',
  'Tweed Heads',
  'Udon Thani',
  'Urbana-Champaign',
  'Val de Seine',
  'Veliko Tarnovo',
  'Vik i Sogn',
  'Villa Fabbriche',
  'Vina del Mar',
  'Vrnjacka Banja',
  'Washington DC',
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
  'Saint Louis' => ['st louis', 'washington st louis'],
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
  Aabenraa Aachen Aalborg Aberdeen Adak Adakli Adalar Adana Adapazan 
  Adelaide Adiyaman Afyonkarahisar Agadir Agresar Ahmedabad Ainhoa 
  Airmadidi Akcakoca Akhisar Akron Aksaray Aksehir Akyaka Akyazi 
  Aladag Alcobaça Alexandria Aley Aliaga Alicante Allahabad Alta 
  Altea Altinoluk Altinova Altrincham Alytus Amasya Ambon Amed Amman 
  Amsterdam Anaheim Analya Angers Ankara Annecy Antakya Antalya Antibes 
  Antony Antwerpen Aqaba Aral Ardesen Arendal Arezzo Ardahan Arhavi
  Arnhem Artvin Asenovec Asenovgrad Askim Asminderød Assis Assos Assunçao 
  Asturia Atakum Atasehir Athens Atlanta Aubagne Auckland Augsburg 
  Aveiro Avignon Ayacucho Aydin Ayvalik Ayvansaray

  Babaeski Babayagmur Baghdad Baglarbasi Bagodi Baimao Balchik Bakauheni 
  Bakirköy Balarampur Balaton Balatonföldvár Balikesir Balikpapan 
  Ballerup Ballymena Bamberg Bandirma Bandung Bangalore Bangkok 
  Banjarmasin Bansi Bansko Barcelona Barlinek Bartoszyce Basel Batam 
  Bath Batikent Batman Batu Batumi Batununggal Bayramiç Bedford Begues 
  Beihai Beijing Beirut Bekasi Belene Belgrade Belfast Bengkalis Bengkulu 
  Beograd Berdyczow Bereket Bergen Bergues Bergule Berkeley Berlin 
  Besiktas Bevagna Beyoglu Bhatpara Bhilwara Bhimavaram Bhubaneswar 
  Bialystok Biarritz Bielefeld Bikaner Bilbao Bilecik Birolo Bismil 
  Bistrita Bitlis Bitung Blitar Blois Bodrum Bochum Bodø Bogor Bogotá 
  Boleslawiec Bologna Bolu Bonn Bordeaux Borlänge Bormali Bornova 
  Boston Botosani Bozüyük Böblingen Braila Brandbu Braniewo Brasilia 
  Brasov Bremen Brevik Briancon Brighton Brisbane Bristol Broadbeach 
  Bromölla Brooklyn Bruges Brussels Bucharest Budapest Buffalo Bulancak 
  Buonconvento Burdwan Burghausen Bursa Burdur Burgas Buyukada 
  Buzios Bydgoszcz Bytom Bø

  Cadiz Caen Cagliari Cairns Cairo Calais Calangute Calgary Cali 
  Cambrils Canakkale Canberra Cankaya Cankiri Cannareggio Cannes 
  Canterbury Caracas Carlsbad Casablanca Cassel Cascais Castres 
  Catalca Catania Çaycuma Caykara Cerkezkoy Cesme Champaign Chandigarh 
  Changhua Changsha Changzhou Chanteloup Charleroi Charlottesville 
  Charreau Chartres Chavdar Chaville Chelmno Chelopech Chengdu Chennai 
  Chepelare Chiayi Chicago Chisinau Chongqing Christchurch Chumphon 
  Cide Cigli Cildir Cimahi Cirebon Civril Claremont Clichy Cluj 
  Coimbatore Coimbra Colmar Comandatuba Copenhagen Correze Corlu 
  Corum Corvallis Coventry Craiova Cranbrook Csapi Csíkszereda Cuenca 
  Cuneo Cupertino Curitiba Czestochowa

  Dabrowka Dalaman Dalian Dambron Darmstadt Datca Daytona Deauville 
  Debrecen Decazeville Degirmendere Delaware Delft Delhi Denizli Denver
  Depok Derpt Detroit Deva Devrek Dhaka Dharmasraya Dijon Dikili 
  Divrigi Diyarbakir Dimitrovgrad Dinhata Dobrich Doha Doki Dombivli 
  Dongguan Dorohoi Dortmund Dörtyol Drammen Drøbak Dubai Dublin 
  Dubrovnik Dunfermlin Durban Durgapur Durham Düsseldorf Düzce

  Eastbourne Edinburgh Edirne Edmonton Edremit Egemen Egirdir Elazig
  Elblag Elmadag Elverum Emirdag Englewood Enschede Ephesus Erdek Eregli 
  Ergene Eryaman Erzinkan Erzurum Esbjerg Esenler Eskisehir Essen 
  Estoril Evanston Evansville Evora

  Farsund Farum Fauske Felletin Fernetti Fethiye Firenze Flekkefjord 
  Florianopolis Foca Foshan Fosnavåg Frankfort Frankfurt Fredrikstad 
  Freiburg Fremont Fritzlar Funchal Fussey Fuzhou Førde

  Gainesville Galveston Galway Gajaki Galicia Galleberg Garches Gaza 
  Gaziemir Gazipasa Gävle Gdansk Gdynia Gebze Gelibolu Geneva Genoa 
  Gent Georgetown Gevgelija Geyve Giresun Giza Gizycko Glasgow Glendale
  Gliwice Gnesta Gniezno Göksun Gölcük Göteborg Gqeberha Graz Grenoble 
  Gresik Grobogan Grodkow Grogol Groningen Guangdong Guangzhou 
  Guayaquil Gudbrandsdal Gudivada Guoxing Gümüshane Gümüşlük Gütersloh 
  Gyor

  Haderslev Haikou Hamar Hamburg Hammamet Hanau Hangzhou Hani Hanko 
  Hannover Harplinge Harmanli Harstad Harvard Haskovo Hatay Havirov 
  Hayrabolu Hebi Hedemora Heikendorf Heledia Helsingborg
  Helsinki Hemsin Hendek Herning Hillerød Hiroshima Hjørring Hobart 
  Hobro Honolulu Hopa Hornbæk Horsens Houston Hrubieszow Hsinchu Huayin 
  Huldretråkket Hunedoara Hurepoix Huwei Hyderabad

  Iasi Incesu Indianapolis Indore Indramayu Inowroclaw 
  Iskenderun Isparta Issans Istanbul Ithaca Izmir Iznik

  Jagodina Jaipur Jakarta Jambi Jastrowie Jaworzno Jember Jermen 
  Jerusalem Jessheim Jiamusi Jiangsu Jiangyin Jiangyou Jianshe Jinchang 
  Jincheng Jinjiang Jiujiang Jixiexiang Johannesburg Juliopolis Jurmala

  Kabardey Kadirli Kahramanmaras Kaisei Kajaani Kalisz Kalundborg Kalyani 
  Kanchanaburi Kanha Kanpur Kaohsiung Karabük Karacasu Karaman Karasu 
  Karimun Karlovo Karlsruhe Karlstad Karsiyaka Kartal Kashi Kassel 
  Kastamonu Katowice Kavakdibi Kavarna Kayseri Kazanlak Kediri 
  Kedungwaru Kedzierzyn Keelung Kemaliye Kemalpasa Kesap Kesten Ketsch 
  Kharagpur Kiel Kielce Kiev Kigali Kinali Kirkeby Kirikcan Kirklareli 
  Kirsehir Kista Kiten Kitka Kiziltepe Klabat Klepp Kleve Kocaeli 
  Kolbotn Kolkata Kolobrzeg Konga Kongsberg Konnerud Konya Kópavogur 
  Korfez Kornik Kosice Kostroma Koszalin Kota Koycegiz Köln Kragerø 
  Krakow Kraljevica Krasnodar Kristiansand Krzywanice Kucukbakkalkoy 
  Kudus Kunming Kunshan Kuopio Kusadasi Kutno Kuzguncuk Küçükçekmece 
  Kütahya Kverndalen Kyoto Kyustendil Køge Kølabånn

  Lahore Lakselv Lambach Landak Langkat Lanzhou Laodikya Lappeenranta 
  Largo Larissa Larnaca Larvik Lausanne Lebork Lecco Leiden Leipzig 
  Leksand Leogane Lerum Lesno Leszno Leuven Leverkusen Lhokseumawe 
  Liandui Liège Liepaja Lille Lillehammer Lima Limboto Linares Lincoln 
  Lindesberg Linköping Lisbon Liushu Livane Liverpool Livorno 
  Ljubljana Lodi Lodz Lojdy Lokotok Lom Lomza London Loughborough
  Lovech Lowicz Lubin Lublin Lubomino Ludhiana Ludvikabygden Lufeng 
  Lugoj Luleburgaz Lumajang Luzern Lübeck Lyngdal Lyon

  Maastricht Madrid Magetan Maillé Mainz Makassar Malaga Malang Malatya 
  Malkara Malmö Manado Manavgat Manchester Manila Manisa Manna Mannheim 
  Marbella Marcelli Mardin Marijampolė Marmaris Marrakech Marseille 
  Martapura Massy Mautern Medan Medellin Melawi Melbourne Memphis 
  Meritxell Mersin Meursac Miami Miaoli Michalovce Michalowo Midyat 
  Milan Milas Milpitas Minsk Miramar Miskolc Mombasa Momchilgrad 
  Montélimar Monticiano Montoro Montpellier Montreal Moradabad Mordogan 
  Morsø Morud Moscow Moss Mragowo Mudanya Muðla Mulhouse Mulund 
  Mumbai Munich Myndos Mysore

  Nagari Nagpur Nagykanizsa Namsos Nanchang Nanchong Nancy Nanjing
  Nanning Nantes Nantong Napoli Narlidere Narvik Nashik Nashville Nazilli 
  Näsby Nebakan Neijiang Nesodden Netanya Neuruppin Nevsehir Newport 
  Nganjuk Nice Nicosia Niedernhausen Nijmegen Niksar Nilüfer Nimes Ningbo 
  Niš Noida Nonthaburi Norrbyskär Norrøna Nottingham Notodden Nouméa
  Novosibirsk Nusaybin Nuuk Nürnberg Nykøbing Nyon Nysa Nærbø Nærøysund 
  Næstved Nøtterøy

  Ocala Odense Oderzo Odessa Odmet Ogndal Oldenburg Olrud Olsztyn 
  Oltenita Omaha Omurtag Opatija Opole Oradea Ordu Orlando Orly 
  Orneta Orhangazi Osaka Ostend Oslo Osmaniye Osnabrück Ostrowiec 
  Otepää Ottadalen Ottawa Oulu Oxford Ozarow Örebro Överum

  Pacitan Padang Padova Paimado Palembang Palencia Palermo Palma Palu 
  Pamukkale Panagyurishte Panaji Pancevo Panzhihua Pariaman Paris 
  Pärnu Parvomay Pasadena Pasuruan Patna Pattaya Pau Pazar Pazardjik Pecs 
  Peebles Pekanbaru Pelitli Pelotas Pemangkat Penajam Pensacola
  Pernik Perpignan Persepolis Perth Perula Pervera Pesaro Pescara 
  Petersfield Petrelik Philadelphia Phitsanulok Phoenix Phokai Phuket 
  Piedimonte Pieksämäki Pijnacker Piraeus Pisa Pisco Pitane Pittsburgh 
  Pleven Pliska Plock Plovdiv Plumergat Poitiers Polokwane Pompeii 
  Pontianak Popovo Portland Porto Portobello Potsdam Poznan Prague 
  Preslav Priboi Primorsko Probolinggo Protaras Przemysl Ptuj Pula 
  Pulawy Pune Puri Pushkar Puutalo Pyrzyce

  Quebec Qingdao

  Rabat Radauti Radkov Rakovski Rakvere Randers Rastignano Ravnkilde 
  Rayong Razgrad Redmond Reims Relizane Rennes Reno Reykjavik Riau 
  Richmond Rieneck Riga Rijeka Rimini Riverside Riyadh Rize Rochester 
  Romana Rome Ronneby Roskilde Rotterdam Rottneros Royan Rozanka 
  Rubbestadneset Ruen Rugao Ruian Ruse Rzepin Rzeszow Rødovre Rønne

  Saarbrücken Sabadell Safranbolu Saigon Salerno Salo Salsomaggiore 
  Samarinda Samobor Sampit Samsun Sandefjord Sanliurfa Sansepolcro 
  Santiago Sanya Saragossa Sariyer Sarpsborg Savoie Savona Sawahlunto 
  Scottsdale Seattle 
  Secunderabad Seferihisar Selfoss Semarang Sendai Senigallia Seoul 
  Serang Sevtopolis Shanghai Shangrao Shaoguan Sharjah Shenyang 
  Shenzhen Shijiazhuang Shimla Shiraz Shouguang Shumen Sibiu Sidoarjo 
  Siedlce Siena Sieradz Sighisoara Siglufjordur Sigulda Sile Silifke 
  Silistra Silivri Simav Simeonovgrad Sindi Singaraja Singkawang 
  Singsås Sinop Siofok Sirnak Sivas Skara Skarvemellen Skawina Ski 
  Skien Skopje Slagelse Slavyanovo Slawa Sleman Sliven Smedstad 
  Smithers Smolyan Smyrna Snåsa Sofia Sogndal Solapur Solo Solok 
  Solvorn Sombor Songkhla Sopot Sortland Söke Sozopol Spartanburg
  Split Stanford 
  Starachowice Stargard Stavanger Steinkjer Stirling Stockholm 
  Stockton Stokke Stoholm Storsjöbygden Strasbourg Strømmen Stureby 
  Stuttgart Szczecin Suceava Sukma Sukomoro Sumedang Sunndalsøra 
  Suqian Surabaya Suzhou Suwalki Sürmene Svendborg Svilengrad 
  Svinninge Svishtov Sydney Szczecinek Szczyrk Szeged Sztum Søborg 
  Sømna Sørreisa Sørvoll

  Tabarka Tacoma Taicang Taichung Tainan Taiyuan Taizhou Takayama 
  Talagante Tallinn Tambun Tampa Tangerang Taoyuan Tarakan Targoviste 
  Tarnów Tarnobrzeg Tarragona Tasikmalaya Taskopru Tatvan Tavsanli 
  Täby Täfteå Tbilisi Tczew Tekkekoy Tekýrdag Telmessos Temuco 
  Ternopil Terzialan Texarkana Thane Thanjavur Thessaloniki Thoisy 
  Tianjin Tijuana Tilburg Timisoara Timbuktu Tire Tofta Tokyo Toledo 
  Tomohon Tonara Tondano Tonya Torino Toronto Torrance Torun Toshima 
  Toulon Toulouse Tours Trabzon Tralles Trang Treviso Trieste Tripoli 
  Trondheim Tromsø Tucson Tula Tulsa Tunceli Turgutlu Turkistan Turku 
  Turunc Tübingen 

  Udaipur Uddevalla Ulricehamn Umeå Underberg Uppsala Urla Usak Utrecht 
  Uzunköprü

  Vadsø Vaduz Valcea Valencia Valenciennes Van Vancouver Varanasi 
  Varberg Varese Varna Vasa Västervik Västerås Vejle Veldhoven Velingrad 
  Vence Venice Verdal Verona Versailles Vestfold Vestvågøy Viareggio 
  Viborg Vienna Vikersund Vilamoura Villeurbanne Vilnius 
  Vishakhapatanam Viterbo Vodskov Vorden Vraca Vukovar Våge Vålerenga

  Walbryzch Waldsolms Waltham Wanzhou Warsaw Warwick Waterford Waterloo
  Wellington Wetzlar Wichita Wiesbaden Williamsburg Wimbledon 
  Winnipeg Wisla Woburn Wolverhampton Wonosobo Worcester Wroclaw 
  Wronie Wuhan Wuxi Wuzhishan

  Xanthi Xiamen Xian Xiantao Xingdong Xinyi Xuzhou

  Yalikavak Yalova Yambol Yamoussoukro Yancheng Yangzhong Yanshi Yantai 
  Yarimada Yarimca Yasothon Yatagan Yaykin Yekaterinburg Yerevan 
  Yingshan Yizhuang Yokohama Yogyakarta Yuquan Yuzhou

  Zagreb Zavet Zawady Zegrze Zhaoqing Zhenjiang Zhongshan Zhuzhou 
  Zigong Zigui Zonguldak Zuzenberk Zürich Zyrardow

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
  Assunçao => ['assunção'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Bakirköy => ['bakirkoy'],
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
  Catalca => ['çatalca'],
  Cerkezkoy => ['çerkezköy', 'cerk'],
  Cesme => ['çesme'],
  Chelopech => ['chelopec'],
  Chennai => ['madras'],
  'Chiang Rai' => ['chaengrai', 'chiangrai'],
  Chumphon => ['chumpon'],
  Copenhagen => ['kopenhagen'],
  Corlu => ['çorlu'],
  Corum => ['çorum'],
  Datca => ['datça'],
  Deauville => ['deauille'],
  Diyarbakir => ['dýyarbakir', 'diyarbakýr'],
  Dongguan => ['dongguang'],
  Dörtyol => ['dortyol'],
  Düsseldorf => ['duesseldorf'],
  Elmadag => ['elmadað'],
  Eregli => ['ereðlý'],
  Erzinkan => ['erzincan'],
  Estoril => ['estoral'],
  Frankfurt => ['frankfurt am main'],
  'Gaziantep Zeugma' => ['zeugma', 'gaziantep'],
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
  Kirklareli => ['kirklarelý'],
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
  Liège => ['liege'],
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
  Pazardjik => ['pazrdzik', 'pazarcik'],
  Petersfield => ['peterfield'],
  Phuket => ['puket'],
  'Piatra Neamt' => ['neamt'],
  Pompeii => ['pompei'],
  Porto => ['invicta', 'oporto'],
  Potsdam => ['postdam'],
  Poznan => ['poz', 'poznañ'],
  Prague => ['praha'],
  Quebec => ['québec'],
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
  Targoviste => ['tg', 'targowischte'],
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
  Yarimca => ['yarýmca'],
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
