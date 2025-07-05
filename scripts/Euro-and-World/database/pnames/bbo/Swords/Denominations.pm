#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Denominations;

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
    '!c',
    'club',
    'fio',
    'fior',
    'fiore',
    'fiori',
    'treb',
    'trebol',
    'treboles',
    'tref',
    'treff',
    'trefl',
    'trefle',
    'trefles',
    'trèfle',
    'trèfles'],
  diamonds => [
    '!d',
    'carreau',
    'diamond',
    'karo',
    'quaadri',
    'quad',
    'quadi',
    'quadr',
    'quadri',
    'quadrii',
    'quadry'],
  hearts => [
    '!h',
    'coeur',
    'cuor',
    'cuore',
    'cuori',
    'heart'],
  spades => [
    '!s',
    'spade',
    'picce',
    'picch',
    'picche',
    'piccche',
    'pik',
    'pique'],
  notrump => [
    '!nt',
    'ba',
    'notramp',
    'nottramp',
    'ntrump',
    'nt',
    'ntbal',
    'sa',
    'sansatu',
    'sanzato',
    'sanzatu',
    'sintriunfo',
    'st',
    'ut'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
