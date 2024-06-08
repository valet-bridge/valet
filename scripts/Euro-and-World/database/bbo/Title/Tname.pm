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
  "d'Orsi",
  'Junior Camrose',
  'Lady Milne Trophy',
  'McConnell Cup',
  'Peggy Bayer',
  'Senior Camrose',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup',
  'World Bridge Series',
  'World Masters Individual',
  'World Men Elite Tournament',
  'World Mind Games',
  'World Team Olympiad',
  'World Top Tournament',
  'World University Championship',
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
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi", 'senior world cup'],
  'Junior Camrose' => ['juniior camrose'],
  'Lady Milne Trophy' => ['lady milne'],
  'McConnell Cup' => ['mc connell'],
  'Senior Camrose' => ['seniors camrose'],
  'Spring Fours' => ['spring 4s', 'spring foursomes'],
  'Spring Nationals' => ['spring nat', 'spring national'],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
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
  "d'Orsi" => ['dorsi'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'McConnell Cup' => ['mcconnell'],
  'Peggy Bayer' => ['peggybayer'],
  Qualifying => ['qualification', 'qualifications', 'qualif',
    'qualifier'],
  Reisinger => ['reisiger'],
  Vanderbilt => ['vanderbuilt', 'vanderebilt', 'vandebilt']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
