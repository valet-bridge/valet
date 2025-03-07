#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Portugal;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Azores Open Teams',
  'FullBridge International Teams',
  'Lisbon Open Pairs',
  'Lisbon Open Teams',
  'Madeira Open Teams',
  'Portuguese First Division',
  'Portuguese Grand Prix',
  'Portuguese IMP Pairs',
  'Portuguese Mixed Team Trials',
  'Portuguese Mixed Teams',
  'Portuguese Open Teams',
  'Portuguese Open Trials',
  'Portuguese Northern Regional Open Teams',
  'Portuguese Senior Team Trials',
  'Rui Pinto Cup'
);

my %MULTI_TYPOS =
(
  'FullBridge International Teams' => [
    'internacional equipos full bridge',
    'internacional full bridge'],
  'Lisbon Open Pairs' => [
    'lisbon masters'],
  'Madeira Open Teams' => [
    'madeira internacional',
    'madeira internacional open',
    'madeira international open',
    'madeira international teams',
    'madeira international teams open´s',
    'madeira international teams open',
    'madeira swiss',
    'madeira swiss teams',
    'madeira teams',
    'swiss teams madeira'],
  'Portuguese First Division' => [
    'portuguese national inter-clubs 1st division'],
  'Portuguese Grand Prix' => [
    'estoril internacional teams',
    'estoril international teams',
    'estoril open teams',
    'estoril swiss teams',
    'estoril teams',
    'portugal grand peix',
    'portugal grand prix',
    'portuguese grad prix'],
  'Portuguese IMP Pairs' => [
    'nacional pares por imps',
    "nacional pares por imp's",
    'nacional pares imps portugal',
    "campeonato nacional pares por imp's"],
  'Portuguese Mixed Team Trials' => [
    'portuguese mixed team selection',
    'portuguese mixed teams trial',
    'portuguese mixed teams trials'],
  'Portuguese Open Teams' => [
    'campeonato nacional equipas open',
    'equipas open pt',
    'open teams pt',
    'portugal open teams championship',
    'portuguese cneo',
    'portuguese national teams',
    'portuguese national teams open',
    'portuguese teams'],
  'Portuguese Open Trials' => [
    'portuguese open team trials',
    'portuguese open trial',
    'portuguese slection trials',
    'portuguese trials',
    'portuguese trial',
    'portuguese selection trials'],
  'Portuguese Northern Regional Open Teams' => [
    'northern regional open teams',
    'northern regional teams open'],
  'Portuguese Senior Team Trials' => [
    'portuguese senior teams trial'],
  'Rui Pinto Cup' => [
    'taca rui pinto',
    'taça rui pinto']
);

my %SINGLE_TYPOS =
(
  'Portuguese Open Teams' => ['cneo'],
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
