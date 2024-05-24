#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamBot;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_bot);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Bridge Baron',
  'Bridge +'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  GIB
  Jack
  Wbridge5
);

my %SINGLE_TYPOS =
(
  Wbridge5 => ['wbridge']
);


sub set_hashes_team_bot
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
