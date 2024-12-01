#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Balkan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_BALKAN =
(
  'Balkan Championship' =>
  {
    ORIGIN => 'International',
    ZONE => 'Balkan',

    EDITIONS => 
    {
      '2006' =>
      {
        MEET_ORDINAL => 1,
        YEAR => 2006,
        DATE_START => '2006-10-17',
        DATE_END => '2006-10-17'
      },
      '2007' =>
      {
        MEET_ORDINAL => 2,
        YEAR => 2007,
        DATE_START => '2007-10-22',
        DATE_END => '2007-10-22'
      },
      '2008' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2008,
        DATE_START => '2008-11-23',
        DATE_END => '2008-11-23'
      },
      '2009' =>
      {
        # balkanbridge.org on Wayback Machine
        MEET_ORDINAL => 4,
        CITY => 'Novi Sad',
        COUNTRY => 'Serbia',
        YEAR => 2009,
        DATE_START => '2009-11-24',
        DATE_END => '2009-11-26'
      },
      '2010' =>
      {
        # https://5bbc.neo-bridge.org/topframe.html
        MEET_ORDINAL => 5,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2010,
        DATE_START => '2010-09-29',
        DATE_END => '2010-10-03'
      },
      '2011' =>
      {
        MEET_ORDINAL => 6,
        CITY => 'Mersin',
        COUNTRY => 'Turkey',
        YEAR => 2011,
        DATE_START => '2011-09-19',
        DATE_END => '2011-09-21'
      },
      '2013' =>
      {
        MEET_ORDINAL => 7,
        YEAR => 2013,
        DATE_START => '2013-10-02',
        DATE_END => '2013-10-03'
      },
      '2015' =>
      {
        MEET_ORDINAL => 8,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2015,
        DATE_START => '2015-10-14',
        DATE_END => '2015-10-15'
      },
      '2016' =>
      {
        MEET_ORDINAL => 9,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2016,
        DATE_START => '2016-10-04',
        DATE_END => '2016-10-08'
      },
      '2018' =>
      {
        MEET_ORDINAL => 11,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2018,
        DATE_START => '2018-10-03',
        DATE_END => '2018-10-04'
      },
      '2019' =>
      {
        # https://8bbc.neo-bridge.org/
        MEET_ORDINAL => 12,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2019,
        DATE_START => '2019-10-04',
        DATE_END => '2019-10-06'
      },
      '2021' =>
      {
        # https://www.bridge.bg/en/tournaments_results/5022-XIII-Balkaniada-po-bridj-finali
        MEET_ORDINAL => 13,
        YEAR => 2021,
        DATE_START => '2021-10-06',
        DATE_END => '2021-10-10'
      },
      '2022' =>
      {
        # https://www.bridge.bg/en/tournaments_results/5513-14-Balkan-Championship-Finals
        MEET_ORDINAL => 14,
        YEAR => 2022,
        DATE_START => '2022-10-05',
        DATE_END => '2022-10-09'
      },
      '2023' =>
      {
        MEET_ORDINAL => 15,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        YEAR => 2023,
        DATE_START => '2023-10-04',
        DATE_END => '2023-10-05'
      },
    }
  },

  'Balkan Friendship Festival' =>
  {
    ORIGIN => 'International',
    ZONE => 'Balkan',

    EDITIONS => 
    {
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-05-04',
        DATE_END => '2008-05-04'
      },

      '2009' =>
      {
        YEAR => 2009,
        CITY => 'Thessaloniki',
        COUNTRY => 'Greece',
        DATE_START => '2009-05-01',
        DATE_END => '2009-05-03'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-10',
        DATE_END => '2010-04-11'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-28',
        DATE_END => '2011-04-30'
      },
      '2013' =>
      {
        MEET_ORDINAL => 7,
        YEAR => 2013,
        DATE_START => '2013-04-28',
        DATE_END => '2013-04-29'
      },
    }
  },
);

my %TOURNAMENTS_BALKAN =
(
  'Balkan Friendship Open Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
        }
      },
    }
  },

  'Balkan Friendship Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-01',
            DATE_END => '2009-05-03'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            DATE_START => '2010-04-10',
            DATE_END => '2010-04-11'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-04-28',
            DATE_END => '2011-04-30'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Balkan Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-28',
            DATE_END => '2013-04-29'
          },
        }
      },
    }
  },

  'Balkan Intercity Cup' => 
  {
    ORIGIN => 'Intercity',
    ZONE => 'Balkan',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-10-07',
            DATE_END => '2009-10-08'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-10-08',
            DATE_END => '2009-10-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-10-08',
            DATE_END => '2009-10-08'
          } 
        }
      },
      '2011' =>
      {
        ORDINAL => 3,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-10-05',
            DATE_END => '2011-10-06'
          } 
        }
      },
      '2012' =>
      {
        ORDINAL => 4,
        CITY => 'Stara Zagora',
        COUNTRY => 'Bulgaria',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-10-04',
            DATE_END => '2012-10-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-05'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-05'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-10-02',
            DATE_END => '2014-10-02'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-10-02',
            DATE_END => '2014-10-02'
          } 
        }
      },
    }
  },

  'Balkan Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-10-17',
            DATE_END => '2006-10-17'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'SEGMENT',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-11-24',
            DATE_END => '2009-11-25'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-26',
            DATE_END => '2009-11-26'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2009-11-26',
            DATE_END => '2009-11-26'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-26',
            DATE_END => '2009-11-26'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-29',
            DATE_END => '2010-09-29'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-09-30',
            DATE_END => '2010-09-30'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-09-30',
            DATE_END => '2010-09-30'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            DATE_START => '2011-09-19',
            DATE_END => '2011-09-21'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-02',
            DATE_END => '2013-10-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Balkan Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-10-14',
            DATE_END => '2015-10-15'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-10-15',
            DATE_END => '2015-10-15'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-10-15',
            DATE_END => '2015-10-15'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BALKAN, \%TOURNAMENTS_BALKAN, 'Balkan');
}

1;
