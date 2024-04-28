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
  'Altay GSKD',
  'Altay Genclik',
  'Annecy BC',
  'Ballerup Bridgeklub',
  'Blakset Klubberne',
  'BC 52 Berlin',
  "BC 't Onstein",
  'BC Allegra',
  'BC Bamberger Reiter',
  'BC Barcelona',
  'BC Bielefeld',
  'BC Bonn',
  'BC Brasov',
  'BC Bremen',
  'BC Burghausen',
  'BC Clichy',
  'BC Darmstadt Alert',
  'BC Garches',
  'BC Grant Thornton',
  'BC Ketsch',
  'BC Kiel',
  'BC Lille',
  'BC Mannheim',
  'BC Modalfa',
  'BC München',
  'BC Nürnberg',
  'BC Oldenburg',
  'BC Saarbrücken 1984',
  'BC Schwäbisch Hall',
  'BC Stuttgart',
  'BC Universität Mannheim',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Lavec Smile',
  'BK Nord Aalborg',
  'Diyarbakýr Sur BSK',
  'Drammen Arbeiderparti',
  'Heimdal BK',
  'Izmir BSB',
  'Karlsruher BSC',
  'Kota Club',
  'Köln Lindenthal BC',
  'Mike Lawrence Club',
  'Nancy Jarville',
  'One Eyed Jacks',
  'Phoenix Oltenita',
  'Qingnian Qiche',
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
  'Altay GSKD' => ['altay gsk', 'altay sdgskd', 'altay sk'],
  'Ballerup Bridgeklub' => ['ballerup bc'],
  'Blakset Klubberne' => ['blakset-klubberne'],
  "BC 't Onstein" => ["bc 't onsten"],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bv bamberger reiter', 'bamberg rider', 'bamberg cavaliers',
    'bamberger germany', 'bamberger welle', 'bamberg riders'],
  'BC Grant Thornton' => ['bc grant-thornton'],
  'BC Universität Mannheim' => ['bc uni mannheim'],
  'BK Lavec Smile' => ['bk lavec - smile', 'bk lavek smile'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'Heimdal BK' => ['heimdal'],
  'Izmir BSB' => ['ýzmýr býlýmsel bk', 'ýzmýt saraybahçe sk',
    'ýzmir b.s. belediye', 'ýzmir bsb', 'ýzmir bþb', 
    'izmir bilimsel', 'izmir buyuksehir', 'izmir b.b.s.k',
    'izmir b.s. belediye', 'Izmir BSB/Turkiye', 'izmir bsbs',
    'izmir.b.b.', 'izmir bbsk', 'izmir b.b.', 'izmir b.b.s.k'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'One Eyed Jacks' => ['one-eyed jacks'],
  'Tromsø BK' => ['tromso', 'tromsoe bk'],
  'Åkirkeby Bridgeklub' => ['aakirkeby bk'],
  'Århus Bridgeklub'=> ['århus bk', 'Aarhus BK',
    'Aarhus Bridgeklub']
);

my @SINGLE_WORDS = qw(
  Hordaland
  Sakura
  Østerdal
);

my %SINGLE_TYPOS =
(
  'ABA Mumbai' => ['aba'],
  'Akademisk Bridgeklub' => ['akademisk'],
  'BC Bamberger Reiter' => ['bamberger']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
