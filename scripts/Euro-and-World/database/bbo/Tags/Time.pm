#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Time;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
  Summer => ['summer time']
);

my @SINGLE_WORDS = qw(
  Christmas
  Afternoon Day Evening
  Fall
  January February April May June July September November December
  Tuesday Friday Saturday Sunday
  Summer 
  Week Weekend
);

my %SINGLE_TYPOS =
(
  Christmas => ['xmas'],
  December => ['dec'],
  January => ['jan'],
  Friday => ['freitag'],
  May => ['mayo'],
  November => ['nov'],
  Saturday => ['samstag'],
  September => ['settembre'],
  Sunday => ['sønd', 'sonntag']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
