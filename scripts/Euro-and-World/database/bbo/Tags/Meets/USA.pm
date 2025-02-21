#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::USA;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'North American Bridge Championship',
  'United States Bridge Championship',
  'United States Youth Bridge Championship',
);

my %MULTI_TYPOS =
(
  'North American Bridge Championship' => [
    'fall nabc'],
  'United States Bridge Championship' => [
    'united states bridge championships',
    'us bridge championship',
    'u_s_b_c'], 
  'United States Youth Bridge Championship' => [
    'michael seamon jusbc',
    'junior usbc'],
);

my %SINGLE_TYPOS =
(
  'North American Bridge Championship' => ['nabc'],
  'United States Bridge Championship' => ['usbc'],
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
