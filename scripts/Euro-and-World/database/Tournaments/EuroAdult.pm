#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::EuroAdult;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# http://www.eurobridge.org/championship-archives/


my %MEETS_EUROADULT =
(
  'European National Championships' =>
  {
    ORGANIZATION => 'EBL',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '1996' =>
      {
        # http://db.eurobridge.org/Repository/competitions/97Montecatini/Montecatini.htm#table
        YEAR => 1996,
        CITY => 'Montecatini',
        COUNTRY => 'Italy',
        DATE_START => '1996-06-14',
        DATE_END => '1996-06-28'
      },

      '1998' =>
      {
        # http://db.eurobridge.org/Repository/competitions/99Malta/malta.htm#table
        YEAR => 1998,
        CITY => 'Valletta',
        COUNTRY => 'Malta',
        DATE_START => '1998-06-12',
        DATE_END => '1998-06-26'
      },

      '2000' =>
      {
        # http://db.eurobridge.org/Repository/competitions/01Tenerife/ResultsMain.htm
        YEAR => 2000,
        CITY => 'Tenerife',
        COUNTRY => 'Spain',
        DATE_START => '2000-06-16',
        DATE_END => '2000-06-30'
      },

      '2002' =>
      {
        # http://db.eurobridge.org/Repository/competitions/02Salsomaggiore/Results.htm
        YEAR => 2002,
        CITY => 'Salgomaggiore',
        COUNTRY => 'Italy',
        DATE_START => '2002-06-15',
        DATE_END => '2002-06-29'
      },

      '2004' =>
      {
        # http://db.eurobridge.org/Repository/competitions/04Malmo/Results.htm
        YEAR => 2004,
        CITY => 'Malmö',
        COUNTRY => 'Sweden',
        DATE_START => '2004-06-19',
        DATE_END => '2004-07-03'
      },

      '2006' =>
      {
        # http://db.eurobridge.org/Repository/competitions/06Warsaw/Results.htm
        YEAR => 2006,
        CITY => 'Warsaw',
        COUNTRY => 'Poland',
        DATE_START => '2006-08-12',
        DATE_END => '2006-08-26'
      },

      '2008' =>
      {
        # http://db.eurobridge.org/Repository/competitions/08Pau/Results.htm
        YEAR => 2008,
        CITY => 'Pau',
        COUNTRY => 'France',
        DATE_START => '2008-06-14',
        DATE_END => '2008-06-28'
      },

      '2010' =>
      {
        # http://db.eurobridge.org/Repository/competitions/10Ostend/Results.htm
        YEAR => 2010,
        CITY => 'Ostend',
        COUNTRY => 'Belgium',
        DATE_START => '2010-06-22',
        DATE_END => '2010-07-03'
      },

      '2012' =>
      {
        # http://db.eurobridge.org/Repository/competitions/12Dublin/microSite/Results.htm
        YEAR => 2012,
        CITY => 'Dublin',
        COUNTRY => 'Ireland',
        DATE_START => '2012-06-12',
        DATE_END => '2012-06-23'
      },

      '2014' =>
      {
        # http://db.eurobridge.org/Repository/competitions/14Opatija/microSite/results.htm
        YEAR => 2014,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2014-06-21',
        DATE_END => '2014-07-01'
      },

      '2016' =>
      {
        # http://db.eurobridge.org/Repository/competitions/16Budapest/microSite/results.htm
        YEAR => 2016,
        CITY => 'Budapest',
        COUNTRY => 'Hungary',
        DATE_START => '2016-06-16',
        DATE_END => '2016-06-25'
      },

      '2018' =>
      {
        # http://db.eurobridge.org/repository/competitions/18Ostend/microSite/results.htm
        YEAR => 2018,
        CITY => 'Ostend',
        COUNTRY => 'Belgium',
        DATE_START => '2018-06-06',
        DATE_END => '2018-06-16'
      },

      '2022' =>
      {
        # http://db.eurobridge.org/repository/competitions/22Madeira/microsite/results.htm
        YEAR => 2023,
        CITY => 'Madeira',
        COUNTRY => 'Portugal',
        DATE_START => '2022-06-12',
        DATE_END => '2022-06-22'
      },

      '2024' =>
      {
        # http://db.eurobridge.org/repository/competitions/24Herning/microsite/results.htm
        YEAR => 2024,
        CITY => 'Herning',
        COUNTRY => 'Denmark',
        DATE_START => '2024-06-24',
        DATE_END => '2024-07-04'
      },
    }
  },

  'European Transnational Championships' =>
  {
    ORGANIZATION => 'EBL',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2005' =>
      {
        # http://db.eurobridge.org/Repository/competitions/05Tenerife/Tenerife.htm
        YEAR => 2005,
        CITY => 'Tenerife',
        COUNTRY => 'Spain',
        DATE_START => '2005-06-18',
        DATE_END => '2005-07-02'
      },
      '2011' =>
      {
        # http://db.eurobridge.org/Repository/competitions/11Poznan/Results.htm#Pairs
        YEAR => 2011,
        CITY => 'Poznan',
        COUNTRY => 'Poland',
        DATE_START => '2011-06-17',
        DATE_END => '2011-07-02'
      },
    }
  },

  'Generali European Team Championships' =>
  {
    ORGANIZATION => 'EBL',
    ORIGIN => 'International',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '1997' =>
      {
        # http://db.eurobridge.org/Repository/competitions/97Montecatini/Montecatini.htm#table
        YEAR => 1997,
        CITY => 'Montecatini',
        COUNTRY => 'Italy',
        DATE_START => '1997-06-14',
        DATE_END => '1997-06-28'
      },
    }
  },
);

my %TOURNAMENTS_EUROADULT =
(
  'European National Mixed Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-06-16',
            DATE_END => '2022-06-22'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-06-28',
            DATE_END => '2024-07-04'
          } 
        }
      },
    }
  },

  'European National Open Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1996,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1996-06-15',
            DATE_END => '1996-06-28'
          } 
        }
      },

      '1998' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1998-06-12',
            DATE_END => '1998-06-26'
          } 
        }
      },

      '2000' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2000-06-17',
            DATE_END => '2000-06-30'
          } 
        }
      },

      '2002' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2002-06-16',
            DATE_END => '2002-06-29'
          } 
        }
      },

      '2004' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-06-20',
            DATE_END => '2004-07-03'
          } 
        }
      },

      '2006' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-08-13',
            DATE_END => '2006-08-26'
          } 
        }
      },

      '2008' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-06-15',
            DATE_END => '2008-06-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2008-06-22',
            DATE_END => '2008-06-28'
          } 
        }
      },

      '2010' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-06-23',
            DATE_END => '2010-06-29'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-06-30',
            DATE_END => '2010-07-03'
          } 
        }
      },

      '2012' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-13',
            DATE_END => '2012-06-23'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-06-22',
            DATE_END => '2014-07-01'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-16',
            DATE_END => '2016-06-25'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-06-06',
            DATE_END => '2018-06-16'
          } 
        }
      },

      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-06-12',
            DATE_END => '2022-06-22'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-06-24',
            DATE_END => '2024-07-04'
          } 
        }
      },
    }
  },

  'European National Seniors Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1996,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '1996-06-15',
            DATE_END => '1996-06-16'
          },
          'C1' => 
          {
            YEAR => 1996,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '1996-06-16',
            DATE_END => '1996-06-17'
          } 
        }
      },

      '1998' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1998,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '1998-06-13',
            DATE_END => '1998-06-14'
          },
          'C1' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '1998-06-14',
            DATE_END => '1998-06-15'
          } 
        }
      },

      '2000' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2000-06-17',
            DATE_END => '2000-06-18'
          },
          'C1' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2000-06-18',
            DATE_END => '2000-06-19'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-06-16',
            DATE_END => '2016-06-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-18'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-06-06',
            DATE_END => '2018-06-07'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2018-06-08',
            DATE_END => '2018-06-09'
          } 
        }
      },

      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2022-06-12',
            DATE_END => '2022-06-14'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2022-06-15',
            DATE_END => '2022-06-15'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2024-06-24',
            DATE_END => '2024-06-25'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2024-06-26',
            DATE_END => '2024-06-26'
          },
          'C2' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2024-06-27',
            DATE_END => '2024-06-27'
          } 
        }
      },
    }
  },

  'European National Seniors Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1996,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1996-06-21',
            DATE_END => '1996-06-27'
          } 
        }
      },

      '1998' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1998-06-17',
            DATE_END => '1998-06-25'
          } 
        }
      },

      '2000' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2000-06-21',
            DATE_END => '2000-06-30'
          } 
        }
      },

      '2002' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2002-06-19',
            DATE_END => '2002-06-28'
          } 
        }
      },

      '2004' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-06-23',
            DATE_END => '2004-06-30'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2004-07-01',
            DATE_END => '2004-07-03'
          } 
        }
      },

      '2006' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-08-17',
            DATE_END => '2006-08-23'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2006-08-23',
            DATE_END => '2006-08-25'
          } 
        }
      },

      '2008' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-27'
          }
        }
      },

      '2010' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-06-26',
            DATE_END => '2010-07-03'
          }
        }
      },

      '2012' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-23'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-06-22',
            DATE_END => '2014-06-28'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-19',
            DATE_END => '2016-06-25'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-06-10',
            DATE_END => '2018-06-16'
          } 
        }
      },

      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-06-16',
            DATE_END => '2022-06-22'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-06-28',
            DATE_END => '2024-07-04'
          } 
        }
      },
    }
  },

  'European National Women Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1996,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '1996-06-15',
            DATE_END => '1996-06-16'
          },
          'C1' => 
          {
            YEAR => 1996,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '1996-06-16',
            DATE_END => '1996-06-17'
          } 
        }
      },

      '1998' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1998,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '1998-06-13',
            DATE_END => '1998-06-14'
          },
          'C1' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '1998-06-14',
            DATE_END => '1998-06-15'
          } 
        }
      },

      '2000' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2000-06-17',
            DATE_END => '2000-06-18'
          },
          'C1' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2000-06-18',
            DATE_END => '2000-06-19'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-06-16',
            DATE_END => '2016-06-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-18'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2018-06-06',
            DATE_END => '2018-06-07'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2018-06-08',
            DATE_END => '2018-06-09'
          } 
        }
      },

      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2022-06-12',
            DATE_END => '2022-06-14'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2022-06-15',
            DATE_END => '2022-06-15'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2024-06-24',
            DATE_END => '2024-06-25'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2024-06-26',
            DATE_END => '2024-06-26'
          },
          'C2' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2024-06-27',
            DATE_END => '2024-06-27'
          } 
        }
      },
    }
  },

  'European National Women Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1996,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1996-06-18',
            DATE_END => '1996-06-27'
          } 
        }
      },

      '1998' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1998-06-16',
            DATE_END => '1998-06-25'
          } 
        }
      },

      '2000' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2000-06-20',
            DATE_END => '2000-06-29'
          } 
        }
      },

      '2002' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2002-06-19',
            DATE_END => '2002-06-28'
          } 
        }
      },

      '2004' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-06-20',
            DATE_END => '2004-07-02'
          } 
        }
      },

      '2006' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-08-17',
            DATE_END => '2006-08-25'
          } 
        }
      },

      '2008' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-06-19',
            DATE_END => '2008-06-27'
          }
        }
      },

      '2010' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-06-23',
            DATE_END => '2010-07-02'
          }
        }
      },

      '2012' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-13',
            DATE_END => '2012-06-22'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-06-22',
            DATE_END => '2014-07-01'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-19',
            DATE_END => '2016-06-25'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-06-10',
            DATE_END => '2018-06-16'
          } 
        }
      },

      '2022' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-06-16',
            DATE_END => '2022-06-22'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-06-28',
            DATE_END => '2024-07-04'
          } 
        }
      },
    }
  },

  'European Transnnational Mixed Teams' => 
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-06-18',
            DATE_END => '2005-06-18'
          },
          'C1' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2005-06-19',
            DATE_END => '2005-06-19'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2005-06-20',
            DATE_END => '2005-06-20'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2005-06-20',
            DATE_END => '2005-06-20'
          },
          'C4' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-21',
            DATE_END => '2005-06-21'
          },
          'C5' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-21',
            DATE_END => '2005-06-21'
          },
          'C6' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-22',
            DATE_END => '2005-06-22'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'European National Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-06-18',
            DATE_END => '2011-06-18'
          },
          'C1' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-06-19',
            DATE_END => '2011-06-19'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2011-06-20',
            DATE_END => '2011-06-20'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-06-20',
            DATE_END => '2011-06-20'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-21',
            DATE_END => '2011-06-21'
          },
          'C5' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-21',
            DATE_END => '2011-06-21'
          },
          'C6' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-22',
            DATE_END => '2011-06-22'
          } 
        }
      },
    }
  },

  'European Transnational Open Pairs' => 
  {
    ORIGIN => 'Transnational',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'European Transnational Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            DATE_START => '2011-06-27',
            DATE_END => '2011-06-28'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            DATE_START => '2011-06-29',
            DATE_END => '2011-06-30'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-07-01',
            DATE_END => '2011-07-02'
          },
        }
      },
    }
  },

  'Generali European Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'Generali European Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Qualifying',
            DATE_START => '1997-06-15',
            DATE_END => '1997-06-28'
          },
        }
      },

      '2001' =>
      {
        MEET => 'Generali European Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            STAGE => 'Qualifying',
            DATE_START => '2001-06-17',
            DATE_END => '2001-06-30'
          },
        }
      },
    }
  },

  'Generali European Women Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'Generali European Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Qualifying',
            DATE_START => '1997-06-15',
            DATE_END => '1997-06-16'
          },
          'C1' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            DATE_START => '1997-06-16',
            DATE_END => '1997-06-17'
          }
        }
      },
    }
  },

  'Generali European Women Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'Generali European Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Qualifying',
            DATE_START => '1997-06-18',
            DATE_END => '1997-06-27'
          },
        }
      },
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_EUROADULT, \%TOURNAMENTS_EUROADULT, 'Europe');
}

1;
