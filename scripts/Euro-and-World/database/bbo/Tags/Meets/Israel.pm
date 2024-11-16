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
  'Israel Grand Prix',
  'Israel Bridge Festival',
  'Red Sea International Festival'
);

my %MULTI_TYPOS =
(
  'Israel Grand Prix' => ['israeli grand prix',
    'israeli grand prize'],
  'Israel Bridge Festival' => [
    'int_ israel festival', 
    'israel festival',
    'israel fest_',
    'israel int_ festival',
    'israel international festival',
    'israeli fest_'],
  'Red Sea International Festival' => [
    'dr_ rand masters',
    'dr. rand masters',
    'rand cup',
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
