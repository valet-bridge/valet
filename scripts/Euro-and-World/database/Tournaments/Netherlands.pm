#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Netherlands;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_NETHERLANDS =
(
  'Meet name' =>
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2015' =>
      {
        # Link
        YEAR => 2000,
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  }
);

my %TOURNAMENTS_NETHERLANDS =
(
  'ArboNed Team Cup',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Arnhem Interbridge Tournament',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Carrousel Cup',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2002' =>
      {
        CITY => "'s-Hertogenbosch",
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            DATE_START => '2002-05-23',
            DATE_END => '2002-05-26'
          } 
        }
      },
      '2003' =>
      {
        CITY => "'s-Hertogenbosch",
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Really 2003-06-28 to 2003-07-02
            YEAR => 2003,
            DATE_START => '2003-07-05',
            DATE_END => '2003-07-06'
          } 
        }
      },
    }
  },

  'Dutch Knock-Out Cup',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Dutch Meesterklasse',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-09',
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
            DATE_START => '2011-01-29',
            DATE_END => '2011-01-30'
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
            DATE_START => '2011-09-24',
            DATE_END => '2011-09-25'
          },
          'C1' => 
          {
            YEAR => 2012,
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-22'
          },
          'C2' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-04',
            DATE_END => '2012-02-05'
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
            DATE_START => '2012-12-22',
            DATE_END => '2012-12-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-01-05',
            DATE_END => '2013-01-06'
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
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
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
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-25'
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
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-24'
          } 
        }
      },
    }
  },

  'Dutch Women',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Forbo Nations Cup',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Jaap Kokkes Tournament',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
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
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
          } 
        }
      },
    }
  },

  'Krommenie Nations Cup',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Petit Grand Prix van Driene',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'The Hague Bridge Experience',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    CITY => 'The Hague',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            DATE_START => '2016-08-19',
            DATE_END => '2016-08-20'
          } 
        }
      },
    }
  },

  'Top Circuit',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
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
            DATE_START => '2009-03-07',
            DATE_END => '2009-03-08'
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
            DATE_START => '2010-03-06',
            DATE_END => '2010-03-07'
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
            DATE_START => '2011-03-05',
            DATE_END => '2011-03-06'
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
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-04'
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
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03'
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
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
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
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-08'
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
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'White House International',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'White House Juniors',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-03-26',
            DATE_END => '2006-03-26'
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
            DATE_START => '2007-03-27',
            DATE_END => '2007-03-27'
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
            DATE_START => '2008-03-20',
            DATE_END => '2008-03-20'
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
            DATE_START => '2009-03-09',
            DATE_END => '2009-03-13'
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
            DATE_START => '2010-03-22',
            DATE_END => '2010-03-26'
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
            DATE_START => '2011-03-21',
            DATE_END => '2011-03-25'
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
            DATE_START => '2012-03-26',
            DATE_END => '2012-03-30'
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
            DATE_START => '2013-03-18',
            DATE_END => '2013-03-22'
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
            DATE_START => '2014-03-31',
            DATE_END => '2014-04-04'
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
            DATE_START => '2015-03-30',
            DATE_END => '2015-04-03'
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
            DATE_START => '2016-03-21',
            DATE_END => '2016-03-25'
          } 
        }
      },
    }
  },

  'White House Top 12',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'White House Top 16',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_NETHERLANDS, \%TOURNAMENTS_NETHERLANDS, 'Netherlands');
}

1;
