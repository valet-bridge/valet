#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Swords::RanksFRA;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  minor
  major
);

my %SINGLE_TYPOS =
(
  minor => [
    'mineu',
    'mineur',
    'mineure',
    'mineures',
    'mineurs',
    'mineuure'],
  major => [
    'majeu',
    'majeur',
    'majeure',
    'majeures',
    'majeurex',
    'majeurs',
    'mjeur',
    'mjeure',
    'mjeurs'],
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
