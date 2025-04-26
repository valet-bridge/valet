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
      '2019' =>
      {
        MEET_ORDINAL => 4,
        YEAR => 2019,
        DATE_START => '2019-11-09',
        DATE_END => '2019-11-16'
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
      '2018A' =>
      {
        YEAR => 2018,
        DATE_START => '2018-10-17',
        DATE_END => '2018-10-24'
      },
      '2018B' =>
      {
        YEAR => 2018,
        DATE_START => '2018-11-14',
        DATE_END => '2018-11-21'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-08-10',
        DATE_END => '2019-08-15'
      },
    }
  },

  'Chinese Team Championships' =>
  {
    EDITIONS =>
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-04-15',
        DATE_END => '2007-04-16'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-05-07',
        DATE_END => '2019-05-12'
      },
    }
  },

  'Chinese University Championships' =>
  {
    EDITIONS =>
    {
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-07-23',
        DATE_END => '2018-07-29'
      },
    }
  },

  'Hainan Bridge Festival' =>
  {
    # TODO Same as Sanya Bridge Festival?
    %GLOBAL,
    ORIGIN => 'Transnational',
    REGION => 'Hainan',

    EDITIONS =>
    {
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-10-22',
        DATE_END => '2016-11-02'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-10-28',
        DATE_END => '2017-11-11'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-10-26',
        DATE_END => '2018-11-09'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-29',
        DATE_END => '2019-10-13'
      },
    }
  },

  'JPD Cup' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-03-29',
        DATE_END => '2006-03-31'
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

  'Beibu Gulf Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' =>
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-12-06',
            DATE_END => '2018-12-07'
          },
          'C1' =>
          {
            YEAR => 2018,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-12-07',
            DATE_END => '2018-12-07'
          },
          'C2' =>
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-07',
            DATE_END => '2018-12-08'
          },
          'C3' =>
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-08',
            DATE_END => '2018-12-08'
          },
          'C4' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-08',
            DATE_END => '2018-12-09'
          },
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

  'China Elite Winter Junior Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'China Elite Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-10',
            DATE_END => '2019-11-12'
          } 
        }
      },
    }
  },

  'China Elite Winter Mixed Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'China Elite Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-09',
            DATE_END => '2019-11-10'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-10',
            DATE_END => '2019-11-10'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Bronze',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-11-11',
            DATE_END => '2019-11-11'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-11',
            DATE_END => '2019-11-11'
          } 
        }
      },
    }
  },

  'China Elite Winter U26 Women Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'China Elite Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-10',
            DATE_END => '2019-11-12'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-13',
            DATE_END => '2019-11-13'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-13',
            DATE_END => '2019-11-14'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            DATE_START => '2019-11-14',
            DATE_END => '2019-11-15'
          },
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
      '2019' =>
      {
        MEET => 'China Elite Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-11',
            DATE_END => '2019-11-13'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-14',
            DATE_END => '2019-11-14'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-14',
            DATE_END => '2019-11-14'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-15',
            DATE_END => '2019-11-16'
          },
        }
      },
    }
  },

  'China Elite Winter Women Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'China Elite Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-11',
            DATE_END => '2019-11-13'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-15',
            DATE_END => '2019-11-16'
          },
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-20'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-20'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
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
    ORIGIN => 'International',
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
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-01'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-01'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-08-02',
            DATE_END => '2015-08-02'
          } 
        }
      },
      '2024' =>
      {
        SPONSOR => 'Geely Automobile',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2024-08-07',
            DATE_END => '2024-08-08'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2024-08-09',
            DATE_END => '2024-08-09'
          },
          'C2' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-08-10',
            DATE_END => '2024-08-10'
          },
          'C3' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-08-11',
            DATE_END => '2024-08-11'
          },
        }
      },
    }
  },

  'Chinese Inter-City Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        SPONSOR => 'Geely Automobile',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-08-09',
            DATE_END => '2024-08-09'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-08-10',
            DATE_END => '2024-08-10'
          },
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
            major => 'ROUND',
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
      '2018A' =>
      {
        MEET => 'Chinese Club Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-10-17',
            DATE_END => '2018-10-21'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-10-21',
            DATE_END => '2018-10-21'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-10-23',
            DATE_END => '2018-10-24'
          },
        }
      },
      '2018B' =>
      {
        MEET => 'Chinese Club Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2018-11-14',
            DATE_END => '2018-11-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-16'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          },
          'C3' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-19',
            DATE_END => '2018-11-19'
          },
          'C4' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-20',
            DATE_END => '2018-11-21'
          },
        }
      },
      '2019A' =>
      {
        # Really second league.
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-09'
          },
        }
      },
      '2019B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2019-12-12',
            DATE_END => '2019-12-13'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-12-13',
            DATE_END => '2019-12-14'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-12-15',
            DATE_END => '2019-12-16'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-12-16',
            DATE_END => '2019-12-17'
          },
          'C4' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-12-18',
            DATE_END => '2019-12-19'
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

  'Chinese Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            ignore => 'GROUP',
            DATE_START => '2019-01-12',
            DATE_END => '2019-01-13'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-01-14',
            DATE_END => '2019-01-15'
          },
          'C2' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-01-16',
            DATE_END => '2019-01-17'
          },
          'C3' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-01-18',
            DATE_END => '2019-01-19'
          },
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
        MEET => 'Chinese Team Championships',
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
      '2019' =>
      {
        MEET => 'Chinese Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Rof16',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-05-09',
            DATE_END => '2019-05-09'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-05-10',
            DATE_END => '2019-05-10'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-05-11',
            DATE_END => '2019-05-11'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-05-12',
            DATE_END => '2019-05-12'
          },
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
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Knock-out',
            major => 'ROUND',
            DATE_START => '2019-12-07',
            DATE_END => '2019-12-07'
          } 
        }
      },
    }
  },

  'Chinese University U26 Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Chinese University Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2018-07-23',
            DATE_END => '2018-07-29'
          },
        }
      },
    }
  },

  'Chinese University U26 Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Chinese University Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2018-07-23',
            DATE_END => '2018-07-29'
          },
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
      '2018' =>
      {
        MEET => 'Chinese Club Championships',
        MEET_TAG => '2018A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-10-22',
            DATE_END => '2018-10-22'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Chinese Club Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-08-10',
            DATE_END => '2019-08-12'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-08-13',
            DATE_END => '2019-08-13'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-08-14',
            DATE_END => '2019-08-15'
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
        MEET => 'Chinese Team Championships',
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
      '2019' =>
      {
        MEET => 'Chinese Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-05-07',
            DATE_END => '2019-05-07'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-05-07',
            DATE_END => '2019-05-07'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-05-08',
            DATE_END => '2019-05-08'
          },
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
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-11-12',
            DATE_END => '2006-11-12'
          },
          'C1' => 
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

  'G60 Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-04-15',
            DATE_END => '2019-04-18'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-04-19',
            DATE_END => '2019-04-19'
          },
          'C2' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-04-20',
            DATE_END => '2019-04-21'
          },
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

  'Guang Qing Memorial Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND',
            DATE_START => '2018-07-14',
            DATE_END => '2018-07-15'
          },
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
            major => 'ROUND',
            DATE_START => '2011-08-20',
            DATE_END => '2011-08-21'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-10',
            DATE_END => '2011-09-11'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-09-20',
            DATE_END => '2011-09-20'
          },
          'C3' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
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

  'HNA Mixed Teams' =>
  {
    SPONSOR => 'Hainan Air',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2017-11-06',
            DATE_END => '2017-11-07'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-11-08',
            DATE_END => '2017-11-08'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-11-08',
            DATE_END => '2017-11-08'
          },
          'C3' => 
          {
            YEAR => 2017,
            STAGE => 'Bronze',
            DATE_START => '2017-11-10',
            DATE_END => '2017-11-10'
          },
          'C4' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-11-11',
            DATE_END => '2017-11-11'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-11-03',
            DATE_END => '2018-11-05'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-05',
            DATE_END => '2018-11-05'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-06',
            DATE_END => '2018-11-06'
          },
          'C3' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-07',
            DATE_END => '2018-11-08'
          },
        }
      },
    }
  },

  'HNA Open Teams' =>
  {
    # TODO Could be at Sanya Bridge Festival
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
            major => 'SEGMENT|ROUND',
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
      '2016' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-10-22',
            DATE_END => '2016-10-23'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-10-24',
            DATE_END => '2016-10-24'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-24',
            DATE_END => '2016-10-25'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-25',
            DATE_END => '2016-10-26'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2016-10-26',
            DATE_END => '2016-10-26'
          },
          'C5' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-10-27',
            DATE_END => '2016-10-27'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-29'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2017-10-30',
            DATE_END => '2017-10-30'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2017-10-30',
            DATE_END => '2017-10-30'
          },
          'C3' => 
          {
            YEAR => 2017,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-10-31',
            DATE_END => '2017-10-31'
          },
          'C4' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-10-31',
            DATE_END => '2017-11-01'
          },
          'C5' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-11-01',
            DATE_END => '2017-11-01'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-10-26',
            DATE_END => '2018-10-27'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-10-28',
            DATE_END => '2018-10-28'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-10-29',
            DATE_END => '2018-10-29'
          },
          'C3' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-10-29',
            DATE_END => '2018-10-29'
          },
          'C4' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-10-30',
            DATE_END => '2018-10-30'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-09-30',
            DATE_END => '2019-10-01'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2019-10-02',
            DATE_END => '2019-10-02'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-03',
            DATE_END => '2019-10-03'
          },
          'C3' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-10-04',
            DATE_END => '2019-10-04'
          },
        }
      },
    }
  },

  'HNA Swiss Teams' =>
  {
    # TODO Could be at Sanya Bridge Festival
    SPONSOR => 'Hainan Air',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2019-10-05',
            DATE_END => '2019-10-05'
          },
        }
      }
    }
  },

  'Jia-Wei Memorial Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND',
            DATE_START => '2018-12-08',
            DATE_END => '2018-12-08'
          },
        }
      },
    }
  },

  'Jiangsu Province Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Chinese Club Championships',
        MEET_TAG => '2018B',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-11-16',
            DATE_END => '2018-11-17'
          },
          'C1' =>
          {
            YEAR => 2018,
            STAGE => 'Relegation',
            major => 'SEGMENT',
            DATE_START => '2018-11-18',
            DATE_END => '2018-11-18'
          },
          'C2' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-19',
            DATE_END => '2018-11-19'
          },
        }
      },
      '2019' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-10-17',
            DATE_END => '2019-10-19'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-19',
            DATE_END => '2019-10-19'
          },
          'C2' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-10-19',
            DATE_END => '2019-10-20'
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

  'JPD Open Cup' =>
  {
    %GLOBAL,
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'JPD Cup',
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

  'JPD Women Cup' =>
  {
    %GLOBAL,
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'JPD Cup',
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

  'Nanshan Mixed Teams Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
          },
          'C1' =>
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-31',
            DATE_END => '2016-10-31'
          },
          'C2' =>
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-10-31',
            DATE_END => '2016-10-31'
          },
          'C3' =>
          {
            YEAR => 2016,
            STAGE => 'Bronze',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-11-02',
            DATE_END => '2016-11-02'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-09',
            DATE_END => '2018-11-09'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-10-09',
            DATE_END => '2019-10-10'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Rof16',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-10-11',
            DATE_END => '2019-10-11'
          },
          'C2' =>
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-12',
            DATE_END => '2019-10-12'
          },
          'C3' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-12',
            DATE_END => '2019-10-12'
          },
          'C4' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-10-13',
            DATE_END => '2019-10-13'
          },
        }
      },
    }
  },

  'Nanshan Open Teams Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-09',
            DATE_END => '2018-11-09'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Hainan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-10-06',
            DATE_END => '2019-10-08'
          },
        }
      },
    }
  },

  'Ruihai Shuicheng Senior Teams' =>
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
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-11-03',
            DATE_END => '2016-11-05'
          },
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

  'Shanqing Mountain Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        ORDINAL => 4,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2018-11-29',
            DATE_END => '2018-11-30'
          },
          'C1' =>
          {
            YEAR => 2018,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-11-30',
            DATE_END => '2018-11-30'
          },
          'C2' =>
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-01',
            DATE_END => '2018-12-01'
          },
          'C3' =>
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-01',
            DATE_END => '2018-12-01'
          },
          'C4' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-01',
            DATE_END => '2018-12-02'
          },
        }
      },
      '2019' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2019-11-21',
            DATE_END => '2019-11-22'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-22'
          },
          'C2' =>
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-23'
          },
          'C3' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-23'
          },
          'C4' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-24'
          },
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
            major => 'ROUND',
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
            groupon => 'GROUP',
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
            major => 'ROUND',
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
