#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Form;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_form set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Pairs => ["pair's", 'de parejas', 'pairs royale'],
  Teams => ['de equipos', 'dörtlü takýmlar']
);

my @SINGLE_WORDS = qw(
  Individual
  Pairs
  Swiss
  Teams
);

my %SINGLE_TYPOS =
(
  Individual => ['indyvidual', 'individuals', 'indiv', 'ind'],
  Teams => [qw(team teamów teamow teamc teamevent
    teamy équipes equipas equipos equipo equips echipe ecgipe lag
    takimlar squadre kadra dörtlü)],
  Pairs => [qw(pair par paires parejas)]
);


sub set_hashes_team_form
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
