#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Portugal;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Azores Festival',
  'Estoril Bridge Festival',
  'Lisbon International Festival',
  'Madeira International Festival',
);

my %MULTI_TYPOS =
(
  'Azores Festival' => [
    'azores bridge festival',
    'azores bridge open',
    'azores bridge teams', 
    'azores festiva',
    'azores festival bridge', 
    'azores team', 
    'azores team festval', 
    'azores teams',
    'festival azores',
    'festival azores bridge', 
    'festival bridge azores', 
    'festival internacional azores'],
  'Estoril Bridge Festival' => [
    'estoril festival'],
  'Lisbon International Festival' => [
    'avgp lisbon teams',
    'internacional teams festival avgp',
    'international teams festival avgp',
    'lisbon teams festival'],
  'Madeira International Festival' => [
    'madeira international bridge open',
    'international madeira',
    'madeira bridge open',
    'madeira open'],
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
