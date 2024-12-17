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
    ORIGIN => 'Transnational',
    ZONE => 'North America',

    EDITIONS => 
    {
      '1996A' =>
      {
        MEET_ORDINAL => 39,
        YEAR => 1996,
        CITY => 'Philadelphia',
        DATE_START => '1996-03-01',
        DATE_END => '1996-03-10'
      },
      '1996B' =>
      {
        MEET_ORDINAL => 68,
        YEAR => 1996,
        CITY => 'Miami Beach',
        DATE_START => '1996-08-01',
        DATE_END => '1996-08-11'
      },
      '1996C' =>
      {
        MEET_ORDINAL => 70,
        YEAR => 1996,
        CITY => 'San Francisco',
        DATE_START => '1996-11-21',
        DATE_END => '1996-12-01'
      },
      '1997A' =>
      {
        MEET_ORDINAL => 40,
        YEAR => 1997,
        CITY => 'Dallas',
        DATE_START => '1997-03-06',
        DATE_END => '1997-03-16'
      },
      '1997B' =>
      {
        MEET_ORDINAL => 69,
        YEAR => 1997,
        CITY => 'Albuquerque',
        DATE_START => '1997-07-24',
        DATE_END => '1997-08-03'
      },
      '1997C' =>
      {
        MEET_ORDINAL => 71,
        YEAR => 1997,
        CITY => 'St. Louis',
        DATE_START => '1997-11-20',
        DATE_END => '1997-11-30'
      },
      '1998A' =>
      {
        MEET_ORDINAL => 41,
        YEAR => 1998,
        CITY => 'Reno',
        DATE_START => '1998-03-19',
        DATE_END => '1998-03-29'
      },
      '1998B' =>
      {
        MEET_ORDINAL => 70,
        YEAR => 1998,
        CITY => 'Chicago',
        DATE_START => '1998-07-23',
        DATE_END => '1998-08-02'
      },
      '1998C' =>
      {
        MEET_ORDINAL => 72,
        YEAR => 1998,
        CITY => 'Orlando',
        DATE_START => '1998-11-19',
        DATE_END => '1998-11-29'
      },
      '1999A' =>
      {
        MEET_ORDINAL => 42,
        YEAR => 1999,
        CITY => 'Vancouver',
        DATE_START => '1999-03-18',
        DATE_END => '1999-03-28'
      },
      '1999B' =>
      {
        MEET_ORDINAL => 71,
        YEAR => 1999,
        CITY => 'San Antonio',
        DATE_START => '1999-07-21',
        DATE_END => '1999-07-31'
      },
      '1999C' =>
      {
        MEET_ORDINAL => 73,
        YEAR => 1999,
        CITY => 'Boston',
        DATE_START => '1999-11-18',
        DATE_END => '1999-11-18'
      },
      '2000A' =>
      {
        MEET_ORDINAL => 43,
        YEAR => 2000,
        CITY => 'Cincinnati',
        DATE_START => '2000-03-19',
        DATE_END => '2000-03-29'
      },
      '2000B' =>
      {
        MEET_ORDINAL => 72,
        YEAR => 2000,
        CITY => 'Anaheim',
        DATE_START => '2000-08-10',
        DATE_END => '2000-08-20'
      },
      '2000C' =>
      {
        MEET_ORDINAL => 74,
        YEAR => 2000,
        CITY => 'Birmingham',
        DATE_START => '2000-11-16',
        DATE_END => '2000-11-26'
      },
      '2001A' =>
      {
        MEET_ORDINAL => 44,
        YEAR => 2001,
        CITY => 'Kansas City',
        DATE_START => '2001-03-15',
        DATE_END => '2001-03-25'
      },
      '2001B' =>
      {
        MEET_ORDINAL => 73,
        YEAR => 2001,
        CITY => 'Toronto',
        DATE_START => '2001-07-19',
        DATE_END => '2001-07-29'
      },
      '2001C' =>
      {
        MEET_ORDINAL => 75,
        YEAR => 2001,
        CITY => 'Las Vegas',
        DATE_START => '2001-11-18',
        DATE_END => '2001-11-27'
      },
      '2002A' =>
      {
        MEET_ORDINAL => 45,
        YEAR => 2002,
        CITY => 'Houston',
        DATE_START => '2002-03-07',
        DATE_END => '2002-03-17'
      },
      '2002B' =>
      {
        MEET_ORDINAL => 74,
        YEAR => 2002,
        CITY => 'Washington, DC',
        DATE_START => '2002-07-18',
        DATE_END => '2002-07-28'
      },
      '2002C' =>
      {
        MEET_ORDINAL => 76,
        YEAR => 2002,
        CITY => 'Phoenix',
        DATE_START => '2002-11-28',
        DATE_END => '2002-12-08'
      },
      '2003A' =>
      {
        MEET_ORDINAL => 46,
        YEAR => 2003,
        CITY => 'Philadelphia',
        DATE_START => '2003-03-06',
        DATE_END => '2003-03-16'
      },
      '2003B' =>
      {
        MEET_ORDINAL => 75,
        YEAR => 2003,
        CITY => 'Long Beach',
        DATE_START => '2003-07-17',
        DATE_END => '2003-07-27'
      },
      '2003C' =>
      {
        MEET_ORDINAL => 77,
        YEAR => 2003,
        CITY => 'New Orleans',
        DATE_START => '2003-11-20',
        DATE_END => '2003-11-30'
      },
      '2004A' =>
      {
        MEET_ORDINAL => 47,
        YEAR => 2004,
        CITY => 'Reno',
        DATE_START => '2004-03-18',
        DATE_END => '2004-03-28'
      },
      '2004B' =>
      {
        MEET_ORDINAL => 76,
        YEAR => 2004,
        CITY => 'New York City',
        DATE_START => '2004-07-21',
        DATE_END => '2004-07-31'
      },
      '2004C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 78,
        YEAR => 2004,
        CITY => 'Orlando',
        DATE_START => '2004-11-19',
        DATE_END => '2004-11-29'
      },
      '2005A' =>
      {
        MEET_ORDINAL => 48,
        YEAR => 2005,
        CITY => 'Pittsburgh',
        DATE_START => '2005-03-10',
        DATE_END => '2005-03-21'
      },
      '2005B' =>
      {
        MEET_ORDINAL => 77,
        YEAR => 2005,
        CITY => 'Atlanta',
        DATE_START => '2005-07-21',
        DATE_END => '2005-07-31'
      },
      '2005C' =>
      {
        MEET_ORDINAL => 79,
        YEAR => 2005,
        CITY => 'Denver',
        DATE_START => '2005-11-21',
        DATE_END => '2005-11-31'
      },
      '2006A' =>
      {
        MEET_ORDINAL => 49,
        YEAR => 2006,
        CITY => 'Dallas',
        DATE_START => '2006-03-30',
        DATE_END => '2006-04-09'
      },
      '2006B' =>
      {
        MEET_ORDINAL => 78,
        YEAR => 2006,
        CITY => 'Chicago',
        DATE_START => '2006-07-13',
        DATE_END => '2006-07-23'
      },
      '2006C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 79, # Should be 80?
        YEAR => 2006, 
        CITY => 'Honolulu',
        DATE_START => '2006-11-16',
        DATE_END => '2006-11-27'
      },
      '2007A' =>
      {
        MEET_ORDINAL => 50,
        YEAR => 2007,
        CITY => 'St. Louis',
        DATE_START => '2007-03-08',
        DATE_END => '2007-03-18'
      },
      '2007B' =>
      {
        MEET_ORDINAL => 79,
        YEAR => 2007,
        CITY => 'Nashville',
        DATE_START => '2007-07-19',
        DATE_END => '2007-07-29'
      },
      '2007C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 81,
        YEAR => 2007,
        CITY => 'San Francisco',
        DATE_START => '2007-11-22',
        DATE_END => '2007-12-02'
      },
      '2008A' =>
      {
        MEET_ORDINAL => 51,
        YEAR => 2008,
        CITY => 'Detroit',
        DATE_START => '2008-03-06',
        DATE_END => '2008-03-16'
      },
      '2008B' =>
      {
        MEET_ORDINAL => 80,
        YEAR => 2008,
        CITY => 'Las Vegas',
        DATE_START => '2008-07-16',
        DATE_END => '2008-07-27'
      },
      '2008C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 81,
        YEAR => 2008,
        CITY => 'Boston',
        DATE_START => '2008-11-20',
        DATE_END => '2008-11-30'
      },
      '2009A' =>
      {
        MEET_ORDINAL => 52,
        YEAR => 2009,
        CITY => 'Houston',
        DATE_START => '2009-03-12',
        DATE_END => '2009-03-22'
      },
      '2009B' =>
      {
        MEET_ORDINAL => 81,
        YEAR => 2009,
        CITY => 'Washington DC',
        DATE_START => '2009-07-22',
        DATE_END => '2009-08-02'
      },
      '2009C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 83,
        YEAR => 2009,
        CITY => 'San Diego',
        DATE_START => '2009-11-26',
        DATE_END => '2009-12-06'
      },
      '2010A' =>
      {
        MEET_ORDINAL => 53,
        YEAR => 2010,
        CITY => 'Reno',
        DATE_START => '2010-03-11',
        DATE_END => '2010-03-22'
      },
      '2010B' =>
      {
        MEET_ORDINAL => 82,
        YEAR => 2010,
        CITY => 'New Orleans',
        DATE_START => '2010-07-22',
        DATE_END => '2010-08-01'
      },
      '2010C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 83,
        YEAR => 2010,
        CITY => 'Orlando',
        DATE_START => '2010-11-25',
        DATE_END => '2010-12-05'
      },
      '2011A' =>
      {
        MEET_ORDINAL => 54,
        YEAR => 2011,
        CITY => 'Louisville',
        DATE_START => '2011-03-10',
        DATE_END => '2011-03-20'
      },
      '2011B' =>
      {
        MEET_ORDINAL => 83,
        YEAR => 2011,
        CITY => 'Toronto',
        DATE_START => '2011-07-21',
        DATE_END => '2011-07-31'
      },
      '2011C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 85,
        YEAR => 2011,
        CITY => 'Seattle',
        DATE_START => '2011-11-24',
        DATE_END => '2011-12-04'
      },
      '2012A' =>
      {
        MEET_ORDINAL => 55,
        YEAR => 2012,
        CITY => 'Memphis',
        DATE_START => '2012-03-15',
        DATE_END => '2012-03-25'
      },
      '2012B' =>
      {
        MEET_ORDINAL => 84,
        YEAR => 2012,
        CITY => 'Philadelphia',
        DATE_START => '2012-07-12',
        DATE_END => '2012-07-23'
      },
      '2012C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 85,
        YEAR => 2012,
        CITY => 'New Orleans',
        DATE_START => '2012-11-22',
        DATE_END => '2012-12-03'
      },
      '2013A' =>
      {
        MEET_ORDINAL => 56,
        YEAR => 2013,
        CITY => 'St. Louis',
        DATE_START => '2013-03-14',
        DATE_END => '2013-03-25'
      },
      '2013B' =>
      {
        MEET_ORDINAL => 85,
        YEAR => 2013,
        CITY => 'Atlanta',
        DATE_START => '2013-08-01',
        DATE_END => '2013-08-12'
      },
      '2013C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 87,
        YEAR => 2013,
        CITY => 'Phoenix',
        DATE_START => '2013-11-28',
        DATE_END => '2013-12-09'
      },
      '2014A' =>
      {
        MEET_ORDINAL => 57,
        YEAR => 2014,
        CITY => 'Dallas',
        DATE_START => '2014-03-19',
        DATE_END => '2014-03-31'
      },
      '2014B' =>
      {
        MEET_ORDINAL => 86,
        YEAR => 2014,
        CITY => 'Las Vegas',
        DATE_START => '2014-07-17',
        DATE_END => '2014-07-28'
      },
      '2014C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 87,
        YEAR => 2014,
        CITY => 'Providence',
        DATE_START => '2014-11-27',
        DATE_END => '2014-12-08'
      },
      '2015A' =>
      {
        MEET_ORDINAL => 58,
        YEAR => 2015,
        CITY => 'New Orleans',
        DATE_START => '2015-03-12',
        DATE_END => '2015-03-23'
      },
      '2015B' =>
      {
        MEET_ORDINAL => 87,
        YEAR => 2015,
        CITY => 'Chicago',
        DATE_START => '2015-08-06',
        DATE_END => '2015-08-17'
      },
      '2015C' =>
      {
        # Senior Teams
        MEET_ORDINAL => 88,
        YEAR => 2015,
        CITY => 'Denver',
        DATE_START => '2015-11-26',
        DATE_END => '2015-12-07'
      },
      '2016A' =>
      {
        MEET_ORDINAL => 59,
        YEAR => 2016,
        CITY => 'Reno',
        DATE_START => '2016-03-09',
        DATE_END => '2016-03-21'
      },
      '2016B' =>
      {
        MEET_ORDINAL => 88,
        YEAR => 2016,
        CITY => 'Washington DC',
        DATE_START => '2016-07-20',
        DATE_END => '2016-08-03'
      },
      '2016C' =>
      {
        MEET_ORDINAL => 89,
        YEAR => 2016,
        CITY => 'Orlando',
        DATE_START => '2016-11-24',
        DATE_END => '2016-12-04'
      },
      '2017A' =>
      {
        MEET_ORDINAL => 60,
        YEAR => 2017,
        CITY => 'Kansas City',
        DATE_START => '2017-03-08',
        DATE_END => '2017-03-19'
      },
      '2017B' =>
      {
        MEET_ORDINAL => 89,
        YEAR => 2017,
        CITY => 'Toronto',
        DATE_START => '2017-07-19',
        DATE_END => '2017-07-30'
      },
      '2017C' =>
      {
        MEET_ORDINAL => 90,
        YEAR => 2017,
        CITY => 'San Diego',
        DATE_START => '2017-11-23',
        DATE_END => '2017-12-03'
      },
      '2018A' =>
      {
        MEET_ORDINAL => 61,
        YEAR => 2018,
        CITY => 'Philadelphia',
        DATE_START => '2018-03-07',
        DATE_END => '2018-03-18'
      },
      '2018B' =>
      {
        MEET_ORDINAL => 90,
        YEAR => 2018,
        CITY => 'Atlanta',
        DATE_START => '2018-07-25',
        DATE_END => '2018-08-05'
      },
      '2018C' =>
      {
        MEET_ORDINAL => 91,
        YEAR => 2018,
        CITY => 'Honolulu',
        DATE_START => '2018-11-22',
        DATE_END => '2018-12-02'
      },
      '2019A' =>
      {
        MEET_ORDINAL => 61, # Should be 62?
        YEAR => 2019,
        CITY => 'Memphis',
        DATE_START => '2019-03-20',
        DATE_END => '2019-03-31'
      },
      '2019B' =>
      {
        MEET_ORDINAL => 91,
        YEAR => 2019,
        CITY => 'Las Vegas',
        DATE_START => '2019-07-17',
        DATE_END => '2019-07-28'
      },
      '2019C' =>
      {
        MEET_ORDINAL => 92,
        YEAR => 2019,
        CITY => 'San Francisco',
        DATE_START => '2019-11-28',
        DATE_END => '2019-12-08'
      },
      '2021C' =>
      {
        MEET_ORDINAL => 93,
        YEAR => 2021,
        CITY => 'Austin',
        DATE_START => '2021-11-25',
        DATE_END => '2021-12-05'
      },
      '2022A' =>
      {
        MEET_ORDINAL => 62,
        YEAR => 2022,
        CITY => 'Reno',
        DATE_START => '2022-03-09',
        DATE_END => '2022-03-20'
      },
      '2022B' =>
      {
        MEET_ORDINAL => 92,
        YEAR => 2022,
        CITY => 'Providence',
        DATE_START => '2022-07-13',
        DATE_END => '2022-07-24'
      },
      '2022C' =>
      {
        MEET_ORDINAL => 94,
        YEAR => 2022,
        CITY => 'Phoenix',
        DATE_START => '2022-11-24',
        DATE_END => '2022-12-04'
      },
      '2023A' =>
      {
        MEET_ORDINAL => 63,
        YEAR => 2023,
        CITY => 'New Orleans',
        DATE_START => '2023-03-09',
        DATE_END => '2023-03-20'
      },
      '2023B' =>
      {
        MEET_ORDINAL => 93,
        YEAR => 2023,
        CITY => 'Chicago',
        DATE_START => '2023-07-12',
        DATE_END => '2023-07-24'
      },
      '2023C' =>
      {
        MEET_ORDINAL => 95,
        YEAR => 2023,
        CITY => 'Atlanta',
        DATE_START => '2023-11-23',
        DATE_END => '2023-12-03'
      },
      '2024A' =>
      {
        MEET_ORDINAL => 64,
        YEAR => 2024,
        CITY => 'Louisville',
        DATE_START => '2024-03-13',
        DATE_END => '2024-03-24'
      },
      '2024B' =>
      {
        MEET_ORDINAL => 94,
        YEAR => 2024,
        CITY => 'Toronto',
        DATE_START => '2024-07-17',
        DATE_END => '2024-07-28'
      },
      '2024C' =>
      {
        MEET_ORDINAL => 96,
        YEAR => 2024,
        CITY => 'Las Vegas',
        DATE_START => '2024-11-28',
        DATE_END => '2024-12-08'
      },
    }
  },

  'United States Bridge Championship' =>
  {
    # https://usbf.org/past-tournaments/past-usbf-tournaments/index.php

    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    ZONE => 'North America',

    EDITIONS => 
    {
      '1997' =>
      {
        # Open Trials
        YEAR => 1997,
        DATE_START => '1997-06-06',
        DATE_END => '1997-06-09'
      },
      '1998' =>
      {
        # Open Trials
        YEAR => 1998,
        CITY => 'Tunica',
        DATE_START => '1998-06-17',
        DATE_END => '1998-06-20'
      },
      '1999' =>
      {
        # Open Trials
        YEAR => 1999,
        DATE_START => '1999-06-17',
        DATE_END => '1999-06-19'
      },
      '2000' =>
      {
        # Open Trials
        YEAR => 2000,
        DATE_START => '2000-06-14',
        DATE_END => '2000-06-17'
      },
      '2001A' =>
      {
        # Open Trials
        YEAR => 2001,
        CITY => 'Houston',
        DATE_START => '2001-05-11',
        DATE_END => '2001-05-20'
      },
      '2001B' =>
      {
        # Women Trials (estimated)
        YEAR => 2001,
        DATE_START => '2001-06-16',
        DATE_END => '2001-06-19'
      },
      '2002' =>
      {
        # Open Trials
        YEAR => 2002,
        CITY => 'Houston',
        DATE_START => '2002-05-10',
        DATE_END => '2002-05-19'
      },
      '2004A' =>
      {
        # Women Trials
        YEAR => 2004,
        DATE_START => '2004-05-31',
        DATE_END => '2004-06-02'
      },
      '2004B' =>
      {
        # Open Trials
        YEAR => 2004,
        CITY => 'Memphis',
        DATE_START => '2004-06-04',
        DATE_END => '2004-06-13'
      },
      '2004C' =>
      {
        # Senior Trials
        YEAR => 2004,
        DATE_START => '2004-06-24',
        DATE_END => '2004-06-25'
      },
      '2005A' =>
      {
        YEAR => 2005,
        CITY => 'Houston',
        DATE_START => '2005-05-13',
        DATE_END => '2005-05-22'
      },
      '2005B' =>
      {
        # Women Trials
        YEAR => 2005,
        CITY => 'Las Vegas',
        DATE_START => '2005-06-05',
        DATE_END => '2005-06-13'
      },
      '2005C' =>
      {
        # Senior Trials
        YEAR => 2005,
        CITY => 'San Antonio',
        DATE_START => '2005-07-04',
        DATE_END => '2005-07-07'
      },
      '2006A' =>
      {
        # Women Trials, dates unclear.
        YEAR => 2006,
        DATE_START => '2006-06-12',
        DATE_END => '2006-06-12'
      },
      '2006B' =>
      {
        # Open Trials
        YEAR => 2006,
        CITY => 'White Plains',
        DATE_START => '2006-08-19',
        DATE_END => '2006-08-27'
      },
      '2007A' =>
      {
        # Women Trials
        YEAR => 2007,
        CITY => 'Schaumburg',
        DATE_START => '2007-06-01',
        DATE_END => '2007-06-07'
      },
      '2007B' =>
      {
        # Open & Senior Trials
        YEAR => 2007,
        CITY => 'Schaumburg',
        DATE_START => '2007-06-05',
        DATE_END => '2007-06-11'
      },
      '2008A' =>
      {
        # Open & Women Trials (approximate)
        YEAR => 2008,
        DATE_START => '2008-06-03',
        DATE_END => '2008-06-07'
      },
      '2008C' =>
      {
        # Senior Trials (approximate)
        YEAR => 2008,
        DATE_START => '2008-06-21',
        DATE_END => '2008-06-21'
      },
      '2009A' =>
      {
        # Women Trials
        YEAR => 2009,
        CITY => 'Sacramento',
        DATE_START => '2009-05-24',
        DATE_END => '2009-05-29'
      },
      '2009B' =>
      {
        # Open Trials
        YEAR => 2009,
        CITY => 'White Plains',
        DATE_START => '2009-06-06',
        DATE_END => '2009-06-15'
      },
      '2009C' =>
      {
        # Senior Trials
        YEAR => 2009,
        CITY => 'Summerlin',
        DATE_START => '2009-07-06',
        DATE_END => '2009-07-10'
      },
      '2010' =>
      {
        # Open Trials
        YEAR => 2010,
        CITY => 'White Plains',
        DATE_START => '2010-06-20',
        DATE_END => '2010-06-27'
      },
      '2011A' =>
      {
        # Open Trials
        YEAR => 2011,
        CITY => 'Las Vegas',
        DATE_START => '2011-05-10',
        DATE_END => '2011-05-17'
      },
      '2011B' =>
      {
        # Senior & Women Trials
        YEAR => 2011,
        CITY => 'Detroit',
        DATE_START => '2011-06-05',
        DATE_END => '2011-06-11'
      },
      '2012A' =>
      {
        # Open Trials
        YEAR => 2012,
        CITY => 'Schaumburg',
        DATE_START => '2012-04-27',
        DATE_END => '2012-05-06'
      },
      '2012B' =>
      {
        # Senior & Women Trials
        YEAR => 2012,
        CITY => 'Schaumburg',
        DATE_START => '2012-06-01',
        DATE_END => '2012-06-07'
      },
      '2013A' =>
      {
        # Open Trials
        YEAR => 2013,
        CITY => 'Orlando',
        DATE_START => '2013-06-01',
        DATE_END => '2013-06-10'
      },
      '2013B' =>
      {
        # Senior & Women Trials
        YEAR => 2013,
        CITY => 'Orlando',
        DATE_START => '2013-07-12',
        DATE_END => '2013-07-20'
      },
      '2014' =>
      {
        # Open Trials
        YEAR => 2014,
        CITY => 'Phoenix',
        DATE_START => '2014-05-11',
        DATE_END => '2014-05-19'
      },
      '2015A' =>
      {
        # Women Trials
        YEAR => 2015,
        CITY => 'Fort Lauderdale',
        DATE_START => '2015-04-14',
        DATE_END => '2015-04-18'
      },
      '2015B' =>
      {
        # Open Trials
        YEAR => 2015,
        CITY => 'Schaumburg',
        DATE_START => '2015-05-08',
        DATE_END => '2015-05-17'
      },
      '2015C' =>
      {
        # Senior Trials
        YEAR => 2015,
        CITY => 'Schaumburg',
        DATE_START => '2015-06-05',
        DATE_END => '2015-06-13'
      },
      '2016A' =>
      {
        # Open Trials
        YEAR => 2016,
        CITY => 'Denver',
        DATE_START => '2016-05-08',
        DATE_END => '2016-05-15'
      },
      '2016B' =>
      {
        # Women Trials
        YEAR => 2016,
        CITY => 'Denver',
        DATE_START => '2016-05-30',
        DATE_END => '2016-06-05'
      },
      '2016C' =>
      {
        # Senior Trials
        YEAR => 2016,
        CITY => 'Denver',
        DATE_START => '2016-06-17',
        DATE_END => '2016-06-22'
      },
      '2017A' =>
      {
        # Open Trials
        YEAR => 2017,
        CITY => 'Schaumburg',
        DATE_START => '2017-04-30',
        DATE_END => '2017-05-06'
      },
      '2017B' =>
      {
        # Women Trials
        YEAR => 2017,
        CITY => 'Schaumburg',
        DATE_START => '2017-05-04',
        DATE_END => '2017-05-11'
      },
      '2017C' =>
      {
        # Senior Trials
        YEAR => 2017,
        CITY => 'Schaumburg',
        DATE_START => '2017-05-15',
        DATE_END => '2017-05-17'
      },
      '2018' =>
      {
        # Open Trials
        YEAR => 2018,
        CITY => 'Houston',
        DATE_START => '2018-05-11',
        DATE_END => '2018-05-20'
      },
      '2019A' =>
      {
        # Open & Women Trials
        YEAR => 2019,
        CITY => 'Schaumburg',
        DATE_START => '2019-05-10',
        DATE_END => '2019-05-20'
      },
      '2019B' =>
      {
        # Senior Trials
        YEAR => 2019,
        CITY => 'Schaumburg',
        DATE_START => '2019-05-31',
        DATE_END => '2019-06-01'
      },
      '2021A' =>
      {
        # Open Trials
        YEAR => 2021,
        CITY => 'Schaumburg',
        DATE_START => '2021-10-05',
        DATE_END => '2021-10-12'
      },
      '2021B' =>
      {
        # Senior Trials
        YEAR => 2021,
        CITY => 'Schaumburg',
        DATE_START => '2021-10-23',
        DATE_END => '2021-10-30'
      },
      '2022' =>
      {
        # Open Trials
        YEAR => 2022,
        CITY => 'Schaumburg',
        DATE_START => '2022-05-16',
        DATE_END => '2022-05-23'
      },
      '2023A' =>
      {
        # Open Trials
        YEAR => 2023,
        CITY => 'Schaumburg',
        DATE_START => '2023-05-01',
        DATE_END => '2023-05-08'
      },
      '2023B' =>
      {
        # Senior & Women Trials
        YEAR => 2023,
        CITY => 'Schaumburg',
        DATE_START => '2023-05-19',
        DATE_END => '2023-05-25'
      },
      '2024A' =>
      {
        # Open Trials
        YEAR => 2024,
        CITY => 'Schaumburg',
        DATE_START => '2024-05-01',
        DATE_END => '2024-05-08'
      },
      '2024B' =>
      {
        # Senior & Women Trials
        YEAR => 2024,
        CITY => 'Schaumburg',
        DATE_START => '2024-05-19',
        DATE_END => '2024-05-26'
      }
    }
  },

  'United States Youth Bridge Championship' =>
  {
    # https://usbf.org/past-tournaments/past-usbf-tournaments/index.php

    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    ZONE => 'North America',

    EDITIONS => 
    {
      '2013-14' =>
      {
        CITY => 'Atlanta',
        DATE_START => '2013-12-29',
        DATE_END => '2014-01-02'
      },
      '2015-16' =>
      {
        DATE_START => '2015-12-27',
        DATE_END => '2015-12-31'
      },
      '2017-18' =>
      {
        DATE_START => '2017-12-27',
        DATE_END => '2017-12-31'
      },
      '2019-20' =>
      {
        DATE_START => '2019-12-27',
        DATE_END => '2019-12-31'
      },
      '2024-25' =>
      {
        DATE_START => '2024-12-27',
        DATE_END => '2025-01-02'
      },
    }
  },
);

my %TOURNAMENTS_USA =
(
  '0 to 1500 Spingold' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2007B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'QUARTER',
            DATE_START => '2007-07-24',
            DATE_END => '2007-07-24'
          },
        }
      },
    }
  },

  'Collegiate Bowl' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2014B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'MATCH',
            DATE_START => '2014-07-19',
            DATE_END => '2014-07-20'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-20',
            DATE_END => '2014-07-20'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-21',
            DATE_END => '2014-07-21'
          }
        }
      },
      '2015' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2015B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-08',
            DATE_END => '2015-08-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2015-08-09',
            DATE_END => '2015-08-10'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-09',
            DATE_END => '2015-08-10'
          }
        }
      },
      '2016' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2016B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-23',
            DATE_END => '2016-07-24'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2016-07-24',
            DATE_END => '2016-07-25'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-24',
            DATE_END => '2016-07-25'
          }
        }
      },
    }
  },

  'Grand National Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2010B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-24',
            DATE_END => '2010-07-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-07-25',
            DATE_END => '2010-07-26'
          },
        }
      },
      '2011' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2011B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-24',
            DATE_END => '2011-07-25'
          },
        }
      },
      '2012' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-15',
            DATE_END => '2012-07-16'
          }
        }
      },
      '2013' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-04'
          },
        }
      },
      '2014' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2014B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-19',
            DATE_END => '2014-07-20'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-20',
            DATE_END => '2014-07-21'
          },
        }
      },
      '2015' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2015B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-08',
            DATE_END => '2015-08-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-09',
            DATE_END => '2015-08-10'
          },
        }
      },
      '2016' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2016B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-23',
            DATE_END => '2016-07-24'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-24',
            DATE_END => '2016-07-25'
          },
        }
      },
    }
  },

  "Missouri Braggin' Rights" => 
  {
    ORGANIZATION => 'ACBL',
    COUNTRY => 'USA',
    ORIGIN => 'National',
    ZONE => 'North America',
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
            major => 'QUARTER',
            DATE_START => '2009-08-22',
            DATE_END => '2009-08-22'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-14'
          },
        }
      },
    }
  },

  'Philadelphia Solomon Teams' => 
  {
    ORGANIZATION => 'ACBL',
    COUNTRY => 'USA',
    CITY => 'Philadelphia',
    ORIGIN => 'National',
    ZONE => 'North America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-05-15',
            DATE_END => '2010-05-15'
          },
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-07-13',
            DATE_END => '2011-07-13'
          },
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-09-11',
            DATE_END => '2013-09-11'
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
            STAGE => 'Final',
            DATE_START => '2014-11-05',
            DATE_END => '2014-11-05'
          },
        }
      },
    }
  },

  'Reisinger BAM Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2004C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-11-29',
            DATE_END => '2004-11-29'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-29',
            DATE_END => '2004-11-29'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2006C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-11-26',
            DATE_END => '2006-11-27'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-11-26',
            DATE_END => '2006-11-27'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2007C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-02',
            DATE_END => '2007-12-02'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2008C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-30',
            DATE_END => '2008-11-30'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2009C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-06',
            DATE_END => '2009-12-06'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2010C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-05',
            DATE_END => '2010-12-05'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2011C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-04',
            DATE_END => '2011-12-04'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2012C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-02',
            DATE_END => '2012-12-02'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-02',
            DATE_END => '2012-12-03'
          },
        }
      },
      '2013' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2013C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-08',
            DATE_END => '2013-12-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-08',
            DATE_END => '2013-12-09'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2014C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-06',
            DATE_END => '2014-12-07'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2014-12-07',
            DATE_END => '2014-12-08'
          },
        }
      },
      '2015' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2015C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2015-12-05',
            DATE_END => '2015-12-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-07'
          },
        }
      },
    }
  },

  'Spingold Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1996' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '1996B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Actually ended on Saturday August 10, but no matter.
            YEAR => 1996,
            STAGE => 'Final',
            DATE_START => '1996-08-10',
            DATE_END => '1996-08-11'
          } 
        }
      },
      '1997' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '1997B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Rof16',
            DATE_START => '1997-07-27',
            DATE_END => '1997-07-27'
          },
          'C1' => 
          {
            YEAR => 1997,
            STAGE => 'Quarterfinal',
            DATE_START => '1997-07-27',
            DATE_END => '1997-07-28'
          },
          'C2' => 
          {
            YEAR => 1997,
            STAGE => 'Semifinal',
            DATE_START => '1997-07-30',
            DATE_END => '1997-07-31'
          },
          'C3' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            DATE_START => '1997-08-01',
            DATE_END => '1997-08-02'
          },
        }
      },
      '1998' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '1998B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1998-07-27',
            DATE_END => '1998-08-01'
          } 
        }
      },
      '1999' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '1999B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1999,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1999-07-28',
            DATE_END => '1999-07-31'
          } 
        }
      },
      '2000' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2000B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-08-13',
            DATE_END => '2000-08-19'
          } 
        }
      },
      '2001' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2001B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            STAGE => 'Rof128',
            DATE_START => '2001-07-19',
            DATE_END => '2001-07-19'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Rof64',
            DATE_START => '2001-07-20',
            DATE_END => '2001-07-20'
          },
          'C2' => 
          {
            YEAR => 2001,
            STAGE => 'Rof32',
            DATE_START => '2001-07-21',
            DATE_END => '2001-07-21'
          },
          'C3' => 
          {
            YEAR => 2001,
            STAGE => 'Rof16',
            DATE_START => '2001-07-22',
            DATE_END => '2001-07-22'
          },
          'C4' => 
          {
            YEAR => 2001,
            STAGE => 'Quarterfinal',
            DATE_START => '2001-07-23',
            DATE_END => '2001-07-24'
          },
          'C5' => 
          {
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-07-25',
            DATE_END => '2001-07-27'
          },
          'C6' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-07-27',
            DATE_END => '2001-07-28'
          } 
        }
      },
      '2004' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2004B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-07-28',
            DATE_END => '2004-07-29'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-07-30',
            DATE_END => '2004-07-31'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2005B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-07-27',
            DATE_END => '2005-07-28'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-07-29',
            DATE_END => '2005-07-30'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2006B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Rof64',
            major => 'SEGMENT|ROUND|QUARTER',
            DATE_START => '2006-07-14',
            DATE_END => '2006-07-14'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2006-07-15',
            DATE_END => '2006-07-15'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2006-07-16',
            DATE_END => '2006-07-16'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-07-17',
            DATE_END => '2006-07-18'
          },
          'C4' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-07-19',
            DATE_END => '2006-07-20'
          },
          'C5' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-07-21',
            DATE_END => '2006-07-22'
          },
        }
      },
      '2007' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2007B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2007-07-22',
            DATE_END => '2007-07-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|QUARTER',
            DATE_START => '2007-07-23',
            DATE_END => '2007-07-24'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-07-25',
            DATE_END => '2007-07-26'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-07-27',
            DATE_END => '2007-07-28'
          },
        }
      },
      '2008' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2008B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2008-07-19',
            DATE_END => '2008-07-19'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2008-07-20',
            DATE_END => '2008-07-20'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2008-07-21',
            DATE_END => '2008-07-21'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-22',
            DATE_END => '2008-07-23'
          },
          'C4' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-24',
            DATE_END => '2008-07-25'
          },
          'C5' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-26',
            DATE_END => '2008-07-27'
          },
        }
      },
      '2009' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2009B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2009-07-28',
            DATE_END => '2009-07-28'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2009-07-29',
            DATE_END => '2009-07-29'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-07-30',
            DATE_END => '2009-07-30'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-31',
            DATE_END => '2009-08-01'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-01',
            DATE_END => '2009-08-02'
          },
          'C5' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-02',
            DATE_END => '2009-08-02'
          },
        }
      },
      '2010' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2010B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2010-07-27',
            DATE_END => '2010-07-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-07-28',
            DATE_END => '2010-07-29'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-29',
            DATE_END => '2010-07-30'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-30',
            DATE_END => '2010-07-31'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-07-31',
            DATE_END => '2010-08-01'
          },
        }
      },
      '2011' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2011B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2011-07-27',
            DATE_END => '2011-07-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-28'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-07-29',
            DATE_END => '2011-07-30'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-07-30',
            DATE_END => '2011-07-30'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-31',
            DATE_END => '2011-07-31'
          },
        }
      },
      '2012' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2012-07-18',
            DATE_END => '2012-07-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-07-19',
            DATE_END => '2012-07-20'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-20',
            DATE_END => '2012-07-21'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-21',
            DATE_END => '2012-07-22'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-22',
            DATE_END => '2012-07-23'
          },
        }
      },
      '2013' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-08-07',
            DATE_END => '2013-08-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-08-08',
            DATE_END => '2013-08-09'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-10'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT|QUARTER',
            DATE_START => '2013-08-10',
            DATE_END => '2013-08-11'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-11',
            DATE_END => '2013-08-12'
          },
        }
      },
      '2014' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2014B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-07-23',
            DATE_END => '2014-07-24'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-07-24',
            DATE_END => '2014-07-25'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-25',
            DATE_END => '2014-07-26'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-26',
            DATE_END => '2014-07-27'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-27',
            DATE_END => '2014-07-28'
          },
        }
      },
      '2015' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2015B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2015-08-13',
            DATE_END => '2015-08-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-08-13',
            DATE_END => '2015-08-14'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-14',
            DATE_END => '2015-08-15'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-16'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-16',
            DATE_END => '2015-08-17'
          },
        }
      },
      '2016' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2016B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2016-07-27',
            DATE_END => '2016-07-28'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-07-28',
            DATE_END => '2016-07-29'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-29',
            DATE_END => '2016-07-30'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-31'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-31',
            DATE_END => '2016-08-01'
          },
        }
      },
    }
  },

  "Sternberg Women's BAM Teams" => 
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2004C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-29',
            DATE_END => '2004-11-29'
          },
        }
      },
    }
  },

  'US Girls Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2013-14' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-junior-usbc/index.php
        MEET => 'United States Youth Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-31',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2015-16' =>
      {
        MEET => 'United States Youth Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-28',
            DATE_END => '2015-12-30'
          } 
        }
      },
    }
  },

  'US Juniors Training',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2013-14' =>
      {
        MEET => 'United States Youth Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'MATCH',
            DATE_START => '2013-12-29',
            DATE_END => '2013-12-30'
          } 
        }
      },
    }
  },

  'US Junior Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2008B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-17'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-18',
            DATE_END => '2008-07-19'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2009B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-22',
            DATE_END => '2009-07-22'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-22',
            DATE_END => '2009-07-23'
          } 
        }
      },
      '2013-14' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-junior-usbc/index.php
        MEET => 'United States Youth Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-31',
            DATE_END => '2014-01-01'
          },
          'C1' => 
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-01',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2015-16' =>
      {
        MEET => 'United States Youth Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-28',
            DATE_END => '2015-12-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-29',
            DATE_END => '2015-12-31'
          } 
        }
      },
      '2017-18' =>
      {
        # https://www.usbf.org/2017-michael-seamon-junior-usbcs/2017-junior-usbc
        MEET => 'United States Youth Bridge Championship',
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
      '2019-20' =>
      {
        # https://www.usbf.org/2019-michael-seamon-jusbc/2019-michael-seamon-jusbc
        MEET => 'United States Youth Bridge Championship',
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
      '2024-25' =>
      {
        # https://www.usbf.org/2024-sam-amer-jusbc/2024-sam-amer-jusbc/index.php
        MEET => 'United States Youth Bridge Championship',
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
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    # https://www.usbf.org/usbcs-before-2014/past-usbf-tournaments/usbf-tournaments-before-2014/index.php

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1997,
            STAGE => 'Semifinal',
            DATE_START => '1997-06-06',
            DATE_END => '1997-06-07'
          },
          'C1' => 
          {
            YEAR => 1997,
            STAGE => 'Playoff',
            DATE_START => '1997-06-08',
            DATE_END => '1997-06-09'
          } 
        }
      },
      '1998' =>
      {
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1998,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '1998-06-17',
            DATE_END => '1998-06-18'
          },
          'C1' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1998-06-19',
            DATE_END => '1998-06-20'
          } 
        }
      },
      '1999' =>
      {
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1999,
            STAGE => 'Semifinal',
            DATE_START => '1999-06-17',
            DATE_END => '1999-06-17'
          },
          'C1' => 
          {
            YEAR => 1999,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1999-06-18',
            DATE_END => '1999-06-19'
          } 
        }
      },
      '2000' =>
      {
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2000,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2000-06-14',
            DATE_END => '2000-06-15'
          },
          'C1' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-06-16',
            DATE_END => '2000-06-17'
          } 
        }
      },
      '2001' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2001A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-05-19',
            DATE_END => '2001-05-19'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-05-20',
            DATE_END => '2001-05-20'
          } 
        }
      },
      '2002' =>
      {
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2002-05-18',
            DATE_END => '2002-05-18'
          },
          'C1' => 
          {
            YEAR => 2002,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2002-05-19',
            DATE_END => '2002-05-19'
          } 
        }
      },
      '2004' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2004B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-11',
            DATE_END => '2004-06-11'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-12',
            DATE_END => '2004-06-12'
          },
          'C2' => 
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
        # https://www.usbf.org/2005-open-usbc/2005-united-states-bridge-championship
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2005A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2005-05-19',
            DATE_END => '2005-05-19'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-20',
            DATE_END => '2005-05-20'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-21',
            DATE_END => '2005-05-21'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-22',
            DATE_END => '2005-05-22'
          } 
        }
      },
      '2006' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2006-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2006B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2006-08-22',
            DATE_END => '2006-08-22'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2006-08-23',
            DATE_END => '2006-08-23'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-24',
            DATE_END => '2006-08-24'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-08-25',
            DATE_END => '2006-08-25'
          },
          'C4' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-26',
            DATE_END => '2006-08-26'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2007B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2007-06-08',
            DATE_END => '2007-06-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-09',
            DATE_END => '2007-06-09'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-10',
            DATE_END => '2007-06-10'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-11',
            DATE_END => '2007-06-11'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2008A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2008-06-04',
            DATE_END => '2008-06-04'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-05',
            DATE_END => '2008-06-05'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-06',
            DATE_END => '2008-06-06'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-06-07',
            DATE_END => '2008-06-07'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/2009-open-usbc/2009-usbc-daily-bulletin
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2009B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2009-06-06',
            DATE_END => '2009-06-07'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-06-07',
            DATE_END => '2009-06-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-08',
            DATE_END => '2009-06-09'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-10',
            DATE_END => '2009-06-11'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-13'
          },
          # Two teams were selected separately
          'D0' => 
          {
            YEAR => 2009,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2009-06-09',
            DATE_END => '2009-06-09'
          },
          'D1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2009-06-10',
            DATE_END => '2009-06-10'
          },
          'D2' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-06-11',
            DATE_END => '2009-06-11'
          },
          'D3' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-12'
          },
          'D4' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-13',
            DATE_END => '2009-06-14'
          },
          'D5' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-14',
            DATE_END => '2009-06-15'
          },
        }
      },
      '2010' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2010-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-06-20',
            DATE_END => '2010-06-21'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-06-22',
            DATE_END => '2010-06-23'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-06-24',
            DATE_END => '2010-06-25'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-26',
            DATE_END => '2010-06-27'
          } 
        }
      },
      '2011' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2011-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2011A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-05-10',
            DATE_END => '2011-05-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-05-12',
            DATE_END => '2011-05-13'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-15'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-16',
            DATE_END => '2011-05-17'
          } 
        }
      },
      '2012' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2012-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2012A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-04-29',
            DATE_END => '2012-04-30'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-01',
            DATE_END => '2012-05-02'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-03',
            DATE_END => '2012-05-04'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-05',
            DATE_END => '2012-05-06'
          },
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-open-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2013A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-06-03',
            DATE_END => '2013-06-05'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-06-05',
            DATE_END => '2013-06-07'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-08'
          },
          'D0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2013-06-04',
            DATE_END => '2013-06-05'
          },
          'D1' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-06-05',
            DATE_END => '2013-06-06'
          },
          'D2' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-06-06',
            DATE_END => '2013-06-07'
          },
          'D3' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-08'
          },
          'D4' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-06-08',
            DATE_END => '2013-06-09'
          },
          'D5' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-09',
            DATE_END => '2013-06-10'
          },
        }
      },
      '2014' =>
      {
        # https://www.usbf.org/2014-open-usbc/2014-open-usbc
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-05-11',
            DATE_END => '2014-05-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-05-13',
            DATE_END => '2014-05-15'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-05-15',
            DATE_END => '2014-05-17'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-05-17',
            DATE_END => '2014-05-19'
          } 
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2015-open-usbc/2015-open-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2015B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-05-10',
            DATE_END => '2015-05-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-12',
            DATE_END => '2015-05-14'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-14',
            DATE_END => '2015-05-16'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-17'
          },
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-open-usbc/2016-open-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2016A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-05-08',
            DATE_END => '2016-05-10'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-10',
            DATE_END => '2016-05-12'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-12',
            DATE_END => '2016-05-14'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-14',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-open-usbc/2017-open-usbc/2017-open-usbc-results/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2017A',
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
        MEET => 'United States Bridge Championship',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2019A',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2021A',
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
        MEET => 'United States Bridge Championship',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2023A',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2024A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-01',
            DATE_END => '2024-05-08'
          } 
        }
      },
    }
  },

  'US Mixed Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2016B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-01',
            DATE_END => '2016-08-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-02',
            DATE_END => '2016-08-02'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-03',
            DATE_END => '2016-08-03'
          },
        }
      },
    }
  },

  'US Senior Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2004C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Quarterfinal',
            major => 'QUARTER',
            DATE_START => '2004-11-26',
            DATE_END => '2004-11-26'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'QUARTER',
            DATE_START => '2004-11-27',
            DATE_END => '2004-11-27'
          },
          'C2' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'QUARTER',
            DATE_START => '2004-11-28',
            DATE_END => '2004-11-28'
          } 
        }
      },
      '2006' =>
      {
        # https://s3.amazonaws.com/cdn.acbl.org/nabc/2006/03/results/November19.html
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2006C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'QUARTER',
            DATE_START => '2006-11-26',
            DATE_END => '2006-11-26'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2007C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-02',
            DATE_END => '2007-12-02'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-02',
            DATE_END => '2007-12-02'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2008C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-30',
            DATE_END => '2008-11-30'
          },
        }
      },
      '2009' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2009C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-01',
            DATE_END => '2009-12-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-02',
            DATE_END => '2009-12-02'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2010C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-11-28',
            DATE_END => '2010-11-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-29',
            DATE_END => '2010-11-29'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-30',
            DATE_END => '2010-12-01'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-01',
            DATE_END => '2010-12-01'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2011C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-11-28',
            DATE_END => '2011-11-29'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-11-29',
            DATE_END => '2011-11-30'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2012C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-11-26',
            DATE_END => '2012-11-27'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-11-27',
            DATE_END => '2012-11-28'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-28',
            DATE_END => '2012-11-29'
          },
        }
      },
      '2013' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2013C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-11-30',
            DATE_END => '2013-12-01'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-01',
            DATE_END => '2013-12-02'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-02',
            DATE_END => '2013-12-03'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-03',
            DATE_END => '2013-12-04'
          },
        }
      },
      '2014' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2014C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-30',
            DATE_END => '2014-12-01'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-01',
            DATE_END => '2014-12-02'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-02',
            DATE_END => '2014-12-03'
          },
        }
      },
      '2015' =>
      {
        MEET => 'North American Bridge Championship',
        MEET_TAG => '2015C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-11-28',
            DATE_END => '2015-11-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-29',
            DATE_END => '2015-11-30'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-30',
            DATE_END => '2015-12-01'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-01',
            DATE_END => '2015-12-02'
          },
        }
      },
    }
  },

  'US Senior Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2004C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'QUARTER',
            DATE_START => '2004-06-24',
            DATE_END => '2004-06-24'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'QUARTER',
            DATE_START => '2004-06-25',
            DATE_END => '2004-06-25'
          } 
        }
      },
      '2005' =>
      {
        # https://www.usbf.org/2005-senior-usbc/2005-united-states-senior-bridge-championship
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2005C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            DATE_START => '2005-07-04',
            DATE_END => '2005-07-05'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            DATE_START => '2005-07-06',
            DATE_END => '2005-07-07'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-senior-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2007B',
        CHAPTERS =>
        {
          'C0' => 
          {
            # USA1
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-06',
            DATE_END => '2007-06-07'
          },
          'C1' => 
          {
            # USA2
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-08',
            DATE_END => '2007-06-09'
          },
          'C2' => 
          {
            # USA1
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-08',
            DATE_END => '2007-06-09'
          },
          'C3' => 
          {
            # USA2
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-10',
            DATE_END => '2007-06-11'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2008C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2009-senior-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2009C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-06',
            DATE_END => '2009-07-06'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-07',
            DATE_END => '2009-07-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-10'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-10'
          } 
        }
      },
      '2011' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2011-senior-usbc/index.php
        # https://usbf.org/2011-senior-usbc/2011-susbc-daily-bulletin
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2011B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-05',
            DATE_END => '2011-06-06'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-06',
            DATE_END => '2011-06-07'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-09'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-11'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-11'
          } 
        }
      },
      '2012' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2012-senior-usbc/index.php
        # https://usbf.org/2012-senior-usbc/2012-susbc-daily-bulletin
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-02'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-04'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-04',
            DATE_END => '2012-06-05'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-05',
            DATE_END => '2012-06-07'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-senior-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-13',
            DATE_END => '2013-07-15'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-15',
            DATE_END => '2013-07-16'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-16',
            DATE_END => '2013-07-17'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-07-16',
            DATE_END => '2013-07-16'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-16',
            DATE_END => '2013-07-18'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-18',
            DATE_END => '2013-07-19'
          },
          'C6' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-19',
            DATE_END => '2013-07-20'
          },
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2024-united-states-bridge-championships/2024-united-states-bridge-championships/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2015C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-07',
            DATE_END => '2015-06-08'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-08',
            DATE_END => '2015-06-09'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-09',
            DATE_END => '2015-06-10'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-10',
            DATE_END => '2015-06-11'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-11',
            DATE_END => '2015-06-12'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-12',
            DATE_END => '2015-06-13'
          },
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-senior-usbc/2016-senior-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2016C',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-06-17',
            DATE_END => '2016-06-18'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-19',
            DATE_END => '2016-06-20'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-20',
            DATE_END => '2016-06-21'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-21',
            DATE_END => '2016-06-22'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-senior-usbc/2017-senior-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2017C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-15',
            DATE_END => '2017-05-17'
          } 
        }
      },
      '2019' =>
      {
        # https://www.usbf.org/2019-senior-usbc/2019-senior-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2019B',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2021B',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2023B',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2024B',
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
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          } 
        }
      },
    }
  },

  'US Women Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2001' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2001B',
        CHAPTERS =>
        {
          'C0' => 
          {
            # Estimated.
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-06-16',
            DATE_END => '2001-06-17'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-06-18',
            DATE_END => '2001-06-19'
          } 
        }
      },
      '2004' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2004A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-05-31',
            DATE_END => '2004-05-31'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-01',
            DATE_END => '2004-06-02'
          } 
        }
      },
      '2005' =>
      {
        # https://www.usbf.org/2005-women-s-usbc/2005-united-states-womens-bridge-championship
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2005B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            DATE_START => '2005-06-06',
            DATE_END => '2005-06-09'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-10',
            DATE_END => '2005-06-11'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-12',
            DATE_END => '2005-06-13'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2005-06-12',
            DATE_END => '2005-06-13'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2006A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-06-12',
            DATE_END => '2006-06-12'
          } 
        }
      },
      '2007' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2007-women-s-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2007A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-01',
            DATE_END => '2007-06-04'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-06',
            DATE_END => '2007-06-07'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2007-06-06',
            DATE_END => '2007-06-07'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2008A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          } 
        }
      },
      '2009' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2009-women-s-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2009A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-25',
            DATE_END => '2009-05-25'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-26',
            DATE_END => '2009-05-29'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2009-05-26',
            DATE_END => '2009-05-29'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2011B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-11'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-03',
            DATE_END => '2012-06-04'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-05',
            DATE_END => '2012-06-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-women-s-usbc/index.php
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-14',
            DATE_END => '2013-07-14'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-15',
            DATE_END => '2013-07-16'
          },
          'D0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-15',
            DATE_END => '2013-07-16'
          },
          'D1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-17',
            DATE_END => '2013-07-18'
          } 
        }
      },
      '2015' =>
      {
        # https://www.usbf.org/2015-women-s-usbc/2015-women-s-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2015A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-14',
            DATE_END => '2015-04-15'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-15',
            DATE_END => '2015-04-17'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-17',
            DATE_END => '2015-04-18'
          } 
        }
      },
      '2016' =>
      {
        # https://www.usbf.org/2016-women-s-usbc/2016-women-s-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2016B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-30',
            DATE_END => '2016-06-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-01',
            DATE_END => '2016-06-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-05'
          } 
        }
      },
      '2017' =>
      {
        # https://www.usbf.org/2017-women-s-usbc/2017-women-s-usbc
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2017B',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2019A',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2023B',
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
        MEET => 'United States Bridge Championship',
        MEET_TAG => '2024B',
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
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2010' =>
      {
        # https://www.usbf.org/2010-junior-usbc/2010-under-21-trials
        MEET => 'United States Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-06-26',
            DATE_END => '2010-06-27'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-27',
            DATE_END => '2010-06-27'
          } 
        }
      },
      '2013-14' =>
      {
        # https://www.usbf.org/usbcs-before-2014/usbf-tournaments-before-2014/2013-junior-usbc/index.php
        MEET => 'United States Youth Bridge Championship',
        MEET_TAG => '2013-14',
        CHAPTERS =>
        {
          # Actually there are two of each.
          'C0' => 
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-31',
            DATE_END => '2014-01-02'
          },
          'C1' => 
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-01',
            DATE_END => '2014-01-02'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'United States Youth Bridge Championship',
        MEET_TAG => '2015-16',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-12-27',
            DATE_END => '2015-12-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-29',
            DATE_END => '2015-12-30'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-12-30',
            DATE_END => '2015-12-31'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-30',
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
            major => 'MATCH',
            DATE_START => '2016-01-31',
            DATE_END => '2016-01-31'
          } 
        }
      },
    }
  },

  'Vanderbilt Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            DATE_START => '1997-03-14',
            DATE_END => '1997-03-14'
          } 
        }
      },
      '1998A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1998-03-27',
            DATE_END => '1998-03-28'
          } 
        }
      },
      '1999A' =>
      {
        MEET => 'North American Bridge Championship',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1999,
            STAGE => 'Final',
            DATE_START => '1999-03-28',
            DATE_END => '1999-03-28'
          } 
        }
      },
      '2000A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-03-24',
            DATE_END => '2000-03-25'
          } 
        }
      },
      '2001A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-03-23',
            DATE_END => '2001-03-24'
          } 
        }
      },
      '2002A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2002-03-14',
            DATE_END => '2002-03-15'
          },
          'C1' => 
          {
            YEAR => 2002,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2002-03-16',
            DATE_END => '2002-03-17'
          } 
        }
      },
      '2004A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-03-25',
            DATE_END => '2004-03-26'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-03-27',
            DATE_END => '2004-03-27'
          } 
        }
      },
      '2005A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            minor => 'MATCH',
            DATE_START => '2005-03-18',
            DATE_END => '2005-03-18'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT|QUARTER',
            ignore => 'MATCH',
            DATE_START => '2005-03-18',
            DATE_END => '2005-03-19'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-03-20',
            DATE_END => '2005-03-20'
          },
        }
      },
      '2006A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C9' => 
          {
            YEAR => 2006,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2006-04-03',
            DATE_END => '2006-04-03'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-04-06',
            DATE_END => '2006-04-06'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-04-08',
            DATE_END => '2006-04-08'
          } 
        }
      },
      '2007A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2007-03-10',
            DATE_END => '2007-03-10'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-03-11',
            DATE_END => '2007-03-12'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-03-13',
            DATE_END => '2007-03-14'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-15',
            DATE_END => '2007-03-16'
          },
        }
      },
      '2008A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2008-03-10',
            DATE_END => '2008-03-11'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-03-11',
            DATE_END => '2008-03-12'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-03-13',
            DATE_END => '2008-03-14'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-03-15',
            DATE_END => '2008-03-16'
          },
        }
      },
      '2009A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2009-03-17',
            DATE_END => '2009-03-18'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-03-18',
            DATE_END => '2009-03-19'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-19',
            DATE_END => '2009-03-20'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-20',
            DATE_END => '2009-03-21'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-21',
            DATE_END => '2009-03-21'
          },
        }
      },
      '2010A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2010-03-16',
            DATE_END => '2010-03-17'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2010-03-17',
            DATE_END => '2010-03-18'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-03-18',
            DATE_END => '2010-03-19'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-03-19',
            DATE_END => '2010-03-20'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-03-20',
            DATE_END => '2010-03-21'
          },
          'C5' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-03-21',
            DATE_END => '2010-03-22'
          },
        }
      },
      '2011A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2011-03-16',
            DATE_END => '2011-03-17'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-03-17',
            DATE_END => '2011-03-18'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-18',
            DATE_END => '2011-03-19'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-19',
            DATE_END => '2011-03-20'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-20',
            DATE_END => '2011-03-20'
          },
        }
      },
      '2012A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2012-03-21',
            DATE_END => '2012-03-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-03-22',
            DATE_END => '2012-03-23'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-23',
            DATE_END => '2012-03-24'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-25'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-25',
            DATE_END => '2012-03-25'
          },
        }
      },
      '2013A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-03-20',
            DATE_END => '2013-03-21'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-03-21',
            DATE_END => '2013-03-22'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-22',
            DATE_END => '2013-03-23'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-24'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-25'
          },
        }
      },
      '2014A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-03-26',
            DATE_END => '2014-03-27'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-03-27',
            DATE_END => '2014-03-28'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-28',
            DATE_END => '2014-03-29'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-29',
            DATE_END => '2014-03-30'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-30',
            DATE_END => '2014-03-31'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-03-19',
            DATE_END => '2015-03-20'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-20',
            DATE_END => '2015-03-21'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-21',
            DATE_END => '2015-03-22'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-22',
            DATE_END => '2015-03-23'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2016-03-15',
            DATE_END => '2016-03-16'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2016-03-16',
            DATE_END => '2016-03-17'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-03-17',
            DATE_END => '2016-03-18'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-18',
            DATE_END => '2016-03-19'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-19',
            DATE_END => '2016-03-20'
          },
          'C5' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-20',
            DATE_END => '2016-03-21'
          } 
        }
      },
    }
  },

  'Wagar Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '1998B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1998-07-30',
            DATE_END => '1998-07-31'
          } 
        }
      },
      '2004B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-07-29',
            DATE_END => '2004-07-29'
          } 
        }
      },
      '2005B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-07-29',
            DATE_END => '2005-07-30'
          } 
        }
      },
      '2006B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT|QUARTER',
            DATE_START => '2006-07-23',
            DATE_END => '2006-07-23'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-07-27',
            DATE_END => '2007-07-27'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-30',
            DATE_END => '2009-07-30'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-07-29',
            DATE_END => '2010-07-30'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-29'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT|QUARTER',
            DATE_START => '2012-07-18',
            DATE_END => '2012-07-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-19',
            DATE_END => '2012-07-20'
          },
        }
      },
      '2013B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-07',
            DATE_END => '2013-08-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-08',
            DATE_END => '2013-08-09'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-23',
            DATE_END => '2014-07-24'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-24',
            DATE_END => '2014-07-25'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-11',
            DATE_END => '2015-08-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-12',
            DATE_END => '2015-08-13'
          } 
        }
      },
      '2016B' =>
      {
        MEET => 'North American Bridge Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-27',
            DATE_END => '2016-07-28'
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
