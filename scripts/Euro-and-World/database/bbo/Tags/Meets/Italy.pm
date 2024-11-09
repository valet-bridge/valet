#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Italy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Italian Club Championship',
  'Italy Cup',
);

my %MULTI_TYPOS =
(
  'Italian Club Championship' => [
    'camp.societ sportive',
    'campionato italiano di societa',
    'campionato italiano di società',
    'campionato italiano intersocietario',
    'campionato di società',
    'campionati soc',
    'interclub italy',
    'italian club champ_',
    'italian clubs champ_',
    'italian club team',
    'italian club team cham',
    'italian club team champ',
    'italian club team championship',
    'italian club team championships',
    'italian club teams',
    'italian clubs teams championships',
    'italian teams clubs championships',
    'italian interclub',
    'interclub italian'],
  'Italy Cup' => ['coppa italia'],
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
