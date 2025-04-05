#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Colombia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_COLOMBIA =
(
);

my %TOURNAMENTS_COLOMBIA =
(
  'Cali Open Teams' => 
  {
    ORGANIZATION => 'FCBC',
    COUNTRY => 'Colombia',
    CITY => 'Cali',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-01',
            DATE_END => '2018-07-01'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-29',
            DATE_END => '2019-09-29'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_COLOMBIA, \%TOURNAMENTS_COLOMBIA, 'Colombia');
}

1;
