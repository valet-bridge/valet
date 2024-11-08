#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Greece;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Greek Central Regional Pairs',
  'Greek Mixed Pairs',
  'Greek Northern Regional',
  'Greek Open Teams',
  'Greek Open Pair Trials',
  'Greek Open Team Trials',
  'Greek Women Trials',
  'Thanos Capayiannides Memorial Simultaneous',
);

my %MULTI_TYPOS =
(
  'Greek Central Regional Pairs' => [
    'regional championship of central greece'],
  'Greek Mixed Pairs' => [
    'hellenic mixed pairs',
    'hellenik mixed pairs'],
  'Greek Northern Regional' => [
    'n_ greece regional championship'],
  'Greek Open Teams' => [
    'greek natioanal teams',
    'greek open nationa team',
    'grekk open national team',
    'greek open team',
    'greek open team championship',
    'greek team',
    'greek teams',
    'hellenic teams championship'],
  'Greek Open Team Trials' => [
    'greek national team trials',
    'greek national teams trials',
    'greek national trials',
    'greek open nationa team trials',
    'greek open national team trials',
    'greek open team trials',
    'greek trials',
    'grekk open national team trials',
    'helenic national team trials',
    'hellenic national team trials',
    'hellenic national teams trials',
    'hellenic open team trials',
    'hellenic team trials',
    'hellenic teams trials'],
  'Greek Women Trials' => [
    'hellenic ladies team trials',
    'hellenic ladies teams trials'],
  'Thanos Capayiannides Memorial Simultaneous' => [
    'thanos capayiannides'],
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
