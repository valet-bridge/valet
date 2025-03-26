#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::NewZealand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://www.nzbridge.co.nz/results0.html

my %GLOBAL = (
  ORGANIZATION => 'NZB',
  COUNTRY => 'New Zealand',
  ZONE => 'South Pacific',
);

my %MEETS_NEWZEALAND =
(
  'New Zealand Inter-Provincial Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2016' =>
      {
        CITY => 'Otago',
        YEAR => 2016,
        DATE_START => '2016-11-25',
        DATE_END => '2016-11-27'
      },
      '2017' =>
      {
        CITY => 'Wellington',
        YEAR => 2017,
        DATE_START => '2017-11-24',
        DATE_END => '2017-11-26'
      },
      '2018' =>
      {
        CITY => 'Auckland',
        YEAR => 2018,
        DATE_START => '2018-11-23',
        DATE_END => '2018-11-26'
      },
      '2019' =>
      {
        CITY => 'Christchurch',
        YEAR => 2019,
        DATE_START => '2019-11-22',
        DATE_END => '2019-11-25'
      },
      '2020' =>
      {
        CITY => 'Christchurch',
        YEAR => 2020,
        DATE_START => '2020-11-20',
        DATE_END => '2020-11-23'
      },
      '2021' =>
      {
        CITY => 'Online',
        YEAR => 2021,
        DATE_START => '2021-11-19',
        DATE_END => '2021-11-21'
      },
      '2022' =>
      {
        CITY => 'Online',
        YEAR => 2022,
        DATE_START => '2022-11-18',
        DATE_END => '2022-11-20'
      },
      '2023' =>
      {
        CITY => 'Online',
        YEAR => 2023,
        DATE_START => '2023-11-24',
        DATE_END => '2023-11-26'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-11-29',
        DATE_END => '2024-12-02'
      }
    }
  },

  'New Zealand National Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-09-24',
        DATE_END => '2005-09-25'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-07-02',
        DATE_END => '2006-07-02'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-09-29',
        DATE_END => '2007-09-29'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-09-27',
        DATE_END => '2008-09-27'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-09-24',
        DATE_END => '2009-09-25'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-09-24',
        DATE_END => '2010-09-24'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-07-15',
        DATE_END => '2011-07-15'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-09-28',
        DATE_END => '2012-09-28'
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Hamilton',
        DATE_START => '2015-09-26',
        DATE_END => '2015-10-03'
      },
      '2016' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=92
        YEAR => 2016,
        CITY => 'Hamilton',
        DATE_START => '2016-09-23',
        DATE_END => '2016-10-01'
      },
      '2017' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=178
        YEAR => 2017,
        CITY => 'Hamilton',
        DATE_START => '2017-09-29',
        DATE_END => '2017-10-07'
      },
      '2018' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=247
        YEAR => 2018,
        CITY => 'Hamilton',
        DATE_START => '2018-09-28',
        DATE_END => '2018-10-06'
      },
      '2019' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=339
        YEAR => 2019,
        CITY => 'Hamilton',
        DATE_START => '2019-09-27',
        DATE_END => '2019-10-05'
      },
      '2023' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=743
        YEAR => 2023,
        CITY => 'Mount Maunganui',
        DATE_START => '2023-09-23',
        DATE_END => '2023-09-30'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-10-03',
        DATE_END => '2024-10-05'
      }
    }
  },

  'New Zealand Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2009A' =>
      {
        YEAR => 2009,
        DATE_START => '2009-03-23',
        DATE_END => '2009-03-23'
      },
      '2009B' =>
      {
        YEAR => 2009,
        DATE_START => '2009-04-09',
        DATE_END => '2009-04-11'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-11-09',
        DATE_END => '2018-11-11'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-02-04',
        DATE_END => '2024-02-05'
      },
    }
  },
);

my %TOURNAMENTS_NEWZEALAND =
(
  'Centre Island Open Teams' => 
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        CITY => 'Wellington',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2007-03-27',
            DATE_END => '2007-03-27'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-27',
            DATE_END => '2007-03-27'
          } 
        }
      }
    }
  },

  'New Zealand Inter-Provincial Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-24',
            DATE_END => '2005-09-25'
          } 
        }
      },

      '2006' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-02'
          } 
        }
      },

      '2007' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
          } 
        }
      },

      '2008' =>
      {
        # https://www.akbc.co.nz/blog/586960
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          } 
        }
      },

      '2009' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-24',
            DATE_END => '2009-09-25'
          } 
        }
      },

      '2010' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-24',
            DATE_END => '2010-09-24'
          } 
        }
      },

      '2011' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-07-15',
            DATE_END => '2011-07-15'
          } 
        }
      },

      '2012' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-09-28',
            DATE_END => '2012-09-28'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-25',
            DATE_END => '2016-11-27'
          } 
        }
      },

      '2017' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=190
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-24',
            DATE_END => '2017-11-26'
          } 
        }
      },

      '2018' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=266
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-23',
            DATE_END => '2018-11-26'
          } 
        }
      },

      '2019' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=367
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-25'
          } 
        }
      },

      '2020' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=405
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-11-20',
            DATE_END => '2020-11-23'
          } 
        }
      },

      '2021' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-11-19',
            DATE_END => '2021-11-21'
          } 
        }
      },

      '2022' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=616
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-20'
          } 
        }
      },

      '2023' =>
      {
        # https://www.nzbridge.co.nz/2023-interprovincial-teams.html
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-11-24',
            DATE_END => '2023-11-26'
          } 
        }
      },

      '2024' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-29',
            DATE_END => '2024-12-02'
          } 
        }
      }
    }
  },

  'New Zealand Inter-Provincial Senior Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-25',
            DATE_END => '2017-11-26'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-24',
            DATE_END => '2018-11-26'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-24'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-11-20',
            DATE_END => '2020-11-23'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-29',
            DATE_END => '2024-12-02'
          } 
        }
      }
    }
  },

  'New Zealand Inter-Provincial Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-25',
            DATE_END => '2016-11-27'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-25',
            DATE_END => '2017-11-26'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-24',
            DATE_END => '2018-11-26'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-24'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-11-21',
            DATE_END => '2020-11-22'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'New Zealand Inter-Provincial Teams',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-29',
            DATE_END => '2024-12-02'
          } 
        }
      }
    }
  },

  'New Zealand Mixed Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          },
        }
      },
    }
  },

  'New Zealand Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-03',
            DATE_END => '2024-03-04'
          },
        }
      },
    }
  },

  'New Zealand Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-02',
            DATE_END => '2015-10-02'
          }
        }
      },

      '2016' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            DATE_START => '2016-09-29',
            DATE_END => '2016-09-29'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            DATE_START => '2016-09-30',
            DATE_END => '2016-09-30'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-09-30',
            DATE_END => '2016-10-01'
          }
        }
      },

      '2017' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-10-05',
            DATE_END => '2017-10-07'
          }
        }
      },

      '2018' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            DATE_START => '2018-10-04',
            DATE_END => '2018-10-04'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            DATE_START => '2018-10-05',
            DATE_END => '2018-10-05'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-10-05',
            DATE_END => '2018-10-06'
          }
        }
      },

      '2019' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            DATE_START => '2019-10-03',
            DATE_END => '2019-10-03'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            DATE_START => '2019-10-04',
            DATE_END => '2019-10-04'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            DATE_START => '2019-10-04',
            DATE_END => '2019-10-05'
          }
        }
      },

      '2023' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Quarterfinal',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-28'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-29'
          },
          'C2' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-30'
          }
        }
      },

      '2024' =>
      {
        MEET => 'New Zealand National Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-10-03',
            DATE_END => '2024-10-05'
          },
        }
      },
    }
  },

  'New Zealand Open Trials' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'New Zealand Trials',
        MEET_TAG => '2009B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND|SESSION',
            DATE_START => '2009-04-09',
            DATE_END => '2009-04-11'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'New Zealand Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-09',
            DATE_END => '2018-11-11'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'New Zealand Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-04',
            DATE_END => '2024-02-05'
          } 
        }
      }
    }
  },

  'New Zealand Women Trials' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009A' =>
      {
        MEET => 'New Zealand Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-03-23',
            DATE_END => '2009-03-23'
          },
        }
      },
      '2009B' =>
      {
        MEET => 'New Zealand Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-04-09',
            DATE_END => '2009-04-10'
          } 
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_NEWZEALAND, \%TOURNAMENTS_NEWZEALAND, 'New Zealand');
}

1;
