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


my %MEETS_NEWZEALAND =
(
  'New Zealand National Congress' =>
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2015' =>
      {
        # 
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
        DATE_END => '2017-10-06'
      },
      '2018' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=247
        YEAR => 2018,
        CITY => 'Hamilton',
        DATE_START => '2017-09-28',
        DATE_END => '2017-10-06'
      },
      '2019' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=339
        YEAR => 2019,
        CITY => 'Hamilton',
        DATE_START => '2017-09-27',
        DATE_END => '2017-10-05'
      },
      '2023' =>
      {
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=743
        YEAR => 2023,
        CITY => 'Mount Maunganui',
        DATE_START => '2023-09-23',
        DATE_END => '2023-09-30'
      }
    }
  }
);

my %TOURNAMENTS_NEWZEALAND =
(
  'New Zealand Inter-Provincial Open Teams' => 
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'Interprovince',
    ZONE => 'South Pacific',
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
            DATE_START => '2005-09-24',
            DATE_END => '2005-09-25'
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
            DATE_START => '2006-07-02',
            DATE_END => '2006-07-02'
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
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
          } 
        }
      },

      '2008' =>
      {
        # https://www.akbc.co.nz/blog/586960
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
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
            DATE_START => '2009-09-24',
            DATE_END => '2009-09-25'
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
            major => 'ROUND',
            DATE_START => '2010-09-24',
            DATE_END => '2010-09-24'
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
            DATE_START => '2011-07-15',
            DATE_END => '2011-07-15'
          } 
        }
      },

      '2012' =>
      {
        # During National Congress
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
        CITY => 'Otago',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-21',
            DATE_END => '2016-11-24'
          } 
        }
      },

      '2017' =>
      {
        # http://www.tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=190
        CITY => 'Wellington',
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
        CITY => 'Auckland',
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
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=367
        CITY => 'Christchurch',
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
        # https://tournaments.nzbridgeclub.org/resultslistbyheadevent.asp?umbid=405
        CITY => 'Christchurch',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-11-21',
            DATE_END => '2020-11-23'
          } 
        }
      },

      '2021' =>
      {
        CITY => 'Online',
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
        CITY => 'Online',
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
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-11-24',
            DATE_END => '2023-11-26'
          } 
        }
      }
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
            DATE_END => '2016-09-30'
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
            STAGE => 'Quarterfinal',
            DATE_START => '2017-10-05',
            DATE_END => '2017-10-05'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            DATE_START => '2017-10-06',
            DATE_END => '2017-10-06'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-10-07',
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
            DATE_END => '2018-10-05'
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
            DATE_END => '2019-10-04'
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
            YEAR => 2017,
            STAGE => 'Quarterfinal',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-28'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-29'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-29'
          }
        }
      }
    }
  },

  'New Zealand Open Trials' => 
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            major => 'ROUND',
            DATE_START => '2009-04-09',
            DATE_END => '2009-04-11'
          } 
        }
      }
    }
  },

  'New Zealand Women Trials' => 
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2009-03-23',
            DATE_END => '2009-03-23'
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
