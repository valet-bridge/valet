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
  'Aachener BC',
  'ABA Mumbai',
  'Adana BSB SK',
  'Akademisk Bridgeklub',
  'Akçeşme SK',
  'Alexandria Sporting Club',
  'Altay GSKD',
  'Altay Genclik',
  'Anadolu BK',
  'Annecy BC',
  'Antalya BSK',
  'Antony BC',
  'Augsburg Atlanta',
  'Avalanche BC',
  'Aydin 1923 BBSK',
  'Ballerup Bridgeklub',
  'Bergen Akademiske',
  'Blakset Klubberne',
  'BC 52 Berlin',
  "BC 't Onstein",
  'BC Alert Mannheim',
  'BC Allegra',
  'BC Bamberger Reiter',
  'BC Barcelona',
  'BC Bielefeld',
  'BC Bonn',
  'BC Braila',
  'BC Brasov',
  'BC Bremen',
  'BC Brotteaux',
  'BC Courseulles',
  'BC Burghausen',
  'BC Clichy',
  'BC Darmstadt Alert',
  'BC de Lille',
  'BC Garches',
  'BC Iasi',
  'BC Ketsch',
  'BC Kiel',
  'BC Lille',
  'BC Massy',
  'BC Modalfa',
  'BC München',
  'BC Nürnberg Museum',
  'BC Oldenburg',
  'BC Saarbrücken 1984',
  'BC Schwäbisch Hall',
  'BC Stuttgart',
  'BC Universität Mannheim',
  'BCN Almirall',
  'BK 2000',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Asenovgrad',
  'BK Björken',
  'BK Everfresh',
  'BK Fyris Skalman',
  'BK Grand',
  'BK Herkules',
  'BK Lavec Smile',
  'BK Nord Aalborg',
  'BK Norrøna',
  'BK Praha',
  'BK St:Erik Hella',
  'BK St:Erik Morot',
  'BSC Essen 86',
  'BTSC Hannover',
  'Bodrum BSK',
  'Bogazici BSK',
  'Bornova BSK',
  'Calcutta Bridge Club',
  'Canakkale BSK',
  'Çayyolu BC',
  'Cerkezkoy Dinamik BSK',
  'Diyarbakýr Sur BSK',
  'Drammen Arbeiderparti',
  'Ege BSK',
  'El Ahly',
  'El Rabwa Club',
  'Fjends BK',
  'Førde BK',
  'Grant Thornton',
  'Haderslev BC',
  'Hanseatic Hamburg BC',
  'Harplinge BK',
  'Harstad BK',
  'Heimdal BK',
  'Hillerød BK',
  'Hindusthan Club',
  'Hok Studiecentrum',
  'Hornbæk Bridgeklub',
  'Istanbul BK',
  'Izmir BSB',
  'Jessheim BK',
  'Karlsruher BSC',
  'Klubben Næstved',
  'Klør 10 Vejle',
  'Kota Club',
  'Köln Lindenthal BC',
  'KSB Radkov',
  'Kultcamp Rieneck',
  'Mersin BSK',
  'Midt Trøndelag',
  'Mike Lawrence Club',
  'Moss BK',
  'Møre og Romsdal',
  'Nancy Jarville',
  'Näsby BK',
  'Niski BK',
  'Næstved BK',
  'Nord Trøndelag',
  'OBK Kloverknekt',
  'Odense BK',
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
  'Rødovre BK',
  'Semen Padang',
  'Sporting Club',
  'Studentenes BK',
  'Sunndalsøra BK',
  'Tromsø BK',
  'Van Bric SK',
  'Young Sharks',
  'Åkirkeby Bridgeklub',
  'Århus Bridgeklub'
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
  "BC 't Onstein" => ["bc 't onsten", "'t onstein"],
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
  'Bornova BSK' => ['bornova bbsk'],
  'Calcutta Bridge Club' => ['calcutta bridgeclub'],
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
  'Istanbul BK' => ['istanbul bmsk', 'istanbul brýç sk',
    'istanbul bric sk', 'istanbul briç sk', 'istanbul sk'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'Izmir BSB/Turkiye', 'izmir bsbs',
    'izmir bbsk'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'Mersin BSK' => ['mersin b.b.k.', 'mersin b.b.k.', 'mersin b.s.b',
    'mersin bsb', 'mersin bsbs', 'mersin bþb', 'mersn ybsk'],
  'Midt Trøndelag' => ['midt trondelag', 'midt-trøndelag'],
  'Niski BK' => ['niski bridz klub'],
  'Nord Trøndelag' => ['nord -trøndelag', 'nord-trøndelag',
    'nord-trløndelag'],
  'OBK Kløverknekt' => ['obk kloverknekt', 'obk/kløverknekt'],
  'One Eyed Jacks' => ['one-eyed jacks'],
  'Quantum BC' => ['bc quantum'],
  'Qi Zhong Club' => ['qi zhong'],
  'Qin Lian Club' => ['qin lian'],
  'Østfold og Follo' => ['østfold/follo'],
  'Øvre Ottadalen' => ['øvre ottadal'],
  'Rødovre BK' => ['rødovre bridgeklub'],
  'Studentenes BK' => ['studentene bk'],
  'Sunndalsøra BK' => ['Sunndalsøra', 'Sunndalsora'],
  'Tromsø BK' => ['tromso', 'tromsoe bk'],
  'Åkirkeby Bridgeklub' => ['aakirkeby bk'],
  'Århus Bridgeklub'=> ['århus bk', 'Aarhus BK',
    'Aarhus Bridgeklub']
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
  'ABA Mumbai' => ['aba'],
  'Akademisk Bridgeklub' => ['akademisk'],
  'BC Bamberger Reiter' => ['bamberger'],
  'BK 2000' => ['bk2000'],
  'Cerkezkoy Dinamik BSK' => ['Cerkezkoy'],
  'Heimdal BK' => ['heimdal'],
  'Izmir BSB' =>['izmir.b.b.']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
