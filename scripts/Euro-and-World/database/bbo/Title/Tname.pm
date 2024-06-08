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
  'Buffett Cup',
  "d'Orsi",
  'Junior Camrose',
  'McConnell Cup',
  'Senior Camrose',
  'Spring Fours',
  'Spring of Cracow',
  'Spring Nationals',
  'Vanderbilt Fantasy Challenge',
  'Venice Cup'
);

my %MULTI_TYPOS =
(
  'Buffett Cup' => ['buffet cup', 'bufett cup'],
  Camrose => ['camrose trophy'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi"],
  'Junior Camrose' => ['juniior camrose'],
  'McConnell Cup' => ['mc connell'],
  'Senior Camrose' => ['seniors camrose'],
  'Spring Fours' => ['spring 4s', 'spring foursomes'],
  'Spring Nationals' => ['spring nat', 'spring national'],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  'Venice Cup' => ['<venive <cup'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"]
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
    'cavendsh', 'cavvendish'],
  "d'Orsi" => ['dorsi'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'McConnell Cup' => ['mcconnell'],
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
