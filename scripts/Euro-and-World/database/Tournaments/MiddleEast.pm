#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::MiddleEast;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'BFAME',
  ZONE => 'Middle East',
);

my %MEETS_MIDDLEEAST =
(
  'Arab Nations Championship' =>
  {
    %GLOBAL,

    EDITIONS =>
    {
      '2019' =>
      {
        MEET_ORDINAL => 7,
        YEAR => 2019,
        DATE_START => '2019-02-21',
        DATE_END => '2019-02-25'
      },
      '2024' =>
      {
        MEET_ORDINAL => 10,
        YEAR => 2024,
        DATE_START => '2024-11-12',
        DATE_END => '2024-11-17'
      },
    }
  },

  'BFAME Championship' =>
  {
    # https://www.bridgewebs.com/cgi-bin/bwop/bw.cgi?club=bfame&pid=display_page2
    %GLOBAL,
    ORIGIN => 'International',

    EDITIONS => 
    {
      '2001' =>
      {
        MEET_ORDINAL => 11,
        CITY => 'Manama',
        COUNTRY => 'Bahrain',
        YEAR => 2001,
        DATE_START => '2001-05-23',
        DATE_END => '2001-06-02'
      },
      '2003' =>
      {
        MEET_ORDINAL => 12,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2003,
        DATE_START => '2003-08-01',
        DATE_END => '2003-08-09'
      },
      '2005' =>
      {
        MEET_ORDINAL => 13,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2005,
        DATE_START => '2005-08-01',
        DATE_END => '2005-08-09'
      },
      '2007' =>
      {
        MEET_ORDINAL => 14,
        CITY => 'Karachi',
        COUNTRY => 'Pakistan',
        YEAR => 2007,
        DATE_START => '2007-05-12',
        DATE_END => '2007-05-20'
      },
      '2009' =>
      {
        MEET_ORDINAL => 15,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2009,
        DATE_START => '2009-06-26',
        DATE_END => '2009-07-04'
      },
      '2011' =>
      {
        MEET_ORDINAL => 16,
        CITY => 'Chennai',
        COUNTRY => 'India',
        YEAR => 2011,
        DATE_START => '2011-05-25',
        DATE_END => '2011-06-01'
      },
      '2013' =>
      {
        MEET_ORDINAL => 17,
        CITY => 'Ahmedabad',
        COUNTRY => 'India',
        YEAR => 2013,
        DATE_START => '2013-06-04',
        DATE_END => '2013-06-11'
      },
      '2015' =>
      {
        MEET_ORDINAL => 18,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2015,
        DATE_START => '2015-05-27',
        DATE_END => '2015-06-03'
      },
      '2017' =>
      {
        MEET_ORDINAL => 19,
        CITY => 'Dubai',
        COUNTRY => 'UAE',
        YEAR => 2017,
        DATE_START => '2017-04-01',
        DATE_END => '2017-04-11'
      },
      '2019' =>
      {
        MEET_ORDINAL => 20,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2019,
        DATE_START => '2019-06-23',
        DATE_END => '2019-06-30'
      },
      '2021' =>
      {
        MEET_ORDINAL => 21,
        CITY => 'Online',
        YEAR => 2021,
        DATE_START => '2021-12-08',
        DATE_END => '2021-12-14'
      },
      '2023' =>
      {
        MEET_ORDINAL => 22,
        CITY => 'Lahore',
        COUNTRY => 'India',
        YEAR => 2023,
        DATE_START => '2023-05-06',
        DATE_END => '2023-05-13'
      },
      '2025' =>
      {
        MEET_ORDINAL => 23,
        CITY => 'Dubai',
        COUNTRY => 'UAE',
        YEAR => 2025,
        DATE_START => '2025-04-10',
        DATE_END => '2025-04-18'
      },
    }
  },

  'UAE Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET_ORDINAL => 4,
        YEAR => 2017,
        DATE_START => '2017-12-03',
        DATE_END => '2017-12-03'
      },
    }
  },
);

my %TOURNAMENTS_MIDDLEEAST =
(
  'Arab Nations Open Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'Arab Nations Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-02-21',
            DATE_END => '2019-02-23'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-02-21',
            DATE_END => '2019-02-25'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Arab Nations Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-11-12',
            DATE_END => '2024-11-14'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-11-16',
            DATE_END => '2024-11-16'
          },
          'C2' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-11-17',
            DATE_END => '2024-11-17'
          } 
        }
      },
    }
  },

  'Arab Nations Women Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        MEET => 'Arab Nations Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-11-13',
            DATE_END => '2024-11-14'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-11-16',
            DATE_END => '2024-11-16'
          },
          'C2' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-11-17',
            DATE_END => '2024-11-17'
          } 
        }
      },
    }
  },

  'BFAME Friendship Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-04',
            DATE_END => '2013-06-04'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-27',
            DATE_END => '2015-05-27'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-06-23',
            DATE_END => '2019-06-23'
          } 
        }
      },
    }
  },

  'BFAME Mixed Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2019-06-26',
            DATE_END => '2019-06-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-06-30',
            DATE_END => '2019-06-30'
          },
        }
      },
      '2023' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2023-05-06',
            DATE_END => '2023-05-10'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-05-12',
            DATE_END => '2023-05-12'
          },
        }
      },
    }
  },

  'BFAME Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2001' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2001-06-02',
            DATE_END => '2001-06-02'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-06-02',
            DATE_END => '2001-06-02'
          },
          'C2' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-06-02',
            DATE_END => '2001-06-02'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-06-26',
            DATE_END => '2009-07-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2009-07-02',
            DATE_END => '2009-07-03'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-04',
            DATE_END => '2009-07-04'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-05-26',
            DATE_END => '2011-05-30'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-31',
            DATE_END => '2011-06-01'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-06-05',
            DATE_END => '2013-06-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-06-09',
            DATE_END => '2013-06-10'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-11',
            DATE_END => '2013-06-11'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-28',
            DATE_END => '2015-06-01'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-02',
            DATE_END => '2015-06-03'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-03'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2017-04-01',
            DATE_END => '2017-04-08'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT|MATCH',
            DATE_START => '2017-04-09',
            DATE_END => '2017-04-10'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-04-11',
            DATE_END => '2017-04-11'
          },
        }
      },
      '2019' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-06-24',
            DATE_END => '2019-06-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-06-28',
            DATE_END => '2019-06-29'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-06-30',
            DATE_END => '2019-06-30'
          },
        }
      },
      '2023' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2023-05-06',
            DATE_END => '2023-05-10'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-05-11',
            DATE_END => '2023-05-12'
          },
          'C2' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-05-13',
            DATE_END => '2023-05-13'
          },
        }
      },
    }
  },

  'BFAME Senior Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-26',
            DATE_END => '2009-07-04'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-06-05',
            DATE_END => '2013-06-10'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-28',
            DATE_END => '2015-05-31'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-02',
            DATE_END => '2015-06-02'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-03'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2017-04-06',
            DATE_END => '2017-04-08'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT|MATCH',
            DATE_START => '2017-04-10',
            DATE_END => '2017-04-10'
          },
        }
      },
      '2019' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-06-26',
            DATE_END => '2019-06-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-06-30',
            DATE_END => '2019-06-30'
          },
        }
      },
      '2023' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-05-06',
            DATE_END => '2023-05-10'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-05-12',
            DATE_END => '2023-05-12'
          },
        }
      },
    }
  },

  'BFAME Women Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2001' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-06-02',
            DATE_END => '2001-06-02'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-06-26',
            DATE_END => '2009-06-30'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-01',
            DATE_END => '2009-07-01'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-05-26',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-06-05',
            DATE_END => '2013-06-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-11',
            DATE_END => '2013-06-11'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-28',
            DATE_END => '2015-06-01'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-02',
            DATE_END => '2015-06-02'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2017-04-01',
            DATE_END => '2017-04-11'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT|MATCH',
            DATE_START => '2017-04-09',
            DATE_END => '2017-04-10'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-04-11',
            DATE_END => '2017-04-11'
          },
        }
      },
      '2019' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2019-06-26',
            DATE_END => '2019-06-27'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-06-30',
            DATE_END => '2019-06-30'
          },
        }
      },
      '2023' =>
      {
        MEET => 'BFAME Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-05-06',
            DATE_END => '2023-05-10'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-05-11',
            DATE_END => '2023-05-12'
          },
          'C2' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-05-13',
            DATE_END => '2023-05-13'
          },
        }
      },
    }
  },

  'Pan Arab Inter-Club Championship' => 
  {
    %GLOBAL,
    ORIGIN => 'Interclub',
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
          # Dates are probably off
          'C0' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          },
        }
      },
      '2013' =>
      {
        ORDINAL => 5,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2013-11-07',
            DATE_END => '2013-11-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-09'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-10',
            DATE_END => '2013-11-10'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 6,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-11-05',
            DATE_END => '2014-11-07'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-08',
            DATE_END => '2014-11-08'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-11-09',
            DATE_END => '2014-11-09'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 7,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-07'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-08',
            DATE_END => '2015-11-08'
          } 
        }
      },
      '2016' =>
      {
        # During Tunisian Bridge Festival
        ORDINAL => 12,
        CITY => 'Hammamet',
        COUNTRY => 'Tunisia',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2016-10-26',
            DATE_END => '2016-10-28'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-29'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2017-10-27',
            DATE_END => '2017-10-27'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-28'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-10-29',
            DATE_END => '2017-10-29'
          } 
        }
      },
      '2018' =>
      {
        ORDINAL => 10,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2018-10-24',
            DATE_END => '2018-10-26'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-10-27',
            DATE_END => '2018-10-27'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-10-28',
            DATE_END => '2018-10-28'
          } 
        }
      },
      '2019' =>
      {
        ORDINAL => 11,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-10-16',
            DATE_END => '2019-10-18'
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
            DATE_START => '2019-10-20',
            DATE_END => '2019-10-20'
          } 
        }
      },
      '2020' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwon/bw.cgi?club=ablonline&pid=display_page37&sessid=250659546987832
        CITY => 'Online',

        CHAPTERS =>
        {
          # TODO Unchecked
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-10-06',
            DATE_END => '2016-10-06'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-25',
            DATE_END => '2016-10-27'
          }
        }
      },
      '2022' =>
      {
        # Supposedly the 12th?
        # During the 39th Jordan International Bridge Festival
        CITY => 'Amman',
        COUNTRY => 'Jordan',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-09-28',
            DATE_END => '2022-09-30'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-10-02',
            DATE_END => '2022-10-02'
          } 
        }
      },
      '2024' =>
      {
        # https://www.bridgewebs.com/ablonline/panarabinterclub2024.htm
        ORDINAL => 15,
        CITY => 'Amman',
        COUNTRY => 'Jordan',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-09-25',
            DATE_END => '2024-09-25'
          } 
        }
      },
    }
  },

  'Saudi-Arabian Open Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            major => 'ROUND|MATCH',
            DATE_START => '2019-04-25',
            DATE_END => '2019-04-25'
          },
        }
      },
    }
  },

  'UAE Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'UAE Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2017-12-03',
            DATE_END => '2017-12-03'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_MIDDLEEAST, \%TOURNAMENTS_MIDDLEEAST, 'Middle East');
}

1;
