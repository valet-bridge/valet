#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Balkan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Balkan Championship',
  'Balkan Friendship Festival'
);

my %MULTI_TYPOS =
(
  'Balkan Championship' => [
    'balkanbridge championship',
    'balkan bridge ch',
    'balkan bridge championship',
    'balkan championships',
    'balkan teams',
    'bolkan championship',
    'bolkan team championship',
    'bolkan teams championship'],
  'Balkan Friendship Festival' => ['balkan bridge festival',
    'balkan festival', 'balcan friendship festival',
    'balcan frienship festival', 'balkan frienship festival',
    'balkan friendsphip festival'],
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
