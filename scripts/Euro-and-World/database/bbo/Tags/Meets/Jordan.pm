#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Jordan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Jordan Bridge Festival',
  'Jordan Spring Festival',
);

my %MULTI_TYPOS =
(
  'Jordan Bridge Festival' => [
    'amman bridge festival',
    'amman festival',
    'jordab festival',
    'jordan festival',
    'jordan b_ festival',
    'jordan bridge f estival'],
  'Jordan Spring Festival' => [
    'jordan bridge tournament spring festival',
    'jordan bridge tournament ( spring festival)',
    'jordan bridge tournament (spring festival)',
    'jordan spring bridge festival',
    'jordan spring tournament'],
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
