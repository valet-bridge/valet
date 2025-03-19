#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::World;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'APBF Women Elite Tournament',
  'Bermuda Bowl',
  'Damiani Trophy',
  "d'Orsi",
  'Huayuan Cup',
  'IMSA Elite Open Individual',
  'IMSA Elite Open Pairs',
  'IMSA Elite Open Teams',
  'IMSA Elite Women Individual',
  'IMSA Elite Women Pairs',
  'IMSA Elite Women Teams',
  'IOC Grand Prix',
  'McConnell Cup',
  'Oly-Star Cup',
  'Rona Cup',
  'Rosenblum Cup',
  'Tianjin Binhai Cup',
  'Venice Cup',
  'World Kids Teams',
  'World Masters Individual',
  'World Mixed Pairs',
  'World Mixed Teams',
  'World Olympiad Open Teams',
  'World Olympiad Women Teams',
  'World Open Girl Pairs',
  'World Open Girl Teams',
  'World Open Junior IMP Pairs',
  'World Open Junior Pairs',
  'World Open Junior Teams',
  'World Open Pairs',
  'World Open Teams',
  'World Open School Teams',
  'World Open Youngster Pairs',
  'World Open Youngster Teams',
  'World Open Youth BAM Teams',
  'World Senior Teams',
  'World Top Tournament',
  'World Transnational Mixed Teams',
  'World Transnational Open Teams',
  'World University Teams',
  'World Women Teams',
  'World Youngster Teams',
  'World Online Juniors Teams',
  'WBG Open Pairs',
  'WBG Women Pairs',
  'WMG Men Individual',
  'WMG Men Pairs',
  'WMG Men Teams',
  'WMG Open Individual',
  'WMG Open Pairs',
  'WMG Open Teams',
  'WMG Senior Teams',
  'WMG U21 Teams',
  'WMG U26 Teams',
  'WMG U28 Teams',
  'WMG Women Individual',
  'WMG Women Pairs',
  'WMG Women Teams',
  'Wuhan Cup',
);

my %MULTI_TYPOS =
(
  'Bermuda Bowl' => ['bermuda bow', 'bemruda bowl'],
  'Damiani Trophy' => [
    'damiani cup',
    'world junior teams'],
  "d'Orsi" => ["d'orsi senior bowl",
    'seniors bowl', 'senior bowl'],
  'Huayuan Cup' => [
    'hua yuan cup',
    'huayuan cup wbt'],
  'IMSA Elite Women Teams' => [
    'hua yuan cup world women elite bridg',
    'hua yuan cup world women elite tournament',
    'huayuan cup world women elite tournament',
    'women elite tournament',
    "women's bridge elite tournament",
    "women's elite tournament",
    "women's bridge grand prix"],
  'McConnell Cup' => ['mc connell'],
  'Oly-Star Cup' => [
    "oly-star cup women's bridge elite tournament",
    "oly-star cup women's elite tournament",
    "oly-star cup women's bridge grand prix"],
  'Tianjin Binhai Cup' => [
    'tianjin bin hai cup',
    'tianjin binhai cup world men elite tournament'],
  'Venice Cup' => ['<venive <cup'],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Online Juniors Teams' => [
    'wbf Youth world online team championships'],
  'World Open Pairs' => ['world pairs championship'],
  'World Transnational Open Teams' => [
    'world transnational teams'],
  'World University Teams' => [
    'world university bridge championship',
    'world university bridge championships',
    'world university championship',
    'univ_ world champs'],

);

my %SINGLE_TYPOS =
(
  'Bermuda Bowl' => ['bb'],
  "d'Orsi" => ['sb', 'dosb', 'dot'],
  'McConnell Cup' => ['mcconnell'],
  'Rona Cup' => ['rona'],
  'Rosenblum Cup' => ['rosenblum'],
  'Venice Cup' => ['vc', 'venice'],
  'World Transnational Mixed Teams' => ['wtmt'],
  'World Transnational Open Teams' => ['wtot'],
  'World University Teams' => ['wuc'],
  'Wuhan Cup' => ['whc'],

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
