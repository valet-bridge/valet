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
use Tags::Tnames::Chile;
use Tags::Tnames::China;
use Tags::Tnames::Denmark;
use Tags::Tnames::Finland;
use Tags::Tnames::France;
use Tags::Tnames::Germany;
use Tags::Tnames::Hungary;
use Tags::Tnames::India;
use Tags::Tnames::Indonesia;
use Tags::Tnames::Israel;
use Tags::Tnames::Italy;
use Tags::Tnames::Norway;
use Tags::Tnames::Poland;
use Tags::Tnames::Portugal;
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

  # CANADA
  'Canadian National Teams Championship',
  'Canadian Seniors Teams Championship',
  'Canadian Women Teams Championship',

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

  # EUROPE
  "European Open Champions' Cup",
  'European National Mixed Teams',
  'European National Open Teams',
  'European National Seniors Pairs',
  'European National Seniors Teams',
  'European National Women Pairs',
  'European National Women Teams',
  'European Small Federation Games',
  'European Transnational Mixed Pairs',
  'European Transnational Mixed Teams',
  'European Transnational Open Pairs',
  'European Transnational Open Teams',
  'European Transnational Seniors Teams',
  'European Winter BAM Trophy',
  'European Winter Teams',
  'European Winter Transnational Teams',
  "European Women Open Champions' Cup",
  'Generali European Open Teams',
  'Generali European Women Pairs',
  'Generali European Women Teams',

  # EURO-YOUTH
  'European U16 Open Pairs',
  'European U16 Open Teams',
  'European U21 Open Pairs',
  'European U21 Open Teams',
  'European U26 Mixed Pairs',
  'European U26 Open IMP Pairs',
  'European U26 Open Pairs',
  'European U26 Open Teams',
  'European U26 Women Pairs',
  'European U26 Women Teams',
  'European U31 Open Pairs',
  "European U31 President's Cup",
  'European University Bridge Championship',
  'European University Team Championship',

  # FAROE ISLANDS
  'Faroese Open Teams',

  # GREECE
  'Greek Central Regional Pairs',
  'Greek Mixed Pairs',
  'Greek Northern Regional',
  'Greek Open Teams',
  'Greek Open Pair Trials',
  'Greek Open Team Trials',
  'Greek Women Trials',
  'Thanos Capayiannides Memorial Simultaneous',

  # HONG KONG
  'Hong Kong Inter-City Open Teams',
  'Hong Kong Inter-City Women Teams',
  'Hong Kong New Year Teams',

  # ICELAND
  'Iceland Express Pairs',
  'Iceland Express Teams',
  'Icelandair Open Pairs',
  'Icelandair Open Teams',
  'Icelandic Cup',
  'Icelandic Open Teams',

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

  # NETHERLANDS
  'ArboNed Team Cup',
  'Arnhem Interbridge Tournament',
  'Carrousel Cup',
  'Dutch Knock-Out Cup',
  'Dutch Meesterklasse',
  'Forbo-Krommenie Nations Cup',
  'Jaap Kokkes Tournament',
  'Petit Grand Prix van Driene',
  'The Hague Open Teams',
  'The Hague Pro-Am Pairs',
  'Top Circuit',
  'Top Circuit Teams',
  'White House International',
  'White House Juniors',
  'White House Top 12',

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

  # ROMANIA
  'Romanian League',
  'Romanian Second League',
  'Romanian Open Teams',
  'Romanian Open Trials',

  # RUSSIA
  'BKBT Teams',
  'Moscow Sunday Times Pairs',
  'Moscow Sunday Times Teams',
  'NN Cup',
  'Russian IMSA Cup',
  'Russian Open Teams',
  'Russian Premier League',
  'Slava Cup',

  # SERBIA
  'Serbian Cup',
  'Serbian Inter-City Teams',
  'Serbian Open Teams',
  'Serbian Open Trials',
  'Serbian Premier League',
  'Vrnjacka Banja Open Teams',

  # SINGAPORE
  'Pesta Sukan',
  'Singapore Open Teams',

  # SLOVAKIA
  'Slovakian Open Teams',

  # SOUTH AFRICA
  'South African Inter-Province Teams',
  'South African Open Teams',

  # SOUTH AMERICA
  'South American Junior Teams',
  'South American Open Pairs',
  'South American Open Teams',
  'South American Open Trials',
  'South American Senior Trials',
  'South American Seniors Teams',
  'South American Women Teams',
  'South American Women Trials',

  # SPAIN
  'Las Palmas Simultaneous Pairs',
  'Las Palmas Women Pairs',
  'Madrid Senior Teams',
  'Open Catalunya Preferent Pairs',
  'Open Catalunya Preferent Teams',
  'Spanish Central Zone Teams',
  'Spanish Mixed Teams',
  'Spanish Open Teams',
  'Spanish Open Trials',
  'Spanish Senior Trials',

  # SUPRA
  'Buffett Cup Individual',
  'Cavendish Open Pairs',
  'Cavendish Women Pairs',
  'Cavendish Teams',
  'Channel Girls Trophy',
  'Channel Juniors Trophy',
  'Channel Schools Trophy',
  'Computer World Championship',
  'Neighbor Challenge IMP Pairs',
  'Neighbor Challenge Open Teams',
  'Neighbor Challenge Women Teams',
  'NYSA Euroregion Nations Cup',
  'Stern-Cornell Trophy',
  'Paris Youth Open Teams',

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

  'ArboNed Team Cup' => ['arbo ned team cup', 'arbo ned teams cup'],

  'Arnhem Interbridge Tournament' => ['interbridge tournament'],
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

  # BELGIUM
  'BKBT Teams' => ['bkbt match'],

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


  # CANADA -- mapped in detail
  'Canadian National Teams Championship' => [
    'canadian a tm', 
    'canadian champ open', 
    'canadian national team',
    'canadian open teams',
    'canadian open teams championship',
    'canadian tm a',
    'can open teams championship',
    'can open team championship', 
    'can_ champ open'],
  'Canadian Seniors Championship' => [
    'canadian champ senior', 
    'canadian champs senior',
    'canadian senior championship',
    'canadian senior teams',
    'canadian senior tm'],
  'Canadian Women Teams Championship' => [
    'can ladies bridge champs',
    'can ladies team champ',
    'cbc womens finals',
    'cbf womens final',
    'cbf womens finals'],

  'Cavendish Open Pairs' => [
    'cavemdish pairs',
    'cavendish monaco pairs',
    'cavendish pair',
    'cavendish pairs',
    'cavendiish pairs',
    'cavendiosh pairs',
    'cavendsh pairs'],
  'Cavendish Women Pairs' => [
    'cavendish monaco pairs women'],
  'Cavendish Teams' => [
    'avendish teams',
    'cavendish tms', 
    'cavendish team'],
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
  'Channel Girls Trophy' => ['channel trophy girls'],
  'Channel Schools Trophy' => ['channel trophy schools'],

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
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],

  ### DDD

  'Dutch Knock-Out Cup' => ['knock-out team cup netherlands',
    'knock out team cup netherlands'],
  'Dutch Meesterklasse' => [
    'dutch mk', 
    'dutch team',
    'dutch teams',
    'dutch club teams'],
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

  # EUROPE -- mapped in detail
  "European Champions' Cup" => ['european champs cup'],
  'European National Mixed Teams' => [
    'euro mixed teams',
    'european mixed teams'],
  'European National Open Teams' => [
    'eur champ pau open'],
  'European National Women Teams' => [
    'eur champ pau woman',
    'eur champ pau women',
    'eur women champ'],
  'European National Seniors Teams' => [
    'eur champ pau senior',
    'eur champ pau seniors'],
  'European Small Federation Games' => [
    'ebl small federation trophy',
    'ebl small federations trophy', 
    'games of small federations',
    'european small federations games', 
    'small federation games',
    'small federations games', 
    'small ffederations games',
    'small federation cup', 
    'european small feds games',
    'small f federations games', 
    'europian small federation games'],
  'European Transnational Mixed Teams' => [
    'euro open mixed teams'],
  'European Winter Teams' => [
    'zimmermann cup'],
  'Generali European Open Teams' => [
    'generali euro team champs',
    'generali european team championships'],

  ### EURO-YOUTH: Mapped in detail
  'European U16 Open Teams' => [
    'ebl schools'],
  'European U21 Open Teams' => [
    'euro yongster championships',
    'euro youngster championship',
    'euro youngster championships',
    'euro youngsters championship',
    'euro youngsters championships',
    'european youngster bridge championship'],
  'European U26 Mixed Pairs' => [
    'em pairs junior mix',
    'european mixed pairs pairs',
    'eyjc mixed pairs',
    'junior em mix'],
  'European U26 Open Pairs' => [
    'european youth bridge pairs championship',
    'european youth pairs'],
  'European U26 Open Teams' => [
    'ebl juniors',
    'euro juniors championship',
    'euro juniors championships',
    'european junior teams',
    'european junior teams championship',
    'european junior teams championships',
    'euroepan junior teams championships',
    'european juniors championship',
    'european juniors championships',
    'european youth teams u26',
    'european youth bridge team champ', 
    'european youth teams'],
  'European U26 Women Teams' => [
    'european girls championships',
    'european girls teams',
    'euro girls championships'],
  'European University Bridge Championship' => [
    'european university championship',
    'european universities bridge championship',
    'european univeristies bridge championship',
    'european universities championship',
    'european unibridge championship',
    'european uni bridge championship',
    'european uni championship'],
  'European University Team Championship' => [
    'european universities bridge trophy',
    'eusa games'],

  ### FFF

  'Faroese Open Teams' => [
    'faroese tc', 
    'faroese team championships',
    'faroese teams'],

  'forumbridge.pl Top Individual' => ['forumbridge_pl top individual'],
  'forumbridge.pl Top Pairs' => ['forumbridge_pl top pairs'],

  ### GGG

  'Grand National Teams' => ['gnt championship'],

  # GREECE
  'Greek Central Regional Pairs' => [
    'regional championship of central greece'],
  'Greek Mixed Pairs' => [
    'hellenic mixed pairs',
    'hellenik mixed pairs'],
  'Greek Northern Regional' => [
    'n_ greece regional championship'],
  'Greek Open Teams' => [
    'greek natioanal teams', 
    'greek open nationa team',
    'grekk open national team', 
    'greek open team', 
    'greek open team championship', 
    'greek team',
    'greek teams',
    'hellenic teams championship'],
  'Greek Open Team Trials' => [
    'greek national team trials',
    'greek national teams trials',
    'greek national trials', 
    'greek open nationa team trials',
    'greek open national team trials',
    'greek open team trials',
    'greek trials', 
    'grekk open national team trials',
    'helenic national team trials',
    'hellenic national team trials',
    'hellenic national teams trials',
    'hellenic open team trials',
    'hellenic team trials',
    'hellenic teams trials'], 
  'Greek Women Trials' => [
    'hellenic ladies team trials',
    'hellenic ladies teams trials'],

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

  # ICELAND
  'Iceland Express Teams' => ['iceland express team'],
  'Icelandair Open Teams' => [
    'icelandair open',
    'icelandair team championship',
    'icelandari open'],
  'Icelandic Cup' => [
    'bikarkeppni bsí', 
    'icelandic champions cup',
    'icelandoc cup',
    'iceland cup'],
  'Icelandic Open Teams' => [
    'iceland teams',
    'icelandic team', 
    'icelandic team championship', 
    'icelandic team championsship',
    'icelandic team chapmionship', 
    'icelandic team championships',
    'icelandic teamhampionship', 
    'icelandic teams'],


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

  'Jaap Kokkes Tournament' => [
    'jaap kokkes toernooi',
    'jaap kookes toernooi',
    'jaap kokkes'],
  'Japanese Open Trials' => ['japanese open team trial',
    'japanese open team trials'],
  'Jean Besse Cup' => ['cup jean besse', 'cup jean besser'],
  'Jordan Open Pairs' => [
    'jordanese open pairs'],
  'Jordan Mixed Pairs' => [
    'jordan spring mix pairs',
    'jordan spring mixed pairs'],

  ### KKK

  'Forbo-Krommenie Nations Cup' => [
    'forbo krommenie teams',
    'forbo nations cup',
    'forbo teams',
    'forbo-krommenie international bridge event',
    'forbo-krommenie tourname',
    'forbo-krommenie tournament',
    'international forbo krommenie bridge event',
    'krommenie nations cup'],

  ### LLL

  'Las Palmas Simultaneous Pairs' => ['simultaneo de mayo las palmas'],
  'Lebanese Invitational Teams' => [
    'lebanese invitational team',
    'lebanon invitational team',
    'lebanon invitational teams'],

  ### MMM

  'Madrid Senior Teams' => ['equipos senior madrid'],
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

  'NN Cup' => [
    'goulyash by e. gladysh',
    'goulyash by e_gladysh',
    'nn-cup'],

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

  'NYSA Euroregion Nations Cup' => ['cup of euroregion nysa'],

  ### OOO

  'Open Catalunya Preferent Pairs' => [
    'open cataluña preferent', 
    'open catalunya preferent', 
    'open preferent'], 
  'Open Catalunya Preferent Teams' => [
    'open catalunya equips',
    'open equips preferent',
    'open preferent equips'],
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
  'Paris Youth Open Teams' => ['youth open bridge paris'],
  'Patton de Monaco' => ["monaco's patton", 'patton international monaco',
    'patton international monte-carlo',
    'patton international monte carlo', 'patton monte carlo'],
  'Petit Grand Prix van Driene' => ['petit grand prix',
    'grand prix van driene'],
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

  # ROMANIA -- mapped in detail
  'Romanian League' => [
    'cn ecgipe',
    'cn echipe', 
    'c_n_ echipe', 
    'divizia a', 
    'national romanian teams',
    'romanian national teams div a', 
    'romanian national division', 
    'romanian national teams- div a', 
    'romanian team championship',
    'romanian teams-a division', 
    'romanian teams- a division'],
  'Romanian Open Teams' => [
    'romanian national champ_',
    'romanian national champs',
    'romanian national championship',
    'romanian national championships teams',
    'romanian national team championship',
    'romanian national team championships',
    'romanian national team champs',
    'romanian national teams', 
    'romanian national teams championships',
    'romanian teams'],
  'Romanian Open Trials' => [
    'romanian national team selection',
    'romanian national trials',
    'romanian open teams trial',
    'romanian open teams trials',
    'romanian open trials',
    'romanian selection'], 
  'Romanian Second League' => [
    'cn echipe div b',
    'cn echipe div b seria a',
    'cn ecgipe div b seria a'],

  # RUSSIA
  'Russian IMSA Cup' => ['imsa cup'],
  'Russian Open Teams' => ['russian teams championship',
    'russian team championship'],
  'Russian Premier League' => ['russian premiere league'],

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

  'Serbian Cup' => [
    'cup of serbia', 
    'cup srbije', 
    'kup srbije'],
  'Serbian Open Teams' => [
    'serbian bridge championship',
    'serbia teams championship',
    'serbian tam championship', 
    'serbian team championship',
    'serbian teams championship',
    'serbianteam championship', 
    'serbian closed team championship'],
  'Serbian Open Trials' => [
    'open serbian trials',
    'serbian open team trials',
    'serbian open trial', 
    'serbian teams trial'],
  'Serbian Premier League' => [
    'serbian league', 
    'serbian premier leaugue',
    'serbian premier leauge'],

  'Slava Cup' => ['cup slava', 'salava cup'],
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

  # SOUTH AMERICA
  'South American Junior Teams' => [
    'south american junior championship',
    'south american junior championships',
    'south american junioor championships',
    'youth sabc'],
  'South American Open Pairs' => [
    'sudamericano de parejas',
    'sudamericano de parejas libres'],
  'South American Open Teams' => [
    'libres sudamericano',
    'southamerican open championship',
    'sudamericano libre equipos',
    'sudamericano libres'],
  'South American Senior Teams' => [
    'clasificacion sudamericano seniors',
    'south american senior championship'],
  'South American Women Teams' => [
    'clasificatoria damas equipos',
    'clasificatoria equipos damas', 
    'sudamericano damas'],
  'South American Senior Trials' => [
    'seleccion sudamericano senior'],

  # SPAIN
  'Spanish Central Zone Teams' => [
    'equipos zonal centro',
    'zonal centro equipos'],
  'Spanish Mixed Teams' => [
    'spanish mixed national teams'],
  'Spanish Open Teams' => [
    'camp esp',
    'campeonato de españa por equipos',
    'campeonato espan', 
    'campeonato espanaonda', 
    'spanish national championship',
    'spanish national teams',
    'spanish national teams championship',
    'spanish teams', 
    'spanish teams championship',
    "spanish teams ch'ship",
    'spain teams'],
  'Spanish Open Trials' => [
    'open seleccion mundial'],
  'Spanish Senior Trials' => [
    'prueba de seleccion equipos senior'],

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

  ### TTT

  'Thanos Capayiannides Memorial Simultaneous' => [
    'thanos capayiannides'],
  'Top Circuit' => ['melchemie top circuit',
    'ing bank top circuit', 'witte huis topcircuit'],

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
  'White House International' => [
    'white house international teams',
    'white house top 16',
    'white house tournament teams'],
  'White House Juniors' => [
    'qhite house juniors',
    'the white hous juniors',
    'white house junior',
    'white house junior internationals',
    'whiteouse juniors'], 
  'White House Top 12' => ['modalfa top 12', 'witte huis top 12'],
  'White House Top 16' => ['white house int. teams top 16',
    'white house int_ teams top 16',
    'white house international top 16 teams'],

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
  'Australian Autumn National Open Teams' => ['anot'],
  'Australian National Open Teams' => ['not'],
  'Australian National Senior Teams' => ['nst'],
  'Australian National Women Teams' => ['nwt'],
  'Australian Spring Open Teams' => ['snot'],
  'Bobby Evans Seniors Teams' => ['best'],
  'Brazilian Open Teams' => ['brasilchamp'],
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc', 'cnst'],
  'Canadian Women Teams Championship' => ['cwtc'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish', 'cav'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Copenhagen Invitational Pairs' => ['cbi'],
  'Danish Championship' => ['dm'],
  'Dutch Meesterklasse' => ['meesterklasse'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Small Federation Games' => ['esfg', 'sfc'],
  'European University Bridge Championship' => ['eubc', 'eucb', 'euc'],
  'European Youth Bridge Championship' => ['eybc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'European Youth Bridge Teams Championship' => ['eytc', 'jem'],
  'Gianarrigo Rona Trophy' => ['rona'],
  'Grand National Open Teams' => ['gnot'],
  'Grand National Teams' => ['gnt'],
  "Gro's Supercup" => ['grocup'],
  'Icelandair Open' => ['icelandair'],
  "Linda Stern Women's Teams" => ['lswt'],
  'NTU Cup' => ['ntucup'],
  'Paris Youth Open Teams' => ['ypob'],
  'Portuguese Open Teams' => ['cneo'],
  'Reisinger BAM Teams' => [
    'reisiger', 
    'reisinger', 
    'resisinger'],
  'Spingold Teams' => ['spingold'],
  'Prince Takamatsu Cup' => ['takamatsu'],
  'Top Circuit' => ['topcircuit'],
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
  'Victorian Pennant' => ['pennant'],
  'Wagar Teams' => ['wagar'],
  'White House Juniors' => ['whj'],
  'European Winter Teams' => ['zc']
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
  Tags::Tnames::Chile::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::China::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Denmark::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Finland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::France::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Germany::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Hungary::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::India::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Indonesia::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Israel::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Italy::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Norway::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Poland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Portugal::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Sweden::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Taipei::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Turkey::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::UK::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::World::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
