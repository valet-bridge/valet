#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::HongKong;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'HKCBA',
  COUNTRY => 'Hong Kong',
  ZONE => 'South East Asia',
);

my %MEETS_HONGKONG =
(
  'Hong Kong Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2020A' =>
      {
        YEAR => 2020,
        DATE_START => '2020-02-09',
        DATE_END => '2020-02-16'
      },
      '2020B' =>
      {
        YEAR => 2020,
        DATE_START => '2020-03-07',
        DATE_END => '2020-03-08'
      },
      '2020C' =>
      {
        YEAR => 2020,
        DATE_START => '2020-11-28',
        DATE_END => '2020-11-29'
      },
      '2021A' =>
      {
        YEAR => 2021,
        DATE_START => '2021-01-21',
        DATE_END => '2021-01-24'
      },
      '2021B' =>
      {
        YEAR => 2021,
        DATE_START => '2021-01-30',
        DATE_END => '2021-01-31'
      },
    }
  },
);

my %TOURNAMENTS_HONGKONG =
(
  'Hong Kong Inter-City Open Teams' => 
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
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
            groupon => 'SECTION',
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
            major => 'SEGMENT|ROUND',
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
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-26',
            DATE_END => '2017-07-30'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-17',
            DATE_END => '2018-07-21'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-07-17',
            DATE_END => '2019-07-21'
          },
        }
      },
    }
  },

  'Hong Kong Inter-City Women Teams' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
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
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-07-21',
            DATE_END => '2019-07-21'
          } 
        }
      },
    }
  },

  'Hong Kong Mixed Team Trials' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        MEET => 'Hong Kong Trials',
        MEET_TAG => '2020B',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-03-07',
            DATE_END => '2020-03-08'
          },
        }
      },
      '2021' =>
      {
        MEET => 'Hong Kong Trials',
        MEET_TAG => '2021A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            DATE_START => '2021-01-21',
            DATE_END => '2021-01-24'
          },
        }
      },
    }
  },

  'Hong Kong New Year Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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

  'Hong Kong Open Team Trials' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020A' =>
      {
        MEET => 'Hong Kong Trials',
        MEET_TAG => '2020A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-02-09',
            DATE_END => '2020-02-16'
          },
        }
      },
      '2020B' =>
      {
        MEET => 'Hong Kong Trials',
        MEET_TAG => '2020C',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-11-28',
            DATE_END => '2020-11-29'
          },
        }
      },
    }
  },

  'Hong Kong Senior Team Trials' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2021' =>
      {
        MEET => 'Hong Kong Trials',
        MEET_TAG => '2021B',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            DATE_START => '2021-01-30',
            DATE_END => '2021-01-31'
          },
        }
      },
    }
  },

  'Rose Bowl' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-07-23',
            DATE_END => '2024-07-23'
          },
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
