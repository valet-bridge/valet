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
      '2009' =>
      {
        # 
        YEAR => 2009,
        DATE_START => '2009-05-29',
        DATE_END => '2009-06-05'
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
  }
);

my %TOURNAMENTS_INDONESIA =
(
  'Indonesian Championship' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-29'
          } 
        }
      },
    }
  },

  'Indonesian Inter-City Championship' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
      '2009' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-01',
            DATE_END => '2009-06-05'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-17',
            DATE_END => '2014-09-20'
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
            DATE_START => '2015-05-13',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-13',
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
      '2014' =>
      {
        MEET => 'Indonesian National Championship Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-14',
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
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-10',
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
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
            DATE_START => '2016-03-19',
            DATE_END => '2016-03-21'
          } 
        }
      },
    }
  },

  'Indonesian League' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
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
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-14',
            DATE_END => '2016-03-18'
          } 
        }
      },
    }
  },

  'Indonesian Mixed Team Trials' =>
  {
    ORGANIZATION => 'GABSI',
    COUNTRY => 'Indonesia',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            DATE_START => '2000-03-14',
            DATE_END => '2000-03-18'
          } 
        }
      },
    }
  },

  'Indonesian National Games' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

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
            DATE_START => '2016-03-09',
            DATE_END => '2016-03-13'
          } 
        }
      },
    }
  },

  'Indonesian Open Teams' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Indonesian Student Championship' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-30',
            DATE_END => '2016-02-05'
          } 
        }
      },
    }
  },

  'Indonesian U21 Trials' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-30',
            DATE_END => '2016-02-05'
          } 
        }
      },
    }
  },

  'Indonesian U26 Trials' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Indonesian University Championship' =>
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
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
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
            DATE_START => '2016-03-06',
            DATE_END => '2016-03-08'
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
      '2000' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-03-06',
            DATE_END => '2000-03-08'
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
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-09-16',
            DATE_END => '2005-09-18'
          } 
        }
      },
      '2008' =>
      {
        ORDINAL => 5,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-07-30',
            DATE_END => '2009-08-02'
          } 
        }
      },
      '2010' =>
      {
        ORDINAL => 7,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-11-05',
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
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-22',
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
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-11-23',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-08',
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
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-29',
            DATE_END => '2014-08-31'
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
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-03',
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
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-19',
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

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_INDONESIA, \%TOURNAMENTS_INDONESIA, 'Indonesia');
}

1;
