#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Bulgaria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_BULGARIA =
(
  'Albena Bridge Festival' =>
  {
    ORGANIZATION => 'BuBF',
    CITY => 'Albena',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'Transnational',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2008' =>
      {
        # https://www.bridgealbena.org/Albena/results2008.html
        ORDINAL => 32,
        YEAR => 2008,
        DATE_START => '2008-06-17',
        DATE_END => '2008-06-28'
      },
      '2009' =>
      {
        # https://www.bridgealbena.org/Albena/results2009.html
        ORDINAL => 33,
        YEAR => 2009,
        DATE_START => '2009-06-16',
        DATE_END => '2009-06-27'
      },
      '2010' =>
      {
        # https://www.bridgealbena.org/Albena/results2010.html
        ORDINAL => 34,
        YEAR => 2010,
        DATE_START => '2010-06-22',
        DATE_END => '2010-07-03'
      },
      '2011' =>
      {
        # https://www.bridgealbena.org/Albena/results2011.html
        ORDINAL => 35,
        YEAR => 2011,
        DATE_START => '2011-06-21',
        DATE_END => '2011-07-02'
      },
      '2012' =>
      {
        # https://www.bridgealbena.org/Albena/results2012.html
        ORDINAL => 36,
        YEAR => 2012,
        DATE_START => '2012-06-19',
        DATE_END => '2012-06-30'
      },
      '2013' =>
      {
        # https://www.bridgealbena.org/Albena/results2013.html
        ORDINAL => 37,
        YEAR => 2013,
        DATE_START => '2013-06-18',
        DATE_END => '2013-06-29'
      },
      '2014' =>
      {
        # https://www.bridgealbena.org/Albena/results2014.html
        ORDINAL => 38,
        YEAR => 2014,
        DATE_START => '2014-06-24',
        DATE_END => '2014-07-06'
      },
      '2015' =>
      {
        # https://www.bridgealbena.org/Albena/results2015.html
        ORDINAL => 39,
        YEAR => 2015,
        DATE_START => '2015-06-24',
        DATE_END => '2015-07-06'
      },
      '2016' =>
      {
        # https://www.bridgealbena.org/Albena/results2016.html
        ORDINAL => 40,
        YEAR => 2016,
        DATE_START => '2016-06-28',
        DATE_END => '2016-07-10'
      },
      '2017' =>
      {
        # https://www.bridgealbena.org/Albena/results2017.html
        ORDINAL => 41,
        YEAR => 2017,
        DATE_START => '2017-06-27',
        DATE_END => '2017-07-09'
      },
      '2018' =>
      {
        # https://www.bridgealbena.org/Albena/results2018.html
        ORDINAL => 42,
        YEAR => 2018,
        DATE_START => '2018-06-27',
        DATE_END => '2018-07-09'
      },
      '2019' =>
      {
        # https://www.bridgealbena.org/Albena/results2019.html
        ORDINAL => 43,
        YEAR => 2019,
        DATE_START => '2019-06-25',
        DATE_END => '2019-07-07'
      },
      '2020' =>
      {
        # https://www.bridgealbena.org/Albena/results2020.html
        YEAR => 2020,
        DATE_START => '2020-06-23',
        DATE_END => '2020-07-05'
      },
      '2021' =>
      {
        # https://www.bridgealbena.org/Albena/results2021.html
        YEAR => 2021,
        DATE_START => '2021-06-25',
        DATE_END => '2021-07-04'
      },
      '2022' =>
      {
        # https://www.bridgealbena.org/Albena/results2022.html
        YEAR => 2022,
        DATE_START => '2022-06-24',
        DATE_END => '2022-07-03'
      },
      '2023' =>
      {
        # https://www.bridgealbena.org/Albena/results2023.html
        YEAR => 2023,
        DATE_START => '2023-06-30',
        DATE_END => '2023-07-09'
      },
      '2024' =>
      {
        # https://www.bridgealbena.org/Albena/results2024.html
        YEAR => 2024,
        DATE_START => '2024-06-28',
        DATE_END => '2024-07-07'
      },
    }
  },

  'Dobrich Bridge Festival' =>
  {
    ORGANIZATION => 'BuBF',
    CITY => 'Dobrich',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1182-28th-International-Bridge-Festival-Dobrich-2013
        ORDINAL => 28,
        YEAR => 2013,
        DATE_START => '2013-04-11',
        DATE_END => '2013-04-14'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1580-29th-International-Bridge-Festival-Dobrich-2014
        ORDINAL => 29,
        YEAR => 2014,
        DATE_START => '2014-04-10',
        DATE_END => '2014-04-13'
      },
      '2016' =>
      {
        # https://www.bridge.bg/en/tournaments/2552-31-IBF-Dobrich-2016
        ORDINAL => 31,
        YEAR => 2016,
        DATE_START => '2016-04-14',
        DATE_END => '2016-04-17'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/2912-32-IBF-Dobrich-2017
        ORDINAL => 32,
        YEAR => 2017,
        DATE_START => '2017-04-06',
        DATE_END => '2017-04-09'
      },
      '2018' =>
      {
        # https://www.bridge.bg/en/tournaments/3316-33ti-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich-2018
        ORDINAL => 33,
        YEAR => 2018,
        DATE_START => '2018-04-12',
        DATE_END => '2018-04-15'
      },
      '2019' =>
      {
        # https://www.bridge.bg/en/tournaments/3944-34th-International-Bridge-Festival-Dobrich-2019
        ORDINAL => 34,
        YEAR => 2019,
        DATE_START => '2019-04-12',
        DATE_END => '2019-04-14'
      },
      '2020' =>
      {
        # https://www.bridge.bg/en/tournaments/4475-35ti-M%D0%B5jdunarod%D0%B5n-Bridj-F%D0%B5stival-Dobrich-2020
        ORDINAL => 35,
        YEAR => 2020,
        DATE_START => '2020-04-10',
        DATE_END => '2020-04-12'
      },
      '2021' =>
      {
        # https://www.bridge.bg/en/tournaments/4887-36ti-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich
        ORDINAL => 36,
        YEAR => 2021,
        DATE_START => '2021-09-17',
        DATE_END => '2021-09-19'
      },
      '2023' =>
      {
        # https://www.bridge.bg/en/tournaments/5905-38i-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Dobrich
        ORDINAL => 38,
        YEAR => 2023,
        DATE_START => '2023-09-29',
        DATE_END => '2023-10-01'
      },
    }
  },

  'Plovdiv Bridge Festival' =>
  {
    ORGANIZATION => 'BuBF',
    CITY => 'Plovdiv',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'Transnational',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2009' =>
      {
        # https://bridge.bg/en/tournaments/7-28th-International-Bridge-Festival-Plovdiv-09
        ORDINAL => 28,
        YEAR => 2009,
        DATE_START => '2009-04-30',
        DATE_END => '2009-04-03'
      },
      '2010' =>
      {
        # https://www.bridge.bg/en/tournaments/170-29th-International-Bridge-Festival-Plovdiv-10
        ORDINAL => 29,
        YEAR => 2010,
        DATE_START => '2010-04-29',
        DATE_END => '2010-05-02'
      },
      '2011' =>
      {
        # https://new.bridge.bg/en/tournaments/541-30-International-Bridge-Festival-Plovdiv-2011
        ORDINAL => 30,
        YEAR => 2011,
        DATE_START => '2011-04-28',
        DATE_END => '2011-05-01'
      },
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1211-32nd-International-Bridge-Festival-Plovdiv-2013
        ORDINAL => 32,
        YEAR => 2013,
        DATE_START => '2013-04-25',
        DATE_END => '2013-04-28'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1844-33-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2014
        ORDINAL => 33,
        YEAR => 2014,
        DATE_START => '2014-04-24',
        DATE_END => '2014-04-27'
      },
      '2015' =>
      {
        # https://www.bridge.bg/en/tournaments/2210-34-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2015
        ORDINAL => 34,
        YEAR => 2015,
        DATE_START => '2015-04-29',
        DATE_END => '2015-05-02'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/2919-36-MBF-Plovdiv-2017
        ORDINAL => 36,
        YEAR => 2017,
        DATE_START => '2017-05-04',
        DATE_END => '2017-05-07'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/international-bridge-festival-plovdiv-2019
        # https://www.bridge.bg/en/tournaments/3978-38-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Plovdiv-2019
        ORDINAL => 38,
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
    ORGANIZATION => 'BuBF',
    CITY => 'Sofia',
    COUNTRY => 'Bulgaria',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2009' =>
      {
        ORDINAL => 17,
        YEAR => 2009,
        DATE_START => '2009-05-16',
        DATE_END => '2010905-17'
      },
      '2010' =>
      {
        ORDINAL => 18,
        YEAR => 2010,
        DATE_START => '2010-05-15',
        DATE_END => '2010-05-15'
      },
      '2011' =>
      {
        # https://bridge.bg/en/tournaments/540-19th-International-Bridge-Festival-Ulpia-Serdica-2011
        ORDINAL => 19,
        YEAR => 2011,
        DATE_START => '2011-05-12',
        DATE_END => '2011-05-15'
      },
      '2012' =>
      {
        ORDINAL => 20,
        YEAR => 2012,
        DATE_START => '2012-05-19',
        DATE_END => '2012-05-20'
      },
    }
  },

  'Varna Bridge Festival' =>
  {
    ORGANIZATION => 'BuBF',
    CITY => 'Varna',
    COUNTRY => 'Bulgaria',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://www.bridge.bg/en/tournaments/955-
        ORDINAL => 36,
        YEAR => 2012,
        DATE_START => '2012-08-11',
        DATE_END => '2012-08-18'
      },
      '2013' =>
      {
        # https://www.bridge.bg/en/tournaments/1321-XXXVIIth-International-Bridge-Tournament-Varna-2013
        ORDINAL => 37,
        YEAR => 2013,
        DATE_START => '2013-08-10',
        DATE_END => '2013-08-17'
      },
      '2014' =>
      {
        # https://www.bridge.bg/en/tournaments/1896-XXXVIII-M%D0%B5jdunarod%D0%B5n-bridj-f%D0%B5stival-Varna-2014
        ORDINAL => 38,
        YEAR => 2014,
        DATE_START => '2014-08-09',
        DATE_END => '2014-08-16'
      },
      '2015' =>
      {
        # https://www.bridge.bg/en/tournaments/2229-XXXIX-International-Bridge-Festival-Varna-2015
        ORDINAL => 39,
        YEAR => 2015,
        DATE_START => '2015-08-11',
        DATE_END => '2015-08-15'
      },
      '2016' =>
      {
        # https://www.bridge.bg/en/tournaments_results/2651-40-ti-M%D0%B5jdunarod%D0%B5n-Bridj-F%D0%B5stival---Varna-2016
        ORDINAL => 40,
        YEAR => 2016,
        DATE_START => '2016-08-15',
        DATE_END => '2016-08-21'
      },
      '2017' =>
      {
        # https://www.bridge.bg/en/tournaments/3036-41-MBF-Varna-2017
        ORDINAL => 41,
        YEAR => 2017,
        DATE_START => '2017-08-14',
        DATE_END => '2017-08-20'
      },
      '2018' =>
      {
        # https://www.bridge.bg/en/tournaments/3036-41-MBF-Varna-2017
        ORDINAL => 42,
        YEAR => 2018,
        DATE_START => '2018-08-13',
        DATE_END => '2018-08-19'
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
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
            DATE_START => '2016-07-08',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'Asenovgrad Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
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
    }
  },

  'Bulgarian Open Pairs' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-27'
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
            major => 'ROUND',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          } 
        }
      },
    }
  },

  'Bulgarian Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-02-07',
            DATE_END => '2013-02-10'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-06',
            DATE_END => '2014-02-09'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-01-29',
            DATE_END => '2015-02-01'
          },
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
            DATE_START => '2016-02-04',
            DATE_END => '2016-02-07'
          },
        }
      },
    }
  },

  'Bulgarian Open Trials' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    }
  },

  'Bulgarian Women Trials' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Cherven Briag Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    CITY => 'Cherven Briag',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
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

  'Dobrich Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
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
    }
  },

  'Karlovo Open Pairs' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    CITY => 'Karlovo',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    CITY => 'Karlovo',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          } 
        }
      },
    }
  },

  'Pleven Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    CITY => 'Pleven',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
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
            STAGE => 'Round-robin',
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
            major => 'ROUND',
            DATE_START => '2016-05-08',
            DATE_END => '2016-05-08'
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
            major => 'ROUND',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-20'
          } 
        }
      },
    }
  },

  'Stara Zagora Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
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
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
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
    }
  },

  'Varna Titan Open Teams' =>
  {
    ORIGIN => 'International',
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
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BULGARIA, \%TOURNAMENTS_BULGARIA, 'Bulgaria');
}

1;
