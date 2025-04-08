#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::EuroYouth;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Good starting page:
# http://www.eurobridge.org/championship-archives/

my %MEETS_EURO_YOUTH =
(
  'European Youth Pairs Championships' =>
  {
    ORGANIZATION => 'EBL',
    ZONE => 'Europe',
    FORM => 'Pairs',

    EDITIONS =>
    {
      '2008' =>
      {
        # http://db.eurobridge.org/Repository/competitions/08Wroclaw/Results.htm
        MEET_ORDINAL => 9,
        YEAR => 2008,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2008-07-15',
        DATE_END => '2008-07-18'
      },

      '2010' =>
      {
        # http://db.eurobridge.org/Repository/competitions/10Opatija/Results.htm
        MEET_ORDINAL => 10,
        YEAR => 2010,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2010-07-14',
        DATE_END => '2010-07-17'
      },

      '2012' =>
      {
        # http://db.eurobridge.org/Repository/competitions/12Vejle/microSite/Results.htm
        MEET_ORDINAL => 11,
        YEAR => 2012,
        CITY => 'Vejle',
        COUNTRY => 'Denmark',
        DATE_START => '2012-07-01',
        DATE_END => '2012-07-06'
      },

      '2014' =>
      {
        # http://db.eurobridge.org/Repository/competitions/14Burghausen/microSite/results.htm
        MEET_ORDINAL => 12,
        YEAR => 2014,
        CITY => 'Burghausen',
        COUNTRY => 'Germany',
        DATE_START => '2014-07-12',
        DATE_END => '2014-07-19'
      },

      '2016' =>
      {
        # http://db.eurobridge.org/Repository/competitions/16Liepaja/microSite/results.htm
        MEET_ORDINAL => 13,
        YEAR => 2016,
        CITY => 'Liepaja',
        COUNTRY => 'Latvia',
        DATE_START => '2016-07-12',
        DATE_END => '2016-07-20'
      },

      '2018' =>
      {
        # http://db.eurobridge.org/Repository/competitions/18opatija/microsite/results.htm
        MEET_ORDINAL => 14,
        YEAR => 2018,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2018-07-11',
        DATE_END => '2018-07-18'
      },

      '2023' =>
      {
        # http://db.eurobridge.org/repository/competitions/23Veldhoven/microsite/results.htm
        MEET_ORDINAL => 15,
        YEAR => 2023,
        CITY => 'Veldhoven',
        COUNTRY => 'Netherlands',
        DATE_START => '2023-07-24',
        DATE_END => '2023-07-29'
      },
    }
  },

  'European Youth Team Championships' =>
  {
    ORGANIZATION => 'EBL',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '1996' =>
      {
        # http://db.eurobridge.org/Repository/competitions/96Cardiff/cardiff.htm
        MEET_ORDINAL => 15,
        YEAR => 1996,
        CITY => 'Cardiff',
        COUNTRY => 'Great Britain',
        DATE_START => '1996-07-19',
        DATE_END => '1996-07-28'
      },

      '1998' =>
      {
        # http://db.eurobridge.org/Repository/competitions/98Vienna/vienna.htm
        MEET_ORDINAL => 16,
        YEAR => 1998,
        CITY => 'Vienna',
        COUNTRY => 'Austria',
        DATE_START => '1998-07-16',
        DATE_END => '1998-07-26'
      },

      '2000' =>
      {
        # http://db.eurobridge.org/Repository/competitions/00Antalya/antalya.htm#table
        MEET_ORDINAL => 17,
        YEAR => 2000,
        CITY => 'Antalya',
        COUNTRY => 'Turkey',
        DATE_START => '2000-07-06',
        DATE_END => '2000-07-16'
      },

      '2002' =>
      {
        # http://db.eurobridge.org/Repository/competitions/02Torquay/Torquay.htm
        MEET_ORDINAL => 18,
        YEAR => 2002,
        CITY => 'Torquay',
        COUNTRY => 'England',
        DATE_START => '2002-07-07',
        DATE_END => '2002-07-17'
      },

      '2004' =>
      {
        # http://db.eurobridge.org/Repository/competitions/04Prague/Results.htm
        MEET_ORDINAL => 19,
        YEAR => 2004,
        CITY => 'Prague',
        COUNTRY => 'Czech Republic',
        DATE_START => '2004-08-01',
        DATE_END => '2004-08-11'
      },

      '2005' =>
      {
        # http://db.eurobridge.org/Repository/competitions/05Riccione/Results.htm
        MEET_ORDINAL => 20,
        YEAR => 2005,
        CITY => 'Riccione',
        COUNTRY => 'Italy',
        DATE_START => '2005-07-13',
        DATE_END => '2005-07-23'
      },

      '2007' =>
      {
        # http://db.eurobridge.org/Repository/competitions/07Jesolo/Results.htm
        MEET_ORDINAL => 21,
        YEAR => 2007,
        CITY => 'Jesolo',
        COUNTRY => 'Italy',
        DATE_START => '2007-07-11',
        DATE_END => '2007-07-21'
      },

      '2009' =>
      {
        # http://db.eurobridge.org/Repository/competitions/09Brasov/Results.htm
        MEET_ORDINAL => 22,
        YEAR => 2009,
        CITY => 'Brasov',
        LOCALITY => 'Poiana Brasov',
        COUNTRY => 'Romania',
        DATE_START => '2009-07-09',
        DATE_END => '2009-07-18'
      },

      '2011' =>
      {
        # http://db.eurobridge.org/Repository/competitions/11Albena/microSite/Results.htm
        MEET_ORDINAL => 23,
        YEAR => 2011,
        LOCALITY => 'Albena',
        COUNTRY => 'Bulgaria',
        DATE_START => '2011-07-14',
        DATE_END => '2011-07-23'
      },

      '2013' =>
      {
        # http://db.eurobridge.org/Repository/competitions/13Wroclaw/microSite/Results.htm
        MEET_ORDINAL => 24,
        YEAR => 2013,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2013-07-12',
        DATE_END => '2013-07-20'
      },

      '2015' =>
      {
        # http://db.eurobridge.org/Repository/competitions/15TromsoYouth/microSite/results.htm
        MEET_ORDINAL => 25,
        YEAR => 2015,
        CITY => 'Tromso',
        COUNTRY => 'Norway',
        DATE_START => '2015-07-19',
        DATE_END => '2015-07-25'
      },

      '2017' =>
      {
        # http://db.eurobridge.org/repository/competitions/17samorin/microsite/results.htm
        MEET_ORDINAL => 26,
        YEAR => 2017,
        CITY => 'Samorin',
        COUNTRY => 'Slovakia',
        DATE_START => '2017-07-09',
        DATE_END => '2017-07-15'
      },

      '2019' =>
      {
        # http://db.eurobridge.org/repository/competitions/19stokke/microsite/results.htm
        MEET_ORDINAL => 27,
        YEAR => 2019,
        CITY => 'Stokke',
        COUNTRY => 'Norway',
        DATE_START => '2019-07-05',
        DATE_END => '2019-07-11'
      },

      '2022' =>
      {
        # http://db.eurobridge.org/repository/competitions/22Veldhoven/microsite/results.htm
        MEET_ORDINAL => 28,
        YEAR => 2022,
        CITY => 'Veldhoven',
        COUNTRY => 'Netherlands',
        DATE_START => '2022-07-19',
        DATE_END => '2022-07-26'
      },

      '2024' =>
      {
        # http://db.eurobridge.org/repository/competitions/24wroclaw/microsite/results.htm
        MEET_ORDINAL => 29,
        YEAR => 2024,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2024-07-07',
        DATE_END => '2024-07-12'
      }
    }
  }
);

my %TOURNAMENTS_EURO_YOUTH =
(
  'European U16 Open Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U16',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            DATE_START => '2016-07-15',
            DATE_END => '2016-07-17'
          },
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            DATE_START => '2018-07-13',
            DATE_END => '2018-07-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-15',
            DATE_END => '2018-07-15'
          }
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-27',
            DATE_END => '2023-07-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-29',
            DATE_END => '2023-07-29'
          }
        }
      },

    }
  },

  'European U16 Open Teams',
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            DATE_START => '2015-07-19',
            DATE_END => '2015-07-22'
          }
        }
      },
      '2017' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            DATE_START => '2017-07-09',
            DATE_END => '2017-07-12'
          }
        }
      },
      '2019' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            DATE_START => '2019-07-08',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2022' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            DATE_START => '2022-07-20',
            DATE_END => '2022-07-26'
          }
        }
      },
      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            DATE_START => '2024-07-09',
            DATE_END => '2024-07-12'
          }
        }
      },
    }
  },

  'European U21 Open Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U21',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Round-robin',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-07-17',
            DATE_END => '2008-07-17'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            DATE_START => '2008-07-18',
            DATE_END => '2008-07-18'
          }
        }
      },

      '2010' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-07-17',
            DATE_END => '2010-07-17'
          }
        }
      },

      '2012' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            DATE_START => '2012-07-04',
            DATE_END => '2012-07-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-07-06',
            DATE_END => '2012-07-06'
          }
        }
      },

      '2014' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            DATE_START => '2014-07-14',
            DATE_END => '2014-07-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-07-16',
            DATE_END => '2014-07-16'
          }
        }
      },

      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            DATE_START => '2016-07-15',
            DATE_END => '2016-07-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-07-17',
            DATE_END => '2016-07-17'
          }
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            DATE_START => '2018-07-13',
            DATE_END => '2018-07-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-15',
            DATE_END => '2018-07-15'
          }
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-27',
            DATE_END => '2023-07-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-29',
            DATE_END => '2023-07-29'
          }
        }
      },

    }
  },

  'European U21 Open Teams',
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 1996,
            MOVEMENT => 'Round-robin',
            DATE_START => '1996-07-23',
            DATE_END => '1996-07-28'
          }
        }
      },
      '1998' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            MOVEMENT => 'Round-robin',
            DATE_START => '1998-07-21',
            DATE_END => '1998-07-26'
          }
        }
      },
      '2000' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            MOVEMENT => 'Round-robin',
            DATE_START => '2000-07-11',
            DATE_END => '2000-07-15'
          }
        }
      },
      '2002' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            MOVEMENT => 'Round-robin',
            DATE_START => '2002-07-11',
            DATE_END => '2002-07-17'
          }
        }
      },
      '2004' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            MOVEMENT => 'Round-robin',
            DATE_START => '2004-08-06',
            DATE_END => '2004-08-11'
          }
        }
      },
      '2005' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-07-18',
            DATE_END => '2005-07-23'
          }
        }
      },
      '2007' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            DATE_START => '2007-07-16',
            DATE_END => '2007-07-21'
          }
        }
      },
      '2009' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-13',
            DATE_END => '2009-07-18'
          }
        }
      },
      '2011' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-07-17',
            DATE_END => '2011-07-23'
          }
        }
      },
      '2013' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2013-07-14',
            DATE_END => '2013-07-20'
          }
        }
      },
      '2015' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-19',
            DATE_END => '2015-07-25'
          }
        }
      },
      '2017' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            DATE_START => '2017-07-09',
            DATE_END => '2017-07-15'
          }
        }
      },
      '2019' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2022' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            DATE_START => '2022-07-20',
            DATE_END => '2022-07-26'
          }
        }
      },
      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            DATE_START => '2024-07-07',
            DATE_END => '2024-07-12'
          },
        }
      },
    }
  },

  'European U26 Mixed Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Mixed',
    AGE => 'U26',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            DATE_START => '2012-07-02',
            DATE_END => '2012-07-03'
          },
        }
      },

      '2014' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            DATE_START => '2014-07-12',
            DATE_END => '2014-07-13'
          },
        }
      },

      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            DATE_START => '2016-07-13',
            DATE_END => '2016-07-13'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2016-07-14',
            DATE_END => '2016-07-14'
          },
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            DATE_START => '2018-07-11',
            DATE_END => '2018-07-12'
          },
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-25',
            DATE_END => '2023-07-26'
          },
        }
      },
    }
  },

  'European U26 Open IMP Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U26',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Round-robin',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-07-17',
            DATE_END => '2008-07-17'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2008-07-18',
            DATE_END => '2008-07-18'
          }
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-25',
            DATE_END => '2023-07-26'
          }
        }
      },
    }
  },

  'European U26 Open Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U26',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-07-17',
            DATE_END => '2010-07-17'
          }
        }
      },

      '2012' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2012-07-04',
            DATE_END => '2012-07-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2012-07-06',
            DATE_END => '2012-07-06'
          }
        }
      },

      '2014' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            DATE_START => '2014-07-14',
            DATE_END => '2014-07-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-07-16',
            DATE_END => '2014-07-16'
          }
        }
      },

      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            DATE_START => '2016-07-15',
            DATE_END => '2016-07-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2016-07-17',
            DATE_END => '2016-07-17'
          }
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            DATE_START => '2018-07-13',
            DATE_END => '2018-07-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-15',
            DATE_END => '2018-07-15'
          }
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-27',
            DATE_END => '2023-07-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-29',
            DATE_END => '2023-07-29'
          }
        }
      },
    }
  },

  'European U26 Open Teams',
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 1996,
            MOVEMENT => 'Round-robin',
            DATE_START => '1996-07-19',
            DATE_END => '1996-07-28'
          }
        }
      },
      '1998' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 1998,
            MOVEMENT => 'Round-robin',
            DATE_START => '1998-07-16',
            DATE_END => '1998-07-26'
          }
        }
      },
      '2000' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2000,
            MOVEMENT => 'Round-robin',
            DATE_START => '2000-07-06',
            DATE_END => '2000-07-16'
          }
        }
      },
      '2002' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2002,
            MOVEMENT => 'Round-robin',
            DATE_START => '2002-07-07',
            DATE_END => '2002-07-17'
          }
        }
      },
      '2004' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2004,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-08-01',
            DATE_END => '2004-08-11'
          }
        }
      },
      '2005' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-07-13',
            DATE_END => '2005-07-23'
          }
        }
      },
      '2007' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2007-07-11',
            DATE_END => '2007-07-21'
          }
        }
      },
      '2009' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-18'
          }
        }
      },
      '2011' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-07-14',
            DATE_END => '2011-07-23'
          }
        }
      },
      '2013' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            ignore => 'MATCH',
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-20'
          }
        }
      },
      '2015' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-19',
            DATE_END => '2015-07-25'
          }
        }
      },
      '2017' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            DATE_START => '2017-07-09',
            DATE_END => '2017-07-15'
          }
        }
      },
      '2019' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            DATE_START => '2024-07-07',
            DATE_END => '2024-07-12'
          }
        }
      },
    }
  },

  'European School Teams',
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'Schools',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-07-20',
            DATE_END => '2007-07-21'
          }
        }
      },
    }
  },

  'European U26 Women Pairs' =>
  {
    ORIGIN => 'International',
    GENDER => 'Women',
    AGE => 'U26',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Round-robin',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-07-17',
            DATE_END => '2008-07-17'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            DATE_START => '2008-07-18',
            DATE_END => '2008-07-18'
          }
        }
      },

      '2010' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-07-17',
            DATE_END => '2010-07-17'
          }
        }
      },

      '2012' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            DATE_START => '2012-07-04',
            DATE_END => '2012-07-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-07-06',
            DATE_END => '2012-07-06'
          }
        }
      },

      '2014' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            DATE_START => '2014-07-14',
            DATE_END => '2014-07-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-07-16',
            DATE_END => '2014-07-16'
          }
        }
      },

      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            DATE_START => '2016-07-15',
            DATE_END => '2016-07-16'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2016-07-16',
            DATE_END => '2016-07-17'
          },
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            DATE_START => '2018-07-13',
            DATE_END => '2018-07-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-15',
            DATE_END => '2018-07-15'
          }
        }
      },

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-27',
            DATE_END => '2023-07-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-29',
            DATE_END => '2023-07-29'
          }
        }
      },
    }
  },

  'European U26 Women Teams',
  {
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2004,
            MOVEMENT => 'Round-robin',
            DATE_START => '2004-08-01',
            DATE_END => '2004-08-05'
          }
        }
      },
      '2005' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-07-18',
            DATE_END => '2005-07-23'
          }
        }
      },
      '2007' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2007-07-11',
            DATE_END => '2007-07-18'
          }
        }
      },
      '2009' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-13'
          }
        }
      },
      '2011' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT|HALF',
            DATE_START => '2011-07-14',
            DATE_END => '2011-07-23'
          }
        }
      },
      '2013' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2013-07-14',
            DATE_END => '2013-07-20'
          }
        }
      },
      '2015' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-19',
            DATE_END => '2015-07-25'
          }
        }
      },
      '2017' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            DATE_START => '2017-07-09',
            DATE_END => '2017-07-15'
          }
        }
      },
      '2019' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            DATE_START => '2019-07-08',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2022' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            DATE_START => '2022-07-20',
            DATE_END => '2022-07-26'
          }
        }
      },
      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'Transnational',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            DATE_START => '2024-07-09',
            DATE_END => '2024-07-12'
          }
        }
      },
    }
  },

  'European U31 Open Pairs',
  {
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U31',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            DATE_START => '2023-07-27',
            DATE_END => '2023-07-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-29',
            DATE_END => '2023-07-29'
          }
        }
      },
    }
  },

  'European U31 Open Teams',
  {
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'International',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            DATE_START => '2022-07-20',
            DATE_END => '2022-07-26'
          }
        }
      },

      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        ORIGIN => 'Transnational',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            DATE_START => '2024-07-09',
            DATE_END => '2024-07-12'
          },
        }
      },
    }
  },

  "European U31 President's Cup",
  {
    ORIGIN => 'Transnational',
    GENDER => 'Open',
    AGE => 'U31',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-07-06',
            DATE_END => '2012-07-06'
          },
        }
      },

      '2014' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-07-16',
            DATE_END => '2014-07-16'
          },
        }
      },

      '2016' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-07-17',
            DATE_END => '2016-07-17'
          },
        }
      },

      '2018' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-15',
            DATE_END => '2018-07-15'
          }
        }
      },
    }
  },

  'European University Bridge Championship' =>
  {
    # https://www.eusa.eu/championships
    ORGANIZATION => 'EBL',
    ZONE => 'Europe',
    ORIGIN => 'University',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2009' =>
      {
        # No link
        ORDINAL => 1,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND|MATCH',
            DATE_START => '2009-10-05',
            DATE_END => '2009-10-09'
          },
        }
      },
      '2011' =>
      {
        # No link
        ORDINAL => 2,
        CITY => 'Warsaw',
        COUNTRY => 'Poland',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND|MATCH',
            DATE_START => '2011-09-19',
            DATE_END => '2011-09-23'
          },
        }
      },
      '2013' =>
      {
        # No link
        ORDINAL => 3,
        CITY => 'Kraljevica',
        COUNTRY => 'Croatia',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-01',
            DATE_END => '2013-10-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-04',
            DATE_END => '2013-10-04'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-04',
            DATE_END => '2013-10-04'
          },
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/euc2015/euc2015leaderb.html
        ORDINAL => 4,
        CITY => 'Warsaw',
        COUNTRY => 'Poland',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND|MATCH',
            DATE_START => '2015-09-01',
            DATE_END => '2015-09-06'
          },
        }
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/eusa/euc2017_leaderb.html
        ORDINAL => 5,
        CITY => 'Warsaw',
        COUNTRY => 'Poland',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-21',
            DATE_END => '2017-09-24'
          },
        }
      },
      '2019' =>
      {
        # https://www.eusa.eu/championships/championships-2019/european-universities-mind-sports-championship
        ORDINAL => 6,
        CITY => 'Budapest',
        COUNTRY => 'Hungary',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-21',
            DATE_END => '2019-09-24'
          },
        }
      },
    }
  },

  'European University Team Championship' =>
  {
    # http://www.eurobridge.org/championship-archives/
    ORGANIZATION => 'EUSA',
    ZONE => 'Europe',
    ORIGIN => 'University',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2005' =>
      {
        # https://www.eusa.eu/cups-and-patronage/cups-and-patronage-2005/1st-eusa-cup-in-bridge
        ORDINAL => 9,
        CITY => 'Rotterdam',
        COUNTRY => 'Netherlands',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-08-25',
            DATE_END => '2005-08-29'
          },
        }
      },
      '2007' =>
      {
        # https://www.eusa.eu/cups-and-patronage/cups-and-patronage-2007/2nd-eusa-cup-in-bridge
        ORDINAL => 10,
        CITY => 'Bruges',
        COUNTRY => 'Belgium',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            ignore => 'TABLE',
            DATE_START => '2007-08-05',
            DATE_END => '2007-08-07'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-08-08',
            DATE_END => '2007-08-08'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2007-08-08',
            DATE_END => '2007-08-08'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Consolation',
            major => 'SEGMENT',
            DATE_START => '2007-08-08',
            DATE_END => '2007-08-08'
          },
        }
      },
      '2014' =>
      {
        # https://www.eusa.eu/games/rotterdam-2014
        # https://kubusiu.michzimny.pl/EUSAGAMES/EUSACupRRleaderb.html
        CITY => 'Rotterdam',
        COUNTRY => 'Netherlands',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-25',
            DATE_END => '2014-07-26'
          },
        }
      },
      '2016' =>
      {
        # http://www.eurobridge.org/2015/12/08/bridge-at-the-european-universities-games-zagreb-rijeka-2016/
        CITY => 'Zagreb',
        COUNTRY => 'Croatia',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-07-19',
            DATE_END => '2016-07-22'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-07-25',
            DATE_END => '2019-07-28'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_EURO_YOUTH, \%TOURNAMENTS_EURO_YOUTH, 'Europe');
}

1;
