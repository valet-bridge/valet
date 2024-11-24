#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::HongKong;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_HONGKONG =
(
);

my %TOURNAMENTS_HONGKONG =
(
  'Hong Kong Inter-City Open Teams' => 
  {
    ORGANIZATION => 'HKCBA',
    COUNTRY => 'Hong Kong',
    ORIGIN => 'National',
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-12',
            DATE_END => '2006-08-12'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-12',
            DATE_END => '2006-08-12'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-12',
            DATE_END => '2006-08-13'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2007-08-27',
            DATE_END => '2007-08-27'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-08-11',
            DATE_END => '2008-08-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-07-30',
            DATE_END => '2014-07-31'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-01',
            DATE_END => '2014-08-01'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-02',
            DATE_END => '2014-08-03'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-03',
            DATE_END => '2014-08-03'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-07-27',
            DATE_END => '2016-07-28'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-29',
            DATE_END => '2016-07-29'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-31',
            DATE_END => '2016-07-31'
          } 
        }
      },
    }
  },

  'Hong Kong Inter-City Women Teams' => 
  {
    ORGANIZATION => 'HKCBA',
    COUNTRY => 'Hong Kong',
    ORIGIN => 'National',
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          } 
        }
      },
    }
  },

  'Hong Kong New Year Teams' =>
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'Hong Kong',
    ORIGIN => 'National',
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-16',
            DATE_END => '2012-12-16'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-16',
            DATE_END => '2012-12-16'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_HONGKONG, \%TOURNAMENTS_HONGKONG, 'Hong Kong');
}

1;
