#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Strengths;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  weak
  strong
);

my %SINGLE_TYPOS =
(
  weak => [
    'wk'],
  strong => [
    'str',
    'strg',
    'strn',
    'strn',
    'strng',
    'strng',
    'strng',
    'strngst',
    'stro',
    'stro',
    'stroang',
    'strobg',
    'strog',
    'strog',
    'strogn',
    'strohg',
    'stroing',
    'stromg',
    'stromg',
    'stromng',
    'stron',
    'stron',
    'strond',
    'stronf',
    'stronfg',
    'stronge',
    'stronge',
    'stronge',
    'strongg',
    'strongv'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
