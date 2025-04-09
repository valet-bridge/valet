#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Spain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# The Spanish results seem to be paywalled or not searchable.
# https://www.aebridge.com/es

my %GLOBAL = (
  ORGANIZATION => 'AEB',
  COUNTRY => 'Spain',
  ZONE => 'Europe',
);

my %MEETS_SPAIN =
(
);

my %TOURNAMENTS_SPAIN =
(
  'Las Palmas Simultaneous Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Las Palmas',
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
            DATE_START => '2013-05-30',
            DATE_END => '2013-05-30'
          } 
        }
      },
    }
  },

  'Las Palmas Women Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Las Palmas',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
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
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-26'
          } 
        }
      },
    }
  },

  'Madrid Senior Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Madrid',
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
            major => 'ROUND',
            DATE_START => '2016-05-15',
            DATE_END => '2016-05-15'
          } 
        }
      },
    }
  },

  'Mutton Individual Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            major => 'SESSION',
            ignore => 'TABLE',
            DATE_START => '2019-08-20',
            DATE_END => '2019-08-24'
          },
        }
      },
      '2020' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            major => 'SESSION',
            DATE_START => '2020-08-13',
            DATE_END => '2020-08-15'
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
            major => 'SESSION',
            DATE_START => '2022-04-21',
            DATE_END => '2022-04-23'
          },
        }
      },
      '2022B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            major => 'SESSION',
            DATE_START => '2022-09-29',
            DATE_END => '2022-10-01'
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
            DATE_START => '2023-08-04',
            DATE_END => '2023-08-05'
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
            major => 'SESSION',
            DATE_START => '2024-08-22',
            DATE_END => '2024-08-24'
          },
        }
      },
    }
  },

  'Open Catalunya Preferent Pairs',
  {
    # https://www.bridge.cat/
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        ORDINAL => 53,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-10-06',
            DATE_END => '2009-10-06'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-10-19',
            DATE_END => '2009-10-19'
          },
          'C2' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-10-26',
            DATE_END => '2009-10-26'
          },
          'C3' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-11-02',
            DATE_END => '2009-11-02'
          },
          'C4' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-11-09',
            DATE_END => '2009-11-09'
          },
          'C5' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-11-23',
            DATE_END => '2009-11-23'
          },
          'C6' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-11-30',
            DATE_END => '2009-11-30'
          },
        }
      },
    }
  },

  'Open Catalunya Preferent Teams',
  {
    # https://www.bridge.cat/
    %GLOBAL,
    ORIGIN => 'Regional',
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
            minor => 'SEGMENT',
            DATE_START => '2010-01-11',
            DATE_END => '2010-01-11'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-01-18',
            DATE_END => '2010-01-18'
          },
          'C2' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-01-25',
            DATE_END => '2010-01-25'
          },
          'C3' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-01',
            DATE_END => '2010-02-01'
          },
          'C4' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-08',
            DATE_END => '2010-02-08'
          },
          'C5' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-15',
            DATE_END => '2010-02-15'
          },
          'C6' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-01',
            DATE_END => '2010-03-01'
          },
          'C7' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-15',
            DATE_END => '2010-03-16'
          },
        }
      },
      '2011' =>
      {
        ORDINAL => 53,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-10',
            DATE_END => '2011-01-12'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-17',
            DATE_END => '2011-01-17'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-24',
            DATE_END => '2011-01-24'
          },
          'C3' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-31',
            DATE_END => '2011-01-31'
          },
          'C4' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-07',
            DATE_END => '2011-02-07'
          },
          'C5' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-14',
            DATE_END => '2011-02-14'
          },
          'C6' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-21',
            DATE_END => '2011-02-21'
          },
          'C7' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-28',
            DATE_END => '2011-02-28'
          },
          'C8' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-03-07',
            DATE_END => '2011-03-07'
          }
        }
      },
    }
  },

  'Spanish Central Zone Teams',
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
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-06-10',
            DATE_END => '2016-06-12'
          } 
        }
      },
    }
  },

  'Spanish Mixed Teams',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-01-15',
            DATE_END => '2016-01-17'
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
            major => 'ROUND',
            DATE_START => '2017-04-01',
            DATE_END => '2017-04-01'
          } 
        }
      },
    }
  },

  'Spanish Open Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            DATE_START => '2008-12-12',
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-13'
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
            major => 'ROUND',
            DATE_START => '2010-12-10',
            DATE_END => '2010-12-12'
          },
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-15',
            DATE_END => '2011-12-17'
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
            DATE_START => '2012-12-10',
            DATE_END => '2012-12-11'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-16'
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
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-22'
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
            DATE_START => '2014-12-20',
            DATE_END => '2014-12-21'
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
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-20'
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
            major => 'ROUND',
            DATE_START => '2016-12-17',
            DATE_END => '2016-12-18'
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
            major => 'ROUND',
            DATE_START => '2017-12-15',
            DATE_END => '2017-12-17'
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
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2018-12-15',
            DATE_END => '2018-12-16'
          } 
        }
      },
      '2019' =>
      {
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND|MATCH',
            DATE_START => '2019-12-12',
            DATE_END => '2019-12-14'
          } 
        }
      },
    }
  },

  'Spanish Open Trials',
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
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-06',
            DATE_END => '2016-05-08'
          } 
        }
      },
    }
  },

  'Spanish Senior Trials',
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
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-03-18',
            DATE_END => '2016-03-20'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SPAIN, \%TOURNAMENTS_SPAIN, 'Spain');
}

1;
