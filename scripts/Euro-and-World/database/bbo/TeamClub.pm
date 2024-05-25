#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamClub;

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
  'Akademisk',
  'Akceþme Spor',
  'Alert Mannheim',
  'Altay Genclik',
  'Ankara Kontrat',
  'Ankara Sistematik',
  'Atletik Basket',
  'Augsburg Augusta',
  'Avalanche BC',
  'Aydin 1923 BBSK',
  'Bakýrköy Briç SK',
  'Bamberger Reiter',
  'Bangkok Bridge Club',
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
  'BK 2000',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Björken',
  'BK Everfresh',
  'BK Fyris Skalman',
  'BK Grand',
  'BK Lavec Smile',
  'BK Lyx',
  'BK Nord',
  'Brans BS',
  'Bridge Académie',
  'Bridge Tunas Cahaya',
  'Bridgeclub Oog',
  'Brussels Bridge Club',
  'Buca Sports',
  'BUKS Bytom',
  'Centrum Kultury i Sportu',
  'Cercle Tourangeau',
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
  'Geologi Bridge Club',
  'Geyve Sports',
  'Goztepe Hilal SK',
  'Göktürk SK',
  'Grant Thornton',
  'Greve Strand',
  'Hamar BK',
  'Hanseatic Hamburg BC',
  'Herkules',
  'Heybeliada SK',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Jakarta BBG',
  'Jia Zhou Ai Qiao',
  'Jian Hua',
  'Jili Qiche',
  'Jin Ying Club',
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
  'Lindesbergs BS',
  'Major Hosgoru',
  'Majör Boğaziçi',
  'Makassar Utama',
  'Manna Bridge Club',
  'Mersin Club',
  'Midt Trøndelag',
  'Mike Lawrence Club',
  'Modalfa',
  'Moss BK',
  'Møre og Romsdal',
  'NDC Den Hommel',
  'Nachteulen Leverkusen',
  'Nancy Jarville',
  'Nord Aalborg',
  'Nord Trøndelag',
  'Norrorts Bridge',
  'NS-1',
  'Núcleo De Bridge Do Círculo',
  'Nürnberg Museum',
  'OBK Kloverknekt',
  'Ocean BC',
  'One Eyed Jacks',
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
  'Ski BK',
  'Smedstadens BK',
  'SPG Club',
  'St:Erik',
  'St:Erik Bahaj',
  'St:Erik Hella',
  'St:Erik Morot',
  'Studentenes',
  'The West End Mumbai',
  'Tennis Club Parioli',
  'Top Bridge BC',
  'Torino Allegra',
  'Van Bric',
  'Vefa SK',
  'Wadi Degla',
  'Wampon Bodi Papua',
  'Wan Jian Club',
  'Witte Huis',
  'WCG Mumbai',
  'Young Sharks',
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
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Akceþme Spor' => ['akceþmespor'],
  'Alexandria Sporting Club' => ["alexandria sport' c"],
  Anadolu => ['anadolu briç'],
  'Ankara Sistematik' => ['sistematik bk'],
  'Antalya BSK' => ['antalya b.s.k'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923'],
  'Bakýrköy Briç SK' => ['bakirkoy su'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen akademiske bk', 'bergen abk', 'begen ak'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bv bamberger reiter', 'bamberg rider', 'bamberg cavaliers',
    'bamberger germany', 'bamberger welle', 'bamberg riders',
    'bc bamberger reite', 'bridgeclub bamberge'],
  'BC Garches' => ['b.c de garches'],
  'BC Milano' => ['bc mi', 'bc. mi', 'b.c. mi'],
  'BC Universität Mannheim' => ['bc uni mannheim'],
  'BCN Almirall' => ['bcn-almirall', 'bcn - almirall'],
  'BK Fyris Skalman' => ['skalman bk fyris'],
  'BK Herkules' => ['bc hercules'],
  'BK Lavec Smile' => ['bk lavec - smile', 'lavec smile',
    'smile bk lavec', 'bk lavek smile', 'bk lavec', 'enjoy bk lavec'],
  'BC Rennais' => ['b.c. rennais', 'b.c rennais'],
  'BC Alert Mannheim' => ['bc mannheim', 'alert mannheim'],
  'Bodrum BSK' => ['bodrum b.s.k.', 'bodrum bric kulubu',
    'bordum bric sk'],
  'Bogazici BSK' => ['bogaz ici bsk', 'boðazici bsk', 'boðazýçý bsk',
    'boðazýçý s.k.'],
  'Bridge Académie' => ['b.academie', 'bridge academie'],
  'Bridge Tunas Cahaya' => ['btc jatim'],
  'Bridgeclub Oog' => ['bc oog in al'],
  'BUKS Bytom' => ['buks ii bytom'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy BS', 'Cerkezkoy BSK'],
  'Crvena Zvezda' => ['zrvena zwezda', 'zrvena zvezda'],
  'Debrecen DEAC' => ['debrecen-deac'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'El-Karma' => ['al-karma', 'al karma'],
  'Eskisehir Adalar' => ['eskisehir adalarbsb', 'eskisehir adalarbsk'],
  'Eskisehir Baðlar' => ['Eskýþehýr Baðlar'],
  'Fanfulla' => ['fanfulla lo'],
  'Gabrial UI' => ['gabrial-ui', 'gabrial - ui', 'gabriel - ui'],
  'Goztepe Hilal SK' => ['goztepe hilal'],
  'Grant Thornton' => ['bc grant thornton', 'bc grant-thornton', 
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
  'Hok Studiecentrum' => ['hok ts', 'hoc studiecentrum'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'Izmir BSB/Turkiye', 'izmir bsbs',
    'izmir bbsk', 'izmir.b.b.'],
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
   Malatyagücü => ['malatya gucu', 'malatya gücü'],
   'Mersin Club' => ['mersin bsb', 'mersin bþb', 'mersin bsbs',
     'mersin ybsk', 'mersin bbs', 'mersin bsb sk', 'mersin bb'],
  'Midt Trøndelag' => ['midt trondelag', 'midt-trøndelag',
    'midt-trondelag'],
  'Miskolc DEAC' => ['deac-miskolc'],
  'Nachteulen Leverkusen' => ['nachteulen leverk'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'Núcleo De Bridge Do Círculo' => ['nb-cbl'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks', 'one.eyed jacks'],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'RAL Poznan' => ['ral poznañ'],
  'St:Erik' => ['bk s.t erik', 'bk st erik', 'st erik', 'st erýk',
    'st erik'],
  'St:Erik Bahaj' => ['s:t erik bahaj', 's:t erik - bahaj'],
  'St:Erik Hella' => ['bk st erik hella', 'bk st.erik hella'],
  'St:Erik Morot' => ['bk st erik morot', 'bk st.erik morot',
    'bk sterik morot', 'morot bk st erik'],
  'Studentenes BK' => ['studentene bk'],
  "'t Onstein" => ["'t onsten"],
  'Tennis Club Parioli' => ['tc pariori', 'tcp rm', 'tennis rm',
    't.c.p.'],
  'Tonyaspor' => ['tonya spor'],
  'Top Bridge BC' => ['topbridge bc', 'top bridge', 'topbridge bk',
    'bk topbridge'],
  'Torino Allegra' => ['bridge allegra', 'allegra to',
    'allegra - to', 'gs allegra', 'torino alegra', 'allegra torino'],
  'Wampon Bodi Papua' => ['wampon bodi', 'wambon bodi papua'],
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai'],
  'Witte Huis' => ['het witte huis', 'white house', 'the white house'],
  'Østfold og Follo' => ['østfold/follo', 'østfold follo',
    'østfold&follo'],
  'Øvre Ottadalen' => ['øvre ottadal']
);

my @SINGLE_WORDS = qw(
  Acol Airmadidi Akceþme Amisos Anadolu Asenovec Auguri AVGP
  Benfica Besiktas Bonsist Botev BTBK
  Debrecen Dragao Drienerlo
  Fanfulla Fenerbahce Fosnavåg
  Galata Galatasaray Gauteng
  Hercules Hoppklubbene Hordaland Hosgoru Houchetou
  Jeofizik
  Karagümrük Karlsruher Kløverknekt 
  Lavec Laksamana LÜKSAD
  Locomotiva
  Malatyagücü Miskolc Mo Mragowia
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
  'Ankara Kontrat' => ['kontrat'],
  Asenovec => ['asenovets'],
  Auguri => ['Augurý'],
  'Banda Aceh' => ['aceh'],
  'Bangkok Bridge Club' => ['bbc'],
  'BC Bamberger Reiter' => ['bamberger', 'amberger'],
  'DB de Zeerob' => ['zeerob'],
  'BC Garches' => ['garches'],
  'BC Milano' => ['bcmi'],
  'BC Rennais' => ['rennais'],
  'BK 2000' => ['bk2000'],
  'BK Lavec Smile' => ['smile'],
  'Bridge Tunas Cahaya' => ['btc'],
  'Bridgeclub Oog' => ['bco'],
  'Brussels Bridge Club' => ['bcob'],
  'Buca Sports' => ['bucaspor'],
  'Centrum Kultury i Sportu' => ['ckis'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy'],
  'Cracovia 1906' => ['cracovia'],
  'Crvena Zvezda' => ['zvezda'],
  'Delhi Gymkhana Club' => ['dgc'],
  'El Ahly' => ['ahly'],
  'El-Karma' => ['karma'],
  'Eskisehir Sports' => ['eskisehirspor'],
  'Fakultas Teknik Bridge Club' => ['ftbc'],
  'Fatih Karagumruk' => ['fatihkaragumruk'],
  'Fjends BK' => ['fjends'],
  'Gabrial UI' => ['gabrial', 'gabriel'],
  'Geologi Bridge Club' => ['geologi'],
  'Geyve Sports' => ['geyvespor'],
  'Hok Studiecentrum' => ['hok'],
  Hordaland => ['hordland'],
  Hosgoru => ['hoþgörü'],
  Houchetou => ['huochetou'],
  'Jing Fan' => ['jingfan'],
  Karagümrük => ['karagumruk'],
  Kløverknekt => ['kloverknekt'],
  Locomotiva => ['loco'],
  'Majör Boğaziçi' => ['majorbogazici'],
  Mragowia => ['mragovia', 'mrogowia', 'mrangowia', 'mr¹gowia',
    'mr¥gowia'],
  'Norrorts Bridge' => ['norrort'],
  'Núcleo De Bridge Do Círculo' => ['nbcbl'],
  'Petroleum Mining Club' => ['pmc'],
  'Porto Club' => ['cbp'],
  'Ruch AZS' => ['ruch'],
  'Rumah Sakit Umum Daerah' => ['rsud'],
  'Samadhan Academy' => ['samadhan', 'samadgan'],
  'Siwo Persatuan Wartawan Indonesia' => ['pwi'],
  'Smedstadens BK' => ['smedstadens'],
  'SPG Club' => ['spg'],
  Spojnia => ['Spójnia'],
  'St:Erik Bahaj' => ['bahaj'],
  "'t Onstein" => ['onstein'],
  'Tennis Club Parioli' => ['tcp', 'rm'],
  TGR => ['tgrs'],
  'The West End Mumbai' => ['twem'],
  'Top Bridge BC' => ['topbridge'],
  Uppsalabridgen => ['ippsalabridgen'],
  'Witte Huis' => ['whitehouse'],
  Zmrzlina => ['zmerzlina'],
  Örebridgen => ['Örebridge', 'orebridgen'],
  'Østfold og Follo' => ['ostfoldfollo']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
