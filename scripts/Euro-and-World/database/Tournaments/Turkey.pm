#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Turkey;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Surely there is more structure here than I have discovered.

my %GLOBAL = (
  ORGANIZATION => 'TBF',
  COUNTRY => 'Turkey',
  ZONE => 'Europe',
);

my %MEETS_TURKEY =
(
  'Assael Festival' =>
  {
    ORGANIZATION => 'TBF',
    COUNTRY => 'Turkey',
    ZONE => 'Europe',
    CITY => 'Cesme',

    EDITIONS => 
    {
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-05-20',
        DATE_END => '2012-05-20'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-06-02',
        DATE_END => '2013-06-03'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-06-03',
        DATE_END => '2014-06-08'
      },
      '2016' =>
      {
        MEET_ORDINAL => 4,
        YEAR => 2016,
        DATE_START => '2016-09-24',
        DATE_END => '2016-09-25'
      },
    }
  },

  'Cappadocia Fairy Chimneys Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    REGION => 'Cappadocia',

    EDITIONS => 
    {
      '2009' =>
      {
        ORDINAL => 3,
        YEAR => 2009,
        DATE_START => '2009-10-24',
        DATE_END => '2009-10-24'
      },
      '2010' =>
      {
        ORDINAL => 4,
        YEAR => 2010,
        DATE_START => '2010-10-23',
        DATE_END => '2010-10-24'
      },
      '2011' =>
      {
        ORDINAL => 5,
        YEAR => 2011,
        DATE_START => '2011-11-19',
        DATE_END => '2011-11-19'
      },
      '2012' =>
      {
        ORDINAL => 6,
        YEAR => 2012,
        DATE_START => '2012-11-03',
        DATE_END => '2012-11-03'
      },
    }
  },

  'Bodrum Peninsula Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Bodrum',

    EDITIONS => 
    {
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-07-25',
        DATE_END => '2014-07-25'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-26',
        DATE_END => '2019-09-27'
      },
    }
  },

  'Merit Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2018A' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2018,
        DATE_START => '2018-04-09',
        DATE_END => '2018-04-12'
      },
      '2018B' =>
      {
        MEET_ORDINAL => 4,
        YEAR => 2018,
        DATE_START => '2018-09-03',
        DATE_END => '2018-09-06'
      },
      '2019A' =>
      {
        MEET_ORDINAL => 5,
        YEAR => 2019,
        DATE_START => '2019-04-15',
        DATE_END => '2019-04-18'
      },
      '2019B' =>
      {
        MEET_ORDINAL => 6,
        YEAR => 2019,
        DATE_START => '2019-10-07',
        DATE_END => '2019-10-10'
      },
    }
  },

  'Mersin Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Mersin',

    EDITIONS => 
    {
      '2011' =>
      {
        ORDINAL => 27,
        YEAR => 2011,
        DATE_START => '2011-09-23',
        DATE_END => '2011-09-25'
      },
      '2013' =>
      {
        ORDINAL => 29,
        YEAR => 2013,
        DATE_START => '2013-09-20',
        DATE_END => '2013-09-20'
      },
      '2014' =>
      {
        ORDINAL => 30,
        YEAR => 2014,
        DATE_START => '2014-09-12',
        DATE_END => '2014-09-12'
      },
      '2015' =>
      {
        ORDINAL => 31,
        YEAR => 2015,
        DATE_START => '2015-09-11',
        DATE_END => '2015-09-11'
      },
      '2016' =>
      {
        ORDINAL => 32,
        YEAR => 2016,
        DATE_START => '2016-09-02',
        DATE_END => '2016-09-02'
      },
      '2018' =>
      {
        ORDINAL => 34,
        YEAR => 2018,
        DATE_START => '2018-09-16',
        DATE_END => '2018-09-16'
      },
    }
  },

  'Sivrioglu Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Sivrioglu',

    EDITIONS => 
    {
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-02-07',
        DATE_END => '2016-02-07'
      },
    }
  },

  'Turkish-Greek Friendship Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS => 
    {
      '2010' =>
      {
        ORDINAL => 2,
        YEAR => 2010,
        DATE_START => '2010-09-24',
        DATE_END => '2010-09-24'
      },
      '2011' =>
      {
        ORDINAL => 3,
        YEAR => 2011,
        DATE_START => '2011-09-09',
        DATE_END => '2011-09-12'
      },
    }
  },

  'Turkish Open Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-04',
        DATE_END => '2010-04-09'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-21',
        DATE_END => '2011-10-23'
      },
      '2012' =>
      {
        CITY => 'Mersin',
        YEAR => 2012,
        DATE_START => '2012-07-11',
        DATE_END => '2012-07-13'
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        YEAR => 2016,
        DATE_START => '2016-07-01',
        DATE_END => '2016-07-03'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-11-03',
        DATE_END => '2017-11-12'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-14',
        DATE_END => '2019-09-21'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-03-05',
        DATE_END => '2022-03-10'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-01-22',
        DATE_END => '2024-01-26'
      },
    }
  },

  'Turkish Summer Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-05-06',
        DATE_END => '2017-05-11'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-05-11',
        DATE_END => '2019-05-15'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-05-21',
        DATE_END => '2022-05-26'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-04-29',
        DATE_END => '2023-05-03'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-04-28',
        DATE_END => '2024-05-02'
      },
    }
  },

  'Turkish Winter Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-03-19',
        DATE_END => '2007-03-19'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-03-03',
        DATE_END => '2008-03-03'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-03-06',
        DATE_END => '2009-03-11'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-03-05',
        DATE_END => '2010-03-10'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-03-04',
        DATE_END => '2011-03-09'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-02-23',
        DATE_END => '2012-02-28'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-03-10',
        DATE_END => '2013-03-16'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-03-01',
        DATE_END => '2014-03-07'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-02-28',
        DATE_END => '2015-03-07'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-03-05',
        DATE_END => '2016-03-12'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-03-25',
        DATE_END => '2017-03-28'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-03-17',
        DATE_END => '2018-03-24'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-02-02',
        DATE_END => '2019-02-09'
      },
      '2020' =>
      {
        YEAR => 2020,
        CITY => 'Antalya',
        DATE_START => '2020-01-23',
        DATE_END => '2020-01-26'
      },
      '2023' =>
      {
        YEAR => 2023,
        CITY => 'Antalya',
        DATE_START => '2023-01-26',
        DATE_END => '2023-01-29'
      },
      '2024' =>
      {
        YEAR => 2024,
        CITY => 'Antalya',
        DATE_START => '2024-01-22',
        DATE_END => '2024-01-28'
      },
    }
  },

  'Turkish Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-05',
        DATE_END => '2010-04-08'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-21',
        DATE_END => '2011-10-23'
      },
      '2017A' =>
      {
        YEAR => 2017,
        DATE_START => '2017-01-31',
        DATE_END => '2017-01-31'
      },
      '2017B' =>
      {
        YEAR => 2017,
        DATE_START => '2017-11-08',
        DATE_END => '2017-11-08'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-14',
        DATE_END => '2019-09-17'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-03-05',
        DATE_END => '2022-03-05'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-03-04',
        DATE_END => '2023-03-05'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-02-05',
        DATE_END => '2024-02-05'
      },
    }
  },
);

my %TOURNAMENTS_TURKEY =
(
  'Aegean Open Teams',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Izmir',
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
            major => 'ROUND',
            DATE_START => '2012-06-29',
            DATE_END => '2012-07-01'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-14'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-26',
            DATE_END => '2016-08-28'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-07-07',
            DATE_END => '2017-07-09'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-07-24',
            DATE_END => '2022-07-24'
          } 
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-07-09',
            DATE_END => '2023-07-09'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-07-06',
            DATE_END => '2024-07-07'
          } 
        }
      },
    }
  },

  'Anatolian Club Teams',
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-05-20',
            DATE_END => '2012-05-20'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-17',
            DATE_END => '2014-05-18'
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
            DATE_START => '2017-05-01',
            DATE_END => '2017-05-01'
          },
          'C1' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-15',
            DATE_END => '2017-05-15'
          },
          'C2' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-19',
            DATE_END => '2017-05-22'
          },
        }
      },
      '2018' =>
      {
        PERSON => 'Yelda Baysal Mumcuoglu',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-05-11',
            DATE_END => '2018-05-13'
          },
          'C1' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-05-28',
            DATE_END => '2018-05-28'
          },
          'C2' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-06-01',
            DATE_END => '2018-06-04'
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
            major => 'ROUND',
            DATE_START => '2019-04-26',
            DATE_END => '2019-04-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-05-17',
            DATE_END => '2019-05-19'
          },
        }
      }
    }
  },

  'Anatolian Fall Teams',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CITY => 'Istanbul',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-26',
            DATE_END => '2011-10-26'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-26',
            DATE_END => '2011-10-27'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-27',
            DATE_END => '2011-10-27'
          },
        }
      }
    }
  },

  'Anatolian Spring Teams',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            STAGE => 'Final',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
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
            MOVEMENT => 'Danish',
            major => 'SEGMENT',
            DATE_START => '2010-04-26',
            DATE_END => '2010-04-27'
          },
        }
      },
      '2011' =>
      {
        CITY => 'Istanbul',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-27',
            DATE_END => '2011-04-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-27',
            DATE_END => '2011-04-27'
          },
        }
      }
    }
  },

  'Ankara Summer Teams',
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-06-17',
            DATE_END => '2012-06-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-06-24',
            DATE_END => '2012-06-24'
          },
          'C2' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-07-01',
            DATE_END => '2012-07-01'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-17',
            DATE_END => '2016-08-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-18',
            DATE_END => '2016-08-19'
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
            DATE_START => '2018-07-12',
            DATE_END => '2018-07-12'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-15',
            DATE_END => '2019-09-15'
          } 
        }
      },
    }
  },

  'Ankara Winter Teams' =>
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
      '2018A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-01-19',
            DATE_END => '2018-01-21'
          },
        }
      },
      '2018B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-22',
            DATE_END => '2018-12-23'
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
            DATE_START => '2019-01-04',
            DATE_END => '2019-01-06'
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
            DATE_START => '2020-01-17',
            DATE_END => '2020-01-19'
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
            DATE_START => '2023-01-22',
            DATE_END => '2023-01-22'
          },
        }
      },
    }
  },

  'Balikcioglu Open Teams',
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-24',
            DATE_END => '2012-05-24'
          },
          'C2' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-31',
            DATE_END => '2012-05-31'
          },
          'C3' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-06-07',
            DATE_END => '2012-06-07'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-06-14',
            DATE_END => '2012-06-14'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-06-21',
            DATE_END => '2012-06-21'
          },
          'C6' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-06-26',
            DATE_END => '2012-06-26'
          },
          'C7' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-06-28',
            DATE_END => '2012-06-28'
          },
        }
      },
    }
  },

  'Bodrum IMP Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'Bodrum Peninsula Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-27',
            DATE_END => '2019-09-27'
          },
        }
      },
    }
  },

  'Bodrum Patton Teams',
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Bodrum Peninsula Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            DATE_START => '2014-07-25',
            DATE_END => '2014-07-25'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-07-25',
            DATE_END => '2014-07-25'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-07-25',
            DATE_END => '2014-07-25'
          },
        }
      },
    }
  },

  'Bornova Arena Autumn Teams' =>
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
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-11-21',
            DATE_END => '2019-11-21'
          },
          'C1' =>
          {
            YEAR => 2019,
            DATE_START => '2019-11-28',
            DATE_END => '2019-11-28'
          },
          'C2' =>
          {
            YEAR => 2019,
            DATE_START => '2019-12-05',
            DATE_END => '2019-12-05'
          },
        }
      },
    }
  },

  'Bornova Arena Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-02-07',
            DATE_END => '2020-02-07'
          },
        }
      },
    }
  },

  'Bornova Arena Spring League' =>
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
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-04-25',
            DATE_END => '2019-04-25'
          },
          'C1' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-02',
            DATE_END => '2019-05-02'
          },
          'C2' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-09',
            DATE_END => '2019-05-09'
          },
        }
      },
    }
  },

  'Cappadocia Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Cappadocia Fairy Chimneys Festival',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-10-24',
            DATE_END => '2009-10-24'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Cappadocia Fairy Chimneys Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-10-23',
            DATE_END => '2010-10-24'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Cappadocia Fairy Chimneys Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION|SEGMENT',
            DATE_START => '2011-11-19',
            DATE_END => '2011-11-19'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Cappadocia Fairy Chimneys Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-11-03',
            DATE_END => '2012-11-03'
          },
        }
      },
    }
  },

  'Deniz Unlu Open Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Assael Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-25'
          },
        }
      },
    }
  },

  'Fatih Kiral Pairs',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-06-11',
            DATE_END => '2011-06-11'
          },
        }
      },
    }
  },

  'Gelibolu Peace Teams',
  {
    %GLOBAL,
    CITY => 'Gelibolu',
    ORIGIN => 'Supranational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND|MATCH',
            DATE_START => '2007-04-22',
            DATE_END => '2007-04-23'
          },
        }
      },
      '2008' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
        }
      },
    }
  },

  'Goksu-Yalikavak Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SESSION',
            DATE_START => '2009-07-17',
            DATE_END => '2009-07-18'
          } 
        }
      },
    }
  },

  'Hakan Peksen Open Teams' =>
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
        REGION => 'Marmara',
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

  'Istanbul Club Teams' =>
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
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2015,
            DATE_START => '2015-04-24',
            DATE_END => '2015-04-26'
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
            DATE_START => '2017-05-20',
            DATE_END => '2017-05-21'
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
            DATE_START => '2024-05-25',
            DATE_END => '2024-05-26'
          },
        }
      },
    }
  },

  'Istanbul Summer Teams',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-01'
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-06-04',
            DATE_END => '2016-06-05'
          } 
        }
      },
    }
  },

  'Istanbul Winter Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-02-13',
            DATE_END => '2006-02-13'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'SEGMENT',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'MATCH|SEGMENT',
            DATE_START => '2010-02-20',
            DATE_END => '2010-02-21'
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
            major => 'ROUND',
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-20'
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
            major => 'ROUND|SEGMENT',
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17'
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
            DATE_START => '2014-02-08',
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-31'
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          } 
        }
      },
      '2017A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-11',
            DATE_END => '2017-02-12'
          } 
        }
      },
      '2017B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-24',
            DATE_END => '2017-02-28'
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
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-21'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-19',
            DATE_END => '2019-01-20'
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
            DATE_START => '2020-01-18',
            DATE_END => '2020-01-19'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-19',
            DATE_END => '2022-03-20'
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
            DATE_START => '2023-01-21',
            DATE_END => '2023-01-22'
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
            DATE_START => '2024-02-16',
            DATE_END => '2024-02-18'
          } 
        }
      },
    }
  },

  'Istanbul Winter Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2019-03-16',
            DATE_END => '2019-03-17'
          },
        }
      },
    }
  },

  'Istanbul Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
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
    }
  },

  'Izmir Teams Cup',
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
            major => 'ROUND',
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-09-22',
            DATE_END => '2009-09-22'
          } 
        }
      },
    }
  },

  'Izmir Winter Teams Cup',
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
            major => 'ROUND',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
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
            STAGE => 'Playoff',
            major => 'ROUND',
            DATE_START => '2013-02-19',
            DATE_END => '2013-02-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'ROUND',
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03'
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-01-25',
            DATE_END => '2015-01-25'
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
            STAGE => 'Playoff',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-02-07',
            DATE_END => '2016-02-07'
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
            DATE_START => '2017-02-12',
            DATE_END => '2017-02-12'
          } 
        }
      },
      '2018-19' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-12-22',
            DATE_END => '2018-12-23'
          },
          'C1' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-05',
            DATE_END => '2019-01-06'
          } 
        }
      },
      '2019-20' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-21',
            DATE_END => '2019-12-22'
          },
          'C1' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-05',
            DATE_END => '2020-01-05'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-19',
            DATE_END => '2022-03-20'
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
            DATE_START => '2023-03-12',
            DATE_END => '2023-03-12'
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
            DATE_START => '2024-02-18',
            DATE_END => '2024-02-18'
          } 
        }
      },
    }
  },

  'Izmir Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2016-10-22',
            DATE_END => '2016-10-22'
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
            DATE_START => '2017-03-05',
            DATE_END => '2017-03-05'
          },
        }
      },
    }
  },

  'Lüleburgaz Liberation Cup',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-11-08',
            DATE_END => '2015-11-08'
          },
        }
      },
    }
  },

  'Marmara Inter-Club Championship',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    REGION => 'Marmara',
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
            major => 'ROUND',
            DATE_START => '2012-04-28',
            DATE_END => '2012-04-29'
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
            major => 'ROUND',
            DATE_START => '2019-05-18',
            DATE_END => '2019-05-19'
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
            major => 'ROUND',
            DATE_START => '2022-07-02',
            DATE_END => '2022-07-03'
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
            major => 'ROUND',
            DATE_START => '2023-05-20',
            DATE_END => '2023-05-21'
          },
        }
      },
    }
  },

  'Merit Mixed Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Merit Bridge Festival',
        MEET_TAG => '2018A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-09',
            DATE_END => '2018-04-10'
          },
        }
      },
      '2019A' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-17',
            DATE_END => '2019-04-18'
          },
        }
      },
      '2019B' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-09',
            DATE_END => '2019-10-10'
          },
        }
      },
    }
  },

  'Merit Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018A' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-04-10',
            DATE_END => '2018-04-12'
          },
        }
      },
      '2018B' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-09-03',
            DATE_END => '2018-09-06'
          },
        }
      },
      '2019A' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-04-15',
            DATE_END => '2019-04-18'
          },
        }
      },
      '2019B' =>
      {
        MEET => 'Merit Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-07',
            DATE_END => '2019-10-09'
          },
        }
      },
    }
  },

  'Mersin Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-09-25',
            DATE_END => '2011-09-25'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-09-16',
            DATE_END => '2018-09-16'
          },
        }
      },
    }
  },

  'Mersin Open Patton Teams',
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'ROUND',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-23'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-23'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-23'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-23'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'ROUND',
            DATE_START => '2013-09-20',
            DATE_END => '2013-09-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-20',
            DATE_END => '2013-09-20'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-20',
            DATE_END => '2013-09-20'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-20',
            DATE_END => '2013-09-20'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|SESSION',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-11'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-11'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-11'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-11'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Mersin Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-02',
            DATE_END => '2016-09-02'
          },
        }
      },
    }
  },

  'Mersin Winter Open Teams' =>
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
            DATE_START => '2017-01-15',
            DATE_END => '2017-01-15'
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
            DATE_START => '2018-11-29',
            DATE_END => '2018-11-29'
          },
          'C1' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-06',
            DATE_END => '2018-12-06'
          },
          'C2' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-09',
            DATE_END => '2018-12-09'
          },
          'C3' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-13',
            DATE_END => '2018-12-13'
          },
          'C4' =>
          {
            YEAR => 2018,
            DATE_START => '2018-12-20',
            DATE_END => '2018-12-20'
          },
        }
      },
    }
  },

  'Murat Kilercioglu Turkish Spring Teams',
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
            DATE_START => '2011-04-28',
            DATE_END => '2011-04-28'
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
            DATE_START => '2012-04-30',
            DATE_END => '2012-04-30'
          } 
        }
      },
    }
  },

  'Necmettin Sunget Teams Cup',
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
        ORDINAL => 9,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
          } 
        }
      },
      '2010' =>
      {
        ORDINAL => 10,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|HALF',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT|HALF',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|HALF',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          } 
        }
      },
      '2011' =>
      {
        ORDINAL => 11,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT|SESSION|ROUND',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|SESSION|ROUND',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-11'
          } 
        }
      },
    }
  },

  'Okay Gur Winter Teams' =>
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
            DATE_START => '2024-03-18',
            DATE_END => '2024-03-23'
          },
        }
      },
    }
  },

  'Sadun Su U26 Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-01-23',
            DATE_END => '2020-01-23'
          },
        }
      },
    }
  },

  'Salvador Assael IMP Pairs',
  {
    # https://bridgescanner.com/event/salvador-assael-aegean-pair-championship-2023

    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'IMP', # Really IAF, but hard to get through the code
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-06-04',
            DATE_END => '2013-06-05'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2013-06-06',
            DATE_END => '2013-06-06'
          },
        }
      },
      '2015' =>
      {
        ORDINAL => 3,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-06-01',
            DATE_END => '2015-06-02'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-04'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-27',
            DATE_END => '2016-09-28'
          },
        }
      },
    }
  },

  'Salvador Assael Pro-Am Pairs',
  {
    ORIGIN => 'Pro-Am',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Assael Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2012-05-20',
            DATE_END => '2012-05-20'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Assael Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-06-02',
            DATE_END => '2013-06-03'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Assael Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-06-04',
            DATE_END => '2014-06-04'
          },
        }
      },

    }
  },

  'Sivrioglu BAM Teams',
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Sivrioglu Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-02-07',
            DATE_END => '2016-02-07'
          },
        }
      },
    }
  },

  'Solakoglu IMP Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Assael Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Elimination',
            major => 'SESSION',
            DATE_START => '2014-06-03',
            DATE_END => '2014-06-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2014-06-05',
            DATE_END => '2014-06-06'
          },
        }
      },
    }
  },

  'Thrace Cup League',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    REGION => 'Thrace',
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
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-05-19',
            DATE_END => '2014-05-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-13'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-19'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-06-05',
            DATE_END => '2016-06-05'
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
            major => 'ROUND',
            DATE_START => '2017-05-19',
            DATE_END => '2017-05-21'
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
            major => 'ROUND',
            DATE_START => '2018-04-07',
            DATE_END => '2018-04-08'
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
            major => 'ROUND',
            DATE_START => '2019-05-25',
            DATE_END => '2019-05-27'
          },
        }
      },
    }
  },

  'Turkish-Greek Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Turkish-Greek Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-10'
          },
        }
      },
    }
  },

  'Turkish-Greek Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Turkish-Greek Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-24',
            DATE_END => '2010-09-24'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Turkish-Greek Friendship Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-12'
          },
        }
      },
    }
  },

  'Turkish Club Championship',
  {
    %GLOBAL,
    ORIGIN => 'Interclub',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2009
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2009
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-07-31',
            DATE_END => '2009-08-02'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-08-02',
            DATE_END => '2009-08-03'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-03',
            DATE_END => '2009-08-04'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-08-04',
            DATE_END => '2009-08-04'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-05',
            DATE_END => '2009-08-05'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2010
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND|MATCH',
            DATE_START => '2010-08-27',
            DATE_END => '2010-08-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-29'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-29',
            DATE_END => '2010-08-30'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-30',
            DATE_END => '2010-08-30'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-31',
            DATE_END => '2010-08-31'
          } 
        }
      },
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2011
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-08-19',
            DATE_END => '2011-08-20'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-08-20',
            DATE_END => '2011-08-21'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-21',
            DATE_END => '2011-08-22'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-22',
            DATE_END => '2011-08-22'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-08-23',
            DATE_END => '2011-08-23'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2012
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=9&year=2012
        CITY => 'Mardin',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2012-08-30',
            DATE_END => '2012-08-31'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-08-31',
            DATE_END => '2012-09-01'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-02'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2012-09-03',
            DATE_END => '2012-09-03'
          } 
        }
      },
      '2013' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2013
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-19',
            DATE_END => '2013-02-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-08-24',
            DATE_END => '2013-08-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-08-25',
            DATE_END => '2013-08-26'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-08-26',
            DATE_END => '2013-08-27'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-27',
            DATE_END => '2013-08-28'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-28',
            DATE_END => '2013-08-28'
          },
          'C6' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-29',
            DATE_END => '2013-08-29'
          } 
        }
      },
      '2014' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2014
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-08-03',
            DATE_END => '2014-08-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-05'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-06'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-06',
            DATE_END => '2014-08-07'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-07',
            DATE_END => '2014-08-07'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Bronze',
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-08'
          },
          'C6' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-08'
          } 
        }
      },
      '2015' =>
      {
        # https://clubs.vugraph.com/tbricfed/calendar.php?month=8&year=2015
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-17',
            DATE_END => '2015-05-19'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Rof64',
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-23'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Rof32',
            DATE_START => '2015-08-24',
            DATE_END => '2015-08-24'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            DATE_START => '2015-08-24',
            DATE_END => '2015-08-25'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-08-25',
            DATE_END => '2015-08-26'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-08-26',
            DATE_END => '2015-08-26'
          },
          'C6' => 
          {
            YEAR => 2015,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2015-08-27',
            DATE_END => '2015-08-27'
          },
          'C7' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-08-27',
            DATE_END => '2015-08-27'
          } 
        }
      },
      '2016' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-11',
            DATE_END => '2016-10-16'
          },
        }
      },
      '2017' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-29',
            DATE_END => '2017-08-03'
          },
        }
      },
      '2018' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-21',
            DATE_END => '2018-07-26'
          },
        }
      },
      '2019' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-07-20',
            DATE_END => '2019-07-25'
          },
        }
      },
      '2022' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-08-06',
            DATE_END => '2022-08-11'
          },
        }
      },
      '2023' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-07-22',
            DATE_END => '2023-07-27'
          },
        }
      },
      '2024' =>
      {
        # TODO Really the same tournament as above?
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-08-26',
            DATE_END => '2024-08-30'
          },
        }
      },
    }
  },

  'Turkish East Mediterranean Teams',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            major => 'ROUND',
            DATE_START => '2013-05-25',
            DATE_END => '2013-05-26'
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
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-06-28',
            DATE_END => '2014-06-29'
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
            DATE_START => '2017-06-10',
            DATE_END => '2017-06-11'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-19',
            DATE_END => '2019-05-19'
          } 
        }
      },
    }
  },

  'Turkish Junior Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2012
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-03'
          } 
        }
      },
    }
  },

  'Turkish Mixed Team Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-10',
            DATE_END => '2016-07-10'
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
            DATE_START => '2018-12-01',
            DATE_END => '2018-12-04'
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
            DATE_START => '2019-11-08',
            DATE_END => '2019-11-17'
          },
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-11',
            DATE_END => '2020-01-14'
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
            DATE_START => '2022-03-14',
            DATE_END => '2022-03-18'
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
            DATE_START => '2023-12-13',
            DATE_END => '2023-12-15'
          },
        }
      },
      '2024A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-27',
            DATE_END => '2024-02-29'
          },
        }
      },
      '2024B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-12-11',
            DATE_END => '2024-12-13'
          },
        }
      },
    }
  },

  'Turkish Mixed Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2012
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND|MATCH',
            DATE_START => '2012-12-19',
            DATE_END => '2012-12-21'
          } 
        }
      },
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2013
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-12-18',
            DATE_END => '2013-12-20'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-12'
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
            DATE_START => '2016-12-14',
            DATE_END => '2016-12-16'
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
            DATE_START => '2017-12-13',
            DATE_END => '2017-12-15'
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
            DATE_START => '2018-12-12',
            DATE_END => '2018-12-14'
          } 
        }
      },
      '2021' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-12-16',
            DATE_END => '2021-12-17'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-12-16',
            DATE_END => '2022-12-16'
          } 
        }
      },
    }
  },

  'Turkish Open Teams',
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
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2009
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-04-26',
            DATE_END => '2009-04-26'
          },
          'C1' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2009-04-27',
            DATE_END => '2009-04-30'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-06'
          } 
        }
      },
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2011
        CITY => 'Antalya',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-05-10',
            DATE_END => '2011-05-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Danish',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-12',
            DATE_END => '2011-05-12'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2012
        CITY => 'Antalya',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2012-05-08',
            DATE_END => '2012-05-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2012-05-10',
            DATE_END => '2012-05-10'
          } 
        }
      },
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2013
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2013-05-07',
            DATE_END => '2013-05-08'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2014
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-05-04',
            DATE_END => '2014-05-05'
          },
          'C1' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2014-05-06',
            DATE_END => '2014-05-06'
          },
          'C2' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2014-05-07',
            DATE_END => '2014-05-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2015
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-05-04',
            DATE_END => '2015-05-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2015-05-07',
            DATE_END => '2015-05-07'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2016
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-05-02',
            DATE_END => '2016-05-02'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2016-05-03',
            DATE_END => '2016-05-03'
          } 
        }
      },
    }
  },

  'Turkish Open Pair Trials',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
      '2010' =>
      {
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'SESSION|ROUND',
            DATE_START => '2010-04-04',
            DATE_END => '2010-04-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-04-06',
            DATE_END => '2010-04-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-04-08',
            DATE_END => '2010-04-09'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SESSION',
            DATE_START => '2016-07-01',
            DATE_END => '2016-07-03'
          } 
        }
      },
    }
  },

  'Turkish Open Team Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=10&year=2011
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-21',
            DATE_END => '2011-10-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-22',
            DATE_END => '2011-10-23'
          } 
        }
      },
      '2012' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2012
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-11',
            DATE_END => '2012-07-12'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-12',
            DATE_END => '2012-07-13'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-03',
            DATE_END => '2017-11-12'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-14',
            DATE_END => '2019-09-21'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-10'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-01-22',
            DATE_END => '2024-01-26'
          },
        }
      },
    }
  },

  'Turkish Senior Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-12-22',
            DATE_END => '2017-12-23'
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
            DATE_START => '2020-01-20',
            DATE_END => '2020-01-23'
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
            DATE_START => '2022-03-17',
            DATE_END => '2022-03-18'
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
            DATE_START => '2024-02-12',
            DATE_END => '2024-02-12'
          },
        }
      },
    }
  },

  'Turkish Summer Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-04-28',
            DATE_END => '2024-04-28'
          },
        }
      },
    }
  },

  'Turkish Summer Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-05-06',
            DATE_END => '2017-05-11'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-11',
            DATE_END => '2019-05-15'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-05-21',
            DATE_END => '2022-05-26'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-04-29',
            DATE_END => '2023-05-03'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-04-29',
            DATE_END => '2024-05-02'
          },
        }
      },
    }
  },

  'Turkish Summer Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-05-10',
            DATE_END => '2017-05-11'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-14',
            DATE_END => '2019-05-15'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-05-24',
            DATE_END => '2022-05-25'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-05-01',
            DATE_END => '2023-05-03'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Turkish Summer Championships',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-05-02',
            DATE_END => '2024-05-02'
          },
        }
      },
    }
  },

  'Turkish Super Cup' =>
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
            DATE_START => '2018-02-10',
            DATE_END => '2018-02-15'
          },
        }
      },
    }
  },

  'Turkish Swiss Mixed Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=12&year=2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND|MATCH',
            DATE_START => '2015-12-16',
            DATE_END => '2015-12-18'
          } 
        }
      },
    }
  },

  'Turkish Swiss Open Teams' =>
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
            DATE_START => '2018-05-19',
            DATE_END => '2018-05-24'
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
            DATE_START => '2022-05-23',
            DATE_END => '2022-05-24'
          },
        }
      },
    }
  },

  'Turkish U16 Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=7&year=2016
        MEET => 'Turkish Open Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-07-02',
            DATE_END => '2016-07-02'
          } 
        }
      },
    }
  },

  'Turkish U21 Pair Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-01-30',
            DATE_END => '2017-01-31'
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
            DATE_START => '2022-01-29',
            DATE_END => '2022-01-30'
          },
        }
      },
    }
  },

  'Turkish U26 Pair Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2017A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-01-29',
            DATE_END => '2017-01-29'
          },
        }
      },
      '2017B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-04-01',
            DATE_END => '2017-04-01'
          },
        }
      },
    }
  },

  'Turkish U26 Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

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
            DATE_START => '2018-07-27',
            DATE_END => '2018-07-27'
          },
        }
      },
    }
  },

  'Turkish U26 Women Pair Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            DATE_START => '2017-01-30',
            DATE_END => '2017-01-31'
          },
        }
      },
    }
  },

  'Turkish U31 Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-03-03',
            DATE_END => '2020-03-03'
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
            DATE_START => '2022-01-28',
            DATE_END => '2022-01-29'
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
            DATE_START => '2023-05-21',
            DATE_END => '2023-05-21'
          },
        }
      },
    }
  },

  'Turkish University Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-03-30',
            DATE_END => '2012-03-30'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-28'
          } 
        }
      },
    }
  },

  'Turkish Winter Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-03-19',
            DATE_END => '2007-03-19'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-03-06',
            DATE_END => '2009-03-07'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2009-03-08',
            DATE_END => '2009-03-08'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-03-08',
            DATE_END => '2009-03-09'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-09',
            DATE_END => '2009-03-10'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-10',
            DATE_END => '2009-03-10'
          },
          'C5' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-11',
            DATE_END => '2009-03-11'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-03-05',
            DATE_END => '2010-03-06'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Rof32',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-03-07',
            DATE_END => '2010-03-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-03-07',
            DATE_END => '2010-03-08'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-03-08',
            DATE_END => '2010-03-09'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-03-09',
            DATE_END => '2010-03-09'
          },
          'C5' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-03-10',
            DATE_END => '2010-03-10'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-03-04',
            DATE_END => '2011-03-05'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2011-03-06',
            DATE_END => '2011-03-06'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-03-06',
            DATE_END => '2011-03-07'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-07',
            DATE_END => '2011-03-08'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-08',
            DATE_END => '2011-03-08'
          },
          'C5' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-09',
            DATE_END => '2011-03-09'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-02-23',
            DATE_END => '2012-02-24'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Rof32',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-02-24',
            DATE_END => '2012-02-25'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Rof16',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-02-25',
            DATE_END => '2012-02-26'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-26',
            DATE_END => '2012-02-27'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-27',
            DATE_END => '2012-02-27'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-28',
            DATE_END => '2012-02-28'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-10',
            DATE_END => '2013-03-11'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2013-03-12',
            DATE_END => '2013-03-12'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-03-12',
            DATE_END => '2013-03-13'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-03-13',
            DATE_END => '2013-03-14'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-14',
            DATE_END => '2013-03-14'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-14',
            DATE_END => '2013-03-15'
          },
          'C6' => 
          {
            YEAR => 2013,
            STAGE => 'Bronze',
            DATE_START => '2013-03-16',
            DATE_END => '2013-03-16'
          },
          'C7' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-15',
            DATE_END => '2013-03-16'
          },
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2014
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Rof64',
            major => 'SEGMENT',
            DATE_START => '2014-03-03',
            DATE_END => '2014-03-03'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-03-03',
            DATE_END => '2014-03-04'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-03-04',
            DATE_END => '2014-03-05'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-05',
            DATE_END => '2014-03-05'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-06'
          },
          'C6' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-06'
          },
          'C7' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-06',
            DATE_END => '2014-03-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2015
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2015
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-02-28',
            DATE_END => '2015-03-02'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Rof64',
            major => 'MATCH',
            DATE_START => '2015-03-02',
            DATE_END => '2015-03-03'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Rof32',
            major => 'MATCH',
            DATE_START => '2015-03-03',
            DATE_END => '2015-03-04'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'MATCH',
            DATE_START => '2015-03-04',
            DATE_END => '2015-03-05'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-05',
            DATE_END => '2015-03-05'
          },
          'C6' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-06'
          },
          'C7' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-07'
          } 
        }
      },
      '2016' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=3&year=2016
        MEET => 'Turkish Winter Championships',
        CHAPTERS =>
        {
          'C0' => 
          {
            # TODO Probably a different tournament
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-07'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof64',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-08',
            DATE_END => '2016-03-08'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Rof32',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-08',
            DATE_END => '2016-03-09'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-09',
            DATE_END => '2016-03-10'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-10',
            DATE_END => '2016-03-10'
          },
          'C5' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-11',
            DATE_END => '2016-03-11'
          },
          'C6' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-11',
            DATE_END => '2016-03-12'
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
            DATE_START => '2017-02-24',
            DATE_END => '2017-02-28'
          },
          'C1' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-25',
            DATE_END => '2017-03-28'
          },
        }
      },
      '2018A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-06',
            DATE_END => '2018-01-07'
          },
        }
      },
      '2018B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-03-19',
            DATE_END => '2018-03-24'
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
            DATE_START => '2019-02-05',
            DATE_END => '2019-02-09'
          },
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-11',
            DATE_END => '2020-02-15'
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
            DATE_START => '2022-04-09',
            DATE_END => '2022-04-16'
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
            DATE_START => '2023-03-27',
            DATE_END => '2023-04-01'
          },
        }
      },
    }
  },

  'Turkish Winter Women Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2012-03-17',
            DATE_END => '2012-03-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-17',
            DATE_END => '2012-03-18'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-18',
            DATE_END => '2012-03-18'
          },
        }
      },
      '2013' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2013
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-02-23',
            DATE_END => '2013-02-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-02-23',
            DATE_END => '2013-02-24'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-24',
            DATE_END => '2013-02-24'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2014
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-02-21',
            DATE_END => '2014-02-23'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=2&year=2015
        PERSON => 'Özgecan Aslan',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-22'
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
            DATE_END => '2016-02-20'
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
            DATE_START => '2017-03-16',
            DATE_END => '2017-03-19'
          } 
        }
      },
    }
  },

  'Turkish Women Pair Trials',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2010
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-04-05',
            DATE_END => '2010-04-08'
          } 
        }
      },
      '2017A' =>
      {
        MEET => 'Turkish Women Trials',
        MEET_TAG => '2017A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2017-01-31',
            DATE_END => '2017-01-31'
          } 
        }
      },
      '2017B' =>
      {
        MEET => 'Turkish Women Trials',
        MEET_TAG => '2017B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-08',
            DATE_END => '2017-11-08'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-03-04',
            DATE_END => '2023-03-05'
          },
        }
      },
    }
  },

  'Turkish Women Team Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=10&year=2011
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-21',
            DATE_END => '2011-10-22'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-22',
            DATE_END => '2011-10-23'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Turkish Women Trials',
        MEET_TAG => '2017B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-08',
            DATE_END => '2017-11-08'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-14',
            DATE_END => '2019-09-17'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-05'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Turkish Women Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-05',
            DATE_END => '2024-02-05'
          },
        }
      },
    }
  },

  'Turkish Women Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=4&year=2009
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-04-25',
            DATE_END => '2009-04-28'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-04-30',
            DATE_END => '2009-04-30'
          } 
        }
      },
      '2010' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2010
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND|MATCH',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-06'
          } 
        }
      },
      '2014' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2014
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-05-06',
            DATE_END => '2014-05-06'
          },
          'C1' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2014-05-07',
            DATE_END => '2014-05-07'
          } 
        }
      },
      '2015' =>
      {
        # http://clubs.vugraph.com/tbricfed/calendar.php?month=5&year=2015
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Danish',
            major => 'ROUND',
            DATE_START => '2015-05-07',
            DATE_END => '2015-05-07'
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
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-16',
            DATE_END => '2017-03-19'
          } 
        }
      },
      '2018A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-13',
            DATE_END => '2018-01-14'
          } 
        }
      },
      '2018B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-24',
            DATE_END => '2018-05-24'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-15',
            DATE_END => '2019-01-18'
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
            DATE_START => '2020-02-29',
            DATE_END => '2020-03-03'
          } 
        }
      },
    }
  },

  'Western Mediterranean Club Teams',
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-01'
          },
        }
      },
    }
  },

  'Yalcin Atabey Open Teams' =>
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
            DATE_START => '2024-05-03',
            DATE_END => '2024-05-03'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_TURKEY, \%TOURNAMENTS_TURKEY, 'Turkey');
}

1;
