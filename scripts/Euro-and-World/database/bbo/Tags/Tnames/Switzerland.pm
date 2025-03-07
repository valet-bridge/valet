#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Switzerland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Jean Besse Cup',
  'Swiss Club Championship',
  'Swiss Cup',
  'Swiss Open Pairs',
  'Swiss Open IMP Pairs',
  'Swiss Open Teams',
  'Swiss Open Team Trials',
  'Zurich Open Pairs',
  'Zurich Open Teams',
);

my %MULTI_TYPOS =
(
  'Jean Besse Cup' => [
    'cup jean besse', 
    'cup jean besser',
    'swiss cup jean besse'],
  'Swiss Club Championship' => [
    'interclub swiss team championship',
    'swiss interclubs',
    'swiss interclub championship',
    'swisss interclubs',
    'swiss interclub'],
  'Swiss Cup' => [
    'copa zurich',
    'coupe suisse',
    'swiss open cup',
    'swiss cuo',
    'switzerland open cup',
    'champion suisse',
    'championnat suisse',
    'swiss championshi',
    'swiss championshio',
    'swiss championship',
    'Swiss open championship',
    'swiss team champiomshio',
    'Swiss team championship'],
  'Zurich Open Pairs' => ['zurich imp pairs']
);

my %SINGLE_TYPOS =
(
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos, $gsingle_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }

  while (my ($key, $value) = each %SINGLE_TYPOS)
  {
    @{$gsingle_typos->{$key}} = @$value;
  }
}

1;
