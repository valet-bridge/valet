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
  'Cappelletti Against 1NT',
  'Cappelletti Transfer',
  'Kokish 2NT',
  'Kokish Game Try',
  'Limit Raise',
  'Negative Double',

  '1 diamond=4+cards, 1 club=2+cards',
  '1 sa 15-17',
  '1403 two way chekback unusall gold way michel gerber multylandy',
  '15/17-2nt 20/21- puppet',
  '1nt 15-17 2nt 20-21',
  '1nt 15-17;2nt 21-22',
  '1nt 15-17 2nt 20-22 2cl 23',
  '1nt 15-19',
  '2c precision',
  '2 sa 20-22',
  '2 major opening: 6-10pts, 6+ suit',
  '2 s h d weak. 2cl 23',
  '2b over 1',
  '2d pos,2h neg,2nt h/2c open',
  '2dhs weak',
  '21=two clubs',
  '2weak transferss 0314',
  '4 kc',
  '5m-3m,1nt15-17,2nt20-22',
  'apel direct',
  'bergen, j2nt, jac & tx',
  'bergen,fnt ,capp,0314,o/e',
  'bbo ita 2012 (almost all jump are weak even in n',
  'canadian club',
  'carta impar siempre gusta',
  'checkback,inv.min.2\'s weak',
  'double: light, and tec',
  'doubles=take-out;neg;re-ooen;penalty',
  'in min/drury/trial bid/dopi',
  're di atout',
  'lavinthal discards or std',
  'michaels. gambling',
  'natural bid only',
  'ndabl',
  'neg x transfer',
  'negat x',
  'negx to 4s',
  'no 2nt fit',
  'no profile we\'ll play mine',
  'no wj',
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
  're x',
  're-bid',
  're-x',
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
  'Cappelletti Against 1NT' => [
    'cap./mod',
    'capell etti',
    'capelleti mod',
    'capelletti on nt',
    'cappeletti ove',
    're capp',],
  'Cappelletti Transfer' => [
    'cappelletti tranf',
    'transfr.capp',
    '4trans capp'],
  Josephine => [
    'josephin 5nt'],
  'Kokish Game Try' => [
    'kokish hsgt',
    'kokish trial bids',
    'kokish trials',
    'kokish game tries',
    'kokish rebids'],
  'Limit Raise' => [
    '10-11 limt rais',
    '10/11 limit raise',
    '1x-3x lim',
    '3 over 1 = limit rai',
    '8LTC limit rais',
    'ask re limit raises',
    'cue=limit+',
    'cue>limitraise',
    '(major) limit raise',
    'lim.r',
    'lim/r',
    'lim.raise',
    'lim. raise',
    'lim r',
    'lim rai',
    'lim rais',
    'lim raise',
    'lim raises',
    'lim rs',
    'limit-bids',
    'limit bid',
    'limit bid with 10-12 points & 3 of partners major',
    'limit bids',
    'limit bids 11-15 tp',
    'limit bids majo',
    'limit cue',
    'limit in major',
    'limit jump in declaarer\'s suit (10-12 pts)',
    'limit major raise',
    'limit major raises',
    'limit r',
    'limit race',
    'limit rai',
    'limit raiases',
    'limit rais',
    'limit raise 10-11',
    'limit raise 10-12pts',
    'limit raise in major',
    'limit raise with 3nt',
    'limit raise with ten poin',
    'limit raises',
    'limit raises major',
    'limit raises over major and minor opening',
    'limit raiziz',
    'limit rase',
    'limit reis',
    'limit rise',
    'limit rs',
    'limited raise',
    'limited raised in major',
    'limraise10-11',
    'limt rais',
    'limt raise',
    'limt raises',
    'lmt rais',
    'major limit raises',
    'minor limit rais',
    'no lim raise',
    'qbid limrs',
    'salto limitado',
    'saltos limitados',
    ],
  'Negative Double' => [
    'dbls. neg.4h',
    'doblo neg',
    'doblo negativo',
    'neg 2 sp',
    'neg 3s',
    'neg d',
    'neg db>3h',
    'neg dbl',
    'neg dbl 3sp',
    'neg dbl to 3 sp',
    'neg dbl-4d',
    'neg dbls',
    'neg do 3 pik',
    'neg do 3pik',
    'neg dou',
    'neg doub',
    'neg doub to 3 level',
    'neg doub up 2sp',
    'neg doubles',
    'neg dub',
    'neg dub to 2 sp',
    'neg x',
    'neg x 4d',
    'neg x thru 3sp',
    'neg x to 2s',
    'neg x-3s',
    'neg*',
    'neg,doub',
    'neg-dbl',
    'neg. dbl',
    'neg. dobles',
    'neg. doub. till 4d',
    'neg. x 3s',
    'neg.d',
    'neg.dbls',
    'neg.dobl',
    'neg.x',
    'neg.x 2sp',
    'negX to 4h',
    'negatif x',
    'negativ dbl',
    'negativ double',
    'negativ x',
    'negative dbl',
    'negative doub',
    'negative double',
    'negative double up to 4 h',
    'negative x',
    'negdbl-3s',
    'negt gb',
    'x-neg'],
  Transfer => [
    'all transefs',
    'no transfer', 
    'no transfers'],
);

my @SINGLE_WORDS = qw(
  15-17 15-17nt 15-18 16-18 16-19 19-20 20-21 20-22 21-23
  0314 03142Q 03/14 1430 5542
  11-rule 17nt 1ba 1h 1nt 1nt16 1p 1re 1s
  2/1 2ba 2cl 2clubs 2d 2k 2nt 2p 2s 2sa 2sp 2way 2weak 2ème
  3c 3k 3p 3s 3sa 3ème 4c 4cl 4mi 4sf 4way 4-way
  5c 5cm 5kc 5li 5m 5ma 5maj 5major 5mj 5s 5t 5ème

  above aces accept acol against agreement akol alert amer artificial 
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

  landik landy lead leader leads lim lo loser losers losing low

  major master meilleur meilleure mini minimum minor
  multi multi2d multicolor

  negativ negative ni nmf nobile nt

  odd open opener openig openings opponent opps overcall 
  overcalls

  pair pari parité partenaire partenaires partener partner partners 
  penalty petite pi pique piques pl play player pnts point points 
  polish positive power 
  prec precision preempt preempts précision pts psychis pupet pupp puppet

  quadri queen

  raise raises rckb real reg relay resp response revers reverse revdrury 
  rkc rkcb rkcb1430 rom roman romen

  sa sans short small spades splinter standard standart
  signals singleton sistem splinters splntr stan std strng 
  strong strongest sui suit suits sup supp support supportx syst system 
  systems

  takeout Transfer trèfle tricks trump twos

  udca udca-mud undo undos upside

  vulnerable 

  waiting weak weak2 way
);

my %SINGLE_TYPOS =
(
  artificial => ['art'],
  'Cappelletti Against 1NT' => [
    'cap',
    'capaletti',
    'capality',
    'capalleti',
    'capaltti',
    'caparetti',
    'capel',
    'capeleti',
    'capeletti',
    'capelleti',
    'capil',
    'capiletti',
    'capilleti',
    'capiltetti',
    'capleti',
    'capolet',
    'capoletti',
    'capollrtti',
    'capp',
    'cappaletti',
    'cappeiieti',
    'cappel',
    'cappeleti',
    'cappeletti',
    'cappelitti',
    'cappelleti',
    'cappelletti',
    'cappellitti',
    'cappilatti',
    'cappl',
    'capplety',
    'cappll',
    'cappoletti',
    'capps',
    'cappti'],
  Josephine => [
    'josep',
    'josephin',
    'josephine',
    'josepsin'],
  'Limit Raise' => ['limra', 'limitraise', 'limitraisecue',
    'limitraises', 'limrsq'],
  'Kokish Game Try' => [
    'kokishgametry'],
  minor => ['mi', 'min', 'miner', 'mineure', 'minors'],
  major => ['maior', 'maj', 'majors', 'mj'],
  natural => ['nat', 'naturale', 'naturel'],
  'Negative Double' => [
    'negativex',
    'negdbl',
    'negdble',
    'negx',
    'negx2lev'],
  Transfer => [
    'notransfer',
    'tran', 'tranfer', 'tranfers', 'trans', 'transef', 'transefer',
    'transefs', 'transf', 'transfe', 'transfeer', 'transfers', 
    'transfert', 'transfr', 'transfs', 'trasfer', 'trf', 'trfrs', 
    'trnsf', 'trnsfer', 'trsf', 'xfer', 'xfers'],
  trèfle => ['trefle', 'trefles'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
