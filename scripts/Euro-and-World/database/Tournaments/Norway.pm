#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Norway;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_NORWAY =
(
  'Norwegian Bridge Festival' =>
  {
    # https://bridgefestival.no/resultater

    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-07-30',
        DATE_END => '2011-08-06'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-08-05',
        DATE_END => '2012-08-09'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-08-04',
        DATE_END => '2013-08-12'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-08-03',
        DATE_END => '2014-08-10'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-07-30',
        DATE_END => '2016-08-04'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-08-02',
        DATE_END => '2017-08-13'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-08-03',
        DATE_END => '2018-08-11'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-08-04',
        DATE_END => '2019-08-10'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-08-03',
        DATE_END => '2020-08-08'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-08-02',
        DATE_END => '2021-08-07'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-08-07',
        DATE_END => '2022-08-13'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-08-06',
        DATE_END => '2023-08-12'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-08-02',
        DATE_END => '2024-08-12'
      },
    }
  }
);

my %TOURNAMENTS_NORWAY =
(
  'Norwegian Championship' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Norwegian District Championship' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
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

  'Norwegian Club Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-01'
          } 
        }
      },
    }
  },

  'Norwegian Club Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-05-20',
            DATE_END => '2004-05-23'
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
            DATE_START => '2005-05-05',
            DATE_END => '2005-05-07'
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
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
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
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
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
            DATE_START => '2009-05-20',
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
            DATE_START => '2010-05-13',
            DATE_END => '2010-05-16'
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
            DATE_START => '2011-04-08',
            DATE_END => '2011-04-08'
          },
          'C1' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-02',
            DATE_END => '2011-06-05'
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
            DATE_START => '2012-05-25',
            DATE_END => '2012-05-28'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/1611/2013-05-09-11.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-09',
            DATE_END => '2013-05-11'
          } 
        }
      },
      '2014' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/nmlag2014.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-28',
            DATE_END => '2014-05-31'
          } 
        }
      },
      '2016' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/finalenmklubblag2016.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-06-02',
            DATE_END => '2016-06-05'
          } 
        }
      },
    }
  },

  'Norwegian Corporate Championship' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Corporate',
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
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'Norwegian Mixed Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-02',
            DATE_END => '2009-08-03'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-07-31',
            DATE_END => '2010-08-01'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-30',
            DATE_END => '2011-07-30'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-04',
            DATE_END => '2012-08-05'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-02',
            DATE_END => '2014-08-03'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-29',
            DATE_END => '2016-07-30'
          } 
        }
      },
    }
  },

  'Norwegian Mixed Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-03',
            DATE_END => '2014-08-04'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-31',
            DATE_END => '2016-08-01'
          } 
        }
      },
    }
  },

  'Norwegian Open Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-05',
            DATE_END => '2009-08-07'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-03',
            DATE_END => '2010-08-05'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-02',
            DATE_END => '2011-08-04'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-07',
            DATE_END => '2012-08-09'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-06',
            DATE_END => '2013-08-08'
          } 
        }
      },
      '2014A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-09'
          } 
        }
      },
      '2014B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-21'
          } 
        }
      },
      '2015' =>
      {
        # No festival in 2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-18',
            DATE_END => '2015-09-20'
          } 
        }
      },
    }
  },

  'Norwegian Open Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Just a guess
            YEAR => 2006,
            DATE_START => '2006-08-06',
            DATE_END => '2006-08-06'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-06',
            DATE_END => '2014-08-08'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-01',
            DATE_END => '2016-08-04'
          } 
        }
      },
    }
  },

  'Norwegian Premier League' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004-05' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            DATE_START => '2004-11-13',
            DATE_END => '2004-11-13'
          },
          'C1' => 
          {
            YEAR => 2005,
            DATE_START => '2005-02-05',
            DATE_END => '2005-02-06'
          },
          'C2' => 
          {
            YEAR => 2005,
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-27'
          }
        }
      },
      '2005-06' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            DATE_START => '2005-11-14',
            DATE_END => '2005-11-14'
          },
          'C1' => 
          {
            YEAR => 2006,
            DATE_START => '2006-02-07',
            DATE_END => '2006-02-07'
          },
        }
      },
      '2006-07' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
          'C1' => 
          {
            YEAR => 2007,
            DATE_START => '2007-02-11',
            DATE_END => '2007-02-11'
          },
          'C2' => 
          {
            YEAR => 2007,
            DATE_START => '2007-03-27',
            DATE_END => '2007-03-27'
          } 
        }
      },
      '2007-08' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
          'C1' => 
          {
            YEAR => 2008,
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          } 
        }
      },
      '2008-09' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          },
          'C1' => 
          {
            YEAR => 2009,
            DATE_START => '2009-02-13',
            DATE_END => '2009-02-15'
          } 
        }
      },
      '2009-10' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-10-23',
            DATE_END => '2009-10-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-07',
            DATE_END => '2010-01-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-12',
            DATE_END => '2010-02-14'
          } 
        }
      },
      '2010-11' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-22',
            DATE_END => '2010-10-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C2' => 
          {
            YEAR => 2011,
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-13'
          },
          'C3' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-27',
            DATE_END => '2011-03-27'
          } 
        }
      },
      '2011-12' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2011-12
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-04',
            DATE_END => '2011-11-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          } 
        }
      },
      '2012-13' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2012-13
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-11-02',
            DATE_END => '2012-11-04'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-09',
            DATE_END => '2013-02-10'
          } 
        }
      },
      '2013-14' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2013-14
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-03'
          },
          'C1' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-08',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2014-15' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2014-15
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-07',
            DATE_END => '2014-11-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-07',
            DATE_END => '2015-02-08'
          } 
        }
      },
      '2015-16' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2015-16
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-02-06',
            DATE_END => '2016-02-07'
          } 
        }
      },

      # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar
    }
  },

  'Norwegian Premier Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Norwegian Senior Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-06',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'Norwegian Swiss Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    MOVEMENT => 'Swiss',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-03',
            DATE_END => '2009-08-04'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-01',
            DATE_END => '2010-08-02'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-31',
            DATE_END => '2011-08-01'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-05',
            DATE_END => '2012-08-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/2013monradpar.htm
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-05'
          } 
        }
      },
    }
  },

  'Norwegian Swiss Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    MOVEMENT => 'Swiss',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-08-05',
            DATE_END => '2007-08-05'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Norwegian Bridge Festival',
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
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-08',
            DATE_END => '2009-08-09'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-05',
            DATE_END => '2010-08-07'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-05',
            DATE_END => '2011-08-06'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-10',
            DATE_END => '2012-08-11'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-10'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-06'
          } 
        }
      },
    }
  },

  'Norwegian Team Trials' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-06-08',
            DATE_END => '2004-06-08'
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
            DATE_START => '2016-05-07',
            DATE_END => '2016-05-08'
          } 
        }
      },
    }
  },

  'Norwegian Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Norwegian Women Invitational Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
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
            DATE_END => '2009-10-31'
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
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-30'
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
            DATE_START => '2011-10-29',
            DATE_END => '2011-10-29'
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
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-27'
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
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-26'
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
            DATE_START => '2014-10-25',
            DATE_END => '2014-10-25'
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
            DATE_START => '2015-10-31',
            DATE_END => '2015-10-31'
          } 
        }
      },
    }
  },

  'Norwegian Women Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2014-03-08',
            DATE_END => '2014-03-09'
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
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-26'
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
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },


  'Olrud Easter Mixed Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          } 
        }
      },
    }
  },

  'Olrud Easter Swiss Pairs' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    FORM => 'Pairs',
    MOVEMENT => 'Swiss',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
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
            DATE_START => '2009-04-04',
            DATE_END => '2009-04-05'
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
            DATE_START => '2010-03-27',
            DATE_END => '2010-03-28'
          } 
        }
      },
    }
  },

  'Olrud Easter Swiss Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2005-03-25',
            DATE_END => '2005-03-25'
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
            DATE_START => '2006-04-10',
            DATE_END => '2006-04-11'
          } 
        }
      },
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
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
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
            DATE_START => '2009-04-06',
            DATE_END => '2009-04-07'
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
            DATE_START => '2010-03-29',
            DATE_END => '2010-03-30'
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
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-18'
          } 
        }
      },
      '2012' =>
      {
        # https://www.bridge.no/var/ruter/html/0124/2012-04-02.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-04-01',
            DATE_END => '2012-04-02'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0124/2013-03-24.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-25'
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
            DATE_START => '2014-04-13',
            DATE_END => '2014-04-14'
          } 
        }
      },
    }
  },

  'Rondane Pairs Cup' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-09',
            DATE_END => '2010-10-09'
          } 
        }
      },
      '2011' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-08'
          } 
        }
      },
      '2012' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-06',
            DATE_END => '2012-10-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2013.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-05'
          } 
        }
      },
      '2014' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-04'
          } 
        }
      },
    }
  },

  'Rondane Teams Cup' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-10',
            DATE_END => '2010-10-10'
          } 
        }
      },
      '2011' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-09'
          } 
        }
      },
      '2012' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2012.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-07',
            DATE_END => '2012-10-07'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2013lag.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          } 
        }
      },
      '2014' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-10-05',
            DATE_END => '2014-10-05'
          } 
        }
      },
    }
  },

  'Rosfjord Swiss Teams' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
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
            DATE_START => '2012-04-05',
            DATE_END => '2012-04-05'
          } 
        }
      },
    }
  },

  'Trondheim Pairs Cup' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            CITY => 'Trondheim',
            DATE_START => '2011-05-07',
            DATE_END => '2011-05-07'
          } 
        }
      },
    }
  },

  'Trondheim Teams Cup' =>
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            CITY => 'Trondheim',
            DATE_START => '2011-05-08',
            DATE_END => '2011-05-08'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_NORWAY, \%TOURNAMENTS_NORWAY, 'Norway');
}

1;
