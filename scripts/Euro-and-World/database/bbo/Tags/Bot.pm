#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Bot;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

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


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
