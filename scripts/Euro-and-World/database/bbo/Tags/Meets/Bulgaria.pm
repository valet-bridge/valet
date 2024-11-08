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
  'Dobrich Bridge Festival',
  'Plovdiv Bridge Festival',
  'Serdika Bridge Festival',
  'Varna Bridge Festival'
);

my %MULTI_TYPOS =
(
  'Dobrich Bridge Festival' => [
    'ibf dobrich'],
  'Plovdiv Bridge Festival' => [
    'bridge festival plovdiv',
    'international bridge festival plovdiv',
    'international festival  plovdiv',
    'international festival plovdiv'],
  'Serdika Bridge Festival' => [
    'bridge festival - serdika',
    'bridge festival serdika'],
  'Varna Bridge Festival' => [
    'international bridge festival varna'],
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
