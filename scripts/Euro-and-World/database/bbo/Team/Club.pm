#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Club;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_club);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  "'t Onstein",
  'Aachener',
  'ABB BK',
  'Acol Praha',
  'Ada Briç SK',
  'Akceþme Spor',
  'Aklindo Musi 88',
  'Alert Mannheim',
  'Altay Genclik',
  'Altinay SK',
  'Ankara Kontrat',
  'Ankara Sistematik',
  'Antalya BSK',
  'ASA University of Tel Aviv',
  'Atletik Basket',
  'ATU Bucharest',
  'Augsburg Augusta',
  'Avalanche BC',
  'Aydin 1923 BBSK',
  'Bakýrköy Briç SK',
  'Balai Pelaksanaan Jalan Nasional',
  'Bamberger Reiter',
  'Bangkok Bridge Club',
  'Baþkent Sekans BSK',
  'Batman Genclik',
  'Beijing Baxi Football',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  'BC de Lille',
  'BC de Zeerob',
  'BC Garches',
  'BC Milano',
  'BC Rennais',
  'BC Saarbrücken 1984',
  'BC Schwäbisch Hall',
  'BC Star',
  'BC Universität Mannheim',
  'BCN Almirall',
  'Besli Major',
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
  'Brans BS',
  'Bridge Académie',
  'Bridge House',
  'Bridge Turó',
  'Bridge Tunas Cahaya',
  'Bridgeclub Oog',
  'Brussels Bridge Club',
  'BSB Kurek Ihtisas',
  'Buca Sports',
  'Bucak Bel.',
  'BUKS Bytom',
  'Camlica Sports',
  'Cedýt Ilica Sports',
  'Centrum Kultury i Sportu',
  'Cercle Tourangeau',
  'CFT Bridge',
  'Circolo del Bridge Cannareggio',
  'Circolo del Bridge Firenze',
  'Circolo del Bridge N. Ditto Reggio Calabria',
  'Circolo del Tennis Palermo',
  'Circolo del Bridge Venezia',
  'Circolo Nautico Posillipo',
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
  'Fakultas Teknik Bridge Club',
  'Fatih Karagumruk',
  'Fire Club',
  'Fjends BK',
  'Frankfurter TBC',
  'Førde BK',
  'Gabrial UI',
  'GB Cimahi',
  'Gereja Masehi Injili di Minahasa',
  'Geyve Sports',
  'Goztepe Hilal SK',
  'Göktürk SK',
  'Grant Thornton',
  'Greve Strand',
  'Hamar BK',
  'Hamra Club',
  'Hanseatic Hamburg BC',
  'Harstad S&B',
  'Hendek Kazimiye',
  'Herkules',
  'Heybeliada SK',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Isparta Club',
  'Istanbul Sports',
  'Jakarta BBG',
  'Jia Zhou Ai Qiao',
  'Jian Hua',
  'Jili Qiche',
  'Jin Fu',
  'Jin Hui',
  'Jin Mei',
  'Jing Fan',
  'JZD Liban',
  'Kao Hsiung Club',
  'Kapakli Sýte',
  'Karlsruher BSC',
  'Ke Bi Ya Club',
  'Klør 10 Vejle',
  'Kota Club',
  'Köln Lindenthal',
  'Kultcamp Rieneck',
  'Lalit Mohanka',
  'Lindesbergs BS',
  'Major Hosgoru',
  'Majör Boğaziçi',
  'Makassar Utama',
  'Malatya Yildiz Dogu',
  'Manna Bridge Club',
  'Mersin Club',
  'Midt Trøndelag',
  'Mike Lawrence Club',
  'Milan CPK Milanowek',
  'Modalfa',
  'Moss BK',
  'Møre og Romsdal',
  'NDC Den Hommel',
  'Nachteulen Leverkusen',
  'Nancy Jarville',
  'Nilüfer Bld. BSK',
  'Nord Trøndelag',
  'Norrorts Bridge',
  'NS-1',
  'Núcleo De Bridge Do Círculo',
  'Nürnberg Museum',
  'OBK Kloverknekt',
  'Ocean BC',
  'Odisha Secretariat Recreation Club',
  'One Eyed Jacks',
  'Otters Club',
  'Østfold og Follo',
  'Øvre Ottadalen',
  'Paris Sud',
  'Pescara Bridge',
  'Petroleum Mining Club',
  'Phoenix Oltenita',
  'Porto Club',
  'Rabwa Club',
  'Resegone LC',
  'Ruch AZS',
  'Qi Zhong Club',
  'Qingnian Qiche',
  'Quantum BC',
  'RAL Poznan',
  'RBSC Polo Club',
  'Royal Selangor Club',
  'Ruch SA',
  'Rumah Sakit Umum Daerah',
  'Salmun BC',
  'Samadhan Academy',
  'San Sac',
  'Semen Padang',
  'Sharja Club',
  'Shemokh Club',
  'Shou Chuang',
  'Siwo Persatuan Wartawan Indonesia',
  'Sirinyer Sports',
  'Site Sports',
  'Ski BK',
  'Slem Bric SK',
  'SM BTC',
  'Smedstadens BK',
  'SPG Club',
  'St:Erik',
  'St:Erik Bahaj',
  'St:Erik Hella',
  'St:Erik Morot',
  'Studentenes',
  'Tabip Odasi',
  'Tekirdað Club',
  'Tennis Club Parioli',
  'The West End Mumbai',
  'Top Bridge BC',
  'Torino Allegra',
  'UKS Olimpia',
  'Van Bric',
  'Vefa SK',
  'Wadi Degla',
  'Wampon Bodi Papua',
  'Wan Jian Club',
  'Witte Huis',
  'WCG Mumbai',
  'Zurich Enge'
);

my %MULTI_TYPOS =
(
  'Aachener BC' => ['aachener bc 1953'],
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'Ada Briç SK' => ['ada bric'],
  'Adana BSB' => ['adana b. shr bld', 'adana b.seh bel',
    'adana bsb sk', 'adana buyuksehir', 'adana b.s.k', 
    'adana bric sk', 'adana bsbkisk', 'adana sk', 'adana bþbký'],
  AGBC => ['a g b c'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Akceþme Spor' => ['akceþmespor'],
  'Aklindo Musi 88' => ['musi 88', 'musi88'],
  'Alexandria Sporting Club' => ["alexandria sport' c"],
  Anadolu => ['anadolu briç'],
  'Ankara Sistematik' => ['sistematik bk'],
  'Antalya BSK' => ['antalya b.s.k', 'noname ant.', 'ant bric ihtisas sk'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923'],
  'Bakýrköy Briç SK' => ['bakirkoy su'],
  'Balai Pelaksanaan Jalan Nasional' => ['bpjn xi'],
  'Batman Genclik' => ['batman gençlýk'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen abk', 'begen ak'],
  Besiktas => ['besiktas jk'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bamberg cavaliers', 'bamberger germany', 'bamberger welle', 
    'bamberg riders', 'bc bamberger reite', 'bridgeclub bamberge'],
  'BC Garches' => ['b.c de garches'],
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
  'Bornova BSK' => ['bornova bel. spor', 'bornova bbsk'],
  'Bridge Académie' => ['b.academie', 'bridge academie'],
  'Bridge House' => ['b.house', 'b. house'],
  'Bridge Turó' => ['b. turó', 'b.turó', 'b.turo'],
  'Bridgeclub Oog' => ['bc oog in al'],
  'Brussels Bridge Club' => ['b.c.o.b.'],
  'BUKS Bytom' => ['buks ii bytom'],
  Canakkale => ['çanakkale', 'canakkale beld.', 'canakkale tarim sp'],
  'Cedýt Ilica Sports' => ['cedýt ilica spor'],
  'Cerkezkoy Dinamik BSK' => ['cerkezkoy bs', 'cerkezkoy bsk',
    'cerkezkoy dinamik'],
  'CFT Bridge' => ['cft b'],
  'Circolo del Bridge Cannareggio' => ['c.lo cann.'],
  'Circolo del Bridge Firenze' => ['c.lo br. firenze'],
  'Circolo del Bridge N. Ditto Reggio Calabria' => ['n. ditto rc'],
  'Circolo del Bridge Venezia' => ['c.lo ve'],
  'Circolo del Tennis Palermo' => ['c.lo tennis palermo'],
  'Circolo Nautico Posillipo' => ['c. n. posillipo', 'posillipo'],
  'Crvena Zvezda' => ['zrvena zvezda'],
  'Debrecen DEAC' => ['debrecen-deac'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'El-Karma' => ['al-karma', 'al karma'],
  'Eskisehir Adalar' => ['eskisehir adalarbsb', 'eskisehir adalarbsk'],
  'Eskisehir Baðlar' => ['eskýþehýr baðlar'],
  'Fanfulla' => ['fanfulla lo'],
  'Fatih Karagumruk' => ['f karagumruk', 'fatýh karagümrük s.'],
  'Gabrial UI' => ['gabrial-ui', 'gabriel - ui',
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
  'Jian Hua' => ['jian hua club'],
  'Jili Qiche' => ['ji li'],
  'Jing Fan' => ['jing fan club', 'jin fan'],
  'Kapakli Sýte' => ['kapaklý sýte'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Ke Bi Ya Club' => ['ke bi ya'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
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
  'Nilüber Bld. BSK' => ['nilufer belediyesi'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'Núcleo De Bridge Do Círculo' => ['nb-cbl'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks', 'one.eyed jacks'],
  'Otters Club' => ["otters' club"],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'RAL Poznan' => ['ral poznañ'],
  'Siwo Persatuan Wartawan Indonesia' => ['siwo pwi sulut'],
  'SM BTC' => ['sm-btc'],
  'St:Erik' => ['bk s.t erik', 'bk st erik', 'st erik', 'st erýk',
    'st erik'],
  'St:Erik Bahaj' => ['s:t erik - bahaj'],
  'St:Erik Hella' => ['bk st erik hella', 'bk st.erik hella'],
  'St:Erik Morot' => ['bk st erik morot', 'bk st.erik morot',
    'bk sterik morot', 'morot bk st erik'],
  'Studentenes BK' => ['studentene bk'],
  "'t Onstein" => ["bc't onsten"],
  'Tekirdað Club' => ['tekirdað belediye s', 'tekýrdah beledýye'],
  'Tennis Club Parioli' => ['tc pariori', 'tcp rm', 'tennis rm',
    't.c.p.'],
  'Tonyaspor' => ['tonya spor'],
  'Top Bridge BC' => ['topbridge bc', 'top bridge', 'topbridge bk'],
  'Torino Allegra' => ['bridge allegra', 'allegra to',
    'allegra - to', 'gs allegra', 'g.s. allegra', 'torino alegra', 
    'allegra torino', 'g.s.allegra'],
  'Wampon Bodi Papua' => ['wambon bodi papua'],
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai'],
  'Witte Huis' => ['het witte huis', 'white house', 'the white house'],
  'Østfold og Follo' => ['østfold/follo', 'østfold&follo'],
  'Øvre Ottadalen' => ['øvre ottadal']
);

my @SINGLE_WORDS = qw(
  Acol Airmadidi AGBC Amisos Anadolu Asenovec Auguri AVGP
  Benfica Besiktas Bonsist Botev BTBK
  Canakkale
  Dragao Drienerlo
  Fanfulla Fenerbahce Fosnavåg
  Galata Galatasaray Gauteng
  Hercules Hoppklubbene Hordaland Hosgoru Houchetou
  Jeofizik
  Karagümrük Karlsruher Kløverknekt 
  Lavec Laksamana LÜKSAD
  Locomotiva
  Malatyagücü Matunga Mo Mragowia
  NBK
  Pamukspor Pelatnas
  Qizhong
  Romana
  Sakura Sivasspor Solli Spezia Spojnia
  TGR Tofas Tonyaspor Trifolium
  Uddevalla Uppsalabridgen
  Vestri
  Østerdal
  Örebridgen
  Yildirimspor
  Zmrzlina
  Åsane
);

my %SINGLE_TYPOS =
(
  'Ada Briç SK' => ['ada'],
  'Akademisk Bridgeklub' => ['akademisk'],
  'Altinay SK' => ['altýnaysk'],
  'Ankara Kontrat' => ['kontrat'],
  'ASA University of Tel Aviv' => ['asa'],
  Asenovec => ['asenovets'],
  'ATU Bucharest' => ['atu'],
  Auguri => ['Augurý'],
  'Bangkok Bridge Club' => ['bbc'],
  'Baþkent Sekans BSK' => ['sekans'],
  'Batman Genclik' => ['batman'],
  'BC Bamberger Reiter' => ['bamberger', 'amberger'],
  'DB de Zeerob' => ['zeerob'],
  'BC Garches' => ['garches'],
  'BC Milano' => ['bcmi'],
  'BH Koru BK' => ['koru'],
  'BK Lavec Smile' => ['smile'],
  'Bridge Tunas Cahaya' => ['btc'],
  'Bridgeclub Oog' => ['bco'],
  'Brussels Bridge Club' => ['bcob'],
  'Buca Sports' => ['bucaspor'],
  'Camlica Sports' => ['camspor'],
  Canakkale => ['çanakkale'],
  'Centrum Kultury i Sportu' => ['ckis'],
  'Cracovia 1906' => ['cracovia'],
  'Crvena Zvezda' => ['zvezda'],
  'Delhi Gymkhana Club' => ['dgc', 'dg'],
  'El Ahly' => ['ahly'],
  'El-Karma' => ['karma'],
  'Eskisehir Sports' => ['eskisehirspor'],
  'Fakultas Teknik Bridge Club' => ['ftbc'],
  'Fatih Karagumruk' => ['fatihkaragumruk'],
  'Fjends BK' => ['fjends'],
  'Gabrial UI' => ['gabrial', 'gabriel'],
  'Geyve Sports' => ['geyvespor'],
  'Hamra Club' => ['hamra'],
  'Harstad S&B' => ['harstad'],
  'Hok Studiecentrum' => ['hok'],
  Hordaland => ['hordland'],
  Hosgoru => ['hoþgörü'],
  Houchetou => ['huochetou'],
  'Isparta Club' => ['isparta'],
  'Istanbul Sports' => ['istanbulspor'],
  'Jing Fan' => ['jingfan'],
  Karagümrük => ['karagumruk'],
  Locomotiva => ['loco'],
  'Majör Boğaziçi' => ['majorbogazici'],
  Mragowia => ['mragovia', 'mrogowia', 'mrangowia', 'mr¹gowia',
    'mr¥gowia'],
  'Norrorts Bridge' => ['norrort'],
  'Núcleo De Bridge Do Círculo' => ['nbcbl'],
  'Odisha Secretariat Recreation Club' => ['osrc'],
  'Otters Club' => ['otters'],
  'Petroleum Mining Club' => ['pmc'],
  'Porto Club' => ['cbp'],
  'RBSC Polo Club' => ['rbsc'],
  'Ruch AZS' => ['ruch'],
  'Rumah Sakit Umum Daerah' => ['rsud'],
  'Samadhan Academy' => ['samadhan', 'samadgan'],
  'Sirinyer Sports' => ['sirinyerspor'],
  'Site Sports' => ['sitespor'],
  'Smedstadens BK' => ['smedstadens'],
  'SPG Club' => ['spg'],
  Spojnia => ['Spójnia'],
  'St:Erik Bahaj' => ['bahaj'],
  "'t Onstein" => ['onstein'],
  'Tennis Club Parioli' => ['tcp', 'rm'],
  TGR => ['tgrs'],
  'The West End Mumbai' => ['twem'],
  Tofas => ['tofaþ'],
  'Top Bridge BC' => ['topbridge'],
  'Torino Allegra' => ['bcat'],
  Uppsalabridgen => ['ippsalabridgen'],
  'Witte Huis' => ['whitehouse'],
  Zmrzlina => ['zmerzlina'],
  Örebridgen => ['Örebridge', 'orebridgen']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
