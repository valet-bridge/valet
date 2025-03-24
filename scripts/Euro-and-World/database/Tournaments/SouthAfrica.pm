#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::SouthAfrica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'SABF',
  COUNTRY => 'South Africa',
  ZONE => 'African Zone',
);

my %MEETS_SOUTHAFRICA =
(
  'South African Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-05-14',
        DATE_END => '2008-05-14'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-05-11',
        DATE_END => '2009-05-12'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-05-10',
        DATE_END => '2010-05-11'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-05-14',
        DATE_END => '2012-05-15'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-04-11',
        DATE_END => '2013-04-12'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-05-17',
        DATE_END => '2016-05-19'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-05-03',
        DATE_END => '2018-05-04'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-07-16',
        DATE_END => '2019-07-16'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-03-10',
        DATE_END => '2020-03-14'
      },
    }
  },
);

my %TOURNAMENTS_SOUTHAFRICA =
(
  'South African Inter-Province Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND|MATCH',
            DATE_START => '2010-05-05',
            DATE_END => '2010-05-07'
          } 
        }
      },
    }
  },

  'South African Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'South African Congress',
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
        MEET => 'South African Congress',
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
        MEET => 'South African Congress',
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
        MEET => 'South African Congress',
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
        MEET => 'South African Congress',
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
      '2016' =>
      {
        MEET => 'South African Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2016-05-17',
            DATE_END => '2016-05-19'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'South African Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-05-03',
            DATE_END => '2018-05-04'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'South African Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-07-16',
            DATE_END => '2019-07-16'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'South African Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-03-10',
            DATE_END => '2020-03-14'
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
