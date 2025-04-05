#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Chile;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# TODO Results missing.
# https://fcb.cl/
# https://fcb.cl/uncategorized/seleccion-libre-2024/
# https://fcb.cl/resultados/2022-12-03l.htm
# https://fcb.cl/resultados/2022-12-10.htm
# There is an archive, but how to search?

my %GLOBAL = (
  ORGANIZATION => 'FCB',
  COUNTRY => 'Chile',
  ZONE => 'South America',
);

my %MEETS_CHILE =
(
);

my %TOURNAMENTS_CHILE =
(
  'Chilean Copa de Oro' =>
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
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-17',
            DATE_END => '2011-03-17'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-24',
            DATE_END => '2011-03-24'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-22',
            DATE_END => '2012-03-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-29',
            DATE_END => '2012-03-29'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-12',
            DATE_END => '2013-04-12'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-11',
            DATE_END => '2014-04-11'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-10'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-05',
            DATE_END => '2016-04-05'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-04-07',
            DATE_END => '2017-04-07'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-04-13',
            DATE_END => '2018-04-13'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-04-02',
            DATE_END => '2019-04-02'
          },
        }
      },
    }
  },

  'Chilean Copa de Plata' =>
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-12',
            DATE_END => '2013-04-12'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-04-07',
            DATE_END => '2017-04-07'
          },
        }
      }
    }
  },

  'Chilean Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2012-11-29',
            DATE_END => '2012-12-03'
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
            major => 'SESSION',
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-04'
          } 
        }
      }
    }
  },

  'Chilean Invitational Teams' =>
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-04-02',
            DATE_END => '2011-04-02'
          } 
        }
      },
    }
  },

  'Chilean Junior Teams' =>
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
            DATE_START => '2016-12-27',
            DATE_END => '2016-12-27'
          },
        }
      },
    }
  },

  'Chilean Mixed Trials' =>
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
            DATE_START => '2024-03-10',
            DATE_END => '2024-03-11'
          },
        }
      },
    }
  },

  'Chilean Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            DATE_START => '2013-12-09',
            DATE_END => '2013-12-12'
          } 
        }
      }
    }
  },

  'Chilean Open Teams' =>
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-21'
          } 
        }
      },
      '2018' =>
      {
        REGION => 'Comandatuba',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-03-03',
            DATE_END => '2018-03-05'
          },
        }
      },
    }
  },

  'Chilean Open Trials' =>
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
            DATE_START => '2010-11-20',
            DATE_END => '2010-11-21'
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
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-10'
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
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-17',
            DATE_END => '2012-06-18'
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
            DATE_START => '2017-03-12',
            DATE_END => '2017-03-13'
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
            DATE_START => '2018-12-09',
            DATE_END => '2018-12-09'
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
            DATE_START => '2022-12-05',
            DATE_END => '2022-12-05'
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
            DATE_START => '2024-03-01',
            DATE_END => '2024-03-04'
          },
        }
      },
    }
  },

  'Chilean Senior Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

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
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-13'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-04-14',
            DATE_END => '2013-04-15'
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
            DATE_START => '2017-12-08',
            DATE_END => '2017-12-10'
          },
        }
      },
    }
  },

  'Chilean Senior Trials' =>
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
            DATE_START => '2017-03-05',
            DATE_END => '2017-03-06'
          },
        }
      },
    }
  },

  'Chilean Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-21'
          } 
        }
      }
    }
  },

  'Chilean Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            major => 'ROUND',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-10'
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
            DATE_START => '2012-06-17',
            DATE_END => '2012-06-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-18',
            DATE_END => '2012-06-18'
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
            DATE_START => '2023-12-17',
            DATE_END => '2023-12-18'
          },
        }
      },
    }
  },

  'Vitacura Open Teams Cup' =>
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
            DATE_START => '2022-11-20',
            DATE_END => '2022-11-21'
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
            DATE_START => '2023-11-12',
            DATE_END => '2023-11-13'
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
            DATE_START => '2024-11-24',
            DATE_END => '2024-11-25'
          },
        }
      },
    }
  },

  'Vitacura Women Teams Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2023-11-12',
            DATE_END => '2023-11-13'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CHILE, \%TOURNAMENTS_CHILE, 'Chile');
}

1;
