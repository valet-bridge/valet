#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Poland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Poland has a number of congresses, each with a number of
# tournaments that have similar names, often including
# "Grand Prix of Poland".
#
# My solution is to keep the number of tournament names low
# by keeping the generic tournament names where possible.

my %MEETS_POLAND =
(
  'Poznan Congress' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Poznan',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2004' =>
      {
        # https://stara.pzbs.pl/wyniki/2004/krajowe/gpp2004/6poznan/poznanski.htm
        ORDINAL => 44,
        YEAR => 2004,
        DATE_START => '2004-06-03',
        DATE_END => '2004-06-06'
      },
      '2005' =>
      {
        # https://stara.pzbs.pl/wyniki/2005/krajowe/gppolski/07poznan/poznan2005.htm
        ORDINAL => 45,
        YEAR => 2005,
        DATE_START => '2005-06-11',
        DATE_END => '2005-06-12'
      },
      '2006' =>
      {
        # https://stara.pzbs.pl/wyniki/2006/krajowe/poznanski06/poznanski2006.htm
        ORDINAL => 46,
        YEAR => 2006,
        DATE_START => '2006-06-30',
        DATE_END => '2006-07-02'
      },
      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/09poznan/poznanski2007.htm
        ORDINAL => 47,
        YEAR => 2007,
        DATE_START => '2007-06-08',
        DATE_END => '2007-06-10'
      },
      '2008' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2008
        ORDINAL => 48,
        YEAR => 2008,
        DATE_START => '2008-05-22',
        DATE_END => '2008-05-25'
      },
      '2009' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2009
        ORDINAL => 49,
        YEAR => 2009,
        DATE_START => '2009-06-11',
        DATE_END => '2009-06-14'
      },
      '2010' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2010
        ORDINAL => 50,
        YEAR => 2010,
        DATE_START => '2010-06-03',
        DATE_END => '2010-06-06'
      },
      '2011' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2011
        ORDINAL => 51,
        YEAR => 2011,
        DATE_START => '2011-04-30',
        DATE_END => '2011-05-03'
      },
      '2012' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2012
        ORDINAL => 52,
        YEAR => 2012,
        DATE_START => '2012-06-01',
        DATE_END => '2012-06-03'
      },
      '2013' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2013
        ORDINAL => 53,
        YEAR => 2013,
        DATE_START => '2013-05-30',
        DATE_END => '2013-06-02'
      },
      '2014' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2014
        ORDINAL => 54,
        YEAR => 2014,
        DATE_START => '2014-06-05',
        DATE_END => '2014-06-08'
      },
      '2015' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2015
        ORDINAL => 55,
        YEAR => 2015,
        DATE_START => '2015-06-03',
        DATE_END => '2015-06-07'
      },
      '2016' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2016
        ORDINAL => 56,
        YEAR => 2016,
        DATE_START => '2016-05-25',
        DATE_END => '2016-05-29'
      },
      '2017' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2017
        ORDINAL => 57,
        YEAR => 2017,
        DATE_START => '2017-06-15',
        DATE_END => '2017-06-18'
      },
      '2018' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2018
        ORDINAL => 58,
        YEAR => 2018,
        DATE_START => '2018-05-30',
        DATE_END => '2018-06-03'
      },
      '2019' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2019
        ORDINAL => 59,
        YEAR => 2019,
        DATE_START => '2019-06-19',
        DATE_END => '2019-06-23'
      },
      '2021' =>
      {
        # http://60pkb.e-pab.pl/
        ORDINAL => 60,
        YEAR => 2021,
        DATE_START => '2021-09-23',
        DATE_END => '2021-09-26'
      },
      '2022' =>
      {
        # http://kongresy.brydz.wlkp.pl/index.php/harmonogram-wyniki-2022/
        ORDINAL => 61,
        YEAR => 2021,
        DATE_START => '2022-04-29',
        DATE_END => '2022-05-03'
      },
      '2023' =>
      {
        # https://kongrespoznanski.pl/historia/pkb-2023/
        ORDINAL => 62,
        YEAR => 2023,
        DATE_START => '2023-04-29',
        DATE_END => '2023-05-03'
      },
      '2024' =>
      {
        # https://kongrespoznanski.pl/
        ORDINAL => 63,
        YEAR => 2024,
        DATE_START => '2024-05-01',
        DATE_END => '2024-05-04'
      },
    }
  },

  'Slawa Congress' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Slawa',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2011' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2011
        ORDINAL => 54,
        YEAR => 2011,
        DATE_START => '2011-07-08',
        DATE_END => '2011-07-17'
      },
      '2012' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2012
        ORDINAL => 55,
        YEAR => 2012,
        DATE_START => '2012-07-06',
        DATE_END => '2012-07-15'
      },
      '2013' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2013
        ORDINAL => 56,
        YEAR => 2013,
        DATE_START => '2013-07-05',
        DATE_END => '2013-07-14'
      },
      '2014' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2014
        ORDINAL => 57,
        YEAR => 2014,
        DATE_START => '2014-07-03',
        DATE_END => '2014-07-12'
      },
      '2015' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2015
        ORDINAL => 58,
        YEAR => 2015,
        DATE_START => '2015-07-02',
        DATE_END => '2015-07-11'
      },
      '2016' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2016
        ORDINAL => 59,
        YEAR => 2016,
        DATE_START => '2016-06-30',
        DATE_END => '2016-07-09'
      },
      '2017' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2017
        ORDINAL => 60,
        YEAR => 2017,
        DATE_START => '2017-06-29',
        DATE_END => '2017-07-08'
      },
      '2018' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2018
        ORDINAL => 61,
        YEAR => 2018,
        DATE_START => '2018-06-28',
        DATE_END => '2018-07-07'
      },
      '2019' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2019
        ORDINAL => 62,
        YEAR => 2019,
        DATE_START => '2019-06-27',
        DATE_END => '2019-07-06'
      },
      '2020' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2020
        # Probably did not take place
        YEAR => 2020,
        ORDINAL => 63,
        DATE_START => '2020-07-02',
        DATE_END => '2020-07-11'
      },
      '2021' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2021
        YEAR => 2021,
        ORDINAL => 64,
        DATE_START => '2021-06-24',
        DATE_END => '2021-07-03'
      },
      '2022' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2022
        YEAR => 2022,
        ORDINAL => 65,
        DATE_START => '2022-06-23',
        DATE_END => '2022-07-02'
      },
      '2023' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2023
        YEAR => 2023,
        ORDINAL => 66,
        DATE_START => '2023-06-22',
        DATE_END => '2023-07-01'
      },
      '2024' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2024
        YEAR => 2024,
        ORDINAL => 67,
        DATE_START => '2024-06-20',
        DATE_END => '2024-06-29'
      },
    }
  },

  'Warsaw Grand Prix' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Warsaw',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2004' =>
      {
        # https://www.warsbrydz.pl/GPW2004/support/program.htm
        ORDINAL => 32,
        YEAR => 2004,
        DATE_START => '2004-08-20',
        DATE_END => '2004-08-29'
      },
      '2005' =>
      {
        # https://www.warsbrydz.pl/GPW2005/support/program.htm
        ORDINAL => 33,
        YEAR => 2005,
        DATE_START => '2005-08-19',
        DATE_END => '2005-08-28'
      },
      '2006' =>
      {
        # https://www.warsbrydz.pl/GPW2006/support/program.htm
        ORDINAL => 34,
        YEAR => 2006,
        DATE_START => '2006-08-25',
        DATE_END => '2006-09-03'
      },
      '2007' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2007/gp2007.htm
        ORDINAL => 35,
        YEAR => 2007,
        DATE_START => '2007-08-24',
        DATE_END => '2007-09-02'
      },
      '2008' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2008/gp2008.php?main=2
        ORDINAL => 36,
        YEAR => 2008,
        DATE_START => '2008-08-21',
        DATE_END => '2008-08-31'
      },
      '2009' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2009/gp2009.php?main=2
        ORDINAL => 37,
        YEAR => 2009,
        DATE_START => '2009-08-20',
        DATE_END => '2009-08-30'
      },
      '2010' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2010/gp2010.php?main=2
        ORDINAL => 38,
        YEAR => 2010,
        DATE_START => '2010-08-20',
        DATE_END => '2010-08-29'
      },
      '2011' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2011/gp2011.php?main=2
        ORDINAL => 39,
        YEAR => 2011,
        DATE_START => '2011-08-18',
        DATE_END => '2011-08-28'
      },
      '2012' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2012/gp2012.php?main=2
        ORDINAL => 40,
        YEAR => 2012,
        DATE_START => '2012-08-24',
        DATE_END => '2012-09-02'
      },
      '2013' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2013/gp2013.php?main=2
        ORDINAL => 41,
        YEAR => 2013,
        DATE_START => '2013-08-23',
        DATE_END => '2013-09-01'
      },
      '2014' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2014/gp2014.php?main=2
        ORDINAL => 42,
        YEAR => 2014,
        DATE_START => '2014-08-22',
        DATE_END => '2014-08-31'
      },
      '2015' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2015/gp2015.php?main=2
        ORDINAL => 43,
        YEAR => 2015,
        DATE_START => '2015-08-21',
        DATE_END => '2015-08-30'
      },
      '2016' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2016/gp2016.php?main=2
        ORDINAL => 44,
        YEAR => 2016,
        DATE_START => '2016-08-19',
        DATE_END => '2016-08-28'
      },
      '2017' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2017/gp2017.php?main=2
        ORDINAL => 45,
        YEAR => 2017,
        DATE_START => '2017-08-18',
        DATE_END => '2017-08-27'
      },
      '2018' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2018/gp2018.php?main=2
        ORDINAL => 46,
        YEAR => 2018,
        DATE_START => '2018-08-24',
        DATE_END => '2018-09-02'
      },
      '2019' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2019/new_program.php
        ORDINAL => 47,
        YEAR => 2019,
        DATE_START => '2019-08-23',
        DATE_END => '2019-09-01'
      },
      '2021' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2021/new_program.php
        ORDINAL => 48,
        YEAR => 2021,
        DATE_START => '2021-08-25',
        DATE_END => '2021-08-29'
      },
      '2022' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2022/new_program.php
        ORDINAL => 49,
        YEAR => 2022,
        DATE_START => '2022-07-29',
        DATE_END => '2022-08-07'
      },
      '2023' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2023/new_program.php
        ORDINAL => 50,
        YEAR => 2023,
        DATE_START => '2023-08-18',
        DATE_END => '2023-08-27'
      },
      '2024' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2024/new_program.php
        ORDINAL => 51,
        YEAR => 2024,
        DATE_START => '2024-08-16',
        DATE_END => '2024-08-25'
      },
    }
  },

  'Zulawski Congress' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2007' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski07/index.html
        ORDINAL => 10,
        CITY => 'Elblag',
        YEAR => 2007,
        DATE_START => '2007-02-23',
        DATE_END => '2007-02-25'
      },
      '2008' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski08/index.html
        ORDINAL => 11,
        CITY => 'Elblag',
        YEAR => 2008,
        DATE_START => '2008-02-22',
        DATE_END => '2008-02-24'
      },
      '2009' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski09/index.html
        ORDINAL => 12,
        CITY => 'Elblag',
        YEAR => 2009,
        DATE_START => '2009-02-20',
        DATE_END => '2009-02-22'
      },
      '2010' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski10/index.html
        ORDINAL => 13,
        CITY => 'Elblag',
        YEAR => 2010,
        DATE_START => '2010-02-19',
        DATE_END => '2010-02-21'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/_gpp/01elblag/W-egpp.html
        ORDINAL => 14,
        CITY => 'Elblag',
        YEAR => 2011,
        DATE_START => '2011-02-18',
        DATE_END => '2011-02-20'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2011/_gpp/2012/01elblag/
        ORDINAL => 15,
        CITY => 'Elblag',
        YEAR => 2012,
        DATE_START => '2012-02-10',
        DATE_END => '2012-02-12'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/02elblag/wyniki/
        ORDINAL => 16,
        CITY => 'Elblag',
        YEAR => 2013,
        DATE_START => '2013-03-08',
        DATE_END => '2013-03-10'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/01elblag/
        ORDINAL => 17,
        CITY => 'Elblag',
        YEAR => 2014,
        DATE_START => '2014-01-24',
        DATE_END => '2014-01-26'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/02elblag/
        ORDINAL => 18,
        CITY => 'Elblag',
        YEAR => 2015,
        DATE_START => '2015-03-06',
        DATE_END => '2015-03-08'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/02elblag/
        ORDINAL => 19,
        CITY => 'Elblag',
        YEAR => 2016,
        DATE_START => '2016-03-04',
        DATE_END => '2016-03-06'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/02elblag/
        ORDINAL => 20,
        CITY => 'Elblag',
        YEAR => 2017,
        DATE_START => '2017-03-03',
        DATE_END => '2017-03-05'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/06elblag/
        ORDINAL => 21,
        CITY => 'Elblag',
        YEAR => 2018,
        DATE_START => '2018-03-01',
        DATE_END => '2018-03-04'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/elblag/
        ORDINAL => 22,
        CITY => 'Elblag',
        YEAR => 2019,
        DATE_START => '2019-03-07',
        DATE_END => '2019-03-10'
      },
      '2020' =>
      {
        # https://wyniki.pzbs.pl/2020/elblag/
        ORDINAL => 23,
        CITY => 'Elblag',
        YEAR => 2020,
        DATE_START => '2020-01-22',
        DATE_END => '2020-01-26'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/elblag/
        ORDINAL => 25,
        CITY => 'Krynica Morska',
        YEAR => 2022,
        DATE_START => '2022-10-06',
        DATE_END => '2022-10-09'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/elblag/
        ORDINAL => 26,
        CITY => 'Warlity Wielkie',
        YEAR => 2023,
        DATE_START => '2023-03-02',
        DATE_END => '2023-03-05'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/elblag/
        ORDINAL => 27,
        CITY => 'Warlity Wielkie',
        YEAR => 2024,
        DATE_START => '2024-02-29',
        DATE_END => '2024-03-03'
      },
    }
  },

  # http://www.bridge.elblag.com.pl/zulawski14/rules.html

);

my %TOURNAMENTS_POLAND =
(
  'Andrzej Wilkosz Memorial Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Grand Prix of Poland',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Grand Prix of Poland Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-20',
            DATE_END => '2010-02-20'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-02-20',
            DATE_END => '2011-02-20'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-11'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-03',
            DATE_END => '2012-06-03'
          } 
        }
      },
      '2013A' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
      '2013B' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-07',
            DATE_END => '2013-07-07'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-01-26',
            DATE_END => '2014-01-26'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-06',
            DATE_END => '2014-07-06'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-29',
            DATE_END => '2016-05-29'
          } 
        }
      },
    }
  },

  'Grand Prix of Poland Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Warsaw Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-08-29',
            DATE_END => '2009-08-30'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-10',
            DATE_END => '2011-07-10'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-07-08',
            DATE_END => '2012-07-08'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Slawa Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-08',
            DATE_END => '2013-07-09'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Poznan Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-28'
          } 
        }
      },
    }
  },

  'Grand Prix of Warsaw',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Grand Prix of Wielkopolski',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Janina Wielkoszewska Memorial Open',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Janos Levai Memorial',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Warsaw Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-23',
            DATE_END => '2011-08-23'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Warsaw Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-28',
            DATE_END => '2012-08-28'
          } 
        }
      },
    }
  },

  'Józef Pochron Jubilee Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Krakow Spring',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Krakow Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Leszek Kwiatkowski Memorial Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-02'
          } 
        }
      },
    }
  },

  'Leszek Kwiatkowski Memorial Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish BAM Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-12'
          } 
        }
      },
    }
  },

  'Polish Boys Championship',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Business League',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Commercial Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Girls Championship',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Girls Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish IMP Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Individual Championship',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Junior Pairs Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Mixed Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Mixed Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-07'
          } 
        }
      },
    }
  },

  'Polish Open Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Open Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Patton Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Premier League',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011-12' =>
      {
        # https://www.pzbs.pl/ligi-all/84/1219

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-10-07',
            DATE_END => '2011-10-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            DATE_START => '2012-01-13',
            DATE_END => '2012-01-15'
          },
          'C2' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-09',
            DATE_END => '2012-05-12'
          },
        }
      },
      '2012-13' =>
      {
        # https://www.pzbs.pl/ligi-all/ekstraklasa

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            DATE_START => '2013-01-04',
            DATE_END => '2013-01-05'
          },
          'C2' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-16',
            DATE_END => '2013-05-18'
          },
        }
      },
      '2013-14' =>
      {
        # https://www.pzbs.pl/ligi-all/119

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-11',
            DATE_END => '2013-10-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            DATE_START => '2014-01-03',
            DATE_END => '2014-01-05'
          },
          'C2' => 
          {
            YEAR => 2014,
            DATE_START => '2014-06-12',
            DATE_END => '2014-06-14'
          },
        }
      },
      '2014-15' =>
      {
        # https://www.pzbs.pl/ligi-all/132

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-10-03',
            DATE_END => '2014-10-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-02',
            DATE_END => '2015-01-04'
          },
          'C2' => 
          {
            YEAR => 2015,
            DATE_START => '2015-06-17',
            DATE_END => '2015-06-20'
          },
        }
      },
      '2015-16' =>
      {
        # https://www.pzbs.pl/ligi-all/201516/ekstraklasa-201516

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-10-16',
            DATE_END => '2015-10-18'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-10'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-09',
            DATE_END => '2016-06-10'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-10',
            DATE_END => '2016-06-11'
          } 
        }
      },
    }
  },

  'Polish Second League',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Senior Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish School Championship',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Super League',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Top Individual',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish U16 Championship',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish U20 Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish U25 Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Women Trials',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Polish Youngster Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Poznan Mixed Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Poznan Pairs Cup',
  {
    FORM => 'Pairs',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-02'
          } 
        }
      },
    }
  },

  'Poznan Open Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Staszek Wybranowski Memorial',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Warsaw Online Teams',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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

  'Zulawski Cup',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-05'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_POLAND, \%TOURNAMENTS_POLAND, 'Poland');
}

1;
