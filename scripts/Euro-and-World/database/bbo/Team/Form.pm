#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Form;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_form);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Pairs => ["pair's"]
);

my @SINGLE_WORDS = qw(
  Individual
  Pairs
  Teams
);

my %SINGLE_TYPOS =
(
  Individual => ['indyvidual', 'individuals', 'indiv'],
  Teams => [qw(team teamów teamow teamc teamevent
    teamy équipes equipas equipos ecgipe lag)],
  Pairs => [qw(pair par paires)]
);


sub set_hashes_team_form
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
