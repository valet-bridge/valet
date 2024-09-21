#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::USA;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_USA =
(
  'North American Bridge Championship' =>
  {
    # https://www.acbl.org/past-nabcs/

    ORGANIZATION => 'ACBL',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    ZONE => 'North America',

    EDITIONS => 
    {
      '2004A' =>
      {
        YEAR => 2004,
        CITY => 'Reno',
        DATE_START => '2004-03-18',
        DATE_END => '2004-03-28'
      },
      '2004B' =>
      {
        YEAR => 2004,
        CITY => 'New York City',
        DATE_START => '2004-07-21',
        DATE_END => '2004-07-31'
      },
      '2004C' =>
      {
        YEAR => 2004,
        CITY => 'Orlando',
        DATE_START => '2004-11-19',
        DATE_END => '2004-11-29'
      },
      '2005A' =>
      {
        YEAR => 2005,
        CITY => 'Pittsburgh',
        DATE_START => '2005-03-10',
        DATE_END => '2005-03-21'
      },
      '2005B' =>
      {
        YEAR => 2005,
        CITY => 'Atlanta',
        DATE_START => '2005-07-21',
        DATE_END => '2005-07-31'
      },
      '2005C' =>
      {
        YEAR => 2005,
        CITY => 'Denver',
        DATE_START => '2005-11-21',
        DATE_END => '2005-11-31'
      },
      '2006A' =>
      {
        YEAR => 2006,
        CITY => 'Dallas',
        DATE_START => '2006-03-30',
        DATE_END => '2006-04-09'
      },
      '2006B' =>
      {
        YEAR => 2006,
        CITY => 'Chicago',
        DATE_START => '2006-07-13',
        DATE_END => '2006-07-23'
      },
      '2006C' =>
      {
        YEAR => 2006,
        CITY => 'Honolulu',
        DATE_START => '2006-11-16',
        DATE_END => '2006-11-26'
      },
      '2007A' =>
      {
        YEAR => 2007,
        CITY => 'St. Louis',
        DATE_START => '2007-03-08',
        DATE_END => '2007-04-18'
      },
      '2007B' =>
      {
        YEAR => 2007,
        CITY => 'Nashville',
        DATE_START => '2007-07-19',
        DATE_END => '2007-07-29'
      },
      '2007C' =>
      {
        YEAR => 2007,
        CITY => 'San Francisco',
        DATE_START => '2007-11-22',
        DATE_END => '2007-12-02'
      },
      '2008A' =>
      {
        YEAR => 2008,
        CITY => 'Detroit',
        DATE_START => '2008-03-06',
        DATE_END => '2008-03-16'
      },
      '2008B' =>
      {
        YEAR => 2008,
        CITY => 'Las Vegas',
        DATE_START => '2008-07-17',
        DATE_END => '2008-07-27'
      },
      '2008C' =>
      {
        YEAR => 2008,
        CITY => 'Boston',
        DATE_START => '2008-11-20',
        DATE_END => '2008-11-30'
      },
      '2009A' =>
      {
        YEAR => 2009,
        CITY => 'Houston',
        DATE_START => '2009-03-12',
        DATE_END => '2009-03-22'
      },
      '2009B' =>
      {
        YEAR => 2009,
        CITY => 'Washington DC',
        DATE_START => '2009-07-23',
        DATE_END => '2009-08-02'
      },
      '2009C' =>
      {
        YEAR => 2009,
        CITY => 'San Diego',
        DATE_START => '2009-11-26',
        DATE_END => '2009-12-06'
      },
      '2010A' =>
      {
        YEAR => 2010,
        CITY => 'Reno',
        DATE_START => '2010-03-11',
        DATE_END => '2010-03-21'
      },
      '2010B' =>
      {
        YEAR => 2010,
        CITY => 'New Orleans',
        DATE_START => '2010-07-22',
        DATE_END => '2010-08-01'
      },
      '2010C' =>
      {
        YEAR => 2010,
        CITY => 'Orlando',
        DATE_START => '2010-11-25',
        DATE_END => '2010-12-05'
      },
      '2011A' =>
      {
        YEAR => 2011,
        CITY => 'Louisville',
        DATE_START => '2011-03-10',
        DATE_END => '2011-03-20'
      },
      '2011B' =>
      {
        YEAR => 2011,
        CITY => 'Toronto',
        DATE_START => '2011-07-21',
        DATE_END => '2011-07-31'
      },
      '2011C' =>
      {
        YEAR => 2011,
        CITY => 'Seattle',
        DATE_START => '2011-11-24',
        DATE_END => '2011-12-04'
      },
      '2012A' =>
      {
        YEAR => 2012,
        CITY => 'Memphis',
        DATE_START => '2012-03-15',
        DATE_END => '2012-03-25'
      },
      '2012B' =>
      {
        YEAR => 2012,
        CITY => 'Philadelphia',
        DATE_START => '2012-07-12',
        DATE_END => '2012-07-22'
      },
      '2012C' =>
      {
        YEAR => 2012,
        CITY => 'New Orleans',
        DATE_START => '2012-11-22',
        DATE_END => '2012-12-02'
      },
      '2013A' =>
      {
        YEAR => 2013,
        CITY => 'St. Louis',
        DATE_START => '2013-03-14',
        DATE_END => '2013-03-24'
      },
      '2013B' =>
      {
        YEAR => 2013,
        CITY => 'Atlanta',
        DATE_START => '2013-08-01',
        DATE_END => '2013-08-11'
      },
      '2013C' =>
      {
        YEAR => 2013,
        CITY => 'Phoenix',
        DATE_START => '2013-11-28',
        DATE_END => '2013-12-08'
      },
      '2014A' =>
      {
        YEAR => 2014,
        CITY => 'Dallas',
        DATE_START => '2014-03-19',
        DATE_END => '2014-03-30'
      },
      '2014B' =>
      {
        YEAR => 2014,
        CITY => 'Las Vegas',
        DATE_START => '2014-07-17',
        DATE_END => '2014-07-27'
      },
      '2014C' =>
      {
        YEAR => 2014,
        CITY => 'Providence',
        DATE_START => '2014-11-27',
        DATE_END => '2014-12-07'
      },
      '2015A' =>
      {
        YEAR => 2015,
        CITY => 'New Orleans',
        DATE_START => '2015-03-12',
        DATE_END => '2015-03-22'
      },
      '2015B' =>
      {
        YEAR => 2015,
        CITY => 'Chicago',
        DATE_START => '2015-08-06',
        DATE_END => '2015-08-16'
      },
      '2015C' =>
      {
        YEAR => 2015,
        CITY => 'Denver',
        DATE_START => '2015-11-26',
        DATE_END => '2015-12-06'
      },
      '2016A' =>
      {
        YEAR => 2016,
        CITY => 'Reno',
        DATE_START => '2016-03-09',
        DATE_END => '2016-03-20'
      },
      '2016B' =>
      {
        YEAR => 2016,
        CITY => 'Washington DC',
        DATE_START => '2016-07-20',
        DATE_END => '2016-07-31'
      },
      '2016C' =>
      {
        YEAR => 2016,
        CITY => 'Orlando',
        DATE_START => '2016-11-24',
        DATE_END => '2016-12-04'
      },
      '2017A' =>
      {
        YEAR => 2017,
        CITY => 'Kansas City',
        DATE_START => '2017-03-08',
        DATE_END => '2017-03-19'
      },
      '2017B' =>
      {
        YEAR => 2017,
        CITY => 'Toronto',
        DATE_START => '2017-07-19',
        DATE_END => '2017-07-30'
      },
      '2017C' =>
      {
        YEAR => 2017,
        CITY => 'San Diego',
        DATE_START => '2017-11-23',
        DATE_END => '2017-12-03'
      },
      '2018A' =>
      {
        YEAR => 2018,
        CITY => 'Philadelphia',
        DATE_START => '2018-03-07',
        DATE_END => '2018-03-18'
      },
      '2018B' =>
      {
        YEAR => 2018,
        CITY => 'Atlanta',
        DATE_START => '2018-07-25',
        DATE_END => '2018-08-05'
      },
      '2018C' =>
      {
        YEAR => 2018,
        CITY => 'Honolulu',
        DATE_START => '2018-11-22',
        DATE_END => '2018-12-02'
      },
      '2019A' =>
      {
        YEAR => 2019,
        CITY => 'Memphis',
        DATE_START => '2019-03-20',
        DATE_END => '2019-03-31'
      },
      '2019B' =>
      {
        YEAR => 2019,
        CITY => 'Las Vegas',
        DATE_START => '2019-07-17',
        DATE_END => '2019-07-28'
      },
      '2019C' =>
      {
        YEAR => 2019,
        CITY => 'San Francisco',
        DATE_START => '2019-11-28',
        DATE_END => '2019-12-08'
      },
      '2021C' =>
      {
        YEAR => 2021,
        CITY => 'Austin',
        DATE_START => '2021-11-25',
        DATE_END => '2021-12-05'
      },
      '2022A' =>
      {
        YEAR => 2022,
        CITY => 'Reno',
        DATE_START => '2022-03-09',
        DATE_END => '2022-03-20'
      },
      '2022B' =>
      {
        YEAR => 2022,
        CITY => 'Providence',
        DATE_START => '2022-07-13',
        DATE_END => '2022-07-24'
      },
      '2022C' =>
      {
        YEAR => 2022,
        CITY => 'Phoenix',
        DATE_START => '2022-11-24',
        DATE_END => '2022-12-04'
      },
      '2023A' =>
      {
        YEAR => 2023,
        CITY => 'New Orleans',
        DATE_START => '2023-03-09',
        DATE_END => '2023-03-20'
      },
      '2023B' =>
      {
        YEAR => 2023,
        CITY => 'Chicago',
        DATE_START => '2023-07-12',
        DATE_END => '2023-07-24'
      },
      '2023C' =>
      {
        YEAR => 2023,
        CITY => 'Atlanta',
        DATE_START => '2023-11-23',
        DATE_END => '2023-12-03'
      },
      '2024A' =>
      {
        YEAR => 2024,
        CITY => 'Louisville',
        DATE_START => '2024-03-13',
        DATE_END => '2024-03-24'
      },
      '2024B' =>
      {
        YEAR => 2024,
        CITY => 'Toronto',
        DATE_START => '2024-07-17',
        DATE_END => '2024-07-28'
      },
      '2024C' =>
      {
        YEAR => 2024,
        CITY => 'Las Vegas',
        DATE_START => '2024-11-28',
        DATE_END => '2024-12-08'
      },
    }
  },
);

my %TOURNAMENTS_USA =
(
  'US Girls Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-07-16',
            DATE_END => '2000-07-19'
          } 
        }
      },
    }
  },

  'US Juniors Training',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-29',
            DATE_END => '2013-12-30'
          } 
        }
      },
    }
  },

  'US Junior Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-19'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-07-22',
            DATE_END => '2009-07-23'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-junior-usbc/index.php
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            DATE_START => '2013-12-28',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            DATE_START => '2013-12-31',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-michael-seamon-junior-usbcs/2017-junior-usbc
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-27',
            DATE_END => '2017-12-31'
          } 
        }
      },
      '2019' =>
      {
        # https://www.usbf.org/2019-michael-seamon-jusbc/2019-michael-seamon-jusbc
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-27',
            DATE_END => '2019-12-31'
          } 
        }
      },
      '2024' =>
      {
        # https://www.usbf.org/2024-sam-amer-jusbc/2024-sam-amer-jusbc/index.php
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            DATE_START => '2024-12-27',
            DATE_END => '2025-01-02'
          } 
        }
      },
    }
  },

  'US Open Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    # https://www.usbf.org/usbcs-before-2014/past-usbf-tournaments/usbf-tournaments-before-2014/index.php

    EDITIONS =>
    {
      '1997' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            DATE_START => '1997-06-06',
            DATE_END => '1997-06-09'
          } 
        }
      },
      '1998' =>
      {
        CITY => 'Tunica',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            DATE_START => '1998-06-17',
            DATE_END => '1998-06-20'
          } 
        }
      },
      '1999' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1999,
            DATE_START => '1999-06-17',
            DATE_END => '1999-06-19'
          } 
        }
      },
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-06-14',
            DATE_END => '2000-06-17'
          } 
        }
      },
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-06-09',
            DATE_END => '2004-06-09'
          } 
        }
      },
      '2005' =>
      {
        # https://www.usbf.org/2005-open-usbc/2005-united-states-bridge-championship
        CITY => 'Houston',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-07-04',
            DATE_END => '2005-07-07'
          } 
        }
      },
      '2006' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2006-open-usbc/index.php
        CITY => 'White Plains',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-19',
            DATE_END => '2006-08-27'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-open-usbc/index.php
        CITY => 'Schaumberg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-01',
            DATE_END => '2007-06-11'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/2009-open-usbc/2009-usbc-daily-bulletin
        CITY => 'White Plains',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-15',
            DATE_END => '2009-06-25'
          } 
        }
      },
      '2010' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2010-open-usbc/index.php
        CITY => 'White Plains',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-06-18',
            DATE_END => '2010-06-27'
          } 
        }
      },
      '2011' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2011-open-usbc/index.php
        CITY => 'Las Vegas',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-10',
            DATE_END => '2011-05-18'
          } 
        }
      },
      '2012' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2012-open-usbc/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-04-27',
            DATE_END => '2012-05-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-open-usbc/index.php
        CITY => 'Orlando',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-31',
            DATE_END => '2013-06-10'
          } 
        }
      },
      '2014' =>
      {
        # https://www.usbf.org/2014-open-usbc/2014-open-usbc
        CITY => 'Phoenix',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-09',
            DATE_END => '2014-05-18'
          } 
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2015-open-usbc/2015-open-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-08',
            DATE_END => '2015-05-17'
          } 
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-open-usbc/2016-open-usbc
        CITY => 'Denver',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-06',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-open-usbc/2017-open-usbc/2017-open-usbc-results/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-04-30',
            DATE_END => '2017-05-06'
          } 
        }
      },
      '2018' =>
      {
        # https://www.usbf.org/2018-open-usbc/2018-open-usbc
        CITY => 'Houston',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-11',
            DATE_END => '2018-05-20'
          } 
        }
      },
      '2019' =>
      {
        # https://www.usbf.org/2019-open-usbc/2019-open-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-10',
            DATE_END => '2019-05-19'
          } 
        }
      },
      '2021' =>
      {
        # https://www.usbf.org/2021-open-usbc/2021-open-usbc/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-05',
            DATE_END => '2021-10-12'
          } 
        }
      },
      '2022' =>
      {
        # https://www.usbf.org/2022-open-usbc/2022-open-usbc/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-05-16',
            DATE_END => '2022-05-23'
          } 
        }
      },
      '2023' =>
      {
        # https://www.usbf.org/2023-usbcs/2023-usbcs/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-01',
            DATE_END => '2023-05-08'
          } 
        }
      },
      '2024' =>
      {
        # https://www.usbf.org/2024-united-states-bridge-championships/2024-united-states-bridge-championships/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2024-05-01',
            DATE_END => '2024-05-08'
          } 
        }
      },
    }
  },

  'US Senior Teams',
  {
    ORGANIZATION => 'ACBL',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2006' =>
      {
        # https://s3.amazonaws.com/cdn.acbl.org/nabc/2006/03/results/November19.html
        MEET => 'North American Bridge Championship',
        CITY => 'Honolulu',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-11-16',
            DATE_END => '2006-11-26'
          } 
        }
      },
      '2007A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-07-05',
            DATE_END => '2007-07-05'
          } 
        }
      },
      '2007B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-12-10',
            DATE_END => '2007-12-10'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          } 
        }
      },
      '2009A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-07-06',
            DATE_END => '2009-07-06'
          } 
        }
      },
      '2009B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-01',
            DATE_END => '2009-12-02'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-11-28',
            DATE_END => '2010-12-01'
          } 
        }
      },
      '2011A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-07',
            DATE_END => '2011-06-11'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-28',
            DATE_END => '2011-11-30'
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
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-07'
          } 
        }
      },
    }
  },

  'US Senior Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-06-24',
            DATE_END => '2004-06-25'
          } 
        }
      },
      '2005' =>
      {
        # https://www.usbf.org/2005-senior-usbc/2005-united-states-senior-bridge-championship
        CITY => 'San Antonio',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-07-04',
            DATE_END => '2005-07-07'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-senior-usbc/index.php
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-07-06',
            DATE_END => '2007-07-08'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2009-senior-usbc/index.php
        CITY => 'Summerlin',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-07-06',
            DATE_END => '2009-07-10'
          } 
        }
      },
      '2011' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2011-senior-usbc/index.php
        CITY => 'Detroit',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-05',
            DATE_END => '2011-06-10'
          } 
        }
      },
      '2012' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2012-senior-usbc/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-senior-usbc/index.php
        CITY => 'Orlando',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-20'
          } 
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2024-united-states-bridge-championships/2024-united-states-bridge-championships/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-06-05',
            DATE_END => '2015-06-13'
          } 
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-senior-usbc/2016-senior-usbc
        CITY => 'Denver',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-06-17',
            DATE_END => '2016-06-22'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-senior-usbc/2017-senior-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-17',
            DATE_END => '2017-05-15'
          } 
        }
      },
      '2019' =>
      {
        # https://www.usbf.org/2019-senior-usbc/2019-senior-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-31',
            DATE_END => '2019-06-01'
          } 
        }
      },
      '2021' =>
      {
        # https://www.usbf.org/2021-senior-usbc/2021-senior-usbc/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-23',
            DATE_END => '2021-10-30'
          } 
        }
      },
      '2023' =>
      {
        # https://www.usbf.org/2023-usbcs/2023-usbcs/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-19',
            DATE_END => '2023-05-24'
          } 
        }
      },
      '2024' =>
      {
        # https://www.usbf.org/2024-united-states-bridge-championships/2024-united-states-bridge-championships/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-19',
            DATE_END => '2024-05-26'
          } 
        }
      },
    }
  },

  'US University Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          } 
        }
      },
    }
  },

  'US Women Teams' =>
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2001' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Estimated.
            YEAR => 2001,
            DATE_START => '2001-06-16',
            DATE_END => '2001-06-19'
          } 
        }
      },
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-05-31',
            DATE_END => '2004-06-02'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-06-10',
            DATE_END => '2005-06-13'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-06-12',
            DATE_END => '2006-06-12'
          } 
        }
      },
      '2007A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-02-27',
            DATE_END => '2007-02-28'
          } 
        }
      },
      '2007B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-07'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-25',
            DATE_END => '2009-05-29'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-11'
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
            DATE_START => '2012-06-03',
            DATE_END => '2012-06-06'
          } 
        }
      },
    }
  },

  'US Women Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        # https://www.usbf.org/2005-women-s-usbc/2005-united-states-womens-bridge-championship
        CITY => 'Las Vegas',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-06-06',
            DATE_END => '2005-06-12'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-women-s-usbc/index.php
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-01',
            DATE_END => '2007-06-07'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2009-women-s-usbc/index.php
        CITY => 'Sacramento',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-24',
            DATE_END => '2009-05-28'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-women-s-usbc/index.php
        CITY => 'Orlando',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-20'
          } 
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2015-women-s-usbc/2015-women-s-usbc
        CITY => 'Fort Lauderdale',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-12',
            DATE_END => '2015-04-18'
          } 
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-women-s-usbc/2016-women-s-usbc
        CITY => 'Denver',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-05',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-women-s-usbc/2017-women-s-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-04',
            DATE_END => '2017-05-11'
          } 
        }
      },
      '2019' =>
      {
        # https://www.usbf.org/2019-women-s-usbc/2019-women-s-usbc
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-14',
            DATE_END => '2019-05-20'
          } 
        }
      },
      '2023' =>
      {
        # https://www.usbf.org/2023-usbcs/2023-usbcs/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-20',
            DATE_END => '2023-05-25'
          } 
        }
      },
      '2024' =>
      {
        # https://www.usbf.org/2024-united-states-bridge-championships/2024-united-states-bridge-championships/index.php
        CITY => 'Schaumburg',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-21',
            DATE_END => '2024-05-26'
          } 
        }
      },
    }
  },

  'US Youngster Trials',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2010' =>
      {
        # https://www.usbf.org/2010-junior-usbc/2010-under-21-trials
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-06-26',
            DATE_END => '2010-06-27'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-junior-usbc/index.php
        CITY => 'Atlanta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            DATE_START => '2013-12-31',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            DATE_START => '2015-12-27',
            DATE_END => '2015-12-31'
          } 
        }
      },
    }
  },

  'USBF Challenge Match',
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
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
            DATE_START => '2016-01-31',
            DATE_END => '2016-01-31'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_USA, \%TOURNAMENTS_USA, 'United States');
}

1;
