#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Lengths;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  cards
);

my %SINGLE_TYPOS =
(
  'cards' => [
    'c`ard',
    'caard',
    'cad',
    'cadd',
    'cadr',
    'cads',
    'caed',
    'caeds',
    'card',
    'carde',
    'carded',
    'carder',
    'carders',
    'cardr',
    'cards\'',
    'cardsuit',
    'cardsuites',
    'cared',
    'cars',
    'carsa',
    'carsd',
    'cart',
    'carta',
    'cartas',
    'carte',
    'cartes',
    'carts',
    'cd',
    'cdr',
    'cds',
    'crad',
    'crd',
    'crd\'s',
    'crder',
    'crds',
    'crt',
    'crts',
    'kaard',
    'kaart',
    'kaarten',
    'kard',
    'kards',
    'kart',
    'karten',
    'kartlý',
    'karts',
    'kartu',
    'kort',
    'kortin',
    'korts',
    'krd',
    'krt',
    'krts',
    'kt',
    'leng',
    'length'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
