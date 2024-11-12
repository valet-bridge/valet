#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::EuroAdult;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  "European Champions' Cup",
  'European National Championships',
  'European Transnational Championships',
  'European Winter Games',
  'European Winter Transnational Championships',
  'Generali European Championships',
);

my %MULTI_TYPOS =
(
  "European Champions' Cup" => [
    'european bridge champion cup',
    "european bridge champions'cup",
    "european bridge champion's cup",
    "european bridge champions' cup",
    'european chamions cup',
    "european champion's cup",
    'european champions cup',
    "white house champions' cup",
    "whitehouse champions'cup",
    "whitehouse champions' cup"],
  'European National Championships' => [
    'champ eur pau',
    'e_b_l_ team championships',
    'e_b_l_ teams championship',
    'e_b_l_ team champioships',
    'ebl team champs',
    'ebl team championships',
    'ebl teams championship',
    'ebl teams championships',
    'eur cha pau',
    'eur cham pau',
    'eur champ eur',
    'eur champ pau',
    'eur champ puau',
    'euro bridge championships',
    'euro teams',
    'euro team championships',
    'european b.t.ch.',
    'european b_t_ch_',
    'european bridge team championships',
    'european bridge team champ',
    'european championships',
    'europeqn teqm championships',
    'european team championship',
    'european team championships',
    'european teams championship',
    'european teams championships'],
  'European Transnational Championships' => [
    'euro open championship',
    'euro open championships',
    'euro open teams',
    'euroepan open champ',
    'european open bridge championship',
    'european open bridge championships',
    'european open champ',
    'european open championship',
    'european open championships',
    'europe open champ'],

);

my %SINGLE_TYPOS =
(
  'European National Championships' => ['ec'],
  'European Transnational Championships' => ['eobc', 'eoc'],
  'European Winter Games' => ['ewg'],
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
