#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Africa;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'African Zonal Championships'
);

my %MULTI_TYPOS =
(
  'African Zonal Championships' => [
    'abf championship',
    'abf championships',
    'abf champoinship',
    'abf zone 8 championships',
    'abf zonal',
    'afbf zone 8 championships',
    'african zonal championships',
    'african zone championship',
    'zonal qualifying africa'],
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
