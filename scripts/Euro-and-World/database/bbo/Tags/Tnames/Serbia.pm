#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Serbia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Novi Sad Open Teams',
  'Serbian Cup',
  'Serbian Inter-City Teams',
  'Serbian Open Teams',
  'Serbian Open Trials',
  'Serbian Premier League',
  'Vrnjacka Banja Open Teams',
);

my %MULTI_TYPOS =
(
  'Serbian Cup' => [
    'cup of serbia',
    'cup srbije',
    'kup srbije',
    'serbian kup'],
  'Serbian Open Teams' => [
    'serbian bridge championship',
    'serbia teams championship',
    'serbian tam championship',
    'serbian team championship',
    'serbian teams championship',
    'serbianteam championship',
    'serbian closed team championship'],
  'Serbian Open Trials' => [
    'open serbian trials',
    'serbian open team trials',
    'serbian open trial',
    'serbian teams trial'],
  'Serbian Premier League' => [
    'serbian league',
    'serbian premier leaugue',
    'serbian premier leauge'],
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
