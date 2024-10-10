#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Indonesia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_INDONESIA =
(
  'Indonesian National Championship Week' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2005' =>
      {
        # 
        YEAR => 2005,
        DATE_START => '2005-04-22',
        DATE_END => '2005-04-27'
      },
      '2007' =>
      {
        # 
        YEAR => 2007,
        DATE_START => '2007-05-15',
        DATE_END => '2007-05-15'
      },
      '2008' =>
      {
        # 
        YEAR => 2008,
        DATE_START => '2008-05-04',
        DATE_END => '2008-05-04'
      },
      '2009' =>
      {
        # 
        YEAR => 2009,
        DATE_START => '2009-05-29',
        DATE_END => '2009-06-05'
      },
      '2011' =>
      {
        # http://kejurnas2011.org/hasil/kejurnas/ (Wayback Machine)
        YEAR => 2011,
        DATE_START => '2011-06-05',
        DATE_END => '2011-06-12'
      },
      '2012' =>
      {
        # https://bridge.web.id/2012/kejurnas50/
        ORDINAL => 50,
        YEAR => 2012,
        CITY => 'Jakarta',
        DATE_START => '2012-04-14',
        DATE_END => '2012-04-22'
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kejurnas/
        ORDINAL => 52,
        YEAR => 2014,
        CITY => 'Manado',
        DATE_START => '2014-09-14',
        DATE_END => '2014-09-21'
      },
      '2015' =>
      {
        # https://bridge.web.id/2015/kejurnas/
        ORDINAL => 53,
        YEAR => 2015,
        CITY => 'Aceh',
        DATE_START => '2015-05-09',
        DATE_END => '2015-05-16'
      },
      '2016' =>
      {
        # https://bridge.web.id/2016/kejurnas54/
        ORDINAL => 54,
        YEAR => 2016,
        CITY => 'Lubuklinggau',
        DATE_START => '2016-05-09',
        DATE_END => '2016-05-17'
      },
      '2018' =>
      {
        # https://bridge.web.id/2018/kejurnas/
        ORDINAL => 56,
        YEAR => 2018,
        CITY => 'Padang',
        DATE_START => '2018-12-06',
        DATE_END => '2018-12-15'
      },
      '2019' =>
      {
        # https://bridge.web.id/2019/kejurnas/antar-prov/
        # https://bridge.web.id/2019/kejurnas/open/
        ORDINAL => 57,
        YEAR => 2019,
        CITY => 'Jakarta',
        DATE_START => '2019-12-05',
        DATE_END => '2019-12-14'
      },
      '2022' =>
      {
        # https://bridge.web.id/2022/kejurnas/
        ORDINAL => 58,
        YEAR => 2022,
        CITY => 'Solo',
        DATE_START => '2022-11-25',
        DATE_END => '2022-12-04'
      },
    }
  },

  'Indonesian National Games' =>
  {
    # Seems to be the National Sports Week!
    # https://en.wikipedia.org/wiki/National_Sports_Week
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2004' =>
      {
        ORDINAL => 16,
        CITY => 'Palembang',
        YEAR => 2004,
        DATE_START => '2004-09-05',
        DATE_END => '2004-09-14'
      },
      '2008' =>
      {
        ORDINAL => 17,
        CITY => 'Tarakan',
        YEAR => 2008,
        DATE_START => '2008-07-06',
        DATE_END => '2008-07-17'
      },
      '2012' =>
      {
        ORDINAL => 18,
        CITY => 'Pekanbaru',
        YEAR => 2012,
        DATE_START => '2012-09-09',
        DATE_END => '2012-09-20'
      },
      '2016' =>
      {
        ORDINAL => 19,
        CITY => 'Bandung',
        YEAR => 2016,
        DATE_START => '2016-09-17',
        DATE_END => '2016-09-29'
      },
      '2021' =>
      {
        ORDINAL => 20,
        CITY => 'Jayapura',
        YEAR => 2021,
        DATE_START => '2021-10-02',
        DATE_END => '2021-10-15'
      },
      '2024' =>
      {
        ORDINAL => 21,
        CITY => 'Banda Aceh',
        YEAR => 2024,
        DATE_START => '2024-09-09',
        DATE_END => '2024-09-20'
      },
    }
  },

  'Indonesian Student Championship' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://bridge.web.id/2012/mhs/
        ORDINAL => 9,
        CITY => 'Jakarta',
        YEAR => 2012,
        DATE_START => '2012-05-16',
        DATE_END => '2012-05-20'
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kejurnas-mhs/
        ORDINAL => 12,
        CITY => 'Surabaya',
        YEAR => 2014,
        DATE_START => '2014-12-08',
        DATE_END => '2014-12-16'
      },
    }
  },

  'Indonesian University Championship' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ZONE => 'Asia Pacific',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://bridge.web.id/2012/mhs/
        CITY => 'Jakarta',
        YEAR => 2012,
        DATE_START => '2012-05-16',
        DATE_END => '2012-05-20'
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kejurnas-mhs/
        CITY => 'Surabaya',
        YEAR => 2014,
        DATE_START => '2014-12-08',
        DATE_END => '2014-12-16'
      },
    }
  },
);

my %TOURNAMENTS_INDONESIA =
(
  'Gabrial UI Bastaman Cup' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

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
            major => 'SEGMENT',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-11-20',
            DATE_END => '2009-11-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-11-21',
            DATE_END => '2009-11-22'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-07-22',
            DATE_END => '2010-07-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-07-24',
            DATE_END => '2010-07-25'
          },
        }
      }
    }
  },

  'Geologi Cup' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    SPONSOR => 'Telkom Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-05'
          } 
        }
      },
      '2009' =>
      {
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-18'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-20'
          } 
        }
      },
      '2010' =>
      {
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-12-10',
            DATE_END => '2010-12-10'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-12-11',
            DATE_END => '2010-12-12'
          } 
        }
      },
      '2011' =>
      {
        #  https://bridge.web.id/geologi/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-18'
          } 
        }
      },
      '2012' =>
      {
        # https://bridge.web.id/geologi/2012/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-08-03',
            DATE_END => '2012-08-04'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-08-04',
            DATE_END => '2012-08-05'
          } 
        }
      },
      '2013' =>
      {
        # https://bridge.web.id/geologi/2013/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-07-26',
            DATE_END => '2013-07-27'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-07-27',
            DATE_END => '2013-07-28'
          } 
        }
      },
      '2014' =>
      {
        # https://bridge.web.id/geologi/2014/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-07-12',
            DATE_END => '2014-07-13'
          } 
        }
      },
    }
  },

  'Indonesian Inter-City Championship' =>
  {
    ORIGIN => 'Intercity',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-05-29',
            DATE_END => '2009-05-31'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-31',
            DATE_END => '2009-05-31'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-01',
            DATE_END => '2009-06-01'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-06-05',
            DATE_END => '2011-06-07'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-08'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-06-10',
            DATE_END => '2011-06-10'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-11',
            DATE_END => '2011-06-12'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-17',
            DATE_END => '2013-05-21'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-21',
            DATE_END => '2013-05-22'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-22',
            DATE_END => '2013-05-22'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-13',
            DATE_END => '2015-05-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-13',
            DATE_END => '2015-05-13'
          } 
        }
      },
    }
  },

  'Indonesian Inter-Club Championship' =>
  {
    ORIGIN => 'Interclub',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-06-01',
            DATE_END => '2009-06-02'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2009-06-02',
            DATE_END => '2009-06-03'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-06-03',
            DATE_END => '2009-06-05'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-04-25',
            DATE_END => '2010-04-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-04-25',
            DATE_END => '2010-04-26'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            DATE_START => '2010-04-26',
            DATE_END => '2010-04-26'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            DATE_START => '2010-04-26',
            DATE_END => '2010-04-27'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-27',
            DATE_END => '2010-04-27'
          },
          'C5' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-04-27',
            DATE_END => '2010-04-27'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2012-04-17',
            DATE_END => '2012-04-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-19',
            DATE_END => '2012-04-19'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-20',
            DATE_END => '2012-04-20'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-20',
            DATE_END => '2012-04-21'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2014-09-17',
            DATE_END => '2014-09-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-19'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-20',
            DATE_END => '2014-09-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-05-14',
            DATE_END => '2015-05-14'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-15',
            DATE_END => '2015-05-15'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-05-15',
            DATE_END => '2015-05-15'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-16',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-05-13',
            DATE_END => '2016-05-14'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-16',
            DATE_END => '2016-05-16'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-16',
            DATE_END => '2016-05-16'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-17',
            DATE_END => '2016-05-17'
          } 
        }
      },
    }
  },

  'Indonesian Inter-Province Championship' =>
  {
    ORIGIN => 'Interprovince',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-04-28',
            DATE_END => '2010-04-29'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-30',
            DATE_END => '2010-04-30'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-30',
            DATE_END => '2010-05-01'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-01'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-04-14',
            DATE_END => '2012-04-16'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-14',
            DATE_END => '2012-04-16'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-17',
            DATE_END => '2012-04-17'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2014-09-14',
            DATE_END => '2014-09-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-09-16',
            DATE_END => '2014-09-16'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-09-16',
            DATE_END => '2014-09-17'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-10',
            DATE_END => '2015-05-12'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-05-10',
            DATE_END => '2016-05-11'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-05-11',
            DATE_END => '2016-05-12'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-11',
            DATE_END => '2016-05-12'
          } 
        }
      },
    }
  },

  'Indonesian Invitational Teams' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-16',
            DATE_END => '2013-03-17'
          } 
        }
      },
    }
  },

  'Indonesian Junior League Online' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2015' =>
      {
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SECTION',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-18'
          }
        }
      },
    }
  },

  'Indonesian Men Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Men',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Indonesian National Games',
        ORDINAL => 16,

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-09-09',
            DATE_END => '2004-09-10'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-09-13',
            DATE_END => '2004-09-13'
          },
          'C2' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-09-14',
            DATE_END => '2004-09-14'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Indonesian National Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Bronze',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
        }
      },
    }
  },

  'Indonesian Mixed Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        # https://bridge.web.id/2016/seleknas2/
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2016-03-14',
            DATE_END => '2016-03-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2016-03-18',
            DATE_END => '2016-03-18'
          } 
        }
      },
    }
  },

  'Indonesian Mixed Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Indonesian National Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-09-05',
            DATE_END => '2004-09-05'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-09-05',
            DATE_END => '2004-09-05'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Indonesian National Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-09'
          } 
        }
      },
    }
  },

  'Indonesian Open Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
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
            SCORING => 'IMP',
            major => 'ROUND',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          } 
        }
      },
      '2016' =>
      {
        # https://bridge.web.id/2016/seleknas2/
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            SCORING => 'MP',
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2016-03-09',
            DATE_END => '2016-03-11'
          },
          'C1' => 
          {
            YEAR => 2016,
            SCORING => 'MP',
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-03-11',
            DATE_END => '2016-03-13'
          } 
        }
      },
    }
  },

  'Indonesian Open Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-04-22',
            DATE_END => '2005-04-23'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-04-27',
            DATE_END => '2005-04-27'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          }
        }
      },
      '2011' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-06-09',
            DATE_END => '2011-06-09'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-05-23',
            DATE_END => '2013-05-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-24'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-24'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-25',
            DATE_END => '2013-05-25'
          } 
        }
      },
    }
  },

  'Indonesian Open Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-07-26',
            DATE_END => '2007-07-26'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Playoff',
            DATE_START => '2007-07-27',
            DATE_END => '2007-07-27'
          } 
        }
      },
    }
  },

  'Indonesian Premier League' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-03-27',
            DATE_END => '2009-03-29'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-04-18',
            DATE_END => '2009-04-19'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-02',
            DATE_END => '2009-05-03'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-08',
            DATE_END => '2009-05-10'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-01-29',
            DATE_END => '2010-01-31'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-21'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-02-26',
            DATE_END => '2010-02-28'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-03-20',
            DATE_END => '2010-03-21'
          },
          'C4' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-09',
            DATE_END => '2010-04-11'
          },
          'C5' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-04-09',
            DATE_END => '2010-04-11'
          },
          'C6' => 
          {
            YEAR => 2010,
            DATE_START => '2010-04-16',
            DATE_END => '2010-04-18'
          },
        }
      },
    }
  },

  'Indonesian U16 Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2016' =>
      {
        # https://bridge.web.id/2016/seleknas2/
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-03-19',
            DATE_END => '2016-03-21'
          } 
        }
      },
    }
  },

  'Indonesian U18 Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U18',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indonesian Student Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-17'
          } 
        }
      },
    }
  },

  'Indonesian U21 Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-01-30',
            DATE_END => '2016-02-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2016-02-01',
            DATE_END => '2016-02-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-02-04',
            DATE_END => '2016-02-05'
          } 
        }
      },
    }
  },

  'Indonesian U21 Teams' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U21',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indonesian Student Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-18'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-18'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kejurnas-mhs/
        CITY => 'Surabaya',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-15',
            DATE_END => '2014-12-15'
          } 
        }
      },
      '2015' =>
      {
        # https://bridge.web.id/2015/kejurnas-mhs/
        CITY => 'Semarang',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-11-03',
            DATE_END => '2015-11-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-04'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-05'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-05',
            DATE_END => '2015-11-05'
          } 
        }
      },
    }
  },

  'Indonesian U26 Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-01-30',
            DATE_END => '2016-02-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2016-02-01',
            DATE_END => '2016-02-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-02-04',
            DATE_END => '2016-02-05'
          } 
        }
      },
    }
  },

  'Indonesian U26 Teams' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indonesian University Championship',
        ORDINAL => 14,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-18'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kejurnas-mhs/
        ORDINAL => 16,
        CITY => 'Surabaya',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-15',
            DATE_END => '2014-12-15'
          } 
        }
      },
      '2015' =>
      {
        # https://bridge.web.id/2015/kejurnas-mhs/
        CITY => 'Semarang',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-11-03',
            DATE_END => '2015-11-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-04'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-05'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-05',
            DATE_END => '2015-11-05'
          } 
        }
      },
    }
  },

  'Indonesian U26 Women Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-25'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2016-01-25',
            DATE_END => '2016-01-27'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-01-27',
            DATE_END => '2016-01-29'
          } 
        }
      },
    }
  },

  'Indonesian U31 Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indonesian University Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-16',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indonesian University Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-12-09',
            DATE_END => '2014-12-09'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-10'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-11'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-11'
          } 
        }
      },
    }
  },

  'Indonesian U31 Women Teams' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U31',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Indonesian University Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-05-16',
            DATE_END => '2012-05-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-17'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indonesian University Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-09',
            DATE_END => '2014-12-11'
          } 
        }
      },
    }
  },

  'Indonesian Women Pair Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-03-06',
            DATE_END => '2016-03-08'
          } 
        }
      },
    }
  },

  'Indonesian Women Teams' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Indonesian National Games',
        ORDINAL => 16,

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-09-09',
            DATE_END => '2004-09-09'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Indonesian National Games',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-10',
            DATE_END => '2015-05-10'
          } 
        }
      },
    }
  },

  'Indonesian Women Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-07-26',
            DATE_END => '2007-07-26'
          } 
        }
      },
    }
  },

  "Kepri Governor's Cup" =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2005-09-15',
            DATE_END => '2005-09-15'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-16',
            DATE_END => '2005-09-16'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-17',
            DATE_END => '2005-09-17'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          },
          'C4' => 
          {
            YEAR => 2005,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          } 
        }
      },
      '2007' =>
      {
        ORDINAL => 4,
        CHAPTERS =>
        {
          # TODO Maybe one is Governor, one isn't?
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-08-12',
            DATE_END => '2007-08-12'
          },
          'C1' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2007-08-27',
            DATE_END => '2007-08-27'
          } 
        }
      },
      '2008' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-08-28',
            DATE_END => '2008-08-28'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2008-08-28',
            DATE_END => '2008-08-28'
          } 
        }
      },
      '2009' =>
      {
        ORDINAL => 6,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-07-30',
            DATE_END => '2009-07-31'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-01',
            DATE_END => '2009-08-02'
          } 
        }
      },
      '2010' =>
      {
        ORDINAL => 7,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-11-05',
            DATE_END => '2010-11-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-06',
            DATE_END => '2010-11-07'
          } 
        }
      },
      '2011' =>
      {
        # https://bridge.web.id/2011/batam/
        ORDINAL => 8,
        CITY => 'Riau',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2011-07-21',
            DATE_END => '2011-07-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-07-23',
            DATE_END => '2011-07-24'
          } 
        }
      },
      '2012' =>
      {
        # https://bridge.web.id/2012/kepri-cup/
        ORDINAL => 9,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-11-23',
            DATE_END => '2012-11-24'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-24',
            DATE_END => '2012-11-25'
          } 
        }
      },
      '2013' =>
      {
        # https://bridge.web.id/2013/kepri-cup/
        ORDINAL => 10,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'SEGMENT',
            DATE_START => '2013-11-08',
            DATE_END => '2013-11-09'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
          } 
        }
      },
      '2014' =>
      {
        # https://bridge.web.id/2014/kepri/
        ORDINAL => 11,
        CITY => 'Batam',

        CHAPTERS =>
        {
          # TODO Maybe one is Governor, one isn't?
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-08-28',
            DATE_END => '2014-08-30'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-30',
            DATE_END => '2014-08-31'
          },
          'C2' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-09-20',
            DATE_END => '2014-09-21'
          } 
        }
      },
      '2015' =>
      {
        # https://bridge.web.id/2015/kepri/
        ORDINAL => 12,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-09-03',
            DATE_END => '2015-09-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-06'
          } 
        }
      },
      '2016' =>
      {
        ORDINAL => 13,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-08-19',
            DATE_END => '2016-08-20'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-08-20',
            DATE_END => '2016-08-21'
          } 
        }
      },
      '2017' =>
      {
        # https://bridge.web.id/2017/kepri/
        ORDINAL => 14,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-08',
            DATE_END => '2017-09-20'
          } 
        }
      },
      '2018' =>
      {
        # https://bridge.web.id/2018/kepri/
        ORDINAL => 15,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-13',
            DATE_END => '2018-07-15'
          } 
        }
      },
      '2019' =>
      {
        # https://bridge.web.id/2019/kepri/
        ORDINAL => 16,
        CITY => 'Batam',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-23',
            DATE_END => '2019-08-25'
          } 
        }
      },
    }
  },

  'PT Timah Invitational Teams' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-04',
            DATE_END => '2011-05-08'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-05-27',
            DATE_END => '2011-05-29'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-15',
            DATE_END => '2011-09-18'
          } 
        }
      },
    }
  },

  'Telkom Indonesia Open' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    SPONSOR => 'Telkom Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # https://bridge.web.id/telkom/2010/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-06-25',
            DATE_END => '2010-06-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-06-26',
            DATE_END => '2010-06-27'
          } 
        }
      },
      '2011' =>
      {
        # https://bridge.web.id/telkom/2011/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2011-07-08',
            DATE_END => '2011-07-08'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-07-09',
            DATE_END => '2011-07-10'
          } 
        }
      },
      '2012' =>
      {
        # https://bridge.web.id/telkom/2012/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-03-23',
            DATE_END => '2012-03-23'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2013' =>
      {
        # https://bridge.web.id/telkom/2013/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-04-19',
            DATE_END => '2013-04-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-04-20',
            DATE_END => '2013-04-21'
          } 
        }
      },
      '2014' =>
      {
        # https://bridge.web.id/telkom/2014/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-05-31'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-05-31',
            DATE_END => '2014-06-01'
          } 
        }
      },
      '2015' =>
      {
        # https://bridge.web.id/telkom/2015/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-11-27',
            DATE_END => '2015-11-28'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-11-28',
            DATE_END => '2015-11-29'
          } 
        }
      },
      '2016' =>
      {
        # https://bridge.web.id/telkom/2016/
        CITY => 'Bandung',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-12-02',
            DATE_END => '2016-12-04'
          } 
        }
      },
      '2017' =>
      {
        # https://bridge.web.id/telkom/2017/
        CITY => 'Bandung',
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
        # https://bridge.web.id/telkom/2018/
        CITY => 'Jakarta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-15',
            DATE_END => '2018-11-17'
          } 
        }
      },
      '2019' =>
      {
        # https://bridge.web.id/telkom/2019/
        CITY => 'Jakarta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-15',
            DATE_END => '2019-11-17'
          } 
        }
      },
      '2022' =>
      {
        # https://bridge.web.id/telkom/2022/
        CITY => 'Jakarta',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-10-28',
            DATE_END => '2022-10-30'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_INDONESIA, \%TOURNAMENTS_INDONESIA, 'Indonesia');
}

1;