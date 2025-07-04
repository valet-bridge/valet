#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::DenominationsITA;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  clubs
  diamonds
  hearts
  spades
  notrump
);

my %SINGLE_TYPOS =
(
  clubs => [
    'fio',
    'fior',
    'fiore',
    'fiori'],
  diamonds => [
    'quaadri',
    'quad',
    'quadi',
    'quadr',
    'quadri',
    'quadrii',
    'quadry'],
  hearts => [
    'cuor',
    'cuore',
    'cuori'],
  spades => [
    'picce',
    'picch',
    'picche',
    'piccche'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
