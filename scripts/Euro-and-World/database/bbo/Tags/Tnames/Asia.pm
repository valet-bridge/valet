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
  'APBF Junior Mixed Teams',
  'APBF Kids Teams',
  'APBF Mixed Teams',
  'APBF Open Pairs',
  'APBF Open Teams',
  'APBF School Teams',
  'APBF Senior Teams',
  'APBF U21 Women Teams',
  'APBF U26 Women Teams',
  'APBF U31 Open Teams',
  'APBF Women Teams',
  'APBF Youngster Teams',
  'ASEAN U21 Club Teams',
  'ASEAN U26 Club Teams',
  'ASEAN Mixed Club Teams',
  'ASEAN Open Club Pairs',
  'ASEAN Open Club Teams',
  'ASEAN University Open Pairs',
  'ASEAN University Teams',
  'ASEAN University Women Pairs',
  'ASEAN Women Club Teams',
  'ASEAN Youngsters Club Teams',
  'Asia Junior Teams Cup',
  'Asia Mixed Pairs',
  'Asia Mixed Teams Cup',
  'Asia Mixed Team Trials',
  'Asia Open Pairs',
  'Asia Open Team Trials',
  'Asia Open Teams Cup',
  'Asia Senior Teams Cup',
  'Asia Women Team Trials',
  'Asia Women Teams Cup',
  'Asian University Championship',
  'SEA Mixed Pairs',
  'SEA Mixed Teams',
  'SEA Open Pairs',
  'SEA Open Teams',
  "SEA President's Cup",
  'SEA Senior Teams',
  'SEA U21 Teams',
  'SEA Women Pairs',
  'SEA Women Teams',
  'South Pacific Open Teams',
  'Yeh Bros Cup',
  'Yeh Bros Pairs Cup',
);

my %MULTI_TYPOS =
(
  'APBF Mixed Teams' => [
    'apbf mixed'],
  'APBF Open Teams' => [
    'apbf open'],
  'APBF Senior Teams' => [
    'apbf senior',
    'apbf seniors'],
  'APBF Women Teams' => [
    'apbf ladies'],
  'ASEAN Open Club Pairs' => [
    'asean open pairs'],
  'ASEAN Open Club Teams' => [
    'asean bridge open team finals',
    'asean clubs championships open teams',
    'asean open',
    'asean open teams'],
  'ASEAN Mixed Club Teams' => [
    'asean mixed teams'],
  'Asia Open Team Trials' => [
    'asian games trials',
    'test event road to asian games'],
  'Asian University Championship' => [
    'asian university bridge championship'],
  "SEA President's Cup" => [
    'seabf president cup'],
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
