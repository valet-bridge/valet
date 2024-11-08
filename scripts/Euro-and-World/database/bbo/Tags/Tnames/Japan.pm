#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Japan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Japanese District KO Teams',
  'Japanese Open Trials',
  'Kanto Teams',
  'NEC Cup',
  'Prince Takamatsu Cup',
);

my %MULTI_TYPOS =
(
  'Japanese Open Trials' => ['japanese open team trial',
    'japanese open team trials'],
  'NEC Cup' => [
    'nec cup bridge festival'],
  'Prince Takamatsu Cup' => [
    'prince takamatsu memorial cup',
    'takamatsu cup'],
);

my %SINGLE_TYPOS =
(
  'Prince Takamatsu Cup' => ['takamatsu'],
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
