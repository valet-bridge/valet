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
  'Australian ANC Championships' =>
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2011' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2011&dir=anc
        YEAR => 2011,
        CITY => 'Melbourne',
        DATE_START => '2011-07-24',
        DATE_END => '2011-07-29'
      },
      '2012' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=12ANCD&header=abf
        YEAR => 2012,
        CITY => 'Darwin',
        DATE_START => '2012-07-14',
        DATE_END => '2012-07-19'
      },
      '2013' =>
      {
        # http://abfevents.com.au/events/anc/2013/
        YEAR => 2013,
        CITY => 'Adelaide',
        DATE_START => '2013-07-06',
        DATE_END => '2013-07-18'
      },
      '2014' =>
      {
        # https://abfevents.com.au/events/anc/2014/
        YEAR => 2014,
        CITY => 'Sydney',
        DATE_START => '2014-07-12',
        DATE_END => '2014-07-24'
      },
      '2015' =>
      {
        # http://abfevents.com.au/events/anc/2016/
        YEAR => 2015,
        CITY => 'Fremantle',
        DATE_START => '2015-07-11',
        DATE_END => '2015-07-23'
      },
      '2016' =>
      {
        # http://abfevents.com.au/events/anc/2016/
        YEAR => 2016,
        CITY => 'Brisbane',
        DATE_START => '2016-06-25',
        DATE_END => '2016-07-07'
      },
      '2017' =>
      {
        # http://abfevents.com.au/events/anc/2017/
        YEAR => 2017,
        CITY => 'Canberra',
        DATE_START => '2017-07-15',
        DATE_END => '2017-08-27'
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/anc/2018/
        YEAR => 2018,
        CITY => 'Hobart',
        DATE_START => '2018-07-28',
        DATE_END => '2018-08-09'
      },
      '2019' =>
      {
        # http://abfevents.com.au/events/anc/2019/
        YEAR => 2019,
        CITY => 'Melbourne',
        DATE_START => '2019-07-13',
        DATE_END => '2019-07-25'
      },
      '2022' =>
      {
        # https://abfevents.com.au/events/anc/2022/
        YEAR => 2022,
        CITY => 'Adelaide',
        DATE_START => '2022-07-02',
        DATE_END => '2022-07-14'
      },
      '2023' =>
      {
        # https://www.myabf.com.au/events/congress/view/472
        YEAR => 2023,
        CITY => 'Perth',
        DATE_START => '2023-07-09',
        DATE_END => '2023-07-20'
      },
      '2024' =>
      {
        # https://www.myabf.com.au/events/congress/view/798
        YEAR => 2024,
        CITY => 'Orange',
        DATE_START => '2024-07-06',
        DATE_END => '2024-07-18'
      },
    }
  },

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
  },

  'Australian Spring Nationals' =>
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2004' =>
      {
        # https://abfevents.com.au/events/spnot/2004/results.asp
        YEAR => 2004,
        CITY => 'Sydney',
        DATE_START => '2004-11-11',
        DATE_END => '2004-11-18'
      },
      '2006' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2006&dir=sn
        YEAR => 2006,
        CITY => 'Sydney',
        DATE_START => '2006-10-18',
        DATE_END => '2006-10-26'
      },
      '2007' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2007&dir=sn
        YEAR => 2007,
        CITY => 'Sydney',
        DATE_START => '2007-10-24',
        DATE_END => '2007-11-01'
      },
      '2008' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2008&dir=sn
        YEAR => 2008,
        CITY => 'Sydney',
        DATE_START => '2008-10-22',
        DATE_END => '2008-10-30'
      },
      '2009' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2009&dir=sn
        YEAR => 2009,
        CITY => 'Sydney',
        DATE_START => '2009-10-21',
        DATE_END => '2009-10-29'
      },
      '2010' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2010&dir=sn
        YEAR => 2010,
        CITY => 'Sydney',
        DATE_START => '2010-10-20',
        DATE_END => '2010-10-28'
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2011&dir=sn
        YEAR => 2011,
        CITY => 'Sydney',
        DATE_START => '2011-10-19',
        DATE_END => '2011-10-27'
      },
      '2012' =>
      {
        # http://abfevents.com.au/events/results/results.asp?yr=2012&dir=sn
        YEAR => 2012,
        CITY => 'Sydney',
        DATE_START => '2012-10-24',
        DATE_END => '2012-11-01'
      },
      '2013' =>
      {
        # http://abfevents.com.au/events/spnot/2013/
        YEAR => 2013,
        CITY => 'Sydney',
        DATE_START => '2013-10-23',
        DATE_END => '2013-10-31'
      },
      '2014' =>
      {
        # http://abfevents.com.au/events/spnot/2014/
        YEAR => 2014,
        CITY => 'Sydney',
        DATE_START => '2014-10-29',
        DATE_END => '2014-11-06'
      },
      '2015' =>
      {
        # http://abfevents.com.au/events/spnot/2015/
        YEAR => 2015,
        CITY => 'Sydney',
        DATE_START => '2015-10-21',
        DATE_END => '2015-10-29'
      },
      '2016' =>
      {
        # http://abfevents.com.au/events/spnot/2016/
        YEAR => 2016,
        CITY => 'Sydney',
        DATE_START => '2016-10-19',
        DATE_END => '2016-10-27'
      },
      '2017' =>
      {
        # http://abfevents.com.au/events/spnot/2017/
        YEAR => 2017,
        CITY => 'Sydney',
        DATE_START => '2017-10-18',
        DATE_END => '2017-10-26'
      },
      '2018' =>
      {
        # http://abfevents.com.au/events/spnot/2018/
        YEAR => 2018,
        CITY => 'Sydney',
        DATE_START => '2018-10-17',
        DATE_END => '2018-10-25'
      },
      '2019' =>
      {
        # http://abfevents.com.au/events/spnot/2019/
        YEAR => 2019,
        CITY => 'Sydney',
        DATE_START => '2019-10-16',
        DATE_END => '2019-10-24'
      },
      '2021' =>
      {
        # https://www.myabf.com.au/events/congress/view/82
        YEAR => 2021,
        CITY => 'Online',
        DATE_START => '2021-10-14',
        DATE_END => '2021-10-24'
      },
      '2022' =>
      {
        # https://www.myabf.com.au/events/congress/view/39
        YEAR => 2022,
        CITY => 'Sydney',
        DATE_START => '2022-10-19',
        DATE_END => '2022-10-28'
      },
      '2023' =>
      {
        # https://www.myabf.com.au/events/congress/view/638
        YEAR => 2023,
        CITY => 'Sydney',
        DATE_START => '2023-10-18',
        DATE_END => '2023-10-25'
      },
      '2024' =>
      {
        # https://www.myabf.com.au/events/congress/view/967
        YEAR => 2024,
        CITY => 'Sydney',
        DATE_START => '2024-10-19',
        DATE_END => '2024-10-27'
      },
    }
  },

  'Australian Summer Festival' =>
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2005' =>
      {
        # https://abfevents.com.au/events/not/2005/index.html
        YEAR => 2005,
        CITY => 'Canberra',
        DATE_START => '2005-01-11',
        DATE_END => '2005-01-24'
      },
      '2006' =>
      {
        # https://abfevents.com.au/events/not/2006/index.html
        YEAR => 2006,
        CITY => 'Canberra',
        DATE_START => '2006-01-18',
        DATE_END => '2006-01-30'
      },
      '2007' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=07SUMF&header=abf
        YEAR => 2007,
        CITY => 'Canberra',
        DATE_START => '2007-01-15',
        DATE_END => '2007-01-29'
      },
      '2008' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=08SUMF&header=abf
        YEAR => 2008,
        CITY => 'Canberra',
        DATE_START => '2008-01-14',
        DATE_END => '2008-01-28'
      },
      '2009' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=10SUMF&header=abf
        YEAR => 2009,
        CITY => 'Canberra',
        DATE_START => '2009-01-12',
        DATE_END => '2009-01-26'
      },
      '2010' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=10SUMF&header=abf
        YEAR => 2010,
        CITY => 'Canberra',
        DATE_START => '2010-01-11',
        DATE_END => '2010-01-25'
      },
      '2011' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=11sumf&header=abf
        YEAR => 2011,
        CITY => 'Canberra',
        DATE_START => '2011-01-17',
        DATE_END => '2011-01-31'
      },
      '2012' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=12sumf&header=abf
        YEAR => 2012,
        CITY => 'Canberra',
        DATE_START => '2012-01-16',
        DATE_END => '2012-01-29'
      },
      '2013' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=13sumf&header=abf
        YEAR => 2013,
        CITY => 'Canberra',
        DATE_START => '2013-01-15',
        DATE_END => '2013-01-27'
      },
      '2014' =>
      {
        # No link.
        YEAR => 2014,
        CITY => 'Canberra',
        DATE_START => '2014-01-14',
        DATE_END => '2014-01-26'
      },
      '2015' =>
      {
        # No link.
        YEAR => 2015,
        CITY => 'Canberra',
        DATE_START => '2015-01-13',
        DATE_END => '2015-01-25'
      },
      '2016' =>
      {
        # No link.
        YEAR => 2016,
        CITY => 'Canberra',
        DATE_START => '2016-01-12',
        DATE_END => '2016-01-24'
      },
      '2017' =>
      {
        # https://abfevents.com.au/events/not/2017/index.asp
        YEAR => 2017,
        CITY => 'Canberra',
        DATE_START => '2017-01-10',
        DATE_END => '2017-01-22'
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/not/2018/
        YEAR => 2018,
        CITY => 'Canberra',
        DATE_START => '2018-01-10',
        DATE_END => '2018-01-21'
      },
      '2019' =>
      {
        # https://abfevents.com.au/events/not/2019/
        YEAR => 2019,
        CITY => 'Canberra',
        DATE_START => '2019-01-09',
        DATE_END => '2019-01-20'
      },
      '2020' =>
      {
        # https://abfevents.com.au/events/not/2020/
        YEAR => 2020,
        CITY => 'Canberra',
        DATE_START => '2020-01-08',
        DATE_END => '2020-01-19'
      },
      '2022' =>
      {
        # https://www.myabf.com.au/events/congress/view/122
        YEAR => 2022,
        CITY => 'Online',
        DATE_START => '2022-01-13',
        DATE_END => '2022-01-23'
      },
      '2023' =>
      {
        # https://www.myabf.com.au/events/congress/view/343
        YEAR => 2024,
        CITY => 'Canberra',
        DATE_START => '2024-01-10',
        DATE_END => '2024-01-22'
      },
      '2024' =>
      {
        # https://www.myabf.com.au/events/congress/view/790
        YEAR => 2024,
        CITY => 'Canberra',
        DATE_START => '2024-01-09',
        DATE_END => '2024-01-21'
      },
    }
  },

  'Australian Youth Week' =>
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',

    EDITIONS => 
    {
      '2006' =>
      {
        # https://abfevents.com.au/youth/events/ayc/2007/results.asp
        YEAR => 2006,
        CITY => 'Canberra',
        DATE_START => '2006-01-14',
        DATE_END => '2006-01-22'
      },
      '2007' =>
      {
        # https://abfevents.com.au/youth/events/ayc/2007/results.asp
        YEAR => 2007,
        CITY => 'Canberra',
        DATE_START => '2007-01-13',
        DATE_END => '2007-01-20'
      },
      '2008' =>
      {
        # https://abfevents.com.au/youth/events/ayc/2008/results.asp
        YEAR => 2008,
        CITY => 'Canberra',
        DATE_START => '2008-01-12',
        DATE_END => '2008-01-19'
      },
      '2009' =>
      {
        # https://abfevents.com.au/youth/events/ayc/2009/results.asp
        YEAR => 2009,
        CITY => 'Canberra',
        DATE_START => '2009-01-10',
        DATE_END => '2009-01-17'
      },
      '2010' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2010&dir=ayc
        YEAR => 2010,
        CITY => 'Canberra',
        DATE_START => '2010-01-09',
        DATE_END => '2010-01-16'
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2011&dir=ayc
        YEAR => 2011,
        CITY => 'Canberra',
        DATE_START => '2011-01-15',
        DATE_END => '2011-01-23'
      },
      '2012' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2012&dir=ayc
        YEAR => 2012,
        CITY => 'Canberra',
        DATE_START => '2012-01-14',
        DATE_END => '2012-01-22'
      },
      '2013' =>
      {
        # https://abfevents.com.au/youth/events/ayc/2013/
        YEAR => 2013,
        CITY => 'Canberra',
        DATE_START => '2013-01-12',
        DATE_END => '2013-01-20'
      },
      '2014' =>
      {
        # https://abfevents.com.au/events/ayc/2014/
        YEAR => 2014,
        CITY => 'Canberra',
        DATE_START => '2014-01-11',
        DATE_END => '2014-01-19'
      },
      '2015' =>
      {
        # https://abfevents.com.au/events/ayc/2015/
        YEAR => 2015,
        CITY => 'Canberra',
        DATE_START => '2015-01-10',
        DATE_END => '2015-01-17'
      },
      '2016' =>
      {
        # https://abfevents.com.au/events/ayc/2016/
        YEAR => 2016,
        CITY => 'Canberra',
        DATE_START => '2016-01-09',
        DATE_END => '2016-01-15'
      },
      '2017' =>
      {
        # https://abfevents.com.au/events/ayc/2017/
        YEAR => 2017,
        CITY => 'Canberra',
        DATE_START => '2017-01-07',
        DATE_END => '2017-01-13'
      },
      '2018' =>
      {
        # https://abfevents.com.au/events/ayc/2018/
        YEAR => 2018,
        CITY => 'Canberra',
        DATE_START => '2018-01-06',
        DATE_END => '2018-01-12'
      },
      '2019' =>
      {
        # https://abfevents.com.au/events/ayc/2019/
        YEAR => 2019,
        CITY => 'Canberra',
        DATE_START => '2019-01-05',
        DATE_END => '2019-01-11'
      },
      '2020' =>
      {
        # https://abfevents.com.au/events/ayc/2020/
        YEAR => 2020,
        CITY => 'Canberra',
        DATE_START => '2020-01-04',
        DATE_END => '2020-01-10'
      },
      '2023' =>
      {
        # https://www.myabf.com.au/events/congress/view/479
        YEAR => 2023,
        CITY => 'Canberra',
        DATE_START => '2023-01-07',
        DATE_END => '2023-01-13'
      },
      '2024' =>
      {
        # https://abfevents.com.au/events/ayc/2024/
        YEAR => 2024,
        CITY => 'Canberra',
        DATE_START => '2024-01-06',
        DATE_END => '2024-01-12'
      },
    }
  },
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
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2007-05-14',
            DATE_END => '2007-05-14'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
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
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-05-05',
            DATE_END => '2008-05-05'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-05',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
      '2006' =>
      {
        # https://abfevents.com.au/events/gnot/2006/index.html
        CITY => 'Banora Point',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-11-17',
            DATE_END => '2006-11-20'
          } 
        }
      },
      '2007' =>
      {
        # https://abfevents.com.au/events/gnot/2007/index.html
        CITY => 'Banora Point',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-11-30',
            DATE_END => '2007-12-01'
          } 
        }
      },
      '2008' =>
      {
        # https://abfevents.com.au/events/gnot/2008/index.html
        CITY => 'Banora Point',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-11-28',
            DATE_END => '2008-12-01'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-28',
            DATE_END => '2008-12-01'
          } 
        }
      },
      '2009' =>
      {
        # https://abfevents.com.au/events/gnot/2009/results.htm
        CITY => 'Banora Point',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-11-27',
            DATE_END => '2009-11-30'
          } 
        }
      },
      '2010' =>
      {
        # https://abfevents.com.au/events/gnot/2010/results.htm
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-28',
            DATE_END => '2010-11-29'
          },
        }
      },
      '2011' =>
      {
        # https://abfevents.com.au/events/gnot/2011/results.htm
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-11-25',
            DATE_END => '2011-11-28'
          } 
        }
      },
      '2012' =>
      {
        # http://abfevents.com.au/events/gnot/2012/results.html
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-11-30',
            DATE_END => '2012-12-03'
          } 
        }
      },
      '2013' =>
      {
        # http://abfevents.com.au/events/gnot/2013/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-29',
            DATE_END => '2013-12-04'
          } 
        }
      },
      '2014' =>
      {
        # http://abfevents.com.au/events/gnot/2014/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-28',
            DATE_END => '2014-12-01'
          } 
        }
      },
      '2015' =>
      {
        # http://abfevents.com.au/events/gnot/2015/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-27',
            DATE_END => '2015-11-30'
          } 
        }
      },
      '2016' =>
      {
        # http://abfevents.com.au/events/gnot/2016/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-25',
            DATE_END => '2016-11-28'
          } 
        }
      },
      '2017' =>
      {
        # http://abfevents.com.au/events/gnot/2017/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-24',
            DATE_END => '2017-11-27'
          } 
        }
      },
      '2018' =>
      {
        # http://abfevents.com.au/events/gnot/2018/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-30',
            DATE_END => '2018-12-03'
          } 
        }
      },
      '2019' =>
      {
        # http://abfevents.com.au/events/gnot/2019/
        CITY => 'Tweed Heads',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-29',
            DATE_END => '2019-12-02'
          } 
        }
      },
      '2021' =>
      {
        # http://abfevents.com.au/events/gnot/2021/
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-11-26',
            DATE_END => '2021-11-28'
          } 
        }
      },
      '2022' =>
      {
        # https://abfevents.com.au/events/gnot/2022/
        CITY => 'Brisbane',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-11-25',
            DATE_END => '2022-11-28'
          } 
        }
      },
      '2023' =>
      {
        # https://abfevents.com.au/events/gnot/2023/
        CITY => 'Brisbane',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-12-01',
            DATE_END => '2023-12-04'
          } 
        }
      },
      '2024' =>
      {
        # https://abfevents.com.au/events/gnot/2024/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-23',
            DATE_END => '2024-11-24'
          } 
        }
      },
    }
  },

  'Australian Junior Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Australian ANC Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-28'
          } 
        }
      },
    }
  },

  'Australian National Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2005-01-22',
            DATE_END => '2005-01-22'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-01-23',
            DATE_END => '2005-01-23'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-01-23',
            DATE_END => '2005-01-23'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-01-25',
            DATE_END => '2005-01-25'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'SEGMENT',
            DATE_START => '2006-01-28',
            DATE_END => '2006-01-30'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-01-28',
            DATE_END => '2006-01-30'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-01-28',
            DATE_END => '2006-01-30'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Rof16',
            DATE_START => '2007-01-28',
            DATE_END => '2007-01-29'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-01-28',
            DATE_END => '2007-01-29'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-01-28',
            DATE_END => '2007-01-29'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-01-28',
            DATE_END => '2007-01-29'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2008-01-25',
            DATE_END => '2008-01-25'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-01-27',
            DATE_END => '2008-01-27'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-01-27',
            DATE_END => '2008-01-27'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-28',
            DATE_END => '2008-01-28'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof12',
            major => 'SEGMENT',
            DATE_START => '2010-01-22',
            DATE_END => '2010-01-22'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-22',
            DATE_END => '2010-01-23'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-23',
            DATE_END => '2010-01-24'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-24',
            DATE_END => '2010-01-25'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof20',
            major => 'SEGMENT',
            DATE_START => '2011-01-28',
            DATE_END => '2011-01-28'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2011-01-28',
            DATE_END => '2011-01-29'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-01-29',
            DATE_END => '2011-01-30'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-30',
            DATE_END => '2011-01-31'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-26',
            DATE_END => '2012-01-27'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-01-27',
            DATE_END => '2012-01-28'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-28',
            DATE_END => '2012-01-29'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-25',
            DATE_END => '2013-01-25'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-26'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-27',
            DATE_END => '2013-01-27'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-24',
            DATE_END => '2014-01-24'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-25'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-26',
            DATE_END => '2014-01-26'
          }
        }
      },
      '2015' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-23'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-24'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-25',
            DATE_END => '2015-01-25'
          }
        }
      },
      '2016' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-22',
            DATE_END => '2016-01-22'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-23'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-24',
            DATE_END => '2016-01-24'
          },
        }
      },
    }
  },

  'Australian National Senior Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-20',
            DATE_END => '2008-01-25'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-01-13',
            DATE_END => '2010-01-15'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-15',
            DATE_END => '2010-01-16'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-01-22',
            DATE_END => '2011-01-23'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-20',
            DATE_END => '2012-01-22'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-20',
            DATE_END => '2013-01-20'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-17',
            DATE_END => '2015-01-17'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-18',
            DATE_END => '2015-01-18'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-16',
            DATE_END => '2016-01-16'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-16',
            DATE_END => '2016-01-17'
          } 
        }
      },
    }
  },

  'Australian National Women Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-20',
            DATE_END => '2008-01-20'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-16'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-01-22',
            DATE_END => '2011-01-23'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-22'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-20',
            DATE_END => '2013-01-20'
          }
        }
      },
      '2014' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-17',
            DATE_END => '2015-01-17'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-17',
            DATE_END => '2015-01-18'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Australian Summer Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-16',
            DATE_END => '2016-01-16'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-17',
            DATE_END => '2016-01-17'
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
      '2005' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=05PLAY&abf=yes
        CITY => 'Sydney',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-03-21',
            DATE_END => '2005-03-21'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-03-21',
            DATE_END => '2005-03-21'
          } 
        }
      },
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
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-03-22',
            DATE_END => '2007-03-26'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
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
            major => 'ROUND',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-23',
            DATE_END => '2009-03-24'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-24',
            DATE_END => '2009-03-24'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-20',
            DATE_END => '2010-03-24'
          } 
        }
      },
      '2011A' =>
      {
        # https://abfevents.com.au/events/playoffs/2011/results/
        CITY => 'Sydney',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Repechage',
            major => 'ROUND',
            DATE_START => '2011-03-27',
            DATE_END => '2011-03-28'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-28',
            DATE_END => '2011-03-29'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-29',
            DATE_END => '2011-03-30'
          },
        }
      },
      '2011B' =>
      {
        MEET => 'Australian ANC Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-28'
          } 
        }
      },
      '2012A' =>
      {
        # http://abfevents.com.au/events/results/results.asp?yr=2012&dir=owp
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-02',
            DATE_END => '2012-04-03'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-03',
            DATE_END => '2012-04-05'
          } 
        }
      },
      '2012B' =>
      {
        # http://abfevents.com.au/events/playoffs/2013/OW/results.asp
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-11',
            DATE_END => '2012-12-11'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-12',
            DATE_END => '2012-12-13'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Australian ANC Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-12',
            DATE_END => '2013-07-12'
          } 
        }
      },
      '2014' =>
      {
        # http://abfevents.com.au/events/playoffs/2014/ow/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-02-05',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2015' =>
      {
        # http://abfevents.com.au/events/playoffs/2015/OW/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-03',
            DATE_END => '2015-02-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-04',
            DATE_END => '2015-02-05'
          } 
        }
      },
      '2016A' =>
      {
        # http://abfevents.com.au/events/playoffs/2016/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-02-09',
            DATE_END => '2016-02-09'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-02-10',
            DATE_END => '2016-02-11'
          } 
        }
      },
      '2016B' =>
      {
        # http://abfevents.com.au/events/playoffs/2017/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-12',
            DATE_END => '2016-11-17'
          } 
        }
      },
      '2017' =>
      {
        # http://abfevents.com.au/events/playoffs/2018/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-12',
            DATE_END => '2017-11-16'
          } 
        }
      },
      '2018' =>
      {
        # http://abfevents.com.au/events/playoffs/2019/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-10',
            DATE_END => '2018-11-15'
          } 
        }
      },
      '2019' =>
      {
        # http://abfevents.com.au/events/playoffs/2020/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-09',
            DATE_END => '2019-11-14'
          } 
        }
      },
      '2022A' =>
      {
        # http://abfevents.com.au/events/playoffs/2022/ows/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-04-18',
            DATE_END => '2022-04-23'
          } 
        }
      },
      '2022B' =>
      {
        # https://abfevents.com.au/events/playoffs/2023/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-11-12',
            DATE_END => '2022-11-17'
          } 
        }
      },
      '2023' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2024&dir=opo
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-11-11',
            DATE_END => '2023-11-16'
          } 
        }
      },
      '2024' =>
      {
        # https://abfevents.com.au/events/playoffs/2025/open/
        CITY => 'Canberra',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-16',
            DATE_END => '2024-11-21'
          } 
        }
      },
    }
  },

  'Australian Senior Pairs',
  {
    ORGANIZATION => 'AuBF',
    COUNTRY => 'Australia',
    ORIGIN => 'National',
    ZONE => 'South Pacific',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2010' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2010&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-04-07',
            DATE_END => '2010-04-11'
          } 
        }
      },
      '2014' =>
      {
        # http://abfevents.com.au/events/playoffs/2014/seniors/
        CITY => 'Coogee',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-04-07',
            DATE_END => '2014-04-08'
          } 
        }
      },
    }
  },

  'Australian Senior Teams',
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
      '2006' =>
      {
        # http://www.abf.com.au/events/results/results.asp?yr=2006&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'STAGE',
            minor => 'ROUND',
            DATE_START => '2006-04-20',
            DATE_END => '2006-04-24'
          } 
        }
      },
      '2007' =>
      {
        # http://www.abf.com.au/events/results/results.asp?yr=2007&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2007-04-22',
            DATE_END => '2007-04-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-19',
            DATE_END => '2007-04-23'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
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
            DATE_START => '2008-04-09',
            DATE_END => '2008-04-13'
          } 
        }
      },
      '2009' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2009&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-18',
            DATE_END => '2009-04-19'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-04-19',
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
      '2011A' =>
      {
        # https://abfevents.com.au/events/results/results.asp?yr=2011&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-04-07',
            DATE_END => '2011-04-08'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-08',
            DATE_END => '2011-04-09'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-09',
            DATE_END => '2011-04-10'
          },
        }
      },
      '2011B' =>
      {
        MEET => 'Australian ANC Championships',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-28',
            DATE_END => '2011-07-29'
          } 
        }
      },
      '2012' =>
      {
        # http://abfevents.com.au/events/results/results.asp?yr=2012&dir=spo
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2012-04-18',
            DATE_END => '2012-04-20'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-20',
            DATE_END => '2012-04-22'
          } 
        }
      },
      '2013' =>
      {
        # http://abfevents.com.au/events/playoffs/2013/seniors/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-13',
            DATE_END => '2013-02-17'
          } 
        }
      },
      '2014' =>
      {
        # http://abfevents.com.au/events/playoffs/2014/seniors/
        CITY => 'Canberra',

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
        # http://abfevents.com.au/events/playoffs/2015/seniors/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-13',
            DATE_END => '2015-03-18'
          } 
        }
      },
      '2016A' =>
      {
        # http://abfevents.com.au/events/playoffs/2016/SW/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-17'
          } 
        }
      },
      '2016B' =>
      {
        # http://abfevents.com.au/events/playoffs/2017/SW/
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
        # http://abfevents.com.au/events/playoffs/2018/sw/
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
        # http://abfevents.com.au/events/playoffs/2019/SW/
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
        # http://abfevents.com.au/events/playoffs/2020/sw/
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
        # http://abfevents.com.au/events/playoffs/2022/ows/
        CITY => 'Canberra',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-04-18',
            DATE_END => '2022-04-23'
          } 
        }
      },
    }
  },

  'Australian Spring Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-18',
            DATE_END => '2004-11-18'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-24',
            DATE_END => '2009-10-25'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-23',
            DATE_END => '2010-10-28'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-24',
            DATE_END => '2015-10-24'
          },
          'C1' => 
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

  'Australian Spring Senior Teams',
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
      '2008' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-30',
            DATE_END => '2008-10-30'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-29',
            DATE_END => '2009-10-29'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-27',
            DATE_END => '2010-10-28'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-26',
            DATE_END => '2011-10-26'
          } 
        }
      },
    }
  },

  "Australian Spring Women Teams",
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
      '2008' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-10-30',
            DATE_END => '2008-10-30'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-28',
            DATE_END => '2010-10-28'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Spring Nationals',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-26',
            DATE_END => '2011-10-26'
          } 
        }
      },
    }
  },

  "Australian Women Teams",
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
      '2005' =>
      {
        # http://www.bridgeunlimited.com/bridge/ViewMasterEvent2?code=05PLAY&abf=yes
        CITY => 'Sydney',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-03-20',
            DATE_END => '2005-03-21'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Tiebreak',
            major => 'SEGMENT',
            DATE_START => '2005-03-20',
            DATE_END => '2005-03-21'
          } 
        }
      },
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
            major => 'ROUND',
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
            major => 'ROUND',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-21',
            DATE_END => '2009-03-26'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
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
            major => 'ROUND',
            DATE_START => '2010-03-20',
            DATE_END => '2010-03-24'
          } 
        }
      },
      '2011A' =>
      {
        # https://abfevents.com.au/events/playoffs/2011/results/
        CITY => 'Newtown',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-28',
            DATE_END => '2011-03-29'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Australian ANC Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-07-29',
            DATE_END => '2011-07-29'
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
            STAGE => 'Final',
            major => 'SEGMENT',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-11',
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
            major => 'SESSION',
            minor => 'ROUND',
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
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-03',
            DATE_END => '2015-02-03'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-04',
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
            STAGE => 'Final',
            major => 'SEGMENT',
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

  'Australian Youth IMP Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-01-18',
            DATE_END => '2011-01-20'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-01-13',
            DATE_END => '2015-01-16'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-01-16',
            DATE_END => '2015-01-17'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-01-15',
            DATE_END => '2016-01-15'
          } 
        }
      },
    }
  },

  'Australian Youth Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2008' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-01-21',
            DATE_END => '2008-01-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-22',
            DATE_END => '2008-01-22'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'STAGE',
            minor => 'ROUND',
            DATE_START => '2010-01-15',
            DATE_END => '2010-01-16'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-22'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-20',
            DATE_END => '2012-01-21'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Repechage',
            major => 'SEGMENT',
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-22'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT',
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-17',
            DATE_END => '2014-01-18'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Repechage',
            major => 'SEGMENT',
            DATE_START => '2014-01-19',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-01-13',
            DATE_END => '2015-01-13'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Australian Youth Week',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-11',
            DATE_END => '2016-01-15'
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
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-12-03',
            DATE_END => '2011-12-03'
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
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-12-03',
            DATE_END => '2011-12-03'
          } 
        }
      },
      '2013' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-12-08',
            DATE_END => '2013-12-08'
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
    AGE => 'U26',

    EDITIONS =>
    {
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-02',
            DATE_END => '2011-12-02'
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
