#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Bulgaria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'BuBF',
  COUNTRY => 'Bulgaria',
  ZONE => 'Europe',
);

my %MEETS_BULGARIA =
(
  'Albena Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    LOCALITY => 'Albena',

    EDITIONS => 
    {
      '2008' =>
      {
        # https://www.bridgealbena.org/Albena/results2008.html
        MEET_ORDINAL => 26,
        YEAR => 2008,
        DATE_START => '2008-06-17',
        DATE_END => '2008-06-28'
      },
      '2009' =>
      {
        # https://www.bridgealbena.org/Albena/results2009.html
        MEET_ORDINAL => 27,
        YEAR => 2009,
        DATE_START => '2009-06-16',
        DATE_END => '2009-06-27'
      },
      '2010' =>
      {
        # https://www.bridgealbena.org/Albena/results2010.html
        MEET_ORDINAL => 28,
        YEAR => 2010,
        DATE_START => '2010-06-22',
        DATE_END => '2010-07-03'
      },
      '2011' =>
      {
        # https://www.bridgealbena.org/Albena/results2011.html
        MEET_ORDINAL => 29,
        YEAR => 2011,
        DATE_START => '2011-06-21',
        DATE_END => '2011-07-02'
      },
      '2012' =>
      {
        # https://www.bridgealbena.org/Albena/results2012.html
        MEET_ORDINAL => 30,
        YEAR => 2012,
        DATE_START => '2012-06-19',
        DATE_END => '2012-06-30'
      },
      '2013' =>
      {
        # https://www.bridgealbena.org/Albena/results2013.html
        MEET_ORDINAL => 31,
        YEAR => 2013,
        DATE_START => '2013-06-18',
        DATE_END => '2013-06-29'
      },
      '2014' =>
      {
        # https://www.bridgealbena.org/Albena/results2014.html
        MEET_ORDINAL => 32,
        YEAR => 2014,
        DATE_START => '2014-06-24',
        DATE_END => '2014-07-06'
      },
      '2015' =>
      {
        # https://www.bridgealbena.org/Albena/results2015.html
        MEET_ORDINAL => 33,
        YEAR => 2015,
        DATE_START => '2015-06-24',
        DATE_END => '2015-07-06'
      },
      '2016' =>
      {
        # https://www.bridgealbena.org/Albena/results2016.html
        MEET_ORDINAL => 34,
        YEAR => 2016,
        DATE_START => '2016-06-28',
        DATE_END => '2016-07-10'
      },
      '2017' =>
      {
        # https://www.bridgealbena.org/Albena/results2017.html
        MEET_ORDINAL => 35,
        YEAR => 2017,
        DATE_START => '2017-06-27',
        DATE_END => '2017-07-09'
      },
      '2018' =>
      {
        # https://www.bridgealbena.org/Albena/results2018.html
        MEET_ORDINAL => 36,
        YEAR => 2018,
        DATE_START => '2018-06-27',
        DATE_END => '2018-07-09'
      },
      '2019' =>
      {
        # https://www.bridgealbena.org/Albena/results2019.html
        MEET_ORDINAL => 37,
        YEAR => 2019,
        DATE_START => '2019-06-25',
        DATE_END => '2019-07-07'
      },
      '2020' =>
      {
        # https://www.bridgealbena.org/Albena/results2020.html
        MEET_ORDINAL => 38,
        YEAR => 2020,
        DATE_START => '2020-06-23',
        DATE_END => '2020-07-05'
      },
      '2021' =>
      {
        # https://www.bridgealbena.org/Albena/results2021.html
        MEET_ORDINAL => 39,
        YEAR => 2021,
        DATE_START => '2021-06-25',
        DATE_END => '2021-07-04'
      },
      '2022' =>
      {
        # https://www.bridgealbena.org/Albena/results2022.html
        MEET_ORDINAL => 40,
        YEAR => 2022,
        DATE_START => '2022-06-24',
        DATE_END => '2022-07-03'
      },
      '2023' =>
      {
        # https://www.bridgealbena.org/Albena/results2023.html
        MEET_ORDINAL => 41,
        YEAR => 2023,
        DATE_START => '2023-06-30',
        DATE_END => '2023-07-09'
      },
      '2024' =>
      {
        # https://www.bridgealbena.org/Albena/results2024.html
        MEET_ORDINAL => 42,
        YEAR => 2024,
        DATE_START => '2024-06-28',
        DATE_END => '2024-07-07'
      },
    }
  },

  'Cherven Briag Festival' =>
  {
    %GLOBAL,
    CITY => 'Cherven Briag',

    EDITIONS => 
    {
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-06-18',
        DATE_END => '2011-06-19'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-09-22',
        DATE_END => '2012-09-23'
      },
    }
  },

  'Dobrich Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Dobrich',

    EDITIONS => 
    {
      '2009' =>
      {
        MEET_ORDINAL => 24,
        YEAR => 2009,
        DATE_START => '2009-04-09',
        DATE_END => '2009-04-12'
      },
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1182-28th-International-Bridge-Festival-Dobrich-2013
        MEET_ORDINAL => 28,
        YEAR => 2013,
        DATE_START => '2013-04-11',
        DATE_END => '2013-04-14'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1580-29th-International-Bridge-Festival-Dobrich-2014
        MEET_ORDINAL => 29,
        YEAR => 2014,
        DATE_START => '2014-04-10',
        DATE_END => '2014-04-13'
      },
      '2015' =>
      {
        MEET_ORDINAL => 30,
        YEAR => 2015,
        DATE_START => '2015-04-18',
        DATE_END => '2015-04-19'
      },
      '2016' =>
      {
        # https://www.bridge.bg/en/tournaments/2552-31-IBF-Dobrich-2016
        MEET_ORDINAL => 31,
        YEAR => 2016,
        DATE_START => '2016-04-14',
        DATE_END => '2016-04-17'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/2912-32-IBF-Dobrich-2017
        MEET_ORDINAL => 32,
        YEAR => 2017,
        DATE_START => '2017-04-06',
        DATE_END => '2017-04-09'
      },
      '2018' =>
      {
        # https://www.bridge.bg/en/tournaments/3316-33ti-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich-2018
        MEET_ORDINAL => 33,
        YEAR => 2018,
        DATE_START => '2018-04-12',
        DATE_END => '2018-04-15'
      },
      '2019' =>
      {
        # https://www.bridge.bg/en/tournaments/3944-34th-International-Bridge-Festival-Dobrich-2019
        MEET_ORDINAL => 34,
        YEAR => 2019,
        DATE_START => '2019-04-12',
        DATE_END => '2019-04-14'
      },
      '2020' =>
      {
        # https://www.bridge.bg/en/tournaments/4475-35ti-M%D0%B5jdunarod%D0%B5n-Bridj-F%D0%B5stival-Dobrich-2020
        MEET_ORDINAL => 35,
        YEAR => 2020,
        DATE_START => '2020-04-10',
        DATE_END => '2020-04-12'
      },
      '2021' =>
      {
        # https://www.bridge.bg/en/tournaments/4887-36ti-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich
        MEET_ORDINAL => 36,
        YEAR => 2021,
        DATE_START => '2021-09-17',
        DATE_END => '2021-09-19'
      },
      '2023' =>
      {
        # https://www.bridge.bg/en/tournaments/5905-38i-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich
        MEET_ORDINAL => 38,
        YEAR => 2023,
        DATE_START => '2023-09-29',
        DATE_END => '2023-10-01'
      },
    }
  },

  'Lozenets Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Lozenets',

    EDITIONS => 
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-05-30',
        DATE_END => '2009-05-31'
      },
      '2010' =>
      {
        MEET_ORDINAL => 11,
        YEAR => 2010,
        DATE_START => '2010-05-29',
        DATE_END => '2010-05-30'
      },
      '2015' =>
      {
        MEET_ORDINAL => 16,
        YEAR => 2015,
        DATE_START => '2015-06-13',
        DATE_END => '2015-06-14'
      },
      '2017' =>
      {
        MEET_ORDINAL => 18,
        YEAR => 2017,
        DATE_START => '2017-06-10',
        DATE_END => '2017-06-11'
      },
    }
  },

  'Pavel Banya Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2018' =>
      {
        ORDINAL => 13,
        YEAR => 2018,
        DATE_START => '2018-01-06',
        DATE_END => '2018-01-07'
      },
      '2019' =>
      {
        ORDINAL => 14,
        CITY => 'Haskovski Mineralni Bani',
        YEAR => 2019,
        DATE_START => '2019-01-05',
        DATE_END => '2019-01-06'
      },
      '2020A' =>
      {
        ORDINAL => 15,
        YEAR => 2020,
        DATE_START => '2020-01-04',
        DATE_END => '2020-01-05'
      },
      '2020B' =>
      {
        YEAR => 2020,
        DATE_START => '2020-01-18',
        DATE_END => '2020-01-19'
      },
      '2021' =>
      {
        ORDINAL => 2,
        YEAR => 2021,
        DATE_START => '2021-03-13',
        DATE_END => '2021-03-14'
      },
    }
  },

  'Plovdiv Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Plovdiv',

    EDITIONS => 
    {
      '2009' =>
      {
        # https://bridge.bg/en/tournaments/7-28th-International-Bridge-Festival-Plovdiv-09
        MEET_ORDINAL => 28,
        YEAR => 2009,
        DATE_START => '2009-04-30',
        DATE_END => '2009-05-03'
      },
      '2010' =>
      {
        # https://www.bridge.bg/en/tournaments/170-29th-International-Bridge-Festival-Plovdiv-10
        MEET_ORDINAL => 29,
        YEAR => 2010,
        DATE_START => '2010-04-29',
        DATE_END => '2010-05-02'
      },
      '2011' =>
      {
        # https://new.bridge.bg/en/tournaments/541-30-International-Bridge-Festival-Plovdiv-2011
        MEET_ORDINAL => 30,
        YEAR => 2011,
        DATE_START => '2011-04-28',
        DATE_END => '2011-05-01'
      },
      '2012' =>
      {
        MEET_ORDINAL => 31,
        YEAR => 2012,
        DATE_START => '2012-05-05',
        DATE_END => '2012-05-06'
      },
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1211-32nd-International-Bridge-Festival-Plovdiv-2013
        MEET_ORDINAL => 32,
        YEAR => 2013,
        DATE_START => '2013-04-25',
        DATE_END => '2013-04-28'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1844-33-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2014
        MEET_ORDINAL => 33,
        YEAR => 2014,
        DATE_START => '2014-04-24',
        DATE_END => '2014-04-27'
      },
      '2015' =>
      {
        # https://www.bridge.bg/en/tournaments/2210-34-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2015
        MEET_ORDINAL => 34,
        YEAR => 2015,
        DATE_START => '2015-04-29',
        DATE_END => '2015-05-03'
      },
      '2016' =>
      {
        MEET_ORDINAL => 35,
        YEAR => 2016,
        DATE_START => '2016-05-07',
        DATE_END => '2016-05-08'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/2919-36-MBF-Plovdiv-2017
        MEET_ORDINAL => 36,
        YEAR => 2017,
        DATE_START => '2017-05-04',
        DATE_END => '2017-05-07'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/international-bridge-festival-plovdiv-2019
        # https://www.bridge.bg/en/tournaments/3978-38-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2019
        MEET_ORDINAL => 38,
        YEAR => 2019,
        DATE_START => '2019-03-07',
        DATE_END => '2019-03-10'
      },
      '2020' =>
      {
        # https://bridgescanner.com/event/international-bridge-festival-plovdiv-2020
        YEAR => 2020,
        DATE_START => '2020-05-07',
        DATE_END => '2020-05-10'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-05-29',
        DATE_END => '2021-05-30'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-03-05',
        DATE_END => '2022-03-06'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/international-bridge-festival-plovdiv-2024
        YEAR => 2023,
        DATE_START => '2023-03-02',
        DATE_END => '2023-03-05'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/international-bridge-festival-plovdiv-2024
        YEAR => 2024,
        DATE_START => '2024-02-29',
        DATE_END => '2024-03-04'
      },
    }
  },

  'Serdika Bridge Festival' =>
  {
    %GLOBAL,
    CITY => 'Sofia',

    EDITIONS => 
    {
      '2009' =>
      {
        MEET_ORDINAL => 17,
        YEAR => 2009,
        DATE_START => '2009-05-16',
        DATE_END => '2009-05-17'
      },
      '2010' =>
      {
        MEET_ORDINAL => 18,
        YEAR => 2010,
        DATE_START => '2010-05-15',
        DATE_END => '2010-05-16'
      },
      '2011' =>
      {
        # https://bridge.bg/en/tournaments/540-19th-International-Bridge-Festival-Ulpia-Serdica-2011
        MEET_ORDINAL => 19,
        YEAR => 2011,
        DATE_START => '2011-05-12',
        DATE_END => '2011-05-15'
      },
      '2012' =>
      {
        # It seems they are both the 19th?!
        MEET_ORDINAL => 19,
        YEAR => 2012,
        DATE_START => '2012-05-19',
        DATE_END => '2012-05-20'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-05-15',
        DATE_END => '2019-05-20'
      },
    }
  },

  'Shumen Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Shumen',

    EDITIONS => 
    {
      '2014' =>
      {
        MEET_ORDINAL => 1,
        YEAR => 2014,
        DATE_START => '2014-09-21',
        DATE_END => '2014-09-22'
      },
      '2015' =>
      {
        MEET_ORDINAL => 2,
        YEAR => 2015,
        DATE_START => '2015-09-21',
        DATE_END => '2015-09-22'
      },
      '2016' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2016,
        DATE_START => '2016-09-24',
        DATE_END => '2016-09-25'
      },
    }
  },

  'Stara Zagora Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Stara Zagora',

    EDITIONS => 
    {
      '2006' =>
      {
        MEET_ORDINAL => 25,
        YEAR => 2006,
        DATE_START => '2006-10-17',
        DATE_END => '2006-10-17'
      },
      '2007' =>
      {
        MEET_ORDINAL => 26,
        YEAR => 2007,
        DATE_START => '2007-10-21',
        DATE_END => '2007-10-22'
      },
      '2009' =>
      {
        MEET_ORDINAL => 28,
        YEAR => 2009,
        DATE_START => '2009-10-10',
        DATE_END => '2009-10-11'
      },
      '2010' =>
      {
        MEET_ORDINAL => 29,
        YEAR => 2010,
        DATE_START => '2010-10-02',
        DATE_END => '2010-10-03'
      },
      '2011' =>
      {
        MEET_ORDINAL => 30,
        YEAR => 2011,
        DATE_START => '2011-10-08',
        DATE_END => '2011-10-09'
      },
      '2012' =>
      {
        MEET_ORDINAL => 31,
        YEAR => 2012,
        DATE_START => '2012-10-06',
        DATE_END => '2012-10-07'
      },
      '2013' =>
      {
        MEET_ORDINAL => 32,
        YEAR => 2013,
        DATE_START => '2013-10-05',
        DATE_END => '2013-10-06'
      },
      '2014' =>
      {
        MEET_ORDINAL => 33,
        YEAR => 2014,
        DATE_START => '2014-10-04',
        DATE_END => '2014-10-05'
      },
      '2015' =>
      {
        MEET_ORDINAL => 34,
        YEAR => 2015,
        DATE_START => '2015-10-17',
        DATE_END => '2015-10-18'
      },
      '2016' =>
      {
        MEET_ORDINAL => 35,
        YEAR => 2016,
        DATE_START => '2016-10-08',
        DATE_END => '2016-10-09'
      },
      '2017' =>
      {
        MEET_ORDINAL => 36,
        YEAR => 2017,
        DATE_START => '2017-10-07',
        DATE_END => '2017-10-08'
      },
      '2018' =>
      {
        MEET_ORDINAL => 37,
        YEAR => 2018,
        DATE_START => '2018-10-06',
        DATE_END => '2018-10-07'
      },
      '2019' =>
      {
        MEET_ORDINAL => 38,
        YEAR => 2019,
        DATE_START => '2019-10-05',
        DATE_END => '2019-10-06'
      },
      '2020' =>
      {
        MEET_ORDINAL => 39,
        YEAR => 2020,
        DATE_START => '2020-10-03',
        DATE_END => '2020-10-04'
      },
      '2024' =>
      {
        MEET_ORDINAL => 43,
        YEAR => 2024,
        DATE_START => '2024-10-12',
        DATE_END => '2024-10-13'
      },
    }
  },

  'Varna Bridge Festival' =>
  {
    %GLOBAL,
    CITY => 'Varna',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://www.bridge.bg/en/tournaments/955-
        MEET_ORDINAL => 36,
        YEAR => 2012,
        DATE_START => '2012-08-11',
        DATE_END => '2012-08-18'
      },
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1321-XXXVIIth-International-Bridge-Tournament-Varna-2013
        MEET_ORDINAL => 37,
        YEAR => 2013,
        DATE_START => '2013-08-10',
        DATE_END => '2013-08-17'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1896-XXXVIII-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Varna-2014
        MEET_ORDINAL => 38,
        YEAR => 2014,
        DATE_START => '2014-08-09',
        DATE_END => '2014-08-16'
      },
      '2015' =>
      {
        # https://www.bridge.bg/en/tournaments/2229-XXXIX-International-Bridge-Festival-Varna-2015
        MEET_ORDINAL => 39,
        YEAR => 2015,
        DATE_START => '2015-08-11',
        DATE_END => '2015-08-16'
      },
      '2016' =>
      {
        # https://www.bridge.bg/en/tournaments_results/2651-40-ti-M%D0%B5jdunarod%D0%B5n-Bridj-F%D0%B5stival---Varna-2016
        MEET_ORDINAL => 40,
        YEAR => 2016,
        DATE_START => '2016-08-15',
        DATE_END => '2016-08-21'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/3036-41-MBF-Varna-2017
        MEET_ORDINAL => 41,
        YEAR => 2017,
        DATE_START => '2017-08-14',
        DATE_END => '2017-08-20'
      },
      '2018' =>
      {
        # https://www.bridge.bg/en/tournaments/3036-41-MBF-Varna-2017
        MEET_ORDINAL => 42,
        YEAR => 2018,
        DATE_START => '2018-08-13',
        DATE_END => '2018-08-19'
      },
      '2019' =>
      {
        MEET_ORDINAL => 43,
        YEAR => 2019,
        DATE_START => '2019-08-14',
        DATE_END => '2019-08-18'
      },
      '2020' =>
      {
        MEET_ORDINAL => 44,
        YEAR => 2020,
        DATE_START => '2020-08-08',
        DATE_END => '2020-08-09'
      },
      '2021' =>
      {
        MEET_ORDINAL => 45,
        YEAR => 2021,
        DATE_START => '2021-08-14',
        DATE_END => '2021-08-15'
      },
      '2022' =>
      {
        MEET_ORDINAL => 46,
        SPONSOR => 'Panatop',
        YEAR => 2022,
        DATE_START => '2022-08-13',
        DATE_END => '2022-08-14'
      },
      '2023' =>
      {
        MEET_ORDINAL => 47,
        YEAR => 2023,
        DATE_START => '2023-08-12',
        DATE_END => '2023-08-13'
      },
      '2024' =>
      {
        MEET_ORDINAL => 48,
        YEAR => 2024,
        DATE_START => '2024-08-10',
        DATE_END => '2024-08-11'
      },
    }
  },

  'Vitosha Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-05-27',
        DATE_END => '2023-05-28'
      },
    }
  },
);

my %TOURNAMENTS_BULGARIA =
(
  'Albena Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Albena Bridge Festival',
        SPONSOR => 'Vinex Preslav',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-28',
            DATE_END => '2012-06-30'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-07-04',
            DATE_END => '2014-07-06'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-07-07',
            DATE_END => '2016-07-09'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-07-07',
            DATE_END => '2017-07-09'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-06-29',
            DATE_END => '2018-07-01'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-07'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            major => 'ROUND',
            DATE_START => '2020-07-05',
            DATE_END => '2020-07-05'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            major => 'ROUND',
            DATE_START => '2021-07-04',
            DATE_END => '2021-07-04'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-07-01',
            DATE_END => '2022-07-03'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            major => 'ROUND',
            DATE_START => '2023-07-07',
            DATE_END => '2023-07-09'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            major => 'ROUND',
            DATE_START => '2024-07-05',
            DATE_END => '2024-07-07'
          } 
        }
      },
    }
  },

  'Asenovgrad Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Asenovgrad',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-05-31'
          },
        }
      },
      '2016' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-29'
          },
        }
      },
      '2017' =>
      {
        ORDINAL => 3,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-05-27',
            DATE_END => '2017-05-28'
          },
        }
      },
    }
  },

  'Bansko Bridge Masters' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
          },
        }
      },
    }
  },

  'Bulgarian Anniversary Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-09-17',
            DATE_END => '2022-09-18'
          },
        }
      },
    }
  },

  'Bulgarian Club Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-12-09',
            DATE_END => '2022-12-11'
          },
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-09-22',
            DATE_END => '2023-09-24'
          },
          'C1' =>
          {
            YEAR => 2023,
            DATE_START => '2023-12-08',
            DATE_END => '2023-12-10'
          },
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-11-15',
            DATE_END => '2024-11-17'
          },
        }
      },
    }
  },

  'Bulgarian Open Cup' =>
  {
    # TODO Related to Club Teams?
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-20'
          },
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-17',
            DATE_END => '2023-11-19'
          },
        }
      },
    }
  },

  'Bulgarian Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CITY => 'Chepelare',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-13'
          } 
        }
      },
      '2013' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-27'
          } 
        }
      },
      '2014' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          } 
        }
      },
    }
  },

  'Bulgarian Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2009-03-13',
            DATE_END => '2009-03-15'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-27',
            DATE_END => '2009-03-27'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-28',
            DATE_END => '2009-03-29'
          } 
        }
      },
      '2013' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2013-02-07',
            DATE_END => '2013-02-10'
          },
        }
      },
      '2014' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            groupon => 'GROUP',
            major => 'ROUND|SEGMENT',
            DATE_START => '2014-02-06',
            DATE_END => '2014-02-09'
          },
        }
      },
      '2015' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            groupon => 'GROUP',
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-01-29',
            DATE_END => '2015-02-01'
          },
        }
      },
      '2016' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            groupon => 'GROUP',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-02-04',
            DATE_END => '2016-02-07'
          },
        }
      },
      '2017' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-04-20',
            DATE_END => '2017-04-23'
          },
        }
      },
      '2018' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-26',
            DATE_END => '2018-04-29'
          },
        }
      },
      '2019' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-04',
            DATE_END => '2019-04-07'
          },
        }
      },
      '2021A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-05-13',
            DATE_END => '2021-05-16'
          },
        }
      },
      '2021B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            DATE_START => '2021-09-23',
            DATE_END => '2021-09-26'
          },
        }
      },
      '2022' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-18',
            DATE_END => '2022-03-20'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Vitosha Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-27',
            DATE_END => '2023-05-28'
          },
        }
      },
      '2024' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-04-19',
            DATE_END => '2024-04-21'
          },
        }
      },
    }
  },

  'Bulgarian Open Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-22',
            DATE_END => '2009-05-22'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-23',
            DATE_END => '2009-05-23'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-24',
            DATE_END => '2009-05-24'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-04-11',
            DATE_END => '2010-04-11'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-26'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-27',
            DATE_END => '2011-03-27'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-05'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-06'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-13',
            DATE_END => '2018-01-14'
          },
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-01',
            DATE_END => '2020-02-02'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-09-23',
            DATE_END => '2022-09-25'
          },
        }
      },
    }
  },

  'Bulgarian Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-03-13',
            DATE_END => '2011-03-13'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-03-18',
            DATE_END => '2012-03-18'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-05'
          } 
        }
      },
    }
  },

  'Chelopech Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-18',
            DATE_END => '2023-08-20'
          },
        }
      },
    }
  },

  'Cherven Briag Open Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Cherven Briag Festival',
        ORDINAL => 2,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-06-18',
            DATE_END => '2011-06-19'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Cherven Briag Festival',
        ORDINAL => 3,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-09-22',
            DATE_END => '2012-09-23'
          } 
        }
      },
    }
  },

  'Dimitrovgrad Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        ORDINAL => 19,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-08-26',
            DATE_END => '2017-08-27'
          },
        }
      },
      '2019' =>
      {
        ORDINAL => 21,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-11-16',
            DATE_END => '2019-11-17'
          },
        }
      },
    }
  },

  'Dobrich Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Dobrich Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-04-12',
            DATE_END => '2009-04-12'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Dobrich Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-14'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Dobrich Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-12',
            DATE_END => '2014-04-13'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Dobrich Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-19'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Dobrich Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-04-08',
            DATE_END => '2017-04-09'
          } 
        }
      },
    }
  },

  'Harmanli Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-09-17',
            DATE_END => '2016-09-18'
          },
        }
      },
    }
  },

  'Haskovski Mineralni Bani Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Haskovski Mineralni Bani',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-05'
          } 
        }
      },
    }
  },

  'Haskovski Mineralni Bani Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Haskovski Mineralni Bani',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-06-06',
            DATE_END => '2009-06-06'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-06-07',
            DATE_END => '2009-06-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-06-07',
            DATE_END => '2009-06-07'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-09',
            DATE_END => '2012-06-10'
          } 
        }
      },
    }
  },

  'Karlovo Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Karlovo',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2009-02-27',
            DATE_END => '2009-02-27'
          } 
        }
      },
    }
  },

  'Karlovo Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Karlovo',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-01'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 11,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          } 
        }
      },
    }
  },

  'Kaylaka Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-11-10',
            DATE_END => '2016-11-11'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-16'
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
            DATE_START => '2019-11-07',
            DATE_END => '2019-11-10'
          },
        }
      },
      '2021' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            DATE_START => '2021-11-04',
            DATE_END => '2021-11-05'
          },
        }
      },
    }
  },

  'Lozenets Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Lozenets Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-05-30',
            DATE_END => '2009-05-31'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Lozenets Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-05-29',
            DATE_END => '2010-05-29'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-05-30',
            DATE_END => '2010-05-30'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-05-30',
            DATE_END => '2010-05-30'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Lozenets Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-06-13',
            DATE_END => '2015-06-14'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Lozenets Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-10',
            DATE_END => '2017-06-11'
          } 
        }
      },
    }
  },

  'Pavel Banya Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Pavel Banya Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-06',
            DATE_END => '2018-01-07'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Pavel Banya Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-05',
            DATE_END => '2019-01-06'
          } 
        }
      },
      '2020A' =>
      {
        MEET => 'Pavel Banya Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-04',
            DATE_END => '2020-01-05'
          } 
        }
      },
      '2020B' =>
      {
        MEET => 'Pavel Banya Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-18',
            DATE_END => '2020-01-19'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Pavel Banya Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-03-13',
            DATE_END => '2021-03-14'
          } 
        }
      },
    }
  },

  'Panagyurishte Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        ORDINAL => 3,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-10-22',
            DATE_END => '2016-10-23'
          },
        }
      },
      '2017' =>
      {
        ORDINAL => 4,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-10-21',
            DATE_END => '2017-10-22'
          },
        }
      },
      '2018' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-10-20',
            DATE_END => '2018-10-21'
          },
        }
      },
    }
  },

  'Pleven Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Pleven',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        ORDINAL => 33,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2012-11-03',
            DATE_END => '2012-11-04'
          } 
        }
      },
      '2013' =>
      {
        ORDINAL => 34,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-11-02',
            DATE_END => '2013-11-03'
          } 
        }
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/2117-XXV-Bridj-turnir-Gabi
        ORDINAL => 35,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-11-12',
            DATE_END => '2016-11-13'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          } 
        }
      },
      '2021' =>
      {
        ORDINAL => 41,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            major => 'ROUND',
            DATE_START => '2021-11-06',
            DATE_END => '2021-11-07'
          } 
        }
      },
    }
  },

  'Plovdiv Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2010-04-30',
            DATE_END => '2010-05-02'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2012-05-05',
            DATE_END => '2012-05-06'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-04-27',
            DATE_END => '2013-04-28'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-03'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-07',
            DATE_END => '2016-05-07'
          },
          'C1' => 
          {
            YEAR => 2016,
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2016-05-08',
            DATE_END => '2016-05-08'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        ORDINAL => 1,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            DATE_START => '2021-05-29',
            DATE_END => '2021-05-30'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Plovdiv Bridge Festival',
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-06'
          },
        }
      },
    }
  },

  'Popovo Friendship Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-02-11',
            DATE_END => '2017-02-12'
          },
        }
      },
    }
  },

  'Rusenski Lom Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-07-21',
            DATE_END => '2018-07-22'
          },
        }
      },
    }
  },

  'Serdika Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-15',
            DATE_END => '2019-05-15'
          } 
        }
      },
    }
  },

  'Serdika Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2009-05-16',
            DATE_END => '2009-05-17'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-05-15',
            DATE_END => '2010-05-16'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-15'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-20'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Serdika Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-16',
            DATE_END => '2019-05-19'
          } 
        }
      },
    }
  },

  'Shumen Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Shumen Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-09-21',
            DATE_END => '2014-09-22'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Shumen Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-09-21',
            DATE_END => '2015-09-22'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Shumen Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-25'
          } 
        }
      },
    }
  },

  'Sliven Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        ORDINAL => 15,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-11-05',
            DATE_END => '2016-11-06'
          },
        }
      },
      '2017' =>
      {
        ORDINAL => 16,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-29'
          },
        }
      },
    }
  },

  'St. Ivan Rilski Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        ORDINAL => 1,
        CITY => 'Bansko',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-07-28',
            DATE_END => '2018-07-29'
          },
        }
      },
    }
  },

  'Stara Zagora Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-10-17',
            DATE_END => '2006-10-17'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-10-17',
            DATE_END => '2006-10-17'
          },
        }
      },
      '2007' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-10-21',
            DATE_END => '2007-10-21'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-10-10',
            DATE_END => '2009-10-11'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-10-11',
            DATE_END => '2009-10-11'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-10-11',
            DATE_END => '2009-10-11'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2010-10-02',
            DATE_END => '2010-10-03'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-10-03',
            DATE_END => '2010-10-03'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-10-03',
            DATE_END => '2010-10-03'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-08'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-09'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-09'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-10-06',
            DATE_END => '2012-10-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-07',
            DATE_END => '2012-10-07'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-10-07',
            DATE_END => '2012-10-07'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        SPONSOR => 'Vito',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-05'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            ignore => 'GROUP',
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-04'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            ignore => 'GROUP',
            DATE_START => '2014-10-05',
            DATE_END => '2014-10-05'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2015-10-17',
            DATE_END => '2015-10-17'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-10-18',
            DATE_END => '2015-10-18'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-08',
            DATE_END => '2016-10-09'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-07',
            DATE_END => '2017-10-08'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-06',
            DATE_END => '2018-10-07'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-05',
            DATE_END => '2019-10-06'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-10-03',
            DATE_END => '2020-10-04'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Stara Zagora Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-10-12',
            DATE_END => '2024-10-13'
          },
        }
      },
    }
  },

  'Star Bet Casino Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-06-02',
            DATE_END => '2018-06-03'
          },
        }
      },
    }
  },

  'Varna Intercity Teams' =>
  {
    ORIGIN => 'Intercity',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-08-12',
            DATE_END => '2013-08-12'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-08-12',
            DATE_END => '2013-08-12'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-08-11',
            DATE_END => '2014-08-11'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-08-11',
            DATE_END => '2014-08-11'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            DATE_START => '2016-08-17',
            DATE_END => '2016-08-17'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-08-17',
            DATE_END => '2016-08-17'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-08-16',
            DATE_END => '2017-08-16'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-08-15',
            DATE_END => '2018-08-15'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-14',
            DATE_END => '2019-08-14'
          },
        }
      },
    }
  },

  'Varna Titan Open Teams' =>
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-08-16',
            DATE_END => '2013-08-17'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-08-15',
            DATE_END => '2014-08-16'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-08-20',
            DATE_END => '2016-08-21'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-08-19',
            DATE_END => '2017-08-20'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-08-18',
            DATE_END => '2018-08-19'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-17',
            DATE_END => '2019-08-18'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-08-08',
            DATE_END => '2020-08-09'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-08-14',
            DATE_END => '2021-08-15'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-08-13',
            DATE_END => '2022-08-14'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-08-12',
            DATE_END => '2023-08-13'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Varna Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-08-10',
            DATE_END => '2024-08-11'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BULGARIA, \%TOURNAMENTS_BULGARIA, 'Bulgaria');
}

1;
