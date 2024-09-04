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
  'Italian Club Championship' =>
  {
    ORGANIZATION => 'FIGB',
    COUNTRY => 'Italy',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-12-16',
        DATE_END => '2004-12-16'
      },
      '2005' =>
      {
        # https://www.federbridge.it/campionati/2005/CSSASBSC/indice.asp
        YEAR => 2005,
        CITY => 'Salsomaggiore',
        DATE_START => '2005-02-12',
        DATE_END => '2005-04-08'
      },
      '2006' =>
      {
        # https://www.federbridge.it/campionati/2006/CSSASBSC/indice.asp
        YEAR => 2006,
        CITY => 'Montecatini',
        DATE_START => '2006-09-28',
        DATE_END => '2006-10-01'
      },
      '2007' =>
      {
        # https://www.federbridge.it/campionati/2007/CLCCSQMX/indice.asp
        YEAR => 2007,
        CITY => 'Salsomaggiore',
        DATE_START => '2007-10-27',
        DATE_END => '2007-10-28'
      },
      '2008' =>
      {
        # https://www.federbridge.it/campionati/2008/CSSASBSC/indice.asp
        YEAR => 2008,
        CITY => 'San Remo',
        DATE_START => '2008-09-18',
        DATE_END => '2008-09-21'
      },
      '2009' =>
      {
        # https://www.federbridge.it/campionati/2009/CSSASBSC/indice.asp
        YEAR => 2009,
        CITY => 'Bologna',
        DATE_START => '2009-09-24',
        DATE_END => '2009-09-27'
      },
      '2010' =>
      {
        # https://www.federbridge.it/campionati/2010/CSS1S2S3/indice.asp
        YEAR => 2010,
        CITY => 'Bologna',
        DATE_START => '2010-09-23',
        DATE_END => '2010-09-26'
      },
      '2011' =>
      {
        # https://www.federbridge.it/campionati/2011/CSS1S2S3/indice.asp
        YEAR => 2011,
        CITY => 'Salsomaggiore',
        DATE_START => '2011-09-22',
        DATE_END => '2011-09-25'
      },
      '2012' =>
      {
        # https://www.federbridge.it/campionati/2012/CSS1S2S3/indice.asp
        YEAR => 2012,
        CITY => 'Salsomaggiore',
        DATE_START => '2012-09-27',
        DATE_END => '2012-09-30'
      },
      '2013' =>
      {
        # https://www.federbridge.it/campionati/2013/CSS1S2S3/indice.asp
        YEAR => 2013,
        CITY => 'Salsomaggiore',
        DATE_START => '2013-10-03',
        DATE_END => '2013-10-06'
      },
      '2014' =>
      {
        # https://www.federbridge.it/campionati/2014/CSS1S2S3/indice.asp
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        DATE_START => '2014-09-25',
        DATE_END => '2014-09-28'
      },
      '2015' =>
      {
        # https://www.federbridge.it/campionati/2015/CSS1S2S3/indice.asp
        YEAR => 2015,
        CITY => 'Salsomaggiore',
        DATE_START => '2015-06-19',
        DATE_END => '2015-06-21'
      },
      '2016' =>
      {
        # https://www.federbridge.it/campionati/2016/CSS1S2S3/indice.asp
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        DATE_START => '2016-05-19',
        DATE_END => '2016-05-22'
      },
      '2017' =>
      {
        # https://www.federbridge.it/campionati/2017/CSS1S2S3/indice.asp
        YEAR => 2017,
        CITY => 'Salsomaggiore',
        DATE_START => '2017-05-18',
        DATE_END => '2017-05-21'
      },
      '2018' =>
      {
        # https://www.federbridge.it/campionati/2018/CSSASBSC/indice.asp
        YEAR => 2018,
        CITY => 'Salsomaggiore',
        DATE_START => '2018-04-05',
        DATE_END => '2018-04-08'
      },
      '2019' =>
      {
        # https://www.federbridge.it/campionati/2019/CSSASBSC/indice.asp
        YEAR => 2019,
        CITY => 'Salsomaggiore',
        DATE_START => '2019-04-04',
        DATE_END => '2019-04-07'
      },
      '2020' =>
      {
        # https://www.federbridge.it/campionati/2019/CSSASBSC/indice.asp
        YEAR => 2020,
        CITY => 'Salsomaggiore',
        DATE_START => '2020-02-20',
        DATE_END => '2020-09-27'
      },
      # Nothing in 2021?
      # https://www.federbridge.it/campionati/2019/CSSASBSC/indice.asp
      '2022' =>,
      {
        # https://www.federbridge.it/campionati/2022/CSSASBSC/indice.asp
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        DATE_START => '2022-09-22',
        DATE_END => '2022-09-25'
      },
      '2023' =>
      {
        # https://www.federbridge.it/campionati/2023/CSSQSASBSC/indice.asp
        YEAR => 2023,
        CITY => 'Salsomaggiore',
        DATE_START => '2023-02-23',
        DATE_END => '2023-02-26'
      },
      '2024' =>
      {
        # https://www.federbridge.it/campionati/2024/CSSQSASBSC/indice.asp
        YEAR => 2024,
        CITY => 'Salsomaggiore',
        DATE_START => '2024-02-29',
        DATE_END => '2024-03-03'
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
        YEAR => 2004,
        DATE_START => '2004-06-05',
        DATE_END => '2004-06-08'
      },
      '2005' =>
      {
        YEAR => 2005,
        CITY => 'Bologna',
        DATE_START => '2005-12-10',
        DATE_END => '2005-12-11'
      },
      '2006' =>
      {
        YEAR => 2006,
        CITY => 'Bologna',
        DATE_START => '2006-12-14',
        DATE_END => '2006-12-17'
      },
      '2007' =>
      {
        YEAR => 2007,
        CITY => 'Salsomaggiore',
        DATE_START => '2007-12-14',
        DATE_END => '2007-12-16'
      },
      '2008' =>
      {
        YEAR => 2008,
        CITY => 'Salsomaggiore',
        DATE_START => '2008-12-12',
        DATE_END => '2008-12-14'
      },
      '2009' =>
      {
        CITY => 'Salsomaggiore',
        YEAR => 2009,
        DATE_START => '2009-12-11',
        DATE_END => '2009-12-13'
      },
      '2010' =>
      {
        YEAR => 2010,
        CITY => 'Salsomaggiore',
        DATE_START => '2010-12-16',
        DATE_END => '2010-12-19'
      },
      '2011' =>
      {
        # https://www.federbridge.it/campionati/2011/CI/programma.asp?ciType=4I
        YEAR => 2011,
        CITY => 'Salsomaggiore',
        DATE_START => '2011-12-16',
        DATE_END => '2011-12-18'
      },
      '2012' =>
      {
        # https://www.federbridge.it/campionati/2012/CI/programma.asp?ciType=4I
        YEAR => 2012,
        CITY => 'Salsomaggiore',
        DATE_START => '2012-12-14',
        DATE_END => '2012-12-16'
      },
      '2013' =>
      {
        # https://www.federbridge.it/campionati/2013/ci/programma.asp?ciType=4I

        YEAR => 2013,
        CITY => 'Salsomaggiore',
        DATE_START => '2013-11-21',
        DATE_END => '2013-11-24'
      },
      '2014' =>
      {
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=MIWI4I
        # https://www.federbridge.it/campionati/2014/CI/programma.asp?ciType=XI
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        DATE_START => '2014-09-11',
        DATE_END => '2014-12-14'
      },
      '2015' =>
      {
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=MIWI5I
        # https://www.federbridge.it/campionati/2015/CI/programma.asp?ciType=XI

        YEAR => 2015,
        CITY => 'Salsomaggiore',
        DATE_START => '2015-10-08',
        DATE_END => '2015-11-22'
      },
      '2016' =>
      {
        # https://www.federbridge.it/campionati/2016/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2016/CI/programma.asp?ciType=XI
        # https://www.federbridge.it/campionati/2016/CI/programma.asp?ciType=MIWI5I

        YEAR => 2016,
        CITY => 'Salsomaggiore',
        DATE_START => '2016-09-23',
        DATE_END => '2016-12-11'
      },
      '2017' =>
      {
        # https://www.federbridge.it/campionati/2017/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2017/CI/programma.asp?ciType=XI
        # https://www.federbridge.it/campionati/2017/CI/programma.asp?ciType=MIWI5I

        YEAR => 2017,
        CITY => 'Salsomaggiore',
        DATE_START => '2017-09-21',
        DATE_END => '2017-12-17'
      },
      '2018' =>
      {
        # https://www.federbridge.it/campionati/2018/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2018/CI/programma.asp?ciType=XI
        # https://www.federbridge.it/campionati/2018/CI/programma.asp?ciType=MIWI

        YEAR => 2018,
        CITY => 'Salsomaggiore',
        DATE_START => '2018-09-13',
        DATE_END => '2018-11-18'
      },
      '2019' =>
      {
        # https://www.federbridge.it/campionati/2019/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2019/CI/programma.asp?ciType=XI
        # https://www.federbridge.it/campionati/2019/CI/programma.asp?ciType=MIWI

        YEAR => 2019,
        CITY => 'Salsomaggiore',
        DATE_START => '2019-10-10',
        DATE_END => '2019-11-24'
      },
      '2022' =>
      {
        # https://www.federbridge.it/campionati/2022/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2022/CI/programma.asp?ciType=XI
        #  https://www.federbridge.it/campionati/2022/CI/programma.asp?ciType=MIWI

        YEAR => 2022,
        CITY => 'Salsomaggiore',
        DATE_START => '2022-10-12',
        DATE_END => '2022-20-11'
      },
      '2023' =>
      {
        # https://www.federbridge.it/campionati/2023/CI/programma.asp?ciType=OI
        # https://www.federbridge.it/campionati/2023/CI/programma.asp?ciType=XI
        # https://www.federbridge.it/campionati/2023/CI/programma.asp?ciType=MIWI

        YEAR => 2023,
        CITY => 'Salsomaggiore',
        DATE_START => '2023-09-28',
        DATE_END => '2023-12-10'
      },
      '2024' =>
      {
        # https://www.federbridge.it/campionati/indice.asp?cYear=2024
        # Not yet available (as of 2024-09-04)
        # 

        YEAR => 2024,
        CITY => 'Salsomaggiore',
        DATE_START => '2024-10-10',
        DATE_END => '2024-12-15'
      },
    }
  }
);

my %TOURNAMENTS_ITALY =
(
  'Italian Club Open Championship' =>
  {
    AGE => 'Open',
    GENDER => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          } ,
          'C1' =>
          {
            STAGE => => 'Final',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Qualifying',
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2005-02-12',
            DATE_END => '2005-02-13'
          },
          'C1' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-04-07',
            DATE_END => '2005-04-07'
          },
          'C2' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-04-08',
            DATE_END => '2005-04-08'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2006-09-28',
            DATE_END => '2006-09-29'
          } ,
          'C1' =>
          {
            STAGE => => 'Final',
            major => 'ROUND',
            DATE_START => '2006-09-30',
            DATE_END => '2006-10-01'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2007-10-27',
            DATE_END => '2007-10-27'
          } ,
          'C1' =>
          {
            STAGE => => 'Final',
            major => 'ROUND',
            DATE_START => '2007-10-28',
            DATE_END => '2007-10-28'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-18',
            DATE_END => '2008-09-19'
          },
          'C1' =>
          {
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2008-09-19',
            DATE_END => '2008-09-20'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-19',
            DATE_END => '2008-09-21'
          }
        }
      },
      '2009' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-24',
            DATE_END => '2009-09-25'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-25',
            DATE_END => '2009-09-27'
          }
        }
      },
      '2010' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-09-23',
            DATE_END => '2010-09-24'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-09-24',
            DATE_END => '2010-09-26'
          }
        }
      },
      '2011' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-22',
            DATE_END => '2011-09-23'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-25'
          }
        }
      },
      '2012' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-27',
            DATE_END => '2012-09-28'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-28',
            DATE_END => '2012-09-30'
          }
        }
      },
      '2013' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-04',
            DATE_END => '2013-10-04'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
          }
        }
      },
      '2014' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-09-25',
            DATE_END => '2014-09-25'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-26',
            DATE_END => '2014-09-27'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          }
        }
      },
      '2015' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-19',
            DATE_END => '2015-06-20'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-20',
            DATE_END => '2015-06-21'
          }
        }
      },
      '2016' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-05-19',
            DATE_END => '2016-05-20'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-20',
            DATE_END => '2016-05-21'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-21',
            DATE_END => '2016-05-22'
          }
        }
      },
      '2017' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2017-05-18',
            DATE_END => '2017-05-19'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-05-19',
            DATE_END => '2017-05-20'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-05-20',
            DATE_END => '2017-05-21'
          }
        }
      },
      '2018' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2018-04-05',
            DATE_END => '2018-04-06'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-04-06',
            DATE_END => '2018-04-07'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-04-07',
            DATE_END => '2018-04-08'
          }
        }
      },
      '2019' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2019-04-04',
            DATE_END => '2019-04-05'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-04-05',
            DATE_END => '2019-04-06'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-04-06',
            DATE_END => '2019-04-07'
          }
        }
      },
      '2020' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2020-02-20',
            DATE_END => '2020-02-22'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-09-19',
            DATE_END => '2020-09-20'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2022-09-22',
            DATE_END => '2022-09-24'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-09-24',
            DATE_END => '2022-09-25'
          }
        }
      },
      '2023' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2023-02-23',
            DATE_END => '2023-02-25'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-02-25',
            DATE_END => '2023-02-26'
          }
        }
      },
      '2024' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2024-02-29',
            DATE_END => '2024-03-02'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-03-02',
            DATE_END => '2024-03-03'
          }
        }
      }
    }
  },

  'Italian Club Women Championship' =>
  {
    AGE => 'Open',
    GENDER => 'Women',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2004-12-16',
            DATE_END => '2004-12-16'
          }
        }
      },
      '2006' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-09-30',
            DATE_END => '2006-10-01'
          }
        }
      },
      '2007' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-10-27',
            DATE_END => '2007-10-27'
          }
        }
      },
      '2008' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-18',
            DATE_END => '2008-09-19'
          }
        }
      },
      '2014' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          }
        }
      },
      '2017' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2017-05-18',
            DATE_END => '2017-05-19'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-05-19',
            DATE_END => '2017-05-20'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-05-20',
            DATE_END => '2017-05-21'
          }
        }
      },
      '2018' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2018-04-05',
            DATE_END => '2018-04-06'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-04-06',
            DATE_END => '2018-04-07'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-04-07',
            DATE_END => '2018-04-08'
          }
        }
      },
      '2019' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2019-04-04',
            DATE_END => '2019-04-05'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-04-05',
            DATE_END => '2019-04-06'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-04-06',
            DATE_END => '2019-04-07'
          }
        }
      },
      '2020' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2020-02-20',
            DATE_END => '2020-02-22'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-09-26',
            DATE_END => '2020-09-27'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2022-09-22',
            DATE_END => '2022-09-24'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-09-24',
            DATE_END => '2022-09-25'
          }
        }
      },
      '2023' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2023-02-23',
            DATE_END => '2023-02-25'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-02-25',
            DATE_END => '2023-02-26'
          }
        }
      },
      '2024' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2024-02-29',
            DATE_END => '2024-03-02'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-03-02',
            DATE_END => '2024-03-03'
          }
        }
      }
    }
  },

  # Probably the same as Open Cup, but would take some relabeling
  # of Men into Open in the original files.
  'Italian Men Cup' =>
  {
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-05',
            DATE_END => '2004-06-06'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-06',
            DATE_END => '2004-06-07'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-07',
            DATE_END => '2004-06-08'
          }
        }
      },
      '2009' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-11'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-12'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-12'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-13'
          }
        }
      },
      '2010' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-12-16',
            DATE_END => '2010-12-16'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-17'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-18'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-19'
          }
        }
      }
    }
  },

  'Italian Mixed Cup' =>
  {
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-29'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-30'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-30',
            DATE_END => '2014-10-30'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-10-30',
            DATE_END => '2014-10-31'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-10-31',
            DATE_END => '2014-11-01'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2015-10-28',
            DATE_END => '2015-10-28'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-28',
            DATE_END => '2015-10-29'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-29',
            DATE_END => '2015-10-29'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-29',
            DATE_END => '2015-10-30'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-30',
            DATE_END => '2015-10-30'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2016-10-28',
            DATE_END => '2016-10-28'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-10-28',
            DATE_END => '2016-10-29'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-29'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-10-30',
            DATE_END => '2016-10-30'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-28'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-29'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-10-29',
            DATE_END => '2017-10-29'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-10-29',
            DATE_END => '2017-10-30'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-10-30',
            DATE_END => '2017-10-30'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2018-10-31',
            DATE_END => '2018-10-31'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-10-31',
            DATE_END => '2018-11-01'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-01',
            DATE_END => '2018-11-01'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-01',
            DATE_END => '2018-11-02'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-02',
            DATE_END => '2018-11-02'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2019-10-30',
            DATE_END => '2019-10-30'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-10-30',
            DATE_END => '2019-10-31'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-31',
            DATE_END => '2019-10-31'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-31',
            DATE_END => '2019-11-01'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-01',
            DATE_END => '2019-11-01'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2020-10-28',
            DATE_END => '2020-10-28'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2020-10-28',
            DATE_END => '2020-10-29'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2020-10-29',
            DATE_END => '2020-10-29'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2020-10-29',
            DATE_END => '2020-10-30'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-10-30',
            DATE_END => '2020-10-30'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2023-10-28',
            DATE_END => '2023-10-28'
          },
          'C1' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2023-10-28',
            DATE_END => '2023-10-29'
          },
          'C2' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-10-29',
            DATE_END => '2023-10-29'
          },
          'C3' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-10-29',
            DATE_END => '2023-10-30'
          },
          'C4' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-10-30',
            DATE_END => '2023-10-30'
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
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            DATE_START => '2014-11-01',
            DATE_END => '2014-11-02'
          }
        }
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          }
        }
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-10-31',
            DATE_END => '2016-11-01'
          }
        }
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2017/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2017-10-31',
            DATE_END => '2017-11-01'
          }
        }
      },
      '2018' =>
      {
        YEAR => 2018,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2018/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2018-11-03',
            DATE_END => '2018-11-04'
          }
        }
      },
      '2019' =>
      {
        YEAR => 2019,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2019/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2019-11-02',
            DATE_END => '2019-11-03'
          }
        }
      },
      '2022' =>
      {
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2022/CXCCMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2022-10-31',
            DATE_END => '2022-11-01'
          }
        }
      },
      '2023' =>
      {
        YEAR => 2023,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2023/CXCCLBMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2023-10-31',
            DATE_END => '2023-11-01'
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
        YEAR => 2010,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2010/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-10-29',
            DATE_END => '2010-11-01'
          }
        }
      },
      '2011' =>
      {
        YEAR => 2011,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-30',
            DATE_END => '2011-11-01'
          }
        }
      },
      '2012' =>
      {
        YEAR => 2012,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-11-01',
            DATE_END => '2012-11-04'
          }
        }
      },
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/CXSQMX/indice.asp
        
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-30',
            DATE_END => '2013-06-02'
          }
        }
      },
      '2014' =>
      {
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/CXSQMX/indice.asp
        
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-02'
          }
        }
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-30',
            DATE_END => '2015-06-02'
          }
        }
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-06-02',
            DATE_END => '2016-06-05'
          }
        }
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2017/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-06-01',
            DATE_END => '2017-06-04'
          }
        }
      },
      '2018' =>
      {
        YEAR => 2018,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2018/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-05-31',
            DATE_END => '2018-06-03'
          }
        }
      },
      '2019' =>
      {
        YEAR => 2019,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2019/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-05-30',
            DATE_END => '2019-06-02'
          }
        }
      },
      '2021' =>
      {
        YEAR => 2021,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2021/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2021-11-18',
            DATE_END => '2021-11-21'
          }
        }
      },
      '2022' =>
      {
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2022/CXSQMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-05-02',
            DATE_END => '2022-05-06'
          }
        }
      },
      '2023' =>
      {
        YEAR => 2023,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2023/CXSQLBMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-06-01',
            DATE_END => '2023-06-04'
          }
        }
      },
      '2024' =>
      {
        YEAR => 2024,
        CITY => 'Salsomaggiore',
        # Not yet available
        # https://www.federbridge.it/campionati/2023/CXSQLBMX/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-11-07',
            DATE_END => '2024-11-10'
          }
        }
      }
    }
  },

  'Italian Open Cup' =>
  {
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-10'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          }
        }
      },
      '2006' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-14',
            DATE_END => '2006-12-15'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-15',
            DATE_END => '2006-12-16'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-12-16',
            DATE_END => '2006-12-17'
          }
        }
      },
      '2007' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-14',
            DATE_END => '2007-12-15'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-12-15',
            DATE_END => '2007-12-15'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-15',
            DATE_END => '2007-12-16'
          }
        }
      },
      '2008' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-12',
            DATE_END => '2008-12-13'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-13',
            DATE_END => '2008-12-13'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-13',
            DATE_END => '2008-12-14'
          }
        }
      },
      '2009' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-11'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-12'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-12'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-13'
          }
        }
      },
      '2010' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2010-12-16',
            DATE_END => '2010-12-16'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-17'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-18'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-19'
          }
        }
      },
      '2011' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-16'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-17'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-17',
            DATE_END => '2011-12-17'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-17',
            DATE_END => '2011-12-18'
          }
        }
      },
      '2012' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-14'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-15'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-15'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-16'
          }
        }
      },
      '2013' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-11-21',
            DATE_END => '2013-11-21'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-21',
            DATE_END => '2013-11-22'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-22',
            DATE_END => '2013-11-22'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-22',
            DATE_END => '2013-11-24'
          }
        }
      },
      '2014' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-13'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-14'
          },
          'C2' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-11'
          },
          'C3' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-12'
          },
          'C4' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-13'
          },
          'C5' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-14'
          }
        }
      },
      '2015' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-11-19',
            DATE_END => '2015-11-19'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-20'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2015-11-20',
            DATE_END => '2015-11-21'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          }
        }
      },
      '2016' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-12-08',
            DATE_END => '2016-12-08'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-12-09',
            DATE_END => '2016-12-09'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2016-12-09',
            DATE_END => '2016-12-10'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-12-10',
            DATE_END => '2016-12-11'
          }
        }
      },
      '2017' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2017-12-14',
            DATE_END => '2017-12-14'
          },
          'C1' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-12-15',
            DATE_END => '2017-12-15'
          },
          'C2' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-12-16',
            DATE_END => '2017-12-16'
          },
          'C3' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-12-16',
            DATE_END => '2017-12-17'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-15'
          },
          'C1' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-16',
            DATE_END => '2018-11-16'
          },
          'C2' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-16',
            DATE_END => '2018-11-17'
          },
          'C3' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-11-21',
            DATE_END => '2019-11-21'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-22'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-23'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-24'
          }
        }
      },
      '2022' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2022-11-17',
            DATE_END => '2022-11-17'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-18'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-19'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-11-19',
            DATE_END => '2022-11-20'
          }
        }
      },
      '2023' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2023-12-07',
            DATE_END => '2023-12-07'
          },
          'C1' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2023-12-07',
            DATE_END => '2023-12-08'
          },
          'C2' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-08',
            DATE_END => '2023-12-08'
          },
          'C3' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-08',
            DATE_END => '2023-12-09'
          },
          'C4' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-12-09',
            DATE_END => '2023-12-10'
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
        YEAR => 2004,
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-30'
          },
          'C1' =>
          {
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2004-05-01',
            DATE_END => '2004-05-02'
          },
        }
      },
      '2006' =>
      {
        YEAR => 2006,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2006/CPSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-04-23',
            DATE_END => '2006-04-25'
          }
        }
      },
      '2010' =>
      {
        YEAR => 2010,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2010/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-04-29',
            DATE_END => '2010-05-02'
          }
        }
      },
      '2011' =>
      {
        YEAR => 2011,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2011/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-04-28',
            DATE_END => '2011-05-01'
          }
        }
      },
      '2012' =>
      {
        YEAR => 2012,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2012/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-04-28',
            DATE_END => '2012-05-01'
          }
        }
      },
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2013/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-04-25',
            DATE_END => '2013-04-28'
          }
        }
      },
      '2014' =>
      {
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        #  https://www.federbridge.it/campionati/2014/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-24',
            DATE_END => '2014-04-27'
          }
        }
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2015/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-30',
            DATE_END => '2015-05-03'
          }
        }
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-04-22',
            DATE_END => '2016-04-25'
          }
        }
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2017/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-04-22',
            DATE_END => '2017-04-25'
          }
        }
      },
      '2018' =>
      {
        YEAR => 2018,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2018/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-04-28',
            DATE_END => '2018-05-01'
          }
        }
      },
      '2019' =>
      {
        YEAR => 2019,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2019/CXSQLBSG/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-04-25',
            DATE_END => '2019-04-28'
          }
        }
      },
      '2021' =>
      {
        YEAR => 2021,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2021/CXSQLB/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2021-10-29',
            DATE_END => '2021-11-01'
          }
        }
      },
      '2022' =>
      {
        YEAR => 2022,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2022/CXSQLB/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-04-22',
            DATE_END => '2022-04-25'
          }
        }
      },
      '2023' =>
      {
        YEAR => 2023,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2023/CXSQLBOP/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-04-28',
            DATE_END => '2023-05-01'
          }
        }
      },
      '2024' =>
      {
        YEAR => 2024,
        CITY => 'Salsomaggiore',
        #  Not yet available

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-09-26',
            DATE_END => '2024-09-29'
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
        YEAR => 2014,
          CITY => 'Salsomaggiore',
          # https://www.federbridge.it/campionati/2014/SSSQOP/indice.asp

          'C0' =>
          {
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-01-31',
            DATE_END => '2014-02-01'
          },
          'C1' =>
          {
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-02-02',
            DATE_END => '2014-02-02'
          },

          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-13',
            DATE_END => '2014-02-14'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-16'
          } 
        }
      }
    }
  },

  'Italian Senior Cup' =>
  {
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-12'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-12',
            DATE_END => '2014-09-13'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-14'
          }
        }
      },
      '2015' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-10-08',
            DATE_END => '2015-10-08'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-09'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-09',
            DATE_END => '2015-10-10'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-10',
            DATE_END => '2015-10-11'
          }
        }
      },
      '2016' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            MOVEMENT => 'Swiss',
            major => 'SEGMENT',
            DATE_START => '2016-09-23',
            DATE_END => '2016-09-26'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-09-26',
            DATE_END => '2016-09-27'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-09-27',
            DATE_END => '2016-09-27'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-09-28',
            DATE_END => '2016-09-28'
          }
        }
      },
      '2017' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2017-09-21',
            DATE_END => '2017-09-21'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-09-22',
            DATE_END => '2017-09-22'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-09-22',
            DATE_END => '2017-09-23'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-09-23',
            DATE_END => '2017-09-24'
          }
        }
      },
      '2018' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-09-13',
            DATE_END => '2018-09-13'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-09-13',
            DATE_END => '2018-09-14'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-09-14',
            DATE_END => '2018-09-15'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-09-15',
            DATE_END => '2018-09-16'
          }
        }
      },
      '2019' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2019-10-10',
            DATE_END => '2019-10-10'
          },
          'C1' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-10-10',
            DATE_END => '2019-10-11'
          },
          'C2' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-11',
            DATE_END => '2019-10-11'
          },
          'C3' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-10-11',
            DATE_END => '2019-10-12'
          },
          'C4' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-10-12',
            DATE_END => '2019-10-13'
          }
        }
      },
      '2020' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2022-10-12',
            DATE_END => '2022-10-12'
          },
          'C1' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2022-10-12',
            DATE_END => '2022-10-13'
          },
          'C2' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2022-10-13',
            DATE_END => '2022-10-13'
          },
          'C3' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-10-13',
            DATE_END => '2022-10-14'
          },
          'C4' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-10-14',
            DATE_END => '2022-10-14'
          }
        }
      },
      '2023' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-28'
          },
          'C1' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2023-09-28',
            DATE_END => '2023-09-29'
          },
          'C2' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-29'
          },
          'C3' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-09-29',
            DATE_END => '2023-09-30'
          },
          'C4' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-09-30',
            DATE_END => '2023-10-01'
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
        YEAR => 2014,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2014/SSSN/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          },
          'C1' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-09',
            DATE_END => '2014-03-09'
          },

          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-03',
            DATE_END => '2014-04-04'
          },
          'C3' =>
          {
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
        YEAR => 2016,
        CITY => 'Salsomaggiore',
        # https://www.federbridge.it/campionati/2016/CU/indice.asp

        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-26'
          }
        }
      }
    }
  },

  'Italian Women Cup' =>
  {
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-05',
            DATE_END => '2004-06-06'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-06-06',
            DATE_END => '2004-06-07'
          }
        }
      },
      '2005' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-10'
          }
        }
      },
      '2010' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-19'
          }
        }
      },
      '2012' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-16'
          }
        }
      },
      '2013' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-24',
            DATE_END => '2013-11-24'
          }
        }
      },
      '2016' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-12-08',
            DATE_END => '2016-12-08'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-12-09',
            DATE_END => '2016-12-09'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2016-12-09',
            DATE_END => '2016-12-10'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-12-10',
            DATE_END => '2016-12-11'
          }
        }
      },
      '2017' =>
      {
        MEET => 'Italian Club Championship',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2017-05-18',
            DATE_END => '2017-05-19'
          },
          'C1' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-05-19',
            DATE_END => '2017-05-20'
          },
          'C2' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-05-20',
            DATE_END => '2017-05-21'
          }
        }
      },
      '2018' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-15'
          },
          'C1' =>
          {
            STAGE => => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-16',
            DATE_END => '2018-11-16'
          },
          'C2' =>
          {
            STAGE => => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-16',
            DATE_END => '2018-11-17'
          },
          'C3' =>
          {
            STAGE => => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2019-11-21',
            DATE_END => '2019-11-21'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-22'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-23'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-23',
            DATE_END => '2019-11-24'
          }
        }
      },
      '2022' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2022-11-17',
            DATE_END => '2022-11-17'
          },
          'C1' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-18'
          },
          'C2' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-11-18',
            DATE_END => '2022-11-19'
          },
          'C3' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-11-19',
            DATE_END => '2022-11-20'
          }
        }
      },
      '2023' =>
      {
        MEET => 'Italy Cup',
        CHAPTERS => 
        {
          'C0' =>
          {
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2023-12-07',
            DATE_END => '2023-12-07'
          },
          'C1' =>
          {
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2023-12-07',
            DATE_END => '2023-12-08'
          },
          'C2' =>
          {
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-08',
            DATE_END => '2023-12-08'
          },
          'C3' =>
          {
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-08',
            DATE_END => '2023-12-09'
          },
          'C4' =>
          {
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-12-09',
            DATE_END => '2023-12-10'
          }
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ITALY, \%TOURNAMENTS_ITALY, 'Italy');
}

1;
