#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::EuroAdult;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  "European Open Champions' Cup",
  'European National Mixed Teams',
  'European National Open Teams',
  'European National Seniors Pairs',
  'European National Seniors Teams',
  'European National Women Pairs',
  'European National Women Teams',
  'European Small Federation Games',
  'European Transnational Mixed Pairs',
  'European Transnational Mixed Teams',
  'European Transnational Open Pairs',
  'European Transnational Open Teams',
  'European Transnational Seniors Teams',
  'European Transnational Women Teams',
  'European Winter BAM Trophy',
  'European Winter Teams',
  'European Winter Transnational Teams',
  "European Women Champions' Cup",
  'Generali European Open Teams',
  'Generali European Women Pairs',
  'Generali European Women Teams',
);

my %MULTI_TYPOS =
(
  'European National Mixed Teams' => [
    'euro mixed teams',
    'european mixed teams'],
  'European National Open Teams' => [
    'eur champ pau open'],
  'European National Women Teams' => [
    'eur champ pau woman',
    'eur champ pau women',
    'eur women champ'],
  'European National Seniors Teams' => [
    'eur champ pau senior',
    'eur champ pau seniors'],
  'European Small Federation Games' => [
    'ebl small federation trophy',
    'ebl small federations trophy',
    'games of small federations',
    'european small federations games',
    'small federation games',
    'small federations games',
    'small ffederations games',
    'small federation cup',
    'european small feds games',
    'small f federations games',
    'europian small federation games'],
  'European Transnational Mixed Teams' => [
    'euro open mixed teams'],
  'European Winter Teams' => [
    'zimmermann cup'],
  'Generali European Open Teams' => [
    'generali euro team champs',
    'generali european team championships'],
);

my %SINGLE_TYPOS =
(
  'European Small Federation Games' => ['esfg', 'sfc'],
  'European Winter Teams' => ['zc']
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
