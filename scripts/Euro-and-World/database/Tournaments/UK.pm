#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::UK;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_UK =
(
  'Meet name' =>
  {
    ORGANIZATION => 'ORG',
    COUNTRY => 'CTR',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2015' =>
      {
        # Link
        YEAR => 2000,
        CITY => 'Hamilton',
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  }
);

my %TOURNAMENTS_UK =
(
  'Camrose Trophy' => 
  {
    # https://www.bridgewebs.com/bgb/Camrose%20Winners.htm
    # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_Past%20Camrose%20Teams.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2002-03' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            major => 'MATCH',
            DATE_START => '2002-11-30',
            DATE_END => '2002-12-01'
          },
          'C1' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-01-02',
            DATE_END => '2003-01-02'
          },
          'C2' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-01-11',
            DATE_END => '2003-01-12'
          },
          'C3' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-02-01',
            DATE_END => '2003-02-02'
          },
          'C4' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-02-22',
            DATE_END => '2003-02-23'
          },
        }
      },
      '2003-04' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2003,
            major => 'ROUND',
            DATE_START => '2003-12-06',
            DATE_END => '2003-12-07'
          },
          'C1' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-01-10',
            DATE_END => '2004-01-11'
          },
          'C2' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-02-07',
            DATE_END => '2004-02-08'
          },
          'C3' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-02-21',
            DATE_END => '2004-02-22'
          },
          'C4' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-03-06',
            DATE_END => '2004-03-07'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            DATE_START => '2005-01-11',
            DATE_END => '2005-01-20'
          },
          'C1' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-03-06',
            DATE_END => '2005-03-07'
          },
          'C2' => 
          {
            YEAR => 2005,
            DATE_START => '2005-03-14',
            DATE_END => '2005-03-17'
          },
          'C3' => 
          {
            YEAR => 2005,
            DATE_START => '2005-03-25',
            DATE_END => '2005-03-28'
          },
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-01-07',
            DATE_END => '2006-01-08'
          },
          'C1' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-03-03',
            DATE_END => '2006-03-05'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-01-05',
            DATE_END => '2007-01-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2007-03-04',
            DATE_END => '2007-03-04'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2008-01-12',
            DATE_END => '2008-01-13'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-03-06',
            DATE_END => '2009-03-08'
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
            major => 'MATCH',
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-10'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2010-03-05',
            DATE_END => '2010-03-07'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-07',
            DATE_END => '2011-01-09'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2011-03-04',
            DATE_END => '2011-03-06'
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
            minor => 'SEGMENT',
            DATE_START => '2012-01-06',
            DATE_END => '2012-01-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-04'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2013-01-04',
            DATE_END => '2013-01-06'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2013-03-01',
            DATE_END => '2013-03-03'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2014-01-10',
            DATE_END => '2014-01-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-09'
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
            DATE_START => '2015-01-09',
            DATE_END => '2015-01-11'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-01-22',
            DATE_END => '2015-01-25'
          },
          'C2' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-08'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-10'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'Teltscher Trophy' => 
  {
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            DATE_START => '2000-11-30',
            DATE_END => '2000-12-01'
          },
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_UK, \%TOURNAMENTS_UK, 'United Kingdom');
}

1;
