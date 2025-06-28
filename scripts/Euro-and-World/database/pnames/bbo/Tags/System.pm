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
  '1 diamond=4+cards, 1 club=2+cards',
  '1 sa 15-17',
  '1403 two way chekback unusall gold way michel gerber multylandy',
  '15/17-2nt 20/21- puppet',
  '1nt 15-17 2nt 20-21',
  '1nt 15-17;2nt 21-22',
  '1nt 15-17 2nt 20-22 2cl 23',
  '1nt 15-19',
  '2 sa 20-22',
  '2 major opening: 6-10pts, 6+ suit',
  '2 s h d weak. 2cl 23',
  '2/1 or sayc',
  '2/1 sayc',
  '2b over 1',
  '2d pos,2h neg,2nt h/2c open',
  '2dhs weak',
  '21=two clubs',
  '2weak transferss 0314',
  '4 kc',
  '5 card ma',
  '5 card major',
  '5 li',
  '5m-3m,1nt15-17,2nt20-22',
  '5 maj',
  'apel direct',
  'bergen, j2nt, jac & tx',
  'bergen,fnt ,capp,0314,o/e',
  'bbo ita 2012 (almost all jump are weak even in n',
  'canadian club',
  'cappelletti',
  'carta impar siempre gusta',
  'checkback,inv.min.2\'s weak',
  'double: light, and tec',
  'doubles=take-out;neg;re-ooen;penalty',
  'in min/drury/trial bid/dopi',
  'jacobytransfer',
  'kc.0314',
  'kc 031422q',
  'kc 30 14 2',
  'kc 3014',
  'kc 1403',
  'kc 1430',
  'kc 14-30',
  'kc 41/30',
  'lavinthal discards or std',
  'lim rais',
  'lim raise',
  'lim.raise',
  'lim. raise',
  'lim raises',
  'lim rs',
  'lim.r',
  'lim/r',
  'michaels unusual nt',
  'michaels. gambling',
  'natural bid only',
  'ndabl',
  'neg x transfer',
  'negat x',
  'negx to 4s',
  'no 2nt fit',
  'no profile we\'ll play mine',
  'no transfer',
  'no transfers',
  'no wj',
  'nz acol',
  'nz precision',
  'o/e',
  'o/e dis crds',
  'o/e discard',
  'odd/even discards upside down attitude',
  'open 12pts or long suit',
  'open 12, fc1nt,1nt15-17,2nt 20-21, 2c 22+,jcby 2nt, weak 2dhs, staym, transf, blackw 03',
  'opening at 3/4 place mb unformal',
  'or standard with 4cards D',
  'precision/wei-sender',
  'prefer 2/1',
  'pupet,1430.,smolen',
  'r kc',
  're di atout',
  're x',
  're-bid',
  're-x',
  'rkcb 14/03/2/2+q',
  'roman kc',
  'roman kc bw',
  'slm 2 wy rev drury',
  'stam.4way trns,dop1',
  'standard canadian',
  'standard card/disc, lead 2/4',
  'stayman, Gerber, Blackwood, transfer',
  'std & udca`·.¸.·´ o\'e',
  'std `·.¸.·´  o\'e',
  'std can',
  'std carding',
  'std discards',
  'std.crd-mud',
  'supp-x',
  'takeout doubles,unsual nt,michaels',
  'transfer. staymen. 1nt 15-17',
  'weak 2',
  'weak 2 spades or hearts',
  'weak 2\'s , negative doubles',
  'with transfer (2S for minors) without profile',
  'weak jumps',
  'wjs, 4W tr, n1tforc,smolen,un2nt capp',
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
  5c 5cm 5crd 5kc 5li 5m 5ma 5maj 5major 5mj 5s 5t 5ème

  aces accept acol against agreement akol alert amer artificial asking
  atout attitude

  bal balance beginner better bicolor bid bidding bids blackwood blw
  boards

  capaletti capp card carding cards checkback cl clubs conservative 
  constructive convention conventions couleur counting cuebids 
  cue cuebid

  dbl deb defausse defence defense demand demande di diamond diamonds 
  discard dispari double doubles doubleton drury dummy duplicate

  enc encourage encouraging exclusion expert

  faible fnt forcing fort forte free fsf fuerte

  gadgets gamble gambling gerber game gf

  hand hands hcp hearts high honor

  impair imparare interference inverted invitation invite 

  jac jacoby

  key keycard kl klaver kravpass

  landy lead lim lo loser losers losing low

  maior maj major majors master mi miner mini minimum minor mj 
  muiderberg multi multi2d multicolor

  nat natural naturale naturel negative ni nmf nobile nt

  odd ogust open opener openig openings opponent opps overcall 
  overcalls

  pair pari parité partenaire partenaires partener partner partners 
  pi pl play player points polish power prec precision preempt preempts 
  précision pts puppet

  raise raises rckb real reg relay resp response revers reverse revdrury 
  rkc rkcb rkcb1430 rom roman romen

  sa sans sayac sayc short small smolen spades splinter standard standart
  sef signals singleton sistem splinters splntr stan stayman std strng 
  strong strongest sui suit suits sup supp support supportx syst system 
  systems

  takeout tran tranfer tranfers trans transf transfe transfer transfers 
  transfert transfr transfs trasfer trefle trèfle trefles trf trfrs 
  tricks trnsf trnsfer trsf trump twos

  udca udca-mud undo undos upside

  vulnerable 

  waiting weak weak2 way

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
