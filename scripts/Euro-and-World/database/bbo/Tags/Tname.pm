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
use Tags::Tnames::Chile;
use Tags::Tnames::China;
use Tags::Tnames::Croatia;
use Tags::Tnames::Denmark;
use Tags::Tnames::Egypt;
use Tags::Tnames::EuroAdult;
use Tags::Tnames::EuroYouth;
use Tags::Tnames::Faroe;
use Tags::Tnames::Finland;
use Tags::Tnames::France;
use Tags::Tnames::Germany;
use Tags::Tnames::Greece;
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
use Tags::Tnames::Netherlands;
use Tags::Tnames::Nordic;
use Tags::Tnames::Norway;
use Tags::Tnames::Poland;
use Tags::Tnames::Portugal;
use Tags::Tnames::Romania;
use Tags::Tnames::Russia;
use Tags::Tnames::Serbia;
use Tags::Tnames::Singapore;
use Tags::Tnames::Slovakia;
use Tags::Tnames::SouthAmerica;
use Tags::Tnames::Spain;
use Tags::Tnames::Supra;
use Tags::Tnames::Sweden;
use Tags::Tnames::Switzerland;
use Tags::Tnames::Taipei;
use Tags::Tnames::Turkey;
use Tags::Tnames::UK;
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
  CHILE => \&Tags::Tnames::Chile::set_hash,
  CHINA => \&Tags::Tnames::China::set_hash,
  CROATIA => \&Tags::Tnames::Croatia::set_hash,
  DENMARK => \&Tags::Tnames::Denmark::set_hash,
  EGYPT => \&Tags::Tnames::Egypt::set_hash,
  EUROADULT => \&Tags::Tnames::EuroAdult::set_hash,
  EUROYOUTH => \&Tags::Tnames::EuroYouth::set_hash,
  FAROE => \&Tags::Tnames::Faroe::set_hash,
  FINLAND => \&Tags::Tnames::Finland::set_hash,
  FRANCE => \&Tags::Tnames::France::set_hash,
  GERMANY => \&Tags::Tnames::Germany::set_hash,
  GREECE => \&Tags::Tnames::Greece::set_hash,
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
  NETHERLANDS => \&Tags::Tnames::Netherlands::set_hash,
  NORDIC => \&Tags::Tnames::Nordic::set_hash,
  POLAND => \&Tags::Tnames::Poland::set_hash,
  PORTUGAL => \&Tags::Tnames::Portugal::set_hash,
  ROMANIA => \&Tags::Tnames::Romania::set_hash,
  RUSSIA => \&Tags::Tnames::Russia::set_hash,
  SERBIA => \&Tags::Tnames::Serbia::set_hash,
  SINGAPORE => \&Tags::Tnames::Singapore::set_hash,
  SLOVAKIA => \&Tags::Tnames::Slovakia::set_hash,
  SOUTHAMERICA => \&Tags::Tnames::SouthAmerica::set_hash,
  SPAIN => \&Tags::Tnames::Spain::set_hash,
  SUPRA => \&Tags::Tnames::Supra::set_hash,
  SWEDEN => \&Tags::Tnames::Sweden::set_hash,
  SWITZERLAND => \&Tags::Tnames::Switzerland::set_hash,
  TAIPEI => \&Tags::Tnames::Taipei::set_hash,
  TURKEY => \&Tags::Tnames::Turkey::set_hash,
  UK => \&Tags::Tnames::UK::set_hash,
  WORLD => \&Tags::Tnames::World::set_hash,
);

my @MULTI_WORDS =
(
  ### These are the only ones that are not specific (in time/place)
  ### tournament "names".

  # FRIENDLY
  'Argentina Friendly',
  'Australia Challenge',
  'Australia Practice',
  'Bay Area Challenge',
  'Brighton Exhibition',
  'Canada Practice',
  'Chile Practice',
  'China Friendly',
  'Denmark Friendly',
  'Denmark Practice',
  'France Friendly',
  'France Friendly Pairs',
  'France Practice',
  'Germany Friendly Pairs',
  'Goulash Practice',
  'Hong Kong Friendly',
  'Hungary Challenge',
  'Hungary Exhibition',
  'Hungary Friendly',
  'Hungary Practice',
  'Iceland Exhibition',
  'Ireland Friendly',
  'Italy Friendly',
  'Italy Practice',
  'Morocco Friendly',
  'Netherlands Friendly',
  'Netherlands Friendly Pairs',
  'Netherlands Practice',
  'Online Friendly',
  'Poland Friendly',
  'Poland Mixed Friendly Pairs',
  'Poland Practice',
  'Portugal Friendly',
  'Portugal Practice',
  'Scotland Exhibition',
  'Scotland Friendly',
  'Scotland Practice',
  'Spain Challenge',
  'Spain Friendly',
  'Sweden Friendly',
  'Sweden Practice',
  'Taiwan Practice',
  'Tunisia Friendly',
  'Turkey Practice',
  'Zulawski Friendly',

  # ASIA/MIDDLE EAST
  'BFAME Friendship Pairs',
  'BFAME Open Teams',
  'BFAME Senior Teams',
  'BFAME Women Teams',
  'Pan Arab Inter-Club Championship',
  'Yeh Bros Cup',

  # CENTRAL AMERICA
  'Central American & Caribbean Open Teams',
  'Central American & Caribbean Transnational Teams',

  # CZECH
  'Czech First League',
  'Czech Open',
  'Grand Prix of Prague',

  # ECUADOR
  'Ecuador Open Teams',

  # HONG KONG
  'Hong Kong Inter-City Open Teams',
  'Hong Kong Inter-City Women Teams',
  'Hong Kong New Year Teams',

  # MONACO
  'Patton de Monaco',
  'Prince Albert II Cup',

  # NEW ZEALAND
  'Centre Island Open Teams',
  'New Zealand Inter-Provincial Open Teams',
  'New Zealand Open Teams',
  'New Zealand Open Trials',
  'New Zealand Women Trials',

  # PAKISTAN
  'Pakistan Day Open Teams',
  'Pakistan Open Trials',

  # SOUTH AFRICA
  'South African Inter-Province Teams',
  'South African Open Teams',

  # USA
  '0 to 1500 Spingold',
  'Collegiate Bowl',
  'Grand National Teams',
  "Missouri Braggin' Rights",
  'Philadelphia Solomon Teams',
  'Reisinger BAM Teams',
  'Spingold Teams',
  "Sternberg Women's BAM Teams",
  'US Girls Trials',
  'US Juniors Training',
  'US Junior Trials',
  'US Open Trials',
  'US Senior Teams',
  'US Senior Trials',
  'US University Trials',
  'US Women Teams',
  'US Women Trials',
  'US Youngster Trials',
  'USBF Charity Match',
  'Vanderbilt Teams',
  'Wagar Teams',

  # VENEZUELA
  'Venezuelan Mixed Teams',
  'Venezuelan Swiss Pairs',

  # ----------------------------------------------------

);

my %MULTI_TYPOS =
(
  ### AAA

  'Atlantic Trade Bridge Cup' => ['atlantic grupa bridge cup'],

  'Scottish Exhibition' => [
    'm lawrence exhibiton',
    'mike lawrence exhibition'],

  ### CCC

  'Central American & Caribbean Open Teams' => [
    'cac final',
    "cacbf zonal c'ships", 
    "cacbf zonal ch'ships",
    "cacbf zonal cha'ships",
    'cacbf zonal championship', 
    'central america & caribean championship',
    'central american & caribbean championship',
    'central american zonal championships'],
  'Centre Island Open Teams' => ['ci teams'],
  "Champions' Cup" => [
    'champions cup', 
    "champion's cup", 
    'chamions cup', 
    'champs cup', 
    'champion cup', 
    "champion'scup", 
    "champions'cup"],

  # CZECH
  'Czech Championship' => ['czech bridge championship',
    'czech bridge championships'],
  'Czech First League' => ['czech bridge league', 'czech bridge league',
    'czech premier league'],
  'Czech Team Championship' => ['czech team championships',
    'czech teams champ_'],
  'Czech First League' => ['czech 1st league', 'czech bridge league',
    'czech premier league'],

  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],

  ### DDD

  'Dutch Women' => ['ducth woman'],

  ### EEE

  'Ecuador Open Teams' => [
    'ecuador open team trials',
    'ecuador teams champinonship'],

  'Estoril Open Teams' => [
    'estoril international teams', 
    'estoril internacional teams',
    'estoril swiss teams',
    'estoril teams'],

  'forumbridge.pl Top Individual' => ['forumbridge_pl top individual'],
  'forumbridge.pl Top Pairs' => ['forumbridge_pl top pairs'],

  ### GGG

  'Grand National Teams' => ['gnt championship'],

  'Grand Prix of Prague' => [
    'grand prix prague', 'gp prague'],

  ### HHH

  'Hong Kong Inter-City Open Teams' => [
    'hong kong iner-city',
    'hong kong inter-city',
    'JP Morgan Inter-City Championship',
    'JP Morgan Inter-City Bridge Championship',
    'JP Morgan Intercity Bridge Championships',
    'JP Morgan Intercity Bridge Championships-Open',
    'JP Morgan Intercity Bridge Championships-Open T_',
    'JP Morgan Intercity Bridge Championships-Open  T_'],

  ### MMM

  "Missouri Braggin' Rights" => ['bragging rights'],

  ###  NNN

  'NABC Senior Knock-Out Teams' => ['nabc senior ko teams'],
 "New Year's Teams" => ['new year greet tm'],

  # NEW ZEALAND -- mapped in detail
  'New Zealand Inter-Provincial Open Teams' => [
    'nz interprovincial',
    'nz interprovincials',
    'new zealand inter provincials'],
  'New Zealand Open Teams' => ['nz teams'],

  ### OOO

 'Opening Tournament' => ['opening tournement'],

  ### PPP

  'Pakistan Day Open Teams' => [
    'pakistan day bridge championship',
    'pakistan day bridge'],
  'Pakistan Open Trials' => [
    'pakistan national trials',
    'pakistan open national trials',
    'pakistan open team national bridge trials',
    'pakistan open team naational trials',
    'pakistan open team national trials',
    'pakistan open team trials', 
    'pakistan trial'],
  'Pan Arab Inter-Club Championship' => [
    'pan arab championship',
    'pan arab iner club',
    'pan arab inter_club', 
    'pan arab inter-club', 
    'pan arab inter club', 
    'pan arab interclub'],
  'Patton de Monaco' => ["monaco's patton", 'patton international monaco',
    'patton international monte-carlo',
    'patton international monte carlo', 'patton monte carlo'],
  'Philadelphia Solomon Teams' => [
    'solomon teams'],

  ### SSS
  'Senior Camrose' => ['seniors camrose'],

  # SOUTH AFRICA
  'South African Inter-Province Teams' => [
    'sa interprovincial',
    'sa interprovincials',
    'sa inter provincials'],
  'South African Open Teams' => [
    'sa team champs',
    'sa teams',
    'sa teams champs',
    'south african chaionships',
    'south african championship',
    'south african championships',
    'south african nationals',
    'south african teams'],

  'Spring Nationals' => [
    'spring nat', 
    'spring national', 
    'spring nats',
    'sping national', 
    'spring nat opens'],
  "Sternberg Women's BAM Teams" => ['marsha may sternberg bam'],

  ### UUU

  'Spingold Teams' => [
    'spingold knockout',
    'spingold knockout teams'],
  'US Girls Trials' => [
    'junior usbc rona',
    'jusbc rona'],
  'US Junior Trials' => [
    'us junior teams',
    'usbf junior trials'],
  'US Open Trials' => [
    'us itt', 
    'us itt trials', 
    'usa international team trials',
    'usa itt',
    'usa team trial'],
  'US Senior Teams' => [
    'baze senior knock-out',
    'baze senior ko', 
    'baze sr_ ko',
    'baze sr_ ko', 
    'baze sr ko',
    'nabc senior ko',
    'nabc senior knock-out teams',
    'united states seniors bridge championship',
    'us senior',
    'us seniors'],
  'US Senior Trials' => [
    'usa seniors team trials',
    'usa seniors trials', 
    'usbf senior team trials',
    'usbf senior trials', 
    'usbf seniors trials'],
  'US Women' => ['us womens championships'],
  'US Women Teams' => [
    'united states women bridge championship',
    "us women's bridge championship", 
    "us women's bridge championhip",
    "united states women's bridge championship"],
  'US Youngsters' => ['u-21 us'],
  'US Youngster Trials' => [
    'jusbc u21',
    'us u-21 trials',
    'u-21 us trials'],
  'USBF Charity Match' => ['usbf jr/pro charity challenge match'],

  ### VVV

  'Vanderbilt Teams' => [
    'vanderbilt teams', 
    'vanderbilt ko teams'],
  'Venezuelan Swiss Pairs' => ['venezuela parejas suizas',
    'venezuela swiss pairs'],

  ### WWW

  'Wagar Teams' => [
    'wagar teams', 
    "wagar women's", 
    "wagar women's ko",
    'wagar womens ko'],

  'Yeh Bros Cup' => ['yehbros cup', 'yer bros cup'],
  'Youth Open Bridge Paris' => ['youth paris open bridge'],

);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Argentinian Club Teams' => ['cnia'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Gianarrigo Rona Trophy' => ['rona'],
  'Grand National Open Teams' => ['gnot'],
  'Grand National Teams' => ['gnt'],
  'NTU Cup' => ['ntucup'],
  'Portuguese Open Teams' => ['cneo'],
  'Reisinger BAM Teams' => [
    'reisiger', 
    'reisinger', 
    'resisinger'],
  'Spingold Teams' => ['spingold'],
  'Transnational Open Teams' => ['tnt', 'tnot'],
  'US Junior Trials' => ['usjbc', 'jusbc'],
  'US Juniors Training' => ['jtp'],
  'US Senior Teams' => ['ussbc'],
  'US Women Teams' => [
    'uswbc', 
    'uswbf', 
    'uswc',
    'us womens championships'],
  'Vanderbilt Teams' => [
    'vanderbilt', 
    'vanderbuilt', 
    'vanderebilt', 
    'vandebilt', 
    'vandy'],
  'Wagar Teams' => ['wagar'],
);

sub set_hashes
{
  my ($method, $key) = @_;

  # while (my ($key, $set_method) = each %DIVISIONS)
  # {
    # $set_method->(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  # }

  Tags::Tnames::Africa::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Argentina::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Asia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Australia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Austria::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Balkan::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Baltic::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Belarus::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Belgium::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Bolivia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Brazil::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Bulgaria::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, 
    \%SINGLE_TYPOS);
  Tags::Tnames::Canada::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Chile::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::China::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Croatia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Denmark::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Egypt::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::EuroAdult::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::EuroYouth::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Faroe::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Finland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::France::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Germany::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Greece::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Hungary::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Iceland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::India::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Indonesia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Ireland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Israel::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Italy::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Japan::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Jordan::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Lebanon::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Netherlands::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Nordic::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Norway::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Poland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Portugal::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Romania::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Russia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Serbia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Singapore::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Slovakia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::SouthAmerica::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Spain::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Supra::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Sweden::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Switzerland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Taipei::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Turkey::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::UK::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::World::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
