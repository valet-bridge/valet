#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::RanksGER;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  minor
  major
);

my %SINGLE_TYPOS =
(
  minor => [
    'uf',
    'ufen',
    'unterfarbe',
    'unterfarben'],
  major => [
    'of',
    'ofen',
    'oberfarbe',
    'oberfarben'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
