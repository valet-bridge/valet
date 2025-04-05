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
  'Challenge Match' =>
  {
    EDITIONS => 
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-05-30',
        DATE_END => '2007-05-30'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-06-08',
        DATE_END => '2010-06-08'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-05-18',
        DATE_END => '2013-05-18'
      },
      '2014A' =>
      {
        YEAR => 2014,
        DATE_START => '2014-05-18',
        DATE_END => '2014-05-18'
      },
      '2014B' =>
      {
        YEAR => 2014,
        DATE_START => '2014-11-02',
        DATE_END => '2014-11-02'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-11-02',
        DATE_END => '2015-11-02'
      },
    }
  },

  'Exhibition Match' =>
  {
    EDITIONS => 
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-11-29',
        DATE_END => '2004-11-29'
      },
      '2005A' =>
      {
        YEAR => 2005,
        DATE_START => '2005-02-17',
        DATE_END => '2005-02-17'
      },
      '2005B' =>
      {
        YEAR => 2005,
        DATE_START => '2005-05-22',
        DATE_END => '2005-05-22'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-08-19',
        DATE_END => '2007-08-19'
      },
    }
  },

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
      '2010D' =>
      {
        YEAR => 2010,
        DATE_START => '2010-11-27',
        DATE_END => '2010-11-27'
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
        DATE_START => '2013-06-25',
        DATE_END => '2013-06-25'
      },
      '2013F' =>
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
        DATE_START => '2014-05-24',
        DATE_END => '2014-05-25'
      },
      '2014G' =>
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
      '2015B' =>
      {
        YEAR => 2015,
        DATE_START => '2015-10-30',
        DATE_END => '2015-11-01'
      },
      '2015C' =>
      {
        YEAR => 2015,
        DATE_START => '2015-11-02',
        DATE_END => '2015-11-02'
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
  },

  'Friendly Pairs' =>
  {
    EDITIONS => 
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-05',
        DATE_END => '2007-06-05'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-05-27',
        DATE_END => '2010-05-27'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-02-13',
        DATE_END => '2015-02-15'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-07-16',
        DATE_END => '2016-07-17'
      },
    }
  },

  'Practice Match' =>
  {
    EDITIONS => 
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-05-09',
        DATE_END => '2004-05-10'
      },
      '2007A' =>
      {
        YEAR => 2007,
        DATE_START => '2007-01-24',
        DATE_END => '2007-01-24'
      },
      '2007B' =>
      {
        YEAR => 2007,
        DATE_START => '2007-02-22',
        DATE_END => '2007-02-22'
      },
      '2007C' =>
      {
        YEAR => 2007,
        DATE_START => '2007-03-05',
        DATE_END => '2007-03-06'
      },
      '2007D' =>
      {
        YEAR => 2007,
        DATE_START => '2007-04-15',
        DATE_END => '2007-04-15'
      },
      '2007E' =>
      {
        YEAR => 2007,
        DATE_START => '2007-04-16',
        DATE_END => '2007-04-16'
      },
      '2007F' =>
      {
        YEAR => 2007,
        DATE_START => '2007-05-05',
        DATE_END => '2007-05-06'
      },
      '2007G' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-01',
        DATE_END => '2007-06-01'
      },
      '2007H' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-03',
        DATE_END => '2007-06-03'
      },
      '2007I' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-05',
        DATE_END => '2007-06-05'
      },
      '2007J' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-07',
        DATE_END => '2007-06-07'
      },
      '2007K' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-08',
        DATE_END => '2007-06-08'
      },
      '2007L' =>
      {
        YEAR => 2007,
        DATE_START => '2007-06-09',
        DATE_END => '2007-06-09'
      },
      '2007M' =>
      {
        YEAR => 2007,
        DATE_START => '2007-09-02',
        DATE_END => '2007-09-02'
      },
      '2007N' =>
      {
        YEAR => 2007,
        DATE_START => '2007-11-05',
        DATE_END => '2007-11-05'
      },
      '2007O' =>
      {
        YEAR => 2007,
        DATE_START => '2007-12-10',
        DATE_END => '2007-12-10'
      },
      '2008A' =>
      {
        YEAR => 2008,
        DATE_START => '2008-04-16',
        DATE_END => '2008-04-16'
      },
      '2008B' => 
      {
        YEAR => 2008,
        DATE_START => '2008-05-04',
        DATE_END => '2008-05-04'
      },
      '2008C' =>
      {
        YEAR => 2008,
        DATE_START => '2008-09-27',
        DATE_END => '2008-09-27'
      },
      '2009A' =>
      {
        YEAR => 2009,
        DATE_START => '2009-02-22',
        DATE_END => '2009-02-22'
      },
      '2009B' =>
      {
        YEAR => 2009,
        DATE_START => '2009-05-13',
        DATE_END => '2009-05-13'
      },
      '2010A' =>
      {
        YEAR => 2010,
        DATE_START => '2010-03-03',
        DATE_END => '2010-03-03'
      },
      '2010B' =>
      {
        YEAR => 2010,
        DATE_START => '2010-05-20',
        DATE_END => '2010-05-22'
      },
      '2011A' =>
      {
        YEAR => 2011,
        DATE_START => '2011-05-26',
        DATE_END => '2011-05-29'
      },
      '2011B' =>
      {
        YEAR => 2011,
        DATE_START => '2011-08-23',
        DATE_END => '2011-08-23'
      },
      '2011C' =>
      {
        YEAR => 2011,
        DATE_START => '2011-09-02',
        DATE_END => '2011-09-03'
      },
      '2011D' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-02',
        DATE_END => '2011-10-02'
      },
      '2012A' =>
      {
        YEAR => 2012,
        DATE_START => '2012-03-03',
        DATE_END => '2012-03-03'
      },
      '2012B' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-06',
        DATE_END => '2012-04-07'
      },
      '2012C' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-20',
        DATE_END => '2012-04-21'
      },
      '2013A' =>
      {
        YEAR => 2013,
        DATE_START => '2013-01-19',
        DATE_END => '2013-01-20'
      },
      '2013B' =>
      {
        YEAR => 2013,
        DATE_START => '2013-01-27',
        DATE_END => '2013-01-27'
      },
      '2013C' =>
      {
        YEAR => 2013,
        DATE_START => '2013-06-07',
        DATE_END => '2013-06-09'
      },
      '2014A' =>
      {
        YEAR => 2014,
        DATE_START => '2014-01-18',
        DATE_END => '2014-01-19'
      },
      '2014B' =>
      {
        YEAR => 2014,
        DATE_START => '2014-05-16',
        DATE_END => '2014-05-18'
      },
      '2014C' =>
      {
        YEAR => 2014,
        DATE_START => '2014-06-08',
        DATE_END => '2014-06-08'
      },
      '2014D' =>
      {
        YEAR => 2014,
        DATE_START => '2014-07-08',
        DATE_END => '2014-07-08'
      },
      '2014E' =>
      {
        YEAR => 2014,
        DATE_START => '2014-11-28',
        DATE_END => '2014-11-30'
      },
      '2015A' =>
      {
        YEAR => 2015,
        DATE_START => '2015-02-21',
        DATE_END => '2015-02-22'
      },
      '2015B' =>
      {
        YEAR => 2015,
        DATE_START => '2015-05-16',
        DATE_END => '2015-05-17'
      },
      '2015C' =>
      {
        YEAR => 2015,
        DATE_START => '2015-06-03',
        DATE_END => '2015-06-03'
      },
      '2015D' =>
      {
        YEAR => 2015,
        DATE_START => '2015-06-05',
        DATE_END => '2015-06-07'
      },
      '2015E' =>
      {
        YEAR => 2015,
        DATE_START => '2015-06-13',
        DATE_END => '2015-06-14'
      },
      '2015F' =>
      {
        YEAR => 2015,
        DATE_START => '2015-06-27',
        DATE_END => '2015-06-28'
      },
      '2015G' =>
      {
        YEAR => 2015,
        DATE_START => '2015-09-05',
        DATE_END => '2015-09-06'
      },
      '2016A' =>
      {
        YEAR => 2016,
        DATE_START => '2016-03-26',
        DATE_END => '2016-03-27'
      },
      '2016B' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-16',
        DATE_END => '2016-04-17'
      },
      '2016C' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-19',
        DATE_END => '2016-04-21'
      },
      '2016D' =>
      {
        YEAR => 2016,
        DATE_START => '2016-05-14',
        DATE_END => '2016-05-15'
      },
      '2016E' =>
      {
        YEAR => 2016,
        DATE_START => '2016-05-19',
        DATE_END => '2016-05-19'
      },
      '2016F' =>
      {
        YEAR => 2016,
        DATE_START => '2016-05-20',
        DATE_END => '2016-05-22'
      },
      '2016G' =>
      {
        YEAR => 2016,
        DATE_START => '2016-05-28',
        DATE_END => '2016-05-28'
      },
      '2016H' =>
      {
        YEAR => 2016,
        DATE_START => '2016-08-18',
        DATE_END => '2016-08-20'
      },
      '2016I' =>
      {
        YEAR => 2016,
        DATE_START => '2016-11-08',
        DATE_END => '2016-11-08'
      },
      '2018A' =>
      {
        YEAR => 2018,
        DATE_START => '2018-05-11',
        DATE_END => '2018-05-13'
      },
      '2020A' =>
      {
        YEAR => 2020,
        DATE_START => '2020-08-04',
        DATE_END => '2020-08-04'
      },
      '2021A' =>
      {
        YEAR => 2021,
        DATE_START => '2021-08-04',
        DATE_END => '2021-08-04'
      },
      '2023A' =>
      {
        YEAR => 2023,
        DATE_START => '2023-08-09',
        DATE_END => '2023-08-09'
      },
    }
  },
);

my %TOURNAMENTS_FRIENDLY =
(
  'Argentina Friendly' => 
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'International',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2011A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-04-06',
            DATE_END => '2011-04-07'
          } 
        }
      },
    }
  },

  'Australia Challenge' => 
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Challenge Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SESSION',
            DATE_START => '2007-05-30',
            DATE_END => '2007-05-30'
          } 
        }
      },
    }
  },

  'Australia Friendly' => 
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-30',
            DATE_END => '2016-10-01'
          },
        }
      },
      '2017' =>
      {
        GENDER => 'Open',
        AGE => 'U21',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-11',
            DATE_END => '2017-12-12'
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
            DATE_START => '2018-10-05',
            DATE_END => '2018-10-06'
          },
        }
      },
    }
  },

  'Australia Practice' => 
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2013A',
        GENDER => 'Open',
        AGE => 'U21',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2014A',
        GENDER => 'Open',
        AGE => 'U21',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016G',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-28'
          } 
        }
      },
      '2017' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-06-18',
            DATE_END => '2017-06-18'
          } 
        }
      },
      '2019' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-03-16',
            DATE_END => '2019-03-16'
          } 
        }
      },
    }
  },

  'Bay Area Challenge' => 
  {
    ORGANIZATION => 'USBF',
    COUNTRY => 'USA',
    ORIGIN => 'University',
    ZONE => 'North America',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Challenge Match',
        MEET_TAG => '2014A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Challenge Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-11-02',
            DATE_END => '2015-11-02'
          } 
        }
      },
    }
  },

  'Brighton Exhibition' => 
  {
    ORGANIZATION => 'EBU',
    COUNTRY => 'England',
    CITY => 'Brighton',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Exhibition Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT|SET',
            DATE_START => '2007-08-19',
            DATE_END => '2007-08-19'
          } 
        }
      },
    }
  },

  'Canada Practice' => 
  {
    ORGANIZATION => 'CBF',
    COUNTRY => 'Canada',
    ORIGIN => 'International',
    ZONE => 'North America',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2015A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015F',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-06-27',
            DATE_END => '2015-06-28'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015F',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION|ROUND',
            DATE_START => '2015-06-27',
            DATE_END => '2015-06-28'
          } 
        }
      },
    }
  },

  'Chile Practice' => 
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2009B',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-13',
            DATE_END => '2009-05-13'
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
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2012H',
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
      '2023' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-06-25',
            DATE_END => '2023-06-25'
          } 
        }
      },
    }
  },

  'China Practice' => 
  {
    ORGANIZATION => 'CCBA',
    COUNTRY => 'China',
    ORIGIN => 'National',
    ZONE => 'South East Asia',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-18',
            DATE_END => '2016-10-19'
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
            DATE_START => '2018-11-22',
            DATE_END => '2018-11-24'
          },
        }
      },
      '2019A' =>
      {
        ORDINAL => 3,
        GENDER => 'Open',
        AGE => 'Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-15',
            DATE_END => '2019-10-15'
          },
        }
      },
      '2019B' =>
      {
        ORDINAL => 3,
        GENDER => 'Mixed',
        AGE => 'Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-15',
            DATE_END => '2019-10-15'
          },
        }
      },
    }
  },

  'Denmark Friendly' => 
  {
    ORGANIZATION => 'DBF',
    COUNTRY => 'Denmark',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2016A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Triangle',
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          } 
        }
      },
    }
  },

  'Denmark Practice' => 
  {
    ORGANIZATION => 'DBF',
    COUNTRY => 'Denmark',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2013B',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-01-27',
            DATE_END => '2013-01-27'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2014E',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-11-28',
            DATE_END => '2014-11-30'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-02-21',
            DATE_END => '2015-02-22'
          } 
        }
      },
      '2018' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-21'
          } 
        }
      },
      '2019A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-20',
            DATE_END => '2019-01-20'
          } 
        }
      },
      '2019B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-03-09',
            DATE_END => '2019-03-09'
          } 
        }
      },
      '2019C' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-31',
            DATE_END => '2019-09-01'
          } 
        }
      },
      '2020' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-22',
            DATE_END => '2020-02-23'
          } 
        }
      },
      '2023' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-02-25',
            DATE_END => '2023-02-26'
          } 
        }
      },
    }
  },

  'Denmark Practice Pairs' => 
  {
    ORGANIZATION => 'DBF',
    COUNTRY => 'Denmark',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2017' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-11',
            DATE_END => '2017-11-12'
          } 
        }
      },
      '2019' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-19',
            DATE_END => '2019-01-19'
          } 
        }
      },
      '2024' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-04-20',
            DATE_END => '2024-04-20'
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
        MEET_TAG => '2006A',
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
        MEET_TAG => '2007A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT|ROUND',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2010C',
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
        MEET_TAG => '2010C',
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
        MEET_TAG => '2012B',
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
        MEET_TAG => '2012E',
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
      '2015A' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2015B',
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
        MEET_TAG => '2015C',
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
        MEET_TAG => '2016E',
        GENDER => 'Open',
        AGE => 'U21',

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
      '2017A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-04-21',
            DATE_END => '2017-04-23'
          } 
        }
      },
      '2017B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-10',
            DATE_END => '2017-05-12'
          } 
        }
      },
      '2018' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-15',
            DATE_END => '2018-05-16'
          } 
        }
      },
      '2019' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-29',
            DATE_END => '2019-05-01'
          } 
        }
      },
      '2020' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-24',
            DATE_END => '2020-01-26'
          } 
        }
      },
      '2024A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-01-26',
            DATE_END => '2024-01-28'
          } 
        }
      },
      '2024B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-02',
            DATE_END => '2024-02-03'
          } 
        }
      },
    }
  },

  'France Friendly Pairs' => 
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Friendly Pairs',
        CLUB => 'BC Saint Honoré',
        CITY => 'Paris',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-27',
            DATE_END => '2010-05-27'
          } 
        }
      },
    }
  },

  'France Practice' => 
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007C',
        ORIGIN => 'Supranational',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2007-03-05',
            DATE_END => '2007-03-06'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007G',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-06-01',
            DATE_END => '2007-06-01'
          } 
        }
      },
      '2007C' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007H',
        ORIGIN => 'National',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-06-03',
            DATE_END => '2007-06-03'
          } 
        }
      },
      '2007D' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007J',
        ORIGIN => 'National',
        SPONSOR => 'Multicoms',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-06-07',
            DATE_END => '2007-06-07'
          } 
        }
      },
      '2007E' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007K',
        ORIGIN => 'National',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-06-08',
            DATE_END => '2007-06-08'
          } 
        }
      },
      '2007F' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007L',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-06-09',
            DATE_END => '2007-06-09'
          } 
        }
      },
      '2008A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2008A',
        ORIGIN => 'National',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'SEGMENT',
            DATE_START => '2008-04-16',
            DATE_END => '2008-04-16'
          } 
        }
      },
      '2008B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2008C',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015G',
        ORIGIN => 'National',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-06'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016A',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT',
            DATE_START => '2016-03-26',
            DATE_END => '2016-03-27'
          } 
        }
      },
      '2016B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016B',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-04-16',
            DATE_END => '2016-04-17'
          },
        }
      },
      '2016C' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016B',
        ORIGIN => 'National',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-04-16',
            DATE_END => '2016-04-17'
          },
        }
      },
      '2016D' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016F',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-20',
            DATE_END => '2016-05-22'
          } 
        }
      },
      '2016E' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016I',
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-11-08',
            DATE_END => '2016-11-08'
          } 
        }
      },
      '2017' =>
      {
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-11',
            DATE_END => '2017-06-11'
          } 
        }
      },
      '2023' =>
      {
        ORIGIN => 'National',
        GENDER => 'Open',
        AGE => 'Open',
        CITY => 'Royan',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-04-07',
            DATE_END => '2023-04-08'
          } 
        }
      },
    }
  },

  'Germany Friendly Pairs' => 
  {
    ORIGIN => 'National',
    COUNTRY => 'Germany',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Friendly Pairs',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-15'
          } 
        }
      },
    }
  },

  'Germany Practice' => 
  {
    ORIGIN => 'National',
    COUNTRY => 'Germany',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2023' =>
      {
        CITY => 'Rieneck',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-28',
            DATE_END => '2023-01-29'
          },
        }
      },
    }
  },

  'Goulash Practice' => 
  {
    ORIGIN => 'Transnational',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007N',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT|SET',
            MOVEMENT => 'Goulash',
            DATE_START => '2007-11-05',
            DATE_END => '2007-11-05'
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
      '2013A' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2013B',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-06-11',
            DATE_END => '2013-06-11'
          },
        }
      },
      '2013B' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2013C',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-06-18',
            DATE_END => '2013-06-18'
          },
        }
      },
      '2013C' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2013E',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-06-25',
            DATE_END => '2013-06-25'
          } 
        }
      },
    }
  },

  'Hungary Challenge' => 
  {
    ORGANIZATION => 'MBSZ',
    COUNTRY => 'Hungary',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Challenge Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-06-08',
            DATE_END => '2010-06-08'
          } 
        }
      },
    }
  },

  'Hungary Exhibition' => 
  {
    ORGANIZATION => 'MBSZ',
    COUNTRY => 'Hungary',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Exhibition Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-11-29',
            DATE_END => '2004-11-29'
          } 
        }
      },
    }
  },

  'Hungary Friendly' => 
  {
    ORGANIZATION => 'MBSZ',
    CITY => 'Budapest',
    COUNTRY => 'Hungary',
    CITY => 'Budapest',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2014C',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-04-18',
            DATE_END => '2014-04-20'
          } 
        }
      },
    }
  },

  'Hungary Practice' => 
  {
    ORGANIZATION => 'MBSZ',
    COUNTRY => 'Hungary',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2011B',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-08-23',
            DATE_END => '2011-08-23'
          } 
        }
      },
    }
  },

  'Iceland Exhibition' => 
  {
    ORGANIZATION => 'IceBF',
    COUNTRY => 'Iceland',
    ORIGIN => 'Supranational',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Exhibition Match',
        MEET_TAG => '2005A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-02-17',
            DATE_END => '2005-02-17'
          } 
        }
      },
    }
  },

  'Iceland Friendly' => 
  {
    ORGANIZATION => 'IceBF',
    COUNTRY => 'Iceland',
    ORIGIN => 'Supranational',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-30',
            DATE_END => '2023-01-31'
          },
        }
      },
    }
  },

  'India Exhibition' => 
  {
    ORGANIZATION => 'BFI',
    COUNTRY => 'India',
    ORIGIN => 'Supranational',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2023A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-08-06',
            DATE_END => '2023-08-06'
          },
        }
      },
      '2023B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-29',
            DATE_END => '2023-10-30'
          },
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
        MEET_TAG => '2011C',
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

  'Israel Friendly' =>
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2018' =>
      {
        GENDER => 'Open',
        AGE => 'U26',

        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-06-26',
            DATE_END => '2018-06-26'
          },
        }
      },
    }
  },

  'Israel Practice' => 
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-02-08',
            DATE_END => '2019-02-08'
          },
        }
      },
    }
  },

  'Italy Friendly' => 
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014A' =>
      {
        ORIGIN => 'International',
        MEET => 'Friendly Match',
        MEET_TAG => '2014C',
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
        ORIGIN => 'International',
        MEET => 'Friendly Match',
        MEET_TAG => '2014G',
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
        ORIGIN => 'Transnational',
        MEET => 'Friendly Match',
        MEET_TAG => '2015A',
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

  'Italy Practice' => 
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2014C',
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
    }
  },

  'Morocco Friendly' => 
  {
    ORGANIZATION => 'FRM',
    COUNTRY => 'Morocco',
    ORIGIN => 'National',
    ZONE => 'African Zone',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2014B',
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
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SEGMENT|SET',
            DATE_START => '2005-09-01',
            DATE_END => '2005-09-01'
          } 
        }
      },
      '2006A' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2006C',
        GENDER => 'Men',
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
      '2006B' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2006C',
        GENDER => 'Women',
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
        MEET_TAG => '2007B',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'U21',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT|SESSION',
            DATE_START => '2007-06-02',
            DATE_END => '2007-06-05'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2007C',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2008A',
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
        MEET_TAG => '2009A',
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
        MEET_TAG => '2010A',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2010B',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2011A',
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
        MEET_TAG => '2011A',
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
        MEET_TAG => '2011B',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2011D',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2012C',
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
        MEET_TAG => '2012D',
        CLUB => "'t Onstein",
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
        MEET_TAG => '2016A',
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
        MEET_TAG => '2016C',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT|SESSION|ROUND',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-27'
          } 
        }
      },
      '2016C' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2016C',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really same time, but easier to separate like this.
            YEAR => 2016,
            major => 'SEGMENT',
            DATE_START => '2016-03-28',
            DATE_END => '2016-03-28'
          } 
        }
      },
      '2016D' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2016D',
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
        MEET_TAG => '2016D',
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
      '2017A' =>
      {
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-17',
            DATE_END => '2017-03-18'
          } 
        }
      },
      '2017B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-11',
            DATE_END => '2017-10-13'
          } 
        }
      },
      '2018A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-04',
            DATE_END => '2018-04-06'
          } 
        }
      },
      '2018B' =>
      {
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-20',
            DATE_END => '2018-04-22'
          } 
        }
      },
      '2018C' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-09',
            DATE_END => '2018-05-09'
          } 
        }
      },
      '2019A' =>
      {
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-02-22',
            DATE_END => '2019-02-24'
          } 
        }
      },
      '2019B' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-12',
            DATE_END => '2019-04-12'
          } 
        }
      },
      '2019C' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-19',
            DATE_END => '2019-04-21'
          } 
        }
      },
      '2019D' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-10',
            DATE_END => '2019-05-12'
          } 
        }
      },
      '2019E' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-17',
            DATE_END => '2019-05-19'
          } 
        }
      },
      '2023' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-26',
            DATE_END => '2023-05-27'
          } 
        }
      },
    }
  },

  'Netherlands Friendly Pairs' => 
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Friendly Pairs',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          } 
        }
      },
    }
  },

  'Netherlands Practice' => 
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007A' =>
      {
        MEET => 'Practice Match',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'Practice Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-02-22',
            DATE_END => '2007-02-22'
          } 
        }
      },
      '2007C' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007E',
        CLUB => "'t Onstein",
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
      '2007D' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007F',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT|ROUND',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          } 
        }
      },
      '2007E' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007M',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'U21',

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
      '2007F' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007O',
        CLUB => "'t Onstein",
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-12-10',
            DATE_END => '2007-12-10'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2008B',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2010B',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-05-20',
            DATE_END => '2010-05-22'
          } 
        }
      },
      '2011A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2011C',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-02',
            DATE_END => '2011-09-03'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2011D',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-10-02',
            DATE_END => '2011-10-02'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2012C',
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-04-20',
            DATE_END => '2012-04-21'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2013C',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'TABLE',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-09'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2014B',
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
      '2015A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015B',
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-17'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015D',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-06-05',
            DATE_END => '2015-06-07'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016E',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-05-19',
            DATE_END => '2016-05-19'
          } 
        }
      },
      '2017A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-19',
            DATE_END => '2017-03-19'
          } 
        }
      },
      '2017B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-12',
            DATE_END => '2017-05-14'
          } 
        }
      },
      '2017C' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-09',
            DATE_END => '2017-06-11'
          } 
        }
      },
      '2017D' =>
      {
        GENDER => 'Open',
        AGE => 'U26',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-04',
            DATE_END => '2017-07-04'
          } 
        }
      },
      '2018A' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-14',
            DATE_END => '2018-10-18'
          } 
        }
      },
      '2018B' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Women',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-30',
            DATE_END => '2018-12-02'
          } 
        }
      },
      '2019A' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-18',
            DATE_END => '2019-01-20'
          } 
        }
      },
      '2019B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-05',
            DATE_END => '2019-04-05'
          } 
        }
      },
      '2019C' =>
      {
        CLUB => "'t Onstein",
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-12',
            DATE_END => '2019-04-14'
          } 
        }
      },
      '2024A' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-04-20',
            DATE_END => '2024-04-20'
          } 
        }
      },
      '2024B' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-17',
            DATE_END => '2024-05-19'
          } 
        }
      },
    }
  },

  'Norway Practice' => 
  {
    ORGANIZATION => 'NBF',
    COUNTRY => 'Norway',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2011A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-05-26',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2012A',
        CITY => 'Namsos',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'HALF',
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-03'
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
        MEET_TAG => '2013F',
        SPONSOR => 'Bridge Winners',
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
    ORGANIZATION => 'PZBS',
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
        MEET_TAG => '2006B',
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
        MEET_TAG => '2012A',
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
        MEET_TAG => '2013A',
        GENDER => 'Open',
        AGE => 'U26',

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
      '2018' =>
      {
        GENDER => 'Women',
        AGE => 'U26',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-14',
            DATE_END => '2018-04-15'
          } 
        }
      },
    }
  },

  'Poland Mixed Friendly Pairs' => 
  {
    ORGANIZATION => 'PZBS',
    ORIGIN => 'National',
    COUNTRY => 'Poland',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Friendly Pairs',
        GENDER => 'Mixed',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT',
            DATE_START => '2016-07-16',
            DATE_END => '2016-07-17'
          } 
        }
      },
    }
  },

  'Poland Practice' => 
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Practice Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SESSION',
            DATE_START => '2004-05-09',
            DATE_END => '2004-05-10'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2014D',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-07-08',
            DATE_END => '2014-07-08'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015C',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-03'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016H',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND|MATCH',
            DATE_START => '2016-08-18',
            DATE_END => '2016-08-19'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-20',
            DATE_END => '2016-08-20'
          } 
        }
      },
      '2017' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-24',
            DATE_END => '2017-05-24'
          },
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
        MEET_TAG => '2014F',
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

  'Portugal Practice' => 
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2015E',
        GENDER => 'Open',
        AGE => 'Open',

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
    }
  },

  'Russia Practice' =>
  {
    ORGANIZATION => 'RBL',
    COUNTRY => 'Russia',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2020A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-08-04',
            DATE_END => '2020-08-04'
          },
        }
      },
      '2021' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2021A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            DATE_START => '2021-08-04',
            DATE_END => '2021-08-04'
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
            DATE_START => '2022-08-03',
            DATE_END => '2022-08-03'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2023A',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-09',
            DATE_END => '2023-08-09'
          },
        }
      },
    }
  },

  'Scotland Exhibition' => 
  {
    ORGANIZATION => 'SBU',
    COUNTRY => 'Scotland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Exhibition Match',
        MEET_TAG => '2005B',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            DATE_START => '2005-05-22',
            DATE_END => '2005-05-22'
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
        MEET_TAG => '2010D',
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

  'Scotland Practice' => 
  {
    ORGANIZATION => 'SBU',
    COUNTRY => 'Scotland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2009A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-02-22',
            DATE_END => '2009-02-22'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2010A',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-03-03',
            DATE_END => '2010-03-03'
          } 
        }
      },
    }
  },

  'Spain Challenge' => 
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Challenge Match',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-05-18',
            DATE_END => '2013-05-18'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Challenge Match',
        MEET_TAG => '2014B',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-11-02',
            DATE_END => '2014-11-02'
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
        MEET_TAG => '2014E',
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
      '2016' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-02',
            DATE_END => '2016-01-03'
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
        MEET_TAG => '2011E',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Knock-out',
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
        MEET_TAG => '2012F',
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
        MEET_TAG => '2014D',
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
      '2017A' =>
      {
        GENDER => 'Open',
        AGE => 'U26',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-20',
            DATE_END => '2017-05-21'
          } 
        }
      },
      '2017B' =>
      {
        GENDER => 'Open',
        AGE => 'U21',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-25',
            DATE_END => '2017-11-26'
          } 
        }
      },
    }
  },

  'Sweden Practice' => 
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2012B',
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
      '2017' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-04',
            DATE_END => '2017-11-05'
          } 
        }
      },
      '2022' =>
      {
        GENDER => 'Open',
        AGE => 'U26',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-19',
            DATE_END => '2022-03-19'
          } 
        }
      },
      '2023' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-04-01',
            DATE_END => '2023-04-02'
          } 
        }
      },
    }
  },

  'Taiwan Practice' => 
  {
    ORGANIZATION => 'CTCBA',
    COUNTRY => 'Taiwan',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2007D',
        GENDER => 'Open',
        AGE => 'U25',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-04-15',
            DATE_END => '2007-04-15'
          },
        }
      },
    }
  },

  'Tunisia Friendly' => 
  {
    ORGANIZATION => 'SBF',
    CITY => 'Hammamet',
    COUNTRY => 'Tunisia',
    ORIGIN => 'National',
    ZONE => 'African Zone',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Friendly Match',
        MEET_TAG => '2013D',
        GENDER => 'Open',
        AGE => 'Open',

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

  'Turkey Friendly' => 
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2018' =>
      {
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-11',
            DATE_END => '2018-05-13'
          },
        }
      },
    }
  },

  'Turkey Practice' => 
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'Turkey',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2016A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016C',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-04-19',
            DATE_END => '2016-04-21'
          },
        }
      },
      '2016B' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2016D',
        GENDER => 'Open',
        AGE => 'Open',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-05-14',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2018A' =>
      {
        MEET => 'Practice Match',
        MEET_TAG => '2018A',
        GENDER => 'Open',
        AGE => 'Seniors',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-11',
            DATE_END => '2018-05-13'
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
        MEET_TAG => '2016B',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT',
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
