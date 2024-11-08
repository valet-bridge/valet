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
use Tags::Tnames::Balkan;
use Tags::Tnames::Baltic;
use Tags::Tnames::Belgium;
use Tags::Tnames::Bulgaria;
use Tags::Tnames::Canada;
use Tags::Tnames::Chile;
use Tags::Tnames::China;
use Tags::Tnames::Denmark;
use Tags::Tnames::EuroAdult;
use Tags::Tnames::EuroYouth;
use Tags::Tnames::Finland;
use Tags::Tnames::France;
use Tags::Tnames::Germany;
use Tags::Tnames::Greece;
use Tags::Tnames::Hungary;
use Tags::Tnames::Iceland;
use Tags::Tnames::India;
use Tags::Tnames::Indonesia;
use Tags::Tnames::Israel;
use Tags::Tnames::Italy;
use Tags::Tnames::Netherlands;
use Tags::Tnames::Norway;
use Tags::Tnames::Poland;
use Tags::Tnames::Portugal;
use Tags::Tnames::Romania;
use Tags::Tnames::Russia;
use Tags::Tnames::Serbia;
use Tags::Tnames::SouthAmerica;
use Tags::Tnames::Spain;
use Tags::Tnames::Supra;
use Tags::Tnames::Sweden;
use Tags::Tnames::Taipei;
use Tags::Tnames::Turkey;
use Tags::Tnames::UK;
use Tags::Tnames::World;

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

  # AUSTRIA
  'Austrian Open Teams',

  # BELARUS
  'Belarusian Open Teams',

  # BOLIVIA
  'Bolivian Open Teams',

  # BRAZIL
  'Brazilian Senior Trials',
  'Brazilian Open Teams',
  'Brazilian Open Trials',
  'Brazilian Women Trials',
  'Rio de Janeiro Open Teams',
  'Rio de Janeiro Christmas Individual',
  'Roberto Taunay Cup',
  'Sao Paulo Cup',
  'Sao Paulo State Championship',

  # CENTRAL AMERICA
  'Central American & Caribbean Open Teams',
  'Central American & Caribbean Transnational Teams',

  # CROATIA
  'Atlantic Trade Bridge Cup',
  'Samobor Open Teams',

  # CZECH
  'Czech First League',
  'Czech Open',
  'Grand Prix of Prague',

  # ECUADOR
  'Ecuador Open Teams',

  # EGYPT
  'Egyptian Cup',
  'Egyptian League',

  # FAROE ISLANDS
  'Faroese Open Teams',

  # HONG KONG
  'Hong Kong Inter-City Open Teams',
  'Hong Kong Inter-City Women Teams',
  'Hong Kong New Year Teams',

  # IRELAND
  'Irish Invitational Pairs',
  'Irish Open Trials',
  'Full Tilt Irish Bridge Masters',

  # JAPAN
  'Japanese District KO Teams',
  'Japanese Open Trials',
  'Kanto Teams',
  'NEC Cup',
  'Prince Takamatsu Cup',

  # JORDAN
  'Jordan Mixed Pairs',
  'Jordan Open Pairs',
  'Jordan Open Teams',

  # LEBANON
  'Lebanese Invitational Teams',

  # MONACO
  'Patton de Monaco',
  'Prince Albert II Cup',

  # NEW ZEALAND
  'Centre Island Open Teams',
  'New Zealand Inter-Provincial Open Teams',
  'New Zealand Open Teams',
  'New Zealand Open Trials',
  'New Zealand Women Trials',

  # NORDIC
  'Nordic Cup',
  'Nordic Junior Pairs',
  'Nordic Junior Teams',
  'Nordic Open Teams',
  'Nordic Security Pro-Am Pairs',
  'Nordic Women Teams',

  # PAKISTAN
  'Pakistan Day Open Teams',
  'Pakistan Open Trials',

  # SINGAPORE
  'Pesta Sukan',
  'Singapore Open Teams',

  # SLOVAKIA
  'Slovakian Open Teams',

  # SOUTH AFRICA
  'South African Inter-Province Teams',
  'South African Open Teams',

  # SWITZERLAND
  'Jean Besse Cup',
  'Swiss Club Championship',
  'Swiss Cup',
  'Swiss Open IMP Pairs',
  'Swiss Open Teams',
  'Zurich Open Pairs',
  'Zurich Open Teams',

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

  'Austrian Open Teams' => [
    'austrian team championship',
    'austrian team championships'],

  'Scottish Exhibition' => [
    'm lawrence exhibiton',
    'mike lawrence exhibition'],

  ### BBB

  'Belarusian Open Teams' => ['belarus teams',
    'belarus cup', 'belarus national teams',
    'belarus team championship', 'belarus teams cup',
    'belarusian team championship'],

  # BOLIVIA
  'Bolivian Open Pairs' => ['bolivariano open pairs'],
  'Bolivian Open Teams' => [
    'bbolivariano open teams',
    'bolivariano open teams',
    'bolivarian tournament',
    'campeonato bolivariano de equipos',
    'torneo bolivariano equipos'],

  # BRAZIL
  'Brazilian Open Teams' => [
    'brasil champ', 
    'brasilian championship',
    'brazilian championship',
    'brazilian championships',
    'brazilian chapionship', 
    'brazilian national championship', 
    'brazilian open championship', 
    'brazilian team',
    'brazilian teams',
    'open brazilian championship'],
  'Brazilian Senior Trials' => ['brazilian senior'],
  'Brazilian Women Trials' => ['brazilian ladies trials'],

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

  # EGYPT
  'Egyptian Cup' => ['egy-cup', 'egypt cup', 'egypt-cup', 'egy cup',
    'egy_cup'],
  'Egyptian League' => ['egy_league', 'egy-league',
    'egyptian premier league'],

  'Estoril Open Teams' => [
    'estoril international teams', 
    'estoril internacional teams',
    'estoril swiss teams',
    'estoril teams'],

  ### FFF

  'Faroese Open Teams' => [
    'faroese tc', 
    'faroese team championships',
    'faroese teams'],

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

  ### III


  # IRELAND -- mapped in detail
  'Irish Invitational Pairs' => [
    'ireland invitational pairs',
    'irish invitational matchpoints'],
  'Irish Open Trials' => [
    'ibu trials',
    'ireland trials', 
    'ireland camrose trials', 
    'ireland lady milne trials', 
    'irish bridge union trials',
    'irish bridge union open trials',
    'irish camrose trials', 
    'irish trials'],

  ### JJJ

  'Japanese Open Trials' => ['japanese open team trial',
    'japanese open team trials'],
  'Jean Besse Cup' => ['cup jean besse', 'cup jean besser'],
  'Jordan Open Pairs' => [
    'jordanese open pairs'],
  'Jordan Mixed Pairs' => [
    'jordan spring mix pairs',
    'jordan spring mixed pairs'],

  ### LLL

  'Lebanese Invitational Teams' => [
    'lebanese invitational team',
    'lebanon invitational team',
    'lebanon invitational teams'],

  ### MMM

  "Missouri Braggin' Rights" => ['bragging rights'],

  ###  NNN

  'NABC Senior Knock-Out Teams' => ['nabc senior ko teams'],
  'NEC Cup' => [
    'nec cup bridge festival'],
 "New Year's Teams" => ['new year greet tm'],

  # NEW ZEALAND -- mapped in detail
  'New Zealand Inter-Provincial Open Teams' => [
    'nz interprovincial',
    'nz interprovincials',
    'new zealand inter provincials'],
  'New Zealand Open Teams' => ['nz teams'],

  'Nordic Cup' => [
    'rottneros cup',
    'rottneros nordic cup'],
  'Nordic Junior Pairs' => [
    'nordic junior pair championship',
    'open nordic junior pair', 
    'open nordic junior pairs'],
  'Nordic Junior Teams' => [
    'nordic junior team championship',
    'nordic junior team championships',
    'nordic junior teams championship',
    'nordic junior teams championships'],
  'Nordic Open Teams' => [
    'nordic championship open class',
    'nordic open championship'],
  'Nordic Security Pro-Am Pairs' => [
    'Nordic Security Play against the stars'],
  'Nordic Women Teams' => [
    'nordic women championship',
    'nordics (women)'],

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

  'Prince Takamatsu Cup' => [
    'prince takamatsu memorial cup',
    'takamatsu cup'],

  ### RRR

  'Rio de Janeiro Open Teams' => [
    'rio de janeiro championship',
    'rio de janeiro state final'],
  'Rio de Janeiro Christmas Individual' => [
    'rio de janeiro xmas individual'],

  ### SSS

  'Sao Paulo Cup' => [
    's o paulo cup', 
    'sao paulo state cup', 
    'são paulo cup'], 
  'Sao Paulo State Championship' => [
    'sao paulo champ',
    'sao paulo championship', 
    'sao paulo champ', 
    'sap paulo state championship',
    'são paulo state championship', 
    'sp champ', 
    'sao paulo state'],
  'Senior Camrose' => ['seniors camrose'],

  'Slovakian Open Teams' => ['slovakia open teams'],

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

  # SWITZERLAND
  'Swiss Club Championship' => [
    'interclub swiss team championship',
    'swiss interclubs',
    'swiss interclub championship', 
    'swisss interclubs', 
    'swiss interclub'],
  'Swiss Cup' => [
    'coupe suisse', 
    'swiss open cup', 
    'swiss cuo', 
    'switzerland open cup',

    'champion suisse', 
    'championnat suisse',
    'swiss championshi', 
    'swiss championshio',
    'swiss championship',
    'Swiss open championship',
    'swiss team champiomshio',
    'Swiss team championship'

    ],

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

  ### ZZZ

  'Zurich Open Pairs' => ['zurich imp pairs']
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Argentinian Club Teams' => ['cnia'],
  'Brazilian Open Teams' => ['brasilchamp'],
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
  'Prince Takamatsu Cup' => ['takamatsu'],
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

  Tags::Tnames::Africa::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Argentina::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Asia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Australia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Balkan::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Baltic::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Belgium::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Bulgaria::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, 
    \%SINGLE_TYPOS);
  Tags::Tnames::Canada::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Chile::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::China::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Denmark::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::EuroAdult::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::EuroYouth::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Finland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::France::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Germany::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Greece::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Hungary::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Iceland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::India::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Indonesia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Israel::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Italy::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Netherlands::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Norway::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Poland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Portugal::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Romania::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Russia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Serbia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::SouthAmerica::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Spain::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Supra::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Sweden::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Taipei::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Turkey::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::UK::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::World::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
