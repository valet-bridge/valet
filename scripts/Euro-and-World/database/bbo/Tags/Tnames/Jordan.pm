#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Jordan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Jordan Mixed Pairs',
  'Jordan Open Pairs',
  'Jordan Open Teams',
  'Jordan Spring Mixed Pairs',
  'Jordan Spring Open Pairs'
);

my %MULTI_TYPOS =
(
  'Jordan Open Pairs' => [
    'jordanese open pairs'],
  'Jordan Spring Mixed Pairs' => [
    'jordan spring mix pairs',
    'jordan spring mixed pairs'],
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
