#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Israel;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Rand Cup',
  'Red Sea International Festival'
);

my %MULTI_TYPOS =
(
  'Rand Cup' => [
    'dr_ rand masters',
    'dr. rand masters'],
  'Red Sea International Festival' => [
    'read beach festival', 
    'red beach festival', 
    'red sea bridge festival', 
    'red sea festival',
    'red see int_ bridge festival',
    'red sea int_ festival',
    'red see international festival'],
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
