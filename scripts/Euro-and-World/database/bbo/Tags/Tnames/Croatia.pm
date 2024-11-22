#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Croatia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Atlantic Trade Bridge Cup',
  'Pula Mixed Teams',
  'Pula Open BAM Teams',
  'Pula Open Teams',
  'Samobor Open Teams',
  'Samobor Women Teams',
);

my %MULTI_TYPOS =
(
  'Atlantic Trade Bridge Cup' => ['atlantic grupa bridge cup'],
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
