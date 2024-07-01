#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Color;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

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
  Purple
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
  Yellow => ['kuning', 'beyaz']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
