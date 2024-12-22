#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Finland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# http://www.bridgefinland.fi/bilbo/results.php

my %GLOBAL = (
  ORGANIZATION => 'SBL',
  COUNTRY => 'Finland',
  ZONE => 'Europe',
);

my %MEETS_FINLAND =
(
  'Jyväskylä Easter Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Jyväskylä',

    EDITIONS =>
    {
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-03-28',
        DATE_END => '2005-03-29'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-04-02',
        DATE_END => '2008-04-02'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-04-10',
        DATE_END => '2009-04-10'
      },
    }
  },

  'Pärnu Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-10-22',
        DATE_END => '2007-10-22'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-07-16',
        DATE_END => '2008-07-16'
      }
    }
  },
);

my %TOURNAMENTS_FINLAND =
(
  'Finnish Cup' =>
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
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          },
        }
      },
      '2008' =>
      {
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          } 
        }
      },
      '2009' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=309
        CITY => 'Hanko',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2009-07-20',
            DATE_END => '2009-07-22'
          } 
        }
      },
      '2010' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=473
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-07-28',
            DATE_END => '2010-07-29'
          } 
        }
      },
      '2011' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=691
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'HALF',
            DATE_START => '2011-07-25',
            DATE_END => '2011-07-25'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2011-07-27',
            DATE_END => '2011-07-27'
          } 
        }
      },
      '2012' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=880
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-07-23',
            DATE_END => '2012-07-23'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-25',
            DATE_END => '2012-07-25'
          } 
        }
      },
      '2013' =>
      {
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-22',
            DATE_END => '2013-07-22'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-24',
            DATE_END => '2013-07-24'
          } 
        }
      },
      '2014' =>
      {
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-21',
            DATE_END => '2014-07-21'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-23',
            DATE_END => '2014-07-23'
          } 
        }
      },
      '2016' =>
      {
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-25',
            DATE_END => '2016-07-25'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-29',
            DATE_END => '2016-07-29'
          } 
        }
      },
    }
  },

  'Finnish Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SESSION|SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-14'
          } 
        }
      },
      '2007' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            ignore => 'TABLE',
            DATE_START => '2007-11-03',
            DATE_END => '2007-11-04'
          } 
        }
      },
      '2008' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          } 
        }
      },
      '2009' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-01'
          } 
        }
      },
      '2010' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=546
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-31'
          } 
        }
      },
      '2012' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=952
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          } 
        }
      },
      '2013' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1160
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND|SESSION|SEGMENT',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
          } 
        }
      },
      '2014' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1388
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-05'
          } 
        }
      },
      '2015' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1614
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          } 
        }
      },
      '2016' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1696
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-04-16',
            DATE_END => '2016-04-17'
          } 
        }
      },
    }
  },

  'Finnish Open Pair Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=547
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-13',
            DATE_END => '2010-11-13'
          } 
        }
      },
    }
  },

  'Finnish Open Teams' =>
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
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-05-13',
            DATE_END => '2006-05-14'
          } 
        }
      },
      '2007' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND|SEGMENT',
            DATE_START => '2007-04-14',
            DATE_END => '2007-04-15'
          } 
        }
      },
      '2008' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-04-12',
            DATE_END => '2008-04-13'
          } 
        }
      },
      '2009' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2009-05-16',
            DATE_END => '2009-05-17'
          } 
        }
      },
      '2010' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2010-05-22',
            DATE_END => '2010-05-23'
          } 
        }
      },
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'MATCH|ROUND',
            minor => 'SEGMENT|HALF',
            DATE_START => '2011-05-21',
            DATE_END => '2011-05-22'
          } 
        }
      },
      '2012' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2012-05-05',
            DATE_END => '2012-05-06'
          } 
        }
      },
      '2013' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'MATCH|ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-05-04',
            DATE_END => '2013-05-05'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          # http://www.bridgefinland.fi/bilbo/results.php?tid=1324
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'MATCH|ROUND',
            minor => 'HALF',
            DATE_START => '2014-05-17',
            DATE_END => '2014-05-19'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          # http://www.bridgefinland.fi/bilbo/results.php?tid=1500
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'MATCH|ROUND',
            minor => 'HALF',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-19'
          } 
        }
      },
    }
  },

  'Finnish Open Trials' =>
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
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-02-04',
            DATE_END => '2007-02-04'
          } 
        }
      },
      '2015' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1637
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-12-12',
            DATE_END => '2015-12-13'
          } 
        }
      },
    }
  },

  'Finnish Senior Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2009' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-01-05',
            DATE_END => '2009-01-05'
          } 
        }
      },
      '2010' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-17'
          } 
        }
      },
      '2013' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT',
            DATE_START => '2013-12-14',
            DATE_END => '2013-12-15'
          } 
        }
      },
    }
  },

  'Finnish Swiss Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=573
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-02-12',
            DATE_END => '2011-02-13'
          } 
        }
      },
      '2012' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=758
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-02-18',
            DATE_END => '2012-02-19'
          } 
        }
      },
      '2013' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=998
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17'
          } 
        }
      },
      '2014' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1257
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-06'
          } 
        }
      },
      '2015' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1515
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-05-23',
            DATE_END => '2015-05-24'
          } 
        }
      },
    }
  },

  'Finnish Women Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        # http://www.bridgefinland.fi/bilbo/results.php?tid=1638
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-12-12',
            DATE_END => '2015-12-13'
          } 
        }
      },
    }
  },

  'Hanko Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Hanko',
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
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-28'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-28'
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
            DATE_START => '2013-07-25',
            DATE_END => '2013-07-25'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Bronze',
            DATE_START => '2013-07-25',
            DATE_END => '2013-07-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-07-25',
            DATE_END => '2013-07-25'
          } 
        }
      },
    }
  },

  'Jyväskylä Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Jyväskylä Easter Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND|SEGMENT',
            DATE_START => '2005-03-28',
            DATE_END => '2005-03-29'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Jyväskylä Easter Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Jyväskylä Easter Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-10',
            DATE_END => '2009-04-10'
          },
        }
      },
    }
  },

  'Pärnu Summer Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    CITY => 'Pärnu',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'ROUND',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
    }
  },

  'Pärnu Summer Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Pärnu Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          } 
        }
      },
    }
  },

  'Puutalo Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Puutalo',
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
            major => 'ROUND',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
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
            major => 'ROUND',
            DATE_START => '2008-05-14',
            DATE_END => '2008-05-14'
          } 
        }
      },
    }
  },

  'Salo Midsummer Juniors Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'International',
    CITY => 'Salo',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U25',

    EDITIONS =>
    {
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-06-05',
            DATE_END => '2015-06-05'
          } 
        }
      },
    }
  },

  'Vadsø Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'International',
    CITY => 'Vadsø',
    FORM => 'Pairs',
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
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_FINLAND, \%TOURNAMENTS_FINLAND, 'Finland');
}

1;
