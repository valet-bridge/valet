#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::NotNames;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'bat joro',
  'black milan',
  'boom be',
  'diamond nat',
  'love eda',
  'lyon york',
  'nie mam',
  'oma joke',
  'ro ki',
  'white cat'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
);

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
