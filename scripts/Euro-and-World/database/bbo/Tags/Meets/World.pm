#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::World;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'FISU World University Championships',
  'IMSA Elite Mind Games',
  'IMSA World Masters Championships',
  'World Olympiad',
  'World Series',
  'World Mind Games',
  'World Team Championships',
  'World Youth Championships',
  'World Youth Open Championships'
);

my %MULTI_TYPOS =
(
  'IMSA Elite Mind Games' => [
    'imsaelitemindgames',
    'imsaelitemindsgames',
    'imsaeliteminggames'],
  'IMSA World Masters Championships' => [
    'imsa wmc'],
  'World Series' => ['world bridge series'],
  'World Mind Games' => [
    'mind sports games', 
    'word mind games', 
    'world mind game', 
    'world ming games',
    'sawmg', 
    'wmg', 
    'wmsg',
    'wnsg'], 
  'World Olympiad' => [
    'bridge olympiad',
    'world bridge olympiad', 
    'world bridge team olympiad',
    'world team olympiad'],
  'World Youth Championships' => [
    'world youth bridge team championship',
    'world youth championship',
    'world youth team championships',
    'world youth teams',
    'world youth teams championship'],
  'World Youth Open Championships' => [
    'world youht congress',
    'world youth congress',
    'world youth open bridge championship',
    'world youth bridge congress',
    'workd youth bridge congress',
    'worlf youth bridge congress',
    'wboyc',
    'wyobc',
    'youth world bridge congress'],
);

my %SINGLE_TYPOS =
(
  'World Olympiad' => ['olympiad', 'olympiads', 'wbo'],
  'World Series' => ['wbs'],
  'World Team Championships' => ['wbtc'],
  'World Youth Championships' => ['wytc', 'wybtc'],
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
