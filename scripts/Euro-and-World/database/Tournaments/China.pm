#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::China;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# No real results, but confirmation of dates and locations:
# https://www.ccba.org.cn/Tour/HistoryList.aspx

my %MEETS_CHINA =
(
  'All China Games' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',

    EDITIONS => 
    {
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-27',
        DATE_END => '2006-05-27'
      },
    }
  }
);

my %TOURNAMENTS_CHINA =
(
  'All-China Mixed Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'All China Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          } 
        }
      },
    }
  },

  'All-China Open Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'All China Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-05-26',
            DATE_END => '2006-05-26'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-27',
            DATE_END => '2006-05-27'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-29',
            DATE_END => '2006-05-29'
          } 
        }
      },
    }
  },

  'All-China Women Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'All China Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-27',
            DATE_END => '2006-05-27'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          } 
        }
      },
    }
  },

  'Aoda Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          } 
        }
      },
    }
  },

  'China Elite Tournament' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011A' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-02-19',
            DATE_END => '2011-02-21'
          } 
        }
      },
      '2011B' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-05-26',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2012A' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-03-22',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2012B' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-18',
            DATE_END => '2012-06-20'
          } 
        }
      },
      '2012C' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-11-16',
            DATE_END => '2012-11-18'
          } 
        }
      },
      '2013A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-22',
            DATE_END => '2013-03-24'
          } 
        }
      },
      '2013B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-31',
            DATE_END => '2013-06-02'
          } 
        }
      },
      '2013C' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-11-07',
            DATE_END => '2013-11-10'
          } 
        }
      },
      '2014A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-07',
            DATE_END => '2014-04-07'
          } 
        }
      },
      '2014B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-08'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-28'
          } 
        }
      },
      '2015B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-08'
          } 
        }
      },
    }
  },

  'China Friend City Senior Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-19'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-20'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-20'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-21'
          } 
        }
      },
    }
  },

  'China Hosts Europe in Rome' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'Italy',
    CITY => 'Rome',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            DATE_START => '2009-04-17',
            DATE_END => '2009-04-18'
          } 
        }
      },
    }
  },

  'Chinese Inter-City Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-18',
            DATE_END => '2009-08-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-12',
            DATE_END => '2009-08-22'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-12',
            DATE_END => '2009-08-22'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-22',
            DATE_END => '2009-08-23'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-08-11',
            DATE_END => '2010-08-13'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-14'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-15'
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
            major => 'ROUND',
            DATE_START => '2011-08-02',
            DATE_END => '2011-08-07'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-08-01',
            DATE_END => '2012-08-03'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-03',
            DATE_END => '2012-08-03'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-04',
            DATE_END => '2012-08-04'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-05',
            DATE_END => '2012-08-05'
          } 
        }
      },
    }
  },

  'Chinese First League' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-06'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C4' => 
          {
            YEAR => 2006,
            DATE_START => '2006-10-04',
            DATE_END => '2006-10-04'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-07-03',
            DATE_END => '2007-07-08'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-11-29',
            DATE_END => '2012-11-30'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-01',
            DATE_END => '2012-12-02'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-03',
            DATE_END => '2012-12-03'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-04',
            DATE_END => '2012-12-04'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-23',
            DATE_END => '2013-10-24'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-24',
            DATE_END => '2013-10-25'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-26'
          },
        }
      },
    }
  },

  'Chinese Mixed Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            DATE_START => '2011-05-29',
            DATE_END => '2011-05-29'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-29',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-08-13',
            DATE_END => '2015-08-14'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-15'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-16'
          } 
        }
      },
    }
  },

  'Chinese Open Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-04-15',
            DATE_END => '2007-04-15'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
    }
  },

  'Chinese Open Trials' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'SEGMENT',
            DATE_START => '2008-05-14',
            DATE_END => '2008-05-14'
          } 
        }
      },
    }
  },

  'Chinese Women Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-12',
            DATE_END => '2014-04-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-16',
            DATE_END => '2014-04-16'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-17',
            DATE_END => '2014-04-18'
          } 
        }
      },
    }
  },

  'Chung Hua Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'SEGMENT',
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-19'
          } 
        }
      },
    }
  },

  'Cross Strait Invitational' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-11-12',
            DATE_END => '2006-11-12'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          } 
        }
      },
    }
  },

  'Dongfeng Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          } 
        }
      },
    }
  },

  'Dongming Knock-out Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          } 
        }
      },
    }
  },

  'GHTD Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2005-12-09',
            DATE_END => '2005-12-09'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          } 
        }
      },
    }
  },

  'Guangdong Club Championship' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-20',
            DATE_END => '2011-08-21'
          },
          'C1' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-10',
            DATE_END => '2011-09-11'
          },
          'C2' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-20',
            DATE_END => '2011-09-20'
          },
          'C3' => 
          {
            YEAR => 2011,
            DATE_START => '2011-10-07',
            DATE_END => '2011-10-07'
          } 
        }
      },
    }
  },

  'Guangdong Elite Tournament' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'ROUND',
            DATE_START => '2011-05-01',
            DATE_END => '2011-05-02'
          } 
        }
      },
    }
  },

  'Guangzhou-HK-Macau Interport' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            major => 'ROUND',
            DATE_START => '2016-07-23',
            DATE_END => '2016-07-24'
          } 
        }
      },
    }
  },

  'Haikou Fitness Day' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-01'
          } 
        }
      },
    }
  },

  'High-Tech Zone Workers Invitational' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-02'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-02',
            DATE_END => '2013-11-02'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-02',
            DATE_END => '2013-11-03'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-03',
            DATE_END => '2013-11-03'
          } 
        }
      },
    }
  },

  'HNA Open Teams' =>
  {
    ORGANIZATION => 'CCBA',
    SPONSOR => 'Hainan Air',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-10-12',
            DATE_END => '2011-10-16'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2012-10-18',
            DATE_END => '2012-10-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2012-10-20',
            DATE_END => '2012-10-21'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-09-05',
            DATE_END => '2013-09-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-09-09',
            DATE_END => '2013-09-09'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-10-16',
            DATE_END => '2014-10-17'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-10-07',
            DATE_END => '2015-10-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-09'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-10'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-10'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-11'
          },
        }
      },
    }
  },

  'Jianshe Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-14',
            DATE_END => '2009-06-14'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-15',
            DATE_END => '2009-06-15'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-15',
            DATE_END => '2009-06-16'
          } 
        }
      },
    }
  },

  'Jili Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'ROUND',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-20'
          } 
        }
      },
    }
  },

  'JPD Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-03-29',
            DATE_END => '2006-03-29'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            DATE_START => '2006-03-30',
            DATE_END => '2006-03-30'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-03-31',
            DATE_END => '2006-03-31'
          } 
        }
      },
    }
  },

  'Mountain Sea Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    CITY => 'Xiamen',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-01-11',
            DATE_END => '2014-01-12'
          } 
        }
      },
    }
  },

  'Sanchen Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          } 
        }
      },
    }
  },

  'Sanya Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-08-19',
            DATE_END => '2007-08-19'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-08-19',
            DATE_END => '2007-08-19'
          } 
        }
      },
    }
  },

  'Shenhua Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            STAGE => 'Bronze',
            DATE_START => '2006-06-20',
            DATE_END => '2006-06-20'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-06-20',
            DATE_END => '2006-06-20'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          }
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            DATE_START => '2009-05-02',
            DATE_END => '2009-05-02'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-05-03',
            DATE_END => '2009-05-03'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-03',
            DATE_END => '2009-05-03'
          } 
        }
      },
    }
  },

  'Shenyang Spring Teams' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    CITY => 'Shenyang',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-03-29',
            DATE_END => '2009-03-29'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-29',
            DATE_END => '2009-03-29'
          } 
        }
      },
    }
  },

  'Shenzhen Lanpu Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    CITY => 'Shenzhen',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          } 
        }
      },
    }
  },

  'Shenzhen Nangangdongli Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    CITY => 'Shenzhen',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2011-10-02',
            DATE_END => '2011-10-04'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-04',
            DATE_END => '2011-10-05'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-05',
            DATE_END => '2011-10-05'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-05',
            DATE_END => '2011-10-06'
          },
        }
      },
    }
  },

  'Sunchime Fund Cup' =>
  {
    # Could be an Elite tournament.
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-10-02',
            DATE_END => '2012-10-04'
          } 
        }
      },
    }
  },

  'Tielu Jixie Invitational' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        CITY => 'Jixiexiang',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          } 
        }
      },
    }
  },

  'Xinyuan Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-06-11',
            DATE_END => '2010-06-13'
          } 
        }
      },
    }
  },

  'Zhejiang Huamen Cup' =>
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-06',
            DATE_END => '2011-09-09'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CHINA, \%TOURNAMENTS_CHINA, 'China');
}

1;
