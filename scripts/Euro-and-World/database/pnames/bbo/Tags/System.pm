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
  '2c strong',
  'even-odd',
  'limit raise',
  'new zealand acol',
  'new zealand precision',
  'standard french',

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
  'carta impar siempre gusta',
  'checkback,inv.min.2\'s weak',
  'double: light, and tec',
  'doubles=take-out;neg;re-ooen;penalty',
  'in min/drury/trial bid/dopi',
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
  '2c strong' => [
    '2c-22+',
    '2c +22',
    '2c +23',
    '2c 19-23 irregular',
    '2c 20',
    '2c 20+',
    '2c 20+pts',
    '2c 22',
    '2c 22+',
    '2c 22+hcp',
    '2c 22+p',
    '2c 22+pts',
    '2c 23',
    '2c 23-24',
    '2c 23+',
    '2c 23+ or 8 tricks',
    '2c 23 pts',
    '2c 9winner',
    '2c asking for aces',
    '2c crodo',
    '2c f',
    '2c forte',
    '2c game force',
    '2c is 22 po',
    '2c max 3loser unbal otherw',
    '2c max forcing',
    '2c s',
    '2c st',
    '2c str',
    '2c str wai',
    '2c stro',
    '2c strng',
    '2c strong',
    '2c strong(22+)',
    '2c strong(22-23pts',
    '2c strong=+23',
    '2c strong 22+',
    '2c strong 18+ 3 losers or 22+',
    '2c strong (23+ points or 3 loosers)',
    '2c strong undeter',
    '2cl art strng',
    '2cl 22+',
    '2cl 22+points',
    '2cl 22+pts',
    '2cl 22+r',
    '2cl 22+transfer to major',
    '2cl 22+ 2d waiting or 5c major',
    '2cl 22+ strong',
    '2cl-strong',
    '2club22+',
    '2club 19 - 21',
    '2club str',
    '2club strong',
    '2club strong 20-21',
    '2clubs=22+',
    '2club 20+',
    '2clubs 19',
    '2clubs 21+= strong',
    '2clubs 22+',
    '2clubs 23plus',
    '2clubs strong',
    'but 2c strong',
    'exc 2clubs straight blackw',
    'st 2c',
    'strong 2c (22+)',
    'strong 2c + 22',
    'strong 2c over 22p',
    'strong 2cl 22+',
    'strong 2club'],
  'even-odd' => [
    'compte en pair-impair',
    'def en pair impair',
    'defausse pair/impair',
    'défausse pair/impair',
    'déf pair/impair',
    'entame p/impair',
    'entame pairimpair',
    'entame pair impair',
    'even/odd',
    'e/u',
    'p/impair par tout',
    'p/impair coul/sa',
    'pair-impair',
    'pair-impair à l\'entame',
    'pair/ impair',
    'pair/impair',
    'pair/impair en def',
    'pair/impair en déf',
    'pair/impair partout',
    'pair/impair strict',
    'pair/impairet',
    'pair / impair',
    'pair /impair',
    'pair imp',
    'pair impair',
    'Pair impair ã la couleur',
    'pair impair coul',
    'pair impair coul/sa',
    'pair impaire',
    'pair impair en defausse',
    'pair impair en toute circonstance',
    'pair impair si utile',
    'pair impair strict',
    'paire impaire',
    'par impair',
    'sign pair-impair',
    'tout en pair impair',
    'tout pair-impair'],
  'high-low' => [
    'discards high /encour',
    'encourige with high',
    'enc-high',
    'h/l eve',
    'high- low',
    'high-l',
    'high-low',
    'high-low=equ',
    'high-low = even number',
    'high-low=even',
    'high-low=even card',
    'high-low =eve',
    'high-low encourage or even card',
    'high-low for 2-4 card',
    'high+',
    'high.lo',
    'high.enc',
    'high/lo',
    'high/law',
    'high/low',
    'high/low =even',
    'high/low discards',
    'high/low= even',
    'high/low=even',
    'high/low=even card',
    'high/low = even or go on',
    'high/low discards',
    'high/low even',
    'high=encourage',
    'high: enccourage',
    'high -low',
    'high = encourage',
    'high / low',
    'high card en',
    'high card enc',
    'high card encourage',
    'high card i like it',
    'high card positiv',
    'high cards positive',
    'high discard en',
    'high e',
    'high en',
    'high enc',
    'high encour',
    'high encourage',
    'high encourang',
    'high enq',
    'high low',
    'high low discards',
    'high low even',
    'high low for enc/even',
    'high interest',
    'high interested',
    'high is on, low is off',
    'high po',
    'high pos',
    'high to encourage',
    'hight-en',
    'hight/low-doubl',
    'hight/low doubl',
    'hight cal',
    'lead high low',
    'low/high odd',
    'low-high when odd',
    'low not interested',
    'marks high/low',
    'sign high-low',
    'signal >high encouraging',
    'signalling is high- low for attit./quant',
    'std carding high'],
  'limit raise' => [
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
    'lim.raise',
    'lim r',
    'lim rai',
    'lim raise',
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
  'new zealand acol' => ['acol in nz', 'nz acol'],
  'new zealand precision' => ['nz precision' ],
  'standard french' => [
    'french std',
    'le sef',
    'le sef+',
    'le sef classiqjue',
    'nouveau sef',
    'seffff',
    'sefmeil mineure',
    'sef 2006',
    'sef au complet',
    'sef basic',
    'sef francais',
    'simple sef',
    'un peu sef',
    ],
  transfer => [
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
  5c 5cm 5crd 5kc 5li 5m 5ma 5maj 5major 5mj 5s 5t 5ème

  above aces accept acol against agreement akol alert amer artificial 
  asking atout attitude

  bal balance better bicolor bid bidding bids blackwood blw
  boards

  card carding cards checkback cl clubs conservative 
  constructive convention conventions couleur counting cuebids 
  cue cuebid

  dbl deb defausse defence defense demand demande di diamond diamonds 
  discard dispari double doubles doubleton drury dummy duplicate

  enc encourage encouraging entame excl exclusion expert

  faible fnt force forceing forcing fort forte free fsf fuerte

  gadgets gamble gambling gerber game gf

  hand hands hcp hearts high hoch hon honor

  impair imparare interference inverted invitation invite 

  jump

  key keycard kl klaver kravpass

  landy lead leader leads lim lo loser losers losing low

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

  sa sans sayac sayc short small smolen spades splinter standard standart
  signals singleton sistem splinters splntr stan stayman std strng 
  strong strongest sui suit suits sup supp support supportx syst system 
  systems

  takeout transfer trèfle tricks trump twos

  udca udca-mud undo undos upside

  vulnerable 

  waiting weak weak2 way
);

my %SINGLE_TYPOS =
(
  artificial => ['art'],
  '2c strong' => ['strog2club'],
  'even-odd' => ['pairimpair'],
  'high-low' => ['highenc'],
  'limit raise' => ['limra', 'limitraise', 'limitraisecue',
    'limitraises', 'limrsq'],
  minor => ['mi', 'min', 'miner', 'mineure', 'minors'],
  major => ['maior', 'maj', 'majors', 'mj'],
  natural => ['nat', 'naturale', 'naturel'],
  'standard french' => ['sef', 'sef12'],
  transfer => [
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
