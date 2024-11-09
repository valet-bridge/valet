#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meet;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use Tags::Meets::Africa;
use Tags::Meets::Argentina;
use Tags::Meets::Asia;
use Tags::Meets::Australia;
use Tags::Meets::Austria;
use Tags::Meets::Balkan;
use Tags::Meets::Baltic;
use Tags::Meets::Belarus;
use Tags::Meets::Belgium;
use Tags::Meets::Bolivia;
use Tags::Meets::Brazil;
use Tags::Meets::Bulgaria;
use Tags::Meets::Canada;
use Tags::Meets::CentralAmerica;
use Tags::Meets::Chile;
use Tags::Meets::China;
use Tags::Meets::Croatia;
use Tags::Meets::Czech;
use Tags::Meets::Denmark;
use Tags::Meets::Ecuador;
use Tags::Meets::Egypt;
use Tags::Meets::EuroAdult;
use Tags::Meets::EuroYouth;
use Tags::Meets::Faroe;
use Tags::Meets::Finland;
use Tags::Meets::France;
use Tags::Meets::Friendly;
use Tags::Meets::Germany;
use Tags::Meets::Greece;
use Tags::Meets::HongKong;
use Tags::Meets::Hungary;
use Tags::Meets::Iceland;
use Tags::Meets::India;
use Tags::Meets::Indonesia;
use Tags::Meets::Ireland;
use Tags::Meets::Israel;
use Tags::Meets::Italy;
use Tags::Meets::Japan;
use Tags::Meets::Jordan;
use Tags::Meets::Lebanon;
use Tags::Meets::MiddleEast;
use Tags::Meets::Monaco;
use Tags::Meets::Netherlands;
use Tags::Meets::NewZealand;
use Tags::Meets::Nordic;
use Tags::Meets::Norway;
use Tags::Meets::Pakistan;
use Tags::Meets::Poland;
use Tags::Meets::Portugal;
use Tags::Meets::Romania;
use Tags::Meets::Russia;
use Tags::Meets::Serbia;
use Tags::Meets::Singapore;
use Tags::Meets::Slovakia;
use Tags::Meets::SouthAfrica;
use Tags::Meets::SouthAmerica;
use Tags::Meets::Spain;
use Tags::Meets::Supra;
use Tags::Meets::Sweden;
use Tags::Meets::Switzerland;
use Tags::Meets::Taipei;
use Tags::Meets::Turkey;
use Tags::Meets::UK;
use Tags::Meets::USA;
use Tags::Meets::Venezuela;
use Tags::Meets::World;

my %DIVISIONS =
(
  AFRICA => \&Tags::Meets::Africa::set_hash,
  ARGENTINA => \&Tags::Meets::Argentina::set_hash,
  ASIA => \&Tags::Meets::Asia::set_hash,
  AUSTRALIA => \&Tags::Meets::Australia::set_hash,
  AUSTRIA => \&Tags::Meets::Austria::set_hash,
  BALKAN => \&Tags::Meets::Balkan::set_hash,
  BALTIC => \&Tags::Meets::Baltic::set_hash,
  BELARUS => \&Tags::Meets::Belarus::set_hash,
  BELGIUM => \&Tags::Meets::Belgium::set_hash,
  BOLIVIA => \&Tags::Meets::Bolivia::set_hash,
  BRAZIL => \&Tags::Meets::Brazil::set_hash,
  BULGARIA => \&Tags::Meets::Bulgaria::set_hash,
  CANADA => \&Tags::Meets::Canada::set_hash,
  CENTRALAMERICA => \&Tags::Meets::CentralAmerica::set_hash,
  CHILE => \&Tags::Meets::Chile::set_hash,
  CHINA => \&Tags::Meets::China::set_hash,
  CROATIA => \&Tags::Meets::Croatia::set_hash,
  CZECH => \&Tags::Meets::Czech::set_hash,
  DENMARK => \&Tags::Meets::Denmark::set_hash,
  ECUADOR => \&Tags::Meets::Ecuador::set_hash,
  EGYPT => \&Tags::Meets::Egypt::set_hash,
  EUROADULT => \&Tags::Meets::EuroAdult::set_hash,
  EUROYOUTH => \&Tags::Meets::EuroYouth::set_hash,
  FAROE => \&Tags::Meets::Faroe::set_hash,
  FINLAND => \&Tags::Meets::Finland::set_hash,
  FRANCE => \&Tags::Meets::France::set_hash,
  FRIENDLY => \&Tags::Meets::Friendly::set_hash,
  GERMANY => \&Tags::Meets::Germany::set_hash,
  GREECE => \&Tags::Meets::Greece::set_hash,
  HONGKONG => \&Tags::Meets::HongKong::set_hash,
  HUNGARY => \&Tags::Meets::Hungary::set_hash,
  ICELAND => \&Tags::Meets::Iceland::set_hash,
  INDIA => \&Tags::Meets::India::set_hash,
  INDONESIA => \&Tags::Meets::Indonesia::set_hash,
  IRELAND => \&Tags::Meets::Ireland::set_hash,
  ISRAEL => \&Tags::Meets::Israel::set_hash,
  ITALY => \&Tags::Meets::Italy::set_hash,
  JAPAN => \&Tags::Meets::Japan::set_hash,
  JORDAN => \&Tags::Meets::Jordan::set_hash,
  LEBANON => \&Tags::Meets::Lebanon::set_hash,
  MIDDLEEAST => \&Tags::Meets::MiddleEast::set_hash,
  MONACO => \&Tags::Meets::Monaco::set_hash,
  NETHERLANDS => \&Tags::Meets::Netherlands::set_hash,
  NEWZEALAND => \&Tags::Meets::NewZealand::set_hash,
  NORDIC => \&Tags::Meets::Nordic::set_hash,
  NORWAY => \&Tags::Meets::Norway::set_hash,
  PAKISTAN => \&Tags::Meets::Pakistan::set_hash,
  POLAND => \&Tags::Meets::Poland::set_hash,
  PORTUGAL => \&Tags::Meets::Portugal::set_hash,
  ROMANIA => \&Tags::Meets::Romania::set_hash,
  RUSSIA => \&Tags::Meets::Russia::set_hash,
  SERBIA => \&Tags::Meets::Serbia::set_hash,
  SINGAPORE => \&Tags::Meets::Singapore::set_hash,
  SLOVAKIA => \&Tags::Meets::Slovakia::set_hash,
  SOUTHAFRICA => \&Tags::Meets::SouthAfrica::set_hash,
  SOUTHAMERICA => \&Tags::Meets::SouthAmerica::set_hash,
  SPAIN => \&Tags::Meets::Spain::set_hash,
  SUPRA => \&Tags::Meets::Supra::set_hash,
  SWEDEN => \&Tags::Meets::Sweden::set_hash,
  SWITZERLAND => \&Tags::Meets::Switzerland::set_hash,
  TAIPEI => \&Tags::Meets::Taipei::set_hash,
  TURKEY => \&Tags::Meets::Turkey::set_hash,
  UK => \&Tags::Meets::UK::set_hash,
  USA => \&Tags::Meets::USA::set_hash,
  VENEZUELA => \&Tags::Meets::Venezuela::set_hash,
  WORLD => \&Tags::Meets::World::set_hash,
);

my @MULTI_WORDS =
(
  'Aegean Championships',
  'Azores Festival',
  'Amman Bridge Festival',
  'ASEAN Club Championship',
  'Australian Youth Triathlon',
  'Bangkok Bridge Festival',
  'Banten Sports Week',
  'Cappadocia Fairy Chimneys Festival',
  'Crete Bridge Festival',
  'Estoril Bridge Festival',

  'Fes Festival',
  'Festival della Matematica',
  'Greek Islands Festival',

  'International Bridge Festival',
  'Jyvaskala Easter Bridge Festival',
  'Lozenets Bridge Festival',
  'Maharaja Holkar National Championship',
  'Marmara Festival',
  'Mersin Bridge Festival',
  'Pärnu Festival',
  'Pula Bridge Festival',
  'Sivrioglu Festival',
  'Stara Zagora Bridge Festival',
  'Tallinn Bridge Festival',
  'Thailand National Games',
  'Umea Bridgefestival',
  'Vanke Cup',
  'VVE Beheer Bridge Week',
  'Winter Bridge Festival',
  'Winter Championships',
  'World Team Olympiad',
);

my %MULTI_TYPOS =
(
  'Azores Festival' => ['azores festival bridge', 'azores bridge open',
    'azores bridge teams', 'azores team', 'azores teams',
    'azores team festval', 'festival azores bridge', 'azores festiva', 
    'festival azores'],
  'Crete Bridge Festival' => ['crete b_ festival'],
  'Estoril Bridge Festival' => ['estoril festival'],

  'Fes Festival' => ['fes bridge international festival',
    'festival fes', 'festival de fes', 'festival international de fès',
    'festival de fez'],
  'Greek Islands Festival' => ['greek bridge festival',
    'greek island festival', 'athens bridge festival', 
    'greek islands festivals', 'greek festival islands', 'greek islands'],
  'International Bridge Festival' => ['int_ bridge festival'],

  'Jyvaskala Easter Bridge Festival' => ['easter bridge trophy'],

  'Lozenets Bridge Festival' => ['bridge festival lozenets'],

  'Maharaja Holkar National Championship' => [
    'maharaja holakar championship',
    'maharaja holar national open',
    'maharaja holkar bridge championship',
    'maharaja holkar championship',
    'maharaja holkar national open championship',
    'maharaja holkar national tournament',
    'M Yeshwantrao Holkar National Bridge Championship'],
  'Marmara Festival' => ['festival marmara'],
  'Pula Bridge Festival' => ['international festival pula',
    'pula bridge festiwal'],
  'Stara Zagora Bridge Festival' => ['bridge festival - stara zagora',
    'bridge festival stara zagora', 
    'bridge festival-bulgaria-stara zagora'],
  'Tallinn Bridge Festival' => ['talinn festival', 'tallin festival',
    'tallinns festival'],
  'VVE Beheer Bridge Week' => ['vve-beheer bridgeweek',
    'vve-beheer bridge week'],
  'Winter Championships' => ['winter championship',
    'winter championsship'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
);

my @SINGLE_WORDS = qw(
  Congress
  Festival
);

my %SINGLE_TYPOS =
(
  'Australian National Championships' => ['anc'],
  'Bangkok Bridge Festival' => ['bbf', 'bff'],
  "Buffett Cup" => ['buffett', 'buffet'],
  Congress => ['kongres', 'kongresowy'],
  'European National Championships' => ['ec'],
  'European Transnational Championships' => ['eobc', 'eoc'],
  Festival => ['fest', 'festivan', 'festývalý', 'festivalul', 'festiwal'],
  'Gold Coast Congress' => ['gc', 'gcc'],
  'World Team Olympiad' => ['olympiad', 'olympiads', 'wbo'],
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
