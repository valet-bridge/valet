#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Spain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Las Palmas Simultaneous Pairs',
  'Las Palmas Women Pairs',
  'Madrid Senior Teams',
  'Mutton Individual Cup',
  'Open Catalunya Preferent Pairs',
  'Open Catalunya Preferent Teams',
  'Spanish Central Zone Teams',
  'Spanish Mixed Teams',
  'Spanish Open Teams',
  'Spanish Open Trials',
  'Spanish Senior Trials',
);

my %MULTI_TYPOS =
(
  'Las Palmas Simultaneous Pairs' => ['simultaneo de mayo las palmas'],
  'Madrid Senior Teams' => ['equipos senior madrid'],
  'Mutton Individual Cup' => [
    'mutton cup', 
    'mutton-cup'],
  'Open Catalunya Preferent Pairs' => [
    'open cataluña preferent',
    'open catalunya preferent',
    'open preferent'],
  'Open Catalunya Preferent Teams' => [
    'open catalunya equips',
    'open equips preferent',
    'open preferent equips'],
  'Spanish Central Zone Teams' => [
    'equipos zonal centro',
    'zonal centro equipos'],
  'Spanish Mixed Teams' => [
    'cn españa mixto',
    'spanish mixed national teams'],
  'Spanish Open Teams' => [
    'camp esp',
    'campeonato de españa por equipos',
    'campeonato espan',
    'campeonato espanaonda',
    'cn españa equipos',
    'cn españa open',
    'cn españa tm',
    'cn españa tm open',
    'cpto equipos españa',
    'cpto españa equipos',
    'cpto_españa equipos',
    'spanish national championship',
    'spanish national teams',
    'spanish national teams championship',
    'spanish teams',
    'spanish teams championship',
    "spanish teams ch'ship",
    'spain teams'],
  'Spanish Open Trials' => [
    'open seleccion mundial'],
  'Spanish Senior Trials' => [
    'prueba de seleccion equipos senior'],
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
