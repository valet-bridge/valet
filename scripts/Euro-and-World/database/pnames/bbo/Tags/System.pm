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
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  15-17 15-18 16-18 16-19 19-20 20-21 20-22 21-23
  0314 1430 5542
  17nt 1h 1n 1nt 1nt16 1p 1s 1t
  2cl 2clubs 2d 2k 2n 2nt 2p 2s 2sa 2sp 2weak 2ème
  3c 3k 3p 3s 3sa 3ème 4c 4cl 4sf 4way 
  5c 5cm 5crd 5m 5maj 5major 5mj 5s 5t 5ème

  aces accept acol against agreement akol alert kartificial asking
  atout attitude

  balance beginner better bicolor bid bidding bids blackwood blw
  boards

  capaletti capp card carding cards checkback clubs conservative 
  constructive convention conventions couleur counting cuebids 
  cue cuebid

  dbl defausse defence defense demand demande diamonds discard 
  double doubles doubleton drury dummy duplicate

  enc encourage encouraging exclusion expert

  faible fnt forcing free fsf fuerte

  gadgets gamble gambling gerber game gf

  hand hands hcp hearts high honor

  impair imparare interference inverted invitation invite 

  jac jacoby

  keycard kravpass

  landy lead leb lebensohl loser losers losing low

  major majors master minimum minor muiderberg multi multi2d 
  multicolor

  natural naturale naturel 
  negative nmf

  ogust open opener openig openings opponent opps overcall 
  overcalls

  pair parité partenaire partenaires partener partner partners 
  play player points prec precision preempt preempts précision 
  pts puppet

  raise raises relay resp response revers reverse revdrury rkc rkcb
  rusinow sayc short small smolen spades splinter standard standart

  sef signals singleton sistem splinters splntr stayman std strng 
  strong strongest suit suits supp support syst system systems

  takeout tranfer tranfers trans transf transfe transfer transfers 
  transfert transfr transfs trasfer trefle trèfle trefles trf trfrs 
  tricks trnsf trnsfer trsf trump twos

  udca undo undos upside

  vulnerable waiting weak weak2 

  xfer xfers
);

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
