#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Thailand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_THAILAND =
(
  'Bangkok Bridge Festival' =>
  {
    ORGANIZATION => 'CBLT',
    CITY => 'Bangkok',
    COUNTRY => 'Thailand',
    ORIGIN => 'National',
    ZONE => 'Southeast Asia',

    EDITIONS => 
    {
      '2000' =>
      {
        YEAR => 2000,
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  },

  'Thailand National Games' =>
  {
    ORGANIZATION => 'CBLT',
    COUNTRY => 'Thailand',
    ORIGIN => 'National',
    ZONE => 'Southeast Asia',

    EDITIONS => 
    {
      '2000' =>
      {
        YEAR => 2000,
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  },

);

my %TOURNAMENTS_THAILAND =
(
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_THAILAND, \%TOURNAMENTS_THAILAND, 'Thailand');
}

1;
