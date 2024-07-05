#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Day;

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
  Monday
  Tuesday 
  Wednesday
  Thursdy
  Friday 
  Saturday 
  Sunday
);

my %SINGLE_TYPOS =
(
  Monday => ['mon'],
  Tuesday => ['tue'],
  Wednesday => ['wed'],
  Thursday => ['thu'],
  Friday => ['fri', 'freitag'],
  Saturday => ['sat', 'samstag'],
  Sunday => ['sun', 'sønd', 'sonntag']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
