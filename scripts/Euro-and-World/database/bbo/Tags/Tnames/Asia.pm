#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Asia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'APBF Girl Teams',
  'APBF Junior Teams',
  'APBF Mixed Teams',
  'APBF Open Teams',
  'APBF School Teams',
  'APBF Senior Teams',
  'APBF Women Teams',
  'APBF Youngster Teams',
  'ASEAN Mixed Club Teams',
  'ASEAN Open Club Pairs',
  'ASEAN Open Club Teams',
  'ASEAN Women Club Teams',
  'ASEAN Youngsters Club Teams',
  'Asia Open Teams Cup',
  'Asia Women Teams Cup',
  'Asian University Championship',
  'SEA Mixed Pairs',
  'SEA Mixed Teams',
  'SEA Open Pairs',
  'SEA Open Teams',
  'SEA Women Pairs',
  'SEA Women Teams',
  'South Pacific Open Teams',
  'Yeh Bros Cup',
  'Yeh Bros Pairs Cup',
);

my %MULTI_TYPOS =
(
  'ASEAN Open Club Pairs' => [
    'asean open pairs'],
  'ASEAN Open Club Teams' => [
    'asean bridge open team finals',
    'asean clubs championships open teams',
    'asean open',
    'asean open teams'],
  'ASEAN Mixed Club Teams' => [
    'asean mixed teams'],
  'Asian University Championship' => [
    'asian university bridge championship'],
  'South Pacific Open Teams' => [
    'south pacific zone 7 championship',
    'spbf championship',
    'zone 7 championship',
    'zone 7 championships'],
  'Yeh Bros Cup' => [
    'yehbros cup',
    'yer bros cup'],
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
