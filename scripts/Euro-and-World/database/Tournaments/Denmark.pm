#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Denmark;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'DBF',
  COUNTRY => 'Denmark',
  ZONE => 'Europe',
);

my %MEETS_DENMARK =
(
  'Copenhagen Invitational' =>
  {
    %GLOBAL,
    CITY => 'Copenhagen',

    EDITIONS =>
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-11-04',
        DATE_END => '2010-11-07'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-02-21',
        DATE_END => '2013-02-24'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-12-13',
        DATE_END => '2014-12-14'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-01-15',
        DATE_END => '2015-01-18'
      }
    }
  },

  'Danish Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2009' =>
      {
        YEAR => 2009,
        CITY => 'Svendborg',
        DATE_START => '2009-07-08',
        DATE_END => '2009-07-12'
      },

      '2010' =>
      {
        YEAR => 2010,
        CITY => 'Svendborg',
        DATE_START => '2010-07-12',
        DATE_END => '2010-07-18'
      },
      '2011' =>
      {
        # https://bridge.dk/2011/
        YEAR => 2011,
        CITY => 'Svendborg',
        DATE_START => '2011-07-09',
        DATE_END => '2011-07-17'
      },
      '2012' =>
      {
        # https://bridge.dk/2012/
        YEAR => 2012,
        CITY => 'Svendborg',
        DATE_START => '2012-07-07',
        DATE_END => '2012-07-15'
      },
      '2013' =>
      {
        # https://bridge.dk/2013/
        YEAR => 2013,
        CITY => 'Svendborg',
        DATE_START => '2013-07-06',
        DATE_END => '2013-07-14'
      },
      '2014' =>
      {
        # https://bridge.dk/2014/
        YEAR => 2014,
        CITY => 'Svendborg',
        DATE_START => '2014-07-05',
        DATE_END => '2014-07-13'
      },
      '2015' =>
      {
        # https://bridge.dk/2015/
        YEAR => 2015,
        CITY => 'Svendborg',
        DATE_START => '2015-07-03',
        DATE_END => '2015-07-12'
      },
      '2016' =>
      {
        # https://bridge.dk/2016/
        YEAR => 2016,
        CITY => 'Svendborg',
        DATE_START => '2016-07-09',
        DATE_END => '2016-07-17'
      },
      '2017' =>
      {
        # https://bridge.dk/2017/
        YEAR => 2017,
        CITY => 'Svendborg',
        DATE_START => '2017-07-08',
        DATE_END => '2017-07-16'
      },
      '2018' =>
      {
        # https://bridge.dk/2018/
        YEAR => 2018,
        CITY => 'Svendborg',
        DATE_START => '2018-07-08',
        DATE_END => '2018-07-15'
      },
      '2019' =>
      {
        # https://bridge.dk/2019/
        YEAR => 2019,
        CITY => 'Svendborg',
        DATE_START => '2019-07-05',
        DATE_END => '2019-07-14'
      },
      '2020' =>
      {
        # https://bridge.dk/2020/
        YEAR => 2020,
        CITY => 'Svendborg', # Probably cancelled
        DATE_START => '2020-07-03',
        DATE_END => '2020-07-12'
      },
      '2021' =>
      {
        # https://bridge.dk/2021/
        YEAR => 2021,
        CITY => 'Online',
        DATE_START => '2021-07-09',
        DATE_END => '2021-07-18'
      },
      '2022' =>
      {
        # https://bridge.dk/2022/
        YEAR => 2022,
        CITY => 'Svendborg',
        DATE_START => '2022-07-08',
        DATE_END => '2022-07-17'
      },
      '2023' =>
      {
        # https://bridge.dk/2023/
        YEAR => 2023,
        CITY => 'Svendborg',
        DATE_START => '2023-07-08',
        DATE_END => '2023-07-15'
      },
      '2024' =>
      {
        # https://bridge.dk/2024/
        YEAR => 2024,
        CITY => 'Svendborg',
        DATE_START => '2024-07-06',
        DATE_END => '2024-07-13'
      },
      '2025' =>
      {
        # https://bridge.dk/2025/
        YEAR => 2025,
        CITY => 'Svendborg',
        DATE_START => '2025-07-04',
        DATE_END => '2025-07-12'
      },
    }
  },

  'Danish Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2003' =>
      {
        YEAR => 2003,
        DATE_START => '2003-05-31',
        DATE_END => '2003-05-31'
      },
    }
  }
);

my %TOURNAMENTS_DENMARK =
(
  'Copenhagen Invitational Pairs',
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Copenhagen Invitational',
        SCORING => 'IMP',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-05',
            DATE_END => '2010-11-07'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Copenhagen Invitational',
        SCORING => 'IMP',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-02-22',
            DATE_END => '2013-02-24'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Copenhagen Invitational',
        SCORING => 'MP',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-14'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Copenhagen Invitational',
        SCORING => 'IMP',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-01-16',
            DATE_END => '2015-01-18'
          } 
        }
      }
    }
  },

  'Copenhagen Open Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',
    CITY => 'Copenhagen',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SECTION',
            DATE_START => '2013-04-20',
            DATE_END => '2013-04-21'
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
            major => 'SECTION',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16'
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
            major => 'SECTION',
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-29'
          } 
        }
      }
    }
  },

  'Copenhagen Pro-Am Pairs',
  {
    ORIGIN => 'Pro-Am',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Copenhagen Invitational',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-11-04',
            DATE_END => '2010-11-04'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Copenhagen Invitational',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-02-21',
            DATE_END => '2013-02-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Copenhagen Invitational',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-15',
            DATE_END => '2015-01-15'
          } 
        }
      },
    }
  },

  'Danish Open Pairs Trials',
  {
    COUNTRY => 'Denmark',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-10-25',
            DATE_END => '2000-10-26'
          } 
        }
      },
    }
  },

  'Danish Club Teams',
  {
    %GLOBAL,
    ORIGIN => 'Interclub',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18619#21568
        CITY => 'Slagelse',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-10-25',
            DATE_END => '2008-10-26'
          } 
        }
      },

      '2009' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18805#26986
        CITY => 'Århus',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-10-24',
            DATE_END => '2009-10-25'
          } 
        }
      },

      '2010' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=17978#20654
        CITY => 'Køge',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-31'
          } 
        }
      },

      '2011' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18971#22277
        CITY => 'Odense',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-10-29',
            DATE_END => '2011-10-30'
          } 
        }
      },

      '2012' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19166#22982
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2012-10-28',
            DATE_END => '2012-10-29'
          } 
        }
      },

      '2013' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19549#23398
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-27'
          } 
        }
      },

      '2014' =>
      {
        # http://hobro.wp.bridge.dk/wp-content/uploads/sites/12/2013/08/DM_Klubhold_2014-program.pdf
        CITY => 'Hobro',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND|MATCH',
            DATE_START => '2014-10-25',
            DATE_END => '2014-10-26'
          } 
        }
      },

      '2015' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19341#23247
        CITY => 'Hobro',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-10-24',
            DATE_END => '2015-10-25'
          } 
        }
      },

      '2016' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22394#26981
        CITY => 'Slagelse',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
          } 
        }
      },

      '2017' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22352#26915
        CITY => 'Haderslev',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-29'
          } 
        }
      },

      '2018' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22961#27700
        CITY => 'Næstved',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-27',
            DATE_END => '2018-10-28'
          } 
        }
      },

      '2019' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25136#30729
        CITY => 'Århus',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-26',
            DATE_END => '2019-10-27'
          } 
        }
      },

      '2020' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25540#31135
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-10-24',
            DATE_END => '2020-10-25'
          } 
        }
      },

      '2021' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26012
        CITY => 'Odense',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-30',
            DATE_END => '2021-10-31'
          } 
        }
      },

      '2022' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26267#31896
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-10-29',
            DATE_END => '2022-10-30'
          } 
        }
      },

      '2023' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26592
        CITY => 'Herning',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-28',
            DATE_END => '2023-10-29'
          } 
        }
      }
    }
  },

  'Danish Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18412#21930
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-28',
            DATE_END => '2008-09-28'
          } 
        }
      },

      '2009' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18620#21679
        CITY => 'Asminderød',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2009-10-03',
            DATE_END => '2009-10-04'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-04',
            DATE_END => '2009-10-04'
          } 
        }
      },

      '2010' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=17979#21414
        CITY => 'Asminderød',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-27'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-11-28',
            DATE_END => '2010-11-28'
          } 
        }
      },

      '2011' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19007#21696
        CITY => 'Asminderød',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-24',
            DATE_END => '2011-09-24'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-25',
            DATE_END => '2011-09-25'
          } 
        }
      },

      '2012' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18970#22295
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-29'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-30',
            DATE_END => '2012-09-30'
          } 
        }
      },

      '2013' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19163#22677
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-08',
            DATE_END => '2013-09-08'
          } 
        }
      },

      '2014' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19550#20349
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-14',
            DATE_END => '2014-09-14'
          } 
        }
      },

      '2015' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=21041#24823
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2015-09-12',
            DATE_END => '2015-09-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-13',
            DATE_END => '2015-09-13'
          } 
        }
      },

      '2016' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22951#27692
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-24'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-09-25',
            DATE_END => '2016-09-25'
          } 
        }
      },

      '2017' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22386#26967
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            DATE_START => '2017-09-23',
            DATE_END => '2017-09-23'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-09-24',
            DATE_END => '2017-09-24'
          } 
        }
      },

      '2018' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22454#27125
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            DATE_START => '2018-09-15',
            DATE_END => '2018-09-15'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-09-16',
            DATE_END => '2018-09-16'
          } 
        }
      },

      '2019' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=24912
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            DATE_START => '2019-09-07',
            DATE_END => '2019-09-07'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            DATE_START => '2019-09-08',
            DATE_END => '2019-09-08'
          } 
        }
      },

      '2021' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25664
        CITY => 'Copenhagen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2021,
            STAGE => 'Semifinal',
            DATE_START => '2021-09-04',
            DATE_END => '2021-09-04'
          },
          'C1' => 
          {
            YEAR => 2021,
            STAGE => 'Final',
            DATE_START => '2021-09-05',
            DATE_END => '2021-09-05'
          } 
        }
      },

      '2022' =>
      {
        # https://pokal.bridge.dk/turnering.asp?Turn_ID=29
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            DATE_START => '2022-09-03',
            DATE_END => '2022-09-03'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            DATE_START => '2022-09-04',
            DATE_END => '2022-09-04'
          } 
        }
      },

      '2023' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26385#32068
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            DATE_START => '2023-09-09',
            DATE_END => '2023-09-09'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-09-10',
            DATE_END => '2023-09-10'
          } 
        }
      }
    }
  },

  'Danish First Division',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008-09' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18622#20859
        # https://www2.bridge.dk/Default.aspx?ID=18626#21322
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            WEEKEND => 1,
            DATE_START => '2008-11-29',
            DATE_END => '2008-11-30'
          },
          'C1' => 
          {
            YEAR => 2009,
            WEEKEND => 2,
            DATE_START => '2009-01-10',
            DATE_END => '2009-01-11'
          },
          'C2' => 
          {
            YEAR => 2009,
            WEEKEND => 3,
            DATE_START => '2009-01-31',
            DATE_END => '2009-02-01'
          },
          'C3' => 
          {
            YEAR => 2009,
            WEEKEND => 4,
            DATE_START => '2009-03-07',
            DATE_END => '2009-03-08'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2009,
            WEEKEND => 5,
            groupon => 'AUTO',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-25',
            DATE_END => '2009-04-26'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2009,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-04-26',
            DATE_END => '2009-04-26'
          }
        }
      },

      '2009-10' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18833#20831
        # https://www2.bridge.dk/Default.aspx?ID=18841#21050
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            WEEKEND => 1,
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            WEEKEND => 2,
            DATE_START => '2009-11-21',
            DATE_END => '2009-11-22'
          },
          'C2' => 
          {
            YEAR => 2010,
            WEEKEND => 3,
            DATE_START => '2010-01-09',
            DATE_END => '2010-01-10'
          },
          'C3' => 
          {
            YEAR => 2010,
            WEEKEND => 4,
            DATE_START => '2010-01-30',
            DATE_END => '2010-01-31'
          },
          'C4' => 
          {
            # Asminderød'
            YEAR => 2010,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2010-03-06',
            DATE_END => '2010-03-06'
          },
          'C5' => 
          {
            YEAR => 2010,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-03-07',
            DATE_END => '2010-03-07'
          }
        }
      },

      '2010-11' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18037#20626
        # https://www2.bridge.dk/Default.aspx?ID=18144#20907
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            WEEKEND => 1,
            DATE_START => '2010-11-13',
            DATE_END => '2010-11-14'
          },
          'C1' => 
          {
            YEAR => 2010,
            WEEKEND => 2,
            DATE_START => '2010-12-04',
            DATE_END => '2010-12-05'
          },
          'C2' => 
          {
            YEAR => 2011,
            WEEKEND => 3,
            DATE_START => '2011-01-08',
            DATE_END => '2011-01-09'
          },
          'C3' => 
          {
            YEAR => 2011,
            WEEKEND => 4,
            DATE_START => '2011-01-29',
            DATE_END => '2011-01-30'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2011,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2011-03-05',
            DATE_END => '2011-03-05'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2011,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-03-06',
            DATE_END => '2011-03-06'
          }
        }
      },

      '2011-12' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=18973
        # https://www2.bridge.dk/Default.aspx?ID=18979
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            WEEKEND => 1,
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
          },
          'C1' => 
          {
            YEAR => 2011,
            WEEKEND => 2,
            DATE_START => '2011-11-19',
            DATE_END => '2011-11-20'
          },
          'C2' => 
          {
            YEAR => 2012,
            WEEKEND => 3,
            DATE_START => '2012-01-14',
            DATE_END => '2012-01-15'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2012,
            WEEKEND => 4,
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-04'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2012,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2012-03-31',
            DATE_END => '2012-03-31'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2012,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-01',
            DATE_END => '2012-04-01'
          }
        }
      },

      '2012-13' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19174
        # https://www2.bridge.dk/Default.aspx?ID=19180#22541
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            WEEKEND => 1,
            DATE_START => '2012-10-06',
            DATE_END => '2012-10-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            WEEKEND => 2,
            major => 'ROUND|MATCH',
            minor => 'HALF',
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          },
          'C2' => 
          {
            YEAR => 2013,
            WEEKEND => 3,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2013-01-12',
            DATE_END => '2013-01-13'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2013,
            WEEKEND => 4,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2013,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            ignore => 'MATCH',
            DATE_START => '2013-04-06',
            DATE_END => '2013-04-06'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2013,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-04-07',
            DATE_END => '2013-04-07'
          }
        }
      },

      '2013-14' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19554#23408
        # https://www2.bridge.dk/Default.aspx?ID=22944#27674
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            WEEKEND => 1,
            major => 'ROUND|MATCH',
            minor => 'HALF',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
          },
          'C1' => 
          {
            YEAR => 2013,
            WEEKEND => 2,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
          },
          'C2' => 
          {
            YEAR => 2014,
            WEEKEND => 3,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2014-01-11',
            DATE_END => '2014-01-12'
          },
          'C3' => 
          {
            YEAR => 2014,
            WEEKEND => 4,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2014-03-01',
            DATE_END => '2014-03-02'
          },
          'C4' => 
          {
            # Copenhagen'
            YEAR => 2014,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-05'
          },
          'C5' => 
          {
            # Copenhagen'
            YEAR => 2014,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-06',
            DATE_END => '2014-04-06'
          }
        }
      },

      '2014-15' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19650#22936
        # https://www2.bridge.dk/Default.aspx?ID=19350#23213
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            WEEKEND => 1,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-05'
          },
          'C1' => 
          {
            YEAR => 2014,
            WEEKEND => 2,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|HALF',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          },
          'C2' => 
          {
            YEAR => 2015,
            WEEKEND => 3,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT|HALF',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-11'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2015,
            WEEKEND => 4,
            major => 'ROUND',
            minor => 'SEGMENT|HALF',
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-08'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2015,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-18'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2015,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-19',
            DATE_END => '2015-04-19'
          }
        }
      },

      '2015-16' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19344
        # https://www2.bridge.dk/Default.aspx?ID=21610
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            WEEKEND => 1,
            major => 'ROUND',
            DATE_START => '2015-09-19',
            DATE_END => '2015-09-20'
          },
          'C1' => 
          {
            # Copenhagen
            YEAR => 2015,
            WEEKEND => 2,
            major => 'ROUND',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          },
          'C2' => 
          {
            # Copenhagen
            YEAR => 2016,
            WEEKEND => 3,
            major => 'ROUND',
            DATE_START => '2016-01-16',
            DATE_END => '2016-01-17'
          },
          'C3' => 
          {
            # Århus
            YEAR => 2016,
            WEEKEND => 4,
            major => 'ROUND',
            minor => 'SEGMENT|HALF',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2016,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-04-02',
            DATE_END => '2016-04-02'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2016,
            WEEKEND => 5,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-03',
            DATE_END => '2016-04-03'
          }
        }
      },

      '2016-17' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=21974
        # https://www2.bridge.dk/Default.aspx?ID=21977
        CHAPTERS => 
        {
          'C0' => 
          {
            # Copenhagen
            YEAR => 2016,
            WEEKEND => 1,
            DATE_START => '2016-10-08',
            DATE_END => '2016-10-09'
          },
          'C1' => 
          {
            YEAR => 2016,
            WEEKEND => 2,
            DATE_START => '2016-11-19',
            DATE_END => '2016-11-20'
          },
          'C2' => 
          {
            YEAR => 2017,
            WEEKEND => 3,
            DATE_START => '2017-01-14',
            DATE_END => '2017-01-15'
          },
          'C3' => 
          {
            # Århus
            YEAR => 2017,
            WEEKEND => 4,
            DATE_START => '2017-03-04',
            DATE_END => '2017-03-05'
          },
          'C4' => 
          {
            # Århus
            YEAR => 2017,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2017-04-01',
            DATE_END => '2017-04-01'
          },
          'C5' => 
          {
            # Århus
            YEAR => 2017,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2017-04-02',
            DATE_END => '2017-04-02'
          }
        }
      },

      '2017-18' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=22347#26909
        # https://www2.bridge.dk/Default.aspx?ID=22345#26907
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            WEEKEND => 1,
            DATE_START => '2017-10-07',
            DATE_END => '2017-10-07'
          },
          'C1' => 
          {
            YEAR => 2017,
            WEEKEND => 2,
            DATE_START => '2017-11-18',
            DATE_END => '2017-11-19'
          },
          'C2' => 
          {
            YEAR => 2018,
            WEEKEND => 3,
            DATE_START => '2018-01-13',
            DATE_END => '2018-01-14'
          },
          'C3' => 
          {
            # Århus
            YEAR => 2018,
            WEEKEND => 4,
            DATE_START => '2018-03-03',
            DATE_END => '2018-03-04'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2018,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2018-04-07',
            DATE_END => '2018-04-07'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2018,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2018-04-08',
            DATE_END => '2018-04-08'
          }
        }
      },

      '2018-19' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=23432
        # https://www2.bridge.dk/Default.aspx?ID=23429
        CHAPTERS => 
        {
          'C0' => 
          {
            # Århus
            YEAR => 2018,
            WEEKEND => 1,
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          },
          'C1' => 
          {
            YEAR => 2019,
            WEEKEND => 2,
            DATE_START => '2019-01-12',
            DATE_END => '2019-01-13'
          },
          'C2' => 
          {
            YEAR => 2019,
            WEEKEND => 3,
            DATE_START => '2019-03-02',
            DATE_END => '2019-03-03'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2019,
            WEEKEND => 4,
            DATE_START => '2019-04-06',
            DATE_END => '2019-04-07'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2019,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2019-04-27',
            DATE_END => '2019-04-27'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2019,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2019-04-28',
            DATE_END => '2019-04-28'
          }
        }
      },

      '2019-20' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25236
        # https://www2.bridge.dk/Default.aspx?ID=25233
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            WEEKEND => 1,
            DATE_START => '2019-10-05',
            DATE_END => '2019-10-06'
          },
          'C1' => 
          {
            YEAR => 2019,
            WEEKEND => 2,
            DATE_START => '2019-11-16',
            DATE_END => '2019-11-17'
          },
          'C2' => 
          {
            YEAR => 2020,
            WEEKEND => 3,
            DATE_START => '2020-01-11',
            DATE_END => '2020-01-12'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2020,
            WEEKEND => 4,
            DATE_START => '2020-08-15',
            DATE_END => '2020-08-16'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2020,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2020-08-29',
            DATE_END => '2020-08-29'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2020,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2020-08-30',
            DATE_END => '2020-08-30'
          }
        }
      },

      '2021-22' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25956#31518
        # https://www2.bridge.dk/Default.aspx?ID=25955#31516
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2021,
            WEEKEND => 1,
            DATE_START => '2021-10-09',
            DATE_END => '2021-10-10'
          },
          'C1' => 
          {
            YEAR => 2021,
            WEEKEND => 2,
            DATE_START => '2021-11-13',
            DATE_END => '2021-11-13'
          },
          'C2' => 
          {
            YEAR => 2022,
            WEEKEND => 3,
            DATE_START => '2022-01-15',
            DATE_END => '2022-01-16'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2022,
            WEEKEND => 4,
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-06'
          },
          'C4' => 
          {
            # Århus
            YEAR => 2022,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2022-04-23',
            DATE_END => '2022-04-23'
          },
          'C5' => 
          {
            # Århus
            YEAR => 2022,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2022-04-24',
            DATE_END => '2022-04-24'
          }
        }
      },

      '2022-23' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26255#31871
        # https://www2.bridge.dk/Default.aspx?ID=26254#31868
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            WEEKEND => 1,
            DATE_START => '2022-10-08',
            DATE_END => '2022-10-09'
          },
          'C1' => 
          {
            YEAR => 2022,
            WEEKEND => 2,
            DATE_START => '2022-11-19',
            DATE_END => '2022-11-20'
          },
          'C2' => 
          {
            YEAR => 2023,
            WEEKEND => 3,
            DATE_START => '2023-01-14',
            DATE_END => '2023-01-15'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2023,
            WEEKEND => 4,
            DATE_START => '2023-03-04',
            DATE_END => '2023-03-05'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2023,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2023-04-15',
            DATE_END => '2023-04-15'
          },
          'C5' => 
          {
           # Copenhagen
            YEAR => 2023,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2023-04-16',
            DATE_END => '2023-04-16'
          }
        }
      },

      '2023-24' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=26580
        # https://www2.bridge.dk/Default.aspx?ID=26579
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            WEEKEND => 1,
            DATE_START => '2023-10-07',
            DATE_END => '2023-10-08'
          },
          'C1' => 
          {
            YEAR => 2023,
            WEEKEND => 2,
            DATE_START => '2023-11-18',
            DATE_END => '2023-11-19'
          },
          'C2' => 
          {
            YEAR => 2024,
            WEEKEND => 3,
            DATE_START => '2024-01-13',
            DATE_END => '2024-01-14'
          },
          'C3' => 
          {
            # Copenhagen
            YEAR => 2024,
            WEEKEND => 4,
            DATE_START => '2024-03-02',
            DATE_END => '2024-03-03'
          },
          'C4' => 
          {
            # Copenhagen
            YEAR => 2024,
            WEEKEND => 5,
            STAGE => 'Semifinal',
            DATE_START => '2024-04-13',
            DATE_END => '2024-04-13'
          },
          'C5' => 
          {
            # Copenhagen
            YEAR => 2024,
            WEEKEND => 5,
            STAGE => 'Final',
            DATE_START => '2024-04-14',
            DATE_END => '2024-04-14'
          }
        }
      }
    }
  },

  'Danish Junior Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            WEEKEND => 1,
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            WEEKEND => 2,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-03-17',
            DATE_END => '2012-03-17'
          },
          'C2' => 
          {
            YEAR => 2012,
            WEEKEND => 2,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-18',
            DATE_END => '2012-03-18'
          },
          'C3' => 
          {
            YEAR => 2012,
            WEEKEND => 3,
            DATE_START => '2012-04-14',
            DATE_END => '2012-04-15'
          } 
        }
      },

      '2013' =>
      {
        SPONSOR => 'Nordfyns Finans',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-14'
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
            DATE_START => '2014-04-12',
            DATE_END => '2014-04-13'
          } 
        }
      },

      '2018' =>
      {
        CITY => 'Vejle',
        CHAPTERS => 
        {
          # https://www2.bridge.dk/Default.aspx?ID=17866#26511
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-05',
            DATE_END => '2018-05-06'
          } 
        }
      },

      '2019' =>
      {
        CITY => 'Vejle',
        CHAPTERS => 
        {
          # https://www2.bridge.dk/Default.aspx?ID=23451#DM_Juniorhold
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-05-04',
            DATE_END => '2018-05-05'
          } 
        }
      }
    }
  },

  'Danish Mixed Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-07-09',
            DATE_END => '2011-07-10'
          } 
        }
      },

      '2012' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-07-07',
            DATE_END => '2012-07-08'
          } 
        }
      },

      '2013' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-07-06',
            DATE_END => '2013-07-07'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-07-05',
            DATE_END => '2014-07-06'
          } 
        }
      },

      '2015' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-07-04',
            DATE_END => '2015-07-05'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION|SECTION',
            DATE_START => '2016-07-09',
            DATE_END => '2016-07-10'
          } 
        }
      },

      '2017' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-07-08',
            DATE_END => '2017-07-09'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            DATE_START => '2018-07-08',
            DATE_END => '2018-07-09'
          } 
        }
      },

      # Can't find 2019

      '2022' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            DATE_START => '2022-07-09',
            DATE_END => '2022-07-10'
          } 
        }
      },

      '2023' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            DATE_START => '2023-07-14',
            DATE_END => '2023-07-15'
          } 
        }
      },

      '2024' =>
      {
        # https://resultater.bridge.dk/template/overview_club.php?mainclubno=2024&clubno=53
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            DATE_START => '2024-07-12',
            DATE_END => '2024-07-13'
          } 
        }
      }
    }
  },

  'Danish Mixed Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=19552#23106
        CITY => 'Svendborg',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'HALF',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          } 
        }
      }
    }
  },

  'Danish Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-07-11',
            DATE_END => '2009-07-12'
          } 
        }
      },

      '2010' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-07-17',
            DATE_END => '2010-07-18'
          } 
        }
      },

      '2011' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-07-16',
            DATE_END => '2011-07-17'
          } 
        }
      },

      '2012' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-07-14',
            DATE_END => '2012-07-15'
          } 
        }
      },

      '2013' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-12'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-07-13',
            DATE_END => '2013-07-14'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SECTION',
            DATE_START => '2014-07-12',
            DATE_END => '2014-07-13'
          } 
        }
      },

      '2015' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SECTION',
            DATE_START => '2015-07-11',
            DATE_END => '2015-07-12'
          } 
        }
      },

      '2016' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-16',
            DATE_END => '2016-07-17'
          } 
        }
      },

      '2017' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-15',
            DATE_END => '2017-07-16'
          } 
        }
      },

      '2018' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-14',
            DATE_END => '2018-07-15'
          } 
        }
      }
    }
  },

  'Danish Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2003' =>
      {
        MEET => 'Danish Championships',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2003,
            STAGE => 'Final',
            DATE_START => '2003-05-31',
            DATE_END => '2003-05-31'
          } 
        }
      },

      '2009' =>
      {
        MEET => 'Danish Bridge Festival',
        SPONSOR => 'XP Digital',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-08',
            DATE_END => '2009-07-08'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-09',
            DATE_END => '2009-07-09'
          } 
        }
      },

      '2010' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-14',
            DATE_END => '2010-07-14'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2010-07-15',
            DATE_END => '2010-07-15'
          } 
        }
      },

      '2011' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2011-07-13',
            DATE_END => '2011-07-13'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-14',
            DATE_END => '2011-07-14'
          } 
        }
      },

      '2012' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2012-07-11',
            DATE_END => '2012-07-11'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-07-12',
            DATE_END => '2012-07-12'
          },
        }
      },

      '2013' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-08',
            DATE_END => '2013-07-09'
          } ,
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-10',
            DATE_END => '2013-07-10'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-10',
            DATE_END => '2013-07-10'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-11',
            DATE_END => '2013-07-11'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2014-07-07',
            DATE_END => '2014-07-08'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-09',
            DATE_END => '2014-07-09'
          } 
        }
      }
    }
  },

  'Danish Open Pairs Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2010-03-27',
            DATE_END => '2010-03-28'
          },
        }
      },
    }
  },

  'Danish Open Team Trials',
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
          'C0' => 
          {
            YEAR => 2010,
            WEEKEND => 2,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-02'
          },
          'C1' => 
          {
            YEAR => 2010,
            WEEKEND => 2,
            STAGE => 'Final',
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-02'
          }
        }
      },
      '2012' =>
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-01-07',
            DATE_END => '2012-01-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND|SEGMENT',
            DATE_START => '2012-04-13',
            DATE_END => '2012-04-15'
          } 
        }
      }
    }
  },

  'Danish Women Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-07-12',
            DATE_END => '2010-07-13'
          } 
        }
      },

      '2011' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-07-11',
            DATE_END => '2011-07-12'
          } 
        }
      },

      '2014' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-12'
          } 
        }
      }
    }
  },

  'Hecht Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        SCORING => 'MP',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2004,
            major => 'SESSION',
            DATE_START => '2004-09-27',
            DATE_END => '2004-09-27'
          },
        }
      },
      '2005' =>
      {
        SCORING => 'MP',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'SESSION|SEGMENT',
            DATE_START => '2005-09-28',
            DATE_END => '2005-09-28'
          },
        }
      },
      '2006' =>
      {
        SCORING => 'IMP',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'SESSION|SEGMENT',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-11'
          },
        }
      },
      '2007' =>
      {
        SCORING => 'MP',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2007,
            DATE_START => '2007-09-20',
            DATE_END => '2007-09-20'
          },
        }
      }
    }
  },

  'Prince Henrik Trophy',
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
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2004-10-08',
            DATE_END => '2004-10-08'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2004-10-08',
            DATE_END => '2004-10-08'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS => 
        {
          # Really SEGMENT
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2005-04-01',
            DATE_END => '2005-04-01'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2005-04-01',
            DATE_END => '2005-04-01'
          },
        }
      }
    }
  },

  'Vinoble Open',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Danish Bridge Festival',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-07-08',
            DATE_END => '2015-07-08'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-07-08',
            DATE_END => '2015-07-08'
          } 
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_DENMARK, \%TOURNAMENTS_DENMARK, 'Denmark');
}

1;
