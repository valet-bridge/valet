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
  'Benjamin ACOL',
  'Blue Club',
  'Better Minor',
  'Convenient Minor',
  'German Forum D',
  'Magic Diamond',
  'Polish ACOL',
  'Polish Club',
  'Power ACOL',
  'Power Precision',
  'Standard American',
  'Standard Italian',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  ACOL
  Precision
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
    'akool',
    'basicacol',
    'basicacolreally',
    'stdacol'],
  'Benjamin ACOL' => [
    'benjiacol'],
  'Better Minor' => [
    'bestmin',
    'bestminor',
    'betmin',
    'betterm',
    'betterminor',
    'bettmin',
    'bettrminor'],
  'Blue Club' => [
    'bluec',
    'blueclub'],
  'Convenient Minor' => [
    'convm',
    'convenientminor',
    'convminors'],
  'German Forum D' => [
    'forumd',
    'forumdplus'],
  'Magic Diamond' => [
    'magicdiamond'],
  'Polish ACOL' => [
    'polishacolholic'],
  'Polish Club' => [
    'polcl',
    'polclub',
    'polishclub',
    'polihsclub'],
  'Power ACOL' => [
    'poweracol'],
  'Power Precision' => [
    'powprec'],
  Precision => [
    'alsoprecision',
    'orprec',
    'orprecision',
    'preccl',
    'precclub',
    'precesionecl',
    'precisionclub'],
  SAYC => [
    'basicsayc',
    'fullsayc',
    'naturalsayc',
    'orsayc',
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
    'standardamericansayc',
    'stsayc',
    'syac'],
  'SEF' => [
    'seff',
    'seffrancophone',
    'sefstandard'],
  'Standard American' => [
    'americanstandard',
    'basicsa',
    'orsa',
    'stanam',
    'stanamer',
    'standam',
    'standarda',
    'standardam',
    'standardamerican',
    'standartamercinan',
    'stdam',
    'stdameican',
    'stdamer',
    'stdamerbdg',
    'stdamerican'],
  'Standard Italian' => [
    'standardbboitalia',
    'standarditalia'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;




