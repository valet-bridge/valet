#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Italy;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_ITALY =
(
  '' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2013' =>
      {
        ORDINAL => '1st',
        YEAR => 2013,
        CITY => 'Berlin',
        DATE_START => '2014-08-10',
        DATE_END => '2014-08-18'
      }
    }
  }
);

my %TOURNAMENTS_ITALY =
(
  # TODO Split into a meet
  'Italian Club Championship' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            STAGE => 'Final',
            GENDER => 'Women',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          },
          'C1' =>
          {
            YEAR => 2004,
            STAGE => => 'Semifinal',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          } ,
          'C2' =>
          {
            YEAR => 2004,
            STAGE => => 'Final',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          } 
        }
      },
      '2005' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2005/CSSASBSC/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2005,
            STAGE => => 'Qualifying',
            GENDER => 'Open',
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2005-02-12',
            DATE_END => '2005-02-13'
          },
          'C1' =>
          {
            YEAR => 2005,
            STAGE => => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2005-04-07',
            DATE_END => '2005-04-07'
          },
          'C2' =>
          {
            YEAR => 2005,
            STAGE => => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2005-04-08',
            DATE_END => '2005-04-08'
          } 
        }
      },
      '2006' =>
      {
        CITY => 'Montecatini',
        # https://www.federbridge.it/campionati/2006/CSSASBSC/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2006,
            STAGE => => 'Semifinal',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2006-09-28',
            DATE_END => '2006-09-29'
          } ,
          'C1' =>
          {
            YEAR => 2006,
            STAGE => => 'Final',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2006-09-30',
            DATE_END => '2006-10-01'
          } 
        }
      },
      '2007' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2007/CLCCSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2007,
            STAGE => => 'Semifinal',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2007-10-27',
            DATE_END => '2007-10-27'
          } ,
          'C1' =>
          {
            YEAR => 2007,
            STAGE => => 'Final',
            GENDER => 'Open',
            major => 'ROUND',
            DATE_START => '2007-10-28',
            DATE_END => '2007-10-28'
          } 
        }
      },
      '2008' =>
      {
        CITY => 'San Remo',
        # https://www.federbridge.it/campionati/2008/CSSASBSC/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            GENDER => 'Women',
            major => 'SEGMENT',
            DATE_START => '2008-09-18',
            DATE_END => '2008-09-19'
          },

          'C1' =>
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2008-09-18',
            DATE_END => '2008-09-19'
          },
          'C2' =>
          {
            YEAR => 2008,
            STAGE => 'Bronze',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2008-09-19',
            DATE_END => '2008-09-20'
          },
          'C3' =>
          {
            YEAR => 2008,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2008-09-19',
            DATE_END => '2008-09-21'
          }
        }
      },
      '2009' =>
      {
        CITY => 'Bologna',
        # https://www.federbridge.it/campionati/2009/CSSASBSC/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2009-09-24',
            DATE_END => '2009-09-25'
          },
          'C1' =>
          {
            YEAR => 2009,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2009-09-25',
            DATE_END => '2009-09-27'
          }
        }
      },
      '2010' =>
      {
        CITY => 'Bologna',
        # https://www.federbridge.it/campionati/2010/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2010-09-23',
            DATE_END => '2010-09-24'
          },
          'C1' =>
          {
            YEAR => 2010,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2010-09-24',
            DATE_END => '2010-09-26'
          }
        }
      },
      '2011' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2011-09-22',
            DATE_END => '2011-09-23'
          },
          'C1' =>
          {
            YEAR => 2011,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-25'
          }
        }
      },
      '2012' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2012-09-27',
            DATE_END => '2012-09-28'
          },
          'C1' =>
          {
            YEAR => 2012,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2012-09-28',
            DATE_END => '2012-09-30'
          }
        }
      },
      '2013' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          },
          'C1' =>
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2013-10-04',
            DATE_END => '2013-10-04'
          },
          'C2' =>
          {
            YEAR => 2013,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
          }
        }
      },
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            GENDER => 'Open',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-09-25',
            DATE_END => '2014-09-25'
          },
          'C1' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2014-09-26',
            DATE_END => '2014-09-27'
          },
          'C2' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          },
          'C3' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            GENDER => 'Women',
            major => 'SEGMENT',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2015-06-19',
            DATE_END => '2015-06-20'
          },
          'C1' =>
          {
            YEAR => 2015,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2015-06-20',
            DATE_END => '2015-06-21'
          }
        }
      },
      '2016' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CSS1S2S3/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            GENDER => 'Open',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-05-19',
            DATE_END => '2016-05-20'
          },
          'C1' =>
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2016-05-20',
            DATE_END => '2016-05-21'
          },
          'C2' =>
          {
            YEAR => 2016,
            STAGE => 'Final',
            GENDER => 'Open',
            major => 'SEGMENT',
            DATE_START => '2016-05-21',
            DATE_END => '2016-05-22'
          }
        }
      }
    }
  },

  'Italian Mixed Cup' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=XI

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-29'
          },
          'C1' =>
          {
            YEAR => 2014,
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-30'
          },
          'C2' =>
          {
            YEAR => 2014,
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-30',
            DATE_END => '2014-10-30'
          },
          'C3' =>
          {
            YEAR => 2014,
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-30',
            DATE_END => '2014-10-31'
          },
          'C4' =>
          {
            YEAR => 2014,
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-10-31',
            DATE_END => '2014-11-01'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=XI

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2015-10-28',
            DATE_END => '2015-10-28'
          },
          'C1' =>
          {
            YEAR => 2015,
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-28',
            DATE_END => '2015-10-29'
          },
          'C2' =>
          {
            YEAR => 2015,
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-29',
            DATE_END => '2015-10-29'
          },
          'C3' =>
          {
            YEAR => 2015,
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-29',
            DATE_END => '2015-10-30'
          },
          'C4' =>
          {
            YEAR => 2015,
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-30',
            DATE_END => '2015-10-30'
          } 
        }
      }
    }
  },

  'Italian Mixed Pairs' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-11-01',
            DATE_END => '2014-11-02'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          }
        }
      }
    }
  },

  'Italian Mixed Teams' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2010/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-10-29',
            DATE_END => '2010-11-01'
          }
        }
      },
      '2011' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-30',
            DATE_END => '2011-11-01'
          }
        }
      },
      '2012' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-11-01',
            DATE_END => '2012-11-04'
          }
        }
      },
      '2013' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/CXSQMX/indice.asp
        
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-30',
            DATE_END => '2013-06-02'
          }
        }
      },
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CXSQMX/indice.asp
        
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-02'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-06-02'
          }
        }
      },
      '2016' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-02',
            DATE_END => '2016-06-05'
          }
        }
      }
    }
  },

  'Italian Open Teams' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
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
          'C0' =>
          {
            YEAR => 2004,
            STAGE => => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-30'
          },
          'C1' =>
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2004-05-01',
            DATE_END => '2004-05-02'
          },
        }
      },
      '2006' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2006/CPSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-04-23',
            DATE_END => '2006-04-25'
          }
        }
      },
      '2010' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2010/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-04-29',
            DATE_END => '2010-05-02'
          }
        }
      },
      '2011' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-04-28',
            DATE_END => '2011-05-01'
          }
        }
      },
      '2012' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-04-28',
            DATE_END => '2012-05-01'
          }
        }
      },
      '2013' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-04-25',
            DATE_END => '2013-04-28'
          }
        }
      },
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        #  https://www.federbridge.it/campionati/2014/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-24',
            DATE_END => '2014-04-27'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-30',
            DATE_END => '2015-05-03'
          }
        }
      },
      '2016' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-04-22',
            DATE_END => '2016-04-25'
          }
        }
      }
    }
  },

  'Italian Open Trials' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
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
          CITY => 'Salsomaggiore',
          # https://www.federbridge.it/campionati/2014/SSSQOP/indice.asp

          'C0' =>
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-01-31',
            DATE_END => '2014-02-01'
          },
          'C1' =>
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-02-02',
            DATE_END => '2014-02-02'
          },

          'C2' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-13',
            DATE_END => '2014-02-14'
          },
          'C3' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-16'
          } 
        }
      }
    }
  },

  'Italian Senior Trials' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/SSSN/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          },
          'C1' =>
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-09',
            DATE_END => '2014-03-09'
          },

          'C2' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-03',
            DATE_END => '2014-04-04'
          },
          'C3' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-06'
          }
        }
      }
    }
  },

  'Italian U36 Teams' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U36',

    EDITIONS =>
    {
      '2016' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CU/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-26'
          }
        }
      }
    }
  },

  'Italy Cup' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2004,
            GENDER => 'Women',
            AGE => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-05',
            DATE_END => '2004-06-06'
          },
          'C1' =>
          {
            YEAR => 2004,
            GENDER => 'Women',
            AGE => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-06',
            DATE_END => '2004-06-07'
          },

          'C2' =>
          {
            YEAR => 2004,
            GENDER => 'Men',
            AGE => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-05',
            DATE_END => '2004-06-06'
          },
          'C3' =>
          {
            YEAR => 2004,
            GENDER => 'Men',
            AGE => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-06',
            DATE_END => '2004-06-07'
          },
          'C4' =>
          {
            YEAR => 2004,
            GENDER => 'Men',
            AGE => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-07',
            DATE_END => '2004-06-08'
          },
          'C5' =>
          {
            YEAR => 2004,
            GENDER => 'Men',
            AGE => 'O55',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-06',
            DATE_END => '2004-06-07'
          }
        }
      },
      '2005' =>
      {
        CITY => 'Bologna',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2005,
            GENDER => 'Women',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-10'
          },

          'C1' =>
          {
            YEAR => 2005,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-10'
          },
          'C2' =>
          {
            YEAR => 2005,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          }
        }
      },
      '2006' =>
      {
        CITY => 'Bologna',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2006,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-14',
            DATE_END => '2006-12-15'
          },
          'C1' =>
          {
            YEAR => 2006,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-15',
            DATE_END => '2006-12-16'
          },
          'C2' =>
          {
            YEAR => 2006,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-12-16',
            DATE_END => '2006-12-17'
          }
        }
      },
      '2007' =>
      {
        CITY => 'Salsomaggiore',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2007,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-14',
            DATE_END => '2007-12-15'
          },
          'C1' =>
          {
            YEAR => 2007,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-15',
            DATE_END => '2007-12-15'
          },
          'C2' =>
          {
            YEAR => 2007,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-15',
            DATE_END => '2007-12-16'
          }
        }
      },
      '2008' =>
      {
        CITY => 'Salsomaggiore',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2008,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-12',
            DATE_END => '2008-12-13'
          },
          'C1' =>
          {
            YEAR => 2008,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-13',
            DATE_END => '2008-12-13'
          },
          'C2' =>
          {
            YEAR => 2008,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-13',
            DATE_END => '2008-12-14'
          }
        }
      },
      '2009' =>
      {
        CITY => 'Salsomaggiore',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2009,
            GENDER => 'Men',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-11'
          },
          'C1' =>
          {
            YEAR => 2009,
            GENDER => 'Men',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-12'
          },
          'C2' =>
          {
            YEAR => 2009,
            GENDER => 'Men',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-12'
          },
          'C3' =>
          {
            YEAR => 2009,
            GENDER => 'Men',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-13'
          }
        }
      },
      '2010' =>
      {
        CITY => 'Salsomaggiore',

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2010,
            GENDER => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-12-16',
            DATE_END => '2010-12-16'
          },
          'C1' =>
          {
            YEAR => 2010,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-17'
          },
          'C2' =>
          {
            YEAR => 2010,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-18'
          },
          'C3' =>
          {
            YEAR => 2010,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-19'
          },
          'C4' =>
          {
            YEAR => 2010,
            GENDER => 'Women',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-19'
          }
        }
      },
      '2011' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CI/programma.asp?ciType=4I

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2011,
            GENDER => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-16'
          },
          'C1' =>
          {
            YEAR => 2011,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-17'
          },
          'C2' =>
          {
            YEAR => 2011,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-17',
            DATE_END => '2011-12-17'
          },
          'C3' =>
          {
            YEAR => 2011,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-17',
            DATE_END => '2011-12-18'
          }
        }
      },
      '2012' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CI/programma.asp?ciType=4I

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2012,
            GENDER => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-14'
          },
          'C1' =>
          {
            YEAR => 2012,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-15'
          },
          'C2' =>
          {
            YEAR => 2012,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-15'
          },
          'C3' =>
          {
            YEAR => 2012,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-16'
          },

          'C4' =>
          {
            YEAR => 2012,
            GENDER => 'Women',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-16'
          }
        }
      },
      '2013' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/ci/programma.asp?ciType=4I

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2013,
            GENDER => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-11-21',
            DATE_END => '2013-11-21'
          },
          'C1' =>
          {
            YEAR => 2013,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-21',
            DATE_END => '2013-11-22'
          },
          'C2' =>
          {
            YEAR => 2013,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-22',
            DATE_END => '2013-11-22'
          },
          'C3' =>
          {
            YEAR => 2013,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-22',
            DATE_END => '2013-11-24'
          },

          'C4' =>
          {
            YEAR => 2013,
            GENDER => 'Women',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-24',
            DATE_END => '2013-11-24'
          }
        }
      },
      '2014' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=MIWI4I
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2014,
            GENDER => 'Seniors',
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C1' =>
          {
            YEAR => 2014,
            GENDER => 'Seniors',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
          'C2' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-13'
          },
          'C3' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-14'
          },

          'C4' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-11'
          },
          'C5' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-12'
          },
          'C6' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-13'
          },
          'C7' =>
          {
            YEAR => 2014,
            GENDER => 'Open',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-14'
          }
        }
      },
      '2015' =>
      {
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=MIWI5I

        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2015,
            AGE => 'Seniors',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-08'
          },
          'C1' =>
          {
            YEAR => 2015,
            AGE => 'Seniors',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-09'
          },
          'C2' =>
          {
            YEAR => 2015,
            AGE => 'Seniors',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-10'
          },
          'C3' =>
          {
            YEAR => 2015,
            AGE => 'Seniors',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-11'
          },

          'C4' =>
          {
            YEAR => 2015,
            AGE => 'Open',
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-11-19',
            DATE_END => '2015-11-19'
          },
          'C5' =>
          {
            YEAR => 2015,
            AGE => 'Open',
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-20'
          },
          'C6' =>
          {
            YEAR => 2015,
            AGE => 'Open',
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-21'
          },
          'C7' =>
          {
            YEAR => 2015,
            AGE => 'Open',
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          }
        }
      }
    }
  }

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ITALY, \%TOURNAMENTS_ITALY, 'Germany');
}

1;
