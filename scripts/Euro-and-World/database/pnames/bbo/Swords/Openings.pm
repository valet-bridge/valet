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
  '2D Multi',
  'Gambling 3NT',
  'Short Club',
  'Strong NT',
  'Three Level Preempts',
  'Variable NT',
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
  'Gambling 3NT' => [
    'gamblingnt',
    'gamblnt',
    'gambnt',
    'gmbnt',
    'gmlgnt',
    'ntgam',
    'ntgamb',
    'ntgambl',
    'ntgambling',
    'ntgb',
    'solidmin'],
  'Strong NT' => [
    'strngnt',
    'strongnt'],
  'Three Level Preempts' => [
    'threest'],
  'Variable NT' => [
    'variablent',
    'varnt'],
  'Weak NT' => [
    'weaknt',
    'weaksa',
    'wejba',
    'wknt'],
  'Weak Two' => [
    'weakbids',
    'weaktwo',
    'weaktwos',
    'weattwo'],
  'Weak Two DHS' => [
    'dhsw',
    'dhswe',
    'dhsweak',
    'dhswk',
    'hdsw',
    'hdsweak',
    'shdw',
    'weakdhs',
    'weakdsh',
    'weakshd',
    'wkdhs'],
  'Weak Two Major' => [
    'hsm',
    'hsweak',
    'hsweaks',
    'weacsh',
    'weakhors',
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
