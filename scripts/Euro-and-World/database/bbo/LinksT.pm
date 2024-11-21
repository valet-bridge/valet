#!perl

package LinksT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(init_linksT);

use lib '.';
use lib '..';

use Tournaments::Friendly;

use Tournaments::Africa;
use Tournaments::Argentina;
use Tournaments::Asia;
use Tournaments::Australia;
use Tournaments::Austria;
use Tournaments::Balkan;
use Tournaments::Baltic;
use Tournaments::Belarus;
use Tournaments::Belgium;
use Tournaments::Bolivia;
use Tournaments::Brazil;
use Tournaments::Bulgaria;
use Tournaments::Canada;
use Tournaments::CentralAmerica;
use Tournaments::Chile;
use Tournaments::China;
use Tournaments::Czech;
use Tournaments::Croatia;
use Tournaments::Denmark;
use Tournaments::Ecuador;
use Tournaments::Egypt;
use Tournaments::EuroAdult;
use Tournaments::EuroYouth;
use Tournaments::Faroe;
use Tournaments::Finland;
use Tournaments::France;
use Tournaments::Germany;
use Tournaments::Greece;
use Tournaments::HongKong;
use Tournaments::Hungary;
use Tournaments::Iceland;
use Tournaments::India;
use Tournaments::Indonesia;
use Tournaments::Ireland;
use Tournaments::Israel;
use Tournaments::Italy;
use Tournaments::Japan;
use Tournaments::Jordan;
use Tournaments::Lebanon;
use Tournaments::MiddleEast;
use Tournaments::Monaco;
use Tournaments::Netherlands;
use Tournaments::NewZealand;
use Tournaments::Nordic;
use Tournaments::Norway;
use Tournaments::Pakistan;
use Tournaments::Poland;
use Tournaments::Portugal;
use Tournaments::Romania;
use Tournaments::Russia;
use Tournaments::Serbia;
use Tournaments::Slovakia;
use Tournaments::Singapore;
use Tournaments::SouthAfrica;
use Tournaments::SouthAmerica;
use Tournaments::Spain;
use Tournaments::Supra;
use Tournaments::Sweden;
use Tournaments::Switzerland;
use Tournaments::Taipei;
use Tournaments::Thailand;
use Tournaments::Turkey;
use Tournaments::UK;
use Tournaments::USA;
use Tournaments::Venezuela;
use Tournaments::World;


my %DIVISIONS =
(
  FRIENDLY => \&Tournaments::Friendly::set_links,
  
  AFRICA => \&Tournaments::Africa::set_links,
  ARGENTINA => \&Tournaments::Argentina::set_links,
  ASIA => \&Tournaments::Asia::set_links,
  AUSTRALIA => \&Tournaments::Australia::set_links,
  AUSTRIA => \&Tournaments::Austria::set_links,
  BALKAN => \&Tournaments::Balkan::set_links,
  BALTIC => \&Tournaments::Baltic::set_links,
  BELARUS => \&Tournaments::Belarus::set_links,
  BELGIUM => \&Tournaments::Belgium::set_links,
  BOLIVIA => \&Tournaments::Bolivia::set_links,
  BRAZIL => \&Tournaments::Brazil::set_links,
  BULGARIA => \&Tournaments::Bulgaria::set_links,
  CANADA => \&Tournaments::Canada::set_links,
  CENTRALAMERICA => \&Tournaments::CentralAmerica::set_links,
  CHILE => \&Tournaments::Chile::set_links,
  CHINA => \&Tournaments::China::set_links,
  CZECH => \&Tournaments::Czech::set_links,
  CROATIA => \&Tournaments::Croatia::set_links,
  DENMARK => \&Tournaments::Denmark::set_links,
  ECUADOR => \&Tournaments::Ecuador::set_links,
  EGYPT => \&Tournaments::Egypt::set_links,
  EUROADULT => \&Tournaments::EuroAdult::set_links,
  EUROYOUTH => \&Tournaments::EuroYouth::set_links,
  FAROE => \&Tournaments::Faroe::set_links,
  FINLAND => \&Tournaments::Finland::set_links,
  FRANCE => \&Tournaments::France::set_links,
  GERMANY => \&Tournaments::Germany::set_links,
  GREECE => \&Tournaments::Greece::set_links,
  HONGKONG => \&Tournaments::HongKong::set_links,
  HUNGARY => \&Tournaments::Hungary::set_links,
  ICELAND => \&Tournaments::Iceland::set_links,
  INDIA => \&Tournaments::India::set_links,
  INDONESIA => \&Tournaments::Indonesia::set_links,
  IRELAND => \&Tournaments::Ireland::set_links,
  ISRAEL => \&Tournaments::Israel::set_links,
  ITALY => \&Tournaments::Italy::set_links,
  JAPAN => \&Tournaments::Japan::set_links,
  JORDAN => \&Tournaments::Jordan::set_links,
  LEBANON => \&Tournaments::Lebanon::set_links,
  MIDDLEEAST => \&Tournaments::MiddleEast::set_links,
  MONACO => \&Tournaments::Monaco::set_links,
  NETHERLANDS => \&Tournaments::Netherlands::set_links,
  NEWZEALAND => \&Tournaments::NewZealand::set_links,
  NORDIC => \&Tournaments::Nordic::set_links,
  NORWAY => \&Tournaments::Norway::set_links,
  PAKISTAN => \&Tournaments::Pakistan::set_links,
  POLAND => \&Tournaments::Poland::set_links,
  PORTUGAL => \&Tournaments::Portugal::set_links,
  ROMANIA => \&Tournaments::Romania::set_links,
  RUSSIA => \&Tournaments::Russia::set_links,
  SERBIA => \&Tournaments::Serbia::set_links,
  SINGAPORE => \&Tournaments::Singapore::set_links,
  SLOVAKIA => \&Tournaments::Slovakia::set_links,
  SOUTHAFRICA => \&Tournaments::SouthAfrica::set_links,
  SOUTHAMERICA => \&Tournaments::SouthAmerica::set_links,
  SPAIN => \&Tournaments::Spain::set_links,
  SUPRA => \&Tournaments::Supra::set_links,
  SWEDEN => \&Tournaments::Sweden::set_links,
  SWITZERLAND => \&Tournaments::Switzerland::set_links,
  TAIPEI => \&Tournaments::Taipei::set_links,
  THAILAND => \&Tournaments::Thailand::set_links,
  TURKEY => \&Tournaments::Turkey::set_links,
  UK => \&Tournaments::UK::set_links,
  USA => \&Tournaments::USA::set_links,
  VENEZUELA => \&Tournaments::Venezuela::set_links,
  WORLD => \&Tournaments::World::set_links
);


sub init_linksT
{
  my ($divisions) = @_;
  %$divisions = %DIVISIONS;
}

1;
