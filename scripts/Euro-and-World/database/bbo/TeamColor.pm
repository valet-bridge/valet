#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamColor;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_color);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Blue
  Green
  Orange
  Red
  White
  Yellow
);

my %SINGLE_TYPOS =
(
  Blue => ['blauw', 'biru'],
  Green => ['verde'],
  Red => ['rouge', 'rød', 'rood'],
  White => ['putih', 'hvid'],
  Yellow => ['kuning']
);


sub set_hashes_team_color
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
