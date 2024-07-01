#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meet;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'All China Games',
  'Azores Festival',
  'Amman Bridge Festival',
  'Australian National Championships',
  'Australian Summer Festival',
  'Balkan Friendship Festival',
  'Baltic Congress',
  'Bangkok Bridge Festival',
  'Banten Sports Week',
  'Bodrum Peninsula Festival',
  'Brasov Festival',
  'Cairo Bridge Festival',
  'Cappadocia Fairy Chimneys Festival',
  'Crete Bridge Festival',
  'Danish Bridge Festival',
  'Estoril Bridge Festival',
  'Fes Festival',
  'Festival della Matematica',
  'Gold Coast Congress',
  'Greek Islands Festival',
  'Iceland Bridge Festival',
  'Indonesian National Pre-Sports Week',
  'Indonesian National Sports Week',
  'International Bridge Festival',
  'Israel Grand Prix',
  'Israel International Festival',
  'Israel Teams Cup',
  'Jordan Bridge Festival',
  'Krakow Meeting',
  'Lozenets Bridge Festival',
  'Luczniczka Meeting',
  'Mar del Plata Festival',
  'Marmara Festival',
  'Mautern Bridge Festival',
  'Mersin Bridge Festival',
  'Monaco International Festival',
  'Pärnu Festival',
  'Plovdiv Bridge Festival',
  'Polish Youth Olympiad',
  'Poznan Bridge Festival',
  'Pula Bridge Festival',
  'Red Sea International Festival',
  'Reykjavik Bridge Festival',
  'Serdika Bridge Festival',
  'Sivrioglu Festival',
  'Stara Zagora Bridge Festival',
  'Tallinn Bridge Festival',
  'Thailand National Games',
  'Turkish Autumn Festival',
  'Turkish-Greek Friendship Festival',
  'The Hague Bridge Festival',
  'Umea Bridgefestival',
  'Vanke Cup',
  'Varna Bridge Festival',
  'VVE Beheer Bridge Week',
  'Wachauer Bridge Festival',
  'West Java Regional',
  'Winter Bridge Festival',
  'Zulawski Congress'
);

my %MULTI_TYPOS =
(
  'All China Games' => ['all-china games'],
  'Australian Summer Festival' => ['sfob'],
  'Azores Festival' => ['azores festival bridge', 'azores bridge open',
    'azores bridge teams', 'azores team', 'azores teams',
    'azores team festval', 'festival azores bridge', 'azores festiva', 
    'festival azores'],
  'Balkan Friendship Festival' => ['balkan bridge festival',
    'balkan festival', 'balcan friendship festival',
    'balcan frienship festival', 'balkan frienship festival',
    'balkan friendsphip festival'],
  'Baltic Congress' => ['baltic bridge congress',
    'international baltic congress'],
  'Bodrum Peninsula Festival' => ['bodrum yarýmada bric festivali'],
  'Brasov Festival' => ['festival brasov', 'festival bridge brasov',
    'international bridge festival brasov',
    'festivalul international de bridge brasov'],
  'Crete Bridge Festival' => ['crete b_ festival'],
  'Estoril Bridge Festival' => ['estoril festival'],
  'Fes Festival' => ['fes bridge international festival',
    'festival fes', 'festival de fes', 'festival international de fès',
    'festival de fez'],
  'Gold Coast Congress' => ['gold coast'],
  'Greek Islands Festival' => ['greek bridge festival',
    'greek island festival', 'athens bridge festival', 
    'greek islands festivals', 'greek festival islands', 'greek islands'],
  'Iceland Bridge Festival' => ['iceland bridgefestival',
    'iceland express bridge festival',
    'icelandic express bridge festival'],
  'Indonesian National Pre-Sports Week' => ['pra pon'],
  'Indonesian National Sports Week' => ['indonesia week',
    'indonesian national sports weeks'],
  'International Bridge Festival' => ['int_ bridge festival'],
  'Israel Grand Prix' => ['israeli grand prix',
    'israeli grand prize'],
  'Israel International Festival' => ['israel int_ festival',
    'int_ israel festival', 'israel festival', 'israel fest_'],
  'Israel Teams Cup' => ['israel national team cup',
    'israel team cup', 'israel team of four cup'],
  'Jordan Bridge Festival' => ['jordab festival', 'jordan b_ festival',
    'jordan bridge f estival', 'jordan bridge tournament spring festival',
    'jordan bridge tournament ( spring festival)',
    'jordan bridge tournament (spring festival)'],
  'Lozenets Bridge Festival' => ['bridge festival lozenets'],
  'Luczniczka Meeting' => ['meeting luczniczka'],
  'Mar del Plata Festival' => [ 'mar del plata international festival',
    'mar del plata international bridge festival'],
  'Marmara Festival' => ['festival marmara'],
  'Mautern Bridge Festival' => ['mautern bridgefestival'],
  'Monaco International Festival' => ['festival international de monaco'],
  'Plovdiv Bridge Festival' => ['international festival - plovdiv',
    'international festival plovdiv'],
  'Polish Youth Olympiad' => ['oom'],
  'Poznan Bridge Festival' => ['poznanski kongres brydzowy',
    'kongres poznanski', 'bridge meeting poznan'],
  'Pula Bridge Festival' => ['international festival pula'],
  'Red Sea International Festival' => ['red see international festival',
    'read beach festival', 'red beach festival', 'red sea festival',
    'red sea bridge festival', 'red see int_ bridge festival',
    'red sea int_ festival'],
  'Reykjavik Bridge Festival' => ['reykjavikbridgefestival'],
  'Serdika Bridge Festival' => ['bridge festival - serdika',
    'bridge festival serdika'],
  'Stara Zagora Bridge Festival' => ['bridge festival - stara zagora',
    'bridge festival stara zagora', 
    'bridge festival-bulgaria-stara zagora'],
  'Tallinn Bridge Festival' => ['talinn festival', 'tallin festival',
    'tallinns festival'],
  'Turkish Autumn Festival' => ['sonbahar bridge festival'],
  'Turkish-Greek Friendship Festival' => [
    'greek-turkish friendship festival'],
  'Varna Bridge Festival' => ['international bridge festival varna'],
  'VVE Beheer Bridge Week' => ['vve-beheer bridgeweek',
    'vve-beheer bridge week'],
  'Wachauer Bridge Festival' => ['wachauer bridgefestival'],
  'West Java Regional' => ['west java regional sport games',
    'west java regional games', 'west java regional spots event',
    'regional west java'],
  'Zulawski Congress' => ['mityng zulawski', "kongres \"zulawski\"",
    'kongres zulawski', "mityng \"zulawski\""]
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
  'Gold Coast Congress' => ['gc', 'gcc'],
  'Indonesian National Pre-Sports Week' => ['prapon'],
  'Indonesian National Sports Week' => ['indonesia week', 'pon']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
