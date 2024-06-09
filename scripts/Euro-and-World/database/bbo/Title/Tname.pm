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
  'Altman Swiss Pairs',
  'ASEAN Club Championship',
  'Australian National Open Teams',
  'Baltic Bowl',
  'Baltic Cup',
  'Baze Senior Knock-out',
  'Bergen Grand Tournament',
  'Bermuda Bowl',
  'Bermuda Triangle Cup',
  'British Gold Cup',
  'Buffett Cup',
  "Champions' Cup",
  'Channel Trophy',
  'Codan Cup',
  'Collegiate Bowl',
  'Computer World Championship',
  "d'Orsi",
  'European Bridge Teams Championship',
  'European Open Bridge Championship',
  "European Champions' Cup",
  'European Small Federation Games',
  'European Youth Bridge Pairs Championship',
  'German Club Cup',
  'German Team Trophy',
  'Golden Jubilee',
  'Grand Prix of Poland',
  'Higson Cup',
  'Junior Camrose',
  "Kepri Governor's Cup",
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  'Maccabi Games',
  'McConnell Cup',
  'Nations Cup',
  'Nordic Championship',
  'Pan Arab Inter-Club Championship',
  'Peggy Bayer',
  'Prince Henrik Trophy',
  'Ruia Gold Cup',
  'Sao Paulo State Championship',
  'Senior Camrose',
  'Silver Jubilee',
  'Slava Cup',
  'South American Bridge Championships',
  'South Zone Championship',
  'Southeast Asian Games',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Summer Monsoon League',
  'Teltscher Trophy',
  'Transnational Open Teams',
  'United States Bridge Championship',
  'United States Seniors Bridge Championship',
  'United States Women Bridge Championship',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup',
  'Victor Champion Cup',
  'Victorian Pennant',
  'Vinoble Cup',
  'World Bridge Series',
  'World Masters Individual',
  'World Men Elite Tournament',
  'World Mind Games',
  'World Team Championships',
  'World Team Olympiad',
  'World Top Tournament',
  'World University Championship',
  'World Youth Open Bridge Championship',
  'World Youth Bridge Teams Championship',
  'World Women Elite Tournament'
);

my %MULTI_TYPOS =
(
  'ASEAN Club Championship' => ["asean bridge club c'ship",
    'asean bridge club championship', "asean bridge c'ship",
    'asean bridge club', 'asean bridge club championships',
    'asean bridge cship', 'asean bridge championship',
    'asean bridge club open championships',
    'asean bridg club championship', 'asean bridge championships',
    'asean club championships'],
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
  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi", 'senior world cup',
    'seniors bowl', 'senior bowl'],
  'European Open Bridge Championship' => ['eobc'],
  'European Small Federation Games' => ['ebl small federation trophy',
    'ebl small federations trophy', 'games of small federations',
    'european small federations games', 'small federation games',
    'small federations games', 'small ffederations games',
    'small federation cup'],
  'German Club Cup' => ['german cup'],
  'German Team Trophy' => ['german bridge team trophy'],
  'Golden Jubilee' => ['golden jubily'],
  'Grand Prix of Poland' => ['grand prix polski'],
  'Junior Camrose' => ['juniior camrose'],
  "Kepri Governor's Cup" => ['kepri governor cup', 'kepri cup',
    'kepri governors cup', 'gubernur kepri cup', 'guvernor kepri cup'],
  'Lady Milne Trophy' => ['lady milne'],
  'Lederer Memorial Trophy' => ['lederer memorial'],
  'Maccabi Games' => ['maccabi-games'],
  'McConnell Cup' => ['mc connell'],
  'Nordic Championship' => ['nordic championships',
    'nordic bridge championship', 'nordic bridge championships'],
  'Pan Arab Inter-Club Championship' => ['pan arab championship',
    'pan arab inter_club', 'pan arab interclub', 'pan arab inerclub',
    'pan arab interclub', 'pan arab inter-club'],
  'Sao Paulo State Championship' => ['s o paulo cup', 'sao paulo champ',
    'sao paulo championship', 'sao paulo champ', 'sao paulo cup',
    'sao paulo state cup', 'são paulo cup', 
    'são paulo state championship'],
  'Senior Camrose' => ['seniors camrose'],
  'Silver Jubilee' => ['siver jubliee'],
  'South American Bridge Championships' => ['sabc'],
  'South Zone Championship' => ['southzone championship'],
  'Southeast Asian Games' => ['sea games'],
  'Spring Fours' => ['spring 4s', 'spring foursomes', 'schapirosfs'],
  'Spring Nationals' => ['spring nat', 'spring national'],
  'Summer Monsoon League' => ['summer monsoon'],
  'Teltscher Trophy' => ['teltcher trophy'],
  'United States Bridge Championship' => ['us bridge championship',
    'u_s_b_c'],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
  'Victorian Pennant' => ['vic pennant'],
  'Vinoble Cup' => ['vinoble open'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Mind Games' => ['world mind game', 'word mind games', 'wmsg',
    'mind sports games', 'sawmg', 'wmg'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
  'World University Championship' => [
    'world university bridge championship',
    'world university bridge championships',
    'univ_ world champs']
);

my @SINGLE_WORDS = qw(
  Bundesliga
  Camrose Cavendish
  Reisinger
  Rosenblum
  Spingold
  Vanderbilt
  Wagar
);

my %SINGLE_TYPOS =
(
  'ASEAN Club Championship' => ['abcc'],
  'Australian National Open Teams' => ['anot'],
  'Bermuda Bowl' => ['bb'],
  "Buffett Cup" => ['buffett', 'buffet'],
  Camrose => ['camroae', 'ccmrose'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  "d'Orsi" => ['dorsi', 'sb'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Youth Bridge Pairs Championship' => ['eybpc'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'Peggy Bayer' => ['peggybayer'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Reisinger => ['reisiger', 'resisinger'],
  'Teltscher Trophy' => ['teltschertrophy'],
  'Transnational Open Teams' => ['tnt', 'tnot'],
  'United States Bridge Championship' => ['usbc'],
  'United States Seniors Bridge Championship' => ['ussbc'],
  'United States Women Bridge Championship' => ['uswbc'],
  Vanderbilt => ['vanderbuilt', 'vanderebilt', 'vandebilt'],
  'Venice Cup' => ['vc'],
  'Victor Champion Cup' => ['vcc'],
  'Victorian Pennant' => ['pennant'],
  'World Team Championships' => ['wbtc'],
  'World Team Olympiad' => ['olympiad', 'olympiads'],
  'World Youth Bridge Team Championship' => ['wybtc'],
  'World Youth Open Bridge Championship' => ['wyobc', 'wboyc']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
