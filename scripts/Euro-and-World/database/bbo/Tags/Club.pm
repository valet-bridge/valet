#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Club;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  "'t Onstein",
  'Aachener BC',
  'ABB BK',
  'Acol Praha',
  'Adapazan Briç SK',
  'Agriculture Bridge Club',
  'Akademisk Bridgeklub',
  'Akceþme Spor',
  'Akhisar BS',
  'Altay Genclik',
  'Altinay SK',
  'Alumni Club Chennai',
  'Anadolu Bridge Club',
  'Annecy BC',
  'Ankara Kontrat',
  'Ankara Sistematik',
  'Antalya BSK',
  'Antalya Tabip Odasi',
  'Antony BC',
  'Arendals BK',
  'Armando and Viviane Gonçalves Pereira',
  'ASA University of Tel Aviv',
  'ASB Salerno',
  'ASD Reggio Emilia',
  'ASD Tennis Roma',
  'ASD Villa Fabbriche',
  'Atakoy BSK',
  'Atakum Club',
  'Atletik Basket',
  'ATU Bucharest',
  'Augsburg Augusta',
  'Auguri Warsaw',
  'Avalanche BC',
  'AVI Club Noida',
  'Aydin 1923 BBSK',
  'Bajnok Bridzs Egyesület',
  'Bakýrköy Briç SK',
  'Balai Pelaksanaan Jalan Nasional',
  'Balikesir BSK',
  'Ballerup BC',
  'Bangkok Bridge Club',
  'Baþkent Sekans BSK',
  'Baragnon BC',
  'Batman Genclik',
  'Beijing Baxi Football',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  'BC Alert Mannheim',
  'BC Bamberger Reiter',
  'BC Barcelona',
  'BC Bielefeld',
  'BC Bonn',
  'BC Braila',
  'BC Brasov',
  'BC Bremen',
  'BC Burghausen',
  'BC Clichy',
  'BC Darmstadt Alert',
  'BC de Lille',
  'BC de Lombard',
  'BC de Zeerob',
  'BC Garches',
  'BC Herkules',
  'BC Iasi',
  'BC Ketsch',
  'BC Kiel',
  'BC Massy',
  'BC Milano',
  'BC Modalfa',
  'BC München',
  'BC Oldenburg',
  'BC Rennais',
  'BC Saarbrücken 1984',
  'BC Saint Honoré',
  'BC Schwäbisch Hall',
  'BC Star',
  'BC Stuttgart',
  'BC Tofas',
  'BC Trieste',
  'BC Universität Mannheim',
  'BCN Almirall',
  'BH Koru BK',
  'Bielski Klub Brydżowy GOK cards',
  'BK2000',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Asenovgrad',
  'BK Björken',
  'BK Everfresh',
  'BK Fyris Skalman',
  'BK Grand',
  'BK Lavec Smile',
  'BK Lyx',
  'BK Nord',
  'BK Norrøna',
  'BK Svanslös Skalman',
  'Bodrum BSK',
  'Bodø BK Lyn',
  'Borivli Sports Club',
  'Bornova BSK',
  'BP Batam',
  'Bridge Académie Toulouse',
  'Bridge Bologna',
  'Bridge House',
  'Bridge Turó',
  'Bridge Tunas Cahaya',
  'Bridgeclub Oog',
  'Brussels Bridge Club',
  'Bombay Gymkhana Club',
  'Bozdogan Club',
  'BSB Kurek Ihtisas',
  'BTSC Hannover',
  'Buca Sports',
  'Bucak Bel.',
  'BUKS Bytom',
  'Bursa BSK',
  'Caen BC',
  'Calcutta Bridge Club',
  'Calcutta Cricket & Football Club',
  'Camlica Sports',
  'Canakkale Tarim',
  'Çayyolu BK',
  'Cedýt Ilica Sports',
  'Centrum Kultury i Sportu Oze',
  'Centrum Kultury i Sportu Skawina',
  'Cercle Tourangeau',
  'Cerkezkoy SK',
  'CFT Bridge',
  'Cimentas Club',
  'Circolo del Bridge Cannareggio',
  'Circolo del Bridge Firenze',
  'Circolo del Bridge N. Ditto Reggio Calabria',
  'Circolo del Tennis Palermo',
  'Circolo del Bridge Venezia',
  'Circolo Nautico Posillipo',
  'CK Zyrardow',
  'Corlu Yildiz',
  'Cracovia 1906',
  'Crvena Zvezda',
  'Cerkezkoy Dinamik BSK',
  'Colonial BC',
  'Datca SK',
  'DBK Dalom',
  'Debrecen DEAC',
  'Deccan Club',
  'Delhi Gymkhana Club',
  'Diyarbakýr Sur BSK',
  'Dombivli BC',
  'Dorost Havirov',
  'Drammen Arbeiderparti',
  'Dýcle Gençlýk',
  'EBC Solok',
  'Edirne GSK',
  'Ege Club',
  'EIBC Bandung',
  'EIBC Jakarta',
  'El Ahly',
  'El-Karma',
  'El Rabwa Club',
  'El Shams Club',
  'Eskisehir Adalar',
  'Eskisehir Baðlar',
  'Eskisehir Sports',
  'Essen 86',
  'Fakultas Teknik Bridge Club Universitas Tanjungpura',
  'Fatih Karagumruk',
  'Fethiye BSK',
  'Field Club Udaipur',
  'Fjends BK',
  'Flekkefjord BK',
  'Foca Club',
  'Fosnavåg BK',
  'Frankfurter TBC',
  'Friedland BC',
  'Førde BK',
  'Gabrial University of Indonesia',
  'Gala Tawa Bridge Club',
  'GB Cimahi',
  'Gereja Masehi Injili di Minahasa',
  'Geyve Sports',
  'Gjøvik og Vardal BK',
  'Goztepe Hilal SK',
  'Göktürk SK',
  'Gölcük Club',
  'Grant Thornton',
  'Haderslev BC',
  'Hamar BK',
  'Hamra Club',
  'Hanseatic Hamburg BC',
  'Harplinge BK',
  'Harstad S&B',
  'Heimdal BK',
  'Hendek Kazimiye',
  'Herning BK',
  'Heybeliada SK',
  'Hillerød BK',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Hornbæk BK',
  'Iskenderun IHS',
  'Isparta Club',
  'Istanbul Sports',
  'Izmir BSB',
  'Jakarta BBG',
  'Jessheim BK',
  'Jomtien Bridge Club',
  'Jubilee Hills International Centre',
  'Kao Hsiung Club',
  'Kapakli Sýte',
  'Karlsruher BSC',
  'Karsiyaka BSK',
  'Kartal Club',
  'Kastamonu BSK',
  'KDI Moradabad',
  'Kirklarelý BSK',
  'Klør 10 Vejle',
  'Kocaeli BSSK',
  'Kocamustafapasa SK',
  'Konak Club',
  'Kota Club',
  'Koycegiz BSK',
  'Köln Lindenthal BC',
  'Kristiansand BK',
  'KSB Radkov',
  'Kucukcekmece BK',
  'Kultcamp Rieneck',
  'Kunshan Qiaoxie',
  'Küp BSK',
  'Kusadasi BSK',
  'Lindesbergs BS',
  'Madras Gymkhana Club',
  'Maesa Palu',
  'Major Hosgoru',
  'Majör Boğaziçi',
  'Makassar Utama',
  'Malatya BSK',
  'Malatya Yildiz Dogu',
  'Malmö BK Scania',
  'Manisa BSK',
  'Manna Bridge Club',
  'Mersin Club',
  'Midyat Club',
  'Milan CPK Milanowek',
  'Milas Club',
  'Moss BK',
  'Muðla GSK',
  'Møre og Romsdal',
  'NBI Roma',
  'NDC Den Hommel',
  'Nachteulen Leverkusen',
  'Nagbagan Card Club',
  'Namsos BK',
  'Nancy Jarville BC',
  'Narlidere Club',
  'Narvik BS',
  'Nazilli BBSK',
  'Näsby BS',
  'NDBAC Nashik',
  'Nilüfer Bld. BSK',
  'Niski Bridge Club',
  'Norrorts Bridge',
  'NS-1',
  'Núcleo De Bridge Do Círculo',
  'Nürnberg Museum',
  'Nærbø BK',
  'Næstved BK',
  'Nøtterøy BK',
  'OAZA Kornik',
  'OBK Kløverknekt',
  'Ocean BC',
  'Odense BK',
  'Odisha Secretariat Recreation Club',
  'Ogndal BK',
  'One Eyed Jacks',
  'Orhangazi SK',
  'Otters Club',
  'Padova Bridge SS',
  'Pamukkale SK',
  'Paris Bridge',
  'Paris Sud',
  'Pattaya BC',
  'Pärnu BK',
  'Pescara Bridge',
  'Pertamina BC',
  'Phoenix Oltenita',
  'Porto Club',
  'Pudong Club',
  'Rabwa Club',
  'Resegone LC',
  'Royal Air Force Club',
  'Ruch AZS',
  'Qi Zhong Club',
  'Quantum BC',
  'RAL Poznan',
  'RBSC Polo Club',
  'Romana Bridge',
  'Royal Selangor Club',
  'Ruch SA',
  'Rumah Sakit Umum Daerah Pekanbaru',
  'Rødovre BK',
  'Salmun BC',
  'Samsun BK',
  'Seferihisar Municipality',
  'Sekolah Bridge Tonaas Wangko',
  'Semen Padang',
  'Shaoguan BA',
  'Sharja Club',
  'Shemokh Club',
  'Shou Chuang',
  'Singsås BK',
  'Siwo Persatuan Wartawan Indonesia',
  'Sirinyer Sports',
  'Skara BS',
  'Ski BK',
  'Slem Bric SK',
  'Smedstadens BK',
  'S:t Erik',
  'Sortland BK',
  'Söke BSK',
  'SPG Club',
  'Sporting Lisbon',
  'Star Bridge Roma',
  'Stavanger BK',
  'Steinkjer BK',
  'Storsjöbygdens BK',
  'Studentenes BK',
  'Suzhou Qiaoxie',
  'Sunndalsøra BK',
  'Sørreisa BK',
  'Täby BK',
  'Tekirdað Club',
  'Tennis Club Parioli',
  'The West End Mumbai',
  'Tire BSK',
  'Top Bridge BC',
  'Torino Allegra',
  'Toulouse BC',
  'Tromsø BK',
  'Usak SK',
  'Van Bric',
  'Vasa BK',
  'Vefa SK',
  'Vestvågøy SK',
  'Vikersund BK',
  'Visnelik Club',
  'Wadi Degla',
  'Willingdon Sports Club',
  'Witte Huis',
  'WCG Mumbai',
  'Yalikavak SK',
  'Yarimca SK',
  'Yatagan SK',
  'Zhong Jian Club',
  'Zurich Enge',
  'Østfold og Follo',
  'Øvre Ottadalen',
  'Åkirkeby BK',
  'Århus BK',
  'Åsane BK'
);

my %MULTI_TYPOS =
(
  'Aachener BC' => ['aachener bc 1953'],
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'ABB BK' => ['abb bk topbridge'],
  'Acol Praha' => ['bk praha'],
  'Adapazan Briç SK' => ['ada bric'],
  'Adana BSB' => ['adana b. shr bld', 'adana b.seh bel',
    'adana bsb sk', 'adana buyuksehir', 'adana b.s.k', 
    'adana bric sk', 'adana bsbkisk', 'adana sk', 'adana bþbký'],
  'Agriculture Bridge Club' => ['a g b c'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Akceþme Spor' => ['akceþmespor'],
  'Alexandria Sporting Club' => ["alexandria sport' c", 'sporting club'],
  'Alumni Club Chennai' => ['alumni club'],
  'Anadolu Bridge Club' => ['anadolu briç', 'anadolu bk',
    'anadolu bjk', 'anadolu bric kulubu'],
  'Ankara Sistematik' => ['sistematik bk'],
  'Antalya BSK' => ['antalya b.s.k', 'noname ant.', 'ant bric ihtisas sk',
    'Antalya Briç ÝSK', 'antalya brýç spor', 'antalya bric sk',
    'Antalya HESK', 'Antalya Bric Klb', 'antalya sk'],
  'Atakoy BSK' => ['Atakoy Bric SK'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923', 'aydin 1912'],
  'Bajnok Bridzs Egyesület' => ['bbe hungary', 'bbe p.s.'],
  'Bakýrköy Briç SK' => ['bakirkoy su'],
  'Balai Pelaksanaan Jalan Nasional' => ['bpjn xi'],
  'Batman Genclik' => ['batman gençlýk'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  'BC Alert Mannheim' => ['bc mannheim', 'alert mannheim'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bamberg cavaliers', 'bamberger germany', 'bamberger welle', 
    'bamberg riders', 'bc bamberger reite', 'bridgeclub bamberge'],
  'BC de Lombard' => ['the lombard', 'de lombard', 'lombard bc'],
  'BC Darmstadt Alert' => ['darmstadt alert'],
  'BC Garches' => ['b.c de garches'],
  'BC Herkules' => ['bk herkules', 'bk hercules'],
  'BC Milano' => ['b.c. milano', 'cbc milano', 'bc mi', 'bc. mi'],
  'BC Rennais' => ['b.c. rennais', 'b.c rennais'],
  'BC Universität Mannheim' => ['bc uni mannheim'],
  'BCN Almirall' => ['bcn-almirall', 'bcn - almirall'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen akademisk', 'bergen abk', 'begen ak', 'bergen akadem bk',
    'bergen ak bk'],
  Besiktas => ['besiktas jk'],
  'Bielski Klub Brydżowy GOK cards' => ['gok-cards bielsk',
    'gok-ard bielsk'],
  'BK 83 Slagelse' => ['bridge 83'],
  'BK Fyris Skalman' => ['skalman bk fyris'],
  'BK Svanslös Skalman' => ['bk svanslos skalman'],
  'BK Lavec Smile' => ['bk lavec - smile', 'lavec smile',
    'smile bk lavec', 'bk lavek smile', 'bk lavec', 'enjoy bk lavec'],
  'Bodrum BSK' => ['bodrum b.s.k.', 'bodrum bric kulubu', 'bodrum bc',
    'bodrum bric sk'],
  'Bogazici BSK' => ['bogaz ici bsk', 'boðazici bsk', 'boðazýçý bsk',
    'boðazýçý s.k.'],
  'Bombay Gymkhana Club' => ['bombay gym', 'bomay gym'],
  'Borivli Sports Club' => ['Borivali Sports C', 'borivali s c',
    'borivali sc'],
  'Bornova BSK' => ['bornova bel. spor', 'bornova bbsk'],
  'Bozdogan Club' => ['bozdogan bld'],
  'Bridge Académie Toulouse' => ['b.academie toulouse', 
    'bridge academie toulouse'],
  'Bridge House' => ['b.house', 'b. house'],
  'Bridge Turó' => ['b. turó', 'b.turó', 'b.turo'],
  'Bridgeclub Oog' => ['bc oog in al'],
  'Brussels Bridge Club' => ['b.c.o.b.'],
  'BUKS Bytom' => ['buks ii bytom'],
  'Calcutta Bridge Club' => ['c b c'],
  'Calcutta Cricket & Football Club' => ['cc&fc', 'cc & fc', 'cc &fc',
    'calcutta bridgeclub'],
  'Canakkale Tarim' => ['canakkale tarim sp'],
  'Çayyolu BK' => ['cayyolu bk', 'Çayyolu Briç SKD',
    'Cayyolu Briç SKD', 'Cayyolu Bridge Club'],
  'Cedýt Ilica Sports' => ['cedýt ilica spor'],
  'Centrum Kultury i Sportu Oze' => ['oze ckis'],
  'Centrum Kultury i Sportu Skawina' => ['ckis skawina', 'ckis skawia'],
  'Cerkezkoy Dinamik BSK' => ['cerkezkoy bs', 'cerkezkoy bsk',
    'cerkezkoy dinamik'],
  'CFT Bridge' => ['cft b'],
  'Cimentas Club' => ['cimentas sk', 'cimentas bsk'],
  'Circolo del Bridge Cannareggio' => ['c.lo cann.'],
  'Circolo del Bridge Firenze' => ['c.lo br. firenze'],
  'Circolo del Bridge N. Ditto Reggio Calabria' => ['n. ditto rc',
    'b. reggio emilia'],
  'Circolo del Bridge Venezia' => ['c.lo ve'],
  'Circolo del Tennis Palermo' => ['c.lo tennis palermo'],
  'Circolo Nautico Posillipo' => ['c. n. posillipo', 'posillipo'],
  'Crvena Zvezda' => ['zrvena zvezda'],
  'Debrecen DEAC' => ['debrecen-deac'],
  'Delhi Gymkhana Club' => ['delhi gymkhana'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'diyarbakir bsb', 'd.bakir b.þ. bld.',
    'd.bakir y.þehýr bld', 'dýyarbakir b.bld.sk'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'Ege Club' => ['ege bilimsel', 'ege bsk'],
  'EIBC Jakarta' => ['eibc_jakarta'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'El-Karma' => ['al-karma', 'al karma', 'karma club'],
  'Eskisehir Adalar' => ['eskisehir adalarbsb', 'eskisehir adalarbsk'],
  'Eskisehir Baðlar' => ['eskýþehýr baðlar'],
  'Essen 86' => ['BSC Essen 86'],
  'Fakultas Teknik Bridge Club Universitas Tanjungpura' =>
    ['ftbc untan', 'ftbc university tanjungpura'],
  'Fanfulla' => ['fanfulla lo'],
  'Fatih Karagumruk' => ['f karagumruk', 'fatýh karagümrük s.'],
  'Field Club Udaipur' => ['field club udaypur'],
  'Frankfurter TBC' => ['tbc frankfurt 1958'],
  'Gabrial University of Indonesia' => ['gabrial ui', 'gabrial-ui', 
    'gaberial ui', 'gabriel - ui', 'gabrial ui-y g', 'gabrial ui yg'],
  'Gereja Masehi Injili di Minahasa' => ['pkbs gmim sulut'],
  'Goztepe Hilal SK' => ['goztepe hilal'],
  'Grant Thornton' => ['bc grant thornton',
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
  'Heimdal BK' => ['heimdal bc'],
  'Hok Studiecentrum' => ['hok ts', 'hoc studiecentrum'],
  'Isparta Club' => ['isparta bric iht. k'],
  'Istanbul Sports' => ['istanbul bsk', 'ýstanbul briç sk',
    'istanbul bric sk', 'istanbul sk', 'ýstanbul brýç sk',
    'ýstanbul sk', 'ýstanbul brýç sk', 'ýstanbul bmsk',
    'istanbul bmsk'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 'izmir b.b.',
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'izmir bsb/turkiye', 'izmir bsbs',
    'izmir bbsk', 'izmir buyuk sehir b', 'izmir bþb', 'izmir bbsgk',
    'ýzmýr b.b.s.k.', 'izmir bbgsk'],
  Jeofizik => ['jeofýzýk', 'jeofizik bsk', 'jeofizik b.k'],
  'Jubilee Hills International Centre' => ['jhic'],
  'Kapakli Sýte' => ['kapaklý sýte'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthal bc', 'köln-lindenthaler', 'köln-lindenthaler b'],
  'KSB Radkov' => ['kcb radkov', "ksb \"radkov\""],
  'Küp BSK' => ['kup bsk'],
  Locomotiva => ['Locomotiva CFR', 'Loco-CFR'],
  'Madras Gymkhana Club' => ['madras gymkhana', 'madras gumkhana',
    'maras gymkhana'],
  'Majör Boğaziçi' => ['major b', 'major bogazici',
    'majör boðaziçi', 'major bogazici bsk'],
  'Malatya BSK' => ['Malatya Briç SK', 'Malatya Bric SK',
    'Malatya Brýç Spor', 'Malatya SK'],
  'Malatya Yildiz Dogu' => ['malatya yldz/dogu', 'malatya yildiz bsk'],
   Malatyagücü => ['malatya gucu', 'malatya gücü', '1932 malatya gucu'],
   Matunga => ['matunga gym'],
   'Mersin Club' => ['mersin bsb', 'mersin bþb', 'mersin bsbs',
     'mersin ybsk', 'mersin bbs', 'mersin bsb sk', 'mersin bb'],
  'Miskolc DEAC' => ['deac-miskolc'],
  Mragowia => ['mragowia si'],
  'Nachteulen Leverkusen' => ['nachteulen leverk'],
  'Nazilli BBSK' => ['nazilli bsk'],
  'Nilüfer Bld. BSK' => ['nilufer belediyesi'],
  'Niski Bridge Club' => ['niski bridz club'],
  'Núcleo De Bridge Do Círculo' => ['nb-cbl'],
  'Nürnberg Museum' => ['BC Nürnberg Museum'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'Odense BK' => ['odense bridgeklub'],
  'One Eyed Jacks' => ['one-eyed jacks', 'one.eyed jacks'],
  'Otters Club' => ["otters' club", "otter's club", "otter's"],
  'Pamukkale SK' => ['pamuk sk', 'pamukkale bsk', 'pamukkale bric'],
  'Pudong Club' => ['pu dong club'],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'RAL Poznan' => ['ral poznañ'],
  'RBSC Polo Club' => ['polo club'],
  'Romana Bridge' => ['romana br'],
  'Rumah Sakit Umum Daerah Pekanbaru' => ['rsud pekanbaru'],
  'Seferihisar Municipality' => ['seferihisar bld-ege',
    'seferihisar bld', 'Narlidere Bld'],
  'Siwo Persatuan Wartawan Indonesia' => ['siwo pwi sulut'],
  'Ski BK' => ['Skien BK'],
  'S:t Erik' => ['bk s.t erik', 'bk st erik', 'bk st.erik', 'bk sterik',
    'st erik', 'st erýk', 'st erik', 'st:erik', 'bk st:erik'],
  'Star Bridge Roma' => ['star br. roma'],
  'Studentenes BK' => ['studentene bk'],
  "'t Onstein" => ["bc't onsten", 'at onstein', 't onstein',
    "bc 't onstein"],
  'Tekirdað Club' => ['tekirdað belediye s', 'tekýrdah beledýye',
    'Tekýrdag Beledýye'],
  'Tennis Club Parioli' => ['tc pariori', 'tcp rm', 'tennis rm',
    't.c.p.', 'tc parioli', 'angelini bt tcp', 't.c.p. angelini b.t',
    'angelini bt-tcp', 't.c. parioli', 'tcp rm angelini'],
  'Tonyaspor' => ['tonya spor'],
  'Top Bridge BC' => ['topbridge bc', 'top bridge', 'topbridge bk'],
  'Torino Allegra' => ['bridge allegra', 'allegra to', 'bc allegra',
    'allegra - to', 'gs allegra', 'g.s. allegra', 'torino alegra', 
    'allegra torino', 'g.s.allegra'],
  'Visnelik Club' => ['viþnelik briç sk'],
  'Wadi Degla' => ['wadi degla club', 'degla club'],
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai'],
   'Willingdon Sports Club' => ['the willingdon sports club', 'wcg'],
  'Witte Huis' => ['het witte huis', 'white house', 'the white house'],
  'Yalikavak SK' => ['yalikavak bld sk'],
  'Yarimca SK' => ['yarimca s.k'],
  'Østfold og Follo' => ['østfold/follo', 'østfold&follo'],
  'Øvre Ottadalen' => ['øvre ottadal'],
  'Århus BK' => ['Aarhus BK', 'Århus Bridgeklub', 'Aarhus Bridgeklub']
);

my @SINGLE_WORDS = qw(
  ABK Acol AGBC 
  Benfica Besiktas Bonsist Botev BTBK
  Dragao Drienerlo
  EIBC Fanfulla Fenerbahce
  Galata Galatasaray 
  Hoppklubbene Hosgoru 
  Jeofizik JZD
  Karagümrük Karlsruher Kløverknekt 
  Lavec Laksamana LÜKSAD
  Locomotiva
  Malatyagücü Matunga Mo Mragowia
  NBK
  Pelatnas
  Qizhong
  Sivasspor Solli Spezia Spojnia
  TGR Tonyaspor Trifolium
  Unia Uppsalabridgen
  Västeråsbridgen Vestri
  Örebridgen
  Yildirimspor
  Zmrzlina
);

my %SINGLE_TYPOS =
(
  'Aachener BC' => ['aachener'],
  'ABA Mumbai' => ['aba'],
  'Acol Praha' => ['acol'],
  'Adapazan Briç SK' => ['ada'],
  'Agriculture Bridge Club' => ['agbc'],
  'Akademisk Bridgeklub' => ['akademisk'],
  'Alexandria Sporting Club' => ['sporting', 'sprting'],
  'Altay Genclik' => ['altay'],
  'Altinay SK' => ['altýnaysk'],
  'Anadolu Bridge Club' => ['anadolu'],
  'Ankara Kontrat' => ['kontrat'],
  'ASA University of Tel Aviv' => ['asa'],
  'Armando and Viviane Gonçalves Pereira' => ['avgp'],
  'ATU Bucharest' => ['atu'],
  'Auguri Warsaw' => ['auguri', 'augurý'],
  'AVI Club Noida' => ['avi'],
  'Bangkok Bridge Club' => ['bbc'],
  'Baþkent Sekans BSK' => ['sekans'],
  'BC Bamberger Reiter' => ['bamberger', 'amberger'],
  'BC de Lombard' => ['lombard', 'lomard'],
  'BC Garches' => ['garches'],
  'BC Herkules' => ['hercules', 'herkules'],
  'BC Milano' => ['bcmi'],
  'BH Koru BK' => ['koru'],
  'BK Everfresh' => ['everfresh'],
  'BK Lavec Smile' => ['smile'],
  'BC Saint Honoré' => ['bcsh'],
  'Bridge Tunas Cahaya' => ['btc'],
  'Bridgeclub Oog' => ['bco'],
  'Brussels Bridge Club' => ['bcob'],
  'Buca Sports' => ['bucaspor'],
  'Calcutta Bridge Club' => ['cbc'],
  'Camlica Sports' => ['camspor'],
  'Cracovia 1906' => ['cracovia'],
  'Crvena Zvezda' => ['zvezda'],
  'BC de Zeerob' => ['zeerob'],
  'Delhi Gymkhana Club' => ['dgc', 'dg'],
  'El Ahly' => ['ahly'],
  'El-Karma' => ['karma'],
  'Eskisehir Sports' => ['eskisehirspor'],
  'Fakultas Teknik Bridge Club Universitas Tanjungpura' => ['ftbc'],
  'Fatih Karagumruk' => ['fatihkaragumruk'],
  'Gabrial University of Indonesia' => ['gabrial', 'gabriel'],
  'Gala Tawa Bridge Club' => ['gtbc'],
  'Geyve Sports' => ['geyvespor'],
  'Hamra Club' => ['hamra'],
  'Harstad S&B' => ['harstad'],
  'Hok Studiecentrum' => ['hok'],
  Hosgoru => ['hoþgörü'],
  'Isparta Club' => ['isparta'],
  'Istanbul Sports' => ['istanbulspor'],
  Karagümrük => ['karagumruk'],
  Locomotiva => ['loco'],
  'Madras Gymkhana Club' => ['mgc'],
  'Majör Boğaziçi' => ['majorbogazici'],
  Mragowia => ['mragovia', 'mrogowia', 'mrangowia', 'mr¹gowia',
    'mr¥gowia'],
  'Niski Bridge Club' => ['nbk'],
  'Norrorts Bridge' => ['norrort'],
  'Núcleo De Bridge Do Círculo' => ['nbcbl'],
  'OBK Kløverknekt' => ['kløverknekt'],
  'Odisha Secretariat Recreation Club' => ['osrc'],
  'Otters Club' => ['otters'],
  'Pamukkale SK' => ['pamukspor'],
  'Porto Club' => ['cbp'],
  'RBSC Polo Club' => ['rbsc'],
  'Royal Air Force Club' => ['rac'],
  'Ruch AZS' => ['ruch'],
  'Sekolah Bridge Tonaas Wangko' => ['sbtw'],
  'Sirinyer Sports' => ['sirinyerspor'],
  'Smedstadens BK' => ['smedstadens'],
  'SPG Club' => ['spg'],
  Spojnia => ['Spójnia'],
  'Studentenes BK' => ['studentenes'],
  "'t Onstein" => ['onstein'],
  'Tennis Club Parioli' => ['tcp', 'rm'],
  TGR => ['tgrs'],
  'The West End Mumbai' => ['twem'],
  'BC Tofas' => ['tofaþ'],
  'Top Bridge BC' => ['topbridge'],
  'Torino Allegra' => ['bcat'],
  Uppsalabridgen => ['ippsalabridgen'],
  'Wadi Degla' => ['degla'],
  'Witte Huis' => ['whitehouse'],
  Yildirimspor => ['yildirim', 'yýldýrým'],
  Zmrzlina => ['zmerzlina'],
  Örebridgen => ['Örebridge', 'orebridgen']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
