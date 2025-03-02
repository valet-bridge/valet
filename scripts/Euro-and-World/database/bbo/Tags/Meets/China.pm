#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::China;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'All China Games',
  'China Elite Tournament',
  'Chinese Club Championships',
  'Chinese Team Championships',
  'Hainan Bridge Festival',
  'JPD Cup'
);

my %MULTI_TYPOS =
(
  'All China Games' => ['all-china games'],
  'China Elite Tournament' => [
    'bridge elite tournament china',
    'china bridge elite tournament',
    'china bridge elite invitational tournament',
    'china elite inivitational tournament',
    'china mind games',
    'china national mind games'],
  'Chinese Club Championships' => [
    'china bridge club championship',
    'chinese club championship',
    'club championships china'],
  'Chinese Team Championships' => [
    'ccba championships'],
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
