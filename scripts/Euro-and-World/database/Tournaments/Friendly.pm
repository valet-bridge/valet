#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Friendly;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_FRIENDLY =
(
  'Friendly Match' =>
  {
    EDITIONS => 
    {
      '2005A' =>
      {
        YEAR => 2005,
        DATE_START => '2005-03-20',
        DATE_END => '2005-03-20'
      },
      '2005B' =>
      {
        YEAR => 2005,
        DATE_START => '2005-06-13',
        DATE_END => '2005-06-13'
      },
      '2005C' =>
      {
        YEAR => 2005,
        DATE_START => '2005-09-01',
        DATE_END => '2005-09-01'
      },
      '2006A' =>
      {
        YEAR => 2006,
        DATE_START => '2006-04-23',
        DATE_END => '2006-04-23'
      },
      '2006B' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-06',
        DATE_END => '2006-05-08'
      },
      '2006C' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-14',
        DATE_END => '2006-05-14'
      },
      '2007A' =>
      {
        YEAR => 2007,
        DATE_START => '2007-05-15',
        DATE_END => '2007-05-15'
      },
      '2007B' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-02',
        DATE_END => '2007-06-05'
      },
      '2007C' =>
      {
        YEAR => 2007,
        DATE_START => '2007-09-02',
        DATE_END => '2007-09-02'
      },
      '2008A' =>
      {
        YEAR => 2008,
        DATE_START => '2008-06-21',
        DATE_END => '2008-06-21'
      },
      '2009A' =>
      {
        YEAR => 2009,
        DATE_START => '2009-05-22',
        DATE_END => '2009-05-24'
      },
      '2010A' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-09',
        DATE_END => '2010-04-11'
      },
      '2010B' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-23',
        DATE_END => '2010-04-25'
      },
      '2010C' =>
      {
        YEAR => 2010,
        DATE_START => '2010-06-04',
        DATE_END => '2010-06-05'
      },
      '2011A' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-06',
        DATE_END => '2011-04-07'
      },
      '2011B' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-08',
        DATE_END => '2011-04-10'
      },
      '2011C' =>
      {
        YEAR => 2011,
        DATE_START => '2011-05-14',
        DATE_END => '2011-05-14'
      },
      '2011D' =>
      {
        YEAR => 2011,
        DATE_START => '2011-05-20',
        DATE_END => '2011-05-22'
      },
      '2011E' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-08',
        DATE_END => '2011-10-09'
      },
      '2012A' =>
      {
        YEAR => 2012,
        DATE_START => '2012-02-11',
        DATE_END => '2012-02-11'
      },
      '2012B' =>
      {
        YEAR => 2012,
        DATE_START => '2012-02-24',
        DATE_END => '2012-02-26'
      },
      '2012C' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-06',
        DATE_END => '2012-04-07'
      },
      '2012D' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-20',
        DATE_END => '2012-04-22'
      },
      '2012E' =>
      {
        YEAR => 2012,
        DATE_START => '2012-05-03',
        DATE_END => '2012-05-04'
      },
      '2012F' =>
      {
        YEAR => 2012,
        DATE_START => '2012-06-01',
        DATE_END => '2012-06-01'
      },
      '2012G' =>
      {
        YEAR => 2012,
        DATE_START => '2012-06-05',
        DATE_END => '2012-06-05'
      },
      '2012H' =>
      {
        YEAR => 2012,
        DATE_START => '2012-09-12',
        DATE_END => '2012-09-13'
      },
      '2013A' =>
      {
        YEAR => 2013,
        DATE_START => '2013-05-24',
        DATE_END => '2013-05-24'
      },
      '2013B' =>
      {
        YEAR => 2013,
        DATE_START => '2013-06-11',
        DATE_END => '2013-06-11'
      },
      '2013C' =>
      {
        YEAR => 2013,
        DATE_START => '2013-06-18',
        DATE_END => '2013-06-18'
      },
      '2013D' =>
      {
        YEAR => 2013,
        DATE_START => '2013-06-22',
        DATE_END => '2013-06-25'
      },
      '2013E' =>
      {
        YEAR => 2013,
        DATE_START => '2013-10-06',
        DATE_END => '2013-10-06'
      },
      '2014A' =>
      {
        YEAR => 2014,
        DATE_START => '2014-02-14',
        DATE_END => '2014-02-15'
      },
      '2014B' =>
      {
        YEAR => 2014,
        DATE_START => '2014-03-27',
        DATE_END => '2014-03-29'
      },
      '2014C' =>
      {
        YEAR => 2014,
        DATE_START => '2014-04-18',
        DATE_END => '2014-04-20'
      },
      '2014D' =>
      {
        YEAR => 2014,
        DATE_START => '2014-05-10',
        DATE_END => '2014-05-11'
      },
      '2014E' =>
      {
        YEAR => 2014,
        DATE_START => '2014-05-16',
        DATE_END => '2014-05-18'
      },
      '2014F' =>
      {
        YEAR => 2014,
        DATE_START => '2014-06-08',
        DATE_END => '2014-06-08'
      },
      '2015A' =>
      {
        YEAR => 2015,
        DATE_START => '2015-10-18',
        DATE_END => '2015-10-18'
      },
      '2016A' =>
      {
        YEAR => 2016,
        DATE_START => '2016-02-19',
        DATE_END => '2016-02-21'
      },
      '2016B' =>
      {
        YEAR => 2016,
        DATE_START => '2016-03-03',
        DATE_END => '2016-03-03'
      },
      '2016C' =>
      {
        YEAR => 2016,
        DATE_START => '2016-03-25',
        DATE_END => '2016-03-28'
      },
      '2016D' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-17',
        DATE_END => '2016-04-18'
      },
      '2016E' =>
      {
        YEAR => 2016,
        DATE_START => '2016-07-01',
        DATE_END => '2016-07-03'
      },
    }
  }
);

my %TOURNAMENTS_FRIENDLY =
(
  'Argentina Friendly' => 
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-04-06',
            DATE_END => '2011-04-07'
          } 
        }
      },
    }
  },

  'China Friendly' => 
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-09-12',
            DATE_END => '2012-09-13'
          } 
        }
      },
    }
  },

  'France Friendly' => 
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-04-23',
            DATE_END => '2006-04-23'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-06-04',
            DATE_END => '2010-06-04'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Actually also 2010-06-04, but simplest way to separate.
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-06-05',
            DATE_END => '2010-06-05'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-02-24',
            DATE_END => '2012-02-26'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-03',
            DATE_END => '2012-05-04'
          } 
        }
      },
      '2012C' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-05',
            DATE_END => '2012-06-05'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-10-30',
            DATE_END => '2015-11-01'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really same time, but easiest way to separate.
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-11-02',
            DATE_END => '2015-11-02'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Youngsters',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-07-01',
            DATE_END => '2016-07-03'
          } 
        }
      },
    }
  },

  'Hong Kong Friendly' => 
  {
    ORGANIZATION => 'HKCBA',
    COUNTRY => 'Hong Kong',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-11',
            DATE_END => '2013-06-11'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-18',
            DATE_END => '2013-06-18'
          },
          'C2' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-25',
            DATE_END => '2013-06-25'
          } 
        }
      },
    }
  },

  'Hungary Friendly' => 
  {
    ORGANIZATION => 'MBSZ',
    COUNTRY => 'Hungary',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-18',
            DATE_END => '2014-04-18'
          } 
        }
      },
    }
  },

  'Ireland Friendly' => 
  {
    ORGANIZATION => 'IBU',
    COUNTRY => 'Ireland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-14'
          } 
        }
      },
    }
  },

  'Italy Friendly' => 
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-18',
            DATE_END => '2014-04-20'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-06-08',
            DATE_END => '2014-06-08'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-10-18',
            DATE_END => '2015-10-18'
          } 
        }
      },
    }
  },

  'Morocco Friendly' => 
  {
    ORGANIZATION => 'FRM',
    COUNTRY => 'Morocco',
    ORIGIN => 'National',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',
        CITY => 'Hammamet',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-03-27',
            DATE_END => '2014-03-29'
          } 
        }
      },
    }
  },

  'Netherlands Friendly' => 
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2005A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            DATE_START => '2005-03-20',
            DATE_END => '2005-03-20'
          } 
        }
      },
      '2005B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            DATE_START => '2005-06-13',
            DATE_END => '2005-06-13'
          } 
        }
      },
      '2005C' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SET',
            DATE_START => '2005-09-01',
            DATE_END => '2005-09-01'
          } 
        }
      },
      '2006A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-05-14',
            DATE_END => '2006-05-14'
          } 
        }
      },
      '2007A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-06-02',
            DATE_END => '2007-06-05'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          } 
        }
      },
      '2008A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-06-21',
            DATE_END => '2008-06-21'
          } 
        }
      },
      '2009A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-05-22',
            DATE_END => '2009-05-24'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-04-09',
            DATE_END => '2010-04-11'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2010-04-23',
            DATE_END => '2010-04-25'
          } 
        }
      },
      '2011A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really simultaneous
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-06',
            DATE_END => '2011-04-06'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-07',
            DATE_END => '2011-04-07'
          } 
        }
      },
      '2011C' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-08',
            DATE_END => '2011-04-10'
          } 
        }
      },
      '2011D' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-20',
            DATE_END => '2011-05-22'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-07'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-04-20',
            DATE_END => '2012-04-22'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-15'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

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
      '2016B' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-27'
          } 
        }
      },
      '2016C' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really same time, but easier to separate like this.
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-03-28',
            DATE_END => '2016-03-28'
          } 
        }
      },
      '2016D' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-04-17',
            DATE_END => '2016-04-17'
          } 
        }
      },
      '2016E' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really same time
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-04-18',
            DATE_END => '2016-04-18'
          } 
        }
      },
    }
  },

  'Online Friendly' => 
  {
    ORGANIZATION => 'BrBaOn',
    ORIGIN => 'Transnational',
    ZONE => 'World',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT',
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          } 
        }
      },
    }
  },

  'Poland Friendly' => 
  {
    ORGANIZATION => 'PYBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-05-06',
            DATE_END => '2006-05-08'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-11'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Juniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT',
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-24'
          } 
        }
      },
    }
  },

  'Portugal Friendly' => 
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-24',
            DATE_END => '2014-05-25'
          } 
        }
      },
    }
  },

  'Scotland Friendly' => 
  {
    ORGANIZATION => 'SBU',
    COUNTRY => 'Scotland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-27'
          } 
        }
      },
    }
  },

  'Spain Friendly' => 
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-16',
            DATE_END => '2014-05-18'
          } 
        }
      },
    }
  },

  'Sweden Friendly' => 
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-01',
            DATE_END => '2012-06-01'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-05-10',
            DATE_END => '2014-05-11'
          } 
        }
      },
    }
  },

  'Tunisia Friendly' => 
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Tunisia',
    ORIGIN => 'National',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Friendly Match',
        GENDER => 'Open',
        AGE => 'Open',
        CITY => 'Hammamet',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-06-22',
            DATE_END => '2013-06-25'
          } 
        }
      },
    }
  },

  'Zulawski Friendly' => 
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
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
        MEET => 'Friendly Match',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-03',
            DATE_END => '2016-03-03'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_FRIENDLY, \%TOURNAMENTS_FRIENDLY, 'Friendly');
}

1;
