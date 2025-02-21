#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::SouthAmerica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'South American Junior Teams',
  'South American Open Pairs',
  'South American Open Teams',
  'South American Open Trials',
  'South American Senior Trials',
  'South American Senior Teams',
  'South American Women Teams',
  'South American Women Trials',
  'South American Zonal Mixed Teams',
  'South American Zonal Open Teams',
  'South American Zonal Senior Teams',
  'South American Zonal Women Teams',
);

my %MULTI_TYPOS =
(
  'South American Junior Teams' => [
    'south american junior championship',
    'south american junior championships',
    'south american junioor championships',
    'youth sabc'],
  'South American Open Pairs' => [
    'sudamericano de parejas',
    'sudamericano de parejas libres'],
  'South American Open Teams' => [
    'libres sudamericano',
    'southamerican open championship',
    'sudamericano libre equipos',
    'sudamericano libres'],
  'South American Senior Trials' => [
    'clasificacion sudamericano seniors'],
  'South American Senior Teams' => [
    'south american senior championship'],
  'South American Senior Trials' => [
    'seleccion sudamericano senior'],
  'South American Women Teams' => [
    'clasificatoria damas equipos',
    'clasificatoria equipos damas',
    'sudamericano damas'],
  'South American Zonal Mixed Teams' => [
    'sabc mixed zonal'],
  'South American Zonal Open Teams' => [
    'sabc open zonal',
    'sabc zonal open'],
  'South American Zonal Senior Teams' => [
    'sabc zonal seniors'],
  'South American Zonal Women Teams' => [
    'sabc zonal women',
    'sabc women zonal'],
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
