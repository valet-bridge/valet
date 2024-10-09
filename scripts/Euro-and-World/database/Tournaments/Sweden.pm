#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Sweden;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_SWEDEN =
(
  'Swedish Bridge Festival' =>
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',

    # Start 6 days before end
    # End 3 days after
    EDITIONS => 
    {
      '2009' =>
      {
        YEAR => 2009,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2009-07-24', # Estimated
        DATE_END => '2009-08-02'
      },
      '2010' =>
      {
        YEAR => 2010,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2010-07-28', # Estimated
        DATE_END => '2010-08-08'
      },
      '2011' =>
      {
        YEAR => 2011,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2011-07-27', # Estimated
        DATE_END => '2011-08-07'
      },
      '2012' =>
      {
        YEAR => 2012,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2012-07-25', # Estimated
        DATE_END => '2012-08-05'
      },
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2013-07-24', # Estimated
        DATE_END => '2013-08-04'
      },
      '2014' =>
      {
        # https://www.svenskbridge.se/festival-2014/nyheter/88
        YEAR => 2014,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2013-07-25',
        DATE_END => '2013-08-03'
      },
      '2015' =>
      {
        # https://www.svenskbridge.se/festival-2015/info
        YEAR => 2015,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2015-07-24',
        DATE_END => '2015-08-02'
      },
      '2016' =>
      {
        # https://www.svenskbridge.se/festival-2016/info
        YEAR => 2016,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2016-07-29',
        DATE_END => '2016-08-07'
      },
      '2017' =>
      {
        # https://www.svenskbridge.se/festival-2017/info
        YEAR => 2017,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2017-07-28',
        DATE_END => '2017-08-05'
      },
      '2018' =>
      {
        # https://www.svenskbridge.se/festival-2018/info
        YEAR => 2018,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2018-07-28',
        DATE_END => '2018-08-05'
      },
      '2019' =>
      {
        # https://www.svenskbridge.se/festival-2019/info
        YEAR => 2019,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2019-07-26',
        DATE_END => '2019-08-04'
      },
      '2021' =>
      {
        # https://www.svenskbridge.se/festival-2021/info
        YEAR => 2021,
        CITY => 'Online',
        COUNTRY => 'Sweden',
        DATE_START => '2021-07-30',
        DATE_END => '2021-08-08'
      },
      '2022' =>
      {
        # https://www.svenskbridge.se/festival-2022/info
        YEAR => 2022,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2022-07-28',
        DATE_END => '2022-08-06'
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/festival-2023/info
        YEAR => 2023,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2023-07-28',
        DATE_END => '2023-08-06'
      },
      '2024' =>
      {
        # https://www.svenskbridge.se/festival-2024/tavling
        YEAR => 2024,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2024-07-26',
        DATE_END => '2024-08-04'
      },
    }
  },

  'Swedish Women Trials' =>
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS => 
    {
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-27',
        DATE_END => '2012-04-28'
      },
    }
  }
);

my %TOURNAMENTS_SWEDEN =
(
  "Chairman's Cup" =>
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
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
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-28',
            DATE_END => '2009-07-28'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-29',
            DATE_END => '2009-07-29'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-30',
            DATE_END => '2009-07-30'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-03',
            DATE_END => '2010-08-03'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-04',
            DATE_END => '2010-08-04'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-05',
            DATE_END => '2010-08-05'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-02',
            DATE_END => '2011-08-02'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-08-03',
            DATE_END => '2011-08-03'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-04',
            DATE_END => '2011-08-04'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-31',
            DATE_END => '2012-07-31'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-08-01',
            DATE_END => '2012-08-01'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-08-02',
            DATE_END => '2012-08-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-30',
            DATE_END => '2013-07-30'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-31',
            DATE_END => '2013-08-01'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-01',
            DATE_END => '2013-08-02'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-29',
            DATE_END => '2014-07-29'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-30',
            DATE_END => '2014-07-30'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-31',
            DATE_END => '2014-07-31'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-07-31',
            DATE_END => '2014-07-31'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-07-28',
            DATE_END => '2015-07-28'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-07-29',
            DATE_END => '2015-07-29'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-07-30',
            DATE_END => '2015-07-30'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-02',
            DATE_END => '2016-08-02'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-03',
            DATE_END => '2016-08-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-04'
          } 
        }
      },
    }
  },

  'Stockholm Teams',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CITY => 'Stockholm',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'MATCH',
            DATE_START => '2005-02-13',
            DATE_END => '2005-02-14'
          } 
        }
      },
    }
  },

  'Swedish Cup',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2014/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            DATE_START => '2014-11-20',
            DATE_END => '2014-11-20'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            DATE_START => '2014-11-20',
            DATE_END => '2014-11-20'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-11-21',
            DATE_END => '2014-11-21'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          } 
        }
      },
      '2015' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2015/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-11-12',
            DATE_END => '2015-11-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-12',
            DATE_END => '2015-11-12'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-13',
            DATE_END => '2015-11-13'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-13',
            DATE_END => '2015-11-14'
          } 
        }
      },
      '2016' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2016/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-10',
            DATE_END => '2016-11-13'
          } 
        }
      },
      '2016' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2016/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-10',
            DATE_END => '2016-11-13'
          } 
        }
      },
      '2017' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2017/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-16',
            DATE_END => '2017-11-19'
          } 
        }
      },
      '2018' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2018/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-18'
          } 
        }
      },
      '2019' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2021/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-14',
            DATE_END => '2019-11-17'
          } 
        }
      },
      '2020' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2020/final
        CITY => 'Online',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-11-12',
            DATE_END => '2020-11-15'
          } 
        }
      },
      '2021' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2021/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-11-11',
            DATE_END => '2021-11-14'
          } 
        }
      },
      '2022' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2022/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-11-10',
            DATE_END => '2022-11-13'
          } 
        }
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2023/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-11-16',
            DATE_END => '2023-11-19'
          } 
        }
      },
      '2024' =>
      {
        # https://www.svenskbridge.se/svenska-cupen-2024/final
        CITY => 'Uppsala',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-07',
            DATE_END => '2024-11-10'
          } 
        }
      },
    }
  },

  'Swedish District Teams',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'Regional',
    ZONE => 'Europe',
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
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-14',
            DATE_END => '2010-03-14'
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
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-26',
            DATE_END => '2011-02-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-03-13',
            DATE_END => '2011-03-13'
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
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-02-25',
            DATE_END => '2012-02-25'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2012-03-10',
            DATE_END => '2012-03-11'
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
            minor => 'SEGMENT',
            DATE_START => '2013-03-09',
            DATE_END => '2013-03-10'
          } 
        }
      },
    }
  },

  'Swedish Juniors Pairs',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

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
            major => 'SESSION',
            DATE_START => '2011-09-17',
            DATE_END => '2011-09-18'
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
            major => 'SESSION',
            DATE_START => '2012-09-15',
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
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-09-14',
            DATE_END => '2013-09-15'
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
            major => 'SESSION',
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-07'
          } 
        }
      },
    }
  },

  'Swedish Juniors Teams',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-03-14',
            DATE_END => '2005-03-14'
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
            major => 'ROUND',
            DATE_START => '2009-05-09',
            DATE_END => '2009-05-10'
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
            major => 'ROUND',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-02'
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
            DATE_START => '2011-05-07',
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
            major => 'ROUND',
            DATE_START => '2012-05-05',
            DATE_END => '2012-05-06'
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
            major => 'ROUND',
            DATE_START => '2014-05-17',
            DATE_END => '2014-05-18'
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
            major => 'ROUND',
            DATE_START => '2015-05-09',
            DATE_END => '2015-05-10'
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
            major => 'ROUND',
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-29'
          } 
        }
      },
    }
  },

  'Swedish Mixed Teams',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20'
          } 
        }
      },
    }
  },

  'Swedish Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-08-07',
            DATE_END => '2010-08-08'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2011-08-06',
            DATE_END => '2011-08-07'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-08-04',
            DATE_END => '2012-08-05'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-08-02',
            DATE_END => '2014-08-03'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-08-01',
            DATE_END => '2015-08-02'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Swedish Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-08-06',
            DATE_END => '2016-08-07'
          } 
        }
      },
    }
  },

  'Swedish Open Teams',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2004-06-01', # Dates probably wrong
            DATE_END => '2004-06-01'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2005-06-01', # Dates probably wrong
            DATE_END => '2005-06-02'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2006-06-02', # Dates probably wrong
            DATE_END => '2006-06-02'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-05-13',
            DATE_END => '2010-05-16'
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
            minor => 'SEGMENT',
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-20'
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
            minor => 'SEGMENT',
            DATE_START => '2013-05-09',
            DATE_END => '2013-05-12'
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
            minor => 'SEGMENT',
            DATE_START => '2014-05-29',
            DATE_END => '2014-06-01'
          } 
        }
      },
      '2015' =>
      {
        # https://www.svenskbridge.se/sm-lag-2015/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-05-14',
            DATE_END => '2015-05-17'
          } 
        }
      },
      '2016' =>
      {
        # https://www.svenskbridge.se/sm-lag-2016/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-05-05',
            DATE_END => '2016-05-08'
          } 
        }
      },
      '2017' =>
      {
        # https://www.svenskbridge.se/sm-lag-2017/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2017-05-25',
            DATE_END => '2017-05-28'
          } 
        }
      },
      '2018' =>
      {
        # https://www.svenskbridge.se/sm-lag-2018/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2018-05-10',
            DATE_END => '2018-06-13'
          } 
        }
      },
      '2019' =>
      {
        # https://www.svenskbridge.se/sm-lag-2022/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2019-05-30',
            DATE_END => '2019-06-02'
          } 
        }
      },
      '2021' =>
      {
        # https://www.svenskbridge.se/sm-lag-2021/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            CITY => 'Online',
            DATE_START => '2021-05-13',
            DATE_END => '2021-05-16'
          } 
        }
      },
      '2022' =>
      {
        # https://www.svenskbridge.se/sm-lag-2022/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2022-05-26',
            DATE_END => '2022-05-29'
          } 
        }
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/sm-lag-2023/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2023-05-18',
            DATE_END => '2023-05-21'
          } 
        }
      },
      '2024' =>
      {
        # https://www.svenskbridge.se/sm-lag-2024/final
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            CITY => 'Örebro',
            COUNTRY => 'Sweden',
            DATE_START => '2024-05-09',
            DATE_END => '2024-05-12'
          } 
        }
      },
    }
  },

  'Swedish Open Pair Trials',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
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
            major => 'ROUND',
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-01'
          } 
        }
      },
    }
  },

  'Swedish Open Team Trials',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
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
            major => 'ROUND',
            DATE_START => '2005-04-08',
            DATE_END => '2005-04-10'
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
            major => 'ROUND',
            DATE_START => '2015-04-24',
            DATE_END => '2015-04-26'
          } 
        }
      },
    }
  },

  'Swedish Premier League',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2008-12-12',
            DATE_END => '2008-12-14' # Dates estimated
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-13'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-12-11',
            DATE_END => '2010-12-12'
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
            minor => 'SEGMENT',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
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
            minor => 'SEGMENT',
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-09'
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
            minor => 'SEGMENT',
            DATE_START => '2013-10-11',
            DATE_END => '2013-10-13'
          } 
        }
      },
      '2014' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2014/div1-program
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-10-03',
            DATE_END => '2014-10-05'
          } 
        }
      },
      '2015' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2015/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-10-23',
            DATE_END => '2015-10-25'
          } 
        }
      },
      '2016' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2016/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-08-27',
            DATE_END => '2016-08-28'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-21',
            DATE_END => '2016-10-23'
          } 
        }
      },
      '2017' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2017/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-27',
            DATE_END => '2017-10-29'
          } 
        }
      },
      '2018' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2018/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-19',
            DATE_END => '2018-10-21'
          } 
        }
      },
      '2019' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2019/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-18',
            DATE_END => '2019-10-20'
          } 
        }
      },
      '2021' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2021/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-15',
            DATE_END => '2021-10-17'
          } 
        }
      },
      '2022' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2022/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-10-14',
            DATE_END => '2022-10-16'
          } 
        }
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2023/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-06',
            DATE_END => '2023-10-08'
          } 
        }
      },
      '2024' =>
      {
        # https://www.svenskbridge.se/allsvenskan-2024/div1
        CITY => 'Örebro',
        COUNTRY => 'Sweden',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-09-27',
            DATE_END => '2024-09-29'
          } 
        }
      },
    }
  },

  'Swedish Senior Team Trials',
  {
    ORGANIZATION => 'SBF',
    COUNTRY => 'Sweden',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-02-12',
            DATE_END => '2012-02-12'
          } 
        }
      },
    }
  },

  'Swedish Women Pair Trials',
  {
    FORM => 'Pairs',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Swedish Women Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-04-27',
            DATE_END => '2012-04-29'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SWEDEN, \%TOURNAMENTS_SWEDEN, 'Sweden');
}

1;
