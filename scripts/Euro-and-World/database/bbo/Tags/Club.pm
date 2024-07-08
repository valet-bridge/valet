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
  'Altay Genclik',
  'Altinay SK',
  'Alumni Club Chennai',
  'Anadolu Bridge Club',
  'Ankara Kontrat',
  'Ankara Sistematik',
  'Antalya BSK',
  'Antalya Tabip Odasi',
  'ASA University of Tel Aviv',
  'Armando and Viviane Gonçalves Pereira',
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
  'BC Bamberger Reiter',
  'Bangkok Bridge Club',
  'Baþkent Sekans BSK',
  'Batman Genclik',
  'Beijing Baxi Football',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  'BC Alert Mannheim',
  'BC de Lille',
  'BC de Zeerob',
  'BC Garches',
  'BC Herkules',
  'BC Milano',
  'BC Rennais',
  'BC Saarbrücken 1984',
  'BC Saint Honoré',
  'BC Schwäbisch Hall',
  'BC Star',
  'BC Universität Mannheim',
  'BCN Almirall',
  'BH Koru BK',
  'Bielski Klub Brydżowy GOK cards',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Björken',
  'BK Everfresh',
  'BK Fyris Skalman',
  'BK Grand',
  'BK Lavec Smile',
  'BK Lyx',
  'BK Nord',
  'Bornova BSK',
  'Bridge Académie',
  'Bridge House',
  'Bridge Turó',
  'Bridge Tunas Cahaya',
  'Bridgeclub Oog',
  'Brussels Bridge Club',
  'Bombay Gymkhana Club',
  'BSB Kurek Ihtisas',
  'Buca Sports',
  'Bucak Bel.',
  'BUKS Bytom',
  'Calcutta Cricket & Football Club',
  'Camlica Sports',
  'Canakkale Tarim',
  'Cedýt Ilica Sports',
  'Centrum Kultury i Sportu Oze',
  'Centrum Kultury i Sportu Skawina',
  'Cercle Tourangeau',
  'CFT Bridge',
  'Circolo del Bridge Cannareggio',
  'Circolo del Bridge Firenze',
  'Circolo del Bridge N. Ditto Reggio Calabria',
  'Circolo del Tennis Palermo',
  'Circolo del Bridge Venezia',
  'Circolo Nautico Posillipo',
  'Corlu Yildiz',
  'Cracovia 1906',
  'Crvena Zvezda',
  'Cerkezkoy Dinamik BSK',
  'Colonial BC',
  'Darmstadt Alert',
  'DBK Dalom',
  'Debrecen DEAC',
  'Deccan Club',
  'Delhi Gymkhana Club',
  'Diyarbakýr Sur BSK',
  'Dorost Havirov',
  'Drammen Arbeiderparti',
  'Dýcle Gençlýk',
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
  'Field Club Udaipur',
  'Fjends BK',
  'Frankfurter TBC',
  'Førde BK',
  'Gabrial University of Indonesia',
  'GB Cimahi',
  'Gereja Masehi Injili di Minahasa',
  'Geyve Sports',
  'Goztepe Hilal SK',
  'Göktürk SK',
  'Grant Thornton',
  'Hamar BK',
  'Hamra Club',
  'Hanseatic Hamburg BC',
  'Harstad S&B',
  'Hendek Kazimiye',
  'Heybeliada SK',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Isparta Club',
  'Istanbul Sports',
  'Jakarta BBG',
  'Jubilee Hills International Centre',
  'Kao Hsiung Club',
  'Kapakli Sýte',
  'Karlsruher BSC',
  'Klør 10 Vejle',
  'Kota Club',
  'Köln Lindenthal BC',
  'Kultcamp Rieneck',
  'Kunshan Qiaoxie',
  'Lindesbergs BS',
  'Madras Gymkhana Club',
  'Major Hosgoru',
  'Majör Boğaziçi',
  'Makassar Utama',
  'Malatya Yildiz Dogu',
  'Manna Bridge Club',
  'Mersin Club',
  'Midt Trøndelag',
  'Milan CPK Milanowek',
  'Moss BK',
  'Møre og Romsdal',
  'NDC Den Hommel',
  'Nachteulen Leverkusen',
  'Nancy Jarville BC',
  'Nilüfer Bld. BSK',
  'Niski Bridge Club',
  'Nord Trøndelag',
  'Norrorts Bridge',
  'NS-1',
  'Núcleo De Bridge Do Círculo',
  'Nürnberg Museum',
  'OBK Kløverknekt',
  'Ocean BC',
  'Odisha Secretariat Recreation Club',
  'One Eyed Jacks',
  'Otters Club',
  'Østfold og Follo',
  'Øvre Ottadalen',
  'Paris Sud',
  'Pescara Bridge',
  'Phoenix Oltenita',
  'Porto Club',
  'Rabwa Club',
  'Resegone LC',
  'Royal Air Force Club',
  'Ruch AZS',
  'Qi Zhong Club',
  'Quantum BC',
  'RAL Poznan',
  'RBSC Polo Club',
  'Royal Selangor Club',
  'Ruch SA',
  'Rumah Sakit Umum Daerah Pekanbaru',
  'Salmun BC',
  'Seferihisar Municipality',
  'Sekolah Bridge Tonaas Wangko',
  'Semen Padang',
  'Sharja Club',
  'Shemokh Club',
  'Shou Chuang',
  'Siwo Persatuan Wartawan Indonesia',
  'Sirinyer Sports',
  'Ski BK',
  'Slem Bric SK',
  'Smedstadens BK',
  'S:t Erik',
  'SPG Club',
  'Sporting Lisbon',
  'Studentenes BK',
  'Suzhou Qiaoxie',
  'Tekirdað Club',
  'Tennis Club Parioli',
  'The West End Mumbai',
  'Top Bridge BC',
  'Torino Allegra',
  'Van Bric',
  'Vefa SK',
  'Wadi Degla',
  'Willingdon Sports Club',
  'Witte Huis',
  'WCG Mumbai',
  'Zurich Enge'
);

my %MULTI_TYPOS =
(
  'Aachener BC' => ['aachener bc 1953'],
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'ABB BK' => ['abb bk topbridge'],
  'Adapazan Briç SK' => ['ada bric'],
  'Adana BSB' => ['adana b. shr bld', 'adana b.seh bel',
    'adana bsb sk', 'adana buyuksehir', 'adana b.s.k', 
    'adana bric sk', 'adana bsbkisk', 'adana sk', 'adana bþbký'],
  'Agriculture Bridge Club' => ['a g b c'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Akceþme Spor' => ['akceþmespor'],
  'Alexandria Sporting Club' => ["alexandria sport' c"],
  'Alumni Club Chennai' => ['alumni club'],
  'Anadolu Bridge Club' => ['anadolu briç', 'anadolu bk',
    'anadolu bjk', 'anadolu bric kulubu'],
  'Ankara Sistematik' => ['sistematik bk'],
  'Antalya BSK' => ['antalya b.s.k', 'noname ant.', 'ant bric ihtisas sk'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923'],
  'Bajnok Bridzs Egyesület' => ['bbe hungary', 'bbe p.s.'],
  'Bakýrköy Briç SK' => ['bakirkoy su'],
  'Balai Pelaksanaan Jalan Nasional' => ['bpjn xi'],
  'Batman Genclik' => ['batman gençlýk'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen akademisk', 'bergen abk', 'begen ak'],
  Besiktas => ['besiktas jk'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bamberg cavaliers', 'bamberger germany', 'bamberger welle', 
    'bamberg riders', 'bc bamberger reite', 'bridgeclub bamberge'],
  'BC Garches' => ['b.c de garches'],
  'BC Herkules' => ['bk herkules', 'herkules'],
  'BC Milano' => ['bc mi', 'bc. mi'],
  'BC Universität Mannheim' => ['bc uni mannheim'],
  'BCN Almirall' => ['bcn-almirall', 'bcn - almirall'],
  'Bielski Klub Brydżowy GOK cards' => ['gok-cards bielsk',
    'gok-ard bielsk'],
  'BK Fyris Skalman' => ['skalman bk fyris'],
  'BK Lavec Smile' => ['bk lavec - smile', 'lavec smile',
    'smile bk lavec', 'bk lavek smile', 'bk lavec', 'enjoy bk lavec'],
  'BC Rennais' => ['b.c. rennais', 'b.c rennais'],
  'BC Alert Mannheim' => ['bc mannheim', 'alert mannheim'],
  'Bodrum BSK' => ['bodrum b.s.k.', 'bodrum bric kulubu'],
  'Bogazici BSK' => ['bogaz ici bsk', 'boðazici bsk', 'boðazýçý bsk',
    'boðazýçý s.k.'],
  'Bombay Gymkhana Club' => ['bombay gym', 'bomay gym'],
  'Bornova BSK' => ['bornova bel. spor', 'bornova bbsk'],
  'Bridge Académie' => ['b.academie', 'bridge academie'],
  'Bridge House' => ['b.house', 'b. house'],
  'Bridge Turó' => ['b. turó', 'b.turó', 'b.turo'],
  'Bridgeclub Oog' => ['bc oog in al'],
  'Brussels Bridge Club' => ['b.c.o.b.'],
  'BUKS Bytom' => ['buks ii bytom'],
  'Calcutta Cricket & Football Club' => ['cc&fc', 'cc & fc', 'cc &fc'],
  'Canakkale Tarim' => ['canakkale tarim sp'],
  'Cedýt Ilica Sports' => ['cedýt ilica spor'],
  'Centrum Kultury i Sportu Oze' => ['oze ckis'],
  'Centrum Kultury i Sportu Skawina' => ['ckis skawina', 'ckis skawia'],
  'Cerkezkoy Dinamik BSK' => ['cerkezkoy bs', 'cerkezkoy bsk',
    'cerkezkoy dinamik'],
  'CFT Bridge' => ['cft b'],
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
    'sur belediye'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'El-Karma' => ['al-karma', 'al karma'],
  'Eskisehir Adalar' => ['eskisehir adalarbsb', 'eskisehir adalarbsk'],
  'Eskisehir Baðlar' => ['eskýþehýr baðlar'],
  'Fakultas Teknik Bridge Club Universitas Tanjungpura' =>
    ['ftbc untan', 'ftbc university tanjungpura'],
  'Fanfulla' => ['fanfulla lo'],
  'Fatih Karagumruk' => ['f karagumruk', 'fatýh karagümrük s.'],
  'Field Club Udaipur' => ['field club udaypur'],
  'Gabrial University of Indonesia' => ['gabrial ui', 'gabrial-ui', 
    'gaberial ui', 'gabrial - ui', 'gabriel - ui', 
    'gabrial ui-y g', 'gabrial ui yg'],
  'Gereja Masehi Injili di Minahasa' => ['pkbs gmim sulut'],
  'Goztepe Hilal SK' => ['goztepe hilal'],
  'Grant Thornton' => ['bc grant thornton',
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
  'Hok Studiecentrum' => ['hok ts', 'hoc studiecentrum'],
  'Isparta Club' => ['isparta bric iht. k'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'izmir bsb/turkiye', 'izmir bsbs',
    'izmir bbsk', 'izmir buyuk sehir b'],
  Jeofizik => ['jeofýzýk'],
  'Jubilee Hills International Centre' => ['jhic'],
  'Kapakli Sýte' => ['kapaklý sýte'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'Madras Gymkhana Club' => ['madras gymkhana', 'madras gumkhana',
    'maras gymkhana'],
  'Majör Boğaziçi' => ['major b', 'major bogazici',
    'majör boðaziçi'],
  'Malatya Yildiz Dogu' => ['malatya yldz/dogu'],
   Malatyagücü => ['malatya gucu', 'malatya gücü'],
   Matunga => ['matunga gym'],
   'Mersin Club' => ['mersin bsb', 'mersin bþb', 'mersin bsbs',
     'mersin ybsk', 'mersin bbs', 'mersin bsb sk', 'mersin bb'],
  'Midt Trøndelag' => ['midt-trøndelag', 'midt-trondelag'],
  'Miskolc DEAC' => ['deac-miskolc'],
  Mragowia => ['mragowia si'],
  'Nachteulen Leverkusen' => ['nachteulen leverk'],
  'Nilüfer Bld. BSK' => ['nilufer belediyesi'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'Núcleo De Bridge Do Círculo' => ['nb-cbl'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks', 'one.eyed jacks'],
  'Otters Club' => ["otters' club", "otter's club", "otter's"],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'RAL Poznan' => ['ral poznañ'],
  'Rumah Sakit Umum Daerah Pekanbaru' => ['rsud pekanbaru'],
  'Seferihisar Municipality' => ['seferihisar bld-ege'],
  'Siwo Persatuan Wartawan Indonesia' => ['siwo pwi sulut'],
  'S:t Erik' => ['bk s.t erik', 'bk st erik', 'bk st.erik', 'bk sterik',
    'st erik', 'st erýk', 'st erik', 'st:erik'],
  'Studentenes BK' => ['studentene bk'],
  "'t Onstein" => ["bc't onsten", 'at onstein', 't onstein'],
  'Tekirdað Club' => ['tekirdað belediye s', 'tekýrdah beledýye'],
  'Tennis Club Parioli' => ['tc pariori', 'tcp rm', 'tennis rm',
    't.c.p.'],
  'Tonyaspor' => ['tonya spor'],
  'Top Bridge BC' => ['topbridge bc', 'top bridge', 'topbridge bk'],
  'Torino Allegra' => ['bridge allegra', 'allegra to',
    'allegra - to', 'gs allegra', 'g.s. allegra', 'torino alegra', 
    'allegra torino', 'g.s.allegra'],
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai'],
   'Willingdon Sports Club' => ['the willingdon sports club', 'wcg'],
  'Witte Huis' => ['het witte huis', 'white house', 'the white house'],
  'Østfold og Follo' => ['østfold/follo', 'østfold&follo'],
  'Øvre Ottadalen' => ['øvre ottadal']
);

my @SINGLE_WORDS = qw(
  Acol AGBC Amisos
  Benfica Besiktas Bonsist Botev BTBK
  Dragao Drienerlo
  Fanfulla Fenerbahce
  Galata Galatasaray 
  Hercules Hoppklubbene Hosgoru 
  Jeofizik JZD
  Karagümrük Karlsruher Kløverknekt 
  Lavec Laksamana LÜKSAD
  Locomotiva
  Malatyagücü Matunga Mo Mragowia
  NBK
  Pamukspor Pelatnas
  Qizhong
  Romana
  Sivasspor Solli Spezia Spojnia
  TGR Tofas Tonyaspor Trifolium
  Unia Uppsalabridgen
  Västeråsbridgen Vestri
  Örebridgen
  Yildirimspor
  Zmrzlina
  Åsane
);

my %SINGLE_TYPOS =
(
  'Aachener BC' => ['aachener'],
  'Acol Praha' => ['acol'],
  'Adapazan Briç SK' => ['ada'],
  'Agriculture Bridge Club' => ['agbc'],
  'Akademisk Bridgeklub' => ['akademisk'],
  'Alexandria Sporting Club' => ['sporting'],
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
  'Fjends BK' => ['fjends'],
  'Gabrial University of Indonesia' => ['gabrial', 'gabriel'],
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
  Tofas => ['tofaþ'],
  'Top Bridge BC' => ['topbridge'],
  'Torino Allegra' => ['bcat'],
  Uppsalabridgen => ['ippsalabridgen'],
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
