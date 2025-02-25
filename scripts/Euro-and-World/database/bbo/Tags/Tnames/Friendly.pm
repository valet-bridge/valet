#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Friendly;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Argentina Friendly',
  'Australia Challenge',
  'Australia Practice',
  'Bay Area Challenge',
  'Brighton Exhibition',
  'Canada Practice',
  'Chile Practice',
  'China Friendly',
  'China Practice',
  'Denmark Friendly',
  'Denmark Practice',
  'France Friendly',
  'France Friendly Pairs',
  'France Practice',
  'Germany Friendly Pairs',
  'Germany Practice',
  'Goulash Practice',
  'Hong Kong Friendly',
  'Hungary Challenge',
  'Hungary Exhibition',
  'Hungary Friendly',
  'Hungary Practice',
  'Iceland Exhibition',
  'Iceland Friendly',
  'India Exhibition',
  'Ireland Friendly',
  'Israel Practice',
  'Italy Friendly',
  'Italy Practice',
  'Morocco Friendly',
  'Netherlands Friendly',
  'Netherlands Friendly Pairs',
  'Netherlands Practice',
  'Norway Practice',
  'Online Friendly',
  'Poland Friendly',
  'Poland Mixed Friendly Pairs',
  'Poland Practice',
  'Portugal Friendly',
  'Portugal Practice',
  'Scotland Exhibition',
  'Scotland Friendly',
  'Scotland Practice',
  'Spain Challenge',
  'Spain Friendly',
  'Sweden Friendly',
  'Sweden Practice',
  'Taiwan Practice',
  'Tunisia Friendly',
  'Turkey Practice',
  'Zulawski Friendly',
);

my %MULTI_TYPOS =
(
  'Denmark Practice' => [
    'danish practice'],
  'Scotland Exhibition' => [
    'm lawrence exhibiton',
    'mike lawrence exhibition'],
);

my %SINGLE_TYPOS =
(
  'Denmark Practice' => [
    'landsholdsobservation',
    'landsholdstræning',
    'observationsturnering'],
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
