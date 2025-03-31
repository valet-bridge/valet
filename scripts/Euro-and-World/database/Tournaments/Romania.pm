#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Romania;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://www.frbridge.ro/rezultate/index.html

my %GLOBAL = (
  ORGANIZATION => 'FRB',
  COUNTRY => 'Romania',
  ZONE => 'Europe',
);

my %MEETS_ROMANIA =
(
  'Brasov Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Brasov',

    EDITIONS =>
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-11-19',
        DATE_END => '2009-11-22'
      },
    }
  },

  'Tusnad Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2000' =>
      {
        YEAR => 2000,
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  },

);

my %TOURNAMENTS_ROMANIA =
(
  'Alba Iulia U26 Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-02',
            DATE_END => '2019-05-03'
          },
        }
      },
    }
  },

  'Brasov Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Brasov Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-21',
            DATE_END => '2009-11-22'
          } 
        }
      },
    }
  },

  'Brasov Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Brasov Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-19',
            DATE_END => '2009-11-20'
          } 
        }
      },
    }
  },

  'Contra Open Cup' =>
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
            DATE_START => '2023-03-23',
            DATE_END => '2023-03-26'
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
            DATE_START => '2024-05-23',
            DATE_END => '2024-05-26'
          },
        }
      },
    }
  },

  'Iasi Open Teams' =>
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
            DATE_START => '2017-04-22',
            DATE_END => '2017-04-23'
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
            DATE_START => '2018-04-14',
            DATE_END => '2018-04-15'
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
            DATE_START => '2019-04-21',
            DATE_END => '2019-04-21'
          },
        }
      },
    }
  },

  'Romanian Butler Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
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
            DATE_START => '2017-01-27',
            DATE_END => '2017-01-29'
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
            DATE_START => '2018-01-27',
            DATE_END => '2018-01-28'
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
            DATE_START => '2024-01-27',
            DATE_END => '2024-01-27'
          },
        }
      },
    }
  },

  'Romanian Individual' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Individual',
    SCORING => 'MP',
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
            DATE_START => '2018-11-18',
            DATE_END => '2018-11-18'
          },
        }
      },
    }
  },

  'Romanian League',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-29'
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
            major => 'ROUND',
            DATE_START => '2010-11-26',
            DATE_END => '2010-11-28'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-20'
          } 
        }
      },
      '2011-12' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-11-04',
            DATE_END => '2011-11-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-11',
            DATE_END => '2012-05-13'
          }
        }
      },
      '2012-13' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-11-30',
            DATE_END => '2012-12-02'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-02-22',
            DATE_END => '2013-02-24'
          }
        }
      },
      '2013-14' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-03'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND|MATCH',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-16'
          }
        }
      },
      '2014-15' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-11-28',
            DATE_END => '2014-11-30'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-15'
          } 
        }
      },
      '2015-16' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-22'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          } 
        }
      },
      '2016-17' =>
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
    }
  },

  'Romanian Mixed Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
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
            DATE_START => '2016-11-12',
            DATE_END => '2016-11-13'
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
            DATE_START => '2017-11-12',
            DATE_END => '2017-11-12'
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
            DATE_START => '2018-12-02',
            DATE_END => '2018-12-02'
          },
        }
      },
    }
  },

  'Romanian Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'Romanian Open Pairs' =>
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
            DATE_START => '2017-04-29',
            DATE_END => '2017-04-30'
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
            DATE_START => '2018-06-02',
            DATE_END => '2018-06-03'
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
            DATE_START => '2019-06-09',
            DATE_END => '2019-06-09'
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
            DATE_START => '2024-06-15',
            DATE_END => '2024-06-15'
          },
        }
      },
    }
  },

  'Romanian Open Teams',
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2005-06-03',
            DATE_END => '2005-06-04'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-04',
            DATE_END => '2005-06-05'
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
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2010-05-21',
            DATE_END => '2010-05-22'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-22',
            DATE_END => '2010-05-23'
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
            minor => 'MATCH',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-12'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-12'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-10'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-10'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-08',
            DATE_END => '2013-06-09'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-06-06',
            DATE_END => '2014-06-07'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-06-07',
            DATE_END => '2014-06-08'
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
            DATE_START => '2015-06-05',
            DATE_END => '2015-06-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-06',
            DATE_END => '2015-06-07'
          } 
        }
      },
      '2016A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-05'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-05'
          } 
        }
      },
      '2016B' =>
      {
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
      '2017A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-02',
            DATE_END => '2017-06-04'
          },
        }
      },
      '2017B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-24',
            DATE_END => '2017-11-26'
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
            DATE_START => '2018-02-23',
            DATE_END => '2018-02-25'
          },
          'C1' => 
          {
            YEAR => 2018,
            DATE_START => '2018-03-03',
            DATE_END => '2018-03-04'
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
            DATE_START => '2018-11-02',
            DATE_END => '2018-11-04'
          },
        }
      },
      '2019A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-02-15',
            DATE_END => '2019-02-17'
          },
        }
      },
      '2019B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-29',
            DATE_END => '2019-12-01'
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
            DATE_START => '2020-02-21',
            DATE_END => '2020-02-23'
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
            DATE_START => '2022-12-16',
            DATE_END => '2022-12-18'
          },
        }
      },
      '2023A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-02-10',
            DATE_END => '2023-02-12'
          },
        }
      },
      '2023B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-11-03',
            DATE_END => '2023-11-05'
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
            DATE_START => '2024-03-01',
            DATE_END => '2024-03-03'
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
            DATE_START => '2024-11-08',
            DATE_END => '2024-11-10'
          },
        }
      },
    }
  },

  'Romanian Open Trials',
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
            major => 'ROUND',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-21'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-27'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
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
            major => 'ROUND',
            DATE_START => '2012-01-27',
            DATE_END => '2012-01-29'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-18',
            DATE_END => '2012-02-19'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-26',
            DATE_END => '2012-02-27'
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
            major => 'ROUND',
            DATE_START => '2014-02-22',
            DATE_END => '2014-02-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
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
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-21'
          },
          'C1' => 
          {
            YEAR => 2018,
            DATE_START => '2018-02-03',
            DATE_END => '2018-02-04'
          },
          'C2' => 
          {
            YEAR => 2018,
            DATE_START => '2018-03-17',
            DATE_END => '2018-03-18'
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
            DATE_START => '2020-02-07',
            DATE_END => '2020-02-09'
          },
          'C1' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-14',
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
            DATE_START => '2022-02-25',
            DATE_END => '2022-02-27'
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
            DATE_START => '2024-02-02',
            DATE_END => '2024-02-11'
          },
        }
      },
    }
  },

  'Romanian Second League',
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
        CITY => 'Brasov',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-10-17',
            DATE_END => '2009-10-17'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Playoff',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-10-18',
            DATE_END => '2009-10-18'
          } 
        }
      },
    }
  },

  'Romanian Senior Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-16',
            DATE_END => '2024-03-17'
          },
        }
      },
    }
  },

  'Romanian Super League',
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
            DATE_START => '2017-06-02',
            DATE_END => '2017-06-03'
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
            DATE_START => '2019-03-30',
            DATE_END => '2019-03-31'
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
            DATE_START => '2020-10-03',
            DATE_END => '2020-10-04'
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
            DATE_START => '2022-05-28',
            DATE_END => '2022-05-29'
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
            DATE_START => '2023-05-06',
            DATE_END => '2023-05-07'
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
            DATE_START => '2024-06-01',
            DATE_END => '2024-06-02'
          },
        }
      },
    }
  },

  'Romanian Women Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
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
            DATE_START => '2024-03-16',
            DATE_END => '2024-03-17'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ROMANIA, \%TOURNAMENTS_ROMANIA, 'Romania');
}

1;
