#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Israel;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://main.bridge.co.il/results/archive/12

my %GLOBAL = (
  ORGANIZATION => 'IBF',
  COUNTRY => 'Israel',
  ZONE => 'Europe',
);

my %MEETS_ISRAEL =
(
  'Israel Bridge Festival' =>
  {
    # http://www.ibf-festival.org/
    %GLOBAL,
    CITY => 'Tel Aviv',

    EDITIONS =>
    {
      '2001' =>
      {
        MEET_ORDINAL => 35,
        YEAR => 2001,
        DATE_START => '2001-02-08',
        DATE_END => '2001-02-17'
      },
      '2003' =>
      {
        MEET_ORDINAL => 37,
        YEAR => 2003,
        DATE_START => '2003-02-13',
        DATE_END => '2003-02-22'
      },
      '2004' =>
      {
        MEET_ORDINAL => 38,
        YEAR => 2004,
        DATE_START => '2004-02-12',
        DATE_END => '2004-02-21'
      },
      '2006' =>
      {
        MEET_ORDINAL => 40,
        YEAR => 2006,
        DATE_START => '2006-02-09',
        DATE_END => '2006-02-19'
      },
      '2007' =>
      {
        MEET_ORDINAL => 41,
        YEAR => 2007,
        DATE_START => '2007-02-08',
        DATE_END => '2007-02-17'
      },
      '2009' =>
      {
        MEET_ORDINAL => 43,
        YEAR => 2009,
        DATE_START => '2009-02-05',
        DATE_END => '2009-02-14'
      },
      '2010' =>
      {
        MEET_ORDINAL => 44,
        YEAR => 2010,
        DATE_START => '2010-02-18',
        DATE_END => '2010-02-27'
      },
      '2011' =>
      {
        MEET_ORDINAL => 45,
        YEAR => 2011,
        DATE_START => '2011-02-18',
        DATE_END => '2011-02-18'
      },
      '2012' =>
      {
        MEET_ORDINAL => 46,
        YEAR => 2012,
        DATE_START => '2012-02-02',
        DATE_END => '2012-02-11'
      },
      '2013' =>
      {
        MEET_ORDINAL => 47,
        YEAR => 2013,
        DATE_START => '2013-02-09',
        DATE_END => '2013-02-15'
      },
      '2014' =>
      {
        MEET_ORDINAL => 48,
        YEAR => 2014,
        DATE_START => '2014-02-20',
        DATE_END => '2014-02-26'
      },
      '2016' =>
      {
        MEET_ORDINAL => 50,
        YEAR => 2016,
        DATE_START => '2016-06-03',
        DATE_END => '2016-06-09'
      },
      '2017' =>
      {
        MEET_ORDINAL => 51,
        YEAR => 2017,
        DATE_START => '2017-06-30',
        DATE_END => '2017-07-06'
      },
      '2018' =>
      {
        MEET_ORDINAL => 52,
        YEAR => 2018,
        DATE_START => '2018-06-22',
        DATE_END => '2018-06-28'
      },
      '2019' =>
      {
        MEET_ORDINAL => 53,
        YEAR => 2019,
        DATE_START => '2019-05-31',
        DATE_END => '2019-06-06'
      },
      '2022' =>
      {
        MEET_ORDINAL => 54,
        YEAR => 2022,
        DATE_START => '2022-07-07',
        DATE_END => '2022-07-14'
      },
      '2024' =>
      {
        MEET_ORDINAL => 56,
        YEAR => 2024,
        DATE_START => '2024-05-30',
        DATE_END => '2024-06-05'
      },
    }
  },

  'Israel Grand Prix' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-05-31',
        DATE_END => '2007-05-31'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-03-28',
        DATE_END => '2009-03-28'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-09-02',
        DATE_END => '2010-09-04'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-06-09',
        DATE_END => '2011-06-11'
      },
    }
  },

  'Red Sea International Festival' =>
  {
    # https://www.bridgeredsea.com/previous-results
    %GLOBAL,

    EDITIONS =>
    {
      '2000' =>
      {
        MEET_ORDINAL => 6,
        CITY => 'Eilat',
        YEAR => 2000,
        DATE_START => '2000-11-05',
        DATE_END => '2000-11-12'
      },
      '2001' =>
      {
        MEET_ORDINAL => 7,
        CITY => 'Eilat',
        YEAR => 2001,
        DATE_START => '2001-11-04',
        DATE_END => '2001-11-11'
      },
      '2002' =>
      {
        MEET_ORDINAL => 8,
        CITY => 'Eilat',
        YEAR => 2002,
        DATE_START => '2002-11-10',
        DATE_END => '2002-11-17'
      },
      '2003' =>
      {
        MEET_ORDINAL => 9,
        CITY => 'Eilat',
        YEAR => 2003,
        DATE_START => '2003-11-16',
        DATE_END => '2003-11-23'
      },
      '2004' =>
      {
        MEET_ORDINAL => 10,
        CITY => 'Eilat',
        YEAR => 2004,
        DATE_START => '2004-11-14',
        DATE_END => '2004-11-21'
      },
      '2005' =>
      {
        MEET_ORDINAL => 11,
        CITY => 'Eilat',
        YEAR => 2005,
        DATE_START => '2005-11-13',
        DATE_END => '2005-11-20'
      },
      '2006' =>
      {
        MEET_ORDINAL => 12,
        CITY => 'Eilat',
        YEAR => 2006,
        DATE_START => '2006-11-05',
        DATE_END => '2006-11-12'
      },
      '2007' =>
      {
        MEET_ORDINAL => 13,
        CITY => 'Eilat',
        YEAR => 2007,
        DATE_START => '2007-11-08',
        DATE_END => '2007-11-18'
      },
      '2008' =>
      {
        MEET_ORDINAL => 14,
        CITY => 'Eilat',
        YEAR => 2008,
        DATE_START => '2008-11-13',
        DATE_END => '2008-11-23'
      },
      '2009' =>
      {
        MEET_ORDINAL => 15,
        CITY => 'Eilat',
        YEAR => 2009,
        DATE_START => '2009-11-07',
        DATE_END => '2009-11-12'
      },
      '2010' =>
      {
        MEET_ORDINAL => 16,
        CITY => 'Eilat',
        YEAR => 2010,
        DATE_START => '2010-11-18',
        DATE_END => '2010-11-28'
      },
      '2011' =>
      {
        MEET_ORDINAL => 17,
        CITY => 'Eilat',
        YEAR => 2011,
        DATE_START => '2011-11-17',
        DATE_END => '2011-11-27'
      },
      '2012' =>
      {
        MEET_ORDINAL => 18,
        CITY => 'Eilat',
        YEAR => 2012,
        DATE_START => '2012-11-15',
        DATE_END => '2012-11-25'
      },
      '2013' =>
      {
        MEET_ORDINAL => 19,
        CITY => 'Eilat',
        YEAR => 2013,
        DATE_START => '2013-11-21',
        DATE_END => '2013-11-21'
      },
      '2014' =>
      {
        MEET_ORDINAL => 20,
        CITY => 'Eilat',
        YEAR => 2014,
        DATE_START => '2014-11-13',
        DATE_END => '2014-11-23'
      },
      '2015' =>
      {
        MEET_ORDINAL => 21,
        CITY => 'Eilat',
        YEAR => 2015,
        DATE_START => '2015-11-12',
        DATE_END => '2015-11-22'
      },
      '2016' =>
      {
        MEET_ORDINAL => 22,
        CITY => 'Eilat',
        YEAR => 2016,
        DATE_START => '2016-11-07',
        DATE_END => '2016-11-17'
      },
      '2017' =>
      {
        MEET_ORDINAL => 23,
        CITY => 'Eilat',
        YEAR => 2017,
        DATE_START => '2017-11-09',
        DATE_END => '2017-11-19'
      },
      '2018' =>
      {
        MEET_ORDINAL => 24,
        CITY => 'Eilat',
        YEAR => 2018,
        DATE_START => '2018-11-08',
        DATE_END => '2018-11-18'
      },
      '2019' =>
      {
        MEET_ORDINAL => 25,
        CITY => 'Eilat',
        YEAR => 2019,
        DATE_START => '2019-11-12',
        DATE_END => '2019-11-20'
      },
      '2021' =>
      {
        CITY => 'Eilat',
        YEAR => 2021,
        DATE_START => '2021-11-12',
        DATE_END => '2021-11-20'
      },
      '2022' =>
      {
        CITY => 'Eilat',
        YEAR => 2022,
        DATE_START => '2022-11-11',
        DATE_END => '2022-11-19'
      },
      '2023' =>
      {
        CITY => 'Eilat',
        YEAR => 2023,
        DATE_START => '2023-11-09',
        DATE_END => '2023-11-19'
      },
      '2024' =>
      {
        CITY => 'Eilat',
        YEAR => 2024,
        DATE_START => '2024-11-07',
        DATE_END => '2024-11-16'
      },
    }
  }
);

my %TOURNAMENTS_ISRAEL =
(
  'Four Nations Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-11-19',
            DATE_END => '2011-11-19'
          } 
        }
      },
    }
  },

  'Israel Festival Open Pairs' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-26',
            DATE_END => '2010-02-26'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-18'
          } 
        }
      },
    }
  },

  'Israel Festival Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-13',
            DATE_END => '2009-02-13'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-26',
            DATE_END => '2010-02-26'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-02-18',
            DATE_END => '2011-02-18'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-08',
            DATE_END => '2016-06-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-08',
            DATE_END => '2016-06-08'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Quarterfinal',
            DATE_START => '2017-07-05',
            DATE_END => '2017-07-05'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            DATE_START => '2017-07-05',
            DATE_END => '2017-07-05'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-07-05',
            DATE_END => '2017-07-05'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-06-27',
            DATE_END => '2018-06-27'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Israel Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-06-05',
            DATE_END => '2019-06-05'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            DATE_START => '2019-06-05',
            DATE_END => '2019-06-05'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-06-05',
            DATE_END => '2019-06-05'
          },
        }
      },
    }
  },

  'Israel Juniors Pairs' => 
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SESSION|MATCH|SEGMENT',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
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
            major => 'SESSION|ROUND',
            DATE_START => '2009-12-26',
            DATE_END => '2009-12-26'
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
            major => 'ROUND',
            DATE_START => '2011-01-15',
            DATE_END => '2011-01-15'
          } 
        }
      },
    }
  },

  'Israel Juniors Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-05-05',
            DATE_END => '2005-05-05'
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
            major => 'ROUND',
            DATE_START => '2011-02-05',
            DATE_END => '2011-02-05'
          } 
        }
      },
    }
  },

  'Israel Individual' =>
  {
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND|SEGMENT',
            DATE_START => '2010-09-03',
            DATE_END => '2010-09-03'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-06-11',
            DATE_END => '2011-06-11'
          } 
        }
      },
    }
  },

  'Israel IMP Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-03-28',
            DATE_END => '2009-03-28'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND|SESSION',
            DATE_START => '2010-09-02',
            DATE_END => '2010-09-04'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Israel Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-06-09',
            DATE_END => '2011-06-09'
          } 
        }
      },
    }
  },

  'Israel League' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-02-19',
            DATE_END => '2022-02-19'
          },
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-01-14',
            DATE_END => '2023-01-14'
          },
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-04-06',
            DATE_END => '2024-04-06'
          },
        }
      },
    }
  },

  'Israel Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2005-06-04',
            DATE_END => '2005-06-04'
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
            major => 'SESSION|ROUND',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
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
            major => 'SESSION|ROUND',
            DATE_START => '2010-06-05',
            DATE_END => '2010-06-05'
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
            STAGE => 'Final',
            major => 'SESSION|ROUND|SEGMENT',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-14'
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
            major => 'SESSION|ROUND',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2013' =>
      {
        # https://main.bridge.co.il/uploads/files/2858gmar-al-2013.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION|ROUND',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
      '2014' =>
      {
        # https://www.bridge.co.il/results/2014/94-2014-ga-fr.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION|ROUND|SEGMENT',
            DATE_START => '2014-07-05',
            DATE_END => '2014-07-05'
          } 
        }
      },
      '2015' =>
      {
        # https://www.bridge.co.il/results/2015/ga2015h.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2015-06-20',
            DATE_END => '2015-06-20'
          } 
        }
      },
      '2016' =>
      {
        # https://www.bridge.co.il/results/2016/94-ga2016.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION|ROUND',
            DATE_START => '2016-05-21',
            DATE_END => '2016-05-21'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT|ROUND',
            DATE_START => '2017-05-06',
            DATE_END => '2017-05-06'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT|ROUND',
            DATE_START => '2018-05-12',
            DATE_END => '2018-05-12'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT|ROUND',
            DATE_START => '2019-04-13',
            DATE_END => '2019-04-13'
          } 
        }
      },
    }
  },

  'Israel Open Teams' =>
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
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-01-16',
            DATE_END => '2006-01-16'
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
            DATE_START => '2008-01-22',
            DATE_END => '2008-01-22'
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
            DATE_START => '2009-01-05',
            DATE_END => '2009-01-05'
          } 
        }
      },
      '2010A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-01',
            DATE_END => '2010-01-02'
          } 
        }
      },
      '2010B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-25',
            DATE_END => '2010-12-25'
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
            DATE_START => '2011-12-31',
            DATE_END => '2011-12-31'
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
            DATE_START => '2012-12-22',
            DATE_END => '2012-12-22'
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
            DATE_START => '2013-12-28',
            DATE_END => '2013-12-28'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-10'
          } 
        }
      },
      '2015B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-12',
            DATE_END => '2015-12-12'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2017-01-07',
            DATE_END => '2017-01-07'
          } 
        }
      },
      '2018A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-01-06',
            DATE_END => '2018-01-06'
          } 
        }
      },
      '2018B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-14',
            DATE_END => '2018-12-14'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-15',
            DATE_END => '2018-12-15'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-12-21',
            DATE_END => '2019-12-21'
          } 
        }
      },
    }
  },

  'Israel Open Teams Cup' =>
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
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
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
            DATE_START => '2009-09-12',
            DATE_END => '2009-09-12'
          } 
        }
      },
      '2010A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-28'
          } 
        }
      },
      '2010B' =>
      {
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-09-04',
            DATE_END => '2010-09-04'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-08-27',
            DATE_END => '2011-08-27'
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
            DATE_START => '2012-09-01',
            DATE_END => '2012-09-01'
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
            DATE_START => '2013-08-31',
            DATE_END => '2013-08-31'
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
            DATE_START => '2014-08-30',
            DATE_END => '2014-08-30'
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
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
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
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-09-02',
            DATE_END => '2017-09-02'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-08-18',
            DATE_END => '2018-08-18'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-08-03',
            DATE_END => '2019-08-03'
          } 
        }
      },
    }
  },

  'Israel Open Trials' =>
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
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-05-01',
            DATE_END => '2006-05-01'
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
            DATE_START => '2009-08-13',
            DATE_END => '2009-08-15'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-03'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-05-08',
            DATE_END => '2015-05-10'
          } 
        }
      },
      '2015B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-26',
            DATE_END => '2015-12-26'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-01-26',
            DATE_END => '2018-01-27'
          } 
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2020-01-17',
            DATE_END => '2020-01-18'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-05-01',
            DATE_END => '2022-05-01'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-01-20',
            DATE_END => '2024-01-20'
          } 
        }
      },
    }
  },

  'Israel School Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U18',

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
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-16'
          } 
        }
      },
    }
  },

  'Israel U21 Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-01-12',
            DATE_END => '2018-01-13'
          },
        }
      },
    }
  },

  'Israel Women Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2015-07-21',
            DATE_END => '2015-07-21'
          } 
        }
      },
    }
  },

  'Maccabi Games' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        ORDINAL => 17,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-07-19',
            DATE_END => '2005-07-19'
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
            DATE_START => '2011-07-11',
            DATE_END => '2011-07-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-11',
            DATE_END => '2011-07-12'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-07-31',
            DATE_END => '2019-08-01'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-08-02',
            DATE_END => '2019-08-02'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-08-04',
            DATE_END => '2019-08-04'
          },
        }
      },
    }
  },

  'Red Sea Invitational Pairs' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-11-12',
            DATE_END => '2009-11-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-24',
            DATE_END => '2011-11-24'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-11-22',
            DATE_END => '2012-11-22'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-21',
            DATE_END => '2013-11-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-19',
            DATE_END => '2015-11-19'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-11-16',
            DATE_END => '2016-11-17'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-16',
            DATE_END => '2017-11-16'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-15'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-14',
            DATE_END => '2019-11-14'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-11-18',
            DATE_END => '2021-11-18'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-11-17',
            DATE_END => '2022-11-17'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-14',
            DATE_END => '2024-11-14'
          } 
        }
      },
    }
  },

  'Red Sea Open Swiss Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2009-11-07',
            DATE_END => '2009-11-08'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-21'
          } 
        }
      },
    }
  },

  'Rand Pairs Cup' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-11-20',
            DATE_END => '2014-11-20'
          } 
        }
      },
    }
  },

  'Rand Teams Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Red Sea International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-11-25',
            DATE_END => '2010-11-25'
          } 
        }
      },
    }
  },

);

sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ISRAEL, \%TOURNAMENTS_ISRAEL, 'Israel');
}

1;
