#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Taipei;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Some names here:
# https://www.ctcba.org.tw/masterpoints.php?lmenuid=3
#
# Chinese Taipei is the Chinese name for Taiwan.
# Taipei is the capital of Taiwan.

my %GLOBAL = (
  ORGANIZATION => 'CTCBA',
  COUNTRY => 'Chinese Taipei',
  ZONE => 'South East Asia'
);

my %MEETS_TAIPEI =
(
);

my %TOURNAMENTS_TAIPEI =
(
  'Antonio Chong Cup' => 
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
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-24'
          } 
        }
      },
    }
  },

  'NCCU Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-06-29',
            DATE_END => '2017-06-29'
          },
          'C1' =>
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-06-29',
            DATE_END => '2017-06-29'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-07-03',
            DATE_END => '2018-07-03'
          },
        }
      },
      '2019' =>
      {
        ORDINAL => 15,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-07-01',
            DATE_END => '2019-07-02'
          },
          'C1' =>
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-07-02',
            DATE_END => '2019-07-02'
          },
        }
      },
    }
  },

  'NTU Cup' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-02-01',
            DATE_END => '2006-02-01'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-02-01',
            DATE_END => '2006-02-01'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-02-01',
            DATE_END => '2006-02-01'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-02-04',
            DATE_END => '2007-02-04'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-02-04',
            DATE_END => '2007-02-04'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-02-04',
            DATE_END => '2007-02-04'
          },
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
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-27',
            DATE_END => '2010-01-27'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-27',
            DATE_END => '2010-01-27'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-28',
            DATE_END => '2010-01-28'
          },
        }
      },
      '2011' =>
      {
        ORDINAL => 18,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-01-26',
            DATE_END => '2011-01-26'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-01-26',
            DATE_END => '2011-01-26'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-27',
            DATE_END => '2011-01-27'
          },
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
            DATE_START => '2012-02-08',
            DATE_END => '2012-02-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-08',
            DATE_END => '2012-02-08'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2012-02-09',
            DATE_END => '2012-02-09'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-08',
            DATE_END => '2012-02-09'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-24',
            DATE_END => '2013-01-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-24',
            DATE_END => '2013-01-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-25',
            DATE_END => '2013-01-25'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-23',
            DATE_END => '2014-01-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-23',
            DATE_END => '2014-01-24'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-24',
            DATE_END => '2014-01-24'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-23'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-23'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-26',
            DATE_END => '2016-01-26'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-26',
            DATE_END => '2016-01-27'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-27',
            DATE_END => '2016-01-27'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-02-07',
            DATE_END => '2017-02-07'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-02-08',
            DATE_END => '2017-02-08'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-02-08',
            DATE_END => '2017-02-08'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-01-30',
            DATE_END => '2018-01-30'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-01-31',
            DATE_END => '2018-01-31'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-01-31',
            DATE_END => '2018-01-31'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-01-22',
            DATE_END => '2019-01-22'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-01-23',
            DATE_END => '2019-01-23'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-01-23',
            DATE_END => '2019-01-23'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2020-01-21',
            DATE_END => '2020-01-22'
          },
          'C1' => 
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-01-22',
            DATE_END => '2020-01-22'
          },
        }
      },
      '2021' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2021-01-20',
            DATE_END => '2021-01-21'
          },
          'C1' => 
          {
            YEAR => 2021,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2021-01-21',
            DATE_END => '2021-01-21'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-02-01',
            DATE_END => '2023-02-01'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-02-02',
            DATE_END => '2023-02-02'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-01-24',
            DATE_END => '2024-01-24'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2024-01-25',
            DATE_END => '2024-01-25'
          },
        }
      },
    }
  },

  'Taiwan School Open Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2020-08-30',
            DATE_END => '2020-08-30'
          },
        }
      },
    }
  },

  'Taiwan University Open Cup' => 
  {
    %GLOBAL,
    ORIGIN => 'University',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2004' =>
      {
        # Probably in reality more like April 2004.
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
          },
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-02'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-10-14',
            DATE_END => '2018-10-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-10-14',
            DATE_END => '2018-10-14'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2020-10-18',
            DATE_END => '2020-10-18'
          },
        }
      },
    }
  },

  'Taiwan University Teachers Cup' => 
  {
    %GLOBAL,
    ORIGIN => 'University',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-02'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2018-10-14',
            DATE_END => '2018-10-14'
          },
        }
      },
    }
  },

  'Taiwan University Women Cup' => 
  {
    %GLOBAL,
    ORIGIN => 'University',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U31',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Probably in reality more like April 2004.
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

  'Taiwanese Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-12-05',
            DATE_END => '2020-12-06'
          },
        }
      },
      '2021' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2021-12-11',
            DATE_END => '2021-12-12'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-12-10',
            DATE_END => '2022-12-11'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-11-18',
            DATE_END => '2023-11-19'
          },
        }
      },
    }
  },

  'Taiwanese Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
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
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2024-12-07',
            DATE_END => '2024-12-08'
          },
        }
      },
    }
  },

  'Taiwanese Open Teams' =>
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-11-21',
            DATE_END => '2020-11-22'
          },
        }
      },
      '2021' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2021-11-27',
            DATE_END => '2021-11-28'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-11-19',
            DATE_END => '2022-11-20'
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2023-11-04',
            DATE_END => '2023-11-05'
          },
        }
      },
    }
  },

  'Taiwanese Open Trials' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-04-17',
            DATE_END => '2004-04-18'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-03-20',
            DATE_END => '2008-03-20'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2009-03-20',
            DATE_END => '2009-03-22'
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-02-26',
            DATE_END => '2010-02-28'
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
            major => 'SEGMENT',
            DATE_START => '2011-02-20',
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
            major => 'SEGMENT',
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-04'
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
            major => 'SEGMENT',
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-27'
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2014-02-22',
            DATE_END => '2014-02-23'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-27',
            DATE_END => '2014-12-28'
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
            major => 'SEGMENT',
            DATE_START => '2015-12-26',
            DATE_END => '2015-12-27'
          } 
        }
      },
      '2016-17' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-12-31',
            DATE_END => '2017-01-01'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-01-06',
            DATE_END => '2018-01-07'
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
            major => 'ROUND',
            DATE_START => '2018-12-01',
            DATE_END => '2018-12-02'
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
            STAGE => 'Knock-out',
            major => 'ROUND',
            DATE_START => '2019-12-07',
            DATE_END => '2019-12-08'
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
            STAGE => 'Knock-out',
            major => 'SEGMENT|ROUND',
            DATE_START => '2024-11-23',
            DATE_END => '2024-11-24'
          } 
        }
      },
    }
  },

  'Taiwanese Senior Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-01-13',
            DATE_END => '2018-01-14'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-12-26',
            DATE_END => '2020-12-27'
          },
        }
      },
      '2022A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-01-08',
            DATE_END => '2022-01-09'
          },
        }
      },
      '2022B' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-10-08',
            DATE_END => '2022-10-08'
          },
          'C1' =>
          {
            YEAR => 2022,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-10-09',
            DATE_END => '2022-10-10'
          },
        }
      },
    }
  },

  'Taiwanese Senior Trials' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-10'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-12-29',
            DATE_END => '2019-12-29'
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
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2022-10-30',
            DATE_END => '2022-10-31'
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
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2023-12-02',
            DATE_END => '2023-12-03'
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
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2024-11-16',
            DATE_END => '2024-11-17'
          },
        }
      },
    }
  },

  'Taiwanese Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-01-01',
            DATE_END => '2022-01-02'
          },
        }
      },
    }
  },

  'Taiwanese Youngster Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-12-29',
            DATE_END => '2019-12-29'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_TAIPEI, \%TOURNAMENTS_TAIPEI, 'Chinese Taipei');
}

1;
