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
  'FISU World University Championships' => 
  {
    # https://www.fisu.net/results/?related-sport=bridge
    ORGANIZATION => 'FISU',
    ZONE => 'World',
    AGE => 'U31',
    
    EDITIONS => 
    {
      '2006' =>
      {
        # https://www.fisu.net/events/2006-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2006,
        CITY => 'Tianjin',
        COUNTRY => 'China',
        DATE_START => '2006-10-21',
        DATE_END => '2006-10-26'
      },
      '2008' =>
      {
        # https://www.fisu.net/events/2008-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2008,
        CITY => 'Lodz',
        COUNTRY => 'Poland',
        DATE_START => '2008-09-03',
        DATE_END => '2008-09-08'
      },
      '2010' =>
      {
        # https://www.fisu.net/events/2010-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2010,
        CITY => 'Kaohsiung',
        COUNTRY => 'Chinese Taipei',
        DATE_START => '2010-08-02',
        DATE_END => '2010-08-09'
      },
      '2012' =>
      {
        # https://www.fisu.net/events/2012-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2012,
        CITY => 'Reims',
        COUNTRY => 'France',
        DATE_START => '2012-07-10',
        DATE_END => '2012-07-15'
      },
      '2014' =>
      {
        # https://www.fisu.net/events/2014-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2014,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2014-11-01',
        DATE_END => '2014-11-06'
      },
      '2016' =>
      {
        # https://www.fisu.net/events/2016-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2016,
        CITY => 'Lodz',
        COUNTRY => 'Poland',
        DATE_START => '2016-08-23',
        DATE_END => '2016-08-28'
      },
      '2018' =>
      {
        # https://www.fisu.net/events/2018-fisu-world-university-championships-bridge/?utm_source=results
        YEAR => 2018,
        CITY => 'Xuzhou',
        COUNTRY => 'China',
        DATE_START => '2018-10-25',
        DATE_END => '2018-10-28'
      },
      '2020' =>
      {
        # https://www.fisu.net/events/2020-fisu-world-university-championships-mind-sports/?utm_source=results
        YEAR => 2020,
        CITY => 'Bydgoszcz',
        COUNTRY => 'Poland',
        DATE_START => '2020-10-26',
        DATE_END => '2020-10-30'
      },
      '2022' =>
      {
        # https://www.fisu.net/events/2022-fisu-world-university-championships-mind-sports/?utm_source=results
        YEAR => 2022,
        CITY => 'Antwerpen',
        COUNTRY => 'Belgium',
        DATE_START => '2022-09-12',
        DATE_END => '2022-09-17'
      },
      '2024' =>
      {
        # https://www.fisu.net/events/2024-fisu-world-university-championships-mind-sports/?utm_source=results
        YEAR => 2024,
        CITY => 'Entebbe',
        COUNTRY => 'Uganda',
        DATE_START => '2024-06-25',
        DATE_END => '2024-06-30'
      },
    }
  },

  'IMSA Elite Mind Games' => 
  {
    ORGANIZATION => 'CCBA',
    ZONE => 'World',
    COUNTRY => 'China',
    
    EDITIONS => 
    {
      '2016' =>
      {
        # http://db.worldbridge.org/Repository/tourn/HuaiAn.16/microSite/results.htm
        ORDINAL => 1,
        YEAR => 2016,
        CITY => 'Huai An',
        DATE_START => '2016-02-26',
        DATE_END => '2016-03-03'
      },
      '2017' =>
      {
        # http://db.worldbridge.org/Repository/tourn/HuaiAn.17/microSite/results.htm
        ORDINAL => 2,
        YEAR => 2017,
        CITY => 'Huai An',
        DATE_START => '2017-12-09',
        DATE_END => '2017-12-15'
      },
    }
  },

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
      '1998' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Lille.98/Lille.htm#table
        YEAR => 1998,
        CITY => 'Lille',
        COUNTRY => 'France',
        DATE_START => '1998-08-21',
        DATE_END => '1998-09-04'
      },
      '2002' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Montreal.02/Results.htm
        YEAR => 2002,
        CITY => 'Montreal',
        COUNTRY => 'Canada',
        DATE_START => '2002-08-16',
        DATE_END => '2002-08-31'
      },
      '2006' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Verona.06/Results.htm
        YEAR => 2006,
        CITY => 'Verona',
        COUNTRY => 'Italy',
        DATE_START => '2006-06-09',
        DATE_END => '2006-06-24'
      },
      '2010' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Philadelphia.10/Results.asp
        YEAR => 2010,
        CITY => 'Philadelphia',
        COUNTRY => 'USA',
        DATE_START => '2010-10-01',
        DATE_END => '2010-10-16'
      },
      '2014' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Sanya.14/microSite/results.htm
        YEAR => 2014,
        CITY => 'Sanya',
        COUNTRY => 'China',
        DATE_START => '2014-10-10',
        DATE_END => '2014-10-25'
      },
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

  'World Youth Championships' =>
  {
    ORGANIZATION => 'WBF',
    ZONE => 'World',

    EDITIONS => 
    {
      '2001' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Mangaratiba.01/Mangaratiba.htm
        ORDINAL => 8,
        YEAR => 2001,
        CITY => 'Rio de Janeiro',
        COUNTRY => 'Brazil',
        DATE_START => '2001-08-06',
        DATE_END => '2001-08-15'
      },
      '2003' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Paris.03/Paris.htm
        ORDINAL => 9,
        YEAR => 2003,
        CITY => 'Paris',
        COUNTRY => 'France',
        DATE_START => '2003-08-18',
        DATE_END => '2003-08-28'
      },
      '2005' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Sydney.05/Sydney.htm
        ORDINAL => 10,
        YEAR => 2005,
        CITY => 'Sydney',
        COUNTRY => 'Australia',
        DATE_START => '2005-08-07',
        DATE_END => '2005-08-17'
      },
      '2006' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Bangkok.06/Bangkok.htm
        ORDINAL => 11,
        YEAR => 2006,
        CITY => 'Bangkok',
        COUNTRY => 'Thailand',
        DATE_START => '2006-07-29',
        DATE_END => '2006-08-08'
      },
      '2012' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Taicang.12/microSite/Taicang.htm
        ORDINAL => 14,
        YEAR => 2012,
        CITY => 'Taicang',
        COUNTRY => 'China',
        DATE_START => '2012-07-25',
        DATE_END => '2012-08-04'
      },
      '2014' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Istanbul.14/microSite/results.htm
        ORDINAL => 15,
        YEAR => 2014,
        CITY => 'Istanbul',
        COUNTRY => 'Turkey',
        DATE_START => '2014-08-13',
        DATE_END => '2014-08-23'
      },
      '2016' =>
      {
        # http://db.worldbridge.org/Repository/tourn/salsomaggiore.16/microSite/results.htm
        ORDINAL => 16,
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        COUNTRY => 'Italy',
        DATE_START => '2016-08-03',
        DATE_END => '2016-08-13'
      },
      '2018' =>
      {
        # http://db.worldbridge.org/repository/tourn/suzhou.18/microsite/Results.htm
        ORDINAL => 17,
        YEAR => 2018,
        CITY => 'Wujiang',
        COUNTRY => 'China',
        DATE_START => '2018-08-08',
        DATE_END => '2018-08-18'
      },
      '2023' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Veldhoven.23/microSite/Results.htm
        ORDINAL => 18,
        YEAR => 2023,
        CITY => 'Veldhoven',
        COUNTRY => 'Netherlands',
        DATE_START => '2023-07-31',
        DATE_END => '2023-08-07'
      },
    }
  },

  'World Youth Open Championships' =>
  {
    ORGANIZATION => 'WBF',
    ZONE => 'World',

    EDITIONS => 
    {
      '2009' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Istanbul.09/Istanbul.htm
        ORDINAL => 1,
        YEAR => 2009,
        CITY => 'Istanbul',
        COUNTRY => 'Turkey',
        DATE_START => '2009-08-15',
        DATE_END => '2009-08-23'
      },
      '2011' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Opatija.11/Opatija11.htm
        ORDINAL => 2,
        YEAR => 2011,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2011-08-22',
        DATE_END => '2011-08-30'
      },
      '2013' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Atlanta.13/microSite/results.htm
        ORDINAL => 3,
        YEAR => 2013,
        CITY => 'Atlanta',
        COUNTRY => 'USA',
        DATE_START => '2013-08-03',
        DATE_END => '2013-08-11'
      },
      '2015' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Opatija.15/microSite/results.htm
        ORDINAL => 4,
        YEAR => 2015,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2015-08-20',
        DATE_END => '2015-08-29'
      },
      '2017' =>
      {
        # http://db.worldbridge.org/Repository/tourn/lyonyouth.17/microSite/results.htm
        ORDINAL => 5,
        YEAR => 2017,
        CITY => 'Lyon',
        COUNTRY => 'France',
        DATE_START => '2017-08-15',
        DATE_END => '2017-08-24'
      },
      '2019' =>
      {
        # http://db.worldbridge.org/Repository/tourn/opatija.19/microSite/Results.htm
        ORDINAL => 6,
        YEAR => 2019,
        CITY => 'Opatija',
        COUNTRY => 'Croatia',
        DATE_START => '2019-08-20',
        DATE_END => '2019-08-29'
      },
      '2022' =>
      {
        # http://db.worldbridge.org/Repository/tourn/salsoyouth.22/microSite/Results.htm
        ORDINAL => 7,
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        COUNTRY => 'Italy',
        DATE_START => '2022-10-08',
        DATE_END => '2022-10-10'
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

  # TODO Same as World Junior Open Teams?
  'Damiani Trophy' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2010' =>
      {
        
        # http://db.worldbridge.org/Repository/tourn/Philadelphia.10/Philadelphia.htm
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-14',
            DATE_END => '2010-10-14'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-15',
            DATE_END => '2010-10-16'
          },
        }
      }
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

  'Huayuan Cup' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
        }
      },
      '2011' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-05',
            DATE_END => '2011-09-07'
          },
        }
      },
      '2013' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-14',
            DATE_END => '2013-10-16'
          },
        }
      },
      '2015' =>
      {
        CITY => 'Beijing',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-11-09',
            DATE_END => '2015-11-11'
          },
        }
      },
    }
  },


  'IMSA Elite Open Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-03-02',
            DATE_END => '2016-03-03'
          },
        }
      },
    }
  },

  'IMSA Elite Open Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-02-29',
            DATE_END => '2016-03-03'
          },
        }
      },
    }
  },

  'IMSA Elite Open Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-02-26',
            DATE_END => '2016-02-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-02-28',
            DATE_END => '2016-02-28'
          },
        }
      },
    }
  },

  'IMSA Elite Women Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-03-02',
            DATE_END => '2016-03-03'
          },
        }
      },
    }
  },

  'IMSA Elite Women Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-02-29',
            DATE_END => '2016-03-03'
          },
        }
      },
    }
  },

  'IMSA Elite Women Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'IMSA Elite Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-02-26',
            DATE_END => '2016-02-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2016-02-28',
            DATE_END => '2016-02-28'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-02-28',
            DATE_END => '2016-02-28'
          },
        }
      },
    }
  },

  'IOC Grand Prix' => 
  {
    ORGANIZER => 'IOC',
    ZONE => 'World',
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1998' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            DATE_START => '1998-09-11',
            DATE_END => '1998-09-11'
          },
        }
      },
      '2002' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Salt%20Lake.02/Results.htm
        CITY => 'Salt Lake City',
        COUNTRY => 'USA',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
            DATE_START => '2002-02-02',
            DATE_END => '2002-02-02'
          },
          'C1' => 
          {
            YEAR => 2002,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2002-02-04',
            DATE_END => '2002-02-05'
          },
          'C2' => 
          {
            YEAR => 2002,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2002-02-06',
            DATE_END => '2002-02-06'
          },
        }
      },
    }
  },

  'McConnell Cup' => 
  {
    ORGANIZER => 'WBF',
    ZONE => 'World',
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-06-21',
            DATE_END => '2006-06-21'
          },
        }
      },
      '2010' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-12',
            DATE_END => '2010-10-12'
          },
        }
      },
      '2014' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-22',
            DATE_END => '2014-10-22'
          },
        }
      },
    }
  },

  'Oly-Star Cup' => 
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-07-12',
            DATE_END => '2011-07-21'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-07-21',
            DATE_END => '2011-07-22'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2011-07-22',
            DATE_END => '2011-07-24'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-22',
            DATE_END => '2011-07-24'
          },
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-06',
            DATE_END => '2012-06-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-09'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-09',
            DATE_END => '2012-06-10'
          },
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-10',
            DATE_END => '2013-07-12'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-13'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-13',
            DATE_END => '2013-07-14'
          },
        }
      },
    }
  },

  'APBF Women Elite Tournament' => 
  {
    ORIGIN => 'International',
    ORGANIZER => 'APBF',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-10-18',
            DATE_END => '2006-10-19'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-10-20',
            DATE_END => '2006-10-21'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2006-10-21',
            DATE_END => '2006-10-21'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-10-21',
            DATE_END => '2006-10-21'
          },
        }
      },
    }
  },

  # TODO Same as some World Junior...?
  'Rona Cup' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2010' =>
      {
        
        # http://db.worldbridge.org/Repository/tourn/Philadelphia.10/Philadelphia.htm
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-13',
            DATE_END => '2010-10-13'
          },
        }
      }
    }
  },

  'Rosenblum Cup' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1998' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1998,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '1998-08-24',
            DATE_END => '1998-08-26'
          },
          'C1' => 
          {
            YEAR => 1998,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '1998-08-27',
            DATE_END => '1998-08-27'
          },
          'C2' => 
          {
            YEAR => 1998,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '1998-08-28',
            DATE_END => '1998-08-28'
          },
          'C3' => 
          {
            YEAR => 1998,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '1998-08-29',
            DATE_END => '1998-08-29'
          },
          'C4' => 
          {
            YEAR => 1998,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '1998-08-30',
            DATE_END => '1998-08-30'
          },
          'C5' => 
          {
            YEAR => 1998,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '1998-08-31',
            DATE_END => '1998-08-31'
          },
          'C6' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1998-09-01',
            DATE_END => '1998-09-01'
          },
        }
      },
      '2002' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2002-08-20',
            DATE_END => '2002-08-22'
          },
          'C1' => 
          {
            YEAR => 2002,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2002-08-23',
            DATE_END => '2002-08-23'
          },
          'C2' => 
          {
            YEAR => 2002,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2002-08-24',
            DATE_END => '2002-08-24'
          },
          'C3' => 
          {
            YEAR => 2002,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2002-08-25',
            DATE_END => '2002-08-25'
          },
          'C4' => 
          {
            YEAR => 2002,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2002-08-26',
            DATE_END => '2002-08-26'
          },
          'C5' => 
          {
            YEAR => 2002,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2002-08-27',
            DATE_END => '2002-08-27'
          },
          'C6' => 
          {
            YEAR => 2002,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2002-08-28',
            DATE_END => '2002-08-28'
          },
        }
      },
      '2006' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-06-13',
            DATE_END => '2006-06-15'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2006-06-16',
            DATE_END => '2006-06-16'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2006-06-17',
            DATE_END => '2006-06-17'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2006-06-18',
            DATE_END => '2006-06-18'
          },
          'C4' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-06-19',
            DATE_END => '2006-06-19'
          },
          'C5' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-06-20',
            DATE_END => '2006-06-20'
          },
          'C6' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-06-21',
            DATE_END => '2006-06-21'
          },
        }
      },
      '2010' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-10-05',
            DATE_END => '2010-10-07'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2010-10-08',
            DATE_END => '2010-10-08'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2010-10-09',
            DATE_END => '2010-10-09'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-10-10',
            DATE_END => '2010-10-10'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-11',
            DATE_END => '2010-10-11'
          },
          'C5' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-12',
            DATE_END => '2010-10-12'
          },
          'C6' => 
          {
            YEAR => 2010,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2010-10-13',
            DATE_END => '2010-10-13'
          },
          'C7' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-13',
            DATE_END => '2010-10-13'
          },
        }
      },
      '2014' =>
      {
        
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-10-18',
            DATE_END => '2014-10-18'
          },
          'C1' => 
          {
            # Confusing to call this a semifinal
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-19',
            DATE_END => '2014-10-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-10-20',
            DATE_END => '2014-10-20'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-10-20',
            DATE_END => '2014-10-21'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-21',
            DATE_END => '2014-10-22'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-22',
            DATE_END => '2014-10-22'
          },
        }
      }
    }
  },

  'Tianjin Binhai Cup' => 
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-14'
          },
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

  'World Girl Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-07-25',
            DATE_END => '2012-08-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-20'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-21',
            DATE_END => '2014-08-21'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-23'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-23'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-10',
            DATE_END => '2016-08-10'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-11',
            DATE_END => '2016-08-11'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-12',
            DATE_END => '2016-08-13'
          }
        }
      },
    }
  },

  'World Junior Open Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-22',
            DATE_END => '2011-08-26'
          } 
        }
      },
    }
  },

  'World Junior Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-08-08',
            DATE_END => '2005-08-15'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-08-15',
            DATE_END => '2005-08-16'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2005-08-16',
            DATE_END => '2005-08-16'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-08-16',
            DATE_END => '2005-08-17'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-07-30',
            DATE_END => '2006-08-05'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-08',
            DATE_END => '2006-08-08'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-08',
            DATE_END => '2006-08-08'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-13',
            DATE_END => '2010-10-16'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-13',
            DATE_END => '2010-10-13'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-14',
            DATE_END => '2010-10-14'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-15',
            DATE_END => '2010-10-16'
          },
        }
      },
      '2012' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-26',
            DATE_END => '2012-07-31'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-01',
            DATE_END => '2012-08-01'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-02',
            DATE_END => '2012-08-02'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-03',
            DATE_END => '2012-08-04'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-09'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-10',
            DATE_END => '2016-08-10'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-11',
            DATE_END => '2016-08-11'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2016-08-12',
            DATE_END => '2016-08-12'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-12',
            DATE_END => '2016-08-13'
          } 
        }
      },
    }
  },

  'World Kids Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Kids',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-18'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-13'
          } 
        }
      },
    }
  },

  'World Masters Individual' => 
  {
    ORIGIN => 'International',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Athens.00/Athens.htm
        ORDINAL => 5,
        CITY => 'Athens',
        COUNTRY => 'Greece',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            major => 'SESSION',
            DATE_START => '2000-04-13',
            DATE_END => '2000-04-15'
          },
        }
      },
      '2004' =>
      {
        # http://db.worldbridge.org/Repository/tourn/Verona.04/Results.htm
        ORDINAL => 6,
        CITY => 'Verona',
        COUNTRY => 'Italy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SESSION',
            DATE_START => '2004-09-08',
            DATE_END => '2004-09-10'
          },
        }
      },
    }
  },

  'World Mixed Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'TABLE',
            DATE_START => '2014-10-13',
            DATE_END => '2014-10-17'
          },
        }
      }
    }
  },

  'World Mixed Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-10-11',
            DATE_END => '2014-10-11'
          },
          'C1' => 
          {
            # Confusing to call this a semifinal
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-12',
            DATE_END => '2014-10-12'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-10-13',
            DATE_END => '2014-10-13'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-10-13',
            DATE_END => '2014-10-13'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-14',
            DATE_END => '2014-10-14'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-14',
            DATE_END => '2014-10-14'
          },
          'C6' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-10-15',
            DATE_END => '2014-10-15'
          },
        }
      }
    }
  },

  'World Open Pairs' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2006-06-22',
            DATE_END => '2006-06-24'
          },
        }
      },
      '2010' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-14',
            DATE_END => '2010-10-16'
          },
        }
      },
      '2014' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'TABLE',
            DATE_START => '2014-10-24',
            DATE_END => '2014-10-25'
          },
        }
      }
    }
  },

  'World Top Tournament' => 
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',
    SPONSOR => 'Cap Gemini',

    EDITIONS =>
    {
      '1997' =>
      {
        ORDINAL => 11,
        CITY => 'The Hague',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            DATE_START => '1997-01-16',
            DATE_END => '1997-01-19'
          },
        }
      },
      '1998' =>
      {
        ORDINAL => 12,
        CITY => 'The Hague',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            DATE_START => '1998-01-15',
            DATE_END => '1998-01-18'
          },
        }
      },
      '1999' =>
      {
        ORDINAL => 13,
        CITY => 'The Hague',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1999,
            DATE_START => '1999-01-14',
            DATE_END => '1999-01-17'
          },
        }
      },
      '2000' =>
      {
        ORDINAL => 14,
        CITY => 'The Hague',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-03-23',
            DATE_END => '2000-03-26'
          },
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-02',
            DATE_END => '2004-11-06'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-17',
            DATE_END => '2008-10-17'
          },
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
            DATE_END => '2012-08-23'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-22',
            DATE_END => '2012-08-23'
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            DATE_START => '2013-09-24',
            DATE_END => '2013-09-26'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-27',
            DATE_END => '2013-09-27'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-28'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-09-29',
            DATE_END => '2013-09-29'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-29',
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

  'World Open Girl Pairs' =>
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-06'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-23'
          } 
        }
      },
    }
  },

  'World Open Girl Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-24',
            DATE_END => '2015-08-28'
          } 
        }
      },
    }
  },

  'World Open Junior IMP Pairs' =>
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-20',
            DATE_END => '2009-08-23'
          } 
        }
      },
    }
  },

  'World Open Junior Pairs' =>
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-20',
            DATE_END => '2009-08-23'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-28',
            DATE_END => '2011-08-30'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-06'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-23'
          } 
        }
      },
    }
  },

  'World Open Junior Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-15',
            DATE_END => '2009-08-19'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-08-06',
            DATE_END => '2013-08-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-08',
            DATE_END => '2013-08-08'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-09'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-09'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-24'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-08-24',
            DATE_END => '2015-08-25'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-26',
            DATE_END => '2015-08-26'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-27',
            DATE_END => '2015-08-27'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-08-28',
            DATE_END => '2015-08-28'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-28',
            DATE_END => '2015-08-28'
          } 
        }
      },
    }
  },

  'World Open Youngster Pairs' =>
  {
    ORIGIN => 'International',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Youngsters',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-06'
          } 
        }
      },
    }
  },

  'World Open Youngster Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Youngsters',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-06',
            DATE_END => '2013-08-09'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-24',
            DATE_END => '2015-08-28'
          } 
        }
      },
    }
  },

  'World Open Youth BAM Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-24',
            DATE_END => '2011-08-27'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-08',
            DATE_END => '2013-08-11'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'World Youth Open Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-26',
            DATE_END => '2015-08-29'
          } 
        }
      },
    }
  },

  'World University Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'FISU World University Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-10-31',
            DATE_END => '2006-10-31'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'FISU World University Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'FISU World University Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-03',
            DATE_END => '2010-08-09'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'FISU World University Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-07-10',
            DATE_END => '2012-07-15'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'FISU World University Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-23',
            DATE_END => '2016-08-28'
          } 
        }
      },
    }
  },

  'World Youngster Teams' =>
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Youngsters',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-07-30',
            DATE_END => '2006-08-08'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'World Series',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-10',
            DATE_END => '2010-10-16'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-07-25',
            DATE_END => '2012-08-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-20'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-21'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-23'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-23'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'World Youth Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-09'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-10',
            DATE_END => '2016-08-10'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-11',
            DATE_END => '2016-08-11'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2016-08-12',
            DATE_END => '2016-08-12'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-12',
            DATE_END => '2016-08-13'
          },
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
            major => 'ROUND',
            DATE_START => '2011-12-14',
            DATE_END => '2011-12-16'
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
            major => 'ROUND',
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
            major => 'ROUND',
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
            major => 'ROUND',
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
            major => 'ROUND',
            DATE_START => '2011-12-09',
            DATE_END => '2011-12-13'
          },
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
            DATE_START => '2012-12-13',
            DATE_END => '2012-12-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
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
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-12-12',
            DATE_END => '2013-12-13'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-14',
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
            major => 'ROUND',
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
            major => 'ROUND',
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
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-12-13',
            DATE_END => '2011-12-14'
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
            major => 'SESSION',
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
            STAGE => 'Final',
            major => 'SESSION',
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
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2008-10-04',
            DATE_END => '2008-10-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-13'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-14',
            DATE_END => '2008-10-15'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-16'
          },
          'C4' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-12'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-08-10',
            DATE_END => '2012-08-14'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-08-15',
            DATE_END => '2012-08-16'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-17',
            DATE_END => '2012-08-18'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-19',
            DATE_END => '2012-08-20'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-08-22'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-08-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
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
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-10-04',
            DATE_END => '2008-10-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-11'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-13'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-14',
            DATE_END => '2008-10-15'
          },
          'C4' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-17'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-08-11',
            DATE_END => '2012-12-14'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-08-15',
            DATE_END => '2012-12-16'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-17',
            DATE_END => '2012-12-18'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-19',
            DATE_END => '2012-12-20'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-12-22'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-12-22'
          } 
        }
      },
    }
  },

  'WMG U21 Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-10-06',
            DATE_END => '2008-10-07'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-10-12',
            DATE_END => '2008-10-12'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-13',
            DATE_END => '2008-10-13'
          } 
        }
      },
    }
  },

  'WMG U26 Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-10-04',
            DATE_END => '2008-10-07'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-10-08',
            DATE_END => '2008-10-11'
          } 
        }
      },
    }
  },

  'WMG U28 Teams' => 
  {
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U28',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-10-04',
            DATE_END => '2008-10-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-11'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-12'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-13',
            DATE_END => '2008-10-13'
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
            major => 'ROUND',
            DATE_START => '2011-12-14',
            DATE_END => '2011-12-16'
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
            major => 'ROUND',
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
            major => 'ROUND',
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
            major => 'ROUND',
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
            major => 'SESSION',
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
            major => 'SESSION',
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
            major => 'SESSION',
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
            major => 'SESSION',
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
      '2008' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2008-10-04',
            DATE_END => '2008-10-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-11',
            DATE_END => '2008-10-13'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-14',
            DATE_END => '2008-10-15'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-16'
          },
          'C4' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2008-10-16',
            DATE_END => '2008-10-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-13'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-08-11',
            DATE_END => '2012-08-14'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-08-15',
            DATE_END => '2012-08-16'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-17',
            DATE_END => '2012-08-18'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-19',
            DATE_END => '2012-08-20'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-08-22'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-21',
            DATE_END => '2012-08-22'
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
            STAGE => 'Final',
            major => 'SESSION',
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
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-12-12',
            DATE_END => '2013-12-13'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-12-14',
            DATE_END => '2013-12-14'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-14',
            DATE_END => '2013-12-14'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'World Mind Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
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
