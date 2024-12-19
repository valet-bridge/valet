#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Venezuela;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'VBF',
  COUNTRY => 'Venezuela',
  ZONE => 'South America'
);

my %MEETS_VENEZUELA =
(
);

my %TOURNAMENTS_VENEZUELA =
(
  'Venezuelan Mixed Teams' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-04-03',
            DATE_END => '2011-04-03'
          } 
        }
      },
    }
  },

  'Venezuelan Swiss Pairs' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP', # Really?
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Swiss',
            DATE_START => '2010-05-26',
            DATE_END => '2010-05-26'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2011-04-04',
            DATE_END => '2011-04-06'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_VENEZUELA, \%TOURNAMENTS_VENEZUELA, 'Venezuela');
}

1;
