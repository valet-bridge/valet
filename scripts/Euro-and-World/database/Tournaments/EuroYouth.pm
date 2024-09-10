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
        ORDINAL => '9th',
        YEAR => 2008,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2008-07-15',
        DATE_END => '2008-07-18'
      },

      '2010' =>
      {
        # http://db.eurobridge.org/Repository/competitions/10Opatija/Results.htm
        ORDINAL => '10th',
        YEAR => 2010,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2010-07-14',
        DATE_END => '2010-07-17'
      },

      '2012' =>
      {
        # http://db.eurobridge.org/Repository/competitions/12Vejle/microSite/Results.htm
        ORDINAL => '11th',
        YEAR => 2012,
        CITY => 'Vejle',
        COUNTRY => 'Denmark',
        DATE_START => '2012-07-01',
        DATE_END => '2012-07-06'
      },

      '2014' =>
      {
        # http://db.eurobridge.org/Repository/competitions/14Burghausen/microSite/results.htm
        ORDINAL => '12th',
        YEAR => 2014,
        CITY => 'Burghausen',
        COUNTRY => 'Germany',
        DATE_START => '2014-07-12',
        DATE_END => '2014-07-19'
      },

      '2016' =>
      {
        # http://db.eurobridge.org/Repository/competitions/16Liepaja/microSite/results.htm
        ORDINAL => '13th',
        YEAR => 2016,
        CITY => 'Liepaja',
        COUNTRY => 'Latvia',
        DATE_START => '2016-07-12',
        DATE_END => '2016-07-20'
      },

      '2018' =>
      {
        # http://db.eurobridge.org/Repository/competitions/18opatija/microsite/results.htm
        ORDINAL => '14th',
        YEAR => 2018,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2018-07-11',
        DATE_END => '2018-07-18'
      },

      '2023' =>
      {
        # http://db.eurobridge.org/repository/competitions/23Veldhoven/microsite/results.htm
        ORDINAL => '15th',
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
        ORDINAL => '15th',
        YEAR => 1996,
        CITY => 'Cardiff',
        COUNTRY => 'Great Britain',
        DATE_START => '1996-07-19',
        DATE_END => '1996-07-28'
      },

      '1998' =>
      {
        # http://db.eurobridge.org/Repository/competitions/98Vienna/vienna.htm
        ORDINAL => '16th',
        YEAR => 1998,
        CITY => 'Vienna',
        COUNTRY => 'Austria',
        DATE_START => '1998-07-16',
        DATE_END => '1998-07-16'
      },

      '2000' =>
      {
        # http://db.eurobridge.org/Repository/competitions/00Antalya/antalya.htm#table
        ORDINAL => '17th',
        YEAR => 2000,
        CITY => 'Antalya',
        COUNTRY => 'Turkey',
        DATE_START => '2000-07-06',
        DATE_END => '2000-07-16'
      },

      '2002' =>
      {
        # http://db.eurobridge.org/Repository/competitions/02Torquay/Torquay.htm
        ORDINAL => '18th',
        YEAR => 2002,
        CITY => 'Torquay',
        COUNTRY => 'England',
        DATE_START => '2002-07-07',
        DATE_END => '2002-07-17'
      },

      '2004' =>
      {
        # http://db.eurobridge.org/Repository/competitions/04Prague/Results.htm
        ORDINAL => '19th',
        YEAR => 2004,
        CITY => 'Prague',
        COUNTRY => 'Czech Republic',
        DATE_START => '2004-08-01',
        DATE_END => '2004-08-11'
      },

      '2005' =>
      {
        # http://db.eurobridge.org/Repository/competitions/05Riccione/Results.htm
        ORDINAL => '20th',
        YEAR => 2005,
        CITY => 'Riccione',
        COUNTRY => 'Italy',
        DATE_START => '2005-07-13',
        DATE_END => '2005-07-23'
      },

      '2007' =>
      {
        # http://db.eurobridge.org/Repository/competitions/07Jesolo/Results.htm
        ORDINAL => '21st',
        YEAR => 2007,
        CITY => 'Jesolo',
        COUNTRY => 'Italy',
        DATE_START => '2007-07-11',
        DATE_END => '2007-07-21'
      },

      '2009' =>
      {
        # http://db.eurobridge.org/Repository/competitions/09Brasov/Results.htm
        ORDINAL => '22nd',
        YEAR => 2009,
        CITY => 'Brasov',
        COUNTRY => 'Romania',
        DATE_START => '2009-07-09',
        DATE_END => '2009-07-18'
      },

      '2011' =>
      {
        # http://db.eurobridge.org/Repository/competitions/11Albena/microSite/Results.htm
        ORDINAL => '23rd',
        YEAR => 2011,
        CITY => 'Albena',
        COUNTRY => 'Bulgaria',
        DATE_START => '2011-07-14',
        DATE_END => '2011-07-23'
      },

      '2013' =>
      {
        # http://db.eurobridge.org/Repository/competitions/13Wroclaw/microSite/Results.htm
        ORDINAL => '24th',
        YEAR => 2013,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2013-07-12',
        DATE_END => '2013-07-19'
      },

      '2015' =>
      {
        # http://db.eurobridge.org/Repository/competitions/15TromsoYouth/microSite/results.htm
        ORDINAL => '25th',
        YEAR => 2015,
        CITY => 'Tromso',
        COUNTRY => 'Norway',
        DATE_START => '2015-07-19',
        DATE_END => '2015-07-25'
      },

      '2017' =>
      {
        # http://db.eurobridge.org/repository/competitions/17samorin/microsite/results.htm
        ORDINAL => '26th',
        YEAR => 2017,
        CITY => 'Samorin',
        COUNTRY => 'Slovakia',
        DATE_START => '2017-07-09',
        DATE_END => '2017-07-15'
      },

      '2019' =>
      {
        # http://db.eurobridge.org/repository/competitions/19stokke/microsite/results.htm
        ORDINAL => '27th',
        YEAR => 2019,
        CITY => 'Oslo',
        COUNTRY => 'Norway',
        DATE_START => '2019-07-05',
        DATE_END => '2019-07-11'
      },

      '2023' =>
      {
        # http://db.eurobridge.org/repository/competitions/22Veldhoven/microsite/results.htm
        ORDINAL => '28th',
        YEAR => 2023,
        CITY => 'Veldhoven',
        COUNTRY => 'Netherlands',
        DATE_START => '2023-07-20',
        DATE_END => '2023-07-26'
      },

      '2024' =>
      {
        # http://db.eurobridge.org/repository/competitions/24wroclaw/microsite/results.htm
        ORDINAL => '29th',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2019-07-08',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2023' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            DATE_START => '2023-07-20',
            DATE_END => '2023-07-23'
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2012,
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 1996,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 1998,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2023' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            DATE_START => '2023-07-20',
            DATE_END => '2023-07-26'
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
            STAGE => 'Round-robin',
            DATE_START => '2024-07-07',
            DATE_END => '2024-07-12'
          }
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2016-07-13',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
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
      '2008' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2012,
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
            STAGE => 'Round-robin',
            major => 'SESSION',
            DATE_START => '2012-07-04',
            DATE_END => '2012-07-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2023' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            DATE_START => '2023-07-20',
            DATE_END => '2023-07-26'
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
            STAGE => 'Round-robin',
            DATE_START => '2024-07-07',
            DATE_END => '2024-07-12'
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C2' => 
          {
            YEAR => 2012,
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
    ORIGIN => 'International',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            DATE_START => '2004-08-01',
            DATE_END => '2004-08-05'
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
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            DATE_START => '2007-07-11',
            DATE_END => '2007-07-16'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-13'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
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
            STAGE => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
            DATE_START => '2017-07-07',
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
            STAGE => 'Round-robin',
            DATE_START => '2019-07-08',
            DATE_END => '2019-07-11'
          }
        }
      },
      '2023' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            DATE_START => '2023-07-20',
            DATE_END => '2023-07-23'
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
            STAGE => 'Round-robin',
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
            STAGE => 'Round-robin',
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
    ORIGIN => 'International',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2024' =>
      {
        MEET => 'European Youth Team Championships',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            DATE_START => '2023-07-20',
            DATE_END => '2023-07-23'
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
            STAGE => 'Round-robin',
            DATE_START => '2024-07-09',
            DATE_END => '2024-07-12'
          }
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

      '2023' =>
      {
        MEET => 'European Youth Pairs Championships',
        CHAPTERS => 
        {
          'C0' => 
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-01',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
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
            major => 'SEGMENT',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-07-19',
            DATE_END => '2016-07-22'
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
