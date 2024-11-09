#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::France;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Mondial de Deauville',
);

my %MULTI_TYPOS =
(
  'Mondial de Deauville' => [
    "barrière champion's cup",
    "barriere champion's cup",
    'barriere championship',
    'barriere championship deauville',
    'barrière championship',
    'champion ship barriere',
    'champions barriere',
    "deauville championship's tournament",
    'mondial barriere deauville',
    'mondial barrière de deauville',
    'mondial deauville',
    'mondial de deauille',
    'montial de deauville',
    'tournoi des champions',
    'tournoi des champions barriere'],
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
