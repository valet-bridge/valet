#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::USA;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  '0 to 1500 Spingold',
  'Collegiate Bowl',
  'Grand National Teams',
  "Missouri Braggin' Rights",
  'Philadelphia Solomon Teams',
  'Reisinger BAM Teams',
  'Soloway Teams',
  'Spingold Teams',
  "Sternberg Women's BAM Teams",
  'US Girls Trials',
  'US Juniors Training',
  'US Junior Trials',
  'US Mixed Teams',
  'US Open Trials',
  'US Senior Teams',
  'US Senior Trials',
  'US University Trials',
  'US Women Trials',
  'US Youngster Trials',
  'USBF Challenge Match',
  'Vanderbilt Teams',
  'Wagar Teams',
);

my %MULTI_TYPOS =
(

  'Collegiate Bowl' => [
    'acbl collegiate bridge bowl',
    'college bowl',
    'collegiate bridge bowl',
    'collegiate championship',
    'collegiate championships', 
    'collegiate champs'],
  'Grand National Teams' => [
    'gnt championship flt',
    'gnt championship flight',
    'gnt championship'],
  "Missouri Braggin' Rights" => ['bragging rights'],
  'Philadelphia Solomon Teams' => [
    'solomon teams'],
  'Soloway Teams' => [
    'soloway',
    'soloway ko team',
    'soloway ko teams'],
  'Spingold Teams' => [
    'spingold knockout',
    'spingold knockout teams'],
  "Sternberg Women's BAM Teams" => ['marsha may sternberg bam'],
  'US Girls Trials' => [
    'junior usbc rona',
    'jusbc rona'],
  'US Junior Trials' => [
    'us junior teams',
    'usbf junior trials'],
  'US Open Trials' => [
    'us itt',
    'us itt trials',
    'usa international team trials',
    'usa itt',
    'usa itt trials',
    'usa team trial'],
  'US Senior Teams' => [
    'baze senior knock-out',
    'baze senior ko',
    'baze sr_ ko',
    'baze sr_ ko',
    'baze sr ko',
    'nabc senior ko',
    'nabc senior ko teams',
    'nabc senior knock-out teams',
    'united states seniors bridge championship',
    'us senior',
    'us seniors'],
  'US Senior Trials' => [
    'usa seniors team trials',
    'usa seniors trials',
    'usbf senior team trials',
    'usbf senior trials',
    'usbf seniors trials'],
  'US Women Trials' => [
    'united states women bridge championship',
    'us women teams',
    "us women's bridge championship",
    "us women's bridge championhip",
    "united states women's bridge championship"],
  'US Youngster Trials' => [
    'jusbc u21',
    'us u21 teams',
    'us u-21 trials',
    'u-21 us trials'],
  'USBF Challenge Match' => [
    'usbf charity match',
    'usbf jr/pro charity challenge match'],
  'Vanderbilt Teams' => [
    'vanderbilt teams',
    'vanderbilt ko teams'],
  'Wagar Teams' => [
    'wagar teams',
    "wagar women's",
    "wagar women's ko",
    'wagar womens ko'],
);

my %SINGLE_TYPOS =
(
  'Collegiate Bowl' => [
    'collegiate', 
    'collegiates'],
  'Grand National Teams' => ['gnt'],
  'Reisinger BAM Teams' => [
    'reienger',
    'reisibger',
    'reilsinger',
    'reinsinger',
    'reinseinger',
    'reisenger',
    'reisiger',
    'reisingef',
    'reisinger',
    'reisisnger',
    'reisneger',
    'reisnger',
    'resisinger',
    'riesinger',
    'teisenger',
    'teisnger'],
  'Spingold Teams' => ['spingold'],
  'US Junior Trials' => ['usjbc', 'jusbc'],
  'US Juniors Training' => ['jtp'],
  'US Senior Trials' => ['ussbc'],
  'US Women Trials' => [
    'uswbc',
    'uswbf',
    'uswc',
    'us womens championships'],
  'Vanderbilt Teams' => [
    'vanderbilt',
    'vanderbuilt',
    'vanderebilt',
    'vandebilt',
    'vandy'],
  'Wagar Teams' => ['wagar'],
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
