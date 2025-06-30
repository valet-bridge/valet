#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Constructive;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Kokish Game Try',
  'Limit Raise',
  'Negative Double',
  'Weak Jump Shift',
);

my %MULTI_TYPOS =
(
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
  Splinter => [
    'no splint',
    'splinter bids',
    'splinter jump'],
  'Weak Jump Shift' => [
    'all jump shifts weak',
    'weak jump shift',
    'weak jump shift overcalls',
    'weak jump shifts',
    'weak jump shifts always',
    'weak jumpshifts',
    'weal jump shift',
    'wk jump shift',
    'wk jump shifts',
    'wkjumpshift2-6pts'],
);

my @SINGLE_WORDS = qw(
  Josephine
  Namyats
  Splinter
);

my %SINGLE_TYPOS =
(
  Josephine => [
    'josep',
    'josephin',
    'josephine',
    'josepsin'],
  'Limit Raise' => ['limra', 'limitraise', 'limitraisecue',
    'limitraises', 'limrsq'],
  'Kokish Game Try' => [
    'kokishgametry'],
  Namyats => [
    'namia',
    'namiyat',
    'namy',
    'namyant',
    'namyas',
    'namyat',
    'namynt',
    'namyt',
    'namyts'],
  'Negative Double' => [
    'negativex',
    'negdbl',
    'negdble',
    'negx',
    'negx2lev'],
  Splinter => [
    'spli',
    'splider',
    'splin',
    'splinder',
    'spliner',
    'spliners',
    'splinr',
    'splint',
    'splintera',
    'splinters',
    'splintery',
    'splintr',
    'splintrs',
    'splints',
    'splintters',
    'split',
    'spliter'],
  'Weak Jump Shift' => [
    'weakjumpshift',
    'wjs',
    'wkjumpshift',
    'wkjumpshifts'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
