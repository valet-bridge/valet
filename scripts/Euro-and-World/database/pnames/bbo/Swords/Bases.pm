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
  'Bluejay Club',
  'Better Minor',
  'Convenient Minor',
  'Five Card Major',
  'German Forum D',
  'Magic Diamond',
  'Nordic Standard',
  'Polish ACOL',
  'Polish Club',
  'Power ACOL',
  'Power Precision',
  'Standard American',
  'Standard Italian',
  'Two Over One',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  ACOL
  Precision
  SAYC
  SEF
  WJ05
  WJXXI
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
    'bestmi',
    'bestmin',
    'bestminor',
    'betmin',
    'betmn',
    'betminor',
    'betterm',
    'betterminor',
    'bettermnr',
    'bettmin',
    'bettrm',
    'bettrminor',
    'btermn',
    'bstmin',
    'btrmin',
    'meilleurmin',
    'meilmin',
    'meimin',
    'openningbestminor'],
  'Blue Club' => [
    'bluec',
    'blueclub'],
  'Bluejay Club' => [
    'bluejayclub'],
  'Convenient Minor' => [
    'conmi',
    'conminor',
    'convm',
    'convminor',
    'convmn',
    'convenientd',
    'convenientminor',
    'convminors'],
  'Five Card Major' => [
    'fivecardmayor',
    'nobv'],
  'German Forum D' => [
    'bietsystemforum',
    'forumd',
    'forumdplus'],
  'Magic Diamond' => [
    'magicdiamond'],
  'Nordic Standard' => [
    'modifiednordicstandard'],
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
    'fioriforte',
    'orprec',
    'orprecision',
    'preccl',
    'precclub',
    'precesionecl',
    'precisionclub'],
  SAYC => [
    'americansyac',
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
    'saycstand',
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
  WJXXI => [
    'wjxxiw'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;




