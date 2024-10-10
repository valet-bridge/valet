#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::World;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_WORLD =
(
  'World Olympiad' =>
  {
    ORGANIZATION => 'WBF',
    ZONE => 'World',

    EDITIONS => 
    {
      '1996' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Rhodes.96/rhodes.htm
        YEAR => 1996,
        CITY => 'Rhodes',
        COUNTRY => 'Greece',
        DATE_START => '1996-10-19',
        DATE_END => '1996-11-02'
      },
      '2000' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Maastricht.00/default.htm
        YEAR => 2000,
        CITY => 'Maastricht',
        COUNTRY => 'Netherlands',
        DATE_START => '2000-08-26',
        DATE_END => '2000-09-09'
      },
      '2004' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Istanbul.04/Results.htm
        YEAR => 2004,
        CITY => 'Istanbul',
        COUNTRY => 'Turkey',
        DATE_START => '2004-10-23',
        DATE_END => '2004-11-06'
      },
    }
  },

  'World Series' =>
  {
    ORGANIZATION => 'WBF',
    ZONE => 'World',

    EDITIONS => 
    {
      '2016' =>
      {
        # http://db.worldbridge.org/Repository/tourn/wroclaw.16/microSite/results.htm
        YEAR => 2016,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2016-09-03',
        DATE_END => '2016-09-17'
      },
      '2022' =>
      {
        # http://db.worldbridge.org/Repository/tourn/wroclaw.22/microSite/Results.htm
        YEAR => 2022,
        CITY => 'Wroclaw',
        COUNTRY => 'Poland',
        DATE_START => '2022-08-19',
        DATE_END => '2022-09-03'
      },
    },
  },

  'World Mind Games' =>
  {
    ORGANIZATION => 'IMSA',
    ZONE => 'World',

    EDITIONS => 
    {
      '2008' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Beijing.08/Beijing.htm
        YEAR => 2008,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '2008-10-03',
        DATE_END => '2008-10-18'
      },
      '2011' =>
      {
        # No link
        YEAR => 2011,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '2011-12-09',
        DATE_END => '2011-12-15'
      },
      '2012A' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Lille.12/microSite/Lille.htm
        YEAR => 2012,
        CITY => 'Lille',
        COUNTRY => 'France',
        DATE_START => '2012-08-09',
        DATE_END => '2012-08-23'
      },
      '2012B' =>
      {
        # No link
        YEAR => 2012,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '2012-12-13',
        DATE_END => '2012-12-19'
      },
      '2013' =>
      {
        # No link
        YEAR => 2013,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '2013-12-12',
        DATE_END => '2013-12-18'
      },
      '2014' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Beijing.14/microSite/results.htm
        YEAR => 2014,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '2014-12-11',
        DATE_END => '2014-12-17'
      },
    }
  },

  'World Team Championships' =>
  {
    ORGANIZATION => 'WBF',
    ZONE => 'World',

    EDITIONS => 
    {
      '1995' =>
      {
        YEAR => 1995,
        CITY => 'Beijing',
        COUNTRY => 'China',
        DATE_START => '1995-10-08',
        DATE_END => '1995-10-10'
      },
      '1997' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Tunisia.97/hammamet.htm
        YEAR => 1997,
        CITY => 'Hammamet',
        COUNTRY => 'Tunisia',
        DATE_START => '1997-10-19',
        DATE_END => '1997-11-01'
      },
      '2000' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Bermuda.00/default.htm
        YEAR => 2000,
        CITY => 'Southampton',
        COUNTRY => 'Bermuda',
        DATE_START => '2000-01-08',
        DATE_END => '2000-01-21'
      },
      '2001' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Paris.01/Paris.htm
        YEAR => 2001,
        CITY => 'Paris',
        COUNTRY => 'France',
        DATE_START => '2001-10-21',
        DATE_END => '2001-11-03'
      },
      '2003' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Montecarlo.03/Monaco.htm
        YEAR => 2003,
        CITY => 'Monte Carlo',
        COUNTRY => 'Monaco',
        DATE_START => '2003-11-02',
        DATE_END => '2003-11-15'
      },
      '2005' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Estoril.05/Estoril.htm
        YEAR => 2005,
        CITY => 'Estoril',
        COUNTRY => 'Portugal',
        DATE_START => '2005-10-22',
        DATE_END => '2005-11-05'
      },
      '2007' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Shanghai.07/Shanghai.htm
        YEAR => 2007,
        CITY => 'Shanghai',
        COUNTRY => 'China',
        DATE_START => '2007-09-29',
        DATE_END => '2007-10-13'
      },
      '2009' =>
      {
        # http://db.worldbridge.org/Repository/tourn/SaoPaulo.09/SaoPaulo.htm
        YEAR => 2009,
        CITY => 'São Paulo',
        COUNTRY => 'Brazil',
        DATE_START => '2009-08-29',
        DATE_END => '2009-09-12'
      },
      '2011' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Veldhoven.11/Veldhoven.htm
        YEAR => 2011,
        CITY => 'Veldhoven',
        COUNTRY => 'Netherlands',
        DATE_START => '2011-09-15',
        DATE_END => '2011-09-29'
      },
      '2013' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Bali.13/microSite/results.htm
        YEAR => 2013,
        CITY => 'Bali',
        COUNTRY => 'Indonesia',
        DATE_START => '2013-09-16',
        DATE_END => '2013-09-29'
      },
      '2015' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Chennai.15/microSite/results.htm
        YEAR => 2015,
        CITY => 'Chennai',
        COUNTRY => 'India',
        DATE_START => '2015-09-26',
        DATE_END => '2015-10-10'
      },
      '2017' =>
      {
        # http://db.worldbridge.org/Repository/tourn/lyon.17/microSite/results.htm
        YEAR => 2017,
        CITY => 'Lyon',
        COUNTRY => 'France',
        DATE_START => '2017-08-12',
        DATE_END => '2017-12-26'
      },
      '2019' =>
      {
        # http://db.worldbridge.org/Repository/tourn/wuhan.19/microSite/Results.htm
        YEAR => 2019,
        CITY => 'Wuhan',
        COUNTRY => 'China',
        DATE_START => '2019-09-14',
        DATE_END => '2019-09-28'
      },
      '2022' =>
      {
        # http://db.worldbridge.org/Repository/tourn/salsomaggiore.22/microSite/Results.htm
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        COUNTRY => 'Italy',
        DATE_START => '2022-03-27',
        DATE_END => '2022-04-09'
      },
      '2023' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Marrakech.23/microSite/Results.htm
        YEAR => 2023,
        CITY => 'Marrakech',
        COUNTRY => 'Morocco',
        DATE_START => '2023-08-20',
        DATE_END => '2023-09-02'
      },
    }
  },
);

my %TOURNAMENTS_WORLD =
(
  'Bermuda Bowl' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1995' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1995,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1995-10-08',
            DATE_END => '1995-10-10'
          },
        }
      },
      '1997' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1997-10-20',
            DATE_END => '1997-10-25'
          },
          'C1' => 
          {
            # No counter data.
            YEAR => 1997,
            STAGE => 'Quarterfinal',
            DATE_START => '1997-10-26',
            DATE_END => '1997-10-27'
          },
          'C2' => 
          {
            # No counter data.
            YEAR => 1997,
            STAGE => 'Semifinal',
            DATE_START => '1997-10-28',
            DATE_END => '1997-10-29'
          },
          'C3' => 
          {
            YEAR => 1997,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '1997-10-30',
            DATE_END => '1997-10-30'
          },
          'C4' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1997-10-30',
            DATE_END => '1997-11-01'
          } 
        }
      },
      '2000' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2000-01-08',
            DATE_END => '2000-01-14'
          },
          'C1' => 
          {
            YEAR => 2000,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2000-01-15',
            DATE_END => '2000-01-16'
          },
          'C2' => 
          {
            YEAR => 2000,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2000-01-17',
            DATE_END => '2000-01-18'
          },
          'C3' => 
          {
            YEAR => 2000,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2000-01-19',
            DATE_END => '2000-01-19'
          },
          'C4' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-19',
            DATE_END => '2000-01-21'
          } 
        }
      },
      '2001' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2001-10-22',
            DATE_END => '2001-10-27'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2001-10-28',
            DATE_END => '2001-10-29'
          },
          'C2' => 
          {
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-10-30',
            DATE_END => '2001-10-31'
          },
          'C3' => 
          {
            YEAR => 2001,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2001-11-01',
            DATE_END => '2001-11-01'
          },
          'C4' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-11-01',
            DATE_END => '2001-11-03'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-10-23',
            DATE_END => '2005-10-29'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-10-30',
            DATE_END => '2005-10-31'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-11-01',
            DATE_END => '2005-11-02'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-03'
          },
          'C4' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-05'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-09-30',
            DATE_END => '2007-10-06'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-07',
            DATE_END => '2007-10-08'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-09',
            DATE_END => '2007-10-10'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-11'
          },
          'C4' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-13'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-30',
            DATE_END => '2009-09-05'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-06',
            DATE_END => '2009-09-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-08',
            DATE_END => '2009-09-09'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-11'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-23',
            DATE_END => '2011-10-24'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-25',
            DATE_END => '2011-10-26'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-29'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-09-17',
            DATE_END => '2013-09-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-24',
            DATE_END => '2013-09-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-26',
            DATE_END => '2013-09-27'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-27',
            DATE_END => '2015-10-03'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-04',
            DATE_END => '2015-10-05'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-06',
            DATE_END => '2015-10-07'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-09'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-10'
          } 
        }
      },
    }
  },

  "d'Orsi" => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-10-23',
            DATE_END => '2005-10-29'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-10-30',
            DATE_END => '2005-10-31'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-11-01',
            DATE_END => '2005-11-02'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-04'
          },
          'C4' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-04'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-09-30',
            DATE_END => '2007-10-06'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-07',
            DATE_END => '2007-10-08'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-09',
            DATE_END => '2007-10-10'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-11'
          },
          'C4' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-12'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-30',
            DATE_END => '2009-09-05'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-06',
            DATE_END => '2009-09-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-08',
            DATE_END => '2009-09-09'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-11'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-11'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-23',
            DATE_END => '2011-10-24'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-25',
            DATE_END => '2011-10-26'
          },
          'C3' => 
          {
            # No counter data.
            YEAR => 2011,
            STAGE => 'Playoff',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-09-17',
            DATE_END => '2013-09-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-24',
            DATE_END => '2013-09-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-26',
            DATE_END => '2013-09-27'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-27',
            DATE_END => '2015-10-03'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-04',
            DATE_END => '2015-10-05'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-06',
            DATE_END => '2015-10-07'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-09'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-09'
          } 
        }
      },
    }
  },

  'Venice Cup' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1997-10-20',
            DATE_END => '1997-10-25'
          },
          'C1' => 
          {
            YEAR => 1997,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '1997-10-26',
            DATE_END => '1997-10-27'
          },
          'C2' => 
          {
            # No counter data.
            YEAR => 1997,
            STAGE => 'Semifinal',
            DATE_START => '1997-10-28',
            DATE_END => '1997-10-29'
          },
          'C3' => 
          {
            YEAR => 1997,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '1997-10-30',
            DATE_END => '1997-10-30'
          },
          'C4' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1997-10-30',
            DATE_END => '1997-10-31'
          } 
        }
      },
      '2000' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2000-01-08',
            DATE_END => '2000-01-14'
          },
          'C1' => 
          {
            YEAR => 2000,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2000-01-15',
            DATE_END => '2000-01-16'
          },
          'C2' => 
          {
            YEAR => 2000,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2000-01-17',
            DATE_END => '2000-01-18'
          },
          'C3' => 
          {
            YEAR => 2000,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2000-01-19',
            DATE_END => '2000-01-19'
          },
          'C4' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-19',
            DATE_END => '2000-01-20'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-10-23',
            DATE_END => '2005-10-29'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-10-30',
            DATE_END => '2005-10-31'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-11-01',
            DATE_END => '2005-11-02'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-04'
          },
          'C4' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-11-03',
            DATE_END => '2005-11-04'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-09-30',
            DATE_END => '2007-10-06'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-07',
            DATE_END => '2007-10-08'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-09',
            DATE_END => '2007-10-10'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-11'
          },
          'C4' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-11',
            DATE_END => '2007-10-12'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-30',
            DATE_END => '2009-09-05'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-06',
            DATE_END => '2009-09-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-08',
            DATE_END => '2009-09-09'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-11'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-11'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-23',
            DATE_END => '2011-10-24'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-25',
            DATE_END => '2011-10-26'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-09-17',
            DATE_END => '2013-09-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-24',
            DATE_END => '2013-09-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-26',
            DATE_END => '2013-09-27'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-29'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-27',
            DATE_END => '2015-10-03'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-04',
            DATE_END => '2015-10-05'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-06',
            DATE_END => '2015-10-07'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-09'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-09'
          } 
        }
      },
    }
  },

  'World Transnational Mixed Teams' => 
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'World Olympiad',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-11-02',
            DATE_END => '2004-11-06'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2012-08-22',
            DATE_END => '2012-08-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-22',
            DATE_END => '2012-08-22'
          } 
        }
      },
    }
  },

  'World Transnational Open Teams' => 
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-10-12',
            DATE_END => '2007-10-13'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-09-07',
            DATE_END => '2009-09-10'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-10',
            DATE_END => '2009-09-10'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-11',
            DATE_END => '2009-09-11'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-11',
            DATE_END => '2009-09-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-24',
            DATE_END => '2011-10-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-27'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-28'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-28',
            DATE_END => '2011-10-28'
          },
          'C5' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-28',
            DATE_END => '2011-10-29'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Team Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-10-04',
            DATE_END => '2015-10-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-07',
            DATE_END => '2015-10-07'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-08'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-09'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-10'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-10'
          } 
        }
      },
    }
  },

  'WMG Men Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-13',
            DATE_END => '2011-12-14'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-17',
            DATE_END => '2012-12-18'
          } 
        }
      },
    }
  },

  'WMG Men Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-12',
            DATE_END => '2011-12-15'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-16',
            DATE_END => '2012-12-19'
          } 
        }
      },
    }
  },

  'WMG Men Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-09',
            DATE_END => '2011-12-13'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-13',
            DATE_END => '2012-12-15'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-12',
            DATE_END => '2013-12-14'
          } 
        }
      },
    }
  },

  'WMG Open Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-16',
            DATE_END => '2013-12-18'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-16',
            DATE_END => '2014-12-17'
          } 
        }
      },
    }
  },

  'WMG Open Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-15',
            DATE_END => '2013-12-18'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-14',
            DATE_END => '2014-12-17'
          } 
        }
      },
    }
  },

  'WMG Open Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-10',
            DATE_END => '2012-12-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-13'
          } 
        }
      },
    }
  },

  'WMG Senior Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-10',
            DATE_END => '2012-12-22'
          } 
        }
      },
    }
  },

  'WMG Women Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-14',
            DATE_END => '2011-12-15'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-18',
            DATE_END => '2012-12-19'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-17',
            DATE_END => '2013-12-18'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-16',
            DATE_END => '2014-12-17'
          } 
        }
      },
    }
  },

  'WMG Women Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-12',
            DATE_END => '2011-12-15'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-16',
            DATE_END => '2012-12-19'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-15',
            DATE_END => '2013-12-18'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-14',
            DATE_END => '2014-12-17'
          } 
        }
      },
    }
  },

  'WMG Women Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2012-12-09',
            DATE_END => '2012-12-13'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-10',
            DATE_END => '2012-12-22'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-13',
            DATE_END => '2012-12-15'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-12',
            DATE_END => '2013-12-14'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-13'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_WORLD, \%TOURNAMENTS_WORLD, 'World');
}

1;
