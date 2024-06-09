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
  'Altman Swiss Pairs',
  'ArboNed Team Cup',
  'ASEAN Club Championship',
  'Asia Cup',
  'Asian University Championship',
  'Australian National Open Teams',
  'Baltic Bowl',
  'Baltic Cup',
  'Baze Senior Knock-out',
  'Bergen Grand Tournament',
  'Bermuda Bowl',
  'Bermuda Triangle Cup',
  'Bobby Evans Seniors Teams',
  'British Gold Cup',
  'Buffett Cup',
  'Canadian National Teams Championship',
  'Canadian Seniors Teams Championship',
  'Canadian Women Teams Championship',
  'Carrousel Cup',
  "Champions' Cup",
  'Channel Trophy',
  'China Elite Tournament',
  'Codan Cup',
  'Collegiate Bowl',
  'Commonwealth Nations Bridge Championships',
  'Computer World Championship',
  'Cross Strait Invitational',
  'Czech Championship',
  'Czech Team Championship',
  'Czech First League',
  "d'Orsi",
  'Damiani Cup',
  'Danish Club Teams',
  'Danish Pairs Championship',
  'Danish Teams Championship',
  'Dutch Meesterklasse',
  'Egyptian League',
  'European Bridge Teams Championship',
  'European Open Bridge Championship',
  "European Champions' Cup",
  'European Championship',
  'European Small Federation Games',
  'European University Bridge Championship',
  'European Youth Bridge Pairs Championship',
  'EUSA Games',
  'Filbyter Cup',
  'Finnish Cup',
  'Finnish Pairs Championship',
  'Finnish Teams Championship',
  'Forbo Krommenie Teams',
  'Forbo Nations Cup',
  'FOSS Grand Tournament',
  'French Cup',
  'Gardermoen Airport Hotel Cup',
  'Gelibolu Peace Cup',
  'German Club Cup',
  'German Team Championship',
  'German Team Trophy',
  'Golden Jubilee',
  'Grand National Open Teams',
  'Grand Prix of Poland',
  'Hainan Air Cup',
  'Hecht Cup',
  'Hellenic Team Trials',
  'Hellenic Team Championship',
  'Higson Cup',
  'Hong Kong Inter-City',
  'Icelandair Open',
  'IMSA Elite Mind Games',
  'Indonesian National Games',
  'Italy Cup',
  'JPD Cup',
  'Junior Camrose',
  'Kalani Trophy',
  "Kepri Governor's Cup",
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  "Linda Stern Women's Teams",
  'Maccabi Games',
  'McConnell Cup',
  'Nations Cup',
  'NN Cup',
  'Nordic Championship',
  'Nordic Junior Championship',
  'Nordic Junior Team Championship',
  'Nordic Cup',
  'North American Bridge Championship',
  'Northern Greece Regional Championship',
  'Norwegian Club Teams',
  'Norwegian Swiss Teams',
  'Palace Cup',
  'Pan Arab Inter-Club Championship',
  'Pärnu Summer Invitational Pairs',
  'Peggy Bayer',
  'Pesta Sukan',
  'Poddar National Masters',
  'Prince Henrik Trophy',
  'Puutalo Open',
  'Riau Governor Cup',
  'Rondane Cup',
  'Rottneros Nordic Cup',
  'Ruia Gold Cup',
  'Sao Paulo State Championship',
  'Sarundajang Cup',
  'Scottish Cup',
  'Senior Camrose',
  'Serbian Cup',
  'Serbian Premier League',
  'Serbian Team Championship',
  'Shenhua Cup',
  'Silver Jubilee',
  'Slava Cup',
  'South American Bridge Championships',
  'South Zone Championship',
  'Southeast Asian Games',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Summer Monsoon League',
  'Swiss Cup',
  'Takamatsu Cup',
  'Taiwan University Cup',
  'Teltscher Trophy',
  'Tianjin Binhai Cup',
  'TGR Auction Pairs',
  'TGR Auction Teams',
  'TGR Super League',
  'Tolani Grand Prix',
  'Tornei di Roma',
  'Towns Cup',
  'Transnational Open Teams',
  'Trondheim Cup',
  'United States Bridge Championship',
  'United States Juniors Bridge Championship',
  'United States Seniors Bridge Championship',
  'United States Women Bridge Championship',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup',
  'Victor Champion Cup',
  'Victorian Pennant',
  'Vinoble Cup',
  'Watermark Bridge Classic',
  'Winter Nationals',
  'Winter Championships',
  'Winter Open Teams',
  'Winter Women Teams',
  'Whitelaw Cup',
  'World Bridge Series',
  'World Masters Individual',
  'World Men Elite Tournament',
  'World Mind Games',
  'World Team Championships',
  'World Team Olympiad',
  'World Top Tournament',
  'World University Championship',
  'World Youth Congress',
  'World Youth Open Bridge Championship',
  'World Youth Teams Championship',
  'World Youth Bridge Congress',
  'World Youth Bridge Teams Championship',
  'World Women Elite Tournament',
  'Xinyuan Cup',
  'Young Chelsea Knock-out',
  'Zhejiang Huamen Cup'
);

my %MULTI_TYPOS =
(
  'ArboNed Team Cup' => ['arbo ned team cup', 'arbo ned teams cup'],
  'ASEAN Club Championship' => ["asean bridge club c'ship",
    'asean bridge club championship', "asean bridge c'ship",
    'asean bridge club', 'asean bridge club championships',
    'asean bridge cship', 'asean bridge championship',
    'asean bridge club open championships',
    'asean bridg club championship', 'asean bridge championships',
    'asean club championships'],
  'Asian University Championship' => [
    'asian university bridge championship'],
  'Baze Senior Knock-out' => ['baze senior ko', 'baze sr_ ko',
    'base sr ko', 'baze sr_ ko'],
  'Bergen Grand Tournament' => ['bergen open', 'bergen stor',
    'bergen storturnering'],
  'Bermuda Triangle Cup' => ['bermuda triangle teams cup'],
  'British Gold Cup' => ['gold cup'],
  'Buffett Cup' => ['buffet cup', 'bufett cup'],
  Camrose => ['camrose trophy'],
  "Champions' Cup" => ['champions cup', "champion's cup", 'chamions cup', 
    'champs cup', 'champion cup'],
  'Channel Trophy' => ['channel trpohy'],
  'Czech Championship' => ['czech bridge championship',
    'czech bridge championships'],
  'Czech Team Championship' => ['czech team championships',
    'czech teams champ_'],
  'Czech First League' => ['czech 1st league', 'chech bridge league'],
  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi", 'senior world cup',
    'seniors bowl', 'senior bowl'],
  'Danish Club Teams' => ['danish club team'],
  'Danish Pairs Championship' => ['danish championship - open pairs',
    'danish open pairs championship', 'danish open pairs championships'],
  'Danish Teams Championship' => ['danish team champions',
    'danish team championships', 'danish team championship',
    'danish open team', 'danish open teams', 'danish teams'],
  'Egyptian League' => ['egy_league', 'egy-league'],
  'European Bridge Teams Championship' => ['european b.t.ch.',
    'european b_t_ch_'],
  'European Championship' => ['eur champ'],
  'European Open Bridge Championship' => ['eobc'],
  'European Small Federation Games' => ['ebl small federation trophy',
    'ebl small federations trophy', 'games of small federations',
    'european small federations games', 'small federation games',
    'small federations games', 'small ffederations games',
    'small federation cup', 'european small feds games'],
  'Finnish Pairs Championship' => ['finnish pair championship',
    'finnish pair championships', 'finnish pairs champs',
    'finnish pairs'],
  'Finnish Teams Championship' => ['finnish teams championships',
    'finnish teams', 'finnish team championships'],
  'Forbo Krommenie Teams' => ['forbo-krommonie tourname',
    'forbo-krommenie tournament', 'forbo-krommenietournament',
    'forbo-krommenie international bridge event',
    'international forbo krommenie bridge event'],
  'Forbo Nations Cup' => ['Forbo Teams'],
  'FOSS Grand Tournament' => ['foss grand tourney',
    'foss grand tourament', 'foss grand tournement', 'foos grnad tourn'],
  'French Cup' => ['coupe de france'],
  'German Club Cup' => ['german cup'],
  'German Team Championship' => ['deutsche teammeisterschaft'],
  'German Team Trophy' => ['german bridge team trophy'],
  'Golden Jubilee' => ['golden jubily'],
  'Grand Prix of Poland' => ['grand prix polski', 'gp of poland',
    'grnd prix of poland'],
  'Hellenic Team Championship' => ['hellenic teams championship'],
  'Icelandair Open' => ['icelandari open'],
  'Junior Camrose' => ['juniior camrose'],
  "Kepri Governor's Cup" => ['kepri governor cup', 'kepri cup',
    'kepri governors cup', 'gubernur kepri cup', 'guvernor kepri cup'],
  'Lady Milne Trophy' => ['lady milne', 'lady mile'],
  'Lederer Memorial Trophy' => ['lederer memorial'],
  "Linda Stern Women's Teams" => ['linda stern womens teams'],
  'Maccabi Games' => ['maccabi-games'],
  'McConnell Cup' => ['mc connell'],
  'NN Cup' => ['nn-cup'],
  'Nordic Championship' => ['nordic championships',
    'nordic bridge championship', 'nordic bridge championships'],
  'Nordic Junior Team Championship' => [
    'nordic junior teams championship',
    'nordic junior teams championships'],
  'Northern Greece Regional Championship' => [
    'n_ greece regional championship'],
  'Norwegian Club Teams' => ['norwegian clubteams championship'],
  'Pan Arab Inter-Club Championship' => ['pan arab championship',
    'pan arab inter_club', 'pan arab interclub', 'pan arab inerclub',
    'pan arab interclub', 'pan arab inter-club'],
  'Pärnu Summer Invitational Pairs' => [
    'pärnu summer_ invitational pairs_', 
    'parnu summer tournament_ invitatoinal pairs'],
  'Poddar National Masters' => ['poddar national master',
    'poddar nationals masters'],
  'Rottneros Nordic Cup' => ['rottneros cup'],
  'Sao Paulo State Championship' => ['s o paulo cup', 'sao paulo champ',
    'sao paulo championship', 'sao paulo champ', 'sao paulo cup',
    'sao paulo state cup', 'são paulo cup', 
    'são paulo state championship'],
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Scottish Cup' => ['scot cup', 'scot cuo'],
  'Senior Camrose' => ['seniors camrose'],
  'Serbian Cup' => ['cup of serbia'],
  'Serbian Premier League' => ['serbian premier leaugue',
    'serbian league'],
  'Serbian Team Championship' => ['serbia teams championship',
    'serbian tam championship', 'serbian teams championship',
    'serbianteam championship'],
  'Silver Jubilee' => ['siver jubliee'],
  'South American Bridge Championships' => ['sabc'],
  'South Zone Championship' => ['southzone championship'],
  'Southeast Asian Games' => ['sea games'],
  'Spring Fours' => ['spring 4s', 'spring foursomes', 'schapirosfs'],
  'Spring Nationals' => ['spring nat', 'spring national'],
  'Summer Monsoon League' => ['summer monsoon'],
  'Swiss Cup' => ['coupe suisse'],
  'Teltscher Trophy' => ['teltcher trophy'],
  'TGR Auction Pairs' => ['tgr auction pair', "tgr's auction pairs",
    'tgrs auction pair', 'tgrs auction pairs'],
  'TGR Auction Teams' => ['tgrs auction teams'],
  'TGR Super League' => ["tgr's super league", "tgr's super legue",
    'tgrs league', 'tgrs 2nd auction pairs'],
  'Tolani Grand Prix' => ['tolani gp'],
  'United States Bridge Championship' => ['us bridge championship',
    'u_s_b_c'],
  'United States Women Bridge Championship' => [
    "us women's bridge championship", "us women's bridge championhip"],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
  'Victorian Pennant' => ['vic pennant'],
  'Vinoble Cup' => ['vinoble open'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"],
  'Winter Championships' => ['winter championship',
    'winter championsship'],
  'Winter Nationals' => ['winter national'],
  'Winter Open Teams' => ['winter teams', 'winter team'],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Mind Games' => ['world mind game', 'word mind games', 'wmsg',
    'mind sports games', 'sawmg', 'wmg'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
  'World University Championship' => [
    'world university bridge championship',
    'world university bridge championships',
    'univ_ world champs'],
  'World Youth Congress' => ['youth world bridge congress'],
  'World Youth Teams Championship' => ['world youth team championships'],
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
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc'],
  'Canadian Women Teams Championship' => ['cwtc'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  "d'Orsi" => ['dorsi', 'sb', 'dosb'],
  'Dutch Meesterklasse' => ['meesterklasse'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Championship' => ['ec'],
  'European University Bridge Championship' => ['eubc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'German Team Championship' => ['teammeisterschaft'],
  'Grand National Open Teams' => ['gnot'],
  'Grand Prix of Poland' => ['gpp'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'North American Bridge Championship' => ['nabc'],
  'Peggy Bayer' => ['peggybayer'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Reisinger => ['reisiger', 'resisinger'],
  'Rondane Cup' => ['rondanecupen'],
  'Takamatsu Cup' => ['takamatsu'],
  'Teltscher Trophy' => ['teltschertrophy'],
  'Transnational Open Teams' => ['tnt', 'tnot'],
  'United States Bridge Championship' => ['usbc'],
  'United States Juniors Bridge Championship' => ['usjbc'],
  'United States Seniors Bridge Championship' => ['ussbc'],
  'United States Women Bridge Championship' => ['uswbc', 'uswbf'],
  Vanderbilt => ['vanderbuilt', 'vanderebilt', 'vandebilt'],
  'Venice Cup' => ['vc'],
  'Victor Champion Cup' => ['vcc'],
  'Victorian Pennant' => ['pennant'],
  'Winter Nationals' => ['winternationals'],
  'World Bridge Series' => ['wbs'],
  'World Team Championships' => ['wbtc'],
  'World Team Olympiad' => ['olympiad', 'olympiads'],
  'World University Championship' => ['wuc'],
  'World Youth Bridge Team Championship' => ['wybtc'],
  'World Youth Open Bridge Championship' => ['wyobc', 'wboyc'],
  'World Youth Teams Championship' => ['wytc'],
  'Young Chelsea Knock-out' => ['ycko']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
