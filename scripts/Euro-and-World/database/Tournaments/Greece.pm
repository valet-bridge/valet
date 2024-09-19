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

my %MEETS_GREECE =
(
);

my %TOURNAMENTS_GREECE =
(
  'Greek Central Regional Pairs' =>
  {
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Greek Mixed Pairs' =>
  {
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-03-19',
            DATE_END => '2010-03-20'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            minor => 'HALF',
            DATE_START => '2010-03-21',
            DATE_END => '2010-03-21'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            minor => 'HALF',
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
            major => 'SEGMENT',
            DATE_START => '2011-05-07',
            DATE_END => '2011-05-07'
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
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2010-01-22',
            DATE_END => '2010-01-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-29',
              DATE_END => '2010-01-31'
          },
        }
      },
    }
  },

  'Greek Open Team Trials' =>
  {
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'SEGMENT',
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
            major => 'SEGMENT',
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
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2016-02-26',
            DATE_END => '2016-02-28'
          },
        }
      },
    }
  },

  'Greek Women Pair Trials' =>
  {
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'ROUND',
            DATE_START => '2010-01-29',
            DATE_END => '2010-01-29'
          } 
        }
      },
    }
  },

  'Greek Women Team Trials' =>
  {
    ORGANIZATION => 'EOM',
    COUNTRY => 'Greece',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-05'
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
