#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Greece;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Can in principle try to find tournaments by guessing the 
# tournament number from https://hellasbridge.org/results?page=6732
# with Google Translate, but cumbersome.  At the moment there are
# about 7130 pages.

my %GLOBAL =
(
  ORGANIZATION => 'EOM',
  COUNTRY => 'Greece',
  ZONE => 'Europe',
);

my %MEETS_GREECE =
(
  'Greek Islands Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET_ORDINAL =>  2,
        YEAR => 2007,
        REGION => 'Crete',
        DATE_START => '2007-09-02',
        DATE_END => '2007-09-02'
      },
      '2008' =>
      {
        MEET_ORDINAL => 3,
        SPONSOR => 'Fantoni Vacations',
        YEAR => 2008,
        DATE_START => '2008-09-10',
        DATE_END => '2008-09-10'
      },
      '2009' =>
      {
        MEET_ORDINAL => 4,
        SPONSOR => 'Fantoni Vacations',
        YEAR => 2009,
        REGION => 'Rhodes',
        DATE_START => '2009-08-17',
        DATE_END => '2009-08-22'
      },
      '2010' =>
      {
        MEET_ORDINAL => 5,
        SPONSOR => 'Fantoni Vacations',
        YEAR => 2010,
        DATE_START => '2010-08-29',
        DATE_END => '2010-09-03'
      },
      '2011' =>
      {
        MEET_ORDINAL => 6,
        SPONSOR => 'Fantoni Vacations',
        YEAR => 2011,
        DATE_START => '2011-08-28',
        DATE_END => '2011-09-03'
      },
      '2012' =>
      {
        MEET_ORDINAL => 7,
        YEAR => 2012,
        DATE_START => '2012-08-30',
        DATE_END => '2012-08-31'
      },
      '2013' =>
      {
        MEET_ORDINAL => 8,
        YEAR => 2013,
        DATE_START => '2013-09-06',
        DATE_END => '2013-09-07'
      },
      '2014' =>
      {
        MEET_ORDINAL => 9,
        YEAR => 2014,
        DATE_START => '2014-08-29',
        DATE_END => '2014-08-30'
      },
      '2015' =>
      {
        MEET_ORDINAL => 10,
        YEAR => 2015,
        DATE_START => '2015-09-09',
        DATE_END => '2015-09-10'
      },
      '2016' =>
      {
        MEET_ORDINAL => 11,
        YEAR => 2016,
        DATE_START => '2016-08-25',
        DATE_END => '2016-08-26'
      },
    }
  },
);

my %TOURNAMENTS_GREECE =
(
  'Greek Central Regional Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # https://hellasbridge.org/results/36862
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-25'
          } 
        }
      },
    }
  },

  'Greek Islands Mixed Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'SESSION',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'SESSION',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-08-20',
            DATE_END => '2009-08-20'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-09-01',
            DATE_END => '2010-09-01'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-08-31',
            DATE_END => '2011-09-01'
          },
        }
      },
    }
  },

  'Greek Islands Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'SESSION|SEGMENT',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'SESSION',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-08-17',
            DATE_END => '2009-08-19'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-08-29',
            DATE_END => '2010-08-31'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-08-28',
            DATE_END => '2011-08-30'
          },
        }
      },
    }
  },

  'Greek Islands Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-09-02',
            DATE_END => '2007-09-02'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND|SESSION',
            DATE_START => '2009-08-21',
            DATE_END => '2009-08-22'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-02',
            DATE_END => '2010-09-03'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-02',
            DATE_END => '2011-09-03'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-08-30',
            DATE_END => '2012-08-31'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND|SESSION',
            DATE_START => '2013-09-06',
            DATE_END => '2013-09-07'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND|SESSION',
            DATE_START => '2014-08-29',
            DATE_END => '2014-08-30'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-09-09',
            DATE_END => '2015-09-10'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Greek Islands Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-08-25',
            DATE_END => '2016-08-26'
          },
        }
      },
    }
  },

  'Greek Mixed Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # https://hellasbridge.org/results/34618
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-05-20',
            DATE_END => '2011-05-22'
          } 
        }
      },
    }
  },

  'Greek Northern Regional' =>
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
            DATE_START => '2006-05-01',
            DATE_END => '2006-05-02'
          } 
        }
      },
    }
  },
  
  'Greek Open Teams' =>
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
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-03-19',
            DATE_END => '2010-03-20'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'HALF|SEGMENT',
            DATE_START => '2010-03-21',
            DATE_END => '2010-03-21'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2010-03-21',
            DATE_END => '2010-03-21'
          } 
        }
      },
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2011-05-06',
            DATE_END => '2011-05-07'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-07',
            DATE_END => '2011-05-08'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Bronze',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-05-07',
            DATE_END => '2011-05-07'
          } 
        }
      },
      '2013' =>
      {
        ORDINAL => 47,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-06'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-06',
            DATE_END => '2013-04-07'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 48,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-05'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-06'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 49,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-03',
            DATE_END => '2015-04-05'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 50,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-08',
            DATE_END => '2016-04-10'
          } 
        }
      },
    }
  },

  'Greek Open Pair Trials' =>
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2010-01-22',
            DATE_END => '2010-01-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-01-29',
            DATE_END => '2010-01-31'
          },
        }
      },
    }
  },

  'Greek Open Team Trials' =>
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
            major => 'ROUND|SEGMENT',
            DATE_START => '2006-02-25',
            DATE_END => '2006-02-26'
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
            major => 'SEGMENT',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          } 
        }
      },
      ,
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-20',
            DATE_END => '2012-01-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-05'
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
            minor => 'SEGMENT',
            DATE_START => '2014-02-07',
            DATE_END => '2014-02-09'

          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2014-02-21',
            DATE_END => '2014-02-23'
          },
          'C2' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-03-08',
            DATE_END => '2014-03-09'
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
            STAGE => 'Qualifying',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-02-12',
            DATE_END => '2016-02-14'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            ignore => 'SESSION',
            DATE_START => '2016-02-26',
            DATE_END => '2016-02-28'
          },
        }
      },
    }
  },

  'Greek Women Pair Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
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
            major => 'SESSION',
            DATE_START => '2010-01-29',
            DATE_END => '2010-01-29'
          } 
        }
      },
    }
  },

  'Greek Women Team Trials' =>
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
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-05'
          } 
        }
      },
    }
  },
  
  'Thanos Capayiannides Memorial Simultaneous' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2010-03-17',
            DATE_END => '2010-03-17'
          } 
        }
      },
    }
  },
  
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_GREECE, \%TOURNAMENTS_GREECE, 'Greece');
}

1;
