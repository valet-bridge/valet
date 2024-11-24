#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Asia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'APBF',
  ZONE => 'Asia Pacific',
);

my %MEETS_ASIA =
(
  'APBF Championships' =>
  {
    # https://www.hkcba.org/apbf.php
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS =>
    {
      '2005' =>
      {
        ORDINAL => 43,
        CITY => 'Seoul',
        COUNTRY => 'South Korea',
        YEAR => 2005,
        DATE_START => '2005-06-23',
        DATE_END => '2005-07-03'
      },
      '2006' =>
      {
        ORDINAL => 44,
        CITY => 'Shanghai',
        COUNTRY => 'China',
        # Dates are just a guess.
        YEAR => 2006,
        DATE_START => '2006-08-24',
        DATE_END => '2006-08-29'
      },
      '2007' =>
      {
        ORDINAL => 45,
        CITY => 'Bandung',
        COUNTRY => 'Indonesia',
        YEAR => 2007,
        DATE_START => '2007-06-04',
        DATE_END => '2007-06-13'
      },
      '2008' =>
      {
        # Probably a PABF championship and not really
        # the official ABPF one.  Also the date is suspect --
        # probably 2008.
        YEAR => 2008,
        DATE_START => '2008-09-10',
        DATE_END => '2008-09-10'
      },
      '2009' =>
      {
        ORDINAL => 46,
        CITY => 'Macau',
        COUNTRY => 'Macau',
        YEAR => 2009,
        DATE_START => '2009-06-18',
        DATE_END => '2009-06-28'
      },
      '2010' =>
      {
        ORDINAL => 47,
        CITY => 'Hamilton',
        COUNTRY => 'New Zealand',
        YEAR => 2010,
        DATE_START => '2010-05-23',
        DATE_END => '2010-05-29'
      },
      '2011' =>
      {
        # http://www.mcba.org.my/
        # http://www.mcba.org.my/2011apbf.pdf
        ORDINAL => 48,
        CITY => 'Kuala Lumpur',
        COUNTRY => 'Malaysia',
        YEAR => 2011,
        DATE_START => '2011-06-15',
        DATE_END => '2011-06-24'
      },
      '2012' =>
      {
        YEAR => 2012,
        CITY => 'Fukuoka',
        COUNTRY => 'Japan',
        DATE_START => '2012-08-25',
        DATE_END => '2012-09-02'
      },
      '2013' =>
      {
        ORDINAL => 49,
        CITY => 'Hong Kong',
        COUNTRY => 'Hong Kong',
        YEAR => 2013,
        DATE_START => '2013-06-07',
        DATE_END => '2013-06-16'
      },
      '2015' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=5827
        ORDINAL => 50,
        CITY => 'Bangkok',
        COUNTRY => 'Thailand',
        YEAR => 2015,
        DATE_START => '2015-05-20',
        DATE_END => '2015-05-31'
      },
      '2017' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=7822
        ORDINAL => 51,
        CITY => 'Seoul',
        COUNTRY => 'South Korea',
        YEAR => 2017,
        DATE_START => '2017-05-28',
        DATE_END => '2017-06-07'
      },
      '2019' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=14478
        ORDINAL => 52,
        CITY => 'Singapore',
        COUNTRY => 'Singapore',
        YEAR => 2019,
        DATE_START => '2019-06-11',
        DATE_END => '2019-06-20'
      },
      '2023' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=23144
        ORDINAL => 53,
        CITY => 'Hong Kong',
        COUNTRY => 'Hong Kong',
        YEAR => 2023,
        DATE_START => '2023-06-09',
        DATE_END => '2023-06-17'
      },
    }
  },

  'APBF Youth Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS =>
    {
      '2006' =>
      {
        # Guess.
        YEAR => 2006,
        DATE_START => '2006-06-10',
        DATE_END => '2006-06-10'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-05-24',
        DATE_END => '2010-05-29'
      },
      '2013' =>
      {
        ORDINAL => 19,
        CITY => 'Wuhan',
        COUNTRY => 'China',
        YEAR => 2013,
        DATE_START => '2013-08-19',
        DATE_END => '2013-08-25'
      },
      '2015' =>
      {
        ORDINAL => 20,
        CITY => 'Bangkok',
        COUNTRY => 'Thailand',
        YEAR => 2015,
        DATE_START => '2015-04-01',
        DATE_END => '2015-04-07'
      },
    }
  },

  'ASEAN Club Championship' =>
  {
    # 2013: https://tournament.aseanbridge.com/
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS =>
    {
      '2006' =>
      {
        ORDINAL => 28,
        CITY => 'Singapore',
        COUNTRY => 'Singapore',
        YEAR => 2006,
        DATE_START => '2006-12-15',
        DATE_END => '2006-12-17'
      },
      '2007' =>
      {
        ORDINAL => 29,
        CITY => 'Makati City',
        COUNTRY => 'Philippines',
        YEAR => 2007,
        DATE_START => '2007-12-07',
        DATE_END => '2007-12-11'
      },
      '2008' =>
      {
        ORDINAL => 30,
        CITY => 'Semarang',
        COUNTRY => 'Indonesia',
        YEAR => 2008,
        DATE_START => '2008-12-03',
        DATE_END => '2008-12-08'
      },
      '2009' =>
      {
        ORDINAL => 31,
        CITY => 'Kuala Lumpur',
        COUNTRY => 'Malaysia',
        YEAR => 2009,
        DATE_START => '2009-12-05',
        DATE_END => '2009-12-09'
      },
      '2010' =>
      {
        ORDINAL => 32,
        CITY => 'Bangkok',
        COUNTRY => 'Thailand',
        YEAR => 2010,
        DATE_START => '2010-11-21',
        DATE_END => '2010-11-24'
      },
      '2011' =>
      {
        ORDINAL => 33,
        CITY => 'Singapore',
        COUNTRY => 'Singapore',
        YEAR => 2011,
        DATE_START => '2011-12-03',
        DATE_END => '2011-12-07'
      },
      '2012' =>
      {
        ORDINAL => 34,
        CITY => 'Bali',
        COUNTRY => 'Indonesia',
        YEAR => 2012,
        DATE_START => '2012-12-05',
        DATE_END => '2012-12-09'
      },
      '2013' =>
      {
        ORDINAL => 35,
        CITY => 'Makati City',
        COUNTRY => 'Philippines',
        YEAR => 2013,
        DATE_START => '2013-11-27',
        DATE_END => '2013-12-01'
      },
      '2014' =>
      {
        ORDINAL => 36,
        CITY => 'Kuala Lumpur',
        COUNTRY => 'Malaysia',
        YEAR => 2014,
        DATE_START => '2014-11-26',
        DATE_END => '2014-11-30'
      },
      '2015' =>
      {
        ORDINAL => 37,
        CITY => 'Bangkok',
        COUNTRY => 'Thailand',
        YEAR => 2015,
        DATE_START => '2015-12-03',
        DATE_END => '2015-12-06'
      },
    }
  },

  'Asia Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS =>
    {
      '2010' =>
      {
        ORDINAL => 1,
        YEAR => 2010,
        DATE_START => '2010-08-30',
        DATE_END => '2010-09-05'
      },
      '2014' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=3989
        ORDINAL => 2,
        CITY => 'Jinhua',
        COUNTRY => 'China',
        YEAR => 2014,
        DATE_START => '2014-06-12',
        DATE_END => '2014-06-22'
      },
      '2018' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=11713
        ORDINAL => 3,
        CITY => 'Goa',
        COUNTRY => 'India',
        YEAR => 2018,
        DATE_START => '2018-06-04',
        DATE_END => '2018-06-10'
      },
      '2022' =>
      {
        # https://www.ccba.org.cn/Tour/TourIndex.aspx?tourid=22055
        ORDINAL => 4,
        CITY => 'Jakarta',
        COUNTRY => 'Indonesia',
        YEAR => 2022,
        DATE_START => '2022-10-19',
        DATE_END => '2022-10-25'
      },
    }
  },

  'Southeast Asian Games' =>
  {
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS =>
    {
      '2011' =>
      {
        # https://en.wikipedia.org/wiki/Bridge_at_the_2011_SEA_Games
        ORDINAL => 26,
        CITY => 'Jakarta',
        COUNTRY => 'Indonesia',
        YEAR => 2011,
        DATE_START => '2011-11-10',
        DATE_END => '2011-11-21'
      },
      '2013' =>
      {
        # https://en.wikipedia.org/wiki/2013_SEA_Games
        # May have dropped bridge again.
        ORDINAL => 27,
        CITY => 'Nay Pyi Taw',
        COUNTRY => 'Myanmar',
        YEAR => 2013,
        DATE_START => '2013-12-11',
        DATE_END => '2013-12-22'
      },
    }
  },
);

my %TOURNAMENTS_ASIA =
(
  'APBF Girl Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-08-21',
            DATE_END => '2013-08-25'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-04-03',
            DATE_END => '2015-04-07'
          } 
        }
      },
    }
  },

  'APBF Junior Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2006-06-10',
            DATE_END => '2006-06-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2010-05-24',
            DATE_END => '2010-05-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2010-05-26',
            DATE_END => '2010-05-29'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          },
        }
      },
      '2013' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-08-20',
            DATE_END => '2013-08-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-08-24',
            DATE_END => '2013-08-25'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-04-01',
            DATE_END => '2015-04-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-04-05',
            DATE_END => '2015-04-07'
          } 
        }
      },
    }
  },

  'APBF Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-19',
            DATE_END => '2009-06-28'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-15',
            DATE_END => '2011-06-24'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-16'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-31'
          } 
        }
      },
    }
  },

  'APBF Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2005-06-23',
            DATE_END => '2005-07-01'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Bronze',
            major => 'ROUND',
            DATE_START => '2005-07-02',
            DATE_END => '2005-07-03'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'ROUND',
            DATE_START => '2005-07-01',
            DATE_END => '2005-07-03'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2006-08-24',
            DATE_END => '2006-08-29'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-06-04',
            DATE_END => '2007-06-11'
          },
          'C1' => 
          {
            # Not sure.
            YEAR => 2007,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2007-06-12',
            DATE_END => '2007-06-12'
          },
          'C2' => 
          {
            # Not sure.
            YEAR => 2007,
            STAGE => 'Playoff',
            DATE_START => '2007-06-13',
            DATE_END => '2007-06-13'
          } 
        }
      },
      '2008' =>
      {
        # Suspect -- PABF rather than APBF?
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2009-06-19',
            DATE_END => '2009-06-26'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-06-26',
            DATE_END => '2009-06-28'
          },
        }
      },
      '2010' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-05-23',
            DATE_END => '2010-05-29'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2011-06-15',
            DATE_END => '2011-06-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-06-23',
            DATE_END => '2011-06-24'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-27',
            DATE_END => '2012-09-02'
          },
        }
      },
      '2013' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-14'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-06-15',
            DATE_END => '2013-06-16'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-05-31'
          } 
        }
      },
    }
  },

  'APBF School Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Schools',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2006-06-10',
            DATE_END => '2006-06-10'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2007-06-13',
            DATE_END => '2007-06-13'
          } 
        }
      },
    }
  },

  'APBF Senior Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2006-08-28',
            DATE_END => '2006-08-29'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-06-04',
            DATE_END => '2007-06-11'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2007-06-12',
            DATE_END => '2007-06-13'
          } 
        }
      },
      '2008' =>
      {
        # Suspect -- PABF rather than APBF?
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2009-06-23',
            DATE_END => '2009-06-25'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-05-23',
            DATE_END => '2010-05-28'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-27',
            DATE_END => '2012-09-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-14'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-06-16',
            DATE_END => '2013-06-16'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-05-30'
          } 
        }
      },
    }
  },

  'APBF Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2006-08-24',
            DATE_END => '2006-08-29'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-10'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Bronze',
            DATE_START => '2007-06-13',
            DATE_END => '2007-06-13'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2007-06-11',
            DATE_END => '2007-06-12'
          } 
        }
      },
      '2008' =>
      {
        # Suspect -- PABF rather than APBF?
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2009-06-20',
            DATE_END => '2009-06-26'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-06-27',
            DATE_END => '2009-06-27'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2010-05-24',
            DATE_END => '2010-05-26'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-27',
            DATE_END => '2012-09-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-06-08',
            DATE_END => '2013-06-14'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-05-30'
          } 
        }
      },
    }
  },

  'APBF Youngster Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2007-06-08',
            DATE_END => '2007-06-11'
          } 
        }
      },
      '2008' =>
      {
        # Suspect -- PABF rather than APBF?
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'APBF Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-05-25',
            DATE_END => '2010-05-29'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-08-21',
            DATE_END => '2013-08-25'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'APBF Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2015-04-02',
            DATE_END => '2015-04-07'
          } 
        }
      },
    }
  },

  'ASEAN Mixed Club Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          } 
        }
      },
      '2008A' =>
      {
        MEET => 'APBF Championships',
        MEET_TAG => '2008',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
        }
      },
      '2008B' =>
      {
        MEET => 'ASEAN Club Championship',
        MEET_TAG => '2008',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-12-07',
            DATE_END => '2008-12-07'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-12-08',
            DATE_END => '2008-12-08'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-06',
            DATE_END => '2009-12-09'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-21',
            DATE_END => '2010-11-24'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-12-05',
            DATE_END => '2012-12-09'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-12-03',
            DATE_END => '2015-12-06'
          } 
        }
      },
    }
  },

  'ASEAN Open Club Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SESSION',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-12-05',
            DATE_END => '2012-12-09'
          } 
        }
      },
    }
  },

  'ASEAN Open Club Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'SESSION',
            DATE_START => '2006-12-16',
            DATE_END => '2006-12-16'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2008-12-06',
            DATE_END => '2008-12-06'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-07',
            DATE_END => '2008-12-07'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-12-06',
            DATE_END => '2009-12-06'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-12-07',
            DATE_END => '2009-12-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-12-09',
            DATE_END => '2009-12-09'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-21',
            DATE_END => '2010-11-23'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-11-24',
            DATE_END => '2010-11-24'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-12-06',
            DATE_END => '2011-12-07'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-12-05',
            DATE_END => '2012-12-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-12-07',
            DATE_END => '2012-12-08'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-09',
            DATE_END => '2012-12-09'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-12-04',
            DATE_END => '2015-12-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
          } 
        }
      },
    }
  },

  'ASEAN Women Club Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SESSION',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          } 
        }
      },
    }
  },

  'ASEAN Youngsters Club Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'ASEAN Club Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
          } 
        }
      },
    }
  },

  'Asia Open Teams Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Asia Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-08-31',
            DATE_END => '2010-09-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Asia Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2014-06-13',
            DATE_END => '2014-06-20'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-06-21',
            DATE_END => '2014-06-21'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-06-22',
            DATE_END => '2014-06-22'
          } 
        }
      },
    }
  },

  'Asia Women Teams Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Asia Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-08-30',
            DATE_END => '2010-09-05'
          } 
        }
      },
    }
  },

  'Asian University Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2009-11-25',
            DATE_END => '2009-11-30'
          } 
        }
      },
    }
  },

  'SEA Mixed Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-10',
            DATE_END => '2011-11-21'
          } 
        }
      },
    }
  },

  'SEA Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            DATE_START => '2011-11-15',
            DATE_END => '2011-11-17'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-11-17',
            DATE_END => '2011-11-18'
          } 
        }
      },
    }
  },

  'SEA Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-10',
            DATE_END => '2011-11-21'
          } 
        }
      },
    }
  },

  'SEA Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-10',
            DATE_END => '2011-11-21'
          } 
        }
      },
    }
  },

  'SEA Women Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-10',
            DATE_END => '2011-11-21'
          } 
        }
      },
    }
  },

  'SEA Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Southeast Asian Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-11-10',
            DATE_END => '2011-11-13'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-11-14',
            DATE_END => '2011-11-15'
          },
        }
      },
    }
  },

  'South Pacific Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'International',
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
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-05-18',
            DATE_END => '2005-05-18'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2005-05-18',
            DATE_END => '2005-05-18'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          } 
        }
      },
    }
  },

  'Yeh Bros Pairs Cup' =>
  {
    ORIGIN => 'Invitational',
    ZONE => 'South East Asia',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CITY => 'Broadbeach',
        COUNTRY => 'Australia',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2009,
            DATE_START => '2009-03-02',
            DATE_END => '2009-03-02'
          },
        }
      },
    }
  },

  'Yeh Bros Cup' =>
  {
    ORIGIN => 'Invitational',
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        # Not present in data
        CITY => 'Beijing',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2004,
            DATE_START => '2004-04-23',
            DATE_END => '2004-04-25'
          }
        }
      },
      '2006' =>
      {
        CITY => 'Kaohsiung',
        COUNTRY => 'Taiwan',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2006,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2006-03-18',
            DATE_END => '2006-03-18'
          },
          'C1' =>
          {
            YEAR => 2006,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-03-18',
            DATE_END => '2006-03-19'
          },
          'C2' =>
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-03-19',
            DATE_END => '2006-03-19'
          }
        }
      },
      '2007' =>
      {
        CITY => 'Shenzhen',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2007-03-01',
            DATE_END => '2007-03-02'
          },
          'C1' =>
          {
            YEAR => 2007,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2007-03-03',
            DATE_END => '2007-03-04'
          },
          'C2' =>
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-04',
            DATE_END => '2007-03-04'
          }
        }
      },
      '2008' =>
      {
        CITY => 'Kaohsiung',
        COUNTRY => 'Taiwan',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-02-13',
            DATE_END => '2008-02-15'
          },
          'C1' =>
          {
            YEAR => 2008,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            minor => 'HALF',
            DATE_START => '2008-02-16',
            DATE_END => '2008-02-16'
          },
          'C2' =>
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-02-17',
            DATE_END => '2008-02-17'
          }
        }
      },
      '2009' =>
      {
        CITY => 'Broadbeach',
        COUNTRY => 'Australia',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-02-25',
            DATE_END => '2009-02-27'
          },
          'C1' =>
          {
            YEAR => 2009,
            STAGE => 'Knock-out',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2009-02-27',
            DATE_END => '2009-03-01'
          },
          'C2' =>
          {
            YEAR => 2009,
            MOVEMENT => 'Triangle',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2009-02-28',
            DATE_END => '2009-03-01'
          },
          'C3' =>
          {
            YEAR => 2009,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-02'
          },
          'C4' =>
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-02'
          }
        }
      },
      '2011' =>
      {
        CITY => 'Wuxi',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-19'
          },
          'C1' =>
          {
            YEAR => 2011,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-04-19',
            DATE_END => '2011-04-21'
          },
          'C2' =>
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-19',
            DATE_END => '2011-04-21'
          }
        }
      },
      '2013' =>
      {
        CITY => 'Yokohama',
        COUNTRY => 'Japan',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-04-22',
            DATE_END => '2013-04-23'
          },
          'C1' =>
          {
            YEAR => 2013,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-25'
          },
          'C2' =>
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-26'
          },
          'C3' =>
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-26'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Shanghai',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-04-08',
            DATE_END => '2015-04-09'
          },
          'C1' =>
          {
            YEAR => 2015,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-11'
          },
          'C2' =>
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-12',
            DATE_END => '2015-04-12'
          }
        }
      },
      '2017' =>
      {
        CITY => 'Tokyo',
        COUNTRY => 'Japan',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-07-03',
            DATE_END => '2017-07-03'
          }
        }
      },
      '2018' =>
      {
        CITY => 'Beijing',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-07-01',
            DATE_END => '2018-07-05'
          }
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ASIA, \%TOURNAMENTS_ASIA, 'Asia');
}

1;
