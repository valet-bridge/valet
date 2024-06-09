#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Meet;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Azores Festival',
  'Greek Islands Festival',
  'Amman Bridge Festival',
  'Australian National Championships',
  'Balkan Friendship Festival',
  'Bangkok Bridge Festival',
  'Brasov Festival',
  'Cairo Bridge Festival',
  'Cappadocia Fairy Chimneys Festival',
  'Crete Bridge Festival',
  'Danish Bridge Festival',
  'Estoril Bridge Festival',
  'Gold Coast Congress',
  'Iceland Bridge Festival',
  'Israel International Festival',
  'Jordan Bridge Festival',
  'Mar del Plata Festival',
  'Marmara Festival',
  'Mautern Bridge Festival',
  'Mersin Bridge Festival',
  'Pärnu Festival',
  'Plovdiv Bridge Festival',
  'Poznan Bridge Festival',
  'Pula Bridge Festival',
  'Reykjavik Bridge Festival',
  'Serdika Bridge Festival',
  'Sivrioglu Festival',
  'Stara Zagora Bridge Festival',
  'Tallinn Bridge Festival',
  'Varna Bridge Festival',
  'Wachauer Bridge Festival',
  'Red Sea International Festival',
  'The Hague Bridge Festival'
);

my %MULTI_TYPOS =
(
  'Azores Festival' => ['azores festival bridge',
    'festival azores bridge', 'azores festiva'],
  'Balkan Friendship Festival' => ['balkan bridge festival',
    'balkan festival', 'balcan friendship festival',
    'balcan frienship festival'],
  'Brasov Festival' => ['festival brasov', 'festival bridge brasov',
    'international bridge festival brasov'],
  'Crete Bridge Festival' => ['crete b_ festival'],
  'Estoril Bridge Festival' => ['estoril festival'],
  'Gold Coast Congress' => ['gold coast'],
  'Greek Islands Festival' => ['greek bridge festival',
    'greek island festival', 'athens bridge festival', 
    'greek islands festivals'],
  'Iceland Bridge Festival' => ['iceland bridgefestival',
    'iceland express bridge festival',
    'icelandic express bridge festival'],
  'Israel International Festival' => ['israel int_ festival'],
  'Jordan Bridge Festival' => ['jordab festival', 'jordan b_ festival'],
  'Mar del Plata Festival' => [ 'mar del plata international festival',
    'mar del plata international bridge festival'],
  'Marmara Festival' => ['festival marmara'],
  'Mautern Bridge Festival' => ['mautern bridgefestival'],
  'Plovdiv Bridge Festival' => ['international festival - plovdiv',
    'international festival plovdiv'],
  'Poznan Bridge Festival' => ['poznanski kongres brydzowy',
    'kongres poznanski'],
  'Pula Bridge Festival' => ['international festival pula'],
  'Red Sea International Festival' => ['red see international festival',
    'read beach festival', 'red beach festival', 'red sea festival',
    'red sea bridge festival', 'red see int_ bridge festival'],
  'Reykjavik Bridge Festival' => ['reykjavikbridgefestival'],
  'Serdika Bridge Festival' => ['bridge festival - serdika',
    'bridge festival serdika'],
  'Stara Zagora Bridge Festival' => ['bridge festival - stara zagora',
    'bridge festival stara zagora', 
    'bridge festival-bulgaria-stara zagora'],
  'Tallinn Bridge Festival' => ['talinn festival', 'tallin festival',
    'tallinns festival'],
  'Varna Bridge Festival' => ['international bridge festival varna'],
  'Wachauer Bridge Festival' => ['wachauer bridgefestival']
);

my @SINGLE_WORDS = qw(
  Congress
  Festival
);

my %SINGLE_TYPOS =
(
  'Australian National Championships' => ['anc'],
  'Bangkok Bridge Festival' => ['bbf', 'bff'],
  Congress => ['kongres', 'kongresowy'],
  Festival => ['fest', 'festiva', 'festivan', 'festval', 'festývalý',
    'festivali', 'festivals', 'festivalul', 'bridgefestival',
    'festiwal'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
