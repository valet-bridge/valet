#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Netherlands;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'ArboNed Team Cup',
  'Arnhem Interbridge Tournament',
  'Carrousel Cup',
  'Dutch Knock-Out Cup',
  'Dutch Meesterklasse',
  'Forbo-Krommenie Nations Cup',
  'Jaap Kokkes Tournament',
  'Petit Grand Prix van Driene',
  'The Hague Open Teams',
  'The Hague Pro-Am Pairs',
  'Top Circuit',
  'Top Circuit Teams',
  'White House International',
  'White House Juniors',
  'White House Top 12',
);

my %MULTI_TYPOS =
(
  'ArboNed Team Cup' => [
    'arbo ned team cup', 
    'arbo ned teams cup'],
  'Arnhem Interbridge Tournament' => [
    'interbridge tournament'],
  'Dutch Knock-Out Cup' => ['knock-out team cup netherlands',
    'knock out team cup netherlands'],
  'Dutch Meesterklasse' => [
    'dutch mk',
    'dutch team',
    'dutch teams',
    'dutch club teams'],
  'Forbo-Krommenie Nations Cup' => [
    'forbo krommenie teams',
    'forbo nations cup',
    'forbo teams',
    'forbo-krommenie international bridge event',
    'forbo-krommenie tourname',
    'forbo-krommenie tournament',
    'international forbo krommenie bridge event',
    'krommenie nations cup'],
  'Jaap Kokkes Tournament' => [
    'jaap kokkes toernooi',
    'jaap kookes toernooi',
    'jaap kokkes'],
  'Petit Grand Prix van Driene' => [
    'petit grand prix',
    'grand prix van driene'],
  'Top Circuit' => ['melchemie top circuit',
    'ing bank top circuit', 'witte huis topcircuit'],
  'White House International' => [
    'white house international teams',
    'white house top 16',
    'white house tournament teams'],
  'White House Juniors' => [
    'qhite house juniors',
    'the white hous juniors',
    'white house junior',
    'white house junior internationals',
    'whiteouse juniors'],
  'White House Top 12' => ['modalfa top 12', 'witte huis top 12'],
  'White House Top 16' => ['white house int. teams top 16',
    'white house int_ teams top 16',
    'white house international top 16 teams'],
);

my %SINGLE_TYPOS =
(
  'Dutch Meesterklasse' => ['meesterklasse'],
  'Top Circuit' => ['topcircuit'],
  'White House Juniors' => ['whj'],
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
