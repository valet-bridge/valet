#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::SouthAfrica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_SOUTHAFRICA =
(
);

my %TOURNAMENTS_SOUTHAFRICA =
(
  'South African Inter-Province Teams' =>
  {
    ORGANIZATION => 'SABF',
    COUNTRY => 'South Africa',
    ORIGIN => 'Interprovince',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-10-27',
            DATE_END => '2009-10-29'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-05-05',
            DATE_END => '2010-05-07'
          } 
        }
      },
    }
  },

  'South African Open Teams' =>
  {
    ORGANIZATION => 'SABF',
    COUNTRY => 'South Africa',
    ORIGIN => 'National',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-14',
            DATE_END => '2008-05-14'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-11',
            DATE_END => '2009-05-12'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-10',
            DATE_END => '2010-05-11'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-14',
            DATE_END => '2012-05-15'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-11',
            DATE_END => '2013-04-12'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SOUTHAFRICA, \%TOURNAMENTS_SOUTHAFRICA, 'South Africa');
}

1;
