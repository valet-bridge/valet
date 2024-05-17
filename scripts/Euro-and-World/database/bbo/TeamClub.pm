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
  'Acol Praha',
  'Akademisk',
  'Alert Mannheim',
  'Allegra Torino',
  'Altay Genclik',
  'Ankara Kontrat',
  'Augsburg Atlanta',
  'Avalanche BC',
  'Aydin 1923 BBSK',
  'Bamberger Reiter',
  'Beijing Baxi Football',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  'BC de Lille',
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
  'Brussels Bridge Club',
  'Cracovia 1906',
  'Crvena Zvezda',
  'Cerkezkoy Dinamik BSK',
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
  'Essen 86',
  'Fire Club',
  'Fjends BK',
  'Førde BK',
  'Gabrial UI',
  'Grant Thornton',
  'Greve Strand',
  'Hanseatic Hamburg BC',
  'Herkules',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Jakarta BBG',
  'Jia Zhou Ai Qiao',
  'Jian Hua',
  'Jili Qiche',
  'Jin Ying',
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
  'Majör Boğaziçi',
  'Makassar Utama',
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
  'Nürnberg Museum',
  'OBK Kloverknekt',
  'One Eyed Jacks',
  'Østfold og Follo',
  'Øvre Ottadalen',
  'Paris Sud',
  'Pescara Bridge',
  'Phoenix Oltenita',
  'Rabwa Club',
  'Qi Zhong Club',
  'Qin Lian Club',
  'Qingnian Qiche',
  'Quantum BC',
  'Royal Selangor Club',
  'Ruch SA',
  'Samadhan Academy',
  'San Sac',
  'Semen Padang',
  'Sharja Club',
  'Shemokh Club',
  'Shou Chuang',
  'St:Erik Hella',
  'St:Erik Morot',
  'Studentenes',
  'Tennis Club Parioli',
  'Torino Allegra',
  'Van Bric',
  'Wadi Degla',
  'Wampon Bodi Papua',
  'Witte Huis',
  'WCG Mumbai',
  'Young Sharks',
  'Zurich Enge'
);

my %MULTI_TYPOS =
(
  'Aachener BC' => ['aachener bc 1953'],
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'Adana BSB' => ['adana b. shr bld', 'adana b.seh bel',
    'adana bsb sk', 'adana buyuksehir', 'adana b.s.k', 
    'adana bric sk', 'adana bsbkisk', 'adana sk', 'adana bþbký'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Alexandria Sporting Club' => ["alexandria sport' c"],
  'Antalya BSK' => ['antalya b.s.k'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen akademiske bk', 'bergen abk'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bv bamberger reiter', 'bamberg rider', 'bamberg cavaliers',
    'bamberger germany', 'bamberger welle', 'bamberg riders',
    'bc bamberger reite', 'bridgeclub bamberge'],
  'BC Universität Mannheim' => ['bc uni mannheim'],
  'BCN Almirall' => ['bcn-almirall', 'bcn - almirall'],
  'BK Herkules' => ['bc hercules'],
  'BK Lavec Smile' => ['bk lavec - smile', 'lavec smile',
    'smile bk lavec', 'bk lavek smile', 'bk lavec', 'enjoy bk lavec'],
  'BC Alert Mannheim' => ['bc mannheim', 'alert mannheim'],
  'BK St:Erik Hella' => ['bk st erik hella', 'bk st.erik hella'],
  'BK St:Erik Morot' => ['bk st erik morot', 'bk st.erik morot',
    'bk sterik morot', 'morot bk st erik'],
  'Bodrum BSK' => ['bodrum b.s.k.', 'bodrum bric kulubu',
    'bordum bric sk'],
  'Bogazici BSK' => ['bogaz ici bsk', 'boðazici bsk', 'boðazýçý bsk',
    'boðazýçý s.k.'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy BS', 'Cerkezkoy BSK'],
  'Crvena Zvezda' => ['zrvena zwezda'],
  'Debrecen DEAC' => ['debrecen-deac'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'Eskisehir Adalar' => ['eskisehir adalarbsb', 'eskisehir adalarbsk'],
  'Eskisehir Baðlar' => ['Eskýþehýr Baðlar'],
  'Fanfulla' => ['fanfulla lo'],
  'Gabrial UI' => ['gabrial-ui', 'gabrial - ui'],
  'Grant Thornton' => ['bc grant thornton', 'bc grant-thornton', 
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
  'Hok Studiecentrum' => ['hok ts'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'Izmir BSB/Turkiye', 'izmir bsbs',
    'izmir bbsk'],
  Jeofizik => ['jeofýzýk'],
  'Jian Hua' => ['jian hua club'],
  'Jili Qiche' => ['ji li'],
  'Jin Ying' => ['jin ying club'],
  'Jing Fan' => ['jing fan club', 'jin fan'],
  'Kapakli Sýte' => ['kapaklý sýte'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Ke Bi Ya Club' => ['ke bi ya'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'Majör Boğaziçi' => ['major b', 'major bogazici',
    'majör boðaziçi'],
  'Midt Trøndelag' => ['midt trondelag', 'midt-trøndelag',
    'midt-trondelag'],
  'Miskolc DEAC' => ['deac-miskolc'],
  'Nachteulen Leverkusen' => ['nachteulen leverk'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks', 'one.eyed jacks'],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'Qin Lian Club' => ['qin lian'],
  'Østfold og Follo' => ['østfold/follo'],
  'Øvre Ottadalen' => ['øvre ottadal'],
  'Studentenes BK' => ['studentene bk'],
  'Torino Allegra' => ['bridge allegra', 'allegra to',
    'allegra - to', 'gs allegra'],
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai'],
  'Witte Huis' => ['het witte huis', 'white house', 'the white house']
);

my @SINGLE_WORDS = qw(
  Acol Airmadidi Akceþme Amisos Asenovec Auguri
  Bonsist Botev
  Debrecen Dragao
  Fanfulla Fenerbahce Fosnavåg
  Galatasaray
  Hercules Hoppklubbene Hordaland Hosgoru Houchetou
  Jeofizik
  Karagümrük Karlsruher Kløverknekt 
  Lavec Laksamana
  Locomotiva
  Miskolc Mo Mragowia
  Qizhong
  Romana
  Sakura Solli Spojnia
  TGR Tofas Trifolium
  Uddevalla Uppsalabridgen
  Østerdal
  Örebridgen
  Zmrzlina
  Åsane
);

my %SINGLE_TYPOS =
(
  'Akademisk Bridgeklub' => ['akademisk'],
  'Ankara Kontrat' => ['kontrat'],
  Asenovec => ['asenovets'],
  Auguri => ['Augurý'],
  'Banda Aceh' => ['aceh'],
  'BC Bamberger Reiter' => ['bamberger', 'amberger'],
  'BK 2000' => ['bk2000'],
  'BK Lavec Smile' => ['smile'],
  'Brussels Bridge Club' => ['bcob'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy'],
  'Cracovia 1906' => ['cracovia'],
  'Delhi Gymkhana Club' => ['dgc'],
  'El Ahly' => ['ahly'],
  'El-Karma' => ['karma'],
  'Gabrial UI' => ['gabrial'],
  'Hok Studiecentrum' => ['hok'],
  Hordaland => ['hordland'],
  Hosgoru => ['hoþgörü'],
  'Izmir BSB' => ['izmir.b.b.'],
  Karagümrük => ['karagumruk'],
  Kløverknekt => ['kloverknekt'],
  Locomotiva => ['loco'],
  'Majör Boğaziçi' => ['majorbogazici'],
  Mragowia => ['mragovia', 'mrogowia', 'mrangowia', 'mr¹gowia',
    'mr¥gowia'],
  'Norrorts Bridge' => ['norrort'],
  'Samadhan Academy' => ['samadhan'],
  Spojnia => ['Spójnia'],
  'Tennis Club Parioli' => ['tcp'],
  TGR => ['tgrs'],
  Uppsalabridgen => ['ippsalabridgen'],
  Örebridgen => ['Örebridge', 'orebridgen'],
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
