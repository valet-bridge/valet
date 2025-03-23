#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Hungary;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://bridzs.hu/hu/versenyek-eredmenyek/ current
# http://bridge.ecosoft.hu/leo/leo_show.php?y=2007&m=05 Wayback Machine

my %GLOBAL = (
  ORGANIZATION => 'MBSZ',
  COUNTRY => 'Hungary',
  ZONE => 'Europe',
);

my %MEETS_HUNGARY =
(
);

my %TOURNAMENTS_HUNGARY =
(
  'Balaton Invitational Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Balaton',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-12-06',
            DATE_END => '2013-12-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-08',
            DATE_END => '2013-12-08'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-05-15',
            DATE_END => '2014-05-17'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          } 
        }
      },
    }
  },

  'EcoSoft Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Balatonföldvár',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-01'
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
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
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
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
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
            DATE_START => '2013-05-19',
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
            DATE_START => '2014-06-08',
            DATE_END => '2014-06-08'
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
            DATE_START => '2015-05-24',
            DATE_END => '2015-05-24'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 27,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-15',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2017' =>
      {
        ORDINAL => 28,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-06-04',
            DATE_END => '2017-06-04'
          } 
        }
      },
    }
  },

  'Hungarian Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SEGMENT|SESSION',
            DATE_START => '2004-05-23',
            DATE_END => '2004-05-23'
          } 
        }
      },
      '2005' =>
      {
        CITY => 'Siofok',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-21',
            DATE_END => '2005-05-22'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-22',
            DATE_END => '2005-05-23'
          },
          'C2' => 
          {
            # Only one .lin file.  The date probably isn't right,
            # but it doesn't appear to be the same as C0
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-06',
            DATE_END => '2005-09-06'
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
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            # Probably it was actually around May 2007
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
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
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-31',
            DATE_END => '2009-03-31'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-07',
            DATE_END => '2009-04-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-24',
            DATE_END => '2009-05-24'
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
            DATE_START => '2010-05-23',
            DATE_END => '2010-05-23'
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
            DATE_START => '2011-05-22',
            DATE_END => '2011-05-22'
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
            DATE_START => '2012-05-20',
            DATE_END => '2012-05-20'
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
            DATE_START => '2013-05-25',
            DATE_END => '2013-05-25'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-26',
            DATE_END => '2013-05-26'
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
            DATE_START => '2014-05-25',
            DATE_END => '2014-05-25'
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
            DATE_START => '2015-05-17',
            DATE_END => '2015-05-17'
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
            DATE_START => '2016-04-24',
            DATE_END => '2016-04-24'
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
            DATE_START => '2017-05-14',
            DATE_END => '2017-05-14'
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
            DATE_START => '2018-05-27',
            DATE_END => '2018-05-27'
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
            DATE_START => '2019-05-18',
            DATE_END => '2019-05-19'
          }
        }
      },
    }
  },

  'Hungarian IMP Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-01-05',
            DATE_END => '2009-01-05'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-29',
            DATE_END => '2009-11-29'
          }
        }
      },
    }
  },

  'Hungarian Open Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'MP',
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
            DATE_START => '2005-04-11',
            DATE_END => '2005-04-11'
          } 
        }
      },
    }
  },

  'Hungarian Open Teams',
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
            DATE_START => '2006-02-12',
            DATE_END => '2006-02-13'
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
            DATE_START => '2007-03-04',
            DATE_END => '2007-03-04'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-05',
            DATE_END => '2007-03-05'
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
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-27',
            DATE_END => '2010-02-28'
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
            DATE_START => '2011-02-05',
            DATE_END => '2011-02-05'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-02-06',
            DATE_END => '2011-02-06'
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
            DATE_START => '2012-02-05',
            DATE_END => '2012-02-05'
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
            DATE_START => '2014-02-09',
            DATE_END => '2014-02-09'
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
            DATE_START => '2015-02-21',
            DATE_END => '2015-02-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-22',
            DATE_END => '2015-02-22'
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
            DATE_START => '2016-02-27',
            DATE_END => '2016-02-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-02-28',
            DATE_END => '2016-02-28'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-03-04',
            DATE_END => '2017-03-05'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-13',
            DATE_END => '2018-05-13'
          } 
        }
      },
    }
  },

  'Hungarian Open Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-02-13',
            DATE_END => '2010-02-14'
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
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-04'
          },
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
            DATE_START => '2015-10-17',
            DATE_END => '2015-10-18'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-23',
            DATE_END => '2015-10-25'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-09',
            DATE_END => '2017-12-10'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-02-03',
            DATE_END => '2018-02-04'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-02-12',
            DATE_END => '2022-02-13'
          },
        }
      },
    }
  },

  'Hungarian Santa Invitational' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
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
            DATE_START => '2016-12-16',
            DATE_END => '2016-12-16'
          },
        }
      },
    }
  },

  'Hungarian Senior Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-09',
            DATE_END => '2016-04-10'
          } 
        }
      },
    }
  },

  'Hungarian Women Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-25',
            DATE_END => '2015-10-25'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_HUNGARY, \%TOURNAMENTS_HUNGARY, 'Hungary');
}

1;
