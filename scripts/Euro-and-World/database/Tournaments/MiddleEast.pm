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
        DATE_START => '2017-04-03',
        DATE_END => '2017-04-11'
      },
      '2019' =>
      {
        MEET_ORDINAL => 20,
        CITY => 'Amman',
        COUNTRY => 'Jordan',
        YEAR => 2019,
        DATE_START => '2019-05-23',
        DATE_END => '2019-05-30'
      },
      '2021' =>
      {
        MEET_ORDINAL => 21,
        CITY => 'Online',
        YEAR => 2021,
        DATE_START => '2021-12-08',
        DATE_END => '2021-12-14'
      },
    }
  }
);

my %TOURNAMENTS_MIDDLEEAST =
(
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
        # During Tunisian bridge festival
        ORDINAL => 12,
        CITY => 'Hammamet',
        COUNTRY => 'Tunisia',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-04',
            DATE_END => '2016-11-08'
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
            # Looks like 2020-10-06 RR, maybe 2020-10-25 to 27 KO.
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

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_MIDDLEEAST, \%TOURNAMENTS_MIDDLEEAST, 'Middle East');
}

1;
