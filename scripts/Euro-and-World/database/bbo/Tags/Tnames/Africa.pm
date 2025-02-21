#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Africa;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'African Zonal Open Teams',
  'African Zonal Senior Teams',
  'African Zonal Women Teams',
  'Hammamet Cup',
  'Marmara Mixed Teams',
  'Marmara Open Teams',
  'Morocco Open Pairs',
  'Morocco Patton Teams',
  "Pigg's Peak All Africa",
);

my %MULTI_TYPOS =
(
  'African Zonal Open Teams' => [
    'african zonal open trials',
    'african zone 8 open teams',
    'zonal africa open'],
  'African Zonal Senior Teams' => [
    'african zonal senior trials'],
  'African Zonal Women Teams' => [
    'african zonal women trials',
    'zonal africa ladies',
    'zonal africa women'],
  'Hammamet Cup' => ['coupe hammamet']
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
