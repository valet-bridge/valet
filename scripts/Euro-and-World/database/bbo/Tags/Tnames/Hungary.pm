#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Hungary;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Balaton Invitational Teams',
  'Balatonföldvár Open Teams',
  'EcoSoft Cup',
  'Hungarian Cup',
  'Hungarian IMP Pairs',
  'Hungarian Open Pairs',
  'Hungarian Open Teams',
  'Hungarian Open Trials',
  'Hungarian Senior Trials',
  'Hungarian Women Trials'
);

my %MULTI_TYPOS =
(
  'Balaton Invitational Teams' => [
    'balaton international teams',
    'balaton invitation teams'],
  'Balatonföldvár Open Teams' => [
    'balatonfoldvar teams'],
  'EcoSoft Cup' => ['eco soft cup'],
    'Hungarian IMP Pairs' => ['hungarian imp'],
  'Hungarian Open Pairs' => ['hungarian national pairs'],
  'Hungarian Open Teams' => [
    'hungarian championships',
    'hungarian team championships',
    'hungarian teams',
    'hungarian teams championship',
    'hungarian teams championships',
    'hungary teams'],
  'Hungarian Open Trials' => [
    'hungarian team trial',
    'hungarian team trials'],
  'Hungarian Women Trials' => [
    'hungarian woman trials',
    "hungarian woman's trials"]
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
