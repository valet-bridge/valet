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
  }
);

my %TOURNAMENTS_WORLD =
(
  'Bermuda Bowl' => 
  {
    ORIGIN => 'International',
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
            YEAR => 1997,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '1997-10-26',
            DATE_END => '1997-10-27'
          },
          'C2' => 
          {
            YEAR => 1997,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
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

  'Venice Cup' => 
  {
    ORIGIN => 'International',
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
            YEAR => 1997,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
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

  "d'Orsi" => 
  {
    ORIGIN => 'International',
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

  'World Transnational Open Teams' => 
  {
    ORIGIN => 'Transnational',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
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
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_WORLD, \%TOURNAMENTS_WORLD, 'World');
}

1;
