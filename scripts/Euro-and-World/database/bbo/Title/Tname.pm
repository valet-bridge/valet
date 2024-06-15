#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Tname;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'ABPF Championships',
  'African Zonal Championship',
  'All-China Games',
  'All India UTI Bank Masters Championship',
  'Altman Swiss Pairs',
  'Anatolian Spring Teams',
  'Antonio Chong Cup',
  'Aoda Cup',
  'ArboNed Team Cup',
  'Argentinian Flags Day Championship',
  'Argentinian Open Teams',
  'Australian Open Teams',
  'Australian Seniors Pairs',
  'Australian Seniors Teams',
  "Australian Women's Teams",
  'Australian Youth',
  'ARIS Cup',
  'ASEAN Club Championship',
  'Asia Cup',
  'Asian University Championship',
  'Australian National Open Teams',
  'Australian Youth IMP Pairs',
  'Balikcioglu Teams Championship',
  'Balkan Championship',
  'Balkan Teams',
  'Baltic Bowl',
  'Baltic Cup',
  'Baltic Teams Cup',
  'Balkan Championship',
  'Baze Senior Knock-out',
  'Belgian Open Teams',
  'Bergen Grand Tournament',
  'Bermuda Bowl',
  'Bermuda Triangle Cup',
  'Biarritz Hiver',
  'Bobby Evans Seniors Teams',
  'Bologna Trophy',
  'British Gold Cup',
  'Buffett Cup',
  'Canadian Bridge Championship',
  'Canadian National Teams Championship',
  'Canadian Seniors Teams Championship',
  'Canadian Women Teams Championship',
  'Carrousel Cup',
  'Cavendish Pairs',
  'Cavendish Teams',
  'Central American Zonal Championships',
  'Centre Island Teams',
  "Champions' Cup",
  'Channel Trophy',
  'Cherven Briag National Tournament',
  'Chilean Championship',
  'China Elite Tournament',
  'China Friend City Senior Team Tournament',
  'China Hosts Europe in Rome',
  'Chung Hua Cup',
  'Cliff Wake Challenge',
  'Codan Cup',
  'Collegiate Bowl',
  'Commonwealth Nations Bridge Championships',
  'Computer World Championship',
  'Copa de Plata',
  'Copa de Oro',
  'Copa Zanalda River Plate',
  'Corn Cairdis',
  'Cross Strait Invitational',
  'Czech Championship',
  'Czech Team Championship',
  'Czech First League',
  "d'Orsi",
  'Damiani Cup',
  'Danish Club Teams',
  'Danish District Championship',
  'Danish Junior Teams',
  'Danish Mixed Pairs',
  'Danish Women Pairs',
  'Danish Open',
  'Danish Pairs Championship',
  'Danish Teams Championship',
  'Dongming Knock-out Teams',
  'Dr. Heinz von Rotteck Pokal',
  'Dutch Meesterklasse',
  'Egyptian League',
  'European Bridge Teams Championship',
  'European Open Bridge Championship',
  "European Champions' Cup",
  'European Championship',
  'European Small Federation Games',
  'European University Bridge Championship',
  'European Winter Games',
  'European Youth Bridge Championship',
  'European Youth Bridge Pairs Championship',
  'European Youth Bridge Teams Championship',
  'EUSA Games',
  'Farmen Invitational',
  'Faroese Teams',
  'Filbyter Cup',
  'Finnish Cup',
  'Finnish Pairs Championship',
  'Finnish Teams Championship',
  'Forbo Krommenie Teams',
  'Forbo Nations Cup',
  'Forest Trophy',
  'Fortuna Cup',
  'FOSS Grand Tournament',
  'French Cup',
  'FullBridge International Teams',
  'Garden Cities',
  'Gardermoen Airport Hotel Cup',
  'Gelibolu Peace Cup',
  'German Club Cup',
  'German Team Championship',
  'German Team Trophy',
  'German Women Pairs',
  'Goksu-Yalikavak Pairs',
  'Golden Jubilee',
  'Grand National Open Teams',
  'Grand Prix of Poland',
  'Grand Prix of Prague',
  'Grand Prix of Warsaw',
  'Grand Prix of Wielkopolski',
  'Greek Open Teams',
  "Gro's Supercup",
  'Guangdong Club Championship',
  'Haikou Fitness Day',
  'Hainan Air Cup',
  'Haskovski Mineralni Bani',
  'Hecht Cup',
  'Hellenic Mixed Pairs',
  'Hellenic Team Trials',
  'Hellenic Team Championship',
  'Higson Cup',
  'High-Tech Zone Workers Invitational',
  'Hong Kong Inter-City',
  'Icelandair Open',
  'Icelandair Team Championship',
  'Icelandic Cup',
  'Icelandic Teams',
  'IMSA Cup',
  'IMSA Elite Mind Games',
  'Indonesian Inter-Province Championship',
  'Indonesian League',
  'Indonesian National Games',
  'INEA Cup',
  'IOC Grand Prix',
  'Istanbul Winter Teams',
  'Italian Club Championship',
  'Italian Team Championship',
  'Italy Cup',
  "Jessheim New Year's Cup",
  'JPD Cup',
  'Junior Camrose',
  'Kalani Trophy',
  "Kepri Governor's Cup",
  'Kings and Queens Blaine Howe Teams',
  'König Ludwig Cup',
  'Krakow Spring',
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  "Linda Stern Women's Teams",
  'Lüleburgaz Liberation Cup',
  'Maccabi Games',
  'McConnell Cup',
  'Milan Trophy',
  "Missouri Braggin' Rights",
  'Mohan Sicka Trophy',
  'Mondial de Deauville',
  'Mountain Sea Cup',
  'Nations Cup',
  'NN Cup',
  'Nordic Championship',
  'Nordic Team Championship',
  'Nordic Junior Championship',
  'Nordic Junior Team Championship',
  'Nordic Cup',
  'Nordic Race',
  'North American Bridge Championship',
  'Northern Greece Regional Championship',
  'Northern Territory Gold Teams',
  'Northern Territory Gold Swiss Pairs',
  'Norwegian Club Teams',
  'Norwegian District Championship',
  'Norwegian Mixed Pairs',
  'Norwegian Swiss Teams',
  'Norwegian Teams',
  'NTU Cup',
  'Olrud Easter Mixed Pairs',
  'Olrud Easter Pairs',
  'Olrud Easter Swiss Teams',
  'Olrud Easter Teams',
  'Open Catalunya Preferent',
  'Pahlawan Cup',
  'Pakistan Day Bridge Championship',
  'Palace Cup',
  'Pan Arab Inter-Club Championship',
  'Pan China Construction Tournament',
  'Paris Youth Open Teams',
  'Park Hotell Swiss Teams',
  'Patton de Monaco',
  'Pärnu Summer Invitational Pairs',
  'Pärnu Summer Open Teams',
  'Peggy Bayer',
  'Pesta Sukan',
  'Petit Grand Prix van Driene',
  'Plock District League',
  'Poddar National Masters',
  'Polish Boys Championship',
  'Polish Girls Championship',
  'Polish Open Teams',
  'Polish Pairs',
  'Polish IMP Pairs',
  'Polish Premier League',
  'Polish Youngster Teams',
  'Pomerania Cup',
  'Portuguese Open Teams',
  'Prince Henrik Trophy',
  'Prince Takamatsu Cup',
  'Puutalo Open',
  'PYC Royale',
  'Riga Invites to Jurmala',
  'Riau Governor Cup',
  'Roberto Taunay Cup',
  'Romanian League',
  'Rondane Cup',
  'Rottneros Nordic Cup',
  'Ruia Gold Cup',
  'Ruia Silver Cup',
  'Ruia Trophy',
  'Ruter 7 Open',
  'S:t Erik Championship Series',
  'Sao Paulo State Championship',
  'Sarundajang Cup',
  'Scottish Cup',
  'Semen Padang Cup',
  'Senior Camrose',
  'Serbian Cup',
  'Serbian Premier League',
  'Serbian Team Championship',
  'Shenhua Cup',
  'Shield of Thoisy',
  'Sigismund Bell Krakow',
  'Silver Jubilee',
  'Slava Cup',
  'Smirnov Cup',
  'Solomon Teams',
  'South African Championship',
  'South American Bridge Championships',
  'South Zone Championship',
  'Southeast Asian Games',
  'Spanish Central Zone Teams',
  'Spanish Teams Championship',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Star Wars',
  'Staszic Pairs Cup',
  'Stena Line Cup',
  'Stern-Cornell Trophy',
  'Stockholm Teams',
  'Summer Monsoon League',
  'Summer Nationals',
  'Swedish District Championship',
  'Swedish Juniors Championship',
  'Swedish Juniors Teams',
  'Swiss Championship',
  'Swiss Cup',
  'Takamatsu Cup',
  'Taiwan University Cup',
  'Taiwanese Teams',
  'TATA Open',
  'Teltscher Trophy',
  'The Hague Bridge Experience',
  'Thrace Club Teams',
  'Thrace Cup League',
  'Tianjin Binhai Cup',
  'TGR Auction',
  'TGR Auction Pairs',
  'TGR Auction Teams',
  'TGR Super League',
  'Tolani Gold Trophy',
  'Tolani Grand Prix',
  'Tolani Silver Cup',
  'Torneo di Rastignano',
  'Torneo di Roma',
  'Toscana Cup',
  'Towns Cup',
  'Transnational Open Teams',
  'Trondheim Cup',
  'Turkich Club Championship',
  'Turkish East & South-East Teams',
  'Turkish Winter Championship',
  'Turkish Women Teams',
  'Turkish Winter Women Teams',
  'United States Bridge Championship',
  'United States Juniors Bridge Championship',
  'United States Seniors Bridge Championship',
  'United States Women Bridge Championship',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup',
  'Victor Champion Cup',
  'Victorian Open Teams',
  'Victorian Pennant',
  'Vilnius Club Pairs',
  'Vinoble Cup',
  'VV Cup',
  'Warsaw Online Teams',
  'Watermark Bridge Classic',
  'Wellingdon Swiss Pairs',
  'Western Mediterranean Club Teams',
  'White House Juniors',
  'White House Top 12',
  'White House Top 16',
  'White House Top Circuit',
  'Whitelaw Cup',
  'Winter Nationals',
  'Winter Championships',
  'Winter Open Teams',
  'Winter Women Teams',
  'World Bridge Series',
  'World Juniors Championship',
  'World Masters Individual',
  'World Men Elite Tournament',
  'World Mind Games',
  'World Open Pairs',
  'World Seniors Championships',
  'World Team Championships',
  'World Team Olympiad',
  'World Top Tournament',
  'World Transnational Teams',
  'World University Championship',
  'World Youth Congress',
  'World Youth Open Bridge Championship',
  'World Youth Teams Championship',
  'World Youth Bridge Congress',
  'World Youth Bridge Teams Championship',
  'World Youth Championship',
  'World Women Elite Tournament',
  'Xinyuan Cup',
  'Yeh Bros Cup',
  'Young Chelsea Knock-out',
  'Zhejiang Huamen Cup',
  'Zimmermann Cup'
);

my %MULTI_TYPOS =
(
  'African Zonal Championship' => ['zonal qualifying africa',
    'abf zonal'],
  'All India UTI Bank Masters Championship' => [
    'ull aindia uti bank masters championship',
    'all india uti national masters championship'],
  'Anatolian Spring Teams' => ['anatolia spring teams'],
  'ArboNed Team Cup' => ['arbo ned team cup', 'arbo ned teams cup'],
  'Argentinian Open Teams' => ['cn equipos libres argentina',
     'argentine team', 'open argentin team'],
  'ASEAN Club Championship' => ["asean bridge club c'ship",
    'asean bridge club championship', "asean bridge c'ship",
    'asean bridge club', 'asean bridge club championships',
    'asean bridge cship', 'asean bridge championship',
    'asean bridge club open championships',
    'asean bridg club championship', 'asean bridge championships',
    'asean club championships', "aseam bridge club c'ship"],
  'Asian University Championship' => [
    'asian university bridge championship'],
  'Australian Open Teams' => ['aust open', 'australian open tream'],
  'Australian Seniors Pairs' => ['aust seniors pairs'],,
  'Australian Seniors Teams' => ['aust seniors open', 'sen australian',
    'aust senriors open'],
  "Australian Women's Teams" => ["aust women's team",
    'aust womens team'],
  'Australian Youth' => ['aust youth'],
  'Australian Youth IMP Pairs' => ['aust youth butler',
    'australian youth butler'],
  'Balkan Championship' => ['balkan bridge ch', 
    'balkanbridge championship', 'balkan championships'],
  'Balkan Teams' => ['bolkan team championship',
    'bolkan teams championship', 'bolkan championship'],
  'Baltic Teams Cup' => ['baltic open teams cup'],
  'Baze Senior Knock-out' => ['baze senior ko', 'baze sr_ ko',
    'base sr ko', 'baze sr_ ko', 'baze sr ko'],
  'Belgian Open Teams' => ['belgian teals'],
  'Bergen Grand Tournament' => ['bergen open', 'bergen stor',
    'bergen storturnering', 'bergen grand tournamnet'],
  'Bermuda Bowl' => ['bermuda bow', 'bemruda bowl'],
  'Bermuda Triangle Cup' => ['bermuda triangle teams cup'],
  'Bobby Evans Seniors Teams' => ["bobby evans senior's teams",
    'bobby evans senior teams'],
  'Bologna Trophy' => ["trofeo citta' di bologna",
    "trofeo citta' bologna", "citta' di bologna", "trofeo citta' bologna"],
  'British Gold Cup' => ['gold cup', 'british gold'],
  'Buffett Cup' => ['buffet cup', 'bufett cup'],
  Camrose => ['camrose trophy'],
  'Cavendish Teams' => ['cavendish tms', 'cavendish team'],
  'Central American Zonal Championships' => ["cacbf zonal ch'ships",
    'cacbf zonal championship', "cacbf zonal cha'ships",
    "cacbf zonal c'ships", 'cac final'],
  'Centre Island Teams' => ['ci teams'],
  "Champions' Cup" => ['champions cup', "champion's cup", 'chamions cup', 
    'champs cup', 'champion cup', "champion'scup", "champions'cup"],
  'Channel Trophy' => ['channel trpohy'],
  'Cherven Briag National Tournament' => [
    'national tournament cherven briag', 'cherven briag'],
  'Chilean Championship' => ['torneo nacional de chile'],
  'China Elite Tournament' => ['china elite inivitational tournament',
    'china bridge elite tournament'],
  'Cliff Wake Challenge' => ['cliff wake invitational'],
  'Commonwealth Nations Bridge Championships' => [
    'commonwealth beidge championship'],
  'Czech Championship' => ['czech bridge championship',
    'czech bridge championships'],
  'Czech First League' => ['czech bridge league', 'czech bridge league'],
  'Czech Team Championship' => ['czech team championships',
    'czech teams champ_'],
  'Czech First League' => ['czech 1st league', 'czech bridge league'],
  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi", 'senior world cup',
    'seniors bowl', 'senior bowl'],
  'Danish Club Teams' => ['danish club team', 'dm klubhold',
    'dm i klubhold', 'dm i knubhold', 'dm i klub hold',
    'danish 1st division'],
  'Danish District Championship' => ['danish district teams championship'],
  'Danish Junior Teams' => ['dansih junior teams',
    'danish junior team championship'],
  'Danish Mixed Pairs' => ['dm mix par', 'danish championship mixed pairs',
    'danish mix-pair championship', 'danish mix pair championship',
    'danish national mix-pairs championship', 'danish mix pairs'],
  'Danish Pairs Championship' => ['danish championship - open pairs',
    'danish open pairs championship', 'danish open pairs championships',
    'danish championship open pairs', 'open pairs - danish championship'],
  'Danish Teams Championship' => ['danish team champions',
    'danish team championships', 'danish team championship',
    'danish open team', 'danish open teams', 'danish teams',
    'dm hold', 'dmi i klubhold', 'danish team', 'danish 1_division',
    'danish team chamionship'],
  'Danish Women Pairs' => ['ladies pairs - danish championship',
    'danish championship ladies pairs'],
  'Dongming Knock-out Teams' => ['dong ming knockout teams',
    'dong ming knockour teams'],
  'Dr. Heinz von Rotteck Pokal' => ['dr_-heinz-von-rotteck-pokal',
    'v_-rotteck-pokal'],
  'Dutch Meesterklasse' => ['dutch mk'],
  'Egyptian League' => ['egy_league', 'egy-league'],
  'European Bridge Teams Championship' => ['european b.t.ch.',
    'european b_t_ch_', 'e_b_l_ team championships',
    'e_b_l_ teams championship', 'e_b_l team championship',
    'e_b_l_ team champioships', 'europeqn teqm championships'],
  'European Championship' => ['eur champ', 'eur cham', 'champ eur',
    'eur cha'],
  'European Open Bridge Championship' => ['eobc'],
  'European Small Federation Games' => ['ebl small federation trophy',
    'ebl small federations trophy', 'games of small federations',
    'european small federations games', 'small federation games',
    'small federations games', 'small ffederations games',
    'small federation cup', 'european small feds games',
    'small f federations games', 'europian small federation games'],
  'European Youth Bridge Pairs Championship' => [
    'european youth pairs'],
  'Faroese Teams' => ['faroese tc'],
  'Filbyter Cup' => ['filbyer cup'],
  'Finnish Pairs Championship' => ['finnish pair championship',
    'finnish pair championships', 'finnish pairs champs',
    'finnish pairs'],
  'Finnish Teams Championship' => ['finnish teams championships',
    'finnish teams', 'finnish team championships'],
  'Forbo Krommenie Teams' => ['forbo-krommonie tourname',
    'forbo-krommenie tournament', 'forbo-krommenietournament',
    'forbo-krommenie international bridge event',
    'international forbo krommenie bridge event',
    'forbo-krommenie tourname'],
  'Forbo Nations Cup' => ['Forbo Teams'],
  'Forest Trophy' => ['forest bridge trophy'],
  'FOSS Grand Tournament' => ['foss grand tourney', 'foss grnad tourn',
    'foss grand tourament', 'foss grand tournement', 'foos grnad tourn'],
  'French Cup' => ['coupe de france', 'de la coupe de france'],
  'FullBridge International Teams' => ['internacional equipos full bridge',
    'internacional full bridge', 'internactional de equipos full bridge'],
  'German Club Cup' => ['german cup', 'vereinspokal'],
  'German Team Championship' => ['deutsche teammeisterschaft'],
  'German Team Trophy' => ['german bridge team trophy',
    'dbv-pokal'],
  'German Women Pairs' => ['damen-paar'],
  'Golden Jubilee' => ['golden jubily'],
  'Grand Prix of Poland' => ['grand prix polski', 'gp of poland',
    'grnd prix of poland', 'grand priix polski', 'gp polski'],
  'Grand Prix of Prague' => ['gp prague'],
  'Grand Prix of Wielkopolski' => ['gp wielkopolski',
    'grand prix of wielkopolski', 
    'grand prix of greater poland voivodeship'],
  'Grand Prix of Warsaw' => ['gp warswawy'],
  'Greek Open Teams' => ['greek open nationa team',
    'greek natioanal teams', 'greek open team championship', 
    'greek open team', 'grekk open national team'],
  "Gro's Supercup" => ["gro's super-cup", 'grocup', 'gros supercup'],
  'Guangdong Club Championship' => ['guang dong club championship',
    'guang dong club bridge championship'],
  'Hellenic Mixed Pairs' => ['hellenik mixed pairs'],
  'Hellenic Team Championship' => ['hellenic teams championship'],
  'Hong Kong Inter-City' => ['hong kong iner-city'],
  'Icelandair Open' => ['icelandari open'],
  'Icelandic Cup' => ['bikarkeppni bsí'],
  'Icelandic Teams' => ['icelandic teamhampionship'],
  'Indonesian Inter-Province Championship' => ['uji coba'],
  'Indonesian League' => ['indonesian bridge league',
    'indonesia bridge league'],
  'Indonesian National Games' => ['indonesian games',
    'indonesian nasional games'],
  'IOC Grand Prix' => ['ioc grandprix'],
  'Istanbul Winter Teams' => ['istanbul kis dortlu takimlar',
    'istanbul kis dortlu takim', 'istanbul winter champs'],
  'Italian Club Championship' => ['campionato italiano di societa'],
  'Italian Team Championship' => ['camp.it.squadre',
    'camp.it. squadre'],
  "Jessheim New Year's Cup" => ['jessheim new years cup',
    'jesshiem new years cup'],
  'Junior Camrose' => ['juniior camrose'],
  'Kalani Trophy' => ['kalani bridge championship'],
  "Kepri Governor's Cup" => ['kepri governor cup', 'kepri cup',
    'kepri governors cup', 'gubernur kepri cup', 'guvernor kepri cup',
    'governor kepri cup'],
  'König Ludwig Cup' => ['koenig ludwig nationen cup'],
  'Krakow Spring' => ['krakowska wiosna'],
  'Lady Milne Trophy' => ['lady milne', 'lady mile'],
  'Lederer Memorial Trophy' => ['lederer memorial'],
  "Linda Stern Women's Teams" => ['linda stern womens teams'],
  'Lüleburgaz Liberation Cup' => ['luleburgaz kurtulus kupasi'],
  'Maccabi Games' => ['maccabi-games'],
  'McConnell Cup' => ['mc connell'],
  'Milan Trophy' => ["trofeo citta' di milano", "citta' di milano"],
  "Missouri Braggin' Rights" => ['bragging rights'],
  'Mohan Sicka Trophy' => ['mohan sicka'],
  'Mondial de Deauville' => ['mondial deauville',
    'mondial barrière deauville', 'mondial barriere deauville',
    'barriere championship deauville', 'mondial de deauille',
    'montial de deauville', 'mondial barrière de deauville',
    'tournoi des champions barriere'],
  'NN Cup' => ['nn-cup'],
  'Nordic Championship' => ['nordic championships',
    'nordic bridge championship', 'nordic bridge championships'],
  'Nordic Junior Championship' => ['nordic championship for juniors'],
  'Nordic Junior Team Championship' => [
    'nordic junior teams championship',
    'nordic junior teams championships'],
  'Nordic Team Championship' => ['nordic bridge team championship'],
  'Northern Greece Regional Championship' => [
    'n_ greece regional championship'],
  'Northern Territory Gold Teams' => ['nt gold teams'],
  'Northern Territory Gold Swiss Pairs' => ['nt gold swiss pairs',
    'nt gold swis pairs', 'nt gold swiss piars'],
  'Norwegian Club Teams' => ['norwegian clubteams championship',
    'norwegian ch ship teams', 'norwegian clubteams ch_ship',
    'norwegian clubteam championship', 'norw premier league',
    'nor club teams ch_ship', 'nor_club teams ch_ship'],
  'Norwegian District Championship' => ['norwegian district',
    'norw district'],
  'Norwegian Mixed Pairs' => ['nor mixed pairs ch_ship'],
  'Norwegian Swiss Teams' => ['nm-monrad-lag', 'nor swiss teams',
    'norwegian swiss team championship'],
  'Norwegian Teams' => ['norwegian teams ch_ship',
    'norwegian teams ch.ships', 'norewegian chship temas'],
  'Olrud Easter Swiss Teams' => ['olrudpaasken monrad lag',
    'olrud paasken monrad lag',
    'olrud swiss teams', 'olrud easter swiss event',
    'olrud easter swiss team'],
  'Olrud Easter Teams' => ['olrudpaasken teams',
    'olrud estern teamevent', 'olrud estern team-event',
    'olrud easter team-event'],
  'Open Catalunya Preferent' => ['open catalunya equips',
    'open cataluña preferent'],
  'Pan Arab Inter-Club Championship' => ['pan arab championship',
    'pan arab inter_club', 'pan arab interclub', 'pan arab inerclub',
    'pan arab inter-club', 'pan arab inter club', 'pan arab iner club'],
  'Pan China Construction Tournament' => [
    'pan china construction tourname'],
  'Patton de Monaco' => ["monaco's patton", 'patton international monaco',
    'patton international monte-carlo',
    'patton international monte carlo', 'patton monte carlo'],
  'Pärnu Summer Invitational Pairs' => [
    'pärnu summer_ invitational pairs_', 
    'parnu summer tournament_ invitatoinal pairs'],
  'Petit Grand Prix van Driene' => ['petit grand prix',
    'grand prix van driene'],
  'Plock District League' => ['plockiej ligi okregowej'],
  'Poddar National Masters' => ['poddar national master',
    'poddar nationals masters', 'podder national masters'],
  'Polish Boys Championship' => ['polish championship boys'],
  'Polish Girls Championship' => ['polish championship girls'],
  'Polish IMP Pairs' => ['butler polish championship',
    'butler (imp) polish pairs championship'],
  'Polish Open Teams' => ['polish open tems'],
  'Polish Pairs' => ['pairs championship od poland'],
  'Polish Premier League' => ['polish premiere league',
    'polish league', 'polish premier leuge'],
  'Polish Youngster Teams' => ['kadry juniorów m³odszych'],
  'Pomerania Cup' => ['rozgrywek pucharowych pwzbs'],
  'Portuguese Open Teams' => ['equipas open pt', 'open teams pt'],
  'PYC Royale' => ['pyc hindu gymkhana royale'],
  'Riga Invites to Jurmala' => ['riga invites', 'latvia invites'],
  'Romanian League' => ['cn echipe', 'c_n_ echipe', 'cn ecgipe'],
  'Rottneros Nordic Cup' => ['rottneros cup'],
  'Ruia Gold Cup' => ['ruia gold'],
  'Ruter 7 Open' => ['ruter7 elitetournament'],
  'Sao Paulo State Championship' => ['s o paulo cup', 'sao paulo champ',
    'sao paulo championship', 'sao paulo champ', 'sao paulo cup',
    'sao paulo state cup', 'são paulo cup', 
    'são paulo state championship'],
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Scottish Cup' => ['scot cup', 'scot cuo', 'scottish cup plate'],
  'Senior Camrose' => ['seniors camrose'],
  'Serbian Cup' => ['cup of serbia', 'kub srbije'],
  'Serbian Premier League' => ['serbian premier leaugue',
    'serbian league'],
  'Serbian Team Championship' => ['serbia teams championship',
    'serbian tam championship', 'serbian teams championship',
    'serbianteam championship'],
  'Shenhua Cup' => ['shen hua cup'],
  'Silver Jubilee' => ['siver jubliee'],
  'Slava Cup' => ['cup slava'],
  'South African Championship' => ['south african nationals'],
  'South American Bridge Championships' => ['sabc'],
  'South Zone Championship' => ['southzone championship'],
  'Southeast Asian Games' => ['sea games', 'south east asian games'],
  'Spanish Central Zone Teams' => ['zonal centro equipos',
    'equipos zonal centro'],
  'Spanish Teams Championship' => ['campeonato de españa por equipos'],
  'Spring Fours' => ['spring 4s', 'spring foursomes', 'schapirosfs'],
  'Spring Nationals' => ['spring nat', 'spring national', 'spring nats',
    'sping national'],
  'Staszic Pairs Cup' => ['otp puchar grodu staszica'],
  'Stockholm Teams' => ['stockholm teams cs'],
  'Summer Monsoon League' => ['summer monsoon'],
  'Summer Nationals' => ['summer national'],
  'Swedish District Championship' => ['swedish championships distrcit',
    'sweden distric', 'swedish districts', 'swedish disttrict',
    'swedis district', 'swesish district', 'sweden district',
    'swedish championship district', 'swesish champsionship district',
    'swedish championships district', 'swedish district championships'],
  'Swedish Juniors Championship' => ['swedish juniors cs'],
  'Swedish Juniors Teams' => ['swedish juniors teams cs',
    'swedish juniors teams cs'],
  'Swiss Cup' => ['coupe suisse'],
  'Swiss Championship' => ['champion suisse', 'championnat suisse'],
  'Taiwanese Teams' => ['taiwanese teal'],
  'TATA Open' => ['tata opren'],
  'Teltscher Trophy' => ['teltcher trophy', 'telscher trophy'],
  'TGR Auction Pairs' => ['tgr auction pair', "tgr's auction pairs",
    'tgrs auction pair', 'tgrs auction pairs'],
  'TGR Auction Teams' => ['tgrs auction teams'],
  'TGR Super League' => ["tgr's super league", "tgr's super legue",
    'tgrs league', 'tgrs 2nd auction pairs', 'tgrs super league',
    "tgr's league", "trg's super league"],
  'The Hague Bridge Experience' => ['the hague bride experience',
    'teh hague bridge experience'],
  'Thrace Club Teams' => ['thrace region clubs team championship',
    'türk trakya bölge kulüpler þampýyonasi ekýbý'],
  'Thrace Cup League' => ['trakya kulupler ligi'],
  'Tianjin Binhai Cup' => ['tianjin bin hai cup'],
  'Tolani Gold Trophy' => ['dr_tolani gold troph',
    'tolani summer nationals gold', 'tolani summer nationald gold',
    'tolani gold summer nationals', 'tolani gold summar nationals',
    'tolani gold summer national'. 'dr_tolanigoldcup',
    'dr_tolani gold summer nationals'],
  'Tolani Grand Prix' => ['tolani gp', 'tolani grand pix'],
  'Tolani Silver Cup' => ['dr tolani summer nationals silver',
    'dr_tolani open summer nationals silver',
    'dr_tolani silver cup summer national',
    'dr_tolani sliver cup summer nationals'],
  'Torneo di Roma' => ['tornei di roma'],
  'Turkich Club Championship' => ['türkýye kulüplerarasi þampýyonasi',
    'türkýye klüpler arasi brýç þampýyonasi'],
  'Turkish East & South-East Teams' =>
    ['turkish clubs championship - east & south east el'],
  'Turkish Winter Women Teams' => [
    'turkish winter woman team championship'],
  'Turkish Women Teams' => ['türkish ladies teams'],
  'United States Bridge Championship' => ['us bridge championship',
    'u_s_b_c'],
  'United States Women Bridge Championship' => [
    "us women's bridge championship", "us women's bridge championhip"],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
  'Victorian Open Teams' => ['victorian opean teams', 'victorian open',
    "'victorian open", 'victorian open team'],
  'Victorian Pennant' => ['vic pennant'],
  'Vinoble Cup' => ['vinoble open'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"],
  'Warsaw Online Teams' => ['enthusiast bridge zlot', 
    'warsaw bboers champ', 'warsaw bboers championship'],
  'Wellingdon Swiss Pairs' => ['wsc open swiss pairs championship',
    'wsc open swisspairs championship', 'wsc swiss open pairs'],
  'Western Mediterranean Club Teams' => [
    'western mediterranean clubs team championship'],
  'White House Juniors' => ['whiteouse juniors', 'the white hous juniors',
    'qhite house juniors'],
  'White House Top 12' => ['modalfa top 12', 'witte huis top 12'],
  'White House Top 16' => ['white house int. teams top 16',
    'white house int_ teams top 16',
    'white house international top 16 teams'],
  'White House Top Circuit' => ['melchemie top circuit',
    'ing bank top circuit', 'ng bank top circuit', 
    'white house topcircuit', 'witte huis topcircuit',
    'the white house topcircuit'],
  'Winter Championships' => ['winter championship',
    'winter championsship'],
  'Winter Nationals' => ['winter national', 'wintter nationals',
    'wintrer national'],
  'Winter Open Teams' => ['winter teams', 'winter team'],
  'World Juniors Championship' => ['world juniors championships'],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Mind Games' => ['world mind game', 'word mind games', 'wmsg',
    'mind sports games', 'sawmg', 'wmg', 'wnsg', 'world ming games'],
  'World Open Pairs' => ['world pairs championship'],
  'World Seniors Championships' => ['world senior championship'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
  'World University Championship' => [
    'world university bridge championship',
    'world university bridge championships',
    'univ_ world champs'],
  'World Youth Championship' => ['world youth championships'],
  'World Youth Congress' => ['youth world bridge congress',
    'worlf youth bridge congress', 'workd youth bridge congress',
    'world youht congress'],
  'World Youth Teams Championship' => ['world youth team championships',
    'world youth teams'],
  'Yeh Bros Cup' => ['yehbros cup'],
  'Young Chelsea Knock-out' => ['yc ko']
);

my @SINGLE_WORDS = qw(
  Bundesliga
  Camrose Cavendish
  Reisinger
  Rosenblum
  Spingold
  Vadsøturneringen Vanderbilt
  Wagar
);

my %SINGLE_TYPOS =
(
  'ABPF Championships' => ['pabfc'],
  'ASEAN Club Championship' => ['abcc'],
  'Australian National Open Teams' => ['anot'],
  'Bermuda Bowl' => ['bb'],
  "Buffett Cup" => ['buffett', 'buffet'],
  Camrose => ['camroae', 'ccmrose'],
  'Canadian Bridge Championship' => ['cbc'],
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc'],
  'Canadian Women Teams Championship' => ['cwtc'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish', 'cav'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  "d'Orsi" => ['dorsi', 'sb', 'dosb'],
  'Dutch Meesterklasse' => ['meesterklasse'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Championship' => ['ec'],
  'European Small Federation Games' => ['esfg', 'sfc'],
  'European University Bridge Championship' => ['eubc', 'eucb', 'euc'],
  'European Winter Games' => ['ewg'],
  'European Youth Bridge Championship' => ['eybc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'European Youth Bridge Teams Championship' => ['eytc'],
  'German Team Championship' => ['teammeisterschaft'],
  'Grand National Open Teams' => ['gnot'],
  'Grand Prix of Poland' => ['gpp'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  "Linda Stern Women's Teams" => ['lswt'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'North American Bridge Championship' => ['nabc'],
  'NTU Cup' => ['ntucup'],
  'Olrud Easter Teams' => ['olrudeasterteams'],
  'Paris Youth Open Teams' => ['ypob'],
  'Peggy Bayer' => ['peggybayer'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Reisinger => ['reisiger', 'resisinger'],
  'Rondane Cup' => ['rondanecupen'],
  'Ruia Trophy' => ['ruia'],
  'Southeast Asian Games' => ['seagames'],
  'Summer Nationals' => ['summernationals'],
  'Takamatsu Cup' => ['takamatsu'],
  'Teltscher Trophy' => ['teltschertrophy', 'teltscher'],
  'Tolani Grand Prix' => ['tolanigrandprix'],
  'Transnational Open Teams' => ['tnt', 'tnot'],
  'United States Bridge Championship' => ['usbc'],
  'United States Juniors Bridge Championship' => ['usjbc'],
  'United States Seniors Bridge Championship' => ['ussbc'],
  'United States Women Bridge Championship' => ['uswbc', 'uswbf', 'uswc'],
  Vanderbilt => ['vanderbuilt', 'vanderebilt', 'vandebilt'],
  'Venice Cup' => ['vc'],
  'Victor Champion Cup' => ['vcc'],
  'Victorian Pennant' => ['pennant'],
  'Vilnius Club Pairs' => ['vbk'],
  'White House Juniors' => ['whj'],
  'Winter Nationals' => ['winternationals'],
  'World Bridge Series' => ['wbs'],
  'World Team Championships' => ['wbtc'],
  'World Team Olympiad' => ['olympiad', 'olympiads'],
  'World University Championship' => ['wuc'],
  'World Youth Bridge Team Championship' => ['wybtc'],
  'World Youth Open Bridge Championship' => ['wyobc', 'wboyc'],
  'World Youth Teams Championship' => ['wytc', 'world youth teams'],
  'Young Chelsea Knock-out' => ['ycko'],
  'Zimmermann Cup' => ['zc']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
