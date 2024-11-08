#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tname;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use Tags::Tnames::Africa;
use Tags::Tnames::Argentina;
use Tags::Tnames::Asia;
use Tags::Tnames::Australia;
use Tags::Tnames::Austria;
use Tags::Tnames::Balkan;
use Tags::Tnames::Baltic;
use Tags::Tnames::Belarus;
use Tags::Tnames::Belgium;
use Tags::Tnames::Bolivia;
use Tags::Tnames::Brazil;
use Tags::Tnames::Bulgaria;
use Tags::Tnames::Canada;
use Tags::Tnames::CentralAmerica;
use Tags::Tnames::Chile;
use Tags::Tnames::China;
use Tags::Tnames::Croatia;
use Tags::Tnames::Czech;
use Tags::Tnames::Denmark;
use Tags::Tnames::Ecuador;
use Tags::Tnames::Egypt;
use Tags::Tnames::EuroAdult;
use Tags::Tnames::EuroYouth;
use Tags::Tnames::Faroe;
use Tags::Tnames::Finland;
use Tags::Tnames::France;
use Tags::Tnames::Friendly;
use Tags::Tnames::Germany;
use Tags::Tnames::Greece;
use Tags::Tnames::HongKong;
use Tags::Tnames::Hungary;
use Tags::Tnames::Iceland;
use Tags::Tnames::India;
use Tags::Tnames::Indonesia;
use Tags::Tnames::Ireland;
use Tags::Tnames::Israel;
use Tags::Tnames::Italy;
use Tags::Tnames::Japan;
use Tags::Tnames::Jordan;
use Tags::Tnames::Lebanon;
use Tags::Tnames::MiddleEast;
use Tags::Tnames::Monaco;
use Tags::Tnames::Netherlands;
use Tags::Tnames::NewZealand;
use Tags::Tnames::Nordic;
use Tags::Tnames::Norway;
use Tags::Tnames::Pakistan;
use Tags::Tnames::Poland;
use Tags::Tnames::Portugal;
use Tags::Tnames::Romania;
use Tags::Tnames::Russia;
use Tags::Tnames::Serbia;
use Tags::Tnames::Singapore;
use Tags::Tnames::Slovakia;
use Tags::Tnames::SouthAfrica;
use Tags::Tnames::SouthAmerica;
use Tags::Tnames::Spain;
use Tags::Tnames::Supra;
use Tags::Tnames::Sweden;
use Tags::Tnames::Switzerland;
use Tags::Tnames::Taipei;
use Tags::Tnames::Turkey;
use Tags::Tnames::UK;
use Tags::Tnames::USA;
use Tags::Tnames::Venezuela;
use Tags::Tnames::World;

my %DIVISIONS =
(
  AFRICA => \&Tags::Tnames::Africa::set_hash,
  ARGENTINA => \&Tags::Tnames::Argentina::set_hash,
  ASIA => \&Tags::Tnames::Asia::set_hash,
  AUSTRALIA => \&Tags::Tnames::Australia::set_hash,
  AUSTRIA => \&Tags::Tnames::Austria::set_hash,
  BALKAN => \&Tags::Tnames::Balkan::set_hash,
  BALTIC => \&Tags::Tnames::Baltic::set_hash,
  BELARUS => \&Tags::Tnames::Belarus::set_hash,
  BELGIUM => \&Tags::Tnames::Belgium::set_hash,
  BOLIVIA => \&Tags::Tnames::Bolivia::set_hash,
  BRAZIL => \&Tags::Tnames::Brazil::set_hash,
  BULGARIA => \&Tags::Tnames::Bulgaria::set_hash,
  CANADA => \&Tags::Tnames::Canada::set_hash,
  CENTRALAMERICA => \&Tags::Tnames::CentralAmerica::set_hash,
  CHILE => \&Tags::Tnames::Chile::set_hash,
  CHINA => \&Tags::Tnames::China::set_hash,
  CROATIA => \&Tags::Tnames::Croatia::set_hash,
  CZECH => \&Tags::Tnames::Czech::set_hash,
  DENMARK => \&Tags::Tnames::Denmark::set_hash,
  ECUADOR => \&Tags::Tnames::Ecuador::set_hash,
  EGYPT => \&Tags::Tnames::Egypt::set_hash,
  EUROADULT => \&Tags::Tnames::EuroAdult::set_hash,
  EUROYOUTH => \&Tags::Tnames::EuroYouth::set_hash,
  FAROE => \&Tags::Tnames::Faroe::set_hash,
  FINLAND => \&Tags::Tnames::Finland::set_hash,
  FRANCE => \&Tags::Tnames::France::set_hash,
  FRIENDLY => \&Tags::Tnames::Friendly::set_hash,
  GERMANY => \&Tags::Tnames::Germany::set_hash,
  GREECE => \&Tags::Tnames::Greece::set_hash,
  HONGKONG => \&Tags::Tnames::HongKong::set_hash,
  HUNGARY => \&Tags::Tnames::Hungary::set_hash,
  ICELAND => \&Tags::Tnames::Iceland::set_hash,
  INDIA => \&Tags::Tnames::India::set_hash,
  INDONESIA => \&Tags::Tnames::Indonesia::set_hash,
  IRELAND => \&Tags::Tnames::Ireland::set_hash,
  ISRAEL => \&Tags::Tnames::Israel::set_hash,
  ITALY => \&Tags::Tnames::Italy::set_hash,
  JAPAN => \&Tags::Tnames::Japan::set_hash,
  JORDAN => \&Tags::Tnames::Jordan::set_hash,
  LEBANON => \&Tags::Tnames::Lebanon::set_hash,
  MIDDLEEAST => \&Tags::Tnames::MiddleEast::set_hash,
  MONACO => \&Tags::Tnames::Monaco::set_hash,
  NETHERLANDS => \&Tags::Tnames::Netherlands::set_hash,
  NEWZEALAND => \&Tags::Tnames::NewZealand::set_hash,
  NORDIC => \&Tags::Tnames::Nordic::set_hash,
  NORWAY => \&Tags::Tnames::Norway::set_hash,
  PAKISTAN => \&Tags::Tnames::Pakistan::set_hash,
  POLAND => \&Tags::Tnames::Poland::set_hash,
  PORTUGAL => \&Tags::Tnames::Portugal::set_hash,
  ROMANIA => \&Tags::Tnames::Romania::set_hash,
  RUSSIA => \&Tags::Tnames::Russia::set_hash,
  SERBIA => \&Tags::Tnames::Serbia::set_hash,
  SINGAPORE => \&Tags::Tnames::Singapore::set_hash,
  SLOVAKIA => \&Tags::Tnames::Slovakia::set_hash,
  SOUTHAFRICA => \&Tags::Tnames::SouthAfrica::set_hash,
  SOUTHAMERICA => \&Tags::Tnames::SouthAmerica::set_hash,
  SPAIN => \&Tags::Tnames::Spain::set_hash,
  SUPRA => \&Tags::Tnames::Supra::set_hash,
  SWEDEN => \&Tags::Tnames::Sweden::set_hash,
  SWITZERLAND => \&Tags::Tnames::Switzerland::set_hash,
  TAIPEI => \&Tags::Tnames::Taipei::set_hash,
  TURKEY => \&Tags::Tnames::Turkey::set_hash,
  UK => \&Tags::Tnames::UK::set_hash,
  USA => \&Tags::Tnames::USA::set_hash,
  VENEZUELA => \&Tags::Tnames::Venezuela::set_hash,
  WORLD => \&Tags::Tnames::World::set_hash,
);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
);

sub set_hashes
{
  my ($method, $key) = @_;

  while (my ($key, $set_method) = each %DIVISIONS)
  {
    $set_method->(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  }

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
