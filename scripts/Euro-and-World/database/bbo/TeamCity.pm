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
  'Al-Rabwa',
  'Banda Aceh',
  'Bandar Lampung',
  'Belo Horizonte',
  'Boven Digoel',
  'El-Maadi',
  'Gaziantep Zeugma',
  'Gjøvik og Vardal',
  'Kansas City',
  'Kashi Goa',
  'Kota Bandung',
  'Kota Bekasi',
  'Kota Bogor',
  'Kota Mataram',
  'Kuala Lumpur',
  'La Chaux-de-Fonds',
  'La Marina',
  'Las Flores',
  'Le Bouscat',
  'Mandobo Bodi',
  'Meilin Qingcheng',
  'Mitra Vihar',
  'Monte Carlo',
  'Muara Bungo',
  'Novi Sad',
  'Piatra Neamt',
  'Reggio Emilia',
  'San Giorgio del Sannio',
  'Semburat Jingga',
  'Seulawah Agam',
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
  Diyarbakir => ['d.baki', 'd.bakir', 'd.bakýr', 'd.baki b.þ',
    'd.bakir b.þ.', 'd.bakir y.þehýr', 'd.bakir yenýþehýr',
    'd.bakýr b.þehir', 'd.bakir sur', 'd.bakýr sur',
    'd.bakýr dicle'],
  'Gaziantep Zeugma' => ['g.antep zeugma'],
  Guangzhou => ['guang zhou'],
  Istanbul => ['ýstanbul'],
  Jakarta => ['jak-tim', 'jak-sel', 'jakarta pusat', 'jakarta utara',
    'dki jaya'],
  Kristiansand => ['kr.sand'],
  Lozenets => ['vs lozenec', 'vv lozenets'],
  Ningbo => ['ning bo'],
  'Novi Sad' => ['nowe sady'],
  'Piatra Neamt' => ['p. neamt', 'p.neamt'],
  Porto => ['invicta', 'cidade invicta'],
  Pudong => ['pu dong'],
  'Reggio Emilia' => ['r.e.', 'reggio e', 'r. emilia', 'reg. emilia'],
  Qingdao => ['qing dao'],
  'San Giorgio del Sannio' => ['sg del sannio', 's.g.sannio',
    's.giorgio sannio', 'san giorgio del san'],
  Shanghai => ['shang hai'],
  Shenzhen => ['shen zhen'],
  'Siddha Eden Lakeville' => ['siddha eden', 'sidhha eden', 'siddha-eden'],
  'Silesia Gliwice' => ['silezia gliwice'],
  Taicang => ['tai cang'],
  Taihu => ['tai hu'],
  Tainan => ['tai nan'],
  'Villa Fabbriche' => ['v.fabbr.', 'villa fabb.', 'v. fabbriche',
    'v.fabbriche'],
  Wuhan => ['wu han'],
  Yogyakarta => ['di jogjakarta']
);

my @SINGLE_WORDS = qw(
  Aabenraa Aalborg Adalar Adana Adelaide Agresar Ahmedabad Akaylar
  Akçeşme Akdeniz Akhisar Akkad Alexandria Albena Aliaga Allahabad Altay 
  Altrincham Alytus Amanora Amarillo Ambon Amsterdam Ankara 
  Annecy Antalya Antony Antwerpen Aral Arendal Arjasa Asenovgrad Assis 
  Atakoy Atakum Athens Auckland Augsburg Avren Ayacucho Ayan Ayvalik

  Bahce Balcova Bahcesehir Balikesir Balikpapan Ballerup Bamberg 
  Bandung 
  Bangalore Bangkok Banjarmasin Bansi Baragnon Barcelona Batam Bath 
  Batu Bayrampaþa Begues Beijing Bekasi Belgrade
  Bengkulu Beograd Bereket Bergen Bergues Berlin Beroe Bhilwara
  Bhubaneshwar Bielefeld Bieniewo Bikaner Bitung Blitar Bodrum 
  Bodø Bogazici Bogor Bologna Bonn Bordeaux Borivli Bormali 
  Bornova Bozdogan Braila Brandbu Brasilia Brasov Bremen Brisbane 
  Bromölla Brotteaux Buca Bucharest Budapest Buitenhof Burghausen 
  Bursa Burdur Bytom

  Caen Cairns Canakkale Canberra Canterbury Caracas Cascais Catania 
  Çayyolu Cemara Cerkezkoy Cesme Changzhou Chaville Chelmno Chelsea 
  Chengdu Chennai Chicago Chislehurst Chongqing Chumphon Cimahi 
  Clichy Cluj Copenhagen Corlu Courseulles Coventry Cuenca Cuneo

  Dabrowa Dalian Dalls Daqing Darmstadt Datca Debrecen Delft Delhi 
  Denizli Derpt Dersým Diyarbakir Dimitrovgrad Dobrich Dombivli 
  Dongguan Düsseldorf

  Eastbourne Edirne Ege Elblag Esbjerg Esenkent Eskisehir Essen 
  Eyjafjallajokull

  Farsund Farta Fatih Fethiye Firenze Flekkefjord Foca
  Frankfurt Freidorf Førde

  Gdansk Gdynia Genoa Gent Geyve Glidice Gnesta Gorontalo Gorzow
  Gölcük Gresik Guangzhou Guayaquil Gudbrandsdal Gundogan Gyor

  Haderslev Hamburg Hangzhou Hannover Harplinge Harstad 
  Hegyvidék Heimdal Heledia Helsinki Herning Hillerød
  Hornbæk Hosguru Huangshi Huldretråkket Hyderabad

  Iasi Iskenderun Istanbul Izmir

  Jagodina Jaipur Jakarta Jember Jessheim Jiamusi Jiangyou Jilin 
  Jinchang Jincheng Jinjiang Jiujiang Jomtien

  Kadikoy Kadirli Kalisz Kalundborg Kalyani Kanpur Karaçay Karachi
  Kardelen
  Karlsruhe Kartal Karsiyaka Kastamonu Katok Katowice Kaylaka Kediri 
  Kesten Ketsch Kiel Kielce Kiev Kirkeby Kirklarelý Klabat Kocaeli 
  Kocamustafapasa 
  Kolbotn Kolkata Konak Kornik Korwin Kosice Koycegiz Köln Krakow 
  Kristiansand 
  Kucukcekmece Kudus Kunshan Kuopio Kusadasi Küp Kütahya Kverndalen
  Kwok Kyustendil Kølabånn

  Langkat Lappee Leiden Leilem Lemvourgeio Lerum Leszno Leuven Leverkusen 
  Lhokseumawe Lille Lima Lincoln Lindesberg Ljubljana Lodz Lokotok
  London Losari Lowicz Lozenets Lubin Lublin Lucignano Luleburgaz 
  Lumajang

  Maadi Maastricht Madrid Makaliwe Makassar Makus Malatya Malkia Malmö 
  Manahasa Manado Manchester Manisa Manna Mannheim Marbella Martapura 
  Massy Mataram Männiku Medan Melbourne Mersin Meski Michalovce 
  Midyat Milan Milas Minsk Miskolc Montpellier Moradabad Morud
  Moudania Mrzenci Muðla Mumbai Munich Muratpasa

  Nagbagan Nagpur Nagykanizsa Namsos Nanchang Nanning Napoli
  Narita Narlidere Narvik Nazilli Näsby Nijmegen Ningbo Niski 
  Norrbyskär Norrorts Norrøna Nusantara Nürnberg Nyon Nærbø Næstved 
  Nøtterøy

  Odense Ogndal Oldenburg Olgiata Olsztyn Orhangazi Oslo Ottadalen 
  Otepää Oxford Överum

  Padang Padova Paimado Palembang Palermo Palma Palu Pamukkale 
  Pancevo Panzhihua Pariaman Parioli Paris Pärnu Pasham Pattaya 
  Pecs Pekanbaru Pelotas Penajam Pernik Perth Perula Pesaro Pescara 
  Peterfield Piloni Pinarbasi Polonezkoy Poncol Popovo 
  Poznan Pula

  Qiaoxie Qingdao

  Radkov Rakvere Randers Rayong Recoleta Reims Riga Rijeka Rimini Rome
  Pisa Pleven Plovdiv Pontianak Potsdam Prague Pudong Pula Pune Puri

  Rajasthan Ravnkilde Ridabu Rzeszow Rødovre

  Saarbrücken Sabadel Sakarya Salerno Samarinda Samsun Sandefjord 
  Sansar Santiago Sanya Sarniak Sarpsborg Secunderabad Seferihisar 
  Semarang Senayan Serang Serdika Shanghai Shaoguan Shenyang 
  Shenzhen Shihua Shijiazhuang Sibiu Sidoarjo Siena Simal Sindi 
  Singsås Sirinyer
  Skara Skawina Skien 
  Skopje Slagelse Slaska Sleman Sliven Sofia Solok Sortland Söke Split 
  Sredec Stavanger Steinkjer Storsjöbygden Stureby Stuttgart 
  Sukma Suleymanpasa Sunndalsøra Surabaya Suralaya Suzhou Sydney 
  Szeged Sørreisa

  Taicang Taihu Tainan Taizhou Takayama Tallinn Tambun Targoviste 
  Tarnów Taskopru Täby Täfteå Tekýrdag Temuco Tengah Tequendama 
  Thessaloniki Tianjin 
  Tianya Timisoara Tingling Tire Tokyo Tomohon Torino Toulouse Trieste 
  Trondheim Tromsø

  Uccle Udaipur Unia Unaós Uppsala Usak Utrecht

  Van Varbergshus Varese Varna Vasa Västervik Vejle Vestfold Vestvågøy 
  Vienna Vikersund Vilnius Viþnelik Vraca

  Xiamen Xinghua Xinyi

  Wadas Warsaw Wellington Wisla Worcester Wratislavia Wroble 
  Wroclaw Wuhan

  Yalikavak Yambol Yarimada Yarýmca Yatagan Yenisehir Yibin Yildirim 
  Yizhuang Yokohama Yogyakarta Yuquan

  Zagreb Zhenjiang Zhongshan Zhujiang Zhuzhou Zigong Zurich 
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
  'Al-Rabwa' => ['rabwa'],
  Ankara => ['ancyra'],
  Antwerpen => ['antwerp'],
  Arendal => ['arendals'],
  Atakoy => ['ataköy'],
  Auckland => ['akarana'],
  Ayvalik => ['aivali'],
  Bahcesehir => ['bahçeþehýr', 'bahcesehýr', 'bahçesehir'],
  Balisekir => ['balikesýr', 'balýkesir',],
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
  Fatih => ['fatýh'],
  'Gaziantep Zeugma' => ['zeugma'],
  Genoa => ['genova'],
  Guangzhou => ['gz', 'gaungzhou'],
  Harplinge => ['harpling'],
  Hegyvidék  => ['hegyvidek'],
  Heimdal => ['heimdalbc'],
  Iskenderun => ['iskendurun'],
  Izmir => ['ýzmir', 'ýzmýr'],
  Jakarta => ['dki', 'jakar', 'jkt'],
  Kadikoy => ['kadiköy'],
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
  Kyustendil => ['kjustend'],
  'La Marina' => ['lamarina'],
  Langkat => ['lankat'],
  Lhokseumawe => ['lhoeksemawe'],
  Lozenets => ['lozenec'],
  Makassar => ['makasar'],
  Manado => ['menado'],
  Manahasa => ['mnhasa'],
  Mersin => ['mersýn'],
  Milan => ['milano'],
  Milas => ['minas'],
  'Mitra Vihar' => ['mitravihar'],
  'Monte Carlo' => ['montecarlo'],
  Moudania => ['moydania'],
  Mumbai => ['mum'],
  Munich => ['münchen'],
  Nagpur => ['nagpor'],
  Nanchang => ['nancang'],
  Napoli => ['naples'],
  Narlidere => ['narlýdere'],
  Ningbo => ['ningpo'],
  Norrbyskär => ['norrbyskar'],
  'Novi Sad' => ['nowewsady'],
  Olgiata => ['ola'],
  Olsztyn => ['olo'],
  Pamukkale => ['pamuk'],
  Panzhihua => ['panzhihuabc'],
  Parioli => ['paroli'],
  'Piatra Neamt' => ['neamt'],
  Potsdam => ['postdam'],
  Poznan => ['poz'],
  Prague => ['praha'],
  Radkov => ['radkow', 'kadkov', 'rxdkov'],
  'Reggio Emilia' => ['re'],
  Reykjavik => ['reykjavikur', 'reykjavitur'],
  Rome => ['roma'],
  Saarbrücken => ['saarbruecken'],
  Shenzhen => ['sz'],
  Skawina => ['skawia'],
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
  Yildirim => ['yýldýrým'],
  Yogyakarta => ['jogjakarta', 'diy'],
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
