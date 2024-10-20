#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Form;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Pairs => ["pair's", 'de parejas', 'pairs royale'],
  Teams => ['de equipos', 'dörtlü takýmlar', "team's"]
);

my @SINGLE_WORDS = qw(
  Individual
  Pairs
  Teams
);

my %SINGLE_TYPOS =
(
  Individual => ['individuals', 'indivual', 'indiv', 'ind'],
  Teams => [qw(team teamów teamow teamc teamevent takim tim
    teamy équipes equipas equipos equipo lag
    takimlar squadre kadra dörtlü tm teamd terms)],
  Pairs => [qw(pair par paires parejas paýrs psirs)]
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
