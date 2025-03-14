#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::SouthAmerica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'South American Team Championship',
  'South American Trials',
  'South American Zonal Trials',
);

my %MULTI_TYPOS =
(
  'South American Team Championship' => [
    'southamerica championship',
    'southamerican championship',
    'southamerican open championship',
    'south american bridge championships',
    'south american championship',
    'south american championhip',
    'south american champioship',
    'south american championshi',
    'south american championships',
    'sudamerican transnacional',
    'sudamericano de bridge',
    'sudamericano transnacional',
    'sudamerico transnacional'],
  'South American Trials' => [
    'clasificacion sudamericano',
    'clasificatoria sudamericano',
    'clasificatorias sudamericano',
    'south americal trials'],
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
