#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Bases;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  ACOL
  SAYC
  SEF
);

my %SINGLE_TYPOS =
(
  ACOL => [
    'accol',
    'accole',
    'accoll',
    'acoal',
    'acoil',
    'acolish',
    'acoll',
    'acolsys',
    'acolsysteem',
    'acolsystem',
    'acool',
    'akol',
    'akoll',
    'akool'],
  SAYC => [
    'sacy',
    'saic',
    'saya',
    'sayac',
    'sayak',
    'saycb',
    'saycbasi',
    'saycbasic',
    'saycc',
    'saycclasic',
    'saycd',
    'saycful',
    'saycfull',
    'saych',
    'saycish',
    'saycl',
    'saycnormal',
    'sayco',
    'saycs',
    'saycsayc',
    'saycsimple',
    'saycwk',
    'saycyellow',
    'sayd',
    'sayec',
    'syac'],
  'SEF' => [
    'seff',
    'seffrancophone',
    'sefstandard'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;




