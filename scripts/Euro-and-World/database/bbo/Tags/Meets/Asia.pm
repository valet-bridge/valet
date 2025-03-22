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
  'Asian National Games',
  'Southeast Asian Games',
  'South East Asian Championship'
);

my %MULTI_TYPOS =
(
  'APBF Championships' => [
    'apbf congress',
    'apbf championship',
    'pabf championship', 
    'pabf c',
    'asia pacific bridge federation championship',
    'asia pacific bridge federation championships',
    'asia pacific bridge federation champio teams'],
  'APBF Youth Championships' => [
    'apbf open youth championship',
    'apbf youth teams championships',
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
  'Asian National Games' => [
    'asian games bridge competition'],
  'Southeast Asian Games' => [
    'sea games',
    'south east asian games'],
  'South East Asian Championship' => [
    'seabf championship',
    'seabf championships',
    'seabf team championships',
    'south east asia bridge club championships',
    'test event road to asian games'],
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
