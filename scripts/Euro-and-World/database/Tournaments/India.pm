#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::India;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_INDIA =
(
  'All India HCL Tournament' =>
  {
    # Was called "All India" up to 2009, then
    # "HCL International".

    ORGANIZATION => 'BFI',
    SPONSOR => 'HCL',
    COUNTRY => 'India',
    ORIGIN => 'International',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2003' =>
      {
        # https://hcl-bridge.com/archive/2003-2/
        ORDINAL => 1,
        CITY => 'Delhi',
        YEAR => 2003,
        DATE_START => '2003-12-18',
        DATE_END => '2003-12-21'
      },
      '2004' =>
      {
        # https://hcl-bridge.com/archive/2004-2/
        ORDINAL => 2,
        CITY => 'Delhi',
        YEAR => 2004,
        DATE_START => '2004-08-12',
        DATE_END => '2004-08-15'
      },
      '2005' =>
      {
        # https://hcl-bridge.com/archive/2005-2/
        ORDINAL => 3,
        CITY => 'Noida',
        YEAR => 2005,
        DATE_START => '2005-08-12',
        DATE_END => '2005-08-15'
      },
      '2006' =>
      {
        # https://hcl-bridge.com/archive/2006-2/
        ORDINAL => 4,
        CITY => 'Noida',
        YEAR => 2006,
        DATE_START => '2006-08-12',
        DATE_END => '2006-08-15'
      },
      '2007' =>
      {
        # https://hcl-bridge.com/archive/2007-2/
        ORDINAL => 5,
        CITY => 'Noida',
        YEAR => 2007,
        DATE_START => '2007-08-16',
        DATE_END => '2007-08-19'
      },
      '2008' =>
      {
        # https://hcl-bridge.com/archive/2008-2/
        ORDINAL => 6,
        CITY => 'Noida',
        YEAR => 2008,
        DATE_START => '2008-09-04',
        DATE_END => '2008-09-07'
      },
      '2009' =>
      {
        # https://hcl-bridge.com/archive/2009-2/
        ORDINAL => 7,
        CITY => 'Noida',
        YEAR => 2009,
        DATE_START => '2009-08-13',
        DATE_END => '2009-08-16'
      },
      '2010' =>
      {
        # https://hcl-bridge.com/archive/2010-2/
        ORDINAL => 8,
        CITY => 'Noida',
        YEAR => 2010,
        DATE_START => '2010-10-30',
        DATE_END => '2010-11-02'
      },
      '2011' =>
      {
        # https://hcl-bridge.com/archive/2011-2/
        ORDINAL => 9,
        CITY => 'Noida',
        YEAR => 2011,
        DATE_START => '2011-09-08',
        DATE_END => '2011-09-11'
      },
      '2012' =>
      {
        # https://hcl-bridge.com/archive/2012-2/
        ORDINAL => 10,
        CITY => 'Delhi',
        YEAR => 2012,
        DATE_START => '2012-08-30',
        DATE_END => '2012-09-02'
      },
      '2013' =>
      {
        # https://hcl-bridge.com/archive/2013-2/
        ORDINAL => 11,
        CITY => 'Delhi',
        YEAR => 2013,
        DATE_START => '2013-08-08',
        DATE_END => '2013-08-11'
      },
      '2014' =>
      {
        # https://hcl-bridge.com/archive/2014-2/
        ORDINAL => 12,
        CITY => 'Delhi',
        YEAR => 2014,
        DATE_START => '2014-08-17',
        DATE_END => '2014-08-20'
      },
      '2015' =>
      {
        # https://hcl-bridge.com/archive/2015-2/
        ORDINAL => 13,
        CITY => 'Delhi',
        YEAR => 2015,
        DATE_START => '2015-08-20',
        DATE_END => '2015-08-23'
      },
      '2016' =>
      {
        # https://hcl-bridge.com/archive/2016-2/
        ORDINAL => 14,
        CITY => 'Delhi',
        YEAR => 2016,
        DATE_START => '2016-10-19',
        DATE_END => '2016-10-23'
      },
      '2017' =>
      {
        # https://hcl-bridge.com/archive/2017-2/
        ORDINAL => 15,
        CITY => 'Delhi',
        YEAR => 2017,
        DATE_START => '2017-09-12',
        DATE_END => '2017-09-17'
      },
      '2018' =>
      {
        # https://hcl-bridge.com/archive/2018-2/
        ORDINAL => 16,
        CITY => 'Delhi',
        YEAR => 2018,
        DATE_START => '2018-08-09',
        DATE_END => '2018-08-14'
      },
      '2019' =>
      {
        # https://hcl-bridge.com/archive/2019-2/
        ORDINAL => 17,
        CITY => 'Delhi',
        YEAR => 2019,
        DATE_START => '2019-08-05',
        DATE_END => '2019-08-10'
      },
      '2021' =>
      {
        # https://hcl-bridge.com/archive/2021-2/
        ORDINAL => 18,
        CITY => 'Online',
        YEAR => 2021,
        DATE_START => '2021-09-18',
        DATE_END => '2021-09-26'
      },
      '2022' =>
      {
        # https://hcl-bridge.com/archive/2022-2/
        ORDINAL => 19,
        CITY => 'Gurgaon',
        YEAR => 2023,
        DATE_START => '2023-10-31',
        DATE_END => '2023-11-06'
      },
      '2023' =>
      {
        # https://hcl-bridge.com/archive/2023-2/
        ORDINAL => 20,
        CITY => 'Delhi',
        YEAR => 2023,
        DATE_START => '2023-10-31',
        DATE_END => '2023-11-06'
      },
    }
  },

  'Goa Bridge Festival' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Panjim',
        DATE_START => '2013-07-18',
        DATE_END => '2013-07-21'
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Panjim',
        DATE_START => '2015-07-23',
        DATE_END => '2015-07-26'
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Panjim',
        DATE_START => '2016-07-30',
        DATE_END => '2016-07-31'
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Panjim',
        DATE_START => '2017-07-21',
        DATE_END => '2017-07-24'
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

  'Indian Summer Nationals' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2012' =>
      {
        ORDINAL => 1,
        CITY => 'Nashik',
        YEAR => 2012,
        DATE_START => '2011-03-15', # More dates
        DATE_END => '2011-03-15'
      },
      '2012' =>
      {
        ORDINAL => 2,
        YEAR => 2012,
        DATE_START => '2012-06-19', # More dates
        DATE_END => '2012-06-20'
      },
      '2013' =>
      {
        ORDINAL => 3,
        YEAR => 2013,
        DATE_START => '2013-02-18', # More dates
        DATE_END => '2013-02-20'
      },
      '2014' =>
      {
        ORDINAL => 4,
        CITY => 'Nashik',
        YEAR => 2014,
        DATE_START => '2014-04-21',
        DATE_END => '2014-04-23'
      },
      '2015' =>
      {
        ORDINAL => 5,
        CITY => 'Bangalore',
        YEAR => 2015,
        DATE_START => '2015-06-17',
        DATE_END => '2015-06-21'
      },
      '2016' =>
      {
        ORDINAL => 6,
        CITY => 'Bangalore',
        YEAR => 2016,
        DATE_START => '2016-07-06',
        DATE_END => '2016-07-10'
      },
      '2017' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page11
        ORDINAL => 7,
        CITY => 'Nashik',
        YEAR => 2017,
        DATE_START => '2017-06-17',
        DATE_END => '2017-06-21'
      },
      '2018' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page15
        ORDINAL => 8,
        CITY => 'Ahmedabad',
        YEAR => 2018,
        DATE_START => '2018-06-24',
        DATE_END => '2018-06-28'
      },
      '2019' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page1
        ORDINAL => 9,
        CITY => 'Pune',
        YEAR => 2019,
        DATE_START => '2019-06-01',
        DATE_END => '2019-06-05'
      },
      '2021' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page30
        ORDINAL => 10,
        YEAR => 2021,
        DATE_START => '2021-06-19',
        DATE_END => '2021-06-27'
      },
      '2022' =>
      {
        # https://bfi.net.in/tournament/11-tolani-summer-national-bridge-championship-2022/
        ORDINAL => 11,
        CITY => 'Bangalore',
        YEAR => 2022,
        DATE_START => '2022-06-28',
        DATE_END => '2022-07-07'
      },
      '2023' =>
      {
        # From here on not Tolani, but Mavericks
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page38
        ORDINAL => 1,
        CITY => 'Goa',
        YEAR => 2023,
        DATE_START => '2023-06-20',
        DATE_END => '2023-06-28'
      },
      '2024' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=summernationals&pid=display_page46
        ORDINAL => 2,
        CITY => 'Mangalore',
        YEAR => 2024,
        DATE_START => '2024-06-05',
        DATE_END => '2024-06-14'
      },
    }
  },

  'Indian Winter Nationals' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',

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
        ORDINAL => 46,
        CITY => 'Visakhapatnam',
        YEAR => 2004,
        DATE_START => '2004-12-07',
        DATE_END => '2004-12-17'
      },
      '2005' =>
      {
        ORDINAL => 47,
        CITY => 'Chennai',
        DATE_START => '2005-12-27',
        DATE_END => '2005-01-05'
      },
      '2007' =>
      {
        ORDINAL => 49,
        CITY => 'Bharuch',
        YEAR => 2007,
        DATE_START => '2007-12-22', # More dates
        DATE_END => '2007-12-22'
      },
      '2008' =>
      {
        ORDINAL => 50,
        CITY => 'Kanpur',
        DATE_START => '2008-11-12',
        DATE_END => '2008-11-21'
      },
      '2009' =>
      {
        ORDINAL => 51,
        DATE_START => '2009-12-24', # More dates
        DATE_END => '2009-12-24'
      },
      '2010' =>
      {
        ORDINAL => 52,
        CITY => 'Kolkata',
        YEAR => 2010,
        DATE_START => '2010-12-12', # More dates
        DATE_END => '2010-12-17'
      },
      '2011' =>
      {
        ORDINAL => 53,
        CITY => 'Chennai',
        YEAR => 2011,
        DATE_START => '2011-12-06', # More dates
        DATE_END => '2011-12-10'
      },
      '2012' =>
      {
        ORDINAL => 54,
        YEAR => 2012,
        CITY => 'Kolkata',
        DATE_START => '2012-12-16',
        DATE_END => '2012-12-22'
      },
      '2014' =>
      {
        ORDINAL => 55,
        CITY => 'Ahmedabad',
        YEAR => 2013,
        DATE_START => '2013-12-20', # More dates
        DATE_END => '2013-12-10'
      },
      '2014' =>
      {
        ORDINAL => 56,
        CITY => 'Jaipur',
        YEAR => 2014,
        DATE_START => '2014-12-18', # More dates
        DATE_END => '2014-12-21'
      },
      '2015' =>
      {
        ORDINAL => 57,
        CITY => 'Pune',
        YEAR => 2015,
        DATE_START => '2015-11-20', # More dates
        DATE_END => '2015-11-22'
      },
      '2016' =>
      {
        # No explicit results links for whole Nationals, but
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=docs_Full%20Brochure.pdf
        ORDINAL => 58,
        YEAR => 2016,
        CITY => 'Jaipur',
        DATE_START => '2016-12-12',
        DATE_END => '2016-12-18'
      },
      '2017' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page14
        ORDINAL => 59,
        YEAR => 2017,
        CITY => 'Visakhapatnam',
        DATE_START => '2017-12-16',
        DATE_END => '2017-12-22'
      },
      '2018' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page25
        ORDINAL => 60,
        YEAR => 2018,
        CITY => 'Chennai',
        DATE_START => '2018-12-09',
        DATE_END => '2018-12-17'
      },
      '2019' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page30
        ORDINAL => 61,
        YEAR => 2019,
        CITY => 'Kolkata',
        DATE_START => '2019-12-08',
        DATE_END => '2019-12-15'
      },
      '2022' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page13
        ORDINAL => 64,
        YEAR => 2022,
        CITY => 'Jabalpur',
        DATE_START => '2022-12-03',
        DATE_END => '2022-12-12'
      },
      '2024' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=winternationals&pid=display_page59
        ORDINAL => 65,
        YEAR => 2024,
        CITY => 'Jabalpur',
        DATE_START => '2024-01-03',
        DATE_END => '2024-01-09'
      },
    }
  },

  'Maharashtra State Championship'  =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2012' =>
      {
        ORDINAL => 32,
        YEAR => 2012,
        DATE_START => '2012-06-19', # More dates
        DATE_END => '2012-06-20'
      },
    }
  },

  'Rajasthan Invitational Championship'  =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Invitational',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-05-03',
        DATE_END => '2013-05-05'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-03-07',
        DATE_END => '2014-03-09'
      },
    }
  },
);

my %TOURNAMENTS_INDIA =
(
  'All India Bangur Cement Hindusthan Club' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-07-27',
            DATE_END => '2012-07-29'
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
            DATE_START => '2013-07-27',
            DATE_END => '2013-07-28'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-07-24',
            DATE_END => '2015-07-26'
          } 
        }
      },
    }
  },

  'All India Corporate Invitational' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'All India Corporate Invitational Pairs' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
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
            SCORING => 'MP',
            DATE_START => '2012-09-16',
            DATE_END => '2012-09-16'
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
            SCORING => 'MP',
            DATE_START => '2013-09-28',
            DATE_END => '2013-09-28'
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
            SCORING => 'IMP',
            DATE_START => '2016-08-27',
            DATE_END => '2016-08-27'
          } 
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
            DATE_START => '2013-08-11',
            DATE_END => '2013-08-11'
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
          'SINGLE' => 
          {
            YEAR => 2007,
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
          'SINGLE' => 
          {
            YEAR => 2008,
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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-14',
            DATE_END => '2009-08-16'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-31',
            DATE_END => '2010-11-02'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-09',
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
            DATE_START => '2012-08-31',
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
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-11'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-18',
            DATE_END => '2014-08-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'All India HCL Tournament',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-20',
            DATE_END => '2015-08-23'
          } 
        }
      },
    }
  },

  'All India Shree Cement' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-10-15',
            DATE_END => '2011-10-16'
          },
          'C1' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-11',
            DATE_END => '2011-11-13'
          } 
        }
      },
    }
  },

  'All India UTI Bank Masters Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2007-04-11',
            DATE_END => '2007-04-11'
          } 
        }
      },
    }
  },

  'Bhabha Atomic Research Centre Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2013-11-17',
            DATE_END => '2013-11-17'
          } 
        }
      },
    }
  },

  'B L Rao Memorial Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-16'
          } 
        }
      },
    }
  },

  'Dainik Navjyoti All India Inter-State' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-08-14',
            DATE_END => '2011-08-16'
          } 
        }
      },
    }
  },

  'Delhi Gymkhana Club Centenary' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Delhi Gymkhana Club Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-11-25',
            DATE_END => '2011-11-27'
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
            DATE_START => '2013-09-06',
            DATE_END => '2013-09-08'
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
            DATE_START => '2012-11-29',
            DATE_END => '2012-12-02'
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
            DATE_START => '2014-02-07',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-15'
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
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-21'
          } 
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
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-12-22',
            DATE_END => '2007-12-22'
          } 
        }
      },
    }
  },

  'Hindusthan Club Teams' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-07-18',
            DATE_END => '2009-07-19'
          } 
        }
      },
    }
  },

  'Indian Inter-State Teams' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-11-02',
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
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-25'
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
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-07'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-04',
            DATE_END => '2015-09-06'
          } 
        }
      },
    }
  },

  'Indian Open Trials' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-04-22',
            DATE_END => '2011-04-25'
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
            DATE_START => '2012-06-23',
            DATE_END => '2012-06-27'
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
            DATE_START => '2013-02-22',
            DATE_END => '2013-02-26'
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
            DATE_START => '2014-08-12',
            DATE_END => '2014-08-16'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-06-29',
            DATE_END => '2015-07-01'
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
            DATE_START => '2016-06-11',
            DATE_END => '2016-06-13'
          } 
        }
      },
    }
  },

  'Indian Senior Trials' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-05-06',
            DATE_END => '2011-05-08'
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
            DATE_START => '2012-07-07',
            DATE_END => '2012-07-09'
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
            DATE_START => '2013-04-15',
            DATE_END => '2013-04-18'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-09',
            DATE_END => '2015-02-10'
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
            DATE_START => '2016-06-15',
            DATE_END => '2016-06-16'
          } 
        }
      },
    }
  },

  'Indian South Zone Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-20',
            DATE_END => '2014-07-21'
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
            DATE_START => '2016-08-13',
            DATE_END => '2016-08-14'
          } 
        }
      },
    }
  },

  'Indian State Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # TODO Same as Indian Inter-State Teams?
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
          } 
        }
      },
    }
  },

  'Indian Western Zone Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-07-11',
            DATE_END => '2005-07-11'
          } 
        }
      },
    }
  },

  'Jaya Jain Memorial' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-08-17',
            DATE_END => '2012-08-17'
          } 
        }
      },
    }
  },

  'Justice J M Lal All India Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-17'
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
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-07'
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
            DATE_START => '2013-03-30',
            DATE_END => '2013-04-01'
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
            DATE_START => '2014-04-06',
            DATE_END => '2014-04-06'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-19'
          } 
        }
      },
    }
  },

  'Karnataka State Teams' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-07-28',
            DATE_END => '2012-07-29'
          } 
        }
      },
    }
  },

  'Krishnapatnam Port National Masters' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2015-12-19',
            DATE_END => '2015-12-21'
          } 
        }
      },
    }
  },

  'Lalit Mohanka Memorial' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-03-25',
            DATE_END => '2011-03-27'
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
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-25'
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
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-24'
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
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-22'
          } 
        }
      },
    }
  },

  'L C Sunil Rajendra Memorial' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2013-09-15',
            DATE_END => '2013-09-15'
          } 
        }
      },
    }
  },

  'Madras Gymkhana Club Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    CITY => 'Chennai',
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
            DATE_START => '2012-01-19',
            DATE_END => '2012-01-22'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-18',
            DATE_END => '2015-01-18'
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
            DATE_START => '2016-01-24',
            DATE_END => '2016-01-24'
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
            DATE_START => '2009-12-24',
            DATE_END => '2009-12-24'
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
            DATE_START => '2012-12-22',
            DATE_END => '2012-12-22'
          } 
        }
      },
    }
  },

  'Maharaja Yeshwantrao Holkar National Teams' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2009-12-24',
            DATE_END => '2009-12-24'
          } 
        }
      },
      '2010A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-09'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-17'
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
            DATE_START => '2012-01-05',
            DATE_END => '2012-01-06'
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
            DATE_START => '2013-01-10',
            DATE_END => '2013-01-11'
          } 
        }
      },
    }
  },

  'Maharashtra State Teams' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-25',
            DATE_END => '2012-02-27'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-20'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-02'
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
            DATE_START => '2016-06-25',
            DATE_END => '2016-06-25'
          } 
        }
      },
    }
  },

  'Maharashtra State Pairs' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Regional',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-27',
            DATE_END => '2012-02-28'
          } 
        }
      },
    }
  },

  'Mitra Vihar State Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
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
      '2009' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-23',
            DATE_END => '2009-12-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Maharashtra State Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-01-20',
            DATE_END => '2014-01-20'
          } 
        }
      },
    }
  },

  'Mohanlal Bhartia Memorial Grand Prix' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2010-02-05',
            DATE_END => '2010-02-07'
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
            DATE_START => '2011-02-10',
            DATE_END => '2011-02-13'
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
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-12'
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
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-07'
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
            DATE_START => '2014-03-14',
            DATE_END => '2014-03-16'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-03',
            DATE_END => '2015-04-05'
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
            DATE_START => '2016-03-11',
            DATE_END => '2016-03-13'
          } 
        }
      },
    }
  },

  'Poddar National Masters' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2010-08-16',
            DATE_END => '2010-08-17'
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
            DATE_START => '2011-08-05',
            DATE_END => '2011-08-07'
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
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-07'
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
            DATE_START => '2013-10-24',
            DATE_END => '2013-10-27'
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
            DATE_START => '2014-10-31',
            DATE_END => '2014-11-02'
          } 
        }
      },
    }
  },

  'Prashant Desai Memorial' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2016-03-26',
            DATE_END => '2016-03-27'
          } 
        }
      },
    }
  },

  'PYC Hindu Gymkhana Royale' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-02'
          } 
        }
      },
    }
  },

  'PYC Hindu Gymkhana Pairs Royale' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Rai Bahadur Modi Memorial All India Open' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
          } 
        }
      },
    }
  },

  'Rajasthan Invitational Pairs' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Invitational',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
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
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Invitational',
    ZONE => 'Asia Pacific',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-03',
            DATE_END => '2013-05-05'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Rajasthan Invitational Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-09'
          } 
        }
      },
    }
  },

  'R N Bagla Memorial Pairs' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-08-26',
            DATE_END => '2011-08-26'
          } 
        }
      },
    }
  },

  'R R Gupta Memorial Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2015-03-12',
            DATE_END => '2015-03-15'
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
            DATE_START => '2016-04-01',
            DATE_END => '2016-04-03'
          } 
        }
      },
    }
  },

  'R Ratnam Memorial' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-15',
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
          'SINGLE' => 
          {
            YEAR => 2004,
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
          'SINGLE' => 
          {
            DATE_START => '2005-12-31',
            DATE_END => '2006-01-06'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-20'
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
            DATE_START => '2010-12-15',
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
            DATE_START => '2011-12-06',
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
            DATE_START => '2012-12-19',
            DATE_END => '2012-12-21'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-18',
            DATE_END => '2014-12-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indian Winter Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-22'
          } 
        }
      },
    }
  },

  'Ruia Silver Cup' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2011-12-06',
            DATE_END => '2011-12-06'
          } 
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
            DATE_START => '2013-07-21',
            DATE_END => '2013-07-21'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
        MEET => 'Goa Bridge Festival',
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-07-25',
            DATE_END => '2015-07-26'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
        MEET => 'Goa Bridge Festival',
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-31'
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
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-15',
            DATE_END => '2011-03-16'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-19',
            DATE_END => '2012-06-19'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-18',
            DATE_END => '2013-02-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indian Summer Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-21',
            DATE_END => '2014-04-23'
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
            DATE_START => '2015-06-18',
            DATE_END => '2015-06-20'
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
            DATE_START => '2016-07-07',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'Tolani Grand Prix' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
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
            DATE_START => '2009-10-01',
            DATE_END => '2009-10-05'
          },
          'C1' => 
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
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-19',
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
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'Uttar Pradesh State Championship' =>
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            DATE_START => '2012-08-18',
            DATE_END => '2012-08-19'
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
