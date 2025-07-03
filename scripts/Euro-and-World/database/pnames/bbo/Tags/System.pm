#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::System;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'apel direct',
  'ndabl',
  'neg x transfer',
  'negat x',
  'negx to 4s',
  'no 2nt fit',
  'no wj',
  'o/e',
  'o/e dis crds',
  'o/e discard',
  'precision/wei-sender',
  're x',
  're-bid',
  're-x',
  'standard canadian',
  'std can',
  'std carding',
  'std discards',
  'std.crd-mud',
  'supp-x',
  'weak 2',
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  15-17 15-17nt 15-18 16-18 16-19 19-20 20-21 20-22 21-23
  0314 03142Q 03/14 1430 5542
  11-rule 17nt 1ba 1h 1nt 1nt16 1p 1re 1s
  2/1 2ba 2cl 2clubs 2d 2k 2nt 2p 2s 2sa 2sp 2way 2weak 2ème
  3c 3k 3p 3s 3sa 3ème 4c 4cl 4mi 4sf 4way 4-way
  5c 5kc 5li 5m 5ma 5mj 5s 5t 5ème

  above aces accept against agreement akol alert amer artificial 
  asking atout attitude

  bal balance better bicolor bid bidding bids bil blackwood blw
  boards

  card carding cards checkback cl clubs conservative 
  constructive convention conventions couleur counting cuebids 
  cue cuebid

  dbl deb defausse defence defense demand demande di diamond diamonds 
  discard dispari double doubles doubleton dummy duplicate

  enc encourage encouraging english entame excl exclusion expert

  faible fnt force forceing forcing fort forte free fsf fuerte

  gadgets gamble gambling game gf

  hand hands hcp hearts high hoch hon honor

  impair imparare interference inverted invitation invite 

  josephine jump

  key keycard kl klaver kravpass

  landy lead leader leads lim lo loser losers losing low

  major master meilleur meilleure mini minimum minor
  multi multi2d multicolor

  negativ negative ni nobile nt

  odd open opener openig openings opponent opps overcall 
  overcalls

  pair pari parité partenaire partenaires partener partner partners 
  penalty petite pi pique piques pl play player pnts point points 
  polish positive power 
  prec precision preempt preempts précision pts psychis 

  quadri queen

  raise raises rckb real reg relay resp response revers reverse revdrury 
  rkc rkcb rkcb1430 rom roman romen

  sa sans short small spades splinter standard standart
  signals singleton sistem splinters splntr stan std strng 
  strong strongest sui suit suits sup supp support supportx syst system 
  systems

  takeout trèfle tricks trump twos

  undo undos upside

  vulnerable 

  waiting weak weak2 way
);

my %SINGLE_TYPOS =
(
  artificial => ['art'],
  minor => ['mi', 'min', 'miner', 'mineure', 'minors'],
  major => ['maior', 'maj', 'majors', 'mj'],
  natural => ['nat', 'naturale', 'naturel'],
  trèfle => ['trefle', 'trefles'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
