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
  'The Hague Bridge Experience',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    CITY => 'The Hague',
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-08-19',
        DATE_END => '2016-08-20'
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
            DATE_START => '2000-04-01',
            DATE_END => '2000-04-04'
          } 
        }
      },
      '2001' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            DATE_START => '2001-05-24',
            DATE_END => '2001-05-27'
          } 
        }
      },
      '2002' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            DATE_START => '2002-05-12',
            DATE_END => '2002-05-12'
          } 
        }
      },
      '2003' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2003,
            DATE_START => '2003-06-04',
            DATE_END => '2003-06-04'
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
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-09',
            DATE_END => '2012-06-09'
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
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-05-23',
            DATE_END => '2004-05-23'
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
      '1996' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1996,
            DATE_START => '1996-12-14',
            DATE_END => '1996-12-15'
          } 
        }
      },
      '1997' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            DATE_START => '1997-12-13',
            DATE_END => '1997-12-14'
          } 
        }
      },
      '1998' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            DATE_START => '1998-12-12',
            DATE_END => '1998-12-13'
          } 
        }
      },
      '1999' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1999,
            DATE_START => '1999-12-11',
            DATE_END => '1999-12-12'
          } 
        }
      },
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-12-09',
            DATE_END => '2000-12-10'
          } 
        }
      },
      '2001' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            DATE_START => '2001-12-08',
            DATE_END => '2001-12-09'
          } 
        }
      },
      '2003' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2003,
            DATE_START => '2003-01-25',
            DATE_END => '2003-01-26'
          } 
        }
      },
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-01-24',
            DATE_END => '2004-01-25'
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
            DATE_START => '2005-01-29',
            DATE_END => '2005-01-30'
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
            DATE_START => '2006-01-16',
            DATE_END => '2006-01-16'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-02-07',
            DATE_END => '2006-02-07'
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
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
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
            DATE_START => '2007-02-04',
            DATE_END => '2007-02-04'
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

  'Forbo-Krommenie Nations Cup',
  {
    ORGANIZATION => 'NBB',
    SPONSOR => 'Forbo',
    COUNTRY => 'Netherlands',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            DATE_START => '1997-02-21',
            DATE_END => '1997-02-23'
          } 
        }
      },
      '1998' =>
      {
        ORDINAL => 6,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            DATE_START => '1998-02-20',
            DATE_END => '1998-02-20'
          } 
        }
      },
      '1999' =>
      {
        ORDINAL => 7,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Guess
            YEAR => 1999,
            DATE_START => '1999-02-23',
            DATE_END => '1999-02-25'
          } 
        }
      },
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-02-25',
            DATE_END => '2000-02-27'
          } 
        }
      },
      '2001' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            DATE_START => '2001-04-14',
            DATE_END => '2001-04-16'
          } 
        }
      },
      '2002' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            DATE_START => '2002-02-22',
            DATE_END => '2002-02-24'
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

  'Petit Grand Prix van Driene',
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
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
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
            DATE_START => '2011-06-11',
            DATE_END => '2011-06-11'
          } 
        }
      },
    }
  },

  'The Hague Open Teams',
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
        MEET => 'The Hague Bridge Experience',
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

  'The Hague Pro-Am Pairs',
  {
    ORGANIZATION => 'NBB',
    COUNTRY => 'Netherlands',
    CITY => 'The Hague',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'The Hague Bridge Experience',
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

  'Top Circuit Teams',
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
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-09-11',
            DATE_END => '2007-09-11'
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
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1998' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Guess
            YEAR => 1998,
            DATE_START => '1998-06-12',
            DATE_END => '1998-06-14'
          } 
        }
      },
      '1999' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Guess
            YEAR => 1999,
            DATE_START => '1999-06-11',
            DATE_END => '1999-06-13'
          } 
        }
      },
      '2000' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-06-10',
            DATE_END => '2000-06-12'
          } 
        }
      },
      '2002' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2002,
            DATE_START => '2002-03-30',
            DATE_END => '2002-04-01'
          } 
        }
      },
      '2009' =>
      {
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
        SCORING => 'IMP',
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
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-02-26',
            DATE_END => '2005-02-27'
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
            DATE_START => '2006-02-26',
            DATE_END => '2006-02-26'
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
            DATE_START => '2007-02-25',
            DATE_END => '2007-02-25'
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
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
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
            DATE_END => '2007-03-29'
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
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-03-31',
            DATE_END => '2014-04-02'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-03',
            DATE_END => '2014-04-03'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-04'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-03-30',
            DATE_END => '2015-03-31'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-01',
            DATE_END => '2015-04-01'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-02',
            DATE_END => '2015-04-02'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-03',
            DATE_END => '2015-04-03'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-21',
            DATE_END => '2016-03-22'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-03-23',
            DATE_END => '2016-03-23'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-24',
            DATE_END => '2016-03-24'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-24',
            DATE_END => '2016-03-24'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-25',
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
    FORM => 'Pairs',
    SCORING => 'IMP',
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
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-11'
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
            DATE_START => '2007-08-27',
            DATE_END => '2007-08-28'
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
            DATE_START => '2008-08-30',
            DATE_END => '2008-08-31'
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
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-29'
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
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-02'
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
