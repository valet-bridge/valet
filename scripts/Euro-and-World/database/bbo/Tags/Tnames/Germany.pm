#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Germany;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bonn Nations Cup',
  'German Bundesliga',
  'German Club Cup',
  'German Mixed Teams',
  'German Open Pairs',
  'German Open Teams',
  'German Open Trials',
  'German Team Trophy',
  'German Women Pairs',
  "Gro's Supercup",
  'König Ludwig Cup',
);

my %MULTI_TYPOS =
(
  'Bonn Nations Cup' => [
    'bonn cup',
    'nations cup germany'], 
  'German Club Cup' => [
    'german cup',
    'vereinspokal',
    'dbv-cup',
    'dbv cup',
    'dbv-pokal'],
  'German Mixed Teams' => [
    'deutsche mixed-teammeisterschaft',
    'deutsche mixed teammeisterschaft'],
  'German Open Pairs' => [
    'german men pairs',
    'german mens pairs',
    'germany mens pairs',
    'Dr. Heinz von Rotteck Pokal',
    'dr_-heinz-von-rotteck-pokal',
    'v_-rotteck-pokal'],
  'German Open Teams' => [
    'offene deutsche teammeisterschaft',
    'offene team meisterschaft',
    'offene team meistershaft',
    'german open team championships',
    'german open',
    'german open team',
    'open german team'],
  'German Open Trials' => [
    'deutsche open qualifikation',
    'german open qualification'],
  'German Team Trophy' => [
    'german bridge team trophy',
    'german team bridge trophy',
    'german bridge trophy'],
  'German Women Pairs' => ['damen-paar'],
  "Gro's Supercup" => ["gro's super-cup", 'gros supercup'],
  'König Ludwig Cup' => ['koenig ludwig nationen cup'],
);

my %SINGLE_TYPOS =
(
  'German Team Championship' => ['teammeisterschaft'],
  'German Bundesliga' => ['bundesliga'],
  "Gro's Supercup" => ['grocup'],
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
