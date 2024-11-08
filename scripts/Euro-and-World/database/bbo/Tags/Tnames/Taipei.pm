#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Taipei;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Antonio Chong Cup',
  'NTU Cup',
  'Taiwan University Open Cup',
  'Taiwan University Teachers Cup',
  'Taiwan University Women Cup',
  'Taiwanese Open Trials',
  'Taiwanese Senior Trials'
);

my %MULTI_TYPOS =
(
  'Taiwan University Open Cup' => [
    'taiwan university cup',
    'taiwan university championship'],
  'Taiwan University Women Cup' => [
    'taiwan university championship women'],
  'Taiwan University Teachers Cup' => [
    'taiwan university cup teachers',
    "taiwan university cup teacher's section"],
  'Taiwanese Open Trials' => [
    'chinese taipei open trials',
    'ctcba chinese taipei open team trials',
    'ctcba chinese taipei open trial',
    'ctcba open team trial',
    'ctcba open team trials',
    'ctcba open trail',
    'ctcba open trial',
    'ctcba trial',
    'chinese taipei open team trail',
    'chinese taipei open team trial',
    'chinese taipei open team trials',
    'chinese taipei team trial',
    'chinese taipei trails',
    'chinese taipei trials',
    'taipei open trials',
    'taiwanese teal trial',
    'taiwanese team trial',
    'taiwanese trials'],
  'Taiwanese Senior Trials' => [
    'ctcba senior team trial']
);

my %SINGLE_TYPOS =
(
  'NTU Cup' => ['ntucup'],
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
