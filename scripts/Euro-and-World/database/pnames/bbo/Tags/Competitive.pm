#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Competitive;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Cappelletti Transfer',
  'Kokish 2NT',
  'Takeout Double',
  'Unusual 2NT',
);

my %MULTI_TYPOS =
(
  'Cappelletti Transfer' => [
    'cappelletti tranf',
    'transfr.capp',
    '4trans capp'],
  'Takeout Double' => [
    'bid on infox',
    'contro informativo',
    'dbl for takeout',
    'doblo informativ',
    'doblo informativo',
    'doblo informotivo',
    'dobre informativo',
    'double for takeout',
    'info dblt',
    'info double',
    'info-x maj',
    'inform dbl',
    'le x informatif',
    'many take-out doubles',
    'no takeout double',
    'tak out doub',
    'tak x',
    'tak/out',
    'take out',
    'take out dbl',
    'take out dbles',
    'take out doub',
    'take out doubles',
    'take out dub',
    'take out x',
    'take-aut dbl',
    'take-out double',
    'takeout dbl',
    'takeout dbles',
    'takeout dbls',
    'takeout doub',
    'takeout double',
    'takeout doubles',
    'takeout x',
    'x for take out',
    'x is for take out'],
  'Unusual 2NT' => [
    'un 2nt',
    'un nt',
    'un nt\'s',
    'un usual nt',
    'un. nt',
    'un.2nt=5-5',
    'un.nt',
    'uns 2nt',
    'uns nt',
    'uns.2nt',
    'unsual nt',
    'unu nt',
    'unu.2nt',
    'unu.nt',
    'unu2nt',
    'ununt',
    'unus 2nt',
    'unus nt',
    'unus. nt',
    'unus.nt',
    'unusal 2nt',
    'unusal nt',
    'unusl 2nt',
    'unusl nt',
    'unusual 2 nt',
    'unusual 2n',
    'unusual 2nt',
    'unusual no trump',
    'unusual notrump',
    'unusual nt',
    'unusual-nt',
    'unusual2 nt',
    'unusuall nt',
    'unusula 2 st',
    'unusull 2nt',
    'usual 2nt'],
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'Takeout Double' => [
    'infox',
    'takeout',
    'takeoutdoubles',
    'takeouts',
    'takout'],
  'Unusual 2NT' => [
    'un2nt',
    'unnt',
    'uns2nt',
    'unsnt',
    'unt',
    'unus2nt',
    'unusal2nt',
    'unusl2nt',
    'unusnt',
    'unusual2nt',
    'unusualnt'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
