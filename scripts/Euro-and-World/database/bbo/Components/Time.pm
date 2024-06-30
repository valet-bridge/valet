#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Components::Time;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Summer => ['summer time']
);

my @SINGLE_WORDS = qw(
  Christmas
  Day
  Fall
  May July September
  Tuesday Saturday Summer Sunday
  Week Weekend
);

my %SINGLE_TYPOS =
(
  Christmas => ['xmas'],
  May => ['mayo'],
  September => ['settembre'],
  Sunday => ['sønd']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
