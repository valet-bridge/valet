#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Particle;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  of => ['out of', '0ff', '(of', '(0f', '(out of', '(or']
);

my @SINGLE_WORDS = qw(
  and
  of
  to
  vs
);

my %SINGLE_TYPOS =
(
  and => ['&'],
  of => ['af', 'off', 'av', 'de', 'olf', 'pf', 'fo', 'from', '0f']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
