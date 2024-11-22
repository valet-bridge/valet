#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Sweden;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  "Chairman's Cup",
  'Filbyter Cup',
  'Park Hotell Swiss Teams',
  'S:t Erik Championship Series',
  'Stena Line Cup',
  'Stockholm Teams',
  'Swedish Cup',
  'Swedish District Teams',
  'Swedish Juniors Pairs',
  'Swedish Juniors Teams',
  'Swedish Mixed Teams',
  'Swedish Open Pairs',
  'Swedish Open Teams',
  'Swedish Open Pair Trials',
  'Swedish Open Team Trials',
  'Swedish Premier League',
  'Swedish Senior Team Trials',
  'Swedish Women Pair Trials',
  'Umea Open Teams',
);

my %MULTI_TYPOS =
(
  "Chairman's Cup" => [
    'chairmans cup', 
    "chairmans's cup", 
    "chariman's cup",
    "swedish chairman's cup"],
  'Filbyter Cup' => ['filbyer cup'],
  'Stockholm Teams' => [
    'stockholm teams cs', 
    'stockholms teams'],
  'Swedish District Teams' => [
    'swdish district',
    'sweden distric',
    'sweden district',
    'swedis district',
    'swedish championship cistrict',
    'swedish championship district',
    'swedish championships distrcit',
    'swedish championships district',
    'swedish champsionship district',
    'swesish champsionship district',
    'swedish district championship',
    'swedish district championships',
    'swedish district',
    'swedish districts',
    'swedish disttrict',
    'swesish district'],
  'Swedish Juniors Pairs' => [
    'swedish junior pair championship',
    'swedish junior pairs championship',
    'swedish national junior pair championship',
    'swedish national junior pairs'],
  'Swedish Juniors Teams' => ['swedish juniors teams cs',
    'swedish juniors teams cs', 'swedish junior teams',
    'swedish junior team', 'swedish junior team championship'],
  'Swedish Open Pairs' => [
    'open swedish pairs championship',
    'sweden national pairs',
    'swedish national pairs',
    'swedish open pair',
    'swedish pair',
    'swedish pairs championships'],
  'Swedish Open Pair Trials' => ['nordic race'],
  'Swedish Open Teams' => ['swedish teams'],
  'Swedish Open Team Trials' => [
    'swedish open trials',
    'swedish team trials',
    'swedish teams trials',
    'swedish team trial'],
  'Swedish Premier League' => [
    'swedish club teams',
    'swedish elite series',
    'swedish elitserien',
    'swedish premier leauge',
    'swedish premieer league'],
  'Swedish Senior Team Trials' => [
    'sweden senior trials',
    'swedish senior trials'],
);

my %SINGLE_TYPOS =
(
  'Swedish Premier League' => ['elitserien'],
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
