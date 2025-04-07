#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Chile;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Chilean Copa de Oro',
  'Chilean Copa de Plata',
  'Chilean Cup',
  'Chilean Invitational Teams',
  'Chilean Junior Teams',
  'Chilean Mixed Trials',
  'Chilean Open Pairs',
  'Chilean Open Teams',
  'Chilean Open Trials',
  'Chilean Senior Teams',
  'Chilean Senior Trials',
  'Chilean Women Teams',
  'Chilean Women Trials',
  'Santiago Open Teams Cup',
  'Vitacura Open Teams Cup',
  'Vitacura Women Teams Cup'
);

my %MULTI_TYPOS =
(
  'Chilean Copa de Oro' => [
    'copa oro chile',
    'copa de oro'],
  'Chilean Copa de Plata' => [
    'copa de plata',
    'copa plata chile'],
  'Chilean Cup' => ['copa aniversario'],
  'Chilean Mixed Trials' => ['seleccion mixta chile'],
  'Chilean Open Pairs' => ['chilean pairs'],
  'Chilean Open Teams' => ['torneo nacional de chile'],
  'Chilean Open Trials' => [
    'chile open team trials',
    'chile seleccion libre',
    'chile seleccion libres',
    'chile selección libres',
    'chile team trials',
    'chilean team trials',
    'chilean open trials',
    'seleccion chile libre',
    'seleccion chile libres',
    'seleccion libre chile',
    'seleccion libres chile'],
  'Vitacura Open Teams Cup' => [
    'copa club vitacura',
    'internacional vitacura'],
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
