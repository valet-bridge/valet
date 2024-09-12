#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Romania;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://www.frbridge.ro/rezultate/index.html


my %MEETS_ROMANIA =
(
);

my %TOURNAMENTS_ROMANIA =
(
  'Romanian League',
  {
    ORGANIZATION => 'FRB',
    COUNTRY => 'Romania',
    ORIGIN => 'National',
    ZONE => 'Europe Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004-05' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-29'
          } 
        }
      },
      '2010-11' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-26',
            DATE_END => '2010-11-28'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-20'
          } 
        }
      },
      '2011-12' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-11-04',
            DATE_END => '2011-11-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-11',
            DATE_END => '2012-05-13'
          }
        }
      },
      '2012-13' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-11-30',
            DATE_END => '2012-12-02'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-02-22',
            DATE_END => '2013-02-24'
          }
        }
      },
      '2013-14' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-03'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-16'
          }
        }
      },
      '2014-15' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-11-28',
            DATE_END => '2014-11-30'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-15'
          } 
        }
      },
      '2015-16' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-22'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          } 
        }
      },
    }
  },

  'Romanian Open Teams',
  {
    ORGANIZATION => 'FRB',
    COUNTRY => 'Romania',
    ORIGIN => 'National',
    ZONE => 'Europe Pacific',
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
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-06-03',
            DATE_END => '2005-06-04'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-04',
            DATE_END => '2005-06-05'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-05-21',
            DATE_END => '2010-05-22'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-22',
            DATE_END => '2010-05-23'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-12'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-12'
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
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-10'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-10'
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
            DATE_START => '2013-06-07',
            DATE_END => '2013-06-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-08',
            DATE_END => '2013-06-09'
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
            DATE_START => '2014-06-06',
            DATE_END => '2014-06-07'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-06-07',
            DATE_END => '2014-06-08'
          } 
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
            DATE_START => '2015-06-05',
            DATE_END => '2015-06-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-06',
            DATE_END => '2015-06-07'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-05'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-05'
          } 
        }
      },
    }
  },

  'Romanian Open Trials',
  {
    ORGANIZATION => 'FRB',
    COUNTRY => 'Romania',
    ORIGIN => 'National',
    ZONE => 'Europe Pacific',
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
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-21'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-27'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
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
            DATE_START => '2012-01-27',
            DATE_END => '2012-01-29'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-18',
            DATE_END => '2012-02-19'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-26',
            DATE_END => '2012-02-27'
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
            major => 'ROUND',
            DATE_START => '2014-02-22',
            DATE_END => '2014-02-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
          } 
        }
      },
    }
  },

  'Romanian Second League',
  {
    ORGANIZATION => 'FRB',
    COUNTRY => 'Romania',
    ORIGIN => 'National',
    ZONE => 'Europe Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CITY => 'Brasov',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-10-17',
            DATE_END => '2009-10-18'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ROMANIA, \%TOURNAMENTS_ROMANIA, 'Romania');
}

1;
