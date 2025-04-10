#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Bolivia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'ABB',
  COUNTRY => 'Bolivia',
  ZONE => 'South America',
);

my %MEETS_BOLIVIA =
(
);

my %TOURNAMENTS_BOLIVIA =
(
  'Bolivian Open Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        ORDINAL => 12,
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-11-16',
            DATE_END => '2015-11-16'
          },
        }
      },
    }
  },

  'Bolivian Open Teams' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        ORDINAL => 7,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-09-10',
            DATE_END => '2004-09-11'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-09-11',
            DATE_END => '2004-09-12'
          } 
        }
      },
      '2013' =>
      {
        ORDINAL => 11,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-10-21',
            DATE_END => '2013-10-25'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-26'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-27'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 12,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-21'
          } 
        }
      },
      '2019' =>
      {
        CITY => 'Medellin',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-15',
            DATE_END => '2019-11-15'
          },
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-29'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-29'
          },
        }
      },
    }
  },

  'Bolivian Transnational Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-30'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BOLIVIA, \%TOURNAMENTS_BOLIVIA, 'Bolivia');
}

1;
