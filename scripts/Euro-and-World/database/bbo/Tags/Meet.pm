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
  'Bodrum Peninsula Festival',
  'Brasov Festival',
  'Buffett Cup',
  'Cappadocia Fairy Chimneys Festival',
  'Channel Trophy',
  'Crete Bridge Festival',
  'Estoril Bridge Festival',

  'FISU World University Championships',

  'Fes Festival',
  'Festival della Matematica',
  'Greek Islands Festival',

  'IMSA Elite Mind Games',
  'International Bridge Festival',
  'Jyvaskala Easter Bridge Festival',
  'Lozenets Bridge Festival',
  'Maharaja Holkar National Championship',
  'Marmara Festival',
  'Mersin Bridge Festival',
  'Monaco International Festival',
  'Neighbor Challenge',
  'North American Bridge Championship',
  'Pärnu Festival',
  'Polish Grand Prix',
  'Polish Pairs Championship',
  'Polish Youth Olympiad',
  'Polish Schools Championship',
  'Pula Bridge Festival',
  'Sivrioglu Festival',
  'Stara Zagora Bridge Festival',
  'Swedish Women Trials',
  'Swedish Bridge Festival',
  'Tallinn Bridge Festival',
  'Thailand National Games',
  'Turkish Autumn Festival',
  'Turkish-Greek Friendship Festival',
  'Turkish Open Trials',
  'Turkish Women Trials',
  'Umea Bridgefestival',
  'United States Bridge Championship',
  'Vanke Cup',
  'VVE Beheer Bridge Week',
  'Wachauer Bridge Festival',
  'West Java Regional',
  'Winter Bridge Festival',
  'Winter Championships',
  'World Series',
  'World Mind Games',
  'World Team Championships',
  'World Team Olympiad',
  'World Youth Championships',
  'World Youth Open Championships',
);

my %MULTI_TYPOS =
(
  'Azores Festival' => ['azores festival bridge', 'azores bridge open',
    'azores bridge teams', 'azores team', 'azores teams',
    'azores team festval', 'festival azores bridge', 'azores festiva', 
    'festival azores'],
  'Bodrum Peninsula Festival' => ['bodrum yarýmada bric festivali'],
  'Brasov Festival' => ['festival brasov', 'festival bridge brasov',
    'international bridge festival brasov',
    'festivalul international de bridge brasov'],
  'Buffett Cup' => ['buffet cup', 'bufett cup'],
  'Channel Trophy' => ['channel trpohy'],
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
  'Monaco International Festival' => ['festival international de monaco'],
  'Neighbor Challenge' => ['neighbour challenge'],
   'Practice Match' => [
     'practice match', 
     'practice matche', 
     'practice matches',
     'practice session', 
     'practise match',
     'training match',
     'tes match', 
     'test match'], 
  'Pula Bridge Festival' => ['international festival pula',
    'pula bridge festiwal'],
  'Stara Zagora Bridge Festival' => ['bridge festival - stara zagora',
    'bridge festival stara zagora', 
    'bridge festival-bulgaria-stara zagora'],
  'Swedish Women Trials' => [
    'sweden women euro trials',
    'swedish women euro trials'],
  'Tallinn Bridge Festival' => ['talinn festival', 'tallin festival',
    'tallinns festival'],
  'Turkish Autumn Festival' => ['sonbahar bridge festival'],
  'Turkish-Greek Friendship Festival' => [
    'greek-turkish friendship festival'],
  'Turkish Open Trials' => [
    'turkey open national team selection',
    'turkey open team trials',
    'turkish national team selection',
    'turkish national open team selection',
    'turkish open national selection',
    'turkish open national team selection',
    'turkish open team selection',
    'turkish open team trials'],
  'Turkish Women Trials' => [
    'turkish woman national selection',
    'turkish woman team trials',
    'turkish women national selection',
    'turkish women team selection'],
  'United States Bridge Championship' => ['us bridge championship',
    'u_s_b_c', 'united states bridge championships'],
  'VVE Beheer Bridge Week' => ['vve-beheer bridgeweek',
    'vve-beheer bridge week'],
  'West Java Regional' => ['west java regional sport games',
    'west java regional games', 'west java regional spots event',
    'regional west java'],
  'Winter Championships' => ['winter championship',
    'winter championsship'],
  'World Series' => ['world bridge series'],
  'World Mind Games' => ['world mind game', 'word mind games', 'wmsg',
    'mind sports games', 'sawmg', 'wmg', 'wnsg', 'world ming games'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
  'World Youth Championships' => [
    'world youth bridge team championship',
    'world youth championship',
    'world youth team championships',
    'world youth teams',
    'world youth teams championship'],
  'World Youth Open Championships' => [
    'wboyc',
    'wyobc',
    'world youht congress',
    'world youth congress',
    'world youth open bridge championship',
    'world youth bridge congress',
    'workd youth bridge congress',
    'worlf youth bridge congress', 
    'youth world bridge congress'],
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
  'North American Bridge Championship' => ['nabc'],
  'United States Bridge Championship' => ['usbc'],
  'World Series' => ['wbs'],
  'World Team Championships' => ['wbtc'],
  'World Team Olympiad' => ['olympiad', 'olympiads', 'wbo'],
  'World Youth Championships' => ['wytc', 'wybtc'],
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
