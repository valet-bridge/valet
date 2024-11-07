#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Chile;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Chilean Copa de Oro',
  'Chilean Copa de Plata',
  'Chilean Cup',
  'Chilean Invitational Teams',
  'Chilean Open Pairs',
  'Chilean Open Teams',
  'Chilean Open Trials',
  'Chilean Senior Teams',
  'Chilean Women Teams',
  'Chilean Women Trials',
);

my %MULTI_TYPOS =
(
  'Chilean Copa de Oro' => ['copa de oro'],
  'Chilean Copa de Plata' => ['copa de plata'],
  'Chilean Cup' => ['copa aniversario'],
  'Chilean Open Pairs' => ['chilean pairs'],
  'Chilean Open Teams' => ['torneo nacional de chile'],
  'Chilean Open Trials' => [
    'chile open team trials',
    'chile team trials',
    'chilean team trials',
    'chilean open trials'],
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }
}

1;
