#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Bulgaria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Albena Bridge Festival',
  'Cherven Briag Festival',
  'Dobrich Bridge Festival',
  'Lozenets Bridge Festival',
  'Pavel Banya Bridge Festival',
  'Plovdiv Bridge Festival',
  'Serdika Bridge Festival',
  'Shumen Bridge Festival',
  'Stara Zagora Bridge Festival',
  'Varna Bridge Festival',
  'Vitosha Bridge Festival'
);

my %MULTI_TYPOS =
(
  'Albena Bridge Festival' => [
    'albena international bridge festival',
    'international bridge festival albena'],
  'Cherven Briag Festival' => [
    'read beach festival',
    'red beach festival'],
  'Dobrich Bridge Festival' => [
    'ibf dobrich'],
  'Lozenets Bridge Festival' => ['bridge festival lozenets'],
  'Pavel Banya Bridge Festival' => [
    'bridge festival pavel banya',
    'bridge holiday pro ead',
    'bridge vacation pro ead',
    'international bridge festival pavel banya',
    'international bridge holiday pro ead',
    'international bridge holidays pavel banya',
    'international festival pavel banya',
    'pro ead pavel banya'],
  'Plovdiv Bridge Festival' => [
    'bridge festival plovdiv',
    'international bridge festival plovdiv',
    'international festival  plovdiv',
    'international festival plovdiv'],
  'Serdika Bridge Festival' => [
    'bridge festival serdica',
    'bridge festival - serdika',
    'bridge festival serdika',
    'sofia bridge festival'],
  'Shumen Bridge Festival' => [
    'international bridge festival shumen',
    'international congress shumen'],
  'Stara Zagora Bridge Festival' => [
    'bridge festival - stara zagora',
    'bridge festival stara zagora',
    'bridge festival-bulgaria-stara zagora',
    'international bridge festival stara zagora'],
  'Varna Bridge Festival' => [
    'ibf varna',
    'international bridge festival varna',
    'international festival varna'],
  'Vitosha Bridge Festival' => [
    'vitosha spring festival']
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
