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

my %MEETS_ARGENTINA =
(
  'Argentinian Trials' =>
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',

    EDITIONS => 
    {
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-14',
        DATE_END => '2012-11-05'
      },
    }
  },

  'Mar del Plata Festival' =>
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',

    EDITIONS => 
    {
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-12-17',
        DATE_END => '2006-12-17'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-12-05',
        DATE_END => '2012-12-08'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-12-06',
        DATE_END => '2015-12-06'
      },
    }
  }
);

my %TOURNAMENTS_ARGENTINA =
(
  'Argentinian Club Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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

  'Argentinian Copa Republica',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
    }
  },

  'Argentinian Flags Day Championship',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
            major => 'SEGMENT',
            DATE_START => '2007-06-20',
            DATE_END => '2007-06-20'
          } 
        }
      },
    }
  },

  'Argentinian Mixed Pairs',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
            STAGE => 'Session',
            DATE_START => '2016-03-20',
            DATE_END => '2016-03-20'
          } 
        }
      },
    }
  },

  'Argentinian Mixed Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
    }
  },

  'Argentinian Open Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
            major => 'SEGMENT',
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
    }
  },

  'Argentinian Open Trials',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
            DATE_START => '2006-08-12',
            DATE_END => '2006-08-12'
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
            FORM => 'Teams',
            SCORING => 'IMP',
            major => 'SEGMENT',
            DATE_START => '2007-04-23',
            DATE_END => '2007-04-23'
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
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-28',
            DATE_END => '2009-03-01'
          } 
        }
      },
      '2010' =>
      {
        # 
        MEET => 'Argentinian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-06',
            DATE_END => '2010-11-06'
          },
        }
      },
      '2012' =>
      {
        # https://csbnews.org/2013-argentine-trials-the-gran-final-1st-match-rizzo-angeleri/
        MEET => 'Argentinian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-14',
            DATE_END => '2012-04-15'
          },
          'C1' => 
          {
            YEAR => 2012,
            FORM => 'Pairs',
            SCORING => 'MP',
            DATE_START => '2012-10-25',
            DATE_END => '2012-10-28'
          },
          'C2' => 
          {
            YEAR => 2012,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-03',
            DATE_END => '2012-11-04'
          },
        }
      },
    }
  },

  'Argentinian Seniors Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Seniors',
    AGE => 'Open',

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

  'Argentinian Senior Trials',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-11'
          } 
        }
      },
    }
  },

  'Argentinian Women Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
          } 
        }
      },
    }
  },

  'Argentinian Women Trials',
  {
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Argentinian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            FORM => 'Teams',
            SCORING => 'IMP',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-06',
            DATE_END => '2010-11-07'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Argentinian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            DATE_START => '2011-11-06',
            DATE_END => '2011-11-07'
          },
        }
      },
      '2012' =>
      {
        # https://csbnews.org/2013-argentine-trials-the-gran-final-1st-match-rizzo-angeleri/
        MEET => 'Argentinian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            FORM => 'Teams',
            SCORING => 'IMP',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-04',
            DATE_END => '2012-11-05'
          },
        }
      },
    }
  },

  'Copa Zanalda River Plate',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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

  'Mar del Plata Open Teams',
  {
    ORGANIZATION => 'ABA',
    COUNTRY => 'Argentina',
    ORIGIN => 'National',
    ZONE => 'South America',
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
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
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
