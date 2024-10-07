#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Turkey;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_TURKEY =
(
  'Turkish Open Trials' =>
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-04',
        DATE_END => '2010-04-09'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-21',
        DATE_END => '2011-10-23'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-07-11',
        DATE_END => '2012-07-13'
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        YEAR => 2016,
        DATE_START => '2016-07-01',
        DATE_END => '2016-07-03'
      },
    }
  },

  'Turkish Women Trials' =>
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-05',
        DATE_END => '2010-04-08'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-21',
        DATE_END => '2011-10-23'
      },
    }
  },
);

my %TOURNAMENTS_TURKEY =
(
  'Ankara Summer Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-06-17',
            DATE_END => '2012-06-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-06-24',
            DATE_END => '2012-06-24'
          },
          'C2' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-07-01',
            DATE_END => '2012-07-01'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-17',
            DATE_END => '2016-08-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-18',
            DATE_END => '2016-08-19'
          } 
        }
      },
    }
  },

  'Goksu-Yalikavak Pairs',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2009-07-17',
            DATE_END => '2009-07-18'
          } 
        }
      },
    }
  },

  'Istanbul Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'SEGMENT',
            DATE_START => '2006-02-13',
            DATE_END => '2006-02-13'
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
            DATE_START => '2010-02-20',
            DATE_END => '2010-02-21'
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
            major => 'ROUND',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-12'
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
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-01'
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
            major => 'ROUND',
            DATE_START => '2016-06-04',
            DATE_END => '2016-06-05'
          } 
        }
      },
    }
  },

  'Istanbul Winter Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            major => 'SEGMENT',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
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
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-20'
          } 
        }
      },
      '2015' =>
      {

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-31'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          } 
        }
      },
    }
  },

  'Izmir Teams Cup',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'ROUND',
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-09-22',
            DATE_END => '2009-09-22'
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
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-01-25',
            DATE_END => '2015-01-25'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-02-07',
            DATE_END => '2016-02-07'
          } 
        }
      },
    }
  },

  'Murat Kilercioglu Turkish Spring Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2011-04-28',
            DATE_END => '2011-04-28'
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
            DATE_START => '2012-04-30',
            DATE_END => '2012-04-30'
          } 
        }
      },
    }
  },

  'Necmettin Sunget Teams Cup',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-11'
          } 
        }
      },
    }
  },

  'Turkish Club Championship',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2009
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2009
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-31',
            DATE_END => '2009-08-02'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-08-02',
            DATE_END => '2009-08-03'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-03',
            DATE_END => '2009-08-04'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-04',
            DATE_END => '2009-08-04'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-05',
            DATE_END => '2009-08-05'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2010
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-08-27',
            DATE_END => '2010-08-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-29'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-29',
            DATE_END => '2010-08-30'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-30',
            DATE_END => '2010-08-30'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-31',
            DATE_END => '2010-08-31'
          } 
        }
      },
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2011
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-08-19',
            DATE_END => '2011-08-20'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-08-20',
            DATE_END => '2011-08-21'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-21',
            DATE_END => '2011-08-22'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-22',
            DATE_END => '2011-08-22'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-23',
            DATE_END => '2011-08-23'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2012
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=9&year=2012
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-08-30',
            DATE_END => '2012-08-31'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-08-31',
            DATE_END => '2012-09-01'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-02'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-03',
            DATE_END => '2012-09-03'
          } 
        }
      },
      '2013' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2013
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-19',
            DATE_END => '2013-02-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-14'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2013-08-24',
            DATE_END => '2013-08-25'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-08-25',
            DATE_END => '2013-08-26'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-08-26',
            DATE_END => '2013-08-27'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-27',
            DATE_END => '2013-08-28'
          },
          'C6' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-28',
            DATE_END => '2013-08-28'
          },
          'C7' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-29',
            DATE_END => '2013-08-29'
          } 
        }
      },
      '2014' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2014
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-08-03',
            DATE_END => '2014-08-04'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-05'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-06'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-06',
            DATE_END => '2014-08-07'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-07',
            DATE_END => '2014-08-07'
          },
          'C6' => 
          {
            YEAR => 2014,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-08'
          },
          'C7' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-08'
          } 
        }
      },
      '2015' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2015
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-17',
            DATE_END => '2015-05-19'
          },
          'C1' => 
          {
            # TODO Got to here from above
            YEAR => 2015,
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-27'
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
            DATE_START => '2016-06-05',
            DATE_END => '2016-06-05'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-26',
            DATE_END => '2016-08-28'
          } 
        }
      },
    }
  },

  'Turkish East Mediterranean Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-25',
            DATE_END => '2013-05-26'
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
            DATE_START => '2014-06-28',
            DATE_END => '2014-06-29'
          } 
        }
      },
    }
  },

  'Turkish Junior Pairs',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2012
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-03'
          } 
        }
      },
    }
  },

  'Turkish Mixed Team Trials',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'Turkish Mixed Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2012
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-19',
            DATE_END => '2012-12-21'
          } 
        }
      },
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2013
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-18',
            DATE_END => '2013-12-20'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-12'
          } 
        }
      },
    }
  },

  'Turkish Open Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2009
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-26',
            DATE_END => '2009-04-30'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-06'
          } 
        }
      },
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2011
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-10',
            DATE_END => '2011-05-12'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2012
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-08',
            DATE_END => '2012-05-10'
          } 
        }
      },
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2013
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2013-05-07',
            DATE_END => '2013-05-08'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-04',
            DATE_END => '2014-05-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2015
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-05-04',
            DATE_END => '2015-05-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2015-05-07',
            DATE_END => '2015-05-07'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2016
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-05-02',
            DATE_END => '2016-05-02'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2016-05-03',
            DATE_END => '2016-05-03'
          } 
        }
      },
    }
  },

  'Turkish Open Pair Trials',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
      '2010' =>
      {
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-04-04',
            DATE_END => '2010-04-09'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-01',
            DATE_END => '2016-07-03'
          } 
        }
      },
    }
  },

  'Turkish Open Team Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=10&year=2011
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-21',
            DATE_END => '2011-10-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-22',
            DATE_END => '2011-10-23'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2012
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-11',
            DATE_END => '2012-07-12'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-12',
            DATE_END => '2012-07-13'
          } 
        }
      },
    }
  },

  'Turkish Women Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2009
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-25',
            DATE_END => '2009-04-30'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2010
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-06'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-06',
            DATE_END => '2014-05-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-07',
            DATE_END => '2015-05-07'
          } 
        }
      },
    }
  },

  'Turkish Swiss Mixed Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    MOVEMENT => 'Swiss',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-12-16',
            DATE_END => '2015-12-18'
          } 
        }
      },
    }
  },

  'Turkish U16 Pairs',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-02',
            DATE_END => '2016-07-02'
          } 
        }
      },
    }
  },

  'Turkish University Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-30',
            DATE_END => '2012-03-30'
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
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-28'
          } 
        }
      },
    }
  },

  'Turkish Winter Open Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2013-02-19',
            DATE_END => '2013-02-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2014
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2014-03-03',
            DATE_END => '2014-03-03'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-03-03',
            DATE_END => '2014-03-04'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-03-04',
            DATE_END => '2014-03-05'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-05',
            DATE_END => '2014-03-05'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-06'
          },
          'C6' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-06'
          },
          'C7' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2015
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-28',
            DATE_END => '2015-03-07'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2016
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-09',
            DATE_END => '2016-03-12'
          } 
        }
      },
    }
  },

  'Turkish Winter Women Teams',
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2013
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-23',
            DATE_END => '2013-02-24'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-21',
            DATE_END => '2014-02-23'
          } 
        }
      },
    }
  },

  'Turkish Women Pair Trials',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-04-05',
            DATE_END => '2010-04-08'
          } 
        }
      },
    }
  },

  'Turkish Women Team Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=10&year=2011
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-21',
            DATE_END => '2011-10-22'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-22',
            DATE_END => '2011-10-23'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_TURKEY, \%TOURNAMENTS_TURKEY, 'Turkey');
}

1;
