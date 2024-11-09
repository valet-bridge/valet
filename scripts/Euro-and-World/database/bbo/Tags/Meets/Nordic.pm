#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Nordic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Nordic Junior Championship',
  'Nordic Team Championship',
);

my %MULTI_TYPOS =
(
  'Nordic Junior Championship' => [
    'nordic championship for juniors',
    'nordic junior championships'],
  'Nordic Team Championship' => [
    'nordic bridge championship',
    'nordic bridge championships',
    'nordic bridge team championship',
    'nordic championship',
    'nordic championships',
    'nordic team championships',
    'nordics'],
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
