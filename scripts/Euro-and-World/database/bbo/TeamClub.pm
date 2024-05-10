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
  'Aachener',
  'Acol Praha',
  'Akademisk',
  'Altay Genclik',
  'Augsburg Atlanta',
  'Avalanche BC',
  'Aydin 1923 BBSK',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  "'t Onstein",
  'Alert Mannheim',
  'Allegra Torino',
  'Bamberger Reiter',
  'Darmstadt Alert',
  'BC de Lille',
  'Modalfa',
  'Nürnberg Museum',
  'BC Saarbrücken 1984',
  'BC Schwäbisch Hall',
  'BC Universität Mannheim',
  'BCN Almirall',
  'BK 2000',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Björken',
  'BK Everfresh',
  'BK Fyris Skalman',
  'BK Grand',
  'Crvena Zvezda',
  'Herkules',
  'Lavec Smile',
  'Nord Aalborg',
  'St:Erik Hella',
  'St:Erik Morot',
  'Essen 86',
  'Cerkezkoy Dinamik BSK',
  'Diyarbakýr Sur BSK',
  'Drammen Arbeiderparti',
  'El Ahly',
  'El Rabwa Club',
  'Fjends BK',
  'Førde BK',
  'Gabrial UI',
  'Grant Thornton',
  'Greve Strand',
  'Hanseatic Hamburg BC',
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
  'Karlsruher BSC',
  'Klør 10 Vejle',
  'Kota Club',
  'Köln Lindenthal',
  'Kultcamp Rieneck',
  'Majör Boğaziçi',
  'Midt Trøndelag',
  'Mike Lawrence Club',
  'Moss BK',
  'Møre og Romsdal',
  'Nachteulen Leverkusen',
  'Nancy Jarville',
  'Nord Trøndelag',
  'OBK Kloverknekt',
  'One Eyed Jacks',
  'Østfold og Follo',
  'Øvre Ottadalen',
  'Pescara Bridge',
  'Phoenix Oltenita',
  'Qi Zhong Club',
  'Qin Lian Club',
  'Qingnian Qiche',
  'Quantum BC',
  'Royal Selangor Club',
  'Samadhan Academy',
  'Semen Padang',
  'Shou Chuang',
  'Studentenes',
  'Van Bric',
  'Wadi Degla',
  'Wampon Bodi Papua',
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
  'BK Lavec Smile' => ['bk lavec - smile', 'bk lavek smile'],
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
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'Gabrial UI' => ['gabrial-ui', 'gabrial - ui'],
  'Grant Thornton' => ['bc grant thornton', 'bc grant-thornton', 
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
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
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'Majör Boğaziçi' => ['major b', 'major bogazici'],
  'Midt Trøndelag' => ['midt trondelag', 'midt-trøndelag',
    'midt-trondelag'],
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
  'WCG Mumbai' => ['wcg (mum)', 'wcg-mumbai']
);

my @SINGLE_WORDS = qw(
  Acol Airmadidi Akceþme Amisos Asenovec Auguri
  Botev
  Debrecen
  Fosnavåg
  Galatasaray
  Hercules Hordaland
  Hosgoru
  Jeofizik
  Kløverknekt 
  Lavec Laksamana
  Locomotiva
  Miskolc
  Sakura
  Uppsalabridgen
  Østerdal
  Örebridgen
  Åsane
);

my %SINGLE_TYPOS =
(
  'Akademisk Bridgeklub' => ['akademisk'],
  Asenovec => ['asenovets'],
  Auguri => ['Augurý'],
  'Banda Aceh' => ['aceh'],
  'BC Bamberger Reiter' => ['bamberger', 'amberger'],
  'BK 2000' => ['bk2000'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy'],
  'El Ahly' => ['ahly'],
  'Gabrial UI' => ['gabrial'],
  Hordaland => ['hordland'],
  Hosgoru => ['hoþgörü'],
  'Izmir BSB' => ['izmir.b.b.'],
  Kløverknekt => ['kloverknekt'],
  Locomotiva => ['loco'],
  'Majör Boğaziçi' => ['majorbogazici'],
  'Samadhan Academy' => ['samadhan'],
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
