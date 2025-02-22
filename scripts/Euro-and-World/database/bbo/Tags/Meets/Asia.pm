#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Asia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'APBF Championships',
  'APBF Youth Championships',
  'ASEAN Club Championship',
  'ASEAN University Games',
  'Asia Cup',
  'Southeast Asian Games'
);

my %MULTI_TYPOS =
(
  'APBF Championships' => [
    'apbf congress',
    'pabf championship', 
    'pabf c',
    'asia pacific bridge federation championship',
    'asia pacific bridge federation championships',
    'asia pacific bridge federation champio teams'],
  'APBF Youth Championships' => [
    'pabf youth championships'],
  'ASEAN Club Championship' => [
    "aseam bridge club c'ship",
    "asean bridge club c'ship",
    'asean bridge club',
    'asean bridge club championship',
    'asean bridge club championships',
    'asean bridge club open championship',
    'asean bridge club open championships',
    'asean bridg club championship',
    "asean bridge c'ship",
    'asean bridge cship',
    'asean bridge championship',
    'asean bridge championships',
    'asean bridge finals',
    'asean club championships'],
  'Southeast Asian Games' => [
    'asian games bridge competition',
    'sea games',
    'seabf championship',
    'seabf championships',
    'south east asia bridge club championships',
    'south east asian games'],
);

my %SINGLE_TYPOS =
(
  'APBF Championships' => ['pabfc', 'pabf', 'pabfs'],
  'ASEAN Club Championship' => ['abcc'],
  'Southeast Asian Games' => ['seagames']
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
