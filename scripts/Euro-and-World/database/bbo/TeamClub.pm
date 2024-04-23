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
  'ABA Mumbai',
  'Akademisk Bridgeklub',
  'Altay GSKD',
  'Altay Genclik',
  'Annecy BC',
  'BC Bamberger Reiter',
  "BC 't Onstein",
  'BC Allegra',
  'BC Bonn',
  'BC Bremen',
  'BC Burghausen',
  'BC Darmstadt Alert',
  'BC Grant Thornton',
  'BC Ketsch',
  'BC Kiel',
  'BC Mannheim',
  'BC München',
  'BC Nürnberg',
  'BC Oldenburg',
  'BC Saarbrücken 1984',
  'BC Schwäbisch Hall',
  'BC Stuttgart',
  'BK 1936',
  'BK 83 Slagelse',
  'BK Nord Aalborg',
  'Diyarbakýr Sur BSK',
  'Drammen Arbeiderparti',
  'Heimdal BK',
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
  'ABA Mumbai' => ['aba - mumbai', 'aba-mumbai'],
  'Akademisk Bridgeklub' => ['akademisk bk'],
  'Altay GSKD' => ['altay gsk', 'altay sdgskd', 'altay sk'],
  'BC Bamberger Reiter' => ['bc bamberg', 'bamberger reiter',
    'bv bamberger reiter', 'bamberg rider', 'bamberg cavaliers',
    'bamberger germany', 'bamberger welle'],
  'BC Grant Thornton' => ['bc grant-thornton'],
  'Diyarbakýr Sur BSK' => ['diyarbakir bs', 'diyarbakir bsbs', 
    'dýyarbakir sur. b.b', 'diyarbakir sur sk', 'sur belediye sk',
    'sur belediye', 'd.bakýr sur', 'd.bakir sur'],
  'Drammen Arbeiderparti' => ['drammen arb'],
  'Heimdal BK' => ['heimdal'],
  'Karlsruher BSC' => ['karlsruher bc'],
  'Köln Lindenthal BC' => ['köln lindenthal', 'köln-lindenthal',
    'köln-lindenthaler', 'köln-lindenthaler b'],
  'One Eyed Jacks' => ['one-eyed jacks'],
  'Tromsø BK' => ['tromso', 'tromsoe bk'],
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
  'ABA Mumbai' => ['aba']
);


sub set_hashes_team_club
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
