#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Thailand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bangkok Bridge Festival',
  'Thailand Championship',
  'Thailand National Games',
  'Thailand National Youth Games',
  'Thailand University Games'
);

my %MULTI_TYPOS =
(
  'Bangkok Bridge Festival' => [
    'amazing thailand bridge',
    'amazing thailand bridge festival'],
  'Thailand National Games' => [
    'thailand nation games'],
  'Thailand National Youth Games' => [
    'thailand youth games',
    'thailand youth national games',
    'thailand nationnal youth games'],
  'Thailand University Games' => [
    'university game of thailand',
    'university games of thailand'],
);

my %SINGLE_TYPOS =
(
  'Bangkok Bridge Festival' => [
    'bbf', 
    'bff'],
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
