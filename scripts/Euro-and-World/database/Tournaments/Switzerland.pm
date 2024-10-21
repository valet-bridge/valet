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


my %MEETS_SWITZERLAND =
(
  'Zurich Open' =>
  {
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    CITY => 'Zurich',

    EDITIONS => 
    {
      '2012' =>
      {
        DATE_START => '2012-03-02',
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
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
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
    }
  },

  'Swiss Cup' =>
  {
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
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
    }
  },

  'Swiss Open IMP Pairs' =>
  {
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
    }
  },

  'Swiss Open Teams' =>
  {
    ORGANIZATION => 'FSB',
    COUNTRY => 'Switzerland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            major => 'SESSION',
            DATE_START => '2016-04-17',
            DATE_END => '2016-04-17'
          },
        }
      },
    }
  },

  'Zurich Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Zurich Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
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
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Zurich Open',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-02',
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
