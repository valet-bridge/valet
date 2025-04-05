#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Thailand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Bangkok Open Teams',
  'Thailand Junior Teams',
  'Thailand Mixed Teams',
  'Thailand Open Teams',
  'Thailand Open Team Trials',
  'Thailand Women Teams',
  'Thailand Youth Games Mixed Teams',
  'Thailand Youth Games Open Teams',
);

my %MULTI_TYPOS =
(
  'Thailand Open Teams' => [
    'thailand open team championships',
    'thailand team championship',
    'thailand teams championship'],
  'Thailand Youth Games Open Teams' => [
    'thailand national youth team games'],
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
