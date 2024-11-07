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
use Tags::Tnames::Belgium;
use Tags::Tnames::Bulgaria;
use Tags::Tnames::Chile;
use Tags::Tnames::China;
use Tags::Tnames::Denmark;
use Tags::Tnames::Finland;
use Tags::Tnames::Hungary;
use Tags::Tnames::India;
use Tags::Tnames::Italy;
use Tags::Tnames::Poland;
use Tags::Tnames::Portugal;
use Tags::Tnames::Taipei;

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

  # BALTIC (Estonia, Latvia, Lithuania)
  'Baltic Open Teams',
  'Estonian First League',
  'Estonian Open Pair Trials',
  'Estonian Open Teams',
  'Estonian-Latvian Open Team Trials',
  'Fortuna Cup',
  'Latvia Invites',
  'Lithuanian Open Teams',
  'Riga Invitational Pairs',
  'Riga Open Teams',
  'Towns Cup',
  'Vilnius BAM Pairs',
  'Vilnius Club Pairs',
  'Vilnius IMP Pairs',
  'Vilnius Open Pairs',
  'Vilnius Open Teams',

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

  # FRANCE
  'Biarritz Hiver',
  'Deauville Open Pairs',
  'Deauville Open Teams',
  'Deauville Patton Teams',
  'French Cup',
  'French First Division',
  'French Intercircle',
  'French Junior Trials',
  'French Mixed Teams',
  'French Open Teams',
  'French Open Trials',
  'French Senior Trials',
  'French U28 Trials',
  'French Women Trials',
  'Shield of Thoisy',

  # GERMANY
  'Bonn Nations Cup',
  'German Bundesliga',
  'German Club Cup',
  'German Mixed Teams',
  'German Open Pairs',
  'German Open Teams',
  'German Open Trials',
  'German Team Trophy',
  'German Women Pairs',
  "Gro's Supercup",
  'König Ludwig Cup',

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

  # INDONESIA
  'Electric Cup',
  'FTBC Tanjungpura University',
  'Gabrial UI Bastaman Cup',
  'Geologi Cup',
  'IBWI Women Cup',
  'Indonesian Inter-City Championship',
  'Indonesian Inter-Club Championship',
  'Indonesian Inter-Province Championship',
  'Indonesian Invitational Teams',
  'Indonesian Junior League Online',
  'Indonesian Mixed Pair Trials',
  'Indonesian Mixed Teams',
  'Indonesian Open Pair Trials',
  'Indonesian Open Teams',
  'Indonesian Open Trials',
  'Indonesian Premier League',
  'Indonesian U16 Pair Trials',
  'Indonesian U18 Teams',
  'Indonesian U21 Pair Trials',
  'Indonesian U21 Teams',
  'Indonesian U26 Pair Trials',
  'Indonesian U26 Teams',
  'Indonesian U26 Women Pair Trials',
  'Indonesian U31 Teams',
  'Indonesian U31 Women Teams',
  'Indonesian Women Pair Trials',
  'Indonesian Women Teams',
  'Indonesian Women Trials',
  "Kepri Governor's Cup",
  'Menpora-Pertamina Cup',
  'Pahlawan Cup',
  'Pertamina Field Tambun Cup',
  'PLN Cup',
  'PT Timah Invitational Teams',
  'Rector University of Brawijaya Cup',
  'Sarundajang Cup',
  'Semen Padang Cup',
  'Telkom Indonesia Open',

  # IRELAND
  'Irish Invitational Pairs',
  'Irish Open Trials',
  'Full Tilt Irish Bridge Masters',

  # ISRAEL
  'Four Nations Cup',
  'Israel Cup',
  'Israel Juniors Pairs',
  'Israel Juniors Trials',
  'Israel IMP Pairs',
  'Israel Open Pairs',
  'Israel Open Teams',
  'Israel Open Trials',
  'Israel School Trials',
  'Israel Women Pairs',
  'Maccabi Games',
  'Rand Pairs Cup',
  'Rand Teams Cup',

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

  # NORWAY
  'Bergen Grand Open Pairs',
  'Codan Teams Cup',
  'Farmen Invitational',
  'FOSS Grand Pairs',
  'FX Securities Pairs Cup',
  'Gardermoen Airport Hotel Pairs',
  'Gardermoen Airport Hotel Teams',
  "Jessheim New Year's Pairs",
  "Jessheim New Year's Teams",
  'Marit Sveaas Open Pairs',
  'Mo i Rana Ladies Invitational',
  'Namsos Pairs Cup',
  'Norwegian Club Pairs',
  'Norwegian Club Teams',
  'Norwegian Corporate Championship',
  'Norwegian Mixed Pairs',
  'Norwegian Mixed Teams',
  'Norwegian Open IMP Pairs',
  'Norwegian Open Pairs',
  'Norwegian Open Teams',
  'Norwegian Premier League',
  'Norwegian Senior Teams',
  'Norwegian Swiss Pairs',
  'Norwegian Swiss Teams',
  'Norwegian Team Trials',
  'Norwegian Women Invitational Pairs',
  'Norwegian Women Teams',
  'Olrud Easter Mixed Pairs',
  'Olrud Easter Swiss Pairs',
  'Olrud Easter Swiss Teams',
  'Ragn-Sells International Open Pairs',
  'Rondane Pairs Cup',
  'Rondane Teams Cup',
  'Rosfjord Swiss Teams',
  'Ruter 7 Open Pairs',
  'Snåsa Pairs Cup',
  'Trondheim Pairs Cup',
  'Trondheim Teams Cup',
  'Vest-Agder Regional Team Championship',
  'Willy Brown Memorial Pairs',

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

  # SWEDEN
  "Chairman's Cup",
  'Filbyter Cup',
  'Park Hotell Swiss Teams',
  'S:t Erik Championship Series',
  'Stena Line Cup',
  'Stockholm Teams',
  'Swedish Cup',
  'Swedish District Teams',
  'Swedish Juniors Pairs',
  'Swedish Juniors Teams',
  'Swedish Mixed Teams',
  'Swedish Open Pairs',
  'Swedish Open Teams',
  'Swedish Open Pair Trials',
  'Swedish Open Team Trials',
  'Swedish Premier League',
  'Swedish Senior Team Trials',
  'Swedish Women Pair Trials',
  'Swedish Women Team Trials',

  # SWITZERLAND
  'Jean Besse Cup',
  'Swiss Club Championship',
  'Swiss Cup',
  'Swiss Open IMP Pairs',
  'Swiss Open Teams',
  'Zurich Open Pairs',
  'Zurich Open Teams',

  # TURKEY
  'Anatolian Club Teams',
  'Anatolian Fall Teams',
  'Anatolian Spring Teams',
  'Ankara Summer Teams',
  'Balikcioglu Open Teams',
  'Fatih Kiral Pairs',
  'Gelibolu Peace Teams',
  'Goksu-Yalikavak Pairs',
  'Istanbul Summer Teams',
  'Istanbul Winter Teams',
  'Izmir Teams Cup',
  'Izmir Winter Teams Cup',
  'Lüleburgaz Liberation Cup',
  'Marmara Inter-Club Championship',
  'Murat Kilercioglu Turkish Spring Teams',
  'Necmettin Sunget Teams Cup',
  'Salvador Assael IMP Pairs',
  'Salvador Assael Pro-Am Pairs',
  'Thrace Cup League',
  'Turkish Club Championship',
  'Turkish East Mediterranean Teams',
  'Turkish Junior Pairs',
  'Turkish Mixed Team Trials',
  'Turkish Mixed Teams',
  'Turkish Open Pair Trials',
  'Turkish Open Team Trials',
  'Turkish Open Teams',
  'Turkish Swiss Mixed Teams',
  'Turkish U16 Pairs',
  'Turkish University Teams',
  'Turkish Winter Open Teams',
  'Turkish Winter Women Teams',
  'Turkish Women Pair Trials',
  'Turkish Women Team Trials',
  'Turkish Women Teams',
  'Western Mediterranean Club Teams',

  # UNITED KINGDOM
  'British Gold Cup',
  'Camrose Trophy',
  'Commonwealth Nations Bridge Championships',
  'Corn Cairdis Match',
  'English Open Trials',
  'English Premier League',
  'English Senior Trials',
  'English U28 Trials',
  'English Women Teams',
  'English Women Trials',
  'Garden Cities Teams',
  'Glasgow Transnational Open Teams',
  'Higson Teams Cup',
  'Junior Camrose',
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  'Peggy Bayer Trophy',
  'Scottish Cup',
  'Scottish National League',
  'Spring Foursomes',
  'Teltscher Trophy',
  'TGR Auction Pairs',
  'TGR Auction Teams',
  'TGR Super League',
  'Welsh Invitational Pairs',
  'Welsh Open Trials',
  'Young Chelsea Knock-out',

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

  # WORLD
  'APBF Women Elite Tournament',
  'Bermuda Bowl',
  'Damiani Trophy',
  "d'Orsi",
  'Huayuan Cup',
  'IMSA Elite Open Individual',
  'IMSA Elite Open Pairs',
  'IMSA Elite Open Teams',
  'IMSA Elite Women Individual',
  'IMSA Elite Women Pairs',
  'IMSA Elite Women Teams',
  'IOC Grand Prix',
  'McConnell Cup',
  'Oly-Star Cup',
  'Rona Cup',
  'Rosenblum Cup',
  'Tianjin Binhai Cup',
  'Venice Cup',
  'World Kids Teams',
  'World Masters Individual',
  'World Mixed Pairs',
  'World Mixed Teams',
  'World Open Girl Pairs',
  'World Open Girl Teams',
  'World Open Junior IMP Pairs',
  'World Open Junior Pairs',
  'World Open Junior Teams',
  'World Open Pairs',
  'World Open Youngster Pairs',
  'World Open Youngster Teams',
  'World Open Youth BAM Teams',
  'World Top Tournament',
  'World Transnational Mixed Teams',
  'World Transnational Open Teams',
  'World University Teams',
  'World Youngster Teams',
  'WMG Men Individual',
  'WMG Men Pairs',
  'WMG Men Teams',
  'WMG Open Individual',
  'WMG Open Pairs',
  'WMG Open Teams',
  'WMG Senior Teams',
  'WMG U21 Teams',
  'WMG U26 Teams',
  'WMG U28 Teams',
  'WMG Women Individual',
  'WMG Women Pairs',
  'WMG Women Teams',

  # ----------------------------------------------------

);

my %MULTI_TYPOS =
(
  ### AAA

  'Anatolian Club Teams' => [
    'anatolian club qualifying',
    'eastern anatolian qualification',
    'eastern anatolýa qualýfýcatýon',
    'turkish interclubs champ_ anatolia elections'],
  'Anatolian Fall Teams' => ['anatolian side fall teams'],
  # 'Anatolian Open Teams' => ['anatolian side bridge clubs open teams'],
  'Anatolian Spring Teams' => ['anatolia spring teams'],
  'Ankara Summer Teams' => ['ankara summer team championship'],
  'ArboNed Team Cup' => ['arbo ned team cup', 'arbo ned teams cup'],

  'Arnhem Interbridge Tournament' => ['interbridge tournament'],
  'Atlantic Trade Bridge Cup' => ['atlantic grupa bridge cup'],

  'Austrian Open Teams' => [
    'austrian team championship',
    'austrian team championships'],

  ### BBB

  'Balikcioglu Open Teams' => [
    'balikcioglu teams championship'],
  'Baltic Open Teams' => [
    'baltic open teams cup',
    'baltic teams cup'],
  'Belarusian Open Teams' => ['belarus teams',
    'belarus cup', 'belarus national teams',
    'belarus team championship', 'belarus teams cup',
    'belarusian team championship'],

  # BELGIUM
  'Bergen Grand Open Pairs' => [
    'bergen grand tournament',
    'bergen grand tournamnet',
    'bergen open',
    'bergen storturnering', 
    'bergen storturnering mester', 
    'bergen stor mester',
    'bst mester'],
  'Bermuda Bowl' => ['bermuda bow', 'bemruda bowl'],
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

  'British Gold Cup' => ['gold cup', 'british gold'],

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
  "Chairman's Cup" => ['chairmans cup', "chariman's cup",
    "chairmans's cup", "swedish chairman's cup", 'chairmans cup'],
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

  'Codan Teams Cup' => ['codan cup'],
  'Commonwealth Nations Bridge Championships' => [
    'commonwealth beidge championship', 
    'commonwealth nations bridge championship', 
    "commonwealth nation's bridge championship",
    'commomwealth bridge championship',
    'commonwealth championship',
    'commonwealth bridge championship'],
  'Corn Cairdis Match' => ['corn cairdis'],

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

  'Damiani Trophy' => [
    'damiani cup',
    'world junior teams'],
  "d'Orsi" => ["d'orsi senior bowl",
    'seniors bowl', 'senior bowl'],

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

  # ENGLAND
  'English Open Trials' => [
    'english open trial',
    'enlish open trials', 
    'english open team trials',
    'english open teams trial',
    'english open teams trials'],
  'English Premier League' => [
    'engish premier league',
    'england premier league', 
    'english premie league',
    'englush premier league', 
    'english premier lge'],
  'English Senior Trials' => [
    'england senior trial',
    'england senior trials', 
    'england senior teams trial',
    'england senior trial',
    'english seniors',
    'english senior european trials',
    'english seniors european trials',
    'english senior teams',
    'englnd senior trials'], 
  'English U28 Trials' => ['england u28 trials'],
  'English Women Teams' => [
    'english national womens teams',
    'whitelaw cup'],
  'English Women Trials' => [
    "england ladies' trials",
    'english ladies trials',
    "english ladies' trials",
    'lady milne trials'],

  # ESTONIA
  'Estonian First League' => ['estonian a- league',
    'estonia a- league'],
  'Estonian Open Teams' => ['estonian team championship',
    'estonian team championships', 'estonian open teams',
    'estonia teams championships', 'est teams champs',
    'estonian teams championships'],
  'Estonian Open Pair Trials' => [
    'estonian open trials',
    'estonian team trials'],
  'Estonian-Latvian Open Team Trials' => [
    'estonian-latvian national team trials',
    'estonian-latvian open trials',
    'estonian latvian team trial',
    'estonian latvian team trials',
    'estonian-latvian team trials'],

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
  'Fatih Kiral Pairs' => [
    'fatih kiral cup'],
  'Filbyter Cup' => ['filbyer cup'],

  'forumbridge.pl Top Individual' => ['forumbridge_pl top individual'],
  'forumbridge.pl Top Pairs' => ['forumbridge_pl top pairs'],
  'FOSS Grand Pairs' => [
    'foss grnad tourn',
    'foss grand tourney', 
    'foss grand torunament', 
    'foss grand toruney', 
    'foss grand tournament',
    'foss grand torurnament',
    'foss grand torurney',
    'foss grand tourament', 
    'foss grand tournement',
    'foss-tren',
    'ftredriklstad and sarpsborg grand tournet'],
  'Four Nations Cup' => ['4 nations cupn', '4 nations cup'],

  # FRANCE
  'French Cup' => ['coupe de france', 'de la coupe de france'],
  'French First Division' => [
    'div_nat',
    'div_ nat_', 
    'division natinale', 
    'division natonale', 
    'division ntionale',
    'divison nationale', 
    'dno_4 d1',
    'dn0_4 division 1',
    'dn0_4 d1',
    'dno0_4 d1',
    'dn1',
    'divisionnationale 1', 
    'division natinale open _ 4 d1',
    'division nationale', 
    'division nationale 1',
    'division nationale1_4',
    'division nationale1 _4',
    'division nationale open 1_ 4',
    'division nationale open 1 _4',
    'division nationale open 1 _ 4',
    'division nationale open_4 d1',
    'division nationale open_ 4 d1',
    'division nationale open _4 d1',
    'division nationale open _ 4 d1',
    'division nationale 1 open_4 d1', 
    'finale nationale interclubs division1',
    'france div_ nat_ 1', 
    'french dn1', 
    'interclub d1',
    'interclub finale d1',
    'interclubs d1', 
    'interclubs division1', 
    'interclubs finale nationale division1',
    'nationale interclubs division 1', 
    'nationale division 1', 
    'nationale interclub d1'],
  'French Intercircle' => ['finale intercercle'],
  'French Junior Trials' => ['french junior trial',
    'french juniors trials', 'french juniors trial',
    'sélection junior france',
    'selection junior france'],
  'French Open Teams' => ['french teams championship'],
  'French Open Trials' => [
    'french opentrial', 
    'french open team trial',
    'french open trial', 
    'french teams trial',
    'french teams trials',
    'french opentrial',
    'selection francaise pau 2008',
    'selection francaise - pau',
    'selection francaise pour pau 2008',
    'selection pekin', 
    'séléction pékin',
    'sélection pau', 
    'selection pau 2008'],
  'French Senior Trials' => ['french seniors trials',
    'french senior trials', 'french seniors selection',
    'french senior trial', 'french seniors trial',
    'selection senior france',
    'selection senior pekin',
    'selection senior pau', 'sélection senior pau'],
  'French U28 Trials' => ['selection junior pekin', 'selection u28 pekin'],
  'French Women Trials' => ['entrainement venice cup'],

  'FTBC Tanjungpura University' => ['ftbc university tanjungpura'],
  'FX Securities Pairs Cup' => [
    'fx securities cup',
    'fx sec_ cup'],

  ### GGG

  'Gabrial UI Bastaman Cup' => [
    'bastaman cup',
    'gabrial-ui cup',
    'gabrial ui cup'],
  'Garden Cities Teams' => ['garden cities'],
  'Gardermoen Airport Hotel Teams' => [
    'gardermoen airport hotel cup'],
  'Gelibolu Peace Teams' => ['gelibolu peace cup'],
  'Geologi Cup' => ['geo cup'],
  'Glasgow Transnational Open Teams' => ['tnt glasgow'],

  # GERMANY -- mapped in detail
  'Bonn Nations Cup' => ['nations cup germany', 'bonn cup'],
  'German Club Cup' => [
    'german cup', 
    'vereinspokal', 
    'dbv-cup', 
    'dbv cup',
    'dbv-pokal'],
  'German Mixed Teams' => [
    'deutsche mixed-teammeisterschaft',
    'deutsche mixed teammeisterschaft'],
  'German Open Pairs' => [
    'german men pairs', 
    'german mens pairs',
    'germany mens pairs',
    'Dr. Heinz von Rotteck Pokal',
    'dr_-heinz-von-rotteck-pokal',
    'v_-rotteck-pokal'],
  'German Open Teams' => [
    'offene deutsche teammeisterschaft',
    'offene team meisterschaft',
    'offene team meistershaft', 
    'german open team championships',
    'german open', 
    'german open team',
    'open german team'],
  'German Open Trials' => [
    'deutsche open qualifikation',
    'german open qualification'],
  'German Team Trophy' => [
    'german bridge team trophy',
    'german team bridge trophy', 
    'german bridge trophy'],
  'German Women Pairs' => ['damen-paar'],
  "Gro's Supercup" => ["gro's super-cup", 'gros supercup'],
  'König Ludwig Cup' => ['koenig ludwig nationen cup'],

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

  'Higson Teams Cup' => ['higson cup'],
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
  'IBWI Women Cup' => ['ibwi cup'],
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

  # INDONESIA
  'Indonesian U26 Women Pair Trials' => [
    'indonesian girls u26 selection',
    'indonesia girls u26 selection'],
  'Indonesian Inter-City Championship' => [
    'ina intercity national chams',
    'ina intercity national champs'],
  'Indonesian Inter-Club Championship' => [
    'ina interclub national champs',
    'national indonesian championship (inter-club'],
  'Indonesian Inter-Province Championship' => [
    'uji coba'],
  'Indonesian Junior League Online' => [
    'icba junior league online'],
  'Indonesian U16 Pair Trials' => [
    'indonesian kids national selection',
    'indonesian kids trials'],
  'Indonesian Premier League' => [
    'indonesian bridge league',
    'indonesia bridge league', 
    'indonesia premier league'],
  'Indonesian Mixed Pair Trials' => [
    'indonesian mixed national selection'],
  'Indonesian Open Pair Trials' => ['indonesian pairs trials'],
  'Indonesian Open Teams' => [
    'indonesia open team',
    'indonesian open team',
    'indonesia national open team',
    'indonesian national open team'],
  'Indonesian Open Trials' => ['indonesian men national selection',
    'indonesian men selection'],
  'Indonesian U21 Trials' => ['indonesian u21 selection',
    'indonesia u21 selection', 'indoneian u21 selection',
    'indonesian u21 selekction'],
  'Indonesian U26 Trials' => ['indonesian u26 selection'],
  'Indonesian Women Trials' => ['indonesian women national selection'],


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

  # ISRAEL
  'Israel Cup' => [
    'israel team cup', 
    'israel team of four cup', 
    'israeli teams cup'],
  'Israel Juniors Pairs' => [
    'israel juniours pairs'],
  'Israel Juniors Trials' => [
    'israel juniors team trials',
    'israeli juniors trials',
    'israeli juniors team trials'],
  'Israel Open Pairs' => [
    'israel pairs', 
    'israel pairs champ',
    'israeli pairs championship'],
  'Israel Open Teams' => [
    'israeli open team', 
    'israel teams',
    'israel team champ_',
    'israel team championship', 
    'israelairs champ_',
    'israeli team champ_'],
  'Israel Open Trials' => [
    'israel open team trials',
    'israel open trials', 
    'israel team trials',
    'israeli open team trials'],
  'Israel School Trials' => [
    'israel schools trials',
    'israel schools teams trials'],

  'Istanbul Summer Teams' => [
    'istanbul team championship', 
    'istanbul team championships',
    'istanbul club teams championship',
    'ýstanbul championship',
    'ýstanbul teams'],
  'Istanbul Winter Teams' => [
    'istanbul kis dortlu takimlar',
    'istanbul kis dortlu takim', 
    'istanbul winter champs',
    'istanbul winter open teams',
    'istanbul winter team championship',
    'istanbul kis'],
  'Izmir Teams Cup' => [
    'izmir open teams championship',
    'izmir open teams championships',
    'izmir teams',
    'izmir teams championship',
    'izmýr teams cup'],
  'Izmir Winter Teams Cup' => [
    'izmir winter teams championship',
    'turkish winter open teams izmir'],

  ### JJJ

  'Jaap Kokkes Tournament' => [
    'jaap kokkes toernooi',
    'jaap kookes toernooi',
    'jaap kokkes'],
  'Japanese Open Trials' => ['japanese open team trial',
    'japanese open team trials'],
  'Jean Besse Cup' => ['cup jean besse', 'cup jean besser'],
  "Jessheim New Year's Pairs" => [
    'warm up jessheim new years cup'],
  "Jessheim New Year's Teams" => [
    "Jessheim New Year's Cup",
    'jessheim new years cup',
    'jesshiem new years cup', 
    'jessheim new years cup swiss teams'],
  'Jordan Open Pairs' => [
    'jordanese open pairs'],
  'Jordan Mixed Pairs' => [
    'jordan spring mix pairs',
    'jordan spring mixed pairs'],
  'Junior Camrose' => ['juniior camrose'],

  ### KKK

  "Kepri Governor's Cup" => [
    'bi cup',
    'gov bi cup', 
    'governor cup', 
    'governor kepri cup', 
    'gubernur kepri cup', 
    'guvernor kepri cup',
    'kepri bridge championship', 
    'kepri cup',
    'kepri governor cup', 
    'kepri governors cup', 
    'kepri international tournament',
    'kepri international bridge tournament',
    'riau governor cup'],
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

  'Lady Milne Trophy' => ['lady milne', 'lady mile'],
  'Las Palmas Simultaneous Pairs' => ['simultaneo de mayo las palmas'],
  'Lebanese Invitational Teams' => [
    'lebanese invitational team',
    'lebanon invitational team',
    'lebanon invitational teams'],
  'Lederer Memorial Trophy' => ['lederer memorial',
    'lederer trophy'],
  'Lithuanian Open Teams' => ['lithuanian teams championship'],
  'Lüleburgaz Liberation Cup' => ['luleburgaz kurtulus kupasi'],

  ### MMM

  'Maccabi Games' => ['maccabi-games', 'europ_ maccabi games'],
  'Madrid Senior Teams' => ['equipos senior madrid'],
  'Marit Sveaas Open Pairs' => [
    'marit sveaas international bridge tournament',
    'marit sveaas international  bridge tournament',
    'marit sveaas tournament'],
  'McConnell Cup' => ['mc connell'],
  'Scottish Exhibition' => [
    'm lawrence exhibiton',
    'mike lawrence exhibition'],
  "Missouri Braggin' Rights" => ['bragging rights'],
  'Murat Kilercioglu Turkish Spring Teams' => [
    'Murat Kilercioglu Spring Teams'],

  ###  NNN

  'NABC Senior Knock-Out Teams' => ['nabc senior ko teams'],
  'Namsos Pairs Cup' => ['namsos cup'],
  'NEC Cup' => [
    'nec cup bridge festival'],
  'Necmettin Sunget Teams Cup' => [
    'necmettin sunget teams',
    'necmettin sünget dörtlü',
    'necmettin sünget dörtlü takýmlar'],
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

  # NORWAY
  'Norwegian Club Teams' => [
    'club team championship norway', 
    'nor club teams ch_ship', 
    'nor_club teams ch_ship',
    'nor club teams',
    'nor. club teams ch.ship',
    'norwegian ch ship teams', 
    'norwegian club team',
    'norwegian club-team',
    'norwegian club team championship',
    'norwegian clubteams championship',
    'norwegian clubteams ch_ship',
    'norwegian clubteam championship', 
    'norwegian clubs team', 
    'norway club team championship',
    'norway club-team championship',
    'norway km teams'], 
  'Norwegian Corporate Championship' => ['norwegian corp_ championship'],
  'Norwegian Mixed Pairs' => [
    'nm mix pairs',
    'nor mixed pairs ch_ship', 
    'norwegian championship mix swiss pair',
    'norwegian championship mix swiss pairs',
    'norwegian championship mixed swiss pairs',
    'norwegian championship open mixed pairs',
    'norwegian championships mixed pairs',
    'norwegian mixed pair championship',
    'norwegian mixed pairs championship',
    'norwegian mix pairs championship'],
  'Norwegian Mixed Teams' => [
    'norwegian championship mix swiss teams',
    'norwegian championship mix teams'],
  'Norwegian Open Pairs' => [
    'nbf norwegian pairs', 
    'nm pairs',
    'nm-pairs', 
    'norwegian championship open pairs',
    'norwegian pairs championship',
    'norwegain pairs', 
    'norwegian pairs'],
  'Norwegian Open Teams' => [
    'nm open teams',
    'norwegian championship open teams',
    'norwegian chship teams',
    'norwegian chships teams',
    'norwgian open teams championship', 
    'norwegian chmp teams'],
  'Norwegian Premier League' => [
    'norw premier league',
    'norway sm',
    'norwegian prremier league',
    'nbf premier league', 
    'nor premier league',
    'norvegian premier league',
    'sm norway'], 
  'Norwegian Senior Teams' => ['nbf senior team championship'],
  'Norwegian Swiss Pairs' => [
    'nm monrad pairs', 
    'nm swiss pairs', 
    'nor swiss pairs',
    'norwegian championship siwss pairs',
    'norwegian open swiss pairs',
    'norwegian swiss open pairs',
    'norwegian swiss pairs championship'],
  'Norwegian Swiss Teams' => [
    'nm-monrad-lag', 
    'nm monrad lag', 
    'nm-monrad-teams', 
    'nm-monrad teams', 
    'nor swiss teams',
    'norwegian championship open teams swiss',
    'norwegian championship swiss teams',
    'norwegian swiss team championship'], 
  'Norwegian Team Trials' => ['nor team trials',
    'norwegian open trials',
    'norwegian wbg qualification'],
  'Norwegian Teams' => [
    'norewegian chship temas',
    'norwegian championships teams',
    'norwegian team championship', 
    'norwegian team championships', 
    'norwegian teams ch_ship',
    'norwegian teams ch.ship',
    'norwegian teams ch.ships', 
    'norway team championship',
    'norway teams championship',
    'norway teams championships'],
  'Norwegian Women Teams' => ['norwegian ladies team championship',
    'norwegian ladies teams',
    'nbf women team championship',
    'nbf women teams championship',
    'nbf womens team championship',
    'norwegian women team championship',
    'norwegian womens team championship'],

  'NYSA Euroregion Nations Cup' => ['cup of euroregion nysa'],

  ### OOO

  'Olrud Easter Mixed Pairs' => ['olrud easter mixed'],
  'Olrud Easter Swiss Pairs' => [
    'olrud easter pairs'],
  'Olrud Easter Swiss Teams' => [
    'olrudpaasken monrad lag',
    'olrud easter',
    'olrud easter tournament',
    'olrud easter swiss event', 
    'olrud easter swiss team', 
    'olrud easter teams',
    'olrud easter team-event',
    'olrud easter tourn',
    'olrud estern teamevent', 
    'olrud estern team-event',
    'olrud paasken monrad lag', 
    'olrud swiss teams', 
    'olrudpaasken teams'],

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
  'Peggy Bayer Trophy' => [
    'peggy bayer'],
  'Petit Grand Prix van Driene' => ['petit grand prix',
    'grand prix van driene'],
  'Pertamina Field Tambun Cup' => ['pertamina ep field tambun cup'],
  'Philadelphia Solomon Teams' => [
    'solomon teams'],
  'PLN Cup' => ['pln fortuga'],

  'PT Timah Invitational Teams' => [
    'invitasi pt timah',
    'invitasi pt_ timah',
    'invitasi pt_timah',
    'invitasi terbatas pt timah',
    'invitasi terbatas pt_timah',
    'invitasi terbatas pt_ timah',
    'pt timah limited invitational teams',
    'pt_ timah limited invitation teams',
    'pt_ timah limited invitational teams',
    'pt_ timah ltd invitational teams'],
  'Prince Takamatsu Cup' => [
    'prince takamatsu memorial cup',
    'takamatsu cup'],

  ### RRR

  'Ragn-Sells International Open Pairs' => [
    'ragn sells international',
    'ragn-sells international grand tournament',
    'ragn-sells intl grand tournament',
    'ragn-sells intl_ grand tournament',
    'ragn sells intl_ grand tournament'],
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

  'Rondane Pairs Cup' => ['rondanecupen swiss pairs'],
  'Rondane Teams Cup' => ['rondane cup teams', 'rondanecupen teams',
    'rondanecupen swiss teams'],
  'Rosfjord Swiss Teams' => ['rosfjord monrad team',
    'rosfjord monrad teams'],

  # RUSSIA
  'Russian IMSA Cup' => ['imsa cup'],
  'Russian Open Teams' => ['russian teams championship',
    'russian team championship'],
  'Russian Premier League' => ['russian premiere league'],

  'Ruter 7 Open Pairs' => [
    'ruter7 elitetournament',
    'ruter 7 open'],

  ### SSS

  'Salvador Assael IMP Pairs' => [
    'assael invitational calcutta',
    "salvador assael imp's across the field"],
  'Salvador Assael Pro-Am Pairs' => [
    'salvador assael pro-am'],
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
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Scottish Cup' => ['scot cup', 'scot cuo', 'scottish cup plate'],
  'Scottish National League' => ['scotland national league'],
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
  'Snåsa Pairs Cup' => [
    'snåsa cup'],

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

  'Spring Foursomes' => [
    'spring 4s', 
    'spring fours', 
    'schapirosfs'],
  'Spring Nationals' => [
    'spring nat', 
    'spring national', 
    'spring nats',
    'sping national', 
    'spring nat opens'],
  "Sternberg Women's BAM Teams" => ['marsha may sternberg bam'],
  'Stockholm Teams' => ['stockholm teams cs', 'stockholms teams'],
  # SWEDEN
  'Swedish District Teams' => [
    'swdish district',
    'sweden distric', 
    'sweden district',
    'swedis district', 
    'swedish championship cistrict', 
    'swedish championship district', 
    'swedish championships distrcit',
    'swedish championships district', 
    'swedish champsionship district', 
    'swesish champsionship district',
    'swedish district championship',
    'swedish district championships',
    'swedish district',
    'swedish districts', 
    'swedish disttrict',
    'swesish district'], 
  'Swedish Juniors Championship' => [
    'swedish junior championships',
    'swedish juniors cs'],
  'Swedish Juniors Pairs' => [
    'swedish junior pair championship',
    'swedish junior pairs championship',
    'swedish national junior pair championship',
    'swedish national junior pairs'],
  'Swedish Juniors Teams' => ['swedish juniors teams cs',
    'swedish juniors teams cs', 'swedish junior teams',
    'swedish junior team', 'swedish junior team championship'],
  'Swedish Open Pairs' => [
    'open swedish pairs championship', 
    'sweden national pairs',
    'swedish national pairs',
    'swedish open pair', 
    'swedish pair',
    'swedish pairs championships'],
  'Swedish Open Pair Trials' => ['nordic race'],
  'Swedish Open Teams' => ['swedish teams'],
  'Swedish Open Team Trials' => [
    'swedish open trials',
    'swedish team trials',
    'swedish teams trials', 
    'swedish team trial'],
  'Swedish Premier League' => [
    'swedish club teams',
    'swedish elite series',
    'swedish elitserien', 
    'swedish premier leauge',
    'swedish premieer league'],
  'Swedish Senior Team Trials' => [
    'sweden senior trials',
    'swedish senior trials'],

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

  'Telkom Indonesia Open' => [
    'telkom cup',
    'telkom speedy',
    'telkom indonesian open'],
  'Teltscher Trophy' => [
    'senior camrose',
    'teltcher trophy'],
  'TGR Auction Pairs' => [
    'tgr auction',
    "tgr's auction pairs",
    'tgrs auction pair', 
    'tgrs auction pairs'],
  'TGR Auction Teams' => ['tgrs auction teams'],
  'TGR Super League' => ["tgr's super league", "tgr's super legue",
    'tgrs league', 'tgrs 2nd auction pairs', 'tgrs super league',
    "tgr's league", "trg's super league"],
  'Thanos Capayiannides Memorial Simultaneous' => [
    'thanos capayiannides'],
  'Thrace Cup League' => [
    'trachean club teams',
    'Thrace Club Teams',
    'thrace region clubs team championship',
    'trakya kulupler ligi',
    'turkish club teams championship aegean playoffs',
    'türk trakya bölge kulüpler þampýyonasi ekýbý'], 
  'Tianjin Binhai Cup' => [
    'tianjin bin hai cup',
    'tianjin binhai cup world men elite tournament'],
  'Top Circuit' => ['melchemie top circuit',
    'ing bank top circuit', 'witte huis topcircuit'],
  'Trondheim Pairs Cup' => ['trondheim cup swiss pairs'],
  'Trondheim Teams Cup' => ['trondheim cup swiss teams'],

  # TURKEY
  'Turkish Club Championship' => ['türkýye kulüplerarasi þampýyonasi',
    'turkey club teams championship',
    'türkýye klüpler arasi brýç þampýyonasi',
    'turkish club teams championship',
    'turkish club championships',
    'turkish club teams championship',
    'turkish clubs championship',
    'turkish clubs team championship',
    'turkish clubs teams championship',
    'turkish clubs team championship teams',
    'turkish club team championship',
    'turkish inter club championships',
    'turkish inter-clubs championship',
    'turkiye clubs championship', 'turkey clubs championship'],
  'Turkish East Mediterranean Teams' => [
    'turkish clubs championship east & south east el',
    'turkish east & south-east teams',
    'turkish east mediterranean',
    'turkish east mediterranean club teams',
    'turkish eastern mediterranean club', 
    'turkish eastern mediterranean club teams'],
  'Turkish Mixed Team Trials' => ['turkish mixed team trails'],
  'Turkish Mixed Teams' => [
    'turkey mix teams ch',
    'turkey mix teams championship',
    'turkey mixed team championship',
    'turkey mixed teams',
    'turkis mixed teams',
    'turkish mixed teams',
    'turkish mixed team championship',
    'turkish mixed team championships',
    'turkish mixed teams championship',
    'turkiye mixed teams championship',
    'turkýsh mixed teams'],
  'Turkish Open Teams' => [
    'turkey open team championship',
    'turkish national open national selection',
    'turkish open team championship',
    'turkish open teams',
    'turkish open teams championship',
    'turkish open teams championships',
    'turkiye acik takimlar sampiyonasi',
    'turkish national open teams'],
  'Turkish Swiss Mixed Teams' => ['turkey swiss mixed teams'],
  'Turkish Teams Championship' => ['turkiye bric takimlar sampiyonasi'],
  'Turkish U16 Pairs' => [
    'turkey u16 championship'],
  'Turkish University Teams' => [
    'turkish Universities championship',
    'turkish universities bridge championship'],
  'Turkish Winter Open Teams' => [
    'turkey winter open teams',
    'turkey winter teams',
    'turkey winter team championship',
    'turkey winter teams championship',
    'turkis winter teams',
    'turkish winter chanpionship',
    'turkish winter championship',
    'turkish winter championships',
    'turkish winter team championship',
    'turkish winter team championships',
    'turkish winter teams',
    'turkiye kis takimlar sampiyonasi',
    'turkiye kis acik takimlar sampiyonasi'],
  'Turkish Winter Women Teams' => [
    'turkish winter woman team championship',
    "turkish woman's winter teams",
    "turkish women's winter teams"],
  'Turkish Women Teams' => [
    'türkish ladies teams',
    'turkish ladies teams championships',
    'turkish ladies teams',
    'turkish women championships',
    'turkish womens teams championship'],

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
  'Venice Cup' => ['<venive <cup'],
  'Vest-Agder Regional Team Championship' => [
    'regional chship vest-agder', 'regional champship vest-agder',
    'regional chship vest-agder', 'vest-agder km lag'],

  ### WWW

  'Wagar Teams' => [
    'wagar teams', 
    "wagar women's", 
    "wagar women's ko",
    'wagar womens ko'],
  'Western Mediterranean Club Teams' => [
    'western mediterranean clubs team championship'],
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
  'Welsh Open Trials' => ['welsh open trial', 'welsh trials',
    'welsh trial'],
  'Willy Brown Memorial Pairs' => [
    'willy brown memorial'],

  # WORLD
  'Huayuan Cup' => [
    'hua yuan cup'],
  'Oly-Star Cup' => [
    "oly-star cup women's bridge elite tournament",
    "oly-star cup women's bridge grand prix"],
  'IMSA Elite Women Teams' => [
    'women elite tournament',
    "women's bridge elite tournament",
    "women's elite tournament",
    "women's bridge grand prix"],
  'World Juniors Championship' => ['world juniors championships'],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Open Pairs' => ['world pairs championship'],
  'World Seniors Championships' => ['world senior championship'],
  'World Transnational Open Teams' => [
    'world transnational teams'],
  'World University Teams' => [
    'world university bridge championship',
    'world university bridge championships',
    'world university championship',
    'univ_ world champs'],

  'Yeh Bros Cup' => ['yehbros cup', 'yer bros cup'],
  'Young Chelsea Knock-out' => ['yc ko', 'young chelsea ko',
    'young chelsea knockout'],
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
  'Bermuda Bowl' => ['bb'],
  'Bobby Evans Seniors Teams' => ['best'],
  'Brazilian Open Teams' => ['brasilchamp'],
  'Camrose Trophy' => ['camrose', 'camroae', 'ccmrose'],
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc', 'cnst'],
  'Canadian Women Teams Championship' => ['cwtc'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish', 'cav'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  'Copenhagen Invitational Pairs' => ['cbi'],
  'Danish Championship' => ['dm'],
  'French First Division' => ['dn'],
  "d'Orsi" => ['sb', 'dosb'],
  'Dutch Meesterklasse' => ['meesterklasse'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Small Federation Games' => ['esfg', 'sfc'],
  'European University Bridge Championship' => ['eubc', 'eucb', 'euc'],
  'European Youth Bridge Championship' => ['eybc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'European Youth Bridge Teams Championship' => ['eytc', 'jem'],
  'FOSS Grand Pairs' => ['foss'],
  'German Team Championship' => ['teammeisterschaft'],
  'German Bundesliga' => ['bundesliga'],
  'Gianarrigo Rona Trophy' => ['rona'],
  'Grand National Open Teams' => ['gnot'],
  'Grand National Teams' => ['gnt'],
  "Gro's Supercup" => ['grocup'],
  'Icelandair Open' => ['icelandair'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  "Kepri Governor's Cup" => ['kepricup'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  "Linda Stern Women's Teams" => ['lswt'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'NTU Cup' => ['ntucup'],
  'Paris Youth Open Teams' => ['ypob'],
  'Peggy Bayer Trophy' => [
    'peggybayer'],
  'Portuguese Open Teams' => ['cneo'],
  'Reisinger BAM Teams' => [
    'reisiger', 
    'reisinger', 
    'resisinger'],
  'Rosenblum Cup' => ['rosenblum'],
  'Scottish Cup' => ['scottishcupplate'],
  'Spingold Teams' => ['spingold'],
  'Swedish Elite Series' => ['elitserien'],
  'Prince Takamatsu Cup' => ['takamatsu'],
  'Teltscher Trophy' => [ 
   'teltschertrophy', 
   'teltscher', 
   'telschertrophy'],
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
  'Venice Cup' => ['vc', 'venice'],
  'Victorian Pennant' => ['pennant'],
  'Vilnius Club Pairs' => ['vbk'],
  'Wagar Teams' => ['wagar'],
  'White House Juniors' => ['whj'],
  'World Transnational Mixed Teams' => ['wtmt'],
  'World Transnational Open Teams' => ['wtot'],
  'World University Championship' => ['wuc'],
  'Young Chelsea Knock-out' => ['ycko'],
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
  Tags::Tnames::Belgium::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Bulgaria::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, 
    \%SINGLE_TYPOS);
  Tags::Tnames::Chile::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::China::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Denmark::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Finland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Hungary::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::India::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Italy::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Poland::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);
  Tags::Tnames::Portugal::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS,
    \%SINGLE_TYPOS);
  Tags::Tnames::Taipei::set_hash(\@MULTI_WORDS, \%MULTI_TYPOS, \%SINGLE_TYPOS);

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
