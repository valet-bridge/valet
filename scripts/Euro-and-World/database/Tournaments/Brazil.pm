#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Brazil;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://www.bridge.esp.br/historico.php, a bit spotty

my %MEETS_BRAZIL =
(
  'Brazilian Trials',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',

    EDITIONS => 
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-08-07',
        DATE_END => '2004-08-09'
      },
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-03-26',
        DATE_END => '2005-03-26'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-04-17',
        DATE_END => '2006-04-17'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-04-16',
        DATE_END => '2007-04-16'
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
        DATE_END => '2009-04-12'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-23',
        DATE_END => '2011-04-23'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-05',
        DATE_END => '2012-04-07'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-03-28',
        DATE_END => '2013-03-30'
      },
      '2016' =>
      {
        # Link
        YEAR => 2016,
        DATE_START => '2016-03-21',
        DATE_END => '2016-03-27'
      },
    }
  }
);

my %TOURNAMENTS_BRAZIL =
(
  'Brazilian Open Teams',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-09-10',
            DATE_END => '2004-09-10'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-09-11',
            DATE_END => '2004-09-11'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-12'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-12'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-11',
            DATE_END => '2007-09-11'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-11',
            DATE_END => '2007-09-11'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
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
            DATE_START => '2009-10-16',
            DATE_END => '2009-10-17'
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
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-10'
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
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-09'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-13'
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
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-07'
          } 
        }
      },
    }
  },

  'Brazilian Open Trials',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-08-07',
            DATE_END => '2004-08-07'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-08-08',
            DATE_END => '2004-08-09'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-26'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-26'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-04-16',
            DATE_END => '2006-04-17'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-04-16',
            DATE_END => '2006-04-17'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-10',
            DATE_END => '2009-04-10'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-04-11',
            DATE_END => '2009-04-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-23',
            DATE_END => '2011-04-23'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-05',
            DATE_END => '2012-04-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-07'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-29'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-29',
            DATE_END => '2013-03-30'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-21',
            DATE_END => '2016-03-23'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-23',
            DATE_END => '2016-03-24'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-24',
            DATE_END => '2016-03-24'
          } 
        }
      },
    }
  },

  'Brazilian Senior Trials',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
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
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
          } 
        }
      },
    }
  },

  'Brazilian Women Trials',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
          } 
        }
        # Link
      },
      '2016' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-25'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-27'
          } 
        }
        # Link
      },
    }
  },

  'Rio de Janeiro Open Teams',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-09-05',
            DATE_END => '2004-09-05'
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
            DATE_START => '2009-06-30',
            DATE_END => '2009-07-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-01',
            DATE_END => '2009-07-01'
          } 
        }
      },
    }
  },

  'Rio de Janeiro Christmas Individual',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Individual',
    SCORING => 'MP',
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
            STAGE => 'Final',
            DATE_START => '2009-12-17',
            DATE_END => '2009-12-17'
          } 
        }
      },
    }
  },

  'Roberto Taunay Cup',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
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
            DATE_START => '2009-11-10',
            DATE_END => '2009-11-10'
          } 
        }
      },
    }
  },

  'Sao Paulo Cup',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-14',
            DATE_END => '2004-11-16'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-17',
            DATE_END => '2005-12-17'
          },
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
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
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
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
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
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          },
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
            DATE_START => '2010-10-29',
            DATE_END => '2010-10-30'
          },
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
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
          },
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
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          },
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
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
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
            DATE_START => '2014-11-29',
            DATE_END => '2014-11-29'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-06',
            DATE_END => '2014-12-06'
          } 
        }
      },
    }
  },

  'Sao Paulo State Championship',
  {
    ORGANIZATION => 'FBB',
    COUNTRY => 'Brazil',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-21',
            DATE_END => '2004-06-21'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-27',
            DATE_END => '2005-06-27'
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
            DATE_START => '2006-07-03',
            DATE_END => '2006-07-03'
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
            DATE_START => '2007-08-27',
            DATE_END => '2007-08-27'
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
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
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
            DATE_START => '2009-06-19',
            DATE_END => '2009-06-21'
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
            DATE_START => '2010-06-18',
            DATE_END => '2010-06-20'
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
            DATE_START => '2011-06-03',
            DATE_END => '2011-06-05'
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
            DATE_START => '2012-06-23',
            DATE_END => '2012-06-24'
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
            DATE_START => '2013-05-18',
            DATE_END => '2013-05-19'
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
            DATE_END => '2014-06-15'
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
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-10'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-13',
            DATE_END => '2015-06-14'
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
            DATE_START => '2016-05-22',
            DATE_END => '2016-05-22'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BRAZIL, \%TOURNAMENTS_BRAZIL, 'Brazil');
}

1;
