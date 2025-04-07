#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Switzerland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://fsbridge.ch/de/le-bridge/
# Not so easy to find results

my %GLOBAL = (
  ORGANIZATION => 'FSB',
  COUNTRY => 'Switzerland',
  ZONE => 'Europe',
);

my %MEETS_SWITZERLAND =
(
  'Zurich Open' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Zürich',

    EDITIONS => 
    {
      '2012' =>
      {
        DATE_START => '2012-03-01',
        DATE_END => '2012-03-04'
      },
      '2013' =>
      {
        DATE_START => '2013-03-01',
        DATE_END => '2013-03-03'
      },
      '2014' =>
      {
        DATE_START => '2014-03-07',
        DATE_END => '2014-03-09'
      },
    }
  }
);

my %TOURNAMENTS_SWITZERLAND =
(
  'Jean Besse Cup' =>
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
            DATE_START => '2010-06-13',
            DATE_END => '2010-06-13'
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
            DATE_START => '2011-06-12',
            DATE_END => '2011-06-12'
          } 
        }
      },
    }
  },

  'Swiss Club Championship' =>
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
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-11',
            DATE_END => '2005-12-11'
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
            major => 'SEGMENT',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-22',
            DATE_END => '2007-12-22'
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
            major => 'SEGMENT',
            DATE_START => '2010-01-10',
            DATE_END => '2010-01-10'
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
            DATE_START => '2011-12-11',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-09',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-15',
            DATE_END => '2013-12-15'
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
            major => 'SEGMENT',
            DATE_START => '2014-12-07',
            DATE_END => '2014-12-07'
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
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
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
            major => 'SEGMENT',
            DATE_START => '2016-12-04',
            DATE_END => '2016-12-04'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-12-03',
            DATE_END => '2017-12-03'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-02',
            DATE_END => '2018-12-02'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-19',
            DATE_END => '2019-10-20'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-10-20',
            DATE_END => '2019-10-20'
          } 
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
            DATE_START => '2021-11-06',
            DATE_END => '2021-11-06'
          },
          'C1' => 
          {
            YEAR => 2021,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2021-11-07',
            DATE_END => '2021-11-07'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-11-05',
            DATE_END => '2022-11-05'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-11-06',
            DATE_END => '2022-11-06'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-11-04',
            DATE_END => '2023-11-04'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-11-05',
            DATE_END => '2023-11-05'
          } 
        }
      },
    }
  },

  'Swiss Cup' =>
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
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-01',
            DATE_END => '2005-09-01'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-12',
            DATE_END => '2007-06-12'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-13',
            DATE_END => '2008-12-13'
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
            DATE_START => '2009-06-07',
            DATE_END => '2009-06-07'
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
            major => 'SEGMENT',
            DATE_START => '2010-06-13',
            DATE_END => '2010-06-13'
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
            DATE_START => '2012-05-28',
            DATE_END => '2012-05-28'
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
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-07'
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
            major => 'SEGMENT',
            DATE_START => '2014-06-11',
            DATE_END => '2014-06-11'
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
            DATE_START => '2015-06-23',
            DATE_END => '2015-06-23'
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
            major => 'SEGMENT',
            DATE_START => '2016-06-12',
            DATE_END => '2016-06-12'
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
            DATE_START => '2017-06-11',
            DATE_END => '2017-06-11'
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
            DATE_START => '2018-06-03',
            DATE_END => '2018-06-03'
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
            DATE_START => '2019-06-16',
            DATE_END => '2019-06-16'
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
            DATE_START => '2022-07-09',
            DATE_END => '2022-07-09'
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
            DATE_START => '2023-07-09',
            DATE_END => '2023-07-09'
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
            DATE_START => '2024-06-08',
            DATE_END => '2024-06-08'
          } 
        }
      },
    }
  },

  'Swiss Open IMP Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
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
            major => 'SESSION',
            DATE_START => '2015-05-30',
            DATE_END => '2015-05-30'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-04-16',
            DATE_END => '2016-04-17'
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
            major => 'SESSION',
            DATE_START => '2017-03-03',
            DATE_END => '2017-03-03'
          },
        }
      },
    }
  },

  'Swiss Open Pairs' =>
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
            major => 'SESSION',
            DATE_START => '2017-03-04',
            DATE_END => '2017-03-04'
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
            major => 'SESSION',
            DATE_START => '2018-03-17',
            DATE_END => '2018-03-17'
          },
        }
      },
    }
  },

  'Swiss Open Teams' =>
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
            major => 'ROUND|MATCH',
            DATE_START => '2015-05-31',
            DATE_END => '2015-05-31'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND|MATCH',
            DATE_START => '2016-04-17',
            DATE_END => '2016-04-17'
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
            major => 'ROUND|MATCH',
            DATE_START => '2017-03-05',
            DATE_END => '2017-03-05'
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
            major => 'ROUND|MATCH',
            DATE_START => '2018-03-18',
            DATE_END => '2018-03-18'
          },
        }
      },
    }
  },

  'Swiss Open Team Trials' =>
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
            DATE_START => '2020-02-22',
            DATE_END => '2020-02-23'
          },
        }
      },
    }
  },

  'Zurich Open Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Zurich Open',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-03-01',
            DATE_END => '2012-03-03'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Zurich Open',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-03-01',
            DATE_END => '2013-03-02'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Zurich Open',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          } 
        }
      },
    }
  },

  'Zurich Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Zurich Open',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-03'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND|SESSION',
            DATE_START => '2012-03-04',
            DATE_END => '2012-03-04'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Zurich Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-03-03',
            DATE_END => '2013-03-03'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Zurich Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND|SESSION',
            DATE_START => '2014-03-09',
            DATE_END => '2014-03-09'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SWITZERLAND, \%TOURNAMENTS_SWITZERLAND, 'Switzerland');
}

1;
