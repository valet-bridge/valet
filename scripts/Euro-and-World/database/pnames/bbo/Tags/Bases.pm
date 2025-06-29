#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Bases;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  '5-card majors',
  'new zealand acol',
  'new zealand precision',
  'standard french',
);

my %MULTI_TYPOS =
(
  '5-card majors' => [
    '1 h/s= 5card',
    '1 h/s - major five',
    '12 13 5card open',
    '12p+ open 5card maj',
    '12 pts 5 cards',
    '12p opening, 5card majer',
    '13/15 5card suits one of suit',
    '13+pts (12 with exceptional case) 5 card major',
    '13points yo open 5cardmajor',
    '13 to open 5cards major',
    '1h-sp 5card',
    '1h/1s 5crd',
    '1h,1s 5card',
    '1hs-13hcp 5crd',
    '1h en 1 sp = 5card',
    '1he, sp- 5card',
    '1s/1h11-15(5carde)',
    '1s,1h 5cards',
    '2std american5card majors',
    '5card m',
    '5card ma opning',
    '5card mag',
    '5card mager',
    '5card magor suits open w 12hpc',
    '5card maio',
    '5card maj',
    '5card major',
    '5card major..opening 11+',
    '5card major a la francaise natural',
    '5card major opening only',
    '5card majors',
    '5card majors 12-16',
    '5card majr',
    '5card man',
    '5card mjr',
    '5card mjrs',
    '5card mayo',
    '5card op',
    '5card open',
    '5cards m',
    '5cards maj',
    '5cards major',
    '5cards meij',
    '5cards op',
    '5crd hoog',
    '5crd mag open',
    '5crd maj',
    '5crd major',
    '5crd major 12+',
    '5crd major with fnt',
    '5crd majors',
    '5crds major',
    '5crd mj',
    '5 c ma',
    '5 c maj',
    '5 c major',
    '5 c mj',
    '5 c openg',
    '5 ca major',
    '5 card Major',
    '5 card m',
    '5 card ma',
    '5 card mager',
    '5 card maj',
    '5 card major',
    '5 card major 12h',
    '5 card major opening',
    '5 card major to open',
    '5 card majors',
    '5 card majs',
    '5 card mayo',
    '5 card mayor',
    '5 cards',
    '5 cards 12 pc',
    '5 cards mag',
    '5 cards maj',
    '5 cards major',
    '5 cards majors',
    '5 cards open in major',
    '5 cards opening',
    '5 carts mar',
    '5 cd maj',
    '5 cd maj opener',
    '5 cd majors',
    '5 cds majors',
    '5 cm',
    '5 cr major',
    '5 crd high',
    '5 crd m 13+',
    '5 crd major',
    '5 crd mjrs',
    '5 crd open',
    '5 li',
    '5 maj',
    'always open 5 carts',
    'five c major',
    'five card major',
    'five card major open',
    'five card major to open',
    'five card majors',
    'five h & S',
    'five hart an sp',
    'five majo',
    'five major',
    'five majors',
    'h/s5cards',
    'in op.5 card maj',
    'm 5',
    'm major five',
    'maj 5',
    'maj 5e',
    'maj. 5ème',
    'major 5card',
    'major 5cards 13-19pc',
    'major 5cards start with (10:12)',
    'majors 5card open',
    'mayor 5',
    'naturel 5 card',
    'op12-21 5card in mayer and spades first',
    'open 5 card majors',
    'open 11 pnts. 5card mjrs',
    'open 12-15.5card mayer',
    'open 12 PC 5 cards in suit',
    'open 12 points-5card majors',
    '0pen 5card.mayor',
    'open 5card majors',
    'open w/5card major and 11-15 pts',
    'open with 5cards',
    'standart 5 mj'],
  'new zealand acol' => ['acol in nz', 'nz acol'],
  'new zealand precision' => ['nz precision' ],
  'standard french' => [
    'french 5 cart major',
    'french standard',
    'french std',
    'le sef',
    'le sef+',
    'le sef classiqjue',
    'nouveau sef',
    's e f',
    'seffff',
    'sefmeil mineure',
    'sef 2006',
    'sef au complet',
    'sef basic',
    'sef francais',
    'simple sef',
    'un peu sef'],
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  '5-card majors' => [
    '5cardm', 
    '5cardmaj', 
    '5cardmajor', 
    '5crd',
    'maj5card',
    'mjrsfive'],
  'standard french' => ['sef', 'sef12'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
