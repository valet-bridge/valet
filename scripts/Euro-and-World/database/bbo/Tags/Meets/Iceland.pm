#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Iceland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Reykjavik Bridge Festival',
);

my %MULTI_TYPOS =
(
  'Reykjavik Bridge Festival' => [
    'iceland bridge festival',
    'iceland bridgefestival',
    'iceland express bridge festival',
    'icelandic express bridge festival',
    'rekjavikbridgefestival',
    'reykjaikbridgefestival',
    'reykjavibridgefestival',
    'reykjavik bridgefestival',
    'reykjavík bridge festival',
    'reykjavík bridgefestival',
    'reykjavíkbridgefestival',
    'reykjavíkbridgefstival',
    'reykavik bridge festival'],
);

my %SINGLE_TYPOS =
(
  'Reykjavik Bridge Festival' => ['reykjavikbridgefestival'],
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
