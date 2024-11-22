#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::EuroYouth;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'European School Teams',
  'European U16 Open Pairs',
  'European U16 Open Teams',
  'European U21 Open Pairs',
  'European U21 Open Teams',
  'European U26 Mixed Pairs',
  'European U26 Open IMP Pairs',
  'European U26 Open Pairs',
  'European U26 Open Teams',
  'European U26 Women Pairs',
  'European U26 Women Teams',
  'European U31 Open Pairs',
  'European U31 Open Teams',
  "European U31 President's Cup",
  'European University Bridge Championship',
  'European University Team Championship',
);

my %MULTI_TYPOS =
(
  'European U16 Open Teams' => [
    'ebl schools'],
  'European U21 Open Teams' => [
    'euro yongster championships',
    'euro youngster championship',
    'euro youngster championships',
    'euro youngsters championship',
    'euro youngsters championships',
    'european youngster bridge championship'],
  'European U26 Mixed Pairs' => [
    'em pairs junior mix',
    'european mixed junior pairs',
    'eyjc mixed pairs',
    'junior em mix'],
  'European U26 Open Pairs' => [
    'european open junior pairs',
    'european youth bridge pairs championship',
    'european youth pairs'],
  'European U26 Open Teams' => [
    'ebl juniors',
    'euro juniors championship',
    'euro juniors championships',
    'european junior teams',
    'european junior teams championship',
    'european junior teams championships',
    'euroepan junior teams championships',
    'european juniors championship',
    'european juniors championships',
    'european youth teams u26',
    'european youth bridge team champ',
    'european youth teams'],
  'European U26 Women Teams' => [
    'european girls championships',
    'european girls teams',
    'euro girls championships'],
  'European University Bridge Championship' => [
    'european university championship',
    'european universities bridge championship',
    'european univeristies bridge championship',
    'european universities championship',
    'european unibridge championship',
    'european uni bridge championship',
    'european uni championship'],
  'European University Team Championship' => [
    'european universities bridge trophy',
    'eusa games'],
);

my %SINGLE_TYPOS =
(
  'European University Bridge Championship' => ['eubc', 'eucb', 'euc'],
  'European Youth Bridge Championship' => ['eybc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'European Youth Bridge Teams Championship' => ['eytc', 'jem'],
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
