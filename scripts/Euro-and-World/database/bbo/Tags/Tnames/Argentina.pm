#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Argentina;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Argentinian Club Teams',
  'Argentinian Copa Republica',
  'Argentinian Flags Day Championship',
  'Argentinian Mixed Pairs',
  'Argentinian Mixed Teams',
  'Argentinian Open Teams',
  'Argentinian Open Trials',
  'Argentinian Seniors Teams',
  'Argentinian Senior Trials',
  'Argentinian Women Teams',
  'Argentinian Women Trials',
  'Copa Zanalda River Plate',
  'Mar del Plata Open Teams',
);

my %MULTI_TYPOS =
(
  'Argentinian Copa Republica' => ['copa republica'],
  'Argentinian Mixed Pairs' => ['argentina national mixed pairs'],
  'Argentinian Mixed Teams' => [
    'argentina equipos mixtos',
    'campeonato nacional equipos mixtos argentino'],
  'Argentinian Open Teams' => [
    'argentina national team championship',
    'argentina open team',
    'argentina open teams',
    'argentina team championship',
    'argentine team',
    'argentinian open team',
    'cn equipos libres argentina',
    'equipo libres argentina',
    'equipos libres argentina',
    'open argentin team'],
  'Argentinian Open Trials' => [
    'argentina open trials',
    'argentine team trials',
    'argentinian team trials',
    'open argentina team trials',
    'open team argentina trials',
    'openargentin team trials',
    'opteamsudamargentina',
    'seleccion libre argentina',
    'seleccion argentina libre'],
  'Argentinian Seniors Teams' => [
    'clasificatoria argentina seniors sudamericano',
    'clasificatoria seniors argentina'],
  'Argentinian Senior Trials' => [
    'open senior argentina trials',
    'seleccion argetina seniors',
    'seleccion argentina seniors',
    'senior argentina team trials'],
);

my %SINGLE_TYPOS =
(
  'Argentinian Club Teams' => ['cnia'],
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
