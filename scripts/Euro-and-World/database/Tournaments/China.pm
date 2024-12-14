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

my %GLOBAL = (
  ORGANIZATION => 'CCBA',
  COUNTRY => 'China',
  ZONE => 'South East Asia',
);

my %MEETS_CHINA =
(
  'All China Games' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2006' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2006,
        DATE_START => '2006-05-26',
        DATE_END => '2006-05-29'
      },
    }
  },

  'China Elite Tournament' =>
  {
    %GLOBAL,

    EDITIONS =>
    {
      '2011A' =>
      {
        MEET_ORDINAL => 1,
        CITY => 'Beijing',
        YEAR => 2011,
        DATE_START => '2011-02-19',
        DATE_END => '2011-02-21'
      },
      '2011B' =>
      {
        MEET_ORDINAL => 2,
        CITY => 'Beijing',
        YEAR => 2011,
        DATE_START => '2011-05-26',
        DATE_END => '2011-05-29'
      },
      '2011C' =>
      {
        MEET_ORDINAL => 3,
        CITY => 'Beijing',
        YEAR => 2011,
        DATE_START => '2011-09-06',
        DATE_END => '2011-09-09'
      },
      '2012A' =>
      {
        MEET_ORDINAL => 5,
        CITY => 'Beijing',
        YEAR => 2012,
        DATE_START => '2012-03-22',
        DATE_END => '2012-03-25'
      },
      '2012B' =>
      {
        MEET_ORDINAL => 6,
        CITY => 'Beijing',
        YEAR => 2012,
        DATE_START => '2012-06-18',
        DATE_END => '2012-06-20'
      },
      '2012C' =>
      {
        MEET_ORDINAL => 8,
        CITY => 'Beijing',
        YEAR => 2012,
        DATE_START => '2012-11-16',
        DATE_END => '2012-11-18'
      },
      '2013A' =>
      {
        MEET_ORDINAL => 9,
        YEAR => 2013,
        DATE_START => '2013-03-22',
        DATE_END => '2013-03-24'
      },
      '2013B' =>
      {
        MEET_ORDINAL => 10,
        YEAR => 2013,
        DATE_START => '2013-05-31',
        DATE_END => '2013-06-02'
      },
      '2013C' =>
      {
        MEET_ORDINAL => 11,
        YEAR => 2013,
        DATE_START => '2013-11-07',
        DATE_END => '2013-11-10'
      },
      '2014A' =>
      {
        MEET_ORDINAL => 12,
        YEAR => 2014,
        DATE_START => '2014-04-07',
        DATE_END => '2014-04-07'
      },
      '2014B' =>
      {
        MEET_ORDINAL => 13,
        YEAR => 2014,
        DATE_START => '2014-08-05',
        DATE_END => '2014-08-08'
      },
      '2015A' =>
      {
        MEET_ORDINAL => 15,
        YEAR => 2015,
        DATE_START => '2015-04-25',
        DATE_END => '2015-04-28'
      },
      '2015B' =>
      {
        MEET_ORDINAL => 17,
        YEAR => 2015,
        DATE_START => '2015-11-06',
        DATE_END => '2015-11-08'
      },
    }
  },

  'Chinese Club Championships' =>
  {
    EDITIONS => 
    {
      '2006A' =>
      {
        YEAR => 2006,
        DATE_START => '2006-07-02',
        DATE_END => '2006-07-06'
      },
      '2006B' =>
      {
        YEAR => 2006,
        DATE_START => '2006-08-09',
        DATE_END => '2006-08-09'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-10-19',
        DATE_END => '2013-10-26'
      },
    }
  },

);

my %TOURNAMENTS_CHINA =
(
  'All-China Mixed Teams' =>
  {
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CITY => 'Shenyang',
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

  'China Elite Spring Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2011A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-02-19',
            DATE_END => '2011-02-21'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2012A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-03-22',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2013A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-22',
            DATE_END => '2013-03-24'
          } 
        }
      },
    }
  },

  'China Elite Winter Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2012C',
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
      '2013' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2013C',
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
      '2015' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2015B',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        ORDINAL => 27,
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
    ZONE => 'Europe',
    ORIGIN => 'National',
    CITY => 'Rome',
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
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-18',
            DATE_END => '2009-08-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-22',
            DATE_END => '2009-08-22'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-22',
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
            MOVEMENT => 'Round-robin',
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
        SPONSOR => 'L&Y Law',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2011-08-02',
            DATE_END => '2011-08-04'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-08-04',
            DATE_END => '2011-08-05'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-05',
            DATE_END => '2011-08-06'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-06',
            DATE_END => '2011-08-06'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-06',
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
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-07-29',
            DATE_END => '2015-07-31'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-01'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-01'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-02',
            DATE_END => '2015-08-02'
          } 
        }
      },
    }
  },

  'Chinese First League' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006A' =>
      {
        MEET => 'Chinese Club Championships',
        CITY => 'Xian',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-06'
          },
        }
      },
      '2006B' =>
      {
        MEET => 'Chinese Club Championships',
        CITY => 'Xian',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
        }
      },
      '2006C' =>
      {
        # TODO Something else?
        CITY => 'Xiantao',
        CHAPTERS =>
        {
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
        # TODO Something else?
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
        MEET => 'Chinese Club Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
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
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CITY => 'Shenyang',
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

  'Chinese Women First League' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Chinese Club Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-23',
            DATE_END => '2013-10-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-24',
            DATE_END => '2013-10-25'
          },
          'C2' => 
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

  'Chinese Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            MOVEMENT => 'Round-robin',
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
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        ORDINAL => 1,
        CITY => 'Kunshan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Round-robin',
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
        ORDINAL => 1,
        CITY => 'Taicang',
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
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CITY => 'Shanghai',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          } 
        }
      },
    }
  },

  'GHTD Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
    CLUB => 'Guangdong Club',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        ORDINAL => 3,
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
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
    SPONSOR => 'Hainan Air',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        ORDINAL => 3,
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
        ORDINAL => 4,
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
        ORDINAL => 5,
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
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-20'
          } 
        }
      },
    }
  },

  'Jinfan Open Teams Cup' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2011B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-05-26',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-18',
            DATE_END => '2012-06-20'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-31',
            DATE_END => '2013-06-02'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2014A',
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
      '2015' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2015A',
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
    }
  },

  'Jinfan Mixed Teams Cup' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2011B',
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
    }
  },

  'JPD Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
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
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Xiamen',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CITY => 'Beijing',
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
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Beijing',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        ORDINAL => 2,
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
        ORDINAL => 3,
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
        ORDINAL => 4,
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
        ORDINAL => 5,
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
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Shenyang',
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
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Shenzhen',
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
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Shenzhen',
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
            MOVEMENT => 'Round-robin',
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
    %GLOBAL,
    ORIGIN => 'Transnational',
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

  'Vanke Open Teams Cup' =>
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
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-07-13',
            DATE_END => '2012-07-14'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-14'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-15'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-15',
            DATE_END => '2012-07-15'
          } 
        }
      },
    }
  },

  'Xinyuan Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
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
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2011C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            DATE_START => '2011-09-06',
            DATE_END => '2011-09-09'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'China Elite Tournament',
        MEET_TAG => '2014B',
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
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CHINA, \%TOURNAMENTS_CHINA, 'China');
}

1;
