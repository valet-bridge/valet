#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Australia;

# https://www.abf.com.au/archives/#results


our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_AUSTRALIA =
(
  'Australian Autumn Nationals' =>
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2004' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=ANOT04&header=abf
        YEAR => 2004,
        CITY => 'Adelaide',
        DATE_START => '2004-05-14',
        DATE_END => '2004-05-17'
      },
      '2005' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=05ANOT&header=abf
        YEAR => 2005,
        CITY => 'Adelaide',
        DATE_START => '2005-05-12',
        DATE_END => '2005-05-16'
      },
      '2006' =>
      {
        # https://www.abf.com.au/events/anot/2006.html
        YEAR => 2006,
        CITY => 'Adelaide',
        DATE_START => '2006-05-11',
        DATE_END => '2006-05-15'
      },
      '2007' =>
      {
        # https://www.abf.com.au/events/anot/2007.html
        YEAR => 2007,
        CITY => 'Adelaide',
        DATE_START => '2007-05-10',
        DATE_END => '2007-05-14'
      },
      '2008' =>
      {
        # https://abfevents.com.au/events/anot/2008.html
        YEAR => 2008,
        CITY => 'Adelaide',
        DATE_START => '2008-05-01',
        DATE_END => '2008-05-05'
      },
      '2009' =>
      {
        # https://abfevents.com.au/events/anot/2009.html
        YEAR => 2009,
        CITY => 'Adelaide',
        DATE_START => '2009-04-30',
        DATE_END => '2009-05-04'
      },
      '2010' =>
      {
        # https://abfevents.com.au/events/anot/2010.html
        YEAR => 2010,
        CITY => 'Adelaide',
        DATE_START => '2010-04-29',
        DATE_END => '2010-05-03'
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/anot/2011.html
        YEAR => 2011,
        CITY => 'Adelaide',
        DATE_START => '2011-04-28',
        DATE_END => '2011-05-02'
      },
      '2012' =>
      {
        # https://abfevents.com.au/events/anot/2012/index.html
        YEAR => 2012,
        CITY => 'Adelaide',
        DATE_START => '2012-04-26',
        DATE_END => '2012-04-30'
      },
      '2013' =>
      {
        # https://abfevents.com.au/events/anot/2013/
        YEAR => 2013,
        CITY => 'Adelaide',
        DATE_START => '2013-05-02',
        DATE_END => '2013-05-06'
      },
      '2014' =>
      {
        # https://abfevents.com.au/events/anot/2014/
        YEAR => 2014,
        CITY => 'Adelaide',
        DATE_START => '2014-05-01',
        DATE_END => '2014-05-05'
      },
      '2015' =>
      {
        # https://abfevents.com.au/events/anot/2015/
        YEAR => 2015,
        CITY => 'Adelaide',
        DATE_START => '2015-04-30',
        DATE_END => '2015-05-04'
      },
      '2016' =>
      {
        # https://abfevents.com.au/events/anot/2016/
        YEAR => 2016,
        CITY => 'Adelaide',
        DATE_START => '2016-04-28',
        DATE_END => '2016-05-02'
      },
      '2017' =>
      {
        # https://abfevents.com.au/events/anot/2017/
        YEAR => 2017,
        CITY => 'Adelaide',
        DATE_START => '2017-05-04',
        DATE_END => '2017-05-08'
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/anot/2018/
        YEAR => 2018,
        CITY => 'Adelaide',
        DATE_START => '2018-05-03',
        DATE_END => '2018-05-07'
      },
      '2019' =>
      {
        # https://abfevents.com.au/events/anot/2019/
        YEAR => 2019,
        CITY => 'Adelaide',
        DATE_START => '2019-05-02',
        DATE_END => '2019-05-06'
      },
      '2021' =>
      {
        # https://www.myabf.com.au/events/congress/view/4
        YEAR => 2021,
        CITY => 'Adelaide',
        DATE_START => '2021-04-29',
        DATE_END => '2021-05-03'
      },
      '2022' =>
      {
        # https://www.myabf.com.au/events/congress/view/155
        YEAR => 2022,
        CITY => 'Adelaide',
        DATE_START => '2022-04-28',
        DATE_END => '2022-05-02'
      },
      '2023' =>
      {
        # https://www.myabf.com.au/events/congress/view/493
        YEAR => 2023,
        CITY => 'Adelaide',
        DATE_START => '2023-05-04',
        DATE_END => '2023-05-08'
      },
      '2024' =>
      {
        # https://www.myabf.com.au/events/congress/view/1187
        YEAR => 2024,
        CITY => 'Adelaide',
        DATE_START => '2024-05-02',
        DATE_END => '2024-05-06'
      },
    }
  }
);

my %TOURNAMENTS_AUSTRALIA =
(
  'Australian Autumn National Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-14',
            DATE_END => '2007-05-14'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-05-14',
            DATE_END => '2008-05-05'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-03',
            DATE_END => '2009-05-04'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-03'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-01',
            DATE_END => '2011-05-02'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-04-29',
            DATE_END => '2012-04-30'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-06',
            DATE_END => '2013-05-06'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-05',
            DATE_END => '2014-05-05'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-04',
            DATE_END => '2015-05-04'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Australian Autumn Nationals',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-02',
            DATE_END => '2016-05-02'
          } 
        }
      },
    }
  },

  'Australian Grand National Open Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Junior Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian National Open Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian National Senior Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian National Women Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Open Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Open Trials',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Seniors Pairs',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Seniors Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2006' =>
      {
        # https://www.abf.com.au/events/results/results.asp?yr=2006&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-04-20',
            DATE_END => '2006-04-24'
          } 
        }
      },
      '2007' =>
      {
        # https://www.abf.com.au/events/results/results.asp?yr=2007&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-04-19',
            DATE_END => '2007-04-23'
          } 
        }
      },
      '2008' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2008&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-19',
            DATE_END => '2008-04-23'
          } 
        }
      },
      '2009' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2009&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-16',
            DATE_END => '2009-04-20'
          } 
        }
      },
      '2010' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2010&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-04-07',
            DATE_END => '2010-04-11'
          } 
        }
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2011&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-04-06',
            DATE_END => '2011-04-10'
          } 
        }
      },
      '2012' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2012&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-04-18',
            DATE_END => '2012-04-22'
          } 
        }
      },
      '2013' =>
      {
        # https://abfevents.com.au/events/playoffs/2013/seniors/
        CITY => 'Redfern',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-02-13',
            DATE_END => '2013-02-17'
          } 
        }
      },
      '2014' =>
      {
        # https://abfevents.com.au/events/playoffs/2014/seniors/
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-08'
          } 
        }
      },
      '2015' =>
      {
        # https://abfevents.com.au/events/playoffs/2015/seniors/
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-13',
            DATE_END => '2015-03-17'
          } 
        }
      },
      '2016A' =>
      {
        # https://abfevents.com.au/events/playoffs/2016/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-17'
          } 
        }
      },
      '2016B' =>
      {
        # https://abfevents.com.au/events/playoffs/2017/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-12-03',
            DATE_END => '2016-12-08'
          } 
        }
      },
      '2017' =>
      {
        # https://abfevents.com.au/events/playoffs/2018/sw/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-03',
            DATE_END => '2017-12-07'
          } 
        }
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/playoffs/2019/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-12-08',
            DATE_END => '2018-12-13'
          } 
        }
      },
      '2019' =>
      {
        # https://abfevents.com.au/events/playoffs/2020/sw/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-07',
            DATE_END => '2019-12-12'
          } 
        }
      },
      '2022' =>
      {
        # https://abfevents.com.au/events/playoffs/2022/ows/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-12',
            DATE_END => '2022-03-17'
          } 
        }
      },
    }
  },

  'Australian Senior Trials',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Spring Open Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Spring Seniors Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  "Australian Spring Women's Teams",
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Trials',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  "Australian Women's Teams",
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=06PLAY&abf=yes
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-03-23',
            DATE_END => '2006-03-27'
          } 
        }
      },
      '2007' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=07PLAY&header=abf
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-03-22',
            DATE_END => '2007-03-26'
          } 
        }
      },
      '2008' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=08PLAY&header=abf
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-03-26',
            DATE_END => '2008-03-30'
          } 
        }
      },
      '2009' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=09PLAY&header=abf
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-03-21',
            DATE_END => '2009-03-26'
          } 
        }
      },
      '2010' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=10PLAY&header=abf
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-03-20',
            DATE_END => '2010-03-24'
          } 
        }
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/playoffs/2011/results/
        CITY => 'Newtown',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-31'
          } 
        }
      },
      '2012A' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2012&dir=owp
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-31',
            DATE_END => '2012-04-05'
          } 
        }
      },
      '2012B' =>
      {
        # https://abfevents.com.au/events/playoffs/2013/OW/results.asp
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-13'
          } 
        }
      },
      '2014' =>
      {
        # https://abfevents.com.au/events/playoffs/2014/ow/
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-05',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2015' =>
      {
        # https://abfevents.com.au/events/playoffs/2015/OW/
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-31',
            DATE_END => '2015-02-05'
          } 
        }
      },
      '2016A' =>
      {
        # https://abfevents.com.au/events/playoffs/2016/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-17'
          } 
        }
      },
      '2016B' =>
      {
        # https://abfevents.com.au/events/playoffs/2017/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-12-03',
            DATE_END => '2016-12-08'
          } 
        }
      },
      '2017' =>
      {
        # https://abfevents.com.au/events/playoffs/2018/sw/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-12-03',
            DATE_END => '2017-12-07'
          } 
        }
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/playoffs/2019/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-12-08',
            DATE_END => '2018-12-13'
          } 
        }
      },
      '2019' =>
      {
        # https://abfevents.com.au/events/playoffs/2020/sw/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-07',
            DATE_END => '2019-12-12'
          } 
        }
      },
      '2022' =>
      {
        # https://abfevents.com.au/events/playoffs/2022/ows/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-03-12',
            DATE_END => '2022-03-17'
          } 
        }
      },
    }
  },

  "Australian Women's Trials",
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Youth',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Youth IMP Pairs',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Youth Tri Individual',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Youth Tri Pairs',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Australian Youth Tri Teams',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
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
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },



);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_AUSTRALIA, \%TOURNAMENTS_AUSTRALIA, 'Australia');
}

1;
