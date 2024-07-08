#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Nationality;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'South African'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Belarusian Belgian Bolivian Brazilian Bulgarian
  Argentinian Australian Austrian
  Canadian Chilean Croatian Czech
  Dutch
  Egyptian English Estonian
  Faroese Finnish French
  German Greek
  Hungarian
  Icelandic Indian Indonesian Irish Israeli Italian
  Japanese
  Latvian Lebanese Lithuanian
  Norwegian 
  Polish Portuguese
  Romanian
  Scottish Serbian Spanish Swedish 
  Taiwanese Turkish Tunisian
  Welsh
);

my %SINGLE_TYPOS =
(
  Argentinian => ['argentino'],
  Australian => ['aussie', 'austalian', 'austarlian', 'australain'],
  Belgian => ['begian'],
  Bolivian => ['bolivariano', 'bolivarian'],
  Brazilian => ['brasilian'],
  Bulgarian => ['blugarian', 'bugarian'],
  Canadian => ['candian', 'caniadian', 'cdn'],
  English => ['engish', 'enlish', 'englush'],
  French => ['francaise', 'française'],
  German => ['deutsch', 'deutsche'],
  Greek => ['hellenic', 'helenic'],
  Hungarian => ['hungar'],
  Icelandic => ['icelandoc'],
  Indonesian => ['indoneian', 'indonseian'],
  Israeli => ['israli'],
  Italian => ['italiano'],
  Japanese => ['jaqpanese', 'jaoanese'],
  Lithuanian => ['lithianin'],
  Norwegian => ['norvegian', 'norwegain', 'norwgian',
    'norwigian', 'norewegian'],
  Polish => ['poish', 'polski'],
  Swedish => ['swdish', 'swedis', 'swesish'],
  Turkish => ['turkis', 'turkýsh'],
  Tunisian => ['tunisie']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
