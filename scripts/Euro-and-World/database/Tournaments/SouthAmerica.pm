#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::SouthAmerica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Many links via Wayback Machine
# http://www.confsudbridge.org/Torneos/
# https://csbnews.org/ganadores-de-los-campeonatos-sudamericanos-19482015/

my %GLOBAL = (
  ORGANIZATION => 'CSB',
  ZONE => 'South America',
);

my %MEETS_SOUTHAMERICA =
(
  'South American Team Championship' =>
  {
    %GLOBAL,

    EDITIONS => 
    {
      '2004' =>
      {
        CITY => 'Sao Paulo',
        COUNTRY => 'Brazil',
        YEAR => 2004,
        DATE_START => '2004-06-13', # Dates unclear
        DATE_END => '2004-06-13'
      },
      '2005' =>
      {
        # ttp://www.confsudbridge.org/Torneos/Tor_0001.aspx
        MEET_ORDINAL => 55,
        CITY => 'Montevideo',
        COUNTRY => 'Uruguay',
        YEAR => 2005,
        DATE_START => '2005-06-10', # Dates unclear
        DATE_END => '2005-06-12'
      },
      '2006' =>
      {
        # http://www.confsudbridge.org/Torneos/Tor_0002.aspx
        MEET_ORDINAL => 56,
        CITY => 'Cartagena',
        COUNTRY => 'Colombia',
        YEAR => 2006,
        DATE_START => '2006-05-01', # Dates unclear
        DATE_END => '2006-05-04'
      },
      '2007' =>
      {
        # http://www.confsudbridge.org/Torneos/Tor_0004.aspx
        MEET_ORDINAL => 57,
        CITY => 'Quito',
        COUNTRY => 'Ecuador',
        YEAR => 2007,
        DATE_START => '2007-06-07', # Dates unclear
        DATE_END => '2007-06-09'
      },
      '2008' =>
      {
        # http://www.confsudbridge.org/torneos/sudamericano2008.aspx
        # 58th South American
        MEET_ORDINAL => 58,
        CITY => 'Lima',
        COUNTRY => 'Peru',
        YEAR => 2008,
        DATE_START => '2008-06-14',
        DATE_END => '2008-06-22',
      },
      '2009' =>
      {
        # http://www.confsudbridge.org/torneos/sudamericano2009.aspx
        MEET_ORDINAL => 59,
        CITY => 'Santiago',
        COUNTRY => 'Chile',
        YEAR => 2009,
        DATE_START => '2009-05-16',
        DATE_END => '2009-05-23'
      },
      '2010' =>
      {
        # http://www.confsudbridge.org/torneos/mardelplata2010.htm
        # 3rd Transnational
        MEET_ORDINAL => 60,
        CITY => 'Mar Del Plata',
        COUNTRY => 'Argentina',
        YEAR => 2010,
        DATE_START => '2010-05-01',
        DATE_END => '2010-05-08'
      },
      '2011' =>
      {
        # http://www.confsudbridge.org/torneos/sudampar2011.aspx
        # 61st South American
        MEET_ORDINAL => 61,
        CITY => 'Asuncion',
        COUNTRY => 'Paraguay',
        YEAR => 2011,
        DATE_START => '2011-06-11',
        DATE_END => '2011-06-18'
      },
      '2012' =>
      {
        # http://www.confsudbridge.org/Torneos/montevideo2012.htm
        # 4th Transnational
        MEET_ORDINAL => 62,
        CITY => 'Montevideo',
        COUNTRY => 'Uruguay',
        YEAR => 2012,
        DATE_START => '2012-05-26',
        DATE_END => '2012-06-02'
      },
      '2013' =>
      {
        # http://angra2013.csbnews.org/
        # http://www.confsudbridge.org/Torneos/angra2013.htm
        MEET_ORDINAL => 63,
        CITY => 'Angra dos Reis',
        COUNTRY => 'Brazil',
        YEAR => 2013,
        DATE_START => '2013-05-25',
        DATE_END => '2013-06-01'
      },
      '2014' =>
      {
        # http://santiago2014.csbnews.org/
        MEET_ORDINAL => 64,
        CITY => 'Santiago',
        COUNTRY => 'Chile',
        YEAR => 2014,
        DATE_START => '2014-05-17',
        DATE_END => '2014-05-24'
      },
      '2015' =>
      {
        # http://buenosaires2015.csbnews.org/
        MEET_ORDINAL => 65,
        CITY => 'Buenos Aires',
        COUNTRY => 'Argentina',
        YEAR => 2015,
        DATE_START => '2015-05-09',
        DATE_END => '2015-05-16'
      },
      '2016' =>
      {
        CITY => 'Medellin',
        COUNTRY => 'Colombia',
        YEAR => 2016,
        DATE_START => '2016-05-25',
        DATE_END => '2016-06-04'
      },
    }
  },

  'South American Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS => 
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-04-18',
        DATE_END => '2009-04-19'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-03-26',
        DATE_END => '2011-04-03'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-11-08',
        DATE_END => '2014-11-10'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-03-28',
        DATE_END => '2015-03-29'
      },
    }
  },

  'South American Zonal Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2000' =>
      {
        YEAR => 2000,
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  }
);

my %TOURNAMENTS_SOUTHAMERICA =
(
  'South American Junior Teams',
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-03',
            DATE_END => '2006-05-03'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-04',
            DATE_END => '2006-05-04'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-25',
            DATE_END => '2016-05-26'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-26',
            DATE_END => '2016-05-27'
          } 
        }
      },
    }
  },

  'South American Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'South American Open Pairs',
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2012-05-26',
            DATE_END => '2012-05-27'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2012-05-28',
            DATE_END => '2012-05-29'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 5,
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-05-19',
            DATE_END => '2014-05-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'TABLE',
            DATE_START => '2015-05-11',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-05-25',
            DATE_END => '2016-06-04'
          } 
        }
      },
    }
  },

  'South American Open Teams',
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-13',
            DATE_END => '2004-06-13'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-13',
            DATE_END => '2004-06-13'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-10',
            DATE_END => '2005-06-12'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-12',
            DATE_END => '2005-06-12'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-01',
            DATE_END => '2006-05-01'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-02',
            DATE_END => '2006-05-02'
          },
        }
      },
      '2007' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-07',
            DATE_END => '2007-06-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-09',
            DATE_END => '2007-06-09'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-22'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2009-05-21',
            DATE_END => '2009-05-22'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-22',
            DATE_END => '2009-05-23'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-05-07',
            DATE_END => '2010-05-07'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-07',
            DATE_END => '2010-05-08'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2011-06-16',
            DATE_END => '2011-06-17'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-17',
            DATE_END => '2011-06-18'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-29',
            DATE_END => '2012-05-31'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-01'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-27',
            DATE_END => '2013-05-28'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-29',
            DATE_END => '2013-05-30'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-05-30',
            DATE_END => '2013-05-31'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          },
        }
      },
      '2014' =>
      {
        MEET => 'South American Team Championship',
        ORDINAL => 5,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-05-19',
            DATE_END => '2014-05-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-05-23',
            DATE_END => '2014-05-23'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-05-24',
            DATE_END => '2014-05-24'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-08'
          },
        }
      },
      '2015B' =>
      {
        MEET => 'South American Team Championship',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-11',
            DATE_END => '2015-05-14'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-14',
            DATE_END => '2015-05-15'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-05-30',
            DATE_END => '2016-06-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-02',
            DATE_END => '2016-06-02'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-03'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-04',
            DATE_END => '2016-06-04'
          } 
        }
      },
    }
  },

  'South American Open Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'South American Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-04-18',
            DATE_END => '2009-04-19'
          } 
        }
      },
    }
  },

  'South American Senior Teams',
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2007' =>
      {
        # http://www.confsudbridge.org/Torneos/Tor_0003.aspx
        %GLOBAL,
        CITY => 'Rio de Janeiro',
        COUNTRY => 'Brazil',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-11',
            DATE_END => '2015-05-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-16'
          } 
        }
      },
    }
  },

  'South American Senior Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'South American Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            groupon => 'PLACE',
            major => 'ROUND',
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
          } 
        }
      },
    }
  },

  'South American Women Teams',
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-10',
            DATE_END => '2005-06-10'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-21',
            DATE_END => '2009-05-23'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-05-07',
            DATE_END => '2010-05-07'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-08',
            DATE_END => '2010-05-08'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-16',
            DATE_END => '2011-06-16'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-30',
            DATE_END => '2013-05-31'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'South American Team Championship',
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-05-24',
            DATE_END => '2014-05-24'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          # Could be Trials
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-08',
            DATE_END => '2015-03-09'
          },
        }
      },
      '2015B' =>
      {
        MEET => 'South American Team Championship',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-11',
            DATE_END => '2015-05-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-15',
            DATE_END => '2015-05-15'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'South American Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-04',
            DATE_END => '2016-06-04'
          } 
        }
      },
    }
  },

  'South American Women Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'South American Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-01',
            DATE_END => '2011-04-03'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'South American Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-11-08',
            DATE_END => '2014-11-10'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'South American Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-29'
          } 
        }
      },
    }
  },

  'South American Zonal Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'South American Zonal Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'South American Zonal Senior Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'South American Zonal Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SOUTHAMERICA, \%TOURNAMENTS_SOUTHAMERICA, 
    'South America');
}

1;
