#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Carding;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'even-odd',
  'high-low',
);

my %MULTI_TYPOS =
(
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
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  'even-odd' => ['pairimpair'],
  'high-low' => ['highenc'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
