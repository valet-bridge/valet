#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::NewZealand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'New Zealand Inter-Provincial Teams',
  'New Zealand National Congress',
  'New Zealand Trials',
);

my %MULTI_TYPOS =
(
  'New Zealand Inter-Provincial Teams' => [
    'nz ip',
    'nz ips'],
  'New Zealand Trials' => [
    'nz trials'],
);

my %SINGLE_TYPOS =
(
  'New Zealand Inter-Provincial Teams' => ['nzips'],
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
