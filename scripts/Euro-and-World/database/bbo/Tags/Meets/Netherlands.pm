#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Netherlands;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'The Hague Bridge Experience',
  'VVE Beheer Bridge Week',
);

my %MULTI_TYPOS =
(
  'The Hague Bridge Experience' => [
    'teh hague bridge experience',
    'the hague bride experience',
    'the hague bridge festival'],
  'VVE Beheer Bridge Week' => [
    'vve-beheer bridgeweek',
    'vve-beheer bridge week'],
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
