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
  'Buffett Cup',
  "d'Orsi",
  'Junior Camrose',
  'Senior Camrose',
  'Vanderbilt Fantasy Challenge'
);

my %MULTI_TYPOS =
(
  'Buffett Cup' => ['buffet cup'],
  Camrose => ['camrose trophy'],
  "d'Orsi" => ["d'orsi senior bowl", "d´orsi"],
  'Junior Camrose' => ['juniior camrose'],
  'Senior Camrose' => ['seniors camrose'],
  Vanderbilt => ['vanderbilt teams', 'vanderbilt ko teams'],
  Wagar => ['wagar teams', "wagar women's", "wagar women's ko"]
);

my @SINGLE_WORDS = qw(
  Camrose Cavendish
  Spingold
  Vanderbilt
  Wagar
);

my %SINGLE_TYPOS =
(
  "Buffett Cup" => ['buffett'],
  Camrose => ['camroae', 'ccmrose'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish'],
  "d'Orsi" => ['dorsi'],
  Vanderbilt => ['vanderbuilt']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
