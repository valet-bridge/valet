#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Openings;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  '2C Albarran',
  '2C Strong',
  '2D Albarran',
  '2D Ekren',
);

my %MULTI_TYPOS =
(
  '2C Albarran' => [
    '2 c albaran',
    '2 cl strong Albarran',
    '2 t albarant',
    '2 tr albarran',
    '2 trebol albarran',
    '2 treboles albarran',
    '2 trfl strong with albarran',
    '2!c albaran',
    '2!c albarran',
    '23+ 2C albarran mod',
    '2C albaran',
    '2C albarran',
    '2c 20 po albaran',
    '2c alba',
    '2c albaran',
    '2c albarr',
    '2c albarran',
    '2c with albaran',
    '2c(albar)',
    '2c>albaran',
    '2cgf albarran',
    '2cl - 22+ po, albaran',
    '2cl albaran',
    '2cl albaron',
    '2cl strng albaran',
    '2cstrong(alba)',
    '2t albaran',
    '2t albarran',
    '2tr albarran',
    '2tre. albarran',
    '2treb alba',
    '2trebol albarran',
    '2treboles albarran',
    '2trefle albarran',
    'albarran=23+ pts or +1',
    'strong 2 cl 23+ and albaran'],
  '2C Strong' => [
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
  '2D Albarran' => [
    '2diamantes-albarran24o+p.h.'],
  '2D Ekren' => [
    'ekrens 2 ruder til major'],
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
  '2C Albarran' => [
    'albar',
    'albaran',
    'albarr',
    'albarrain',
    'albarran'],
  '2C Strong' => ['strog2club'],
  '2D Ekren' => ['ekren'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
