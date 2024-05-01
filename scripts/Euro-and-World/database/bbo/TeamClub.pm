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
  'Grant Thornton',
  'Hanseatic Hamburg BC',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Karlsruher BSC',
  'Klør 10 Vejle',
  'Kota Club',
  'Köln Lindenthal',
  'Kultcamp Rieneck',
  'Midt Trøndelag',
  'Mike Lawrence Club',
  'Moss BK',
  'Møre og Romsdal',
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
  'Semen Padang',
  'Studentenes',
  'Van Bric',
  'Young Sharks'
);

my %MULTI_TYPOS =
(
  'Aachener BC' => ['aachener bc 1953'],
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'Adana BSB' => ['adana b. shr bld', 'adana b.seh bel',
    'adana bsb sk', 'adana buyuksehir', 'adana b.s.k', 
    'adana bric sk', 'adana bsbkisk', 'adana sk', 'adana bþbký'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Akçeşme SK' => ['akcesme spor kulubu', 'akçeþme spor kulübü'],
  'Alexandria Sporting Club' => ["alexandria sport' c"],
  'Antalya BSK' => ['antalya b.s.k'],
  'Aydin 1923 BBSK' => ['aydin 1923 sk', 'aydin bbsk',
    'aydin bilimsel bsk', 'aydinspor 1923'],
  'Bergen Akademiske' => ['bergen ak', 'bergen akad', 'bergen akadem',
    'bergen akademiske bk'],
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
  'Canakkale BSK' => ['canakkale b.s.k', 'canakkale beld',
    'canakkale beledýye', 'canakkale bld.spor', 'çanakkale briç sk'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy BS', 'Cerkezkoy BSK'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'El Ahly'  => ['el ahly club', 'el-ahly club', 'el-ahly'],
  'Grant Thornton' => ['bc grant thornton', 'bc grant-thornton', 
    'bg thornton', 'grant thonrton', 'grantt thornton'],
  'Hanseatic Hamburg BC' => ['hanseatic bc', 'hanseatic hamburg'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'Izmir BSB/Turkiye', 'izmir bsbs',
    'izmir bbsk'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'Mersin BSK' => ['mersin b.b.k.', 'mersin b.b.k.', 'mersin b.s.b',
    'mersn ybsk'],
  'Midt Trøndelag' => ['midt trondelag', 'midt-trøndelag'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks'],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'Qin Lian Club' => ['qin lian'],
  'Østfold og Follo' => ['østfold/follo'],
  'Øvre Ottadalen' => ['øvre ottadal'],
  'Studentenes BK' => ['studentene bk']
);

my @SINGLE_WORDS = qw(
  Botev
  Debrecen
  Hordaland
  Miskolc
  Sakura
  Østerdal
);

my %SINGLE_TYPOS =
(
  'Akademisk Bridgeklub' => ['akademisk'],
  'BC Bamberger Reiter' => ['bamberger'],
  'BK 2000' => ['bk2000'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy'],
  'Izmir BSB' =>['izmir.b.b.']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
