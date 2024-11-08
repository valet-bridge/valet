#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Bolivia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bolivian Open Teams',
);

my %MULTI_TYPOS =
(
  'Bolivian Open Pairs' => ['bolivariano open pairs'],
  'Bolivian Open Teams' => [
    'bbolivariano open teams',
    'bolivariano open teams',
    'bolivarian tournament',
    'campeonato bolivariano de equipos',
    'torneo bolivariano equipos'],
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
