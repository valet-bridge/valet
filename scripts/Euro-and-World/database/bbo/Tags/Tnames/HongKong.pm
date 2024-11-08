#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::HongKong;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Hong Kong Inter-City Open Teams',
  'Hong Kong Inter-City Women Teams',
  'Hong Kong New Year Teams',
);

my %MULTI_TYPOS =
(
  'Hong Kong Inter-City Open Teams' => [
    'hong kong iner-city',
    'hong kong inter-city',
    'JP Morgan Inter-City Championship',
    'JP Morgan Inter-City Bridge Championship',
    'JP Morgan Intercity Bridge Championships',
    'JP Morgan Intercity Bridge Championships-Open',
    'JP Morgan Intercity Bridge Championships-Open T_',
    'JP Morgan Intercity Bridge Championships-Open  T_'],
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
