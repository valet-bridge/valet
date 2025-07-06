#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::Openings;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Weak NT',
  'Weak Two',
  'Weak Two DHS',
  'Weak Two Major',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Weak NT' => [
    'wknt',
    'wknt'],
  'Weak Two' => [
    'weakbids',
    'weaktwo',
    'weaktwos',
    'weattwo'],
  'Weak Two DHS' => [
    'weakdhs',
    'weakdsh',
    'weakshd',
    'wkdhs'],
  'Weak Two Major' => [
    'weacsh',
    'weakhs',
    'weakm',
    'weakmjr',
    'weaksh',
    'weekm',
    'wkhs',
    'wkm',
    'weakmaj',
    'weakmajor',
    'weakms'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
