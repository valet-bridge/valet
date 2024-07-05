#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Month;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  January 
  February 
  March
  April 
  May 
  June 
  July 
  August
  September 
  October
  November 
  December
);

my %SINGLE_TYPOS =
(
  January => ['jan'],
  February => ['feb'],
  March => ['mar'],
  April => ['apr'],
  May => ['mayo'],
  June => ['jun', 'juin'],
  July => ['jul'],
  August => ['aug'],
  September => ['settembre', 'sept', 'sep'],
  October => ['oct'],
  November => ['nov'],
  December => ['dec']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
