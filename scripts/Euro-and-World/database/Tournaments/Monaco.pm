#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Monaco;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'FMB',
  COUNTRY => 'Monaco',
  ZONE => 'Europe',
);

my %MEETS_MONACO =
(
  'Monaco International Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Monte Carlo',

    EDITIONS =>
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-11-05',
        DATE_END => '2004-11-07'
      },
      '2007' =>
      {
        # http://www.federation-bridge.mc/article.php3?id_article=8
        # Wayback
        YEAR => 2007,
        DATE_START => '2007-11-09',
        DATE_END => '2007-11-11'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-11-07',
        DATE_END => '2008-11-09'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-10-09',
        DATE_END => '2009-10-11'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-10-08',
        DATE_END => '2010-10-10'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-10-14',
        DATE_END => '2011-10-16'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-10-12',
        DATE_END => '2012-10-14'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-10-18',
        DATE_END => '2013-10-20'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-09-05',
        DATE_END => '2014-09-07'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-10-16',
        DATE_END => '2015-10-18'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-10-16',
        DATE_END => '2016-10-23'
      },
    }
  },
);

my %TOURNAMENTS_MONACO =
(
  'Patton de Monaco' => 
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND|MATCH',
            ignore => 'TABLE',
            DATE_START => '2007-11-10',
            DATE_END => '2007-11-10'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|HALF',
            DATE_START => '2007-11-11',
            DATE_END => '2007-11-11'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT|HALF',
            DATE_START => '2007-11-11',
            DATE_END => '2007-11-11'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-11-11',
            DATE_END => '2007-11-11'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|TABLE',
            DATE_START => '2008-11-09',
            DATE_END => '2008-11-09'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-11-09',
            DATE_END => '2008-11-09'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-11-09',
            DATE_END => '2008-11-09'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-09',
            DATE_END => '2008-11-09'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            ignore => 'GROUP',
            DATE_START => '2009-10-09',
            DATE_END => '2009-10-10'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-10-11',
            DATE_END => '2009-10-11'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-10-11',
            DATE_END => '2009-10-11'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-11',
            DATE_END => '2009-10-11'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-10-14',
            DATE_END => '2011-10-14'
          },
          'C1' => 
          {
            YEAR => 2011,
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2011-10-15',
            DATE_END => '2011-10-15'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-16'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-16'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-10-16',
            DATE_END => '2011-10-16'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            groupon => 'GROUP',
            major => 'ROUND',
            DATE_START => '2012-10-12',
            DATE_END => '2012-10-13'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-14',
            DATE_END => '2012-10-14'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-14',
            DATE_END => '2012-10-14'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Bronze',
            DATE_START => '2012-10-14',
            DATE_END => '2012-10-14'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-10-14',
            DATE_END => '2012-10-14'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-10-18',
            DATE_END => '2013-10-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-20'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-20'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND|SESSION',
            DATE_START => '2014-09-05',
            DATE_END => '2014-09-05'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Monaco International Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-18',
            DATE_END => '2015-10-18'
          }, 
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-18',
            DATE_END => '2015-10-18'
          }, 
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-18',
            DATE_END => '2015-10-18'
          }
        }
      },
    }
  },

  'Prince Albert II Cup' => 
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
            major => 'MATCH',
            DATE_START => '2011-10-11',
            DATE_END => '2011-10-12'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-13',
            DATE_END => '2011-10-13'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_MONACO, \%TOURNAMENTS_MONACO, 'Monaco');
}

1;
