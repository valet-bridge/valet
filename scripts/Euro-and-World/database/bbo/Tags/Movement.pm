#!perl

package Tags::Movement;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Barometer
  Danish
  Goulash
  Swiss
  Triangle
);

my %SINGLE_TYPOS =
(
  Barometer => ['barometr'],
  Goulash => ['goullash', 'goulyash'],
  Swiss => ['suisse', 'swis', 'sw', 'monrad']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
