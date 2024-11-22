#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Poland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Baltic Congress',
  'Beskids Slam',
  'Boleslawiec Festival',
  'Krakow Congress',
  'Luczniczka Meeting',
  'Palace Cup',
  'Polish Championships',
  'Polish Pairs Championship',
  'Polish School Championship',
  'Poznan Congress',
  'Slawa Congress',
  'Warsaw Grand Prix',
  'Wroclaw Meeting',
  'Zulawski Congress',
);

my %MULTI_TYPOS =
(
  'Baltic Congress' => [
    'baltic bowl',
    'baltic bridge congress',
    'international baltic congress'],
  'Krakow Congress' => ['krakow meeting'],
  'Luczniczka Meeting' => ['meeting luczniczka'],
  'Polish School Championship' => [
    'polish schools champ',
    'polish Schools championship',
    'polish schools champs'],
  'Poznan Congress' => [
    'bridge meeting poznan',
    'kongres poznanski',
    'poznan bridge congress',
    'poznanski kongres brydzowy'],
  'Slawa Congress' => [
    'kongres slawa',
    'slava congress',
    's³awa turniej kongresowy',
    'turniej kongresowy slawa'],
  'Zulawski Congress' => [
    'mityng zulawski',
    "kongres \"zulawski\"",
    'kongres zulawski',
    "mityng \"zulawski\""]
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
