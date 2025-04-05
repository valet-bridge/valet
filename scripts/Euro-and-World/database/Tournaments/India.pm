#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::India;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Surely there is more structure here that I haven't found.
# https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bw&pid=display_page18

my %GLOBAL = (
  ORGANIZATION => 'BFI',
  COUNTRY => 'India',
  ZONE => 'Asia Pacific',
);

my %MEETS_INDIA =
(
  'All India HCL Tournament' =>
  {
    # Was called "All India" up to 2009, then
    # "HCL International".

    %GLOBAL,
    SPONSOR => 'HCL',
    ORIGIN => 'Transnational',

    EDITIONS => 
    {
      '2003' =>
      {
        # https://hcl-bridge.com/archive/2003-2/
        MEET_ORDINAL => 1,
        CITY => 'Delhi',
        YEAR => 2003,
        DATE_START => '2003-12-18',
        DATE_END => '2003-12-21'
      },
      '2004' =>
      {
        # https://hcl-bridge.com/archive/2004-2/
        MEET_ORDINAL => 2,
        CITY => 'Delhi',
        YEAR => 2004,
        DATE_START => '2004-08-12',
        DATE_END => '2004-08-15'
      },
      '2005' =>
      {
        # https://hcl-bridge.com/archive/2005-2/
        MEET_ORDINAL => 3,
        CITY => 'Noida',
        YEAR => 2005,
        DATE_START => '2005-08-12',
        DATE_END => '2005-08-15'
      },
      '2006' =>
      {
        # https://hcl-bridge.com/archive/2006-2/
        MEET_ORDINAL => 4,
        CITY => 'Noida',
        YEAR => 2006,
        DATE_START => '2006-08-12',
        DATE_END => '2006-08-15'
      },
      '2007' =>
      {
        # https://hcl-bridge.com/archive/2007-2/
        MEET_ORDINAL => 5,
        CITY => 'Noida',
        YEAR => 2007,
        DATE_START => '2007-08-16',
        DATE_END => '2007-08-19'
      },
      '2008' =>
      {
        # https://hcl-bridge.com/archive/2008-2/
        MEET_ORDINAL => 6,
        CITY => 'Noida',
        YEAR => 2008,
        DATE_START => '2008-09-04',
        DATE_END => '2008-09-07'
      },
      '2009' =>
      {
        # https://hcl-bridge.com/archive/2009-2/
        MEET_ORDINAL => 7,
        CITY => 'Noida',
        YEAR => 2009,
        DATE_START => '2009-08-13',
        DATE_END => '2009-08-16'
      },
      '2010' =>
      {
        # https://hcl-bridge.com/archive/2010-2/
        MEET_ORDINAL => 8,
        CITY => 'Noida',
        YEAR => 2010,
        DATE_START => '2010-10-30',
        DATE_END => '2010-11-02'
      },
      '2011' =>
      {
        # https://hcl-bridge.com/archive/2011-2/
        MEET_ORDINAL => 9,
        CITY => 'Noida',
        YEAR => 2011,
        DATE_START => '2011-09-08',
        DATE_END => '2011-09-11'
      },
      '2012' =>
      {
        # https://hcl-bridge.com/archive/2012-2/
        MEET_ORDINAL => 10,
        CITY => 'Delhi',
        YEAR => 2012,
        DATE_START => '2012-08-30',
        DATE_END => '2012-09-02'
      },
      '2013' =>
      {
        # https://hcl-bridge.com/archive/2013-2/
        MEET_ORDINAL => 11,
        CITY => 'Delhi',
        YEAR => 2013,
        DATE_START => '2013-08-08',
        DATE_END => '2013-08-11'
      },
      '2014' =>
      {
        # https://hcl-bridge.com/archive/2014-2/
        MEET_ORDINAL => 12,
        CITY => 'Delhi',
        YEAR => 2014,
        DATE_START => '2014-08-17',
        DATE_END => '2014-08-20'
      },
      '2015' =>
      {
        # https://hcl-bridge.com/archive/2015-2/
        MEET_ORDINAL => 13,
        CITY => 'Delhi',
        YEAR => 2015,
        DATE_START => '2015-08-20',
        DATE_END => '2015-08-23'
      },
      '2016' =>
      {
        # https://hcl-bridge.com/archive/2016-2/
        MEET_ORDINAL => 14,
        CITY => 'Delhi',
        YEAR => 2016,
        DATE_START => '2016-10-19',
        DATE_END => '2016-10-23'
      },
      '2017' =>
      {
        # https://hcl-bridge.com/archive/2017-2/
        MEET_ORDINAL => 15,
        CITY => 'Delhi',
        YEAR => 2017,
        DATE_START => '2017-09-12',
        DATE_END => '2017-09-17'
      },
      '2018' =>
      {
        # https://hcl-bridge.com/archive/2018-2/
        MEET_ORDINAL => 16,
        CITY => 'Delhi',
        YEAR => 2018,
        DATE_START => '2018-08-09',
        DATE_END => '2018-08-14'
      },
      '2019' =>
      {
        # https://hcl-bridge.com/archive/2019-2/
        MEET_ORDINAL => 17,
        CITY => 'Delhi',
        YEAR => 2019,
        DATE_START => '2019-08-05',
        DATE_END => '2019-08-10'
      },
      '2021' =>
      {
        # https://hcl-bridge.com/archive/2021-2/
        MEET_ORDINAL => 18,
        CITY => 'Online',
        YEAR => 2021,
        DATE_START => '2021-09-18',
        DATE_END => '2021-09-26'
      },
      '2022' =>
      {
        # https://hcl-bridge.com/archive/2022-2/
        MEET_ORDINAL => 19,
        CITY => 'Gurgaon',
        YEAR => 2022,
        DATE_START => '2022-10-11',
        DATE_END => '2022-10-16'
      },
      '2023' =>
      {
        # https://hcl-bridge.com/archive/2023-2/
        MEET_ORDINAL => 20,
        CITY => 'Delhi',
        YEAR => 2023,
        DATE_START => '2023-10-31',
        DATE_END => '2023-11-06'
      },
      '2024' =>
      {
        MEET_ORDINAL => 21,
        CITY => 'Delhi',
        YEAR => 2024,
        DATE_START => '2024-09-14',
        DATE_END => '2024-09-22'
      },
    }
  },

  'Goa Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',

    EDITIONS => 
    {
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Panaji',
        DATE_START => '2013-07-18',
        DATE_END => '2013-07-21'
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Panaji',
        DATE_START => '2015-07-23',
        DATE_END => '2015-07-26'
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Panaji',
        DATE_START => '2016-07-30',
        DATE_END => '2016-07-31'
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Panaji',
        DATE_START => '2017-07-21',
        DATE_END => '2017-07-24'
      },
      '2018' =>
      {
        YEAR => 2018,
        CITY => 'Panaji',
        DATE_START => '2018-07-21',
        DATE_END => '2018-07-22'
      },
      '2019' =>
      {
        YEAR => 2019,
        CITY => 'Panaji',
        DATE_START => '2019-07-20',
        DATE_END => '2019-07-21'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-07-17',
        DATE_END => '2020-07-19'
      },
      '2024' =>
      {
        # Probably not a good permanent link
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=goaswisspairs&pid=display_past
        YEAR => 2024,
        CITY => 'Panjim',
        DATE_START => '2024-07-19',
        DATE_END => '2024-07-21'
      },
    }
  },

  'Indian South Zone Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',

    EDITIONS => 
    {
      '2014' =>
      {
        MEET_ORDINAL => 52,
        REGION => 'Goa',
        YEAR => 2014,
        DATE_START => '2014-07-20', # More dates
        DATE_END => '2014-07-21'
      },
      '2015' =>
      {
        MEET_ORDINAL => 53,
        YEAR => 2015,
        DATE_START => '2015-12-19', # Might be something else
        DATE_END => '2015-12-21'
      },
      '2016' =>
      {
        MEET_ORDINAL => 54,
        SPONSOR => 'Krishnapatnam Port',
        YEAR => 2016,
        DATE_START => '2016-08-13', # More dates
        DATE_END => '2016-08-14'
      },
    }
  },

  'Indian Summer Nationals' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2010' =>
      {
        MEET_ORDINAL => 41,
        YEAR => 2010,
        DATE_START => '2010-06-18', # More dates
        DATE_END => '2010-06-20'
      },
      '2011' =>
      {
        MEET_ORDINAL => 1,
        CITY => 'Nashik',
        YEAR => 2011,
        DATE_START => '2011-03-14',
        DATE_END => '2011-03-16'
      },
      '2012' =>
      {
        MEET_ORDINAL => 2,
        REGION => 'Goa',
        YEAR => 2012,
        DATE_START => '2012-06-19',
        DATE_END => '2012-06-21'
      },
      '2013' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2013,
        CITY => 'Pune',
        DATE_START => '2013-02-18', # More dates
        DATE_END => '2013-02-20'
      },
      '2014' =>
      {
        MEET_ORDINAL => 4,
        CITY => 'Nashik',
        YEAR => 2014,
        DATE_START => '2014-04-21',
        DATE_END => '2014-04-23'
      },
      '2015' =>
      {
        MEET_ORDINAL => 5,
        CITY => 'Bangalore',
        YEAR => 2015,
        DATE_START => '2015-06-17',
        DATE_END => '2015-06-21'
      },
      '2016' =>
      {
        MEET_ORDINAL => 6,
        CITY => 'Bangalore',
        YEAR => 2016,
        DATE_START => '2016-07-06',
        DATE_END => '2016-07-10'
      },
      '2017' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page11
        MEET_ORDINAL => 7,
        CITY => 'Nashik',
        YEAR => 2017,
        DATE_START => '2017-06-17',
        DATE_END => '2017-06-21'
      },
      '2018' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page15
        MEET_ORDINAL => 8,
        CITY => 'Ahmedabad',
        YEAR => 2018,
        DATE_START => '2018-06-24',
        DATE_END => '2018-06-28'
      },
      '2019' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page1
        MEET_ORDINAL => 9,
        CITY => 'Pune',
        YEAR => 2019,
        DATE_START => '2019-06-01',
        DATE_END => '2019-06-05'
      },
      '2021' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page30
        MEET_ORDINAL => 10,
        YEAR => 2021,
        DATE_START => '2021-06-19',
        DATE_END => '2021-06-27'
      },
      '2022' =>
      {
        # https://bfi.net.in/tournament/11-tolani-summer-national-bridge-championship-2022/
        MEET_ORDINAL => 11,
        CITY => 'Bangalore',
        YEAR => 2022,
        DATE_START => '2022-06-28',
        DATE_END => '2022-07-07'
      },
      '2023' =>
      {
        # From here on not Tolani, but Mavericks
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page38
        MEET_ORDINAL => 1,
        CITY => 'Goa',
        YEAR => 2023,
        DATE_START => '2023-06-20',
        DATE_END => '2023-06-28'
      },
      '2024' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page46
        MEET_ORDINAL => 2,
        CITY => 'Mangalore',
        YEAR => 2024,
        DATE_START => '2024-06-05',
        DATE_END => '2024-06-14'
      },
    }
  },

  'Indian Winter Nationals' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page4
    # 2005 Chennai
    # 2006 Bhopal
    # 2007 Bharuch
    # 2008 Kanpur
    # 2009 Bangalore
    # 2010 Kolkata
    # 2011 Chennai
    # 2013 Ahmedabad
    # 2014 Jaipur
    # 2015 Pune

    EDITIONS => 
    {
      '2004' =>
      {
        MEET_ORDINAL => 46,
        CITY => 'Visakhapatnam',
        YEAR => 2004,
        DATE_START => '2004-12-07',
        DATE_END => '2004-12-17'
      },
      '2005-06' =>
      {
        MEET_ORDINAL => 47,
        CITY => 'Chennai',
        DATE_START => '2005-12-27',
        DATE_END => '2006-01-05'
      },
      '2007' =>
      {
        MEET_ORDINAL => 49,
        CITY => 'Bharuch',
        YEAR => 2007,
        DATE_START => '2007-12-22', # More dates
        DATE_END => '2007-12-22'
      },
      '2008' =>
      {
        MEET_ORDINAL => 50,
        CITY => 'Kanpur',
        DATE_START => '2008-11-12',
        DATE_END => '2008-11-23'
      },
      '2009' =>
      {
        MEET_ORDINAL => 51,
        DATE_START => '2009-12-18',
        DATE_END => '2009-12-24'
      },
      '2010' =>
      {
        MEET_ORDINAL => 52,
        CITY => 'Kolkata',
        YEAR => 2010,
        DATE_START => '2010-12-12', # More dates
        DATE_END => '2010-12-17'
      },
      '2011' =>
      {
        MEET_ORDINAL => 53,
        CITY => 'Chennai',
        YEAR => 2011,
        DATE_START => '2011-12-06', # More dates
        DATE_END => '2011-12-10'
      },
      '2012' =>
      {
        MEET_ORDINAL => 54,
        YEAR => 2012,
        CITY => 'Kolkata',
        DATE_START => '2012-12-16',
        DATE_END => '2012-12-22'
      },
      '2013' =>
      {
        MEET_ORDINAL => 55,
        CITY => 'Ahmedabad',
        YEAR => 2013,
        DATE_START => '2013-12-20',
        DATE_END => '2013-12-23'
      },
      '2014' =>
      {
        MEET_ORDINAL => 56,
        CITY => 'Jaipur',
        YEAR => 2014,
        DATE_START => '2014-12-18', # More dates
        DATE_END => '2014-12-21'
      },
      '2015' =>
      {
        MEET_ORDINAL => 57,
        CITY => 'Pune',
        YEAR => 2015,
        DATE_START => '2015-11-20', # More dates
        DATE_END => '2015-11-22'
      },
      '2016' =>
      {
        # No explicit results links for whole Nationals, but
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=docs_Full%20Brochure.pdf
        MEET_ORDINAL => 58,
        YEAR => 2016,
        CITY => 'Jaipur',
        DATE_START => '2016-12-12',
        DATE_END => '2016-12-18'
      },
      '2017' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page14
        MEET_ORDINAL => 59,
        YEAR => 2017,
        CITY => 'Vishakhapatanam',
        DATE_START => '2017-12-16',
        DATE_END => '2017-12-22'
      },
      '2018' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page25
        MEET_ORDINAL => 60,
        YEAR => 2018,
        CITY => 'Chennai',
        DATE_START => '2018-12-09',
        DATE_END => '2018-12-17'
      },
      '2019' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page30
        MEET_ORDINAL => 61,
        YEAR => 2019,
        CITY => 'Kolkata',
        DATE_START => '2019-12-08',
        DATE_END => '2019-12-15'
      },
      '2022' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page13
        MEET_ORDINAL => 64,
        YEAR => 2022,
        CITY => 'Jaipur',
        DATE_START => '2022-12-03',
        DATE_END => '2022-12-12'
      },
      '2024A' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page59
        MEET_ORDINAL => 65,
        YEAR => 2024,
        CITY => 'Jabalpur',
        DATE_START => '2024-01-03',
        DATE_END => '2024-01-09'
      },
      '2024B' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page60
        MEET_ORDINAL => 66,
        YEAR => 2024,
        CITY => 'Pune',
        DATE_START => '2024-12-08',
        DATE_END => '2024-12-18'
      },
    }
  },

  'Maharaja Holkar National Championship'  =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-01-07',
        DATE_END => '2010-01-10'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-01-04',
        DATE_END => '2011-01-09'
      },
      '2012' =>
      {
        MEET_ORDINAL => 9,
        YEAR => 2012,
        CITY => 'Indore',
        DATE_START => '2012-01-05',
        DATE_END => '2012-01-08'
      },
      '2013' =>
      {
        MEET_ORDINAL => 10,
        YEAR => 2013,
        CITY => 'Indore',
        DATE_START => '2013-01-10',
        DATE_END => '2013-01-13'
      },
      '2014' =>
      {
        MEET_ORDINAL => 11,
        YEAR => 2014,
        CITY => 'Indore',
        DATE_START => '2014-01-04',
        DATE_END => '2014-01-06'
      },
      '2015' =>
      {
        MEET_ORDINAL => 12,
        YEAR => 2015,
        DATE_START => '2015-01-09',
        DATE_END => '2015-01-11'
      },
      '2016' =>
      {
        MEET_ORDINAL => 13,
        YEAR => 2016,
        CITY => 'Indore',
        DATE_START => '2016-01-08',
        DATE_END => '2016-01-10'
      },
      '2017' =>
      {
        MEET_ORDINAL => 14,
        YEAR => 2017,
        DATE_START => '2017-01-06',
        DATE_END => '2017-01-08'
      },
      '2018' =>
      {
        MEET_ORDINAL => 15,
        YEAR => 2018,
        DATE_START => '2018-01-12',
        DATE_END => '2018-01-14'
      },
      '2019' =>
      {
        MEET_ORDINAL => 16,
        YEAR => 2019,
        DATE_START => '2019-01-11',
        DATE_END => '2019-01-13'
      },
      '2020' =>
      {
        MEET_ORDINAL => 17,
        YEAR => 2020,
        DATE_START => '2020-01-05',
        DATE_END => '2020-01-07'
      },
      '2023A' =>
      {
        MEET_ORDINAL => 18,
        YEAR => 2023,
        CITY => 'Indore',
        DATE_START => '2023-01-15',
        DATE_END => '2023-01-20'
      },
      '2023B' =>
      {
        MEET_ORDINAL => 19,
        YEAR => 2023,
        CITY => 'Indore',
        DATE_START => '2023-12-16',
        DATE_END => '2023-12-19'
      },
      '2025' =>
      {
        MEET_ORDINAL => 20,
        YEAR => 2025,
        CITY => 'Indore',
        DATE_START => '2025-01-07',
        DATE_END => '2025-01-10'
      }
    }
  },

  'Maharashtra State Championship'  =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',

    EDITIONS => 
    {
      '2012A' =>
      {
        MEET_ORDINAL => 32,
        YEAR => 2012,
        DATE_START => '2012-02-25',
        DATE_END => '2012-02-28'
      },
      '2012B' =>
      {
        MEET_ORDINAL => 33,
        YEAR => 2012,
        DATE_START => '2012-10-27',
        DATE_END => '2012-10-28'
      },
      '2014' =>
      {
        MEET_ORDINAL => 34,
        CITY => 'Dombivli',
        YEAR => 2014,
        DATE_START => '2014-01-18',
        DATE_END => '2014-01-20'
      },
      '2015' =>
      {
        MEET_ORDINAL => 35,
        CITY => 'Nashik',
        YEAR => 2015,
        DATE_START => '2015-05-02',
        DATE_END => '2015-05-02'
      },
      '2016' =>
      {
        CITY => 'Pune',
        YEAR => 2016,
        DATE_START => '2016-06-25',
        DATE_END => '2016-06-25'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-02-17',
        DATE_END => '2017-02-18'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-04-14',
        DATE_END => '2023-04-16'
      },
    }
  },

  'Rajasthan Invitational Championship'  =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',

    EDITIONS => 
    {
      '2013' =>
      {
        CITY => 'Pushkar',
        YEAR => 2013,
        DATE_START => '2013-05-03',
        DATE_END => '2013-05-05'
      },
      '2014' =>
      {
        MEET_ORDINAL => 30,
        CITY => 'Kota',
        YEAR => 2014,
        DATE_START => '2014-03-07',
        DATE_END => '2014-03-09'
      },
    }
  },

  'Uttar Pradesh State Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    REGION => 'Uttar Pradesh',

    EDITIONS => 
    {
      '2012' =>
      {
        MEET_ORDINAL => 42,
        YEAR => 2012,
        CITY => 'Noida',
        CLUB => 'AVI Club Noida',
        DATE_START => '2012-08-17',
        DATE_END => '2012-08-19'
      },
    }
  },

  'West Bengal State Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-11-12',
        DATE_END => '2022-11-13'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-11-18',
        DATE_END => '2023-11-19'
      },
      '2024A' =>
      {
        YEAR => 2024,
        DATE_START => '2024-07-21',
        DATE_END => '2024-07-21'
      },
      '2024B' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2024,
        DATE_START => '2024-11-09',
        DATE_END => '2024-11-10'
      },
    }
  },

  'West Indian Regional' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',

    EDITIONS => 
    {
      '2011' =>
      {
        YEAR => 2011,
        CITY => 'Mumbai',
        DATE_START => '2011-01-17',
        DATE_END => '2011-01-17'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-01-15',
        DATE_END => '2012-01-16'
      },
    }
  },

);

my %TOURNAMENTS_INDIA =
(
  "Ahmedabad President's Cup" =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
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

  'All India Bangur Cement Hindusthan Club' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        ORDINAL => 6,
        SPONSOR => 'Bangur Cement',
        CITY => 'Kolkata',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-27',
            DATE_END => '2012-07-28'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-29',
            DATE_END => '2012-07-29'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-27',
            DATE_END => '2013-07-27'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-28',
            DATE_END => '2013-07-28'
          } 
        }
      },
      '2015' =>
      {
        # Probably 'Goa Bridge Festival', but collides with
        # Shree Keni Trophy?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-24',
            DATE_END => '2015-07-25'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-26',
            DATE_END => '2015-07-26'
          } 
        }
      },
    }
  },

  'All India Corporate Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-09-16',
            DATE_END => '2012-09-16'
          } 
        }
      },
      '2013' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-28'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 5,
        CITY => 'Mumbai',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-08-27',
            DATE_END => '2016-08-27'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-08-05',
            DATE_END => '2017-08-05'
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
            DATE_START => '2018-08-04',
            DATE_END => '2018-08-04'
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
            DATE_START => '2019-08-24',
            DATE_END => '2019-08-24'
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
            DATE_START => '2022-08-13',
            DATE_END => '2022-08-13'
          },
        }
      },
    }
  },

  'All India HCL Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Barometer',
            major => 'SESSION',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-11'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-08-11',
            DATE_END => '2013-08-11'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-10-23',
            DATE_END => '2016-10-23'
          } 
        }
      },
    }
  },

  'All India HCL Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2004-08-15',
            DATE_END => '2004-08-15'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-08-19',
            DATE_END => '2007-08-19'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-08-19',
            DATE_END => '2007-08-19'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-07',
            DATE_END => '2008-09-07'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-07',
            DATE_END => '2008-09-07'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-07',
            DATE_END => '2008-09-07'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-14',
            DATE_END => '2009-08-14'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-15',
            DATE_END => '2009-08-15'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-16',
            DATE_END => '2009-08-16'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-10-31',
            DATE_END => '2010-11-01'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-01',
            DATE_END => '2010-11-01'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-02',
            DATE_END => '2010-11-02'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-10',
            DATE_END => '2011-09-10'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-11'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2012-08-31',
            DATE_END => '2012-08-31'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-01'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-01'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-10',
            DATE_END => '2013-08-10'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-11',
            DATE_END => '2013-08-11'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-18',
            DATE_END => '2014-08-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-19',
            DATE_END => '2014-08-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-08-20',
            DATE_END => '2015-08-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-21'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-22'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-22'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-23'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-19',
            DATE_END => '2016-10-23'
          },
        }
      },
      '2017' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-12',
            DATE_END => '2017-09-17'
          },
        }
      },
      '2023' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-31',
            DATE_END => '2023-11-04'
          },
        }
      },
    }
  },

  'All India Open Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    # Bit of a synthetic tournament
    EDITIONS =>
    {
      '2013A' =>
      {
        MEET => 'Indian Summer Nationals',
        MEET_TAG => '2013',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-02-20',
            DATE_END => '2013-02-20'
          } 
        }
      },
      '2013B' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2013',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-12-23',
            DATE_END => '2013-12-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian Winter Nationals',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-12-21',
            DATE_END => '2014-12-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indian Summer Nationals',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-06-21',
            DATE_END => '2015-06-21'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Indian Summer Nationals',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-06-21',
            DATE_END => '2017-06-21'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Indian Summer Nationals',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-06-28',
            DATE_END => '2023-06-28'
          } 
        }
      },
    }
  },

  'All India Shree Cement' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CITY => 'Kolkata',
        CLUB => 'Jaipur Club',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-15',
            DATE_END => '2011-10-16'
          },
          'C1' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-11-11',
            DATE_END => '2011-11-12'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-12'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-12'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-11-13',
            DATE_END => '2011-11-13'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-21',
            DATE_END => '2018-04-22'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-19',
            DATE_END => '2019-04-21'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-05-14',
            DATE_END => '2022-05-15'
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
            DATE_START => '2023-05-26',
            DATE_END => '2023-05-28'
          },
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-04-12',
            DATE_END => '2024-04-14'
          },
        }
      },
    }
  },

  'All India UTI Bank Masters Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-11',
            DATE_END => '2007-04-11'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-11',
            DATE_END => '2007-04-11'
          } 
        }
      },
    }
  },

  'Amla Ruia Women Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-09',
            DATE_END => '2024-12-09'
          },
        }
      },
    }
  },

  'Anoop Dhawan Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2017-03-19',
            DATE_END => '2017-03-19'
          },
        }
      },
    }
  },

  'Ashok Kapur Memorial Swiss Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        ORDINAL => 1,
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-11-24',
            DATE_END => '2012-11-25'
          } 
        }
      },
      '2013' =>
      {
        ORDINAL => 2,
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-24'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 3,
        CITY => 'Mumbai',
        CLUB => 'Bombay Gymkhana Club',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Pune',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-11-28',
            DATE_END => '2015-11-29'
          } 
        }
      },
    }
  },

  'Bhabha Atomic Research Centre Open' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2013-11-17',
            DATE_END => '2013-11-17'
          } 
        }
      },
    }
  },

  'B L Rao Memorial Open' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        ORDINAL => 20,
        CITY => 'Hyderabad',
        CLUB => 'Jubilee Hills International Centre',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-14'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-15',
            DATE_END => '2012-07-15'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-15',
            DATE_END => '2012-07-15'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-16',
            DATE_END => '2012-07-16'
          } 
        }
      },
    }
  },

  'Dainik Navjyoti All India Inter-State' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-14',
            DATE_END => '2011-08-14'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-15',
            DATE_END => '2011-08-15'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-16',
            DATE_END => '2011-08-16'
          } 
        }
      },
    }
  },

  'Delhi Gymkhana Club Dhampur Trophy' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-03-01',
            DATE_END => '2019-03-03'
          },
        }
      },
    }
  },

  'Delhi Gymkhana Club Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2012-12-02',
            DATE_END => '2012-12-02'
          } 
        }
      },
    }
  },

  'Delhi Gymkhana Club Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Delhi',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-11-25',
            DATE_END => '2011-11-26'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-11-26',
            DATE_END => '2011-11-26'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-11-27',
            DATE_END => '2011-11-27'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-11-27',
            DATE_END => '2011-11-27'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-11-29',
            DATE_END => '2012-11-30'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-11-30',
            DATE_END => '2012-12-01'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-09-06',
            DATE_END => '2013-09-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-07'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-08'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-08',
            DATE_END => '2013-09-08'
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-02-07',
            DATE_END => '2014-02-08'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-08',
            DATE_END => '2014-02-08'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-09',
            DATE_END => '2014-02-09'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-02-09',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-14'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2015-02-14',
            DATE_END => '2015-02-14'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-15',
            DATE_END => '2015-02-15'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-15',
            DATE_END => '2015-02-15'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-20'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-02-21',
            DATE_END => '2016-02-21'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-02-21',
            DATE_END => '2016-02-21'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-03',
            DATE_END => '2017-03-05'
          }
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-03-16',
            DATE_END => '2018-03-18'
          }
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-28',
            DATE_END => '2020-03-01'
          }
        }
      },
    }
  },

  'Fenesta Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-05-24',
            DATE_END => '2023-05-24'
          },
        }
      },
    }
  },

  'Fenesta Women Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-05-23',
            DATE_END => '2023-05-23'
          },
        }
      },
    }
  },

  'Ganesha Open Teams' =>
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
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-03-02',
            DATE_END => '2023-03-05'
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
            DATE_START => '2024-07-12',
            DATE_END => '2024-07-14'
          },
        }
      },
    }
  },

  'Godfrey Phillips All India Open' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-22',
            DATE_END => '2007-12-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-22',
            DATE_END => '2007-12-22'
          } 
        }
      },
    }
  },

  'HCL Pro-Am Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Pro-Am',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-06',
            DATE_END => '2023-11-06'
          },
        }
      },
      '2024' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-09-22',
            DATE_END => '2024-09-22'
          },
        }
      },
    }
  },

  'Hindusthan Club Teams' =>
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
        CITY => 'Kolkata',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-18',
            DATE_END => '2009-07-18'
          },
          'C1' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-19',
            DATE_END => '2009-07-19'
          } 
        }
      },
    }
  },

  'Indian Gold Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2022-12-08',
            DATE_END => '2022-12-09'
          },
        }
      },
    }
  },

  'Indian Gold Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018B' =>
      {
        MEET => 'All India HCL Tournament',
        MEET_TAG => '2018',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-08-09',
            DATE_END => '2018-08-14'
          },
        }
      },
      '2018C' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2018',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-09',
            DATE_END => '2018-12-13'
          },
        }
      },
      '2019A' =>
      {
        MEET => 'Indian Summer Nationals',
        MEET_TAG => '2019',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-06-02',
            DATE_END => '2019-06-05'
          },
        }
      },
      '2019B' =>
      {
        MEET => 'All India HCL Tournament',
        MEET_TAG => '2019',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-08-05',
            DATE_END => '2019-08-10'
          },
        }
      },
      '2019C' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2019',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-12-10',
            DATE_END => '2019-12-12'
          },
        }
      },
      '2022A' =>
      {
        MEET => 'Indian Summer Nationals',
        MEET_TAG => '2022',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-06-29',
            DATE_END => '2022-07-02'
          },
        }
      },
      '2022B' =>
      {
        MEET => 'All India HCL Tournament',
        MEET_TAG => '2022',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-10-11',
            DATE_END => '2022-10-16'
          },
        }
      },
      '2022C' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2022',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-12-04',
            DATE_END => '2022-12-07'
          },
        }
      },
      '2023A' =>
      {
        MEET => 'Indian Summer Nationals',
        MEET_TAG => '2023',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-06-25',
            DATE_END => '2023-06-27'
          },
        }
      },
      '2023B' =>
      {
        MEET => 'All India HCL Tournament',
        MEET_TAG => '2023',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-05',
            DATE_END => '2023-11-05'
          },
        }
      },
      '2024A' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2024A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-01-05',
            DATE_END => '2024-01-07'
          },
        }
      },
      '2024B' =>
      {
        MEET => 'Indian Summer Nationals',
        MEET_TAG => '2024',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-06-11',
            DATE_END => '2024-06-13'
          },
        }
      },
      '2024C' =>
      {
        MEET => 'All India HCL Tournament',
        MEET_TAG => '2024',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-09-16',
            DATE_END => '2024-09-21'
          },
        }
      },
      '2024D' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2024B',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-12',
            DATE_END => '2024-12-16'
          },
        }
      },
    }
  },

  'Indian Gold Women Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-12-12',
            DATE_END => '2022-12-12'
          },
        }
      },
    }
  },

  'Indian Inter-State Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-11-02',
            DATE_END => '2012-11-02'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-11-03',
            DATE_END => '2012-11-03'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-04',
            DATE_END => '2012-11-04'
          } 
        }
      },
      '2013' =>
      {
        ORDINAL => 3,
        CITY => 'Varanasi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-23'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-24',
            DATE_END => '2013-08-24'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-25',
            DATE_END => '2013-08-25'
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
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-06'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 5,
        CITY => 'Nagpur',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-04',
            DATE_END => '2015-09-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-06',
            DATE_END => '2015-09-06'
          } 
        }
      },
      '2016' =>
      {
        CITY => 'Ludhiana',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-04',
            DATE_END => '2016-11-06'
          },
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-02',
            DATE_END => '2017-09-03'
          },
        }
      },
      '2018' =>
      {
        CITY => 'Mysore',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-09-07',
            DATE_END => '2018-09-09'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-06',
            DATE_END => '2019-09-08'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-09-14',
            DATE_END => '2022-09-18'
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
            DATE_START => '2023-11-24',
            DATE_END => '2023-11-26'
          },
        }
      },
      '2024' =>
      {
        REGION => 'Goa',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-08-29',
            DATE_END => '2024-08-31'
          },
        }
      },
    }
  },

  'Indian Masters Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
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
            DATE_START => '2022-09-29',
            DATE_END => '2022-10-02'
          },
        }
      },
    }
  },

  'Indian Masters Open Teams' =>
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
            DATE_START => '2016-11-27',
            DATE_END => '2016-11-29'
          },
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-11-06',
            DATE_END => '2017-11-07'
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
            DATE_START => '2024-02-18',
            DATE_END => '2024-02-20'
          },
        }
      },
    }
  },

  'Indian Men Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-05-01',
            DATE_END => '2024-05-07'
          },
        }
      },
    }
  },

  'Indian Mixed Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'Indian Winter Nationals',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-12-11',
            DATE_END => '2022-12-11'
          },
        }
      },
      '2024' =>
      {
        MEET => 'All India HCL Tournament',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-09-14',
            DATE_END => '2024-09-15'
          },
        }
      },
    }
  },

  'Indian Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-05-08',
            DATE_END => '2024-05-12'
          },
        }
      },
    }
  },

  'Indian Open Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-22',
            DATE_END => '2011-04-23'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-24',
            DATE_END => '2011-04-25'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-23',
            DATE_END => '2012-06-25'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-25',
            DATE_END => '2012-06-26'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-26',
            DATE_END => '2012-06-27'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-02-22',
            DATE_END => '2013-02-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-25',
            DATE_END => '2013-02-26'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Knock-out',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-08-12',
            DATE_END => '2014-08-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            groupon => 'AUTO',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-08-13',
            DATE_END => '2014-08-13'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-15'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-15',
            DATE_END => '2014-08-16'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-29',
            DATE_END => '2015-06-30'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-30',
            DATE_END => '2015-07-01'
          } 
        }
      },
      '2016' =>
      {
        REGION => 'Goa',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-11',
            DATE_END => '2016-06-11'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-12',
            DATE_END => '2016-06-13'
          } 
        }
      },
      '2017A' =>
      {
        CITY => 'Ahmedabad',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-03',
            DATE_END => '2017-02-06'
          },
        }
      },
      '2017B' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-06',
            DATE_END => '2017-10-08'
          },
        }
      },
    }
  },

  'Indian Senior Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-05-06',
            DATE_END => '2011-05-07'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-08',
            DATE_END => '2011-05-08'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-07',
            DATE_END => '2012-07-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-08',
            DATE_END => '2012-07-08'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-09',
            DATE_END => '2012-07-09'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Chennai',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-04-15',
            DATE_END => '2013-04-16'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-16',
            DATE_END => '2013-04-17'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-17',
            DATE_END => '2013-04-18'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Mumbai',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-09',
            DATE_END => '2015-02-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-10',
            DATE_END => '2015-02-10'
          } 
        }
      },
      '2016' =>
      {
        REGION => 'Goa',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-15',
            DATE_END => '2016-06-16'
          } 
        }
      },
      '2017' =>
      {
        CITY => 'Ahmedabad',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-07',
            DATE_END => '2017-02-09'
          },
        }
      },
      '2018' =>
      {
        CITY => 'Mumbai',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-29',
            DATE_END => '2018-05-01'
          } 
        }
      },
      '2021' =>
      {
        CITY => 'Ahmedabad',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-25',
            DATE_END => '2021-10-27'
          } 
        }
      },
    }
  },

  'Indian Silver Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-08-14',
            DATE_END => '2018-08-14'
          },
        }
      },
      '2018B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-13',
            DATE_END => '2018-12-13'
          },
        }
      },
      '2019A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-06-03',
            DATE_END => '2019-06-05'
          },
        }
      },
      '2019B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-08-10',
            DATE_END => '2019-08-10'
          },
        }
      },
      '2019C' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-12-12',
            DATE_END => '2019-12-12'
          },
        }
      },
      '2022A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-10-15',
            DATE_END => '2022-10-16'
          },
        }
      },
      '2022B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-12-06',
            DATE_END => '2022-12-07'
          },
        }
      },
      '2023A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-06-27',
            DATE_END => '2023-06-27'
          },
        }
      },
      '2023B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-05',
            DATE_END => '2023-11-05'
          },
        }
      },
      '2024A' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-01-06',
            DATE_END => '2024-01-06'
          },
        }
      },
      '2024B' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-09-21',
            DATE_END => '2024-09-21'
          },
        }
      },
      '2024C' =>
      {
        MEET => 'Indian Winter Nationals',
        MEET_TAG => '2024B',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-15',
            DATE_END => '2024-12-15'
          },
        }
      },
    }
  },

  'Indian State Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # TODO Same as Indian Inter-State Teams?
      '2013' =>
      {
        SPONSOR => 'Indian Oil',
        CITY => 'Nashik',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-11-10',
            DATE_END => '2013-11-10'
          } 
        }
      },
    }
  },

  'Indian Western Zone Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CITY => 'Mumbai',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-07-11',
            DATE_END => '2005-07-11'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-07-11',
            DATE_END => '2005-07-11'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-07-11',
            DATE_END => '2005-07-11'
          } 
        }
      },
    }
  },

  'Indian Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-05-13',
            DATE_END => '2024-05-16'
          },
        }
      },
    }
  },

  'Jaya Jain Memorial' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Uttar Pradesh State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-08-17',
            DATE_END => '2012-08-17'
          } 
        }
      },
    }
  },

  'JHIC Silver Jubilee Open Teams' =>
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
            DATE_START => '2017-07-02',
            DATE_END => '2017-07-03'
          },
        }
      },
    }
  },

  'Justice J M Lal All India Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-03-30',
            DATE_END => '2013-04-01'
          } 
        }
      },
    }
  },

  'Justice J M Lal All India Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-17'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-06'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-07',
            DATE_END => '2012-04-07'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-30',
            DATE_END => '2013-03-30'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-30',
            DATE_END => '2013-03-30'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-31',
            DATE_END => '2013-04-01'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-06',
            DATE_END => '2014-04-06'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 9,
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-18'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-18'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-19',
            DATE_END => '2015-04-19'
          } 
        }
      },
    }
  },

  'Kabra Open IMP Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-09-30',
            DATE_END => '2023-10-02'
          },
        }
      },
    }
  },

  'Kabra Women IMP Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2022-09-19',
            DATE_END => '2022-09-21'
          },
        }
      },
    }
  },

  'Karnataka State Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        CITY => 'Bangalore',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-28',
            DATE_END => '2012-07-28'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-29',
            DATE_END => '2012-07-29'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-29',
            DATE_END => '2012-07-29'
          },
        }
      },
    }
  },

  'Kalani Trophy',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-08'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-01-04',
            DATE_END => '2011-01-06'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|SESSION',
            DATE_START => '2011-01-07',
            DATE_END => '2011-01-07'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-01-08',
            DATE_END => '2011-01-08'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-09',
            DATE_END => '2011-01-09'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-06',
            DATE_END => '2012-01-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-06',
            DATE_END => '2012-01-07'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-07',
            DATE_END => '2012-01-08'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-09',
            DATE_END => '2015-01-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-10'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-11'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        MEET_TAG => '2023A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-16',
            DATE_END => '2023-01-18'
          },
        }
      },
    }
  },

  'Karnik-Vaidya Open',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2011-02-06',
            DATE_END => '2011-02-06'
          } 
        }
      },
    }
  },

  'Kr. Murli Manohar National Masters' =>
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
            DATE_START => '2018-10-26',
            DATE_END => '2018-10-28'
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
            DATE_START => '2019-10-20',
            DATE_END => '2019-10-22'
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
            DATE_START => '2022-11-04',
            DATE_END => '2022-11-06'
          },
        }
      },
    }
  },

  'Krishnapatnam Port National Masters' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        # Not really sure.
        MEET => 'Indian South Zone Championship',
        CITY => 'Hyderabad',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-19',
            DATE_END => '2015-12-19'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-20',
            DATE_END => '2015-12-20'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-21',
            DATE_END => '2015-12-21'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indian South Zone Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2016-08-13',
            DATE_END => '2016-08-13'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-08-13',
            DATE_END => '2016-08-13'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-08-14',
            DATE_END => '2016-08-14'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-08-14',
            DATE_END => '2016-08-14'
          } 
        }
      },
    }
  },

  'Lalit Mohanka Memorial' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CLUB => 'Calcutta Cricket & Football Club',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-03-25',
            DATE_END => '2011-03-26'
          },
          'C1' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-03-27',
            DATE_END => '2011-03-27'
          } 
        }
      },
      '2012' =>
      {
        CITY => 'Kolkata',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-25'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-25',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Kolkata',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-24'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-24'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-25'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-26',
            DATE_END => '2014-01-26'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-21',
            DATE_END => '2015-02-22'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-22',
            DATE_END => '2015-02-22'
          } 
        }
      },
    }
  },

  'Lokmanya Jubilee',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SEGMENT',
            DATE_START => '2010-09-26',
            DATE_END => '2010-09-26'
          } 
        }
      },
    }
  },

  'L C Sunil Rajendra Memorial' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2013-09-15',
            DATE_END => '2013-09-15'
          } 
        }
      },
    }
  },

  'Madras Gymkhana Club Open' =>
  {
    # https://www.bridgewebs.com/gymkhanachennai
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Chennai',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-01-19',
            DATE_END => '2012-01-20'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-21'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-21'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-22',
            DATE_END => '2012-01-22'
          } 
        }
      },
      '2015' =>
      {
        SPONSOR => 'TTK Healthcare',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-01-18',
            DATE_END => '2015-01-18'
          } 
        }
      },
      '2016' =>
      {
        SPONSOR => 'TTK Healthcare',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-01-24',
            DATE_END => '2016-01-24'
          } 
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-16',
            DATE_END => '2020-01-19'
          } 
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-05',
            DATE_END => '2023-01-08'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-01',
            DATE_END => '2024-02-04'
          } 
        }
      },
    }
  },

  'Maharaja Yeshwantrao Holkar National Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SESSION|ROUND|SEGMENT',
            DATE_START => '2009-12-24',
            DATE_END => '2009-12-24'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-10'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2012-12-21',
            DATE_END => '2012-12-22'
          } 
        }
      },
    }
  },

  'Maharaja Yeshwantrao Holkar National Teams' =>
  {
    # Could be the same as Kalani Trophy
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2009-12-24',
            DATE_END => '2009-12-24'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-08'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-09'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-01-09',
            DATE_END => '2010-01-10'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-01-05',
            DATE_END => '2012-01-06'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-01-10',
            DATE_END => '2013-01-11'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-11',
            DATE_END => '2013-01-11'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT|SESSION',
            DATE_START => '2013-01-12',
            DATE_END => '2013-01-12'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-12',
            DATE_END => '2013-01-13'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-04',
            DATE_END => '2014-01-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-05',
            DATE_END => '2014-01-05'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-05',
            DATE_END => '2014-01-06'
          },
        },
      },
      '2016' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-09'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-09',
            DATE_END => '2016-01-09'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-10',
            DATE_END => '2016-01-10'
          },
        },
      },
      '2017' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-01-06',
            DATE_END => '2017-01-08'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-12',
            DATE_END => '2018-01-14'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-11',
            DATE_END => '2019-01-13'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-05',
            DATE_END => '2020-01-07'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Maharaja Holkar National Championship',
        MEET_TAG => '2023B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-12-17',
            DATE_END => '2023-12-19'
          },
        }
      },
    }
  },

  'Maharashtra State Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Maharashtra State Championship',
        MEET_TAG => '2012A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION|ROUND|SEGMENT',
            DATE_START => '2012-02-27',
            DATE_END => '2012-02-28'
          } 
        }
      },
    }
  },

  'Maharashtra State Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012A' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-25',
            DATE_END => '2012-02-26'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-26',
            DATE_END => '2012-02-26'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-26',
            DATE_END => '2012-02-26'
          },
        }
      },
      '2012B' =>
      {
        MEET => 'Maharashtra State Championship',
        CITY => 'Nashik',
        CHAPTERS =>
        {
          'C0' => 
          {
            # Not sure
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          },
          'C1' => 
          {
            # Not sure
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-27'
          },
          'C2' => 
          {
            # Not sure
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          },
          'C3' => 
          {
            # Not sure
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-10-28',
            DATE_END => '2012-10-28'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-01-19',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-02'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-25',
            DATE_END => '2016-06-25'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-17',
            DATE_END => '2017-02-18'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-04-14',
            DATE_END => '2023-04-16'
          } 
        }
      },
    }
  },

  'Mall of the Millenium Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-17',
            DATE_END => '2024-12-18'
          },
        }
      },
    }
  },

  'Mavericks Premier League' =>
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
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-03',
            DATE_END => '2023-08-06'
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
            DATE_START => '2024-08-15',
            DATE_END => '2024-08-18'
          },
        }
      },
    }
  },

  'Mohan Sicka BAM Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2009-12-23',
            DATE_END => '2009-12-23'
          } 
        }
      },
    }
  },

  'Mohan Sicka Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-01-20',
            DATE_END => '2014-01-20'
          } 
        }
      },
    }
  },

  'Mohanlal Bhartia Memorial Grand Prix' =>
  {
    # https://www.bridgewebs.com/bhartia/
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-02-05',
            DATE_END => '2010-02-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-02-05',
            DATE_END => '2010-02-06'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-06',
            DATE_END => '2010-02-07'
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
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-02-10',
            DATE_END => '2011-02-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-11'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-11'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-02-12',
            DATE_END => '2011-02-12'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-02-12',
            DATE_END => '2011-02-13'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-10'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-10'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-11'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-05'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-06'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-06',
            DATE_END => '2013-04-06'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-07',
            DATE_END => '2013-04-07'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof64',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-03-14',
            DATE_END => '2014-03-14'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-03-14',
            DATE_END => '2014-03-14'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-15'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-15'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-15'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-16',
            DATE_END => '2014-03-16'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-04-03',
            DATE_END => '2015-04-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-05',
            DATE_END => '2015-04-05'
          } 
        }
      },
      '2016' =>
      {
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Knock-out',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2016-03-11',
            DATE_END => '2016-03-12'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-13',
            DATE_END => '2016-03-13'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-26',
            DATE_END => '2017-03-28'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-01',
            DATE_END => '2018-04-03'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-03-15',
            DATE_END => '2019-03-17'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-07-29',
            DATE_END => '2022-07-31'
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
            DATE_START => '2023-04-09',
            DATE_END => '2023-04-11'
          },
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-03-29',
            DATE_END => '2024-03-31'
          },
        }
      },
    }
  },

  'Mohanlal Bhartia Memorial Pairs' =>
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
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2011-02-12',
            DATE_END => '2011-02-13'
          } 
        }
      },
      '2023' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2023-04-11',
            DATE_END => '2023-04-11'
          } 
        }
      },
    }
  },

  'Nandu Oke Memorial IAF Swiss Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IAF',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CITY => 'Mumbai',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-21'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-05-13',
            DATE_END => '2016-05-13'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-05-14',
            DATE_END => '2016-05-15'
          } 
        }
      },
    }
  },

  'Narain Bhojwani Memorial',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CLUB => 'Otters Club',
    CITY => 'Mumbai',
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
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2010-01-30',
            DATE_END => '2010-01-31'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            MOVEMENT => 'Round-robin',
            DATE_START => '2012-01-28',
            DATE_END => '2012-01-29'
          } 
        }
      },
    }
  },

  'Otters Inter-Club Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Mumbai',
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
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2010-09-05',
            DATE_END => '2010-09-05'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-01-22',
            DATE_END => '2011-01-23'
          } 
        }
      },
    }
  },

  'P Singhania All India Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-02-22',
            DATE_END => '2019-02-24'
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
            DATE_START => '2020-02-21',
            DATE_END => '2020-02-23'
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
            DATE_START => '2023-02-24',
            DATE_END => '2023-02-26'
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
            DATE_START => '2024-02-23',
            DATE_END => '2024-02-25'
          },
        }
      },
    }
  },

  'Phoenix Mixed Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-10',
            DATE_END => '2024-12-11'
          },
        }
      },
    }
  },

  'Poddar National Masters' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-16',
            DATE_END => '2010-08-16'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-17',
            DATE_END => '2010-08-17'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-05',
            DATE_END => '2011-08-05'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            groupon => 'AUTO',
            DATE_START => '2011-08-06',
            DATE_END => '2011-08-06'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-07',
            DATE_END => '2011-08-07'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-05'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-06',
            DATE_END => '2012-10-06'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-10-07',
            DATE_END => '2012-10-07'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Kolkata',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-24',
            DATE_END => '2013-10-25'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-26'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-27',
            DATE_END => '2013-10-27'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-31',
            DATE_END => '2014-10-31'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-01',
            DATE_END => '2014-11-01'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-11-02',
            DATE_END => '2014-11-02'
          } 
        }
      },
    }
  },

  'Prashant Desai Memorial' =>
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
        CITY => 'Nashik',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-03-26',
            DATE_END => '2016-03-26'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-27',
            DATE_END => '2016-03-27'
          } 
        }
      },
    }
  },

  'Pune State Level Open Teams' =>
  {
    %GLOBAL,
    CITY => 'Pune',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        SPONSOR => 'Jain Group',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-06-01',
            DATE_END => '2014-06-01'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-05-24',
            DATE_END => '2015-05-24'
          } 
        }
      },
    }
  },

  'PSN Sarma Centenary Memorial Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Chennai',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-02-07',
            DATE_END => '2015-02-07'
          } 
        }
      },
    }
  },

  'PSN Sarma Centenary Memorial Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Chennai',
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-02-08',
            DATE_END => '2015-02-08'
          } 
        }
      },
    }
  },

  'PYC Hindu Gymkhana Royale' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Pune',
    FORM => 'Pairs',
    SCORING => 'IMP',
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
            major => 'ROUND|SESSION|SEGMENT',
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-02'
          } 
        }
      },
    }
  },

  'Rai Bahadur Modi Memorial All India Open' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
          } 
        }
      },
    }
  },

  'Rajasthan Invitational Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-03',
            DATE_END => '2013-05-04'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-04'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-05-05',
            DATE_END => '2013-05-05'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-03-09',
            DATE_END => '2014-03-09'
          } 
        }
      },
    }
  },

  'Rajasthan Invitational Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-03',
            DATE_END => '2013-05-04'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-04'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-05'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-08',
            DATE_END => '2014-03-08'
          } 
        }
      },
    }
  },

  'R N Bagla Memorial Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            major => 'ROUND',
            DATE_START => '2011-08-26',
            DATE_END => '2011-08-28'
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
            DATE_START => '2012-10-19',
            DATE_END => '2012-10-21'
          } 
        }
      },
    }
  },

  'R R Gupta Memorial Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        ORDINAL => 1,
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-03-12',
            DATE_END => '2015-03-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-13',
            DATE_END => '2015-03-13'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-14',
            DATE_END => '2015-03-14'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-15',
            DATE_END => '2015-03-15'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 2,
        CITY => 'Delhi',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-04-01',
            DATE_END => '2016-04-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-04-02',
            DATE_END => '2016-04-02'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-03',
            DATE_END => '2016-04-03'
          } 
        }
      },
    }
  },

  'R Ratnam Memorial' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CITY => 'Chennai',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-11-15',
            DATE_END => '2014-11-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2014-11-16',
            DATE_END => '2014-11-16'
          } 
        }
      },
    }
  },

  'Ruia Gold Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          } 
        }
      },
      '2005-06' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-31',
            DATE_END => '2005-12-31'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2006-01-01',
            DATE_END => '2006-01-01'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-01-02',
            DATE_END => '2006-01-02'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-20'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-19'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-19'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-20',
            DATE_END => '2009-12-20'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-15',
            DATE_END => '2010-12-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-16',
            DATE_END => '2010-12-17'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-16',
            DATE_END => '2010-12-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-12-06',
            DATE_END => '2011-12-07'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-08',
            DATE_END => '2011-12-08'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2011-12-09',
            DATE_END => '2011-12-09'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-10'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-19',
            DATE_END => '2012-12-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2012-12-19',
            DATE_END => '2012-12-20'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-20',
            DATE_END => '2012-12-21'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Pre-Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-12-21',
            DATE_END => '2013-12-21'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-12-22',
            DATE_END => '2013-12-22'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-23',
            DATE_END => '2013-12-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2014-12-18',
            DATE_END => '2014-12-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-19',
            DATE_END => '2014-12-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2014-12-20',
            DATE_END => '2014-12-20'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-21',
            DATE_END => '2014-12-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-20'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-21'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-22',
            DATE_END => '2015-11-22'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-12-15',
            DATE_END => '2016-12-18'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-18',
            DATE_END => '2017-12-20'
          },
        }
      },
    }
  },

  'Ruia Silver Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-12-12',
            DATE_END => '2010-12-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-12-06',
            DATE_END => '2011-12-06'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-12-20',
            DATE_END => '2017-12-20'
          } 
        }
      },
    }
  },

  'Shree Cement Corporate Invitational Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Corporate',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-09-23',
            DATE_END => '2023-09-23'
          },
        }
      },
    }
  },

  'Shree Keni Trophy' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-21',
            DATE_END => '2013-07-21'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian South Zone Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-20',
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
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-25',
            DATE_END => '2015-07-25'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-26',
            DATE_END => '2015-07-26'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-31'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-22',
            DATE_END => '2017-07-23'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-21',
            DATE_END => '2018-07-22'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Goa Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-07-20',
            DATE_END => '2019-07-21'
          },
        }
      },
    }
  },

  'Smt. Vijya Jajoo Mixed Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-27',
            DATE_END => '2024-03-27'
          },
        }
      },
    }
  },

  'Summer Monsoon League',
  {
    ORGANIZATION => 'MBA',
    COUNTRY => 'India',
    ZONE => 'Asia Pacific',
    REGION => 'Maharashtra',
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-07-17',
            DATE_END => '2011-07-18'
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
            DATE_START => '2012-08-11',
            DATE_END => '2012-08-12'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-07-06',
            DATE_END => '2013-07-06'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-07-07',
            DATE_END => '2013-07-07'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-06-21',
            DATE_END => '2014-06-22'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2014-06-22',
            DATE_END => '2014-06-22'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Pune',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-04',
            DATE_END => '2015-07-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-07-05',
            DATE_END => '2015-07-05'
          } 
        }
      },
      '2016' =>
      {
        SPONSOR => 'Samadhan Academy',
        CITY => 'Mumbai',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-18'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-06-19',
            DATE_END => '2016-06-19'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-10',
            DATE_END => '2017-06-11'
          },
        }
      },
    }
  },

  'TATA Open',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Indian Summer Nationals',
        SPONSOR => 'Tata Consulting Services',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-06-18',
            DATE_END => '2010-06-18'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-06-19',
            DATE_END => '2010-06-19'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-20',
            DATE_END => '2010-06-20'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'West Indian Regional',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-17',
            DATE_END => '2011-01-17'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'West Indian Regional',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-15',
            DATE_END => '2012-01-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-16',
            DATE_END => '2012-01-16'
          } 
        }
      },
    }
  },

  'Thane Champion of Champions Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Mulund',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-02-06',
            DATE_END => '2011-02-06'
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
            major => 'ROUND',
            DATE_START => '2014-11-09',
            DATE_END => '2014-11-09'
          } 
        }
      },
    }
  },

  'Tolani Gold Trophy' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-14',
            DATE_END => '2011-03-14'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-15',
            DATE_END => '2011-03-15'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-16',
            DATE_END => '2011-03-16'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-19',
            DATE_END => '2012-06-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-20',
            DATE_END => '2012-06-20'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-21',
            DATE_END => '2012-06-21'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-02-18',
            DATE_END => '2013-02-18'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-02-19',
            DATE_END => '2013-02-19'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-20',
            DATE_END => '2013-02-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            ignore => 'TABLE',
            DATE_START => '2014-04-21',
            DATE_END => '2014-04-21'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            ignore => 'TABLE',
            DATE_START => '2014-04-22',
            DATE_END => '2014-04-22'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-23',
            DATE_END => '2014-04-23'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-06-18',
            DATE_END => '2015-06-18'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-19',
            DATE_END => '2015-06-19'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2015-06-20',
            DATE_END => '2015-06-20'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Pre-Quarterfinal',
            major => 'ROUND',
            DATE_START => '2016-07-07',
            DATE_END => '2016-07-07'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-08',
            DATE_END => '2016-07-08'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2016-07-09',
            DATE_END => '2016-07-09'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-18',
            DATE_END => '2017-06-21'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-06-25',
            DATE_END => '2018-06-28'
          },
        }
      },
    }
  },

  'Tolani Grand Prix' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-10-01',
            DATE_END => '2009-10-03'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-10-03',
            DATE_END => '2009-10-04'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2009-10-04',
            DATE_END => '2009-10-04'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2009-10-05',
            DATE_END => '2009-10-05'
          },
          'C4' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-12'
          } 
        }
      },
    }
  },

  'Tolani Silver Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-19',
            DATE_END => '2012-06-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-20',
            DATE_END => '2012-06-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-21',
            DATE_END => '2015-06-21'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'Uttar Pradesh State Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Uttar Pradesh State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-18',
            DATE_END => '2012-08-19'
          } 
        }
      },
    }
  },

  'Uttar Pradesh State Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Uttar Pradesh State Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-08-17',
            DATE_END => '2012-08-18'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-08-18',
            DATE_END => '2012-08-18'
          } 
        }
      },
    }
  },

  'West Bengal Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'West Bengal State Championship',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-11-12',
            DATE_END => '2022-11-13'
          },
        }
      },
      '2023' =>
      {
        MEET => 'West Bengal State Championship',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-18',
            DATE_END => '2023-11-19'
          },
        }
      },
      '2024A' =>
      {
        MEET => 'West Bengal State Championship',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-07-21',
            DATE_END => '2024-07-21'
          },
        }
      },
      '2024B' =>
      {
        MEET => 'West Bengal State Championship',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-11-09',
            DATE_END => '2024-11-10'
          },
        }
      },
    }
  },

  'West Bengal Open Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-05-18',
            DATE_END => '2024-05-19'
          },
        }
      },
    }
  },

  'Willingdon Sports Club Swiss Pairs',
  {
    # https://www.bridgewebs.com/willingdonbridge/
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Mumbai',
    FORM => 'Pairs',
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-25'
          } 
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-01-24',
            DATE_END => '2016-01-26'
          } 
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
            MOVEMENT => 'Swiss',
            DATE_START => '2017-01-27',
            DATE_END => '2017-01-29'
          } 
        }
      },
      '2018' =>
      {
        ORDINAL => 4,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Swiss',
            DATE_START => '2018-01-26',
            DATE_END => '2018-01-28'
          } 
        }
      },
      '2019' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Swiss',
            DATE_START => '2019-01-25',
            DATE_END => '2019-01-27'
          } 
        }
      },
      '2020' =>
      {
        ORDINAL => 6,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            MOVEMENT => 'Swiss',
            DATE_START => '2020-01-24',
            DATE_END => '2020-01-26'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Online
            YEAR => 2022,
            MOVEMENT => 'Swiss',
            DATE_START => '2022-01-28',
            DATE_END => '2022-01-30'
          } 
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Swiss',
            DATE_START => '2023-01-27',
            DATE_END => '2023-01-29'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Swiss',
            DATE_START => '2024-01-26',
            DATE_END => '2024-01-28'
          } 
        }
      },
    }
  },

  'WCG Open',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-25',
            DATE_END => '2009-10-25'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_INDIA, \%TOURNAMENTS_INDIA, 'India');
}

1;
