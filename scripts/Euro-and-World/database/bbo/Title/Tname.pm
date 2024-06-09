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
  'Baltic Bowl',
  'Baltic Cup',
  'Bermuda Bowl',
  'Bermuda Triangle Cup',
  'Buffett Cup',
  "Champions' Cup",
  'Codan Cup',
  'Collegiate Bowl',
  'Computer World Championship',
  "d'Orsi",
  'European Small Federation Games',
  'German Club Cup',
  'German Team Trophy',
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
  'Senior Camrose',
  'Southeast Asian Games',
  'South Zone Championship',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Teltscher Trophy',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup',
  'Vinoble Cup',
  'World Bridge Series',
  'World Masters Individual',
  'World Men Elite Tournament',
  'World Mind Games',
  'World Team Olympiad',
  'World Top Tournament',
  'World University Championship',
  'World Youth Open Bridge Championship',
  'World Women Elite Tournament'
);

my %MULTI_TYPOS =
(
  'Bermuda Bowl' => ['world team championships'],
  'Bermuda Triangle Cup' => ['bermuda triangle teams cup'],
  'Buffett Cup' => ['buffet cup', 'bufett cup'],
  Camrose => ['camrose trophy'],
  "Champions' Cup" => ['champions cup', "champion's cup", 'chamions cup', 
    'champs cup', 'champion cup'],
  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi", 'senior world cup',
    'seniors bowl', 'senior bowl'],
  'European Small Federation Games' => ['ebl small federation trophy',
    'ebl small federations trophy', 'games of small federations',
    'european small federations games', 'small federation games',
    'small federations games', 'small ffederations games',
    'small federation cup'],
  'German Club Cup' => ['german cup'],
  'German Team Trophy' => ['german bridge team trophy'],
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
    'pan arab inter-club'],
  'Senior Camrose' => ['seniors camrose'],
  'South Zone Championship' => ['southzone championship'],
  'Spring Fours' => ['spring 4s', 'spring foursomes'],
  'Spring Nationals' => ['spring nat', 'spring national'],
  'Teltscher Trophy' => ['teltcher trophy'],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
  'Vinoble Cup' => ['vinoble open'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Mind Games' => ['world mind game', 'word mind games'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad'],
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
  "Buffett Cup" => ['buffett', 'buffet'],
  Camrose => ['camroae', 'ccmrose'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  "d'Orsi" => ['dorsi'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'Peggy Bayer' => ['peggybayer'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Reisinger => ['reisiger'],
  'Teltscher Trophy' => ['teltschertrophy'],
  Vanderbilt => ['vanderbuilt', 'vanderebilt', 'vandebilt'],
  'World Youth Open Bridge Championship' => ['wyobc', 'wboyc']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
