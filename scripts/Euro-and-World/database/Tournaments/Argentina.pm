#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Argentina;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# There does not seem to exist a good website for Argentinian results.

my %GLOBAL = (
 ORGANIZATION => 'ABA',
 COUNTRY => 'Argentina',
 ZONE => 'South America',
);

my %MEETS_ARGENTINA =
(
  'Mar del Plata Festival' =>
  {
    %GLOBAL,
    CITY => 'Mar del Plata',
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2002' =>
      {
        YEAR => 2002,
        DATE_START => '2002-12-07',
        DATE_END => '2002-12-15'
      },
      '2003' =>
      {
        YEAR => 2003,
        DATE_START => '2003-12-06',
        DATE_END => '2003-12-14'
      },
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-12-11',
        DATE_END => '2005-12-12'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-12-01',
        DATE_END => '2006-12-10'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-11-30',
        DATE_END => '2007-12-12'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-12-01',
        DATE_END => '2008-12-07'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-11-27',
        DATE_END => '2009-12-05'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-12-05',
        DATE_END => '2010-12-12'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-12-02',
        DATE_END => '2011-12-11'
      },
      '2012' =>
      {
        # Listed on Great Bridge Links as one week earlier.
        YEAR => 2012,
        DATE_START => '2012-11-30',
        DATE_END => '2012-12-09'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-12-06',
        DATE_END => '2015-12-06'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-12-06',
        DATE_END => '2019-12-15'
      },
      '2020' =>
      {
        YEAR => 2020, # Online
        DATE_START => '2020-11-28',
        DATE_END => '2020-12-06'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-12-03',
        DATE_END => '2021-12-11'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-12-02',
        DATE_END => '2022-12-10'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-12-09',
        DATE_END => '2023-12-11'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-12-22',
        DATE_END => '2024-12-23'
      },
    }
  }
);

my %TOURNAMENTS_ARGENTINA =
(
  'Argentinian Club Teams' =>
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
            major => 'SEGMENT',
            DATE_START => '2011-05-08',
            DATE_END => '2011-05-08'
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
            DATE_START => '2015-06-07',
            DATE_END => '2015-06-08'
          } 
        }
      }
    }
  },

  'Argentinian Copa Republica' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-29',
            DATE_END => '2009-11-29'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-29',
            DATE_END => '2009-11-29'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-05',
            DATE_END => '2010-12-05'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-06',
            DATE_END => '2015-12-06'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-09',
            DATE_END => '2023-12-09'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-12-10',
            DATE_END => '2023-12-10'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-12-22',
            DATE_END => '2024-12-23'
          } 
        }
      },
    }
  },

  'Argentinian Flags Day Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-20',
            DATE_END => '2007-06-20'
          } 
        }
      },
    }
  },

  'Argentinian Mixed Pairs' =>
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
            major => 'SESSION',
            DATE_START => '2016-03-20',
            DATE_END => '2016-03-20'
          } 
        }
      },
    }
  },

  'Argentinian Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            major => 'SEGMENT',
            DATE_START => '2011-08-28',
            DATE_END => '2011-08-28'
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
            DATE_START => '2016-08-21',
            DATE_END => '2016-08-22'
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
            DATE_START => '2017-07-23',
            DATE_END => '2017-07-23'
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
            major => 'SEGMENT',
            DATE_START => '2018-07-09',
            DATE_END => '2018-07-10'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-07-16',
            DATE_END => '2023-07-17'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-10-13',
            DATE_END => '2024-10-13'
          } 
        }
      },
    }
  },

  'Argentinian Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    # Unclear whether all these are the same tournament.
    EDITIONS =>
    {
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-02',
            DATE_END => '2009-05-02'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-03',
            DATE_END => '2009-05-03'
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
            DATE_START => '2010-04-18',
            DATE_END => '2010-04-18'
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
            DATE_START => '2011-05-28',
            DATE_END => '2011-05-29'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-05-06',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-28',
            DATE_END => '2013-07-28'
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
            DATE_START => '2016-05-15',
            DATE_END => '2016-05-15'
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
            DATE_START => '2017-04-23',
            DATE_END => '2017-04-23'
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
            major => 'SEGMENT',
            DATE_START => '2018-04-22',
            DATE_END => '2018-04-23'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-05-05',
            DATE_END => '2019-05-06'
          } 
        }
      },
    }
  },

  'Argentinian Open Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-12',
            DATE_END => '2006-08-12'
          } 
        }
      },
      '2007' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-04-23',
            DATE_END => '2007-04-23'
          } 
        }
      },
      '2009' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-28',
            DATE_END => '2009-03-01'
          } 
        }
      },
      '2010' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-06',
            DATE_END => '2010-11-06'
          },
        }
      },
      '2012A' =>
      {
        # https://csbnews.org/2013-argentine-trials-the-gran-final-1st-match-rizzo-angeleri/
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-04-14',
            DATE_END => '2012-04-15'
          },
        }
      },
      '2012B' =>
      {
        FORM => 'Pairs',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-25',
            DATE_END => '2012-10-28'
          },
        }
      },
      '2012' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-03',
            DATE_END => '2012-11-04'
          },
        }
      },
      '2017' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-03-05',
            DATE_END => '2017-03-06'
          },
        }
      },
      '2023A' =>
      {
        FORM => 'Pairs',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            SCORING => 'MP',
            DATE_START => '2023-06-02',
            DATE_END => '2023-06-03'
          },
        }
      },
      '2023B' =>
      {
        FORM => 'Pairs',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            SCORING => 'IMP',
            DATE_START => '2023-06-09',
            DATE_END => '2023-06-12'
          },
        }
      },
      '2024A' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-02-10',
            DATE_END => '2024-02-12'
          },
        }
      },
      '2024B' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-11',
            DATE_END => '2024-05-12'
          },
        }
      },
    }
  },

  'Argentinian Seniors Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2015' =>
      {
        # TODO vs Argentinian Senior Trials?!
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-11'
          } 
        }
      },
    }
  },

  'Argentinian Senior Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-11'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-05-18',
            DATE_END => '2024-05-18'
          } 
        }
      },
    }
  },

  'Argentinian Women Club Teams' =>
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-03',
            DATE_END => '2011-07-03'
          },
        }
      },
    }
  },

  'Argentinian Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-06',
            DATE_END => '2010-11-07'
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
            STAGE => 'Final',
            DATE_START => '2011-11-06',
            DATE_END => '2011-11-07'
          },
        }
      },
      '2012' =>
      {
        # https://csbnews.org/2013-argentine-trials-the-gran-final-1st-match-rizzo-angeleri/
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-11-04',
            DATE_END => '2012-11-05'
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
            DATE_START => '2024-02-11',
            DATE_END => '2024-02-13'
          },
          'C1' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-12',
            DATE_END => '2024-05-12'
          },
        }
      },
    }
  },

  'Copa Fundadores' =>
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
            DATE_START => '2023-05-12',
            DATE_END => '2023-05-14'
          },
        }
      },
    }
  },

  'Copa Zanalda River Plate' =>
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
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-11-12',
            DATE_END => '2009-11-12'
          },
        }
      }
    }
  },

  'Mar del Plata Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2005-12-11',
            DATE_END => '2005-12-12'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-11',
            DATE_END => '2005-12-12'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-11',
            DATE_END => '2005-12-12'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-10',
            DATE_END => '2006-12-10'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-12-10',
            DATE_END => '2006-12-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-12',
            DATE_END => '2010-12-12'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Mar del Plata Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2012-12-09',
            DATE_END => '2012-12-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-12-09',
            DATE_END => '2012-12-09'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ARGENTINA, \%TOURNAMENTS_ARGENTINA, 'Argentina');
}

1;
