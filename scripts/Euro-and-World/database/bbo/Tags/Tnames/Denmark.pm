#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Denmark;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Copenhagen Invitational Pairs',
  'Copenhagen Open Pairs',
  'Danish Club Teams',
  'Danish Cup',
  'Danish First Division',
  'Danish Junior Teams',
  'Danish Mixed Pairs',
  'Danish Mixed Teams',
  'Danish Open Pairs',
  'Danish Open Pairs Trials',
  'Danish Open Teams',
  'Danish Open Trials',
  'Danish Women Pairs',
  'Hecht Cup',
  'Prince Henrik Trophy',
  'Vinoble Open'
);

my %MULTI_TYPOS =
(
  'Copenhagen Open Pairs' => ['km åben par'],
  'Danish Club Teams' => [
    'danish club team',
    'danish district teams championship',
    'dm klubhold',
    'dm i klubhold',
    'dm i knubhold',
    'dm i klub hold',
    'dmi i klubhold'],
  'Danish Cup' => [
    'danmark pokal',
    'danmark pokal match',
    'denmark pokal',
    'vinoble cup'],
  'Danish First Division' => [
    '1_ division danmark',
    'danish 1st division',
    'danish 1_division',
    'danish team',
    'danish team champions',
    'danish team championship',
    'danish team championships',
    'danmark 1_ division',
    'danmark 1_division',
    'danmark 1st division',
    'denmark 1st division',
    'denmark 1_division',
    'denmark team championship',
    'dm hold'],
  'Danish Junior Teams' => [
    'danish junior team championship',
    'dansih junior team championship',
    'junior dm'],
  'Danish Mixed Pairs' => [
    'dm mix',
    'dm mix par',
    'danish championship mixed pairs',
    'danish mix-pair championship',
    'danish mix pair championship',
    'danish mix pairs',
    'danish national mix-pairs championship'],
  'Danish Open Pairs' => [
    'danish championship open pairs',
    'danish open pairs championship',
    'denmark national open pair championship',
    'denmark national open pairs championship',
    'danish open pairs championships',
    'danish pairs championship',
    'open pairs - danish championship'],
  'Danish Open Teams' => [
    'danish open',
    'danish open team',
    'danish open teams'],
  'Danish Open Pairs Trials' => [
    'danish team test',
    'danish teams test'],
  'Danish Open Trials' => [
    'danish open team trials',
    'danish team trial',
    'danish team trials',
    'denmark team test'],
  'Danish Women Pairs' => [
    'danish championship ladies pairs',
    'danish champoinship ladies pairs',
    'ladies pairs - danish championship']
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
