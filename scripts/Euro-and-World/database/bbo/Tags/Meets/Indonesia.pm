#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Indonesia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Indonesian National Championship Week',
  'Indonesian National Games',
  'Indonesian National Pre-Sports Week',
  'Indonesian Province Sports Week',
  'Indonesian Student Championship',
  'Indonesian University Championship',
);

my %MULTI_TYPOS =
(
  'Indonesian National Championship Week' => [
    'indonesia bridge championships',
    'indonesia national championship',
    'indonesia national championships',
    'indonesian championship',
    'indonesian championships',
    'indonesian national chamapionship',
    'indonesian national championship',
    'indonesian national championships',
    'indonesian national champonship',
    'national indonesian championship',
    'national championship indonesia'],
  'Indonesian National Games' => [
    'indonesia week',
    'indonesian games',
    'indonesian nasional games',
    'indonesian national sports week',
    'indonesian national sports weeks'],
  'Indonesian National Pre-Sports Week' => ['pra pon'],
  'Indonesian Student Championship' => [
    'indonesian student championships',
    'indonesian students championship',
    'indonesian students championships'],
  'Indonesian University Championship' => [
    'indonesian university championships'],
);

my %SINGLE_TYPOS =
(
  'Indonesian National Pre-Sports Week' => ['prapon'],
  'Indonesian Province Sports Week' => ['porprov'],
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
