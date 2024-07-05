#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Ordinal;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  last
);

my %SINGLE_TYPOS =
(
    1 => [qw(first 1rst 1er primera fir)],
    2 => [qw(second segundo segunda sec)],
    3 => [qw(third tercer)],
    4 => [qw(fourth 4rth)],
    5 => ['fifth'],
    6 => ['sixth'],
    7 => ['seventh'],
    8 => ['eighth'],
    last => [qw(lats ultimo)]
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
