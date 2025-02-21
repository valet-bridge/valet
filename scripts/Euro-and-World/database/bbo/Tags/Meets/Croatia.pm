#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Croatia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Pula Bridge Festival',
  'Samobor Bridge Meeting'
);

my %MULTI_TYPOS =
(
  'Pula Bridge Festival' => [
    'international festival pula',
    'pula brdige festival',
    'pula bridge festiwal'],
  'Samobor Bridge Meeting' => [
    'bridge meeting samobor',
    'samobor invitational bridge meeting'],
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
