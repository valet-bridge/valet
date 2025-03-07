#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::MiddleEast;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Arab Nations Championship',
  'BFAME Championship',
);

my %MULTI_TYPOS =
(
  'Arab Nations Championship' => [
    'arab nation championship',
    'arab nation championships',
    'arab nations championships'],
  'BFAME Championship' => [
    'zone 4 bridge championship',
    'zone4 bridge championship',
    'befame championships',
    'bfame chp',
    'bfame championships',
    'bfame bridge championship',
    'bfame bridge championships',
    'bfame chamionship'],
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
