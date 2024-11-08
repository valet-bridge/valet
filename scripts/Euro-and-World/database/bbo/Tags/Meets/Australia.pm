#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Australia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Australian ANC Championships',
  'Australian Autumn Nationals',
  'Australian Spring Nationals',
  'Australian Summer Festival',
  'Australian Youth Week',
  'Gold Coast Congress',
  'Victor Champion Cup'
 
);

my %MULTI_TYPOS =
(
  'Australian ANC Championships' => [
    'australian national championships'],
  'Australian Spring Nationals' => [
    'aus spring nationals',
    'australian spring national',
    'sydney spring nationals'],
  'Australian Summer Festival' => ['summer bridge festival'],
  'Gold Coast Congress' => ['gold coast'],
);

my %SINGLE_TYPOS =
(
  'Australian Summer Festival' => ['sfb', 'sfob'],
  'Victor Champion Cup' => ['vcc'],
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
