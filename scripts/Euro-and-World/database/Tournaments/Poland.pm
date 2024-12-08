#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Poland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Poland has a number of congresses, and a grand prix system
# that cuts across many congresses and events.
#
# Useful links:
# https://stara.pzbs.pl/wyniki/default.htm
# https://stara.pzbs.pl/imprezy/kal08.html
# https://stara.pzbs.pl/imprezy/kal09.html

my %GLOBAL = (
  ORGANIZATION => 'PZBS',
  COUNTRY => 'Poland',
  ZONE => 'Europe',
);

my %MEETS_POLAND =
(
  'Baltic Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2009' =>
      {
        MEET_ORDINAL => 49,
        YEAR => 2009,
        CITY => 'Sopot',
        DATE_START => '2009-07-21',
        DATE_END => '2009-07-22'
      },
      '2010' =>
      {
        # https://bridge.gda.pl/kongres/10/k_baltycki10.htm
        MEET_ORDINAL => 50,
        YEAR => 2010,
        CITY => 'Sopot',
        DATE_START => '2010-07-14',
        DATE_END => '2010-07-25'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/baltycki/
        MEET_ORDINAL => 51,
        YEAR => 2011,
        CITY => 'Sopot',
        DATE_START => '2011-07-21',
        DATE_END => '2011-07-31'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/baltycki/
        MEET_ORDINAL => 52,
        YEAR => 2012,
        CITY => 'Sopot',
        DATE_START => '2012-07-26',
        DATE_END => '2012-08-05'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/baltycki/
        MEET_ORDINAL => 53,
        YEAR => 2013,
        CITY => 'Sopot',
        DATE_START => '2013-07-19',
        DATE_END => '2013-07-27'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/baltycki/
        MEET_ORDINAL => 54,
        YEAR => 2014,
        CITY => 'Sopot',
        DATE_START => '2014-07-18',
        DATE_END => '2014-07-26'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/baltycki/
        MEET_ORDINAL => 55,
        YEAR => 2015,
        CITY => 'Sopot',
        DATE_START => '2015-07-17',
        DATE_END => '2015-07-25'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/baltycki/
        MEET_ORDINAL => 56,
        YEAR => 2016,
        CITY => 'Sopot',
        DATE_START => '2016-07-22',
        DATE_END => '2016-07-30'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/baltycki/
        MEET_ORDINAL => 57,
        YEAR => 2017,
        CITY => 'Sopot',
        DATE_START => '2017-08-04',
        DATE_END => '2017-08-12'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/baltycki/
        MEET_ORDINAL => 58,
        YEAR => 2018,
        CITY => 'Sopot',
        DATE_START => '2018-08-03',
        DATE_END => '2018-08-11'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/baltycki/
        MEET_ORDINAL => 59,
        YEAR => 2019,
        CITY => 'Sopot',
        DATE_START => '2019-08-02',
        DATE_END => '2019-08-10'
      },
      '2021' =>
      {
        # https://wyniki.pzbs.pl/2021/baltycki/
        MEET_ORDINAL => 60,
        YEAR => 2021,
        CITY => 'Sopot',
        DATE_START => '2021-08-06',
        DATE_END => '2021-08-14'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/baltycki/
        MEET_ORDINAL => 61,
        YEAR => 2022,
        CITY => 'Sopot',
        DATE_START => '2022-07-15',
        DATE_END => '2022-07-23'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/baltycki/
        MEET_ORDINAL => 62,
        YEAR => 2023,
        CITY => 'Sopot',
        DATE_START => '2023-07-28',
        DATE_END => '2023-08-03'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/baltycki/
        MEET_ORDINAL => 63,
        YEAR => 2024,
        CITY => 'Sopot',
        DATE_START => '2024-07-26',
        DATE_END => '2024-08-01'
      },
    }
  },

  'Beskids Slam' =>
  {
    # Seems to have stopped in 2019
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Szczyrk',

    EDITIONS => 
    {
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/111111szczyrk/W-szczyrk.html
        YEAR => 2011,
        DATE_START => '2011-11-11',
        DATE_END => '2011-11-13'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/121109szczyrk/W-szczyrk2012_final.html
        YEAR => 2012,
        DATE_START => '2012-11-09',
        DATE_END => '2012-11-11'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/131108szczyrk/
        MEET_ORDINAL => 1,
        YEAR => 2013,
        DATE_START => '2013-11-08',
        DATE_END => '2013-11-11'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/02szczyrk/W-14szgpp.html
        MEET_ORDINAL => 2,
        YEAR => 2014,
        DATE_START => '2014-02-03',
        DATE_END => '2014-02-08'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/01szczyrk/W-15szgpp.html
        MEET_ORDINAL => 3,
        YEAR => 2015,
        DATE_START => '2015-02-09',
        DATE_END => '2015-02-15'
      },
      '2016' =>
      {
        # https://www.pzbs.pl/wyniki/kadra/2016/jun/szlem.html
        MEET_ORDINAL => 4,
        YEAR => 2016,
        DATE_START => '2016-02-15',
        DATE_END => '2016-02-21'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/01szczyrk/szlem.html
        MEET_ORDINAL => 5,
        YEAR => 2017,
        DATE_START => '2017-02-06',
        DATE_END => '2017-02-12'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/01szczyrk/
        MEET_ORDINAL => 6,
        YEAR => 2018,
        DATE_START => '2018-02-02',
        DATE_END => '2018-02-04'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/szczyrk/
        MEET_ORDINAL => 7,
        YEAR => 2019,
        DATE_START => '2019-01-11',
        DATE_END => '2019-01-13'
      },
    }
  },

  'Boleslawiec Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Boleslawiec',

    EDITIONS => 
    {
      '2009' =>
      {
        # ?
        MEET_ORDINAL => 18,
        YEAR => 2009,
        DATE_START => '2009-09-18',
        DATE_END => '2009-09-20'
      },
      '2010' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyniki2010/471-19-boleslawiecka-trzydniowka-wyniki
        MEET_ORDINAL => 19,
        YEAR => 2010,
        DATE_START => '2010-10-01',
        DATE_END => '2010-10-03'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/110916boles/program.htm
        MEET_ORDINAL => 20,
        YEAR => 2011,
        DATE_START => '2011-09-16',
        DATE_END => '2011-09-18'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/0920-boles/program.htm
        MEET_ORDINAL => 21,
        YEAR => 2012,
        DATE_START => '2012-09-21',
        DATE_END => '2012-09-23'
      },
      '2013' =>
      {
        # ?
        MEET_ORDINAL => 22,
        YEAR => 2013,
        DATE_START => '2013-10-03',
        DATE_END => '2013-10-06'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/13boles/program.htm
        MEET_ORDINAL => 23,
        YEAR => 2014,
        DATE_START => '2014-09-25',
        DATE_END => '2014-09-28'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/14boleslawiec/program.htm
        MEET_ORDINAL => 24,
        YEAR => 2015,
        DATE_START => '2015-09-17',
        DATE_END => '2015-09-20'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/15boles/program.htm
        MEET_ORDINAL => 25,
        YEAR => 2016,
        DATE_START => '2016-09-22',
        DATE_END => '2016-09-25'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/1718boles/program.htm
        MEET_ORDINAL => 26,
        YEAR => 2017,
        DATE_START => '2017-09-22',
        DATE_END => '2017-09-24'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp1819/boles/program.htm
        MEET_ORDINAL => 27,
        YEAR => 2018,
        DATE_START => '2018-09-20',
        DATE_END => '2018-09-23'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp1920/01boles/program.htm
        MEET_ORDINAL => 28,
        YEAR => 2019,
        DATE_START => '2019-09-19',
        DATE_END => '2019-09-23'
      },
      '2024' =>
      {
        # http://mzbskarkonosze.internetdsl.pl/trzydniowka/2024/program.htm
        YEAR => 2024,
        DATE_START => '2024-08-30',
        DATE_END => '2024-09-01'
      },
    }
  },

  'Krakow Congress' =>
  {
    # This is Krakow Spring
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Krakow',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/gpp/05bydgoszcz/W-bydgpp.html
        MEET_ORDINAL => 49,
        YEAR => 2012,
        DATE_START => '2012-03-23', # Dates are a guess
        DATE_END => '2012-03-25'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/03krakow/13kwgpp.html
        YEAR => 2013,
        DATE_START => '2013-03-22', # Dates are a guess
        DATE_END => '2013-03-24'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/04krakow/W-gpp2014.html
        YEAR => 2014,
        DATE_START => '2014-03-28', # Dates are a guess
        DATE_END => '2014-03-30'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/03krakow/
        YEAR => 2015,
        DATE_START => '2015-03-20',
        DATE_END => '2015-03-22'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/kwb/
        YEAR => 2016,
        DATE_START => '2016-03-11',
        DATE_END => '2016-03-13'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/kwb/
        YEAR => 2017,
        DATE_START => '2017-03-24',
        DATE_END => '2017-03-26'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/kwb/
        YEAR => 2018,
        DATE_START => '2018-03-23',
        DATE_END => '2018-03-25'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/kwb/
        YEAR => 2019,
        DATE_START => '2019-03-22',
        DATE_END => '2019-03-24'
      },
      '2022' =>
      {
        # https://kwb.mzbs.pl/22/
        YEAR => 2022,
        DATE_START => '2022-03-18',
        DATE_END => '2022-03-20'
      },
      '2023' =>
      {
        # https://kwb.mzbs.pl/23/
        YEAR => 2023,
        DATE_START => '2023-03-17',
        DATE_END => '2023-03-19'
      },
      '2024' =>
      {
        # https://kwb.mzbs.pl/24/
        YEAR => 2024,
        DATE_START => '2024-03-15',
        DATE_END => '2024-03-17'
      },
    }
  },

  'Luczniczka Meeting' =>
  {
    # "Archer"
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Bydgoszcz',

    EDITIONS => 
    {
      '2004' =>
      {
        # Dates are a guess.
        YEAR => 2004,
        DATE_START => '2004-04-28',
        DATE_END => '2004-04-28'
      },
      '2006' =>
      {
        # https://stara.pzbs.pl/wyniki/2006/krajowe/gpp2006/06bydg/luczniczka2006.htm
        # Dates are a guess.
        YEAR => 2006,
        DATE_START => '2006-04-05',
        DATE_END => '2006-04-09'
      },
      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/11Bydgoszcz/LUCZ/LUCZ.html
        MEET_ORDINAL => 44,
        YEAR => 2007,
        DATE_START => '2007-07-15', # Probably more days
        DATE_END => '2007-07-15'
      },
      '2009' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/gpp/07bydgoszcz/luczniczka2009.html
        MEET_ORDINAL => 46,
        YEAR => 2009,
        DATE_START => '2009-06-05',
        DATE_END => '2009-06-07'
      },
      '2010' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyniki2010/222-47-ogolnopolski-kongres-brydzowy-luczniczka-wyniki
        MEET_ORDINAL => 47,
        YEAR => 2010,
        DATE_START => '2010-06-26',
        DATE_END => '2010-06-28'
      },
      '2011' =>
      {
        # http://kpzbs.host4u.pl/wyniki/GP2011/Luczniczka/luczniczka.html
        MEET_ORDINAL => 48,
        YEAR => 2011,
        DATE_START => '2011-06-10',
        DATE_END => '2011-06-12'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/gpp/05bydgoszcz/W-bydgpp.html
        MEET_ORDINAL => 49,
        YEAR => 2012,
        DATE_START => '2012-04-27', # Guess
        DATE_END => '2012-04-29'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/08bydgoszcz/gp.html
        MEET_ORDINAL => 50,
        YEAR => 2013,
        DATE_START => '2013-06-14',
        DATE_END => '2013-06-16'
      },
      '2014' =>
      {
        # http://www.kpzbs.host4u.pl/wyniki/2014/luczniczka/luczniczka2014.html
        MEET_ORDINAL => 51,
        YEAR => 2014,
        DATE_START => '2014-03-14',
        DATE_END => '2014-03-16'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/04bydgoszcz/
        MEET_ORDINAL => 52,
        YEAR => 2015,
        DATE_START => '2015-03-27',
        DATE_END => '2015-03-29'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/06bydgoszcz/
        MEET_ORDINAL => 53,
        YEAR => 2016,
        DATE_START => '2016-05-13',
        DATE_END => '2016-05-15'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/06bydgoszcz/
        MEET_ORDINAL => 54,
        YEAR => 2017,
        DATE_START => '2017-05-12',
        DATE_END => '2017-05-14'
      },
      '2018' =>
      {
        # http://kpzbs.host4u.pl/wyniki/2018/Luczniczka/Luczniczka2018.html
        MEET_ORDINAL => 55,
        YEAR => 2018,
        DATE_START => '2018-07-27',
        DATE_END => '2018-07-29'
      },
      '2019' =>
      {
        # http://kpzbs.host4u.pl/wyniki/2019/Luczniczka/Luczniczka2019.html
        MEET_ORDINAL => 56,
        YEAR => 2019,
        DATE_START => '2019-07-19',
        DATE_END => '2019-07-21'
      },
      '2023' =>
      {
        # http://kpzbs.host4u.pl/zaproszenia/2023/luczniczka59.html
        MEET_ORDINAL => 59,
        YEAR => 2023,
        DATE_START => '2023-04-14',
        DATE_END => '2023-04-16'
      },
      '2024' =>
      {
        # http://kpzbs.host4u.pl/zaproszenia/2024/luczniczka60.html
        MEET_ORDINAL => 60,
        YEAR => 2024,
        DATE_START => '2024-07-19',
        DATE_END => '2024-07-21'
      },
    }
  },

  'Palace Cup' =>
  {
    %GLOBAL,
    CITY => 'Warsaw',

    EDITIONS => 
    {
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/palacecup/palace16.html
        YEAR => 2014,
        DATE_START => '2014-08-27',
        DATE_END => '2014-08-29'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-06-22',
        DATE_END => '2015-06-25'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-01',
        DATE_END => '2016-04-03'
      },
    }
  },

  'Polish Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2007' =>
      {
        YEAR => 2007,
        CITY => 'Poznan',
        DATE_START => '2007-05-05', # Probably more days
        DATE_END => '2007-05-05'
      },
      '2011' => 
      {
        YEAR => 2011,
        DATE_START => '2011-05-14',
        DATE_END => '2011-05-15'
      },
      '2012A' =>
      {
        YEAR => 2012,
        DATE_START => '2012-03-29',
        DATE_END => '2012-03-30'
      },
      '2012B' =>
      {
        YEAR => 2012,
        CITY => 'Poznan',
        DATE_START => '2012-05-01', # Estimated
        DATE_END => '2012-05-05'
      },
      '2013A' =>
      {
        YEAR => 2013,
        CITY => 'Poznan',
        DATE_START => '2013-04-29', # Estimated
        DATE_END => '2013-05-04'
      },
      '2013B' =>
      {
         YEAR => 2013,
        CITY => 'Krakow',
         DATE_START => '2013-11-23',
         DATE_END => '2013-11-23'
      },
      '2014A' =>
      {
        YEAR => 2014,
        CITY => 'Poznan',
        DATE_START => '2014-05-01',
        DATE_END => '2014-05-04'
      },
      '2014B' =>
      {
        YEAR => 2014,
        CITY => 'Krakow',
        DATE_START => '2014-11-22',
        DATE_END => '2014-11-23'
      },
      '2015A' =>
      {
        YEAR => 2015,
        CITY => 'Poznan',
        DATE_START => '2015-04-30',
        DATE_END => '2015-05-04'
      },
      '2015B' =>
      {
        YEAR => 2015,
        CITY => 'Krakow',
        DATE_START => '2015-11-21',
        DATE_END => '2015-11-22'
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Poznan',
        DATE_START => '2016-04-30',
        DATE_END => '2016-05-03'
      },
    }
  },

  'Polish Grand Prix Pairs Legs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2005' =>
      {
        CITY => 'Warsaw',
        YEAR => 2005,
        DATE_START => '2005-09-06',
        DATE_END => '2005-09-06'
      },
      '2006' =>
      {
        CITY => 'Warsaw',
        YEAR => 2006,
        DATE_START => '2006-12-15',
        DATE_END => '2006-12-17'
      },
      '2007A' =>
      {
        CITY => 'Lodz',
        YEAR => 2007,
        DATE_START => '2007-04-15',
        DATE_END => '2007-04-15'
      },
      '2007B' =>
      {
        CITY => 'Warsaw',
        YEAR => 2007,
        DATE_START => '2007-12-14',
        DATE_END => '2007-12-16'
      },
      '2008' =>
      {
        CITY => 'Warsaw',
        YEAR => 2008,
        DATE_START => '2008-12-19',
        DATE_END => '2008-12-21'
      },
      '2009A' =>
      {
        CITY => 'Starachowice',
        YEAR => 2009,
        DATE_START => '2009-03-08',
        DATE_END => '2009-03-08'
      },
      '2009B' =>
      {
        CITY => 'Starachowice',
        YEAR => 2009,
        DATE_START => '2009-12-18',
        DATE_END => '2009-12-20'
      },
      '2010A' =>
      {
        CITY => 'Pila',
        YEAR => 2010,
        DATE_START => '2010-03-06',
        DATE_END => '2010-03-07'
      },
      '2010B' =>
      {
        YEAR => 2010,
        DATE_START => '2010-12-17',
        DATE_END => '2010-12-19'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-12-16',
        DATE_END => '2011-12-18'
      },
      '2012A' =>
      {
        CITY => 'Pulawy',
        YEAR => 2012,
        DATE_START => '2012-06-16',
        DATE_END => '2012-06-16'
      },
      '2012B' =>
      {
        YEAR => 2012,
        DATE_START => '2012-12-14',
        DATE_END => '2012-12-16'
      },
      '2012C' =>
      {
        YEAR => 2012,
        DATE_START => '2012-12-17',
        DATE_END => '2012-12-18'
      },
      '2013A' =>
      {
        CITY => 'Krakow',
        YEAR => 2013,
        DATE_START => '2013-11-24',
        DATE_END => '2013-11-24'
      },
      '2013B' =>
      {
        YEAR => 2013,
        DATE_START => '2013-12-13',
        DATE_END => '2013-12-15'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-12-19',
        DATE_END => '2014-12-21'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-12-11',
        DATE_END => '2015-12-13'
      },
    }
  },

  'Polish Grand Prix Teams Legs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2009' =>
      {
        CITY => 'Staszic',
        YEAR => 2009,
        DATE_START => '2009-03-08',
        DATE_END => '2009-03-08'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-12-19',
        DATE_END => '2013-12-21'
      },
      '2016' =>
      {
        CITY => 'Dąbrowa Gornicza',
        YEAR => 2016,
        DATE_START => '2016-06-17',
        DATE_END => '2016-06-19'
      },
    }
  },

  'Polish Pairs Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-07',
        DATE_END => '2006-05-07'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-05-05',
        DATE_END => '2012-05-06'
      },
    }
  },

  'Polish School Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    AGE => 'Schools',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-06-12',
        DATE_END => '2010-06-13'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-06-07',
        DATE_END => '2012-06-08'
      },
    }
  },

  'Poznan Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Poznan',

    EDITIONS => 
    {
      '2004' =>
      {
        # https://stara.pzbs.pl/wyniki/2004/krajowe/gpp2004/6poznan/poznanski.htm
        MEET_ORDINAL => 44,
        YEAR => 2004,
        DATE_START => '2004-06-03',
        DATE_END => '2004-06-06'
      },
      '2005' =>
      {
        # https://stara.pzbs.pl/wyniki/2005/krajowe/gppolski/07poznan/poznan2005.htm
        MEET_ORDINAL => 45,
        YEAR => 2005,
        DATE_START => '2005-06-11',
        DATE_END => '2005-06-12'
      },
      '2006' =>
      {
        # https://stara.pzbs.pl/wyniki/2006/arajowe/poznanski06/poznanski2006.htm
        MEET_ORDINAL => 46,
        YEAR => 2006,
        DATE_START => '2006-06-30',
        DATE_END => '2006-07-02'
      },
      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/09poznan/poznanski2007.htm
        MEET_ORDINAL => 47,
        YEAR => 2007,
        DATE_START => '2007-06-08',
        DATE_END => '2007-06-11'
      },
      '2008' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2008
        MEET_ORDINAL => 48,
        YEAR => 2008,
        DATE_START => '2008-05-22',
        DATE_END => '2008-05-25'
      },
      '2009' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2009
        MEET_ORDINAL => 49,
        YEAR => 2009,
        DATE_START => '2009-06-11',
        DATE_END => '2009-06-14'
      },
      '2010' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2010
        MEET_ORDINAL => 50,
        YEAR => 2010,
        DATE_START => '2010-06-03',
        DATE_END => '2010-06-06'
      },
      '2011' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2011
        MEET_ORDINAL => 51,
        YEAR => 2011,
        DATE_START => '2011-04-30',
        DATE_END => '2011-05-03'
      },
      '2012' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2012
        MEET_ORDINAL => 52,
        YEAR => 2012,
        DATE_START => '2012-06-01',
        DATE_END => '2012-06-03'
      },
      '2013' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2013
        MEET_ORDINAL => 53,
        YEAR => 2013,
        DATE_START => '2013-05-30',
        DATE_END => '2013-06-02'
      },
      '2014' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2014
        MEET_ORDINAL => 54,
        YEAR => 2014,
        DATE_START => '2014-06-05',
        DATE_END => '2014-06-08'
      },
      '2015' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2015
        MEET_ORDINAL => 55,
        YEAR => 2015,
        DATE_START => '2015-06-03',
        DATE_END => '2015-06-07'
      },
      '2016' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2016
        MEET_ORDINAL => 56,
        YEAR => 2016,
        DATE_START => '2016-05-25',
        DATE_END => '2016-05-29'
      },
      '2017' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2017
        MEET_ORDINAL => 57,
        YEAR => 2017,
        DATE_START => '2017-06-15',
        DATE_END => '2017-06-18'
      },
      '2018' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2018
        MEET_ORDINAL => 58,
        YEAR => 2018,
        DATE_START => '2018-05-30',
        DATE_END => '2018-06-03'
      },
      '2019' =>
      {
        # https://kongres.brydz.wlkp.pl/arch2019
        MEET_ORDINAL => 59,
        YEAR => 2019,
        DATE_START => '2019-06-19',
        DATE_END => '2019-06-23'
      },
      '2021' =>
      {
        # http://60pkb.e-pab.pl/
        MEET_ORDINAL => 60,
        YEAR => 2021,
        DATE_START => '2021-09-23',
        DATE_END => '2021-09-26'
      },
      '2022' =>
      {
        # http://kongresy.brydz.wlkp.pl/index.php/harmonogram-wyniki-2022/
        MEET_ORDINAL => 61,
        YEAR => 2022,
        DATE_START => '2022-04-29',
        DATE_END => '2022-05-03'
      },
      '2023' =>
      {
        # https://kongrespoznanski.pl/historia/pkb-2023/
        MEET_ORDINAL => 62,
        YEAR => 2023,
        DATE_START => '2023-04-29',
        DATE_END => '2023-05-03'
      },
      '2024' =>
      {
        # https://kongrespoznanski.pl/
        MEET_ORDINAL => 63,
        YEAR => 2024,
        DATE_START => '2024-05-01',
        DATE_END => '2024-05-04'
      },
    }
  },

  'Slawa Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Slawa',

    EDITIONS => 
    {
      '2007' =>
      {
        # No link
        MEET_ORDINAL => 50,
        YEAR => 2007,
        DATE_START => '2007-07-06',
        DATE_END => '2007-07-15'
      },
      '2008' =>
      {
        # No link
        MEET_ORDINAL => 51,
        YEAR => 2008,
        DATE_START => '2008-07-04',
        DATE_END => '2008-07-13'
      },
      '2009' =>
      {
        # No link
        MEET_ORDINAL => 52,
        YEAR => 2009,
        DATE_START => '2009-07-03',
        DATE_END => '2009-07-11'
      },
      '2010' =>
      {
        # https://wyniki.pzbs.pl/2010/slawa/
        MEET_ORDINAL => 53,
        YEAR => 2010,
        DATE_START => '2010-07-02',
        DATE_END => '2010-07-11'
      },
      '2011' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2011
        MEET_ORDINAL => 54,
        YEAR => 2011,
        DATE_START => '2011-07-08',
        DATE_END => '2011-07-17'
      },
      '2012' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2012
        MEET_ORDINAL => 55,
        YEAR => 2012,
        DATE_START => '2012-07-06',
        DATE_END => '2012-07-15'
      },
      '2013' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2013
        MEET_ORDINAL => 56,
        YEAR => 2013,
        DATE_START => '2013-07-05',
        DATE_END => '2013-07-14'
      },
      '2014' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2014
        MEET_ORDINAL => 57,
        YEAR => 2014,
        DATE_START => '2014-07-03',
        DATE_END => '2014-07-12'
      },
      '2015' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2015
        MEET_ORDINAL => 58,
        YEAR => 2015,
        DATE_START => '2015-07-02',
        DATE_END => '2015-07-11'
      },
      '2016' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2016
        MEET_ORDINAL => 59,
        YEAR => 2016,
        DATE_START => '2016-06-30',
        DATE_END => '2016-07-09'
      },
      '2017' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2017
        MEET_ORDINAL => 60,
        YEAR => 2017,
        DATE_START => '2017-06-29',
        DATE_END => '2017-07-08'
      },
      '2018' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2018
        MEET_ORDINAL => 61,
        YEAR => 2018,
        DATE_START => '2018-06-28',
        DATE_END => '2018-07-07'
      },
      '2019' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2019
        MEET_ORDINAL => 62,
        YEAR => 2019,
        DATE_START => '2019-06-27',
        DATE_END => '2019-07-06'
      },
      '2020' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2020
        # Probably did not take place
        YEAR => 2020,
        MEET_ORDINAL => 63,
        DATE_START => '2020-07-02',
        DATE_END => '2020-07-11'
      },
      '2021' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2021
        YEAR => 2021,
        MEET_ORDINAL => 64,
        DATE_START => '2021-06-24',
        DATE_END => '2021-07-03'
      },
      '2022' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2022
        YEAR => 2022,
        MEET_ORDINAL => 65,
        DATE_START => '2022-06-23',
        DATE_END => '2022-07-02'
      },
      '2023' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2023
        YEAR => 2023,
        MEET_ORDINAL => 66,
        DATE_START => '2023-06-22',
        DATE_END => '2023-07-01'
      },
      '2024' =>
      {
        # https://www.kongres-slawa.pl/harmonogram/2024
        YEAR => 2024,
        MEET_ORDINAL => 67,
        DATE_START => '2024-06-20',
        DATE_END => '2024-06-29'
      },
    }
  },

  'Warsaw Grand Prix' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Warsaw',

    EDITIONS => 
    {
      '2004' =>
      {
        # https://www.warsbrydz.pl/GPW2004/support/program.htm
        MEET_ORDINAL => 32,
        YEAR => 2004,
        DATE_START => '2004-08-20',
        DATE_END => '2004-08-29'
      },
      '2005' =>
      {
        # https://www.warsbrydz.pl/GPW2005/support/program.htm
        MEET_ORDINAL => 33,
        YEAR => 2005,
        DATE_START => '2005-08-19',
        DATE_END => '2005-08-28'
      },
      '2006' =>
      {
        # https://www.warsbrydz.pl/GPW2006/support/program.htm
        MEET_ORDINAL => 34,
        YEAR => 2006,
        DATE_START => '2006-08-25',
        DATE_END => '2006-09-03'
      },
      '2007' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2007/gp2007.htm
        MEET_ORDINAL => 35,
        YEAR => 2007,
        DATE_START => '2007-08-24',
        DATE_END => '2007-09-02'
      },
      '2008' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2008/gp2008.php?main=2
        MEET_ORDINAL => 36,
        YEAR => 2008,
        DATE_START => '2008-08-21',
        DATE_END => '2008-08-31'
      },
      '2009' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2009/gp2009.php?main=2
        MEET_ORDINAL => 37,
        YEAR => 2009,
        DATE_START => '2009-08-20',
        DATE_END => '2009-08-30'
      },
      '2010' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2010/gp2010.php?main=2
        MEET_ORDINAL => 38,
        YEAR => 2010,
        DATE_START => '2010-08-20',
        DATE_END => '2010-08-29'
      },
      '2011' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2011/gp2011.php?main=2
        MEET_ORDINAL => 39,
        YEAR => 2011,
        DATE_START => '2011-08-18',
        DATE_END => '2011-08-28'
      },
      '2012' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2012/gp2012.php?main=2
        MEET_ORDINAL => 40,
        YEAR => 2012,
        DATE_START => '2012-08-24',
        DATE_END => '2012-09-02'
      },
      '2013' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2013/gp2013.php?main=2
        MEET_ORDINAL => 41,
        YEAR => 2013,
        DATE_START => '2013-08-23',
        DATE_END => '2013-09-01'
      },
      '2014' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2014/gp2014.php?main=2
        MEET_ORDINAL => 42,
        YEAR => 2014,
        DATE_START => '2014-08-22',
        DATE_END => '2014-08-31'
      },
      '2015' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2015/gp2015.php?main=2
        MEET_ORDINAL => 43,
        YEAR => 2015,
        DATE_START => '2015-08-21',
        DATE_END => '2015-08-30'
      },
      '2016' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2016/gp2016.php?main=2
        MEET_ORDINAL => 44,
        YEAR => 2016,
        DATE_START => '2016-08-19',
        DATE_END => '2016-08-28'
      },
      '2017' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2017/gp2017.php?main=2
        MEET_ORDINAL => 45,
        YEAR => 2017,
        DATE_START => '2017-08-18',
        DATE_END => '2017-08-27'
      },
      '2018' =>
      {
        # https://www.warsbrydz.pl/gpw/gpw2018/gp2018.php?main=2
        MEET_ORDINAL => 46,
        YEAR => 2018,
        DATE_START => '2018-08-24',
        DATE_END => '2018-09-02'
      },
      '2019' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2019/new_program.php
        MEET_ORDINAL => 47,
        YEAR => 2019,
        DATE_START => '2019-08-23',
        DATE_END => '2019-09-01'
      },
      '2021' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2021/new_program.php
        MEET_ORDINAL => 48,
        YEAR => 2021,
        DATE_START => '2021-08-25',
        DATE_END => '2021-08-29'
      },
      '2022' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2022/new_program.php
        MEET_ORDINAL => 49,
        YEAR => 2022,
        DATE_START => '2022-07-29',
        DATE_END => '2022-08-07'
      },
      '2023' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2023/new_program.php
        MEET_ORDINAL => 50,
        YEAR => 2023,
        DATE_START => '2023-08-18',
        DATE_END => '2023-08-27'
      },
      '2024' =>
      {
        # https://www.warsbrydz.pl/GPW/GPW2024/new_program.php
        MEET_ORDINAL => 51,
        YEAR => 2024,
        DATE_START => '2024-08-16',
        DATE_END => '2024-08-25'
      },
    }
  },

  'Wroclaw Meeting' =>
  {
    # Also "Blue Ribbon of the Oder"
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2008' =>
      {
        # Link on https://stara.pzbs.pl/imprezy/kal08.html
        MEET_ORDINAL => 29,
        CITY => 'Wroclaw',
        YEAR => 2008,
        DATE_START => '2008-05-09',
        DATE_END => '2008-05-11'
      },
      '2009' =>
      {
        # https://stara.pzbs.pl/imprezy/OTP/2009/bwodry2009.html
        MEET_ORDINAL => 30,
        CITY => 'Wroclaw',
        YEAR => 2009,
        DATE_START => '2009-05-08',
        DATE_END => '2009-05-10'
      },
      '2010' =>
      {
        # https://michzimny.pl/bridge/2010/wroclaw/
        MEET_ORDINAL => 31,
        CITY => 'Wroclaw',
        YEAR => 2010,
        DATE_START => '2010-05-07',
        DATE_END => '2010-05-09'
      },
      '2011' =>
      {
        # https://michzimny.pl/bridge/2011/wroclaw/
        MEET_ORDINAL => 32,
        CITY => 'Wroclaw',
        YEAR => 2011,
        DATE_START => '2011-05-06',
        DATE_END => '2011-05-08'
      },
      '2012' =>
      {
        # https://michzimny.pl/bridge/2012/wroclaw/
        MEET_ORDINAL => 33,
        CITY => 'Wroclaw',
        YEAR => 2012,
        DATE_START => '2012-05-25',
        DATE_END => '2012-05-27'
      },
      '2013' =>
      {
        # https://michzimny.pl/bridge/2013/wroclaw/
        MEET_ORDINAL => 34,
        CITY => 'Wroclaw',
        YEAR => 2013,
        DATE_START => '2013-05-24',
        DATE_END => '2013-05-26'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/07wroclaw/
        MEET_ORDINAL => 35,
        CITY => 'Wroclaw',
        YEAR => 2014,
        DATE_START => '2014-05-23',
        DATE_END => '2014-05-25'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/07wroclaw/
        MEET_ORDINAL => 36,
        CITY => 'Wroclaw',
        YEAR => 2015,
        DATE_START => '2015-05-22',
        DATE_END => '2015-05-24'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/07wroclaw/
        MEET_ORDINAL => 37,
        CITY => 'Wroclaw',
        YEAR => 2016,
        DATE_START => '2016-05-20',
        DATE_END => '2016-05-22'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/07wroclaw/
        MEET_ORDINAL => 38,
        CITY => 'Wroclaw',
        YEAR => 2017,
        DATE_START => '2017-05-26',
        DATE_END => '2017-05-28'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/wroclaw/
        MEET_ORDINAL => 39,
        CITY => 'Wroclaw',
        YEAR => 2018,
        DATE_START => '2018-05-18',
        DATE_END => '2018-05-20'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/wroclaw/
        MEET_ORDINAL => 40,
        CITY => 'Wroclaw',
        YEAR => 2019,
        DATE_START => '2019-05-24',
        DATE_END => '2019-05-26'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/wroclaw/
        MEET_ORDINAL => 41,
        CITY => 'Wroclaw',
        YEAR => 2022,
        DATE_START => '2022-05-20',
        DATE_END => '2022-05-22'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/wroclaw/
        MEET_ORDINAL => 42,
        CITY => 'Wroclaw',
        YEAR => 2023,
        DATE_START => '2023-05-12',
        DATE_END => '2023-05-14'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/wroclaw/
        MEET_ORDINAL => 43,
        CITY => 'Wroclaw',
        YEAR => 2024,
        DATE_START => '2024-05-17',
        DATE_END => '2024-05-19'
      },
    }
  },

  'Zulawski Congress' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2007' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski07/index.html
        MEET_ORDINAL => 10,
        CITY => 'Elblag',
        YEAR => 2007,
        DATE_START => '2007-02-23',
        DATE_END => '2007-02-25'
      },
      '2008' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski08/index.html
        MEET_ORDINAL => 11,
        CITY => 'Elblag',
        YEAR => 2008,
        DATE_START => '2008-02-22',
        DATE_END => '2008-02-24'
      },
      '2009' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski09/index.html
        MEET_ORDINAL => 12,
        CITY => 'Elblag',
        YEAR => 2009,
        DATE_START => '2009-02-20',
        DATE_END => '2009-02-22'
      },
      '2010' =>
      {
        # http://www.bridge.elblag.com.pl/zulawski10/index.html
        MEET_ORDINAL => 13,
        CITY => 'Elblag',
        YEAR => 2010,
        DATE_START => '2010-02-19',
        DATE_END => '2010-02-21'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/_gpp/01elblag/W-egpp.html
        MEET_ORDINAL => 14,
        CITY => 'Elblag',
        YEAR => 2011,
        DATE_START => '2011-02-18',
        DATE_END => '2011-02-20'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2011/_gpp/2012/01elblag/
        MEET_ORDINAL => 15,
        CITY => 'Elblag',
        YEAR => 2012,
        DATE_START => '2012-02-10',
        DATE_END => '2012-02-12'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/02elblag/wyniki/
        MEET_ORDINAL => 16,
        CITY => 'Elblag',
        YEAR => 2013,
        DATE_START => '2013-03-08',
        DATE_END => '2013-03-10'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/01elblag/
        MEET_ORDINAL => 17,
        CITY => 'Elblag',
        YEAR => 2014,
        DATE_START => '2014-01-24',
        DATE_END => '2014-01-26'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/02elblag/
        MEET_ORDINAL => 18,
        CITY => 'Elblag',
        YEAR => 2015,
        DATE_START => '2015-03-06',
        DATE_END => '2015-03-08'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/02elblag/
        MEET_ORDINAL => 19,
        CITY => 'Elblag',
        YEAR => 2016,
        DATE_START => '2016-03-04',
        DATE_END => '2016-03-06'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/02elblag/
        MEET_ORDINAL => 20,
        CITY => 'Elblag',
        YEAR => 2017,
        DATE_START => '2017-03-03',
        DATE_END => '2017-03-05'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/06elblag/
        MEET_ORDINAL => 21,
        CITY => 'Elblag',
        YEAR => 2018,
        DATE_START => '2018-03-01',
        DATE_END => '2018-03-04'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/elblag/
        MEET_ORDINAL => 22,
        CITY => 'Elblag',
        YEAR => 2019,
        DATE_START => '2019-03-07',
        DATE_END => '2019-03-10'
      },
      '2020' =>
      {
        # https://wyniki.pzbs.pl/2020/elblag/
        MEET_ORDINAL => 23,
        CITY => 'Elblag',
        YEAR => 2020,
        DATE_START => '2020-01-22',
        DATE_END => '2020-01-26'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/elblag/
        MEET_ORDINAL => 25,
        CITY => 'Krynica Morska',
        YEAR => 2022,
        DATE_START => '2022-10-06',
        DATE_END => '2022-10-09'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/elblag/
        MEET_ORDINAL => 26,
        CITY => 'Warlity Wielkie',
        YEAR => 2023,
        DATE_START => '2023-03-02',
        DATE_END => '2023-03-05'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/elblag/
        MEET_ORDINAL => 27,
        CITY => 'Warlity Wielkie',
        YEAR => 2024,
        DATE_START => '2024-02-29',
        DATE_END => '2024-03-03'
      },
    }
  },

);

my %TOURNAMENTS_POLAND =
(
  'Bermuda Triangle Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        ORDINAL => 6,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2007-04-21',
            DATE_END => '2007-04-21'
          },
          'C1' =>
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-22',
            DATE_END => '2007-04-22'
          },
          'C2' =>
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-22',
            DATE_END => '2007-04-22'
          }
        }
      },
    }
  },

  'bridge24.pl Trophy' =>
  {
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Palace Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-25',
            DATE_END => '2015-06-25'
          },
        }
      },
    }
  },

  'Forest Trophy' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SEGMENT',
            DATE_START => '2009-05-16',
            DATE_END => '2009-05-16'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-05-17',
            DATE_END => '2009-05-17'
          },
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
          },
        }
      },
    }
  },

  'Grand Prix of Poland Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    # Overviews of annual GPPP tournaments:
    # 6th, 2005: https://stara.pzbs.pl/komunikaty/r2005/reg_gppp2005.htm
    # 7th, 2006: https://stara.pzbs.pl/komunikaty/r2006/reg_gppp2006.htm
    # 8th, 2007: https://stara.pzbs.pl/komunikaty/r2007/reg_gppp2007.htm
    # 9th, 2008: https://stara.pzbs.pl/komunikaty/r2008/gppp2008.htm
    # 10th, 2009: https://stara.pzbs.pl/komunikaty/r2009/gppp2009.html
    # 11th, 2010: https://stara.pzbs.pl/komunikaty/r2010/gppp2010reg.html
    # 12th, 2011: https://www.pzbs.pl/archiwum/regulaminy2011/598-budimex-gpp-2011-regulamin
    # 13th, 2012: https://www.pzbs.pl/archiwum/regulaminy2012/1162-budimex-grand-prix-polski-par-2012
    # 14th, 2013: https://www.pzbs.pl/archiwum/2013/1593-budimex-14-grand-prix-polski-par-2013
    # 15th, 2014: https://www.pzbs.pl/archiwum/2014/2268-15-budimex-grand-prix-polski-par-komunikat-2014
    # 16th, 2015: https://www.pzbs.pl/archiwum/regulaminy-2015/2596-komunikat-budimex-grand-prix-polski-par-2015
    # 17th, 2016: https://www.pzbs.pl/archiwum/regulainy-2016/3030-17-budimex-grand-prix-polski-par-komunikat-2016
    # 19th, 2017/18: https://www.pzbs.pl/archiwum/regulaminy-2018/3905-grand-prix-polski-par-2017-18
    # 21th, 2019/21: https://www.pzbs.pl/archiwum/regulaminy-2021/5301-grand-prix-polski-par-2019-20-komunikat
    # 22nd, 2022: https://www.pzbs.pl/archiwum/2022/6792-grand-prix-polski-par-2022-komunikat
    # 23rd, 2023: https://www.pzbs.pl/2023/7411-grand-prix-polski-par-2023-komunikat

    EDITIONS =>
    {
      '2005' =>
      {
        # https://stara.pzbs.pl/komunikaty/r2005/reg_gppt2005.htm
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2005',
        SPONSOR => 'Powszechna Kasa Oszczędności Bank Polski',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Round-robin',
            DATE_START => '2005-09-06',
            DATE_END => '2005-09-06'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            DATE_START => '2005-09-06',
            DATE_END => '2005-09-06'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            DATE_START => '2005-09-06',
            DATE_END => '2005-09-06'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2006',
        SPONSOR => 'Prokom',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-12-15',
            DATE_END => '2006-12-17'
          } 
        }
      },
      '2007A' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2007A',
        CHAPTERS =>
        {
          # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/05lodz/3/3.html
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-15',
            DATE_END => '2007-04-15'
          } 
        }
      },
      '2007B' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2007B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-12-14',
            DATE_END => '2007-12-16'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2008',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-12-19',
            DATE_END => '2008-12-21'
          } 
        }
      },
      '2009A' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2009A',
        ORDINAL => 13,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-03-08',
            DATE_END => '2009-03-08'
          } 
        }
      },
      '2009B' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-13',
            DATE_END => '2009-06-13'
          } 
        }
      },
      '2009C' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-09-20',
            DATE_END => '2009-09-20'
          } 
        }
      },
      '2009D' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/gpp/gppp2009final/www/el.html
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2009B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-18'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-20'
          },
        }
      },
      '2010A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-02-20',
            DATE_END => '2010-02-20'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2010A',
        CHAPTERS =>
        {
          # https://michzimny.pl/bridge/2010/pila/W-gp.html
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-03-06',
            DATE_END => '2010-03-07'
          } 
        }
      },
      '2010C' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2010',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-06-03',
            DATE_END => '2010-06-03'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-06-04',
            DATE_END => '2010-06-04'
          },
          'C2' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-06-05',
            DATE_END => '2010-06-05'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-06',
            DATE_END => '2010-06-06'
          },
        }
      },
      '2010D' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SEGMENT',
            DATE_START => '2010-10-03',
            DATE_END => '2010-10-03'
          } 
        }
      },
      '2010E' =>
      {
        # https://wyniki.pzbs.pl/2010/_gpp/final/f.html
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2010B',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-19'
          } 
        }
      },
      '2011A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2011',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-02-20',
            DATE_END => '2011-02-20'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Boleslawiec Festival',
        SPONSOR => 'Budimex',
        MEET_TAG => '2011',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-09-18',
            DATE_END => '2011-09-18'
          } 
        }
      },
      '2011C' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2011',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-18'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            MOVEMENT => 'Barometer',
            major => 'ROUND',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-10'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          } 
        }
      },
      '2012C' =>
      {
        MEET => 'Krakow Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-03-25',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2012D' =>
      {
        MEET => 'Wroclaw Meeting',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          } 
        }
      },
      '2012E' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2012',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-03',
            DATE_END => '2012-06-03'
          } 
        }
      },
      '2012F' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2012A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-16'
          } 
        }
      },
      '2012G' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-09-23',
            DATE_END => '2012-09-23'
          } 
        }
      },
      '2012H' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-16'
          },
        }
      },
      '2012I' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2012C',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-17',
            DATE_END => '2012-12-18'
          } 
        }
      },
      '2013A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-03-10',
            DATE_END => '2013-03-10'
          } 
        }
      },
      '2013B' =>
      {
        MEET => 'Krakow Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-24'
          } 
        }
      },
      '2013C' =>
      {
        MEET => 'Wroclaw Meeting',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-05-26',
            DATE_END => '2013-05-26'
          } 
        }
      },
      '2013D' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2013',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-06-02',
            DATE_END => '2013-06-02'
          } 
        }
      },
      '2013E' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-07-07',
            DATE_END => '2013-07-07'
          } 
        }
      },
      '2013F' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-07-21',
            DATE_END => '2013-07-21'
          } 
        }
      },
      '2013G' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          } 
        }
      },
      '2013H' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2013A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-11-24',
            DATE_END => '2013-11-24'
          } 
        }
      },
      '2013I' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2013B',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2013-12-13',
            DATE_END => '2013-12-15'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-01-26',
            DATE_END => '2014-01-26'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-03-16',
            DATE_END => '2014-03-16'
          } 
        }
      },
      '2014C' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/04krakow/W-gpp2014.html
        MEET => 'Krakow Congress',
        MEET_TAG => '2014',
        PERSON => 'Andrzej Wilkosz',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-03-30',
            DATE_END => '2014-03-30'
          } 
        }
      },
      '2014D' =>
      {
        MEET => 'Wroclaw Meeting',
        MEET_TAG => '2014',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-25',
            DATE_END => '2014-05-25'
          } 
        }
      },
      '2014E' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-07-06',
            DATE_END => '2014-07-06'
          } 
        }
      },
      '2014F' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-07-20',
            DATE_END => '2014-07-20'
          } 
        }
      },
      '2014G' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-09-28',
            DATE_END => '2014-09-28'
          } 
        }
      },
      '2014H' =>
      {
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2014',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2014-12-19',
            DATE_END => '2014-12-21'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Beskids Slam',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-02-14',
            DATE_END => '2015-02-14'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Krakow Congress',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-03-22',
            DATE_END => '2015-03-22'
          } 
        }
      },
      '2015C' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-28'
          } 
        }
      },
      '2015D' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-09-20',
            DATE_END => '2015-09-20'
          } 
        }
      },
      '2015E' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/fin/15gppfin2.html
        MEET => 'Polish Grand Prix Pairs Legs',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-12-11',
            DATE_END => '2015-12-13'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'Beskids Slam',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-20'
          } 
        }
      },
      '2016B' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2016-05-15',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2016C' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-05-29',
            DATE_END => '2016-05-29'
          } 
        }
      },
    }
  },

  'Grand Prix of Poland Teams',
  {
    # Overviews of annual GPPT tournaments:
    # 2013: https://www.pzbs.pl/archiwum/2013/1791-regulamin-grand-prix-polski-teamow-2013
    # 2014: https://www.pzbs.pl/archiwum/2014/2265-komunikat-grand-prix-polski-teamow-jako-mistrzostwa-polski-teamow
    # 2015: https://www.pzbs.pl/archiwum/regulaminy-2015/2866-komunikat-organizacyjny-mistrzostw-polski-teamow-2015
    # 2016: https://www.pzbs.pl/archiwum/regulainy-2016/3031-komunikat-organizacyjny-29-mistrzostw-polski-teamow-grand-prix-polski-teamow-2016
    # 2017: https://www.pzbs.pl/archiwum/regulaminy-2017/3544-grand-prix-polski-teamow-2017-komunikat-organizacyjny
    # 2017-18: https://www.pzbs.pl/archiwum/regulaminy-2018/3904-grand-prix-polski-teamow-2017-18
    # 2019-21: https://www.pzbs.pl/archiwum/regulaminy-2021/5302-grand-prix-polski-teamow-2019-20-komunikat
    # 2022: https://www.pzbs.pl/archiwum/2022/6793-grand-prix-polski-teamow-2022-komunikat
    # 2023: https://www.pzbs.pl/2023/7413-grand-prix-polski-teamow-2023-komunikat
    # 2024: https://www.pzbs.pl/nowosci/8266-2024-02-15-12-20-59

    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009A' =>
      {
        MEET => 'Polish Grand Prix Teams Legs',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-03-08',
            DATE_END => '2009-03-08'
          } 
        }
      },
      '2009B' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-13',
            DATE_END => '2009-06-13'
          } 
        }
      },
      '2009C' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-07-21',
            DATE_END => '2009-07-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-07-22',
            DATE_END => '2009-07-22'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-22',
            DATE_END => '2009-07-22'
          } 
        }
      },
      '2009D' =>
      {
        MEET => 'Warsaw Grand Prix',
        MEET_TAG => '2009',
        SPONSOR => 'Prestige Development',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-08-29',
            DATE_END => '2009-08-29'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-30',
            DATE_END => '2009-08-30'
          },
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
            major => 'SEGMENT',
            DATE_START => '2011-07-10',
            DATE_END => '2011-07-10'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Krakow Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
        }
      },
      '2012B' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-07-08',
            DATE_END => '2012-07-08'
          } 
        }
      },
      '2013A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            DATE_START => '2013-03-08',
            DATE_END => '2013-03-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-03-08',
            DATE_END => '2013-03-09'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-03-09',
            DATE_END => '2013-03-09'
          } 
        }
      },
      '2013B' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
      '2013C' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-07-08',
            DATE_END => '2013-07-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'MATCH',
            DATE_START => '2013-07-09',
            DATE_END => '2013-07-09'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'MATCH',
            DATE_START => '2013-07-09',
            DATE_END => '2013-07-09'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'MATCH',
            DATE_START => '2013-07-09',
            DATE_END => '2013-07-09'
          },
        }
      },
      '2013D' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Rof32',
            major => 'SEGMENT',
            DATE_START => '2013-07-22',
            DATE_END => '2013-07-22'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2013-07-23',
            DATE_END => '2013-07-23'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-24',
            DATE_END => '2013-07-24'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-07-25',
            DATE_END => '2013-07-25'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-07-26',
            DATE_END => '2013-07-26'
          } 
        }
      },
      '2013E' =>
      {
        MEET => 'Boleslawiec Festival',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          } 
        }
      },
      '2013F' =>
      {
        MEET => 'Polish Grand Prix Teams Legs',
        MEET_TAG => '2013',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-12-19',
            DATE_END => '2013-12-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-20'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-21',
            DATE_END => '2013-12-21'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-15'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-14',
            DATE_END => '2014-03-15'
          } 
        }
      },
      '2014B' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/07wroclaw/t/fleaderb.html?1401096198
        MEET => 'Wroclaw Meeting',
        MEET_TAG => '2014',
        CLUB => 'Ruch AZS',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-24',
            DATE_END => '2014-05-24'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Krakow Congress',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-03-21',
            DATE_END => '2015-03-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-21',
            DATE_END => '2015-03-21'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2015',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-03-29',
            DATE_END => '2015-03-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-03-29',
            DATE_END => '2015-03-29'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT',
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-06'
          } 
        }
      },
      '2016B' =>
      {
        MEET => 'Luczniczka Meeting',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-14',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2016C' =>
      {
        MEET => 'Poznan Congress',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-28'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-28',
            DATE_END => '2016-05-28'
          } 
        }
      },
      '2016D' =>
      {
        MEET => 'Polish Grand Prix Teams Legs',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'MATCH',
            DATE_START => '2016-06-17',
            DATE_END => '2016-06-18'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-18'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-06-18',
            DATE_END => '2016-06-18'
          },
        }
      },
      '2016E' =>
      {
        # https://wyniki.pzbs.pl/2016/baltycki/
        MEET => 'Baltic Congress',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-07-26',
            DATE_END => '2016-07-26'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-07-26',
            DATE_END => '2016-07-26'
          } 
        }
      },
    }
  },

  'Janina Wielkoszewska Memorial Open',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/wielkoszewska2009/TT-08-11/index.html
        ORDINAL => 19,
        CITY => 'Stargard',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-08',
            DATE_END => '2009-11-08'
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
            major => 'ROUND',
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
            major => 'SEGMENT',
            DATE_START => '2012-08-28',
            DATE_END => '2012-08-28'
          } 
        }
      },
    }
  },

  'Józef Pochron Jubilee Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/mppimp/W-impa.html
        MEET => 'Polish Championships',
        MEET_TAG => '2014B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-22'
          } 
        }
      },
    }
  },

  'Krakow Spring Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
          },
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
            major => 'ROUND',
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-02'
          } 
        }
      },
    }
  },

  'Leszek Kwiatkowski Memorial Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-05-03',
            DATE_END => '2011-05-03'
          } 
        }
      },
    }
  },

  'Mondi Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-04-05',
            DATE_END => '2009-04-05'
          },
        }
      },
    }
  },

  'MTP Cup' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-02',
            DATE_END => '2011-05-02'
          },
        }
      },
    }
  },

  'Palace Pairs Cup' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Palace Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-08-27',
            DATE_END => '2014-08-29'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Palace Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-06-22',
            DATE_END => '2015-06-23'
          },
        }
      },
    }
  },

  'Palace Teams Cup' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Palace Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-06-24',
            DATE_END => '2015-06-24'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-25',
            DATE_END => '2015-06-25'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-25',
            DATE_END => '2015-06-25'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Palace Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-04-01',
            DATE_END => '2016-04-01'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-04-02',
            DATE_END => '2016-04-02'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-02',
            DATE_END => '2016-04-03'
          },
        }
      },
    }
  },

  'Plock District League' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Plock',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
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
            DATE_START => '2015-05-09',
            DATE_END => '2015-05-09'
          },
        }
      },
    }
  },

  'Polish BAM Cup',
  {
    FORM => 'Teams',
    SCORING => 'BAM',
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
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-05-26',
            DATE_END => '2007-05-26'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-26',
            DATE_END => '2007-05-26'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          } 
        }
      },
    }
  },

  'Polish BAM Teams',
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Slawa Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-07-11',
            DATE_END => '2014-07-11'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-07-12',
            DATE_END => '2014-07-12'
          } 
        }
      },
    }
  },

  'Polish Boys Championship',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U18', # Unclear

    EDITIONS =>
    {
      '2013' =>
      {
        # https://www.pzbs.pl/wyniki-mlodziezowe
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-04-11',
            DATE_END => '2013-04-12'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-14'
          } 
        }
      },
    }
  },

  'Polish Business League',
  {
    ORGANIZATION => 'Bridge Academy Poland',
    COUNTRY => 'Poland',
    CITY => 'Warsaw',
    ORIGIN => 'Corporate',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014-15' =>
      {
        # http://akademiabrydza.pl/blb/kontakt
        # Only on Wayback Machine
        CHAPTERS =>
        {
          'C00' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-10-22',
            DATE_END => '2014-10-22'
          },
          'C01' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-29'
          },
          'C02' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-11-05',
            DATE_END => '2014-11-05'
          },
          'C03' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-11-12',
            DATE_END => '2014-11-12'
          },
          'C04' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-11-19',
            DATE_END => '2014-11-19'
          },
          'C05' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-11-26',
            DATE_END => '2014-11-26'
          },
          'C06' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-12-03',
            DATE_END => '2014-12-03'
          },
          'C07' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-10'
          },
          'C08' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-12-17',
            DATE_END => '2014-12-17'
          },
          'C09' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-07',
            DATE_END => '2015-01-07'
          },
          'C10' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-14',
            DATE_END => '2015-01-14'
          },
        }
      },
    }
  },

  'Polish Business Pairs',
  {
    ORGANIZATION => 'Bridge Academy Poland',
    COUNTRY => 'Poland',
    CITY => 'Warsaw',
    ORIGIN => 'Corporate',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # http://akademiabrydza.pl/blb/kontakt
        # Only on Wayback Machine
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-11-17',
            DATE_END => '2014-11-17'
          } 
        }
      },
    }
  },

  'Polish Girls Championship',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U18', # Unclear

    EDITIONS =>
    {
      '2013' =>
      {
        # https://www.pzbs.pl/wyniki-mlodziezowe
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-04-11',
            DATE_END => '2013-04-14'
          } 
        }
      },
    }
  },

  'Polish Girls Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Wroclaw Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-05-09',
            DATE_END => '2009-05-10'
          } 
        }
      },
    }
  },

  'Polish IMP Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2009/W-cz1.html
        MEET => 'Poznan Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Poznan Congress',
        SPONSOR => 'Budimex',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-01',
            DATE_END => '2011-05-01'
          } 
        }
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/mppimp/W-impfin.html
        MEET => 'Polish Championships',
        MEET_TAG => '2013B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SESSION',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2014B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/kjb/
        MEET => 'Polish Championships',
        MEET_TAG => '2015B',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          } 
        }
      },
    }
  },

  'Polish Individual Championship',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # http://www.branka.pl/wengorz/TOP/top.html
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2010-03-27',
            DATE_END => '2010-03-27'
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
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-22',
            DATE_END => '2011-01-22'
          } 
        }
      },
      '2012' =>
      {
        # http://wengorz.waw.pl/top2012/
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-03-30',
            DATE_END => '2012-03-30'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-03-31',
            DATE_END => '2012-04-01'
          } 
        }
      },
      '2013A' =>
      {
        # https://wyniki.pzbs.pl/2013/topi/W-topif.html
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-12',
            DATE_END => '2013-04-13'
          } 
        }
      },
      '2013B' =>
      {
        # https://michzimny.pl/bridge/2013/indmp/
        CITY => 'Tarnów',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'SEGMENT',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-19'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-20'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-20'
          }
        }
      },
    }
  },

  'Polish Junior Pairs Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-04-09',
            DATE_END => '2012-04-12'
          } 
        }
      },
    }
  },

  'Polish Mixed Pairs',
  {
    FORM => 'Pairs',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Poznan Congress',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-06-11',
            DATE_END => '2009-06-11'
          },
        }
      },
      '2011A' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb2m.html
        MEET => 'Poznan Congress',
        MEET_TAG => '2011',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
          } 
        }
      },
      '2011B' =>
      {
        # http://www.kongres-slawa.pl/2011/k4.html
        MEET => 'Slawa Congress',
        MEET_TAG => '2011',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-09',
            DATE_END => '2011-07-09'
          } 
        }
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/mmm/W-mxt.html
        MEET => 'Polish Championships',
        MEET_TAG => '2012B',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-01',
            DATE_END => '2012-05-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2013A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-29',
            DATE_END => '2013-04-29'
          } 
        }
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/mpp/W-mxtf.html
        MEET => 'Polish Championships',
        MEET_TAG => '2014A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-01',
            DATE_END => '2014-05-02'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/mpp/W-mxtf.html
        MEET => 'Polish Championships',
        MEET_TAG => '2015A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-04-30',
            DATE_END => '2015-05-01'
          } 
        }
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-openf2.html
        MEET => 'Polish Championships',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-04-30',
            DATE_END => '2016-05-01'
          } 
        }
      },
    }
  },

  'Polish Mixed Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/H500Mixt/final/t/HTleaderb.html
        CITY => 'Zegrze',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-04-27',
            DATE_END => '2007-04-29'
          } 
        }
      },
    }
  },

  'Polish Open Pairs',
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Polish Pairs Championship',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-05-07',
            DATE_END => '2006-05-07'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Polish Championships',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
          } 
        }
      },
      '2009' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2009/W-cz1.html
        MEET => 'Poznan Congress',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-11',
            DATE_END => '2009-06-11'
          },
          'C1' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Barometer',
            major => 'ROUND',
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-12'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Zulawski Congress',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-02-21',
            DATE_END => '2010-02-21'
          } 
        }
      },
      '2011A' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb1.html
        MEET => 'Poznan Congress',
        MEET_TAG => '2011',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2011',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-15'
          } 
        }
      },
      '2011C' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2011',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-12',
            DATE_END => '2011-07-12'
          } 
        }
      },
      '2011D' =>
      {
        MEET => 'Slawa Congress',
        MEET_TAG => '2011',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-07-14',
            DATE_END => '2011-07-15'
          } 
        }
      },
      '2012A' =>
      {
        # http://wengorz.waw.pl/top2012/
        MEET => 'Polish Championships',
        MEET_TAG => '2012A',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-03-29',
            DATE_END => '2012-03-29'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-03-30',
            DATE_END => '2012-03-30'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Polish Pairs Championship',
        MEET_TAG => '2012',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-05',
            DATE_END => '2012-05-06'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2013A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-03',
            DATE_END => '2013-05-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2014A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-03',
            DATE_END => '2014-05-04'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/mpp/W-mxtf.html
        MEET => 'Polish Championships',
        MEET_TAG => '2015A',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-03'
          } 
        }
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-openf2.html
        MEET => 'Polish Championships',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-02',
            DATE_END => '2016-05-03'
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
      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/09poznan/teamy/TTleaderb.html
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-06-10',
            DATE_END => '2007-06-10'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-10',
            DATE_END => '2007-06-11'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-14',
            DATE_END => '2009-06-14'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          }
        }
      },
      '2010B' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-07-19',
            DATE_END => '2010-07-20'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-20',
            DATE_END => '2010-07-20'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-07-20',
            DATE_END => '2010-07-21'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-07-21',
            DATE_END => '2010-07-21'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-02',
            DATE_END => '2012-05-02'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-05-03',
            DATE_END => '2012-05-03'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-03',
            DATE_END => '2012-05-03'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-04',
            DATE_END => '2012-05-04'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-04',
            DATE_END => '2012-05-05'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Baltic Congress',
        MEET_TAG => '2012',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-07-30',
            DATE_END => '2012-07-30'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2013A',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-04-30',
            DATE_END => '2013-04-30'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-04-30',
            DATE_END => '2013-05-01'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-01',
            DATE_END => '2013-05-01'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-02',
            DATE_END => '2013-05-02'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-02',
            DATE_END => '2013-05-03'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-25'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-25'
          } 
        }
      },
      '2014B' =>
      {
        CHAPTERS =>
        {
          # https://wyniki.pzbs.pl/2014/_gpp/teamfin/14gptfrunda2.html
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2014-12-12',
            DATE_END => '2014-12-12'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Zulawski Congress',
        MEET_TAG => '2015',
        CLUB => 'Ruch AZS',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-06'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-07'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-07'
          } 
        }
      },
      '2015B' =>
      {
        CHAPTERS =>
        {
          # https://wyniki.pzbs.pl/2015/_gpp/team/15gptofrunda1.html
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-12-17',
            DATE_END => '2015-12-18'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-19'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-19',
            DATE_END => '2015-12-19'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          # https://wyniki.pzbs.pl/2016/kwb/
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-12'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-12'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-12'
          },
        }
      }
    }
  },

  'Polish Open Trials',
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
        # 'Luczniczka Meeting', but don't want to find the others...
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-28'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SEGMENT',
            DATE_START => '2005-05-28',
            DATE_END => '2005-05-31'
          } 
        }
      },
      '2007A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-01-23',
            DATE_END => '2007-01-23'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          },
          'C4' => 
          {
            YEAR => 2007,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          },
          'C5' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          },
          'C6' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          },
          'C7' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
          } 
        }
      },
      '2007B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            DATE_START => '2007-08-05',
            DATE_END => '2007-08-08'
          },
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
            DATE_START => '2008-01-27',
            DATE_END => '2008-01-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-27',
            DATE_END => '2008-01-27'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C4' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-05-03',
            DATE_END => '2008-05-03'
          },
          'C5' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-16',
            DATE_END => '2014-01-17'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-17',
            DATE_END => '2014-01-19'
          },
          'C2' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-02-21',
            DATE_END => '2014-02-22'
          } 
        }
      },
    }
  },

  'Polish Pairs Cup',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-02'
          } 
        }
      },
    }
  },

  'Polish Patton Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-27'
          },
        }
      },
    }
  },

  'Polish Patton Teams',
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-19'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-19'
          },
        }
      },
      '2010' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyniki2010/471-19-boleslawiecka-trzydniowka-wyniki
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-10-02',
            DATE_END => '2010-10-02'
          } 
        }
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/110916boles/program.htm
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-09-17',
            DATE_END => '2011-09-17'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-09-22',
            DATE_END => '2012-09-22'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-05'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-09-26',
            DATE_END => '2014-09-27'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/14boleslawiec/program.htm
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2015-09-18',
            DATE_END => '2015-09-19'
          } 
        }
      },
    }
  },

  'Polish Premier League',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2002-03' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2003,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2003-05-27',
            DATE_END => '2003-05-27'
          },
          'C1' => 
          {
            YEAR => 2003,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2003-05-28',
            DATE_END => '2003-05-28'
          },
        }
      },
      '2003-04' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-05-02',
            DATE_END => '2004-05-02'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-05-03',
            DATE_END => '2004-05-03'
          },
        }
      },
      '2004-05' =>
      {
        CHAPTERS =>
        {
          # Dates probably more like May.
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-23',
            DATE_END => '2005-09-23'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-24',
            DATE_END => '2005-09-24'
          },
        }
      },
      '2005-06' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-06',
            DATE_END => '2006-05-06'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-07',
            DATE_END => '2006-05-07'
          },
        }
      },
      '2006-07' =>
      {
        # https://stara.pzbs.pl/liga/liga2006_7/pierwsza/1liga20067.htm
        CHAPTERS =>
        {
          'C0' => 
          {
            # Different tournament? Different dates?
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-07',
            DATE_END => '2007-03-07'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-06-06',
            DATE_END => '2007-06-07'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-06-07',
            DATE_END => '2007-06-08'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2007-06-07',
            DATE_END => '2007-06-08'
          },
        }
      },
      '2007-08' =>
      {
        # https://stara.pzbs.pl/liga/liga2007_8/pierwsza/1liga20078.htm
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
          },
        }
      },
      '2008-09' =>
      {
        # https://stara.pzbs.pl/liga/liga2008_9/pierwsza20089/pierwsza20089liga.html

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-14',
            DATE_END => '2009-05-16'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-14',
            DATE_END => '2009-05-16'
          },
        }
      },
      '2009-10' =>
      {
        # https://www.pzbs.pl/ligi-all/93
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-05-01',
            DATE_END => '2010-05-02'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-03'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2010-05-02',
            DATE_END => '2010-05-03'
          },
        }
      },
      '2010-11' =>
      {
        # https://www.pzbs.pl/ligi-all/92?start=20
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-10-22',
            DATE_END => '2010-10-24'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-01-07',
            DATE_END => '2011-01-09'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-02-26',
            DATE_END => '2011-02-27'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-03-04',
            DATE_END => '2011-03-05'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Playoff',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-03-12',
            DATE_END => '2011-03-13'
          },
          'C5' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
          },
          'C6' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-05-19',
            DATE_END => '2011-05-20'
          },
          'C7' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-20',
            DATE_END => '2011-05-21'
          },
        }
      },
      '2011-12' =>
      {
        # https://www.pzbs.pl/ligi-all/84/1219
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-10-07',
            DATE_END => '2011-10-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-01-13',
            DATE_END => '2012-01-15'
          },
          'C2' => 
          {
            YEAR => 2012,
            minor => 'SEGMENT',
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-03'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-09',
            DATE_END => '2012-05-09'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-10',
            DATE_END => '2012-05-11'
          },
          'C6' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-11',
            DATE_END => '2012-05-12'
          }
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-10-05',
            DATE_END => '2012-10-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-01-04',
            DATE_END => '2013-01-06'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-03-09',
            DATE_END => '2013-03-10'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-05'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-16',
            DATE_END => '2013-05-17'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-17',
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-10-11',
            DATE_END => '2013-10-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-01-03',
            DATE_END => '2014-01-05'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          },
          'C3' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-04-11',
            DATE_END => '2014-04-12'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-06-12',
            DATE_END => '2014-06-13'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-06-13',
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-10-03',
            DATE_END => '2014-10-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-01-02',
            DATE_END => '2015-01-04'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-02-07',
            DATE_END => '2015-02-08'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-21'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-04-18',
            DATE_END => '2015-04-19'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-06-17',
            DATE_END => '2015-06-17'
          },
          'C6' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-17',
            DATE_END => '2015-06-19'
          },
          'C7' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-19',
            DATE_END => '2015-06-20'
          },
          'C8' => 
          {
            YEAR => 2015,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2015-07-11',
            DATE_END => '2015-07-12'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-10-16',
            DATE_END => '2015-10-18'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
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

  'Polish School Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Polish School Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-06-07',
            DATE_END => '2012-06-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-08'
          },
        }
      },
    }
  },

  'Polish School Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Polish School Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Elimination',
            major => 'SEGMENT',
            DATE_START => '2010-06-12',
            DATE_END => '2010-06-12'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-13',
            DATE_END => '2010-06-13'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Polish School Championship',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'MATCH',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-08'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-08',
            DATE_END => '2012-06-08'
          },
        }
      },
    }
  },

  'Polish Second League',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
          } 
        }
      },
    }
  },

  'Polish Senior Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      # https://wyniki.pzbs.pl/2014/mpps/W-senfin.html
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-02-15',
            DATE_END => '2014-02-16'
          } 
        }
      },
    }
  },

  'Polish Third League',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        REGION => 'Pomerania',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-28',
            DATE_END => '2015-02-28'
          },
        }
      },
    }
  },

  'Polish U16 Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-18'
          } 
        }
      },
    }
  },

  'Polish U16 Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U16',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-20'
          } 
        }
      },
    }
  },

  'Polish U20 Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U20',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-12',
            DATE_END => '2014-04-13'
          } 
        }
      },
    }
  },

  'Polish U25 Trials',
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U25',

    EDITIONS =>
    {
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-u25.html
        MEET => 'Polish Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-01',
            DATE_END => '2016-05-02'
          } 
        }
      },
    }
  },

  'Polish Women Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Polish Championships',
        MEET_TAG => '2014A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-03'
          } 
        }
      },
    }
  },

  'Polish Women Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      # Guessing that 2004 and 2006 were also at this meet.
      '2004' =>
      {
        MEET => 'Luczniczka Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-28'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Luczniczka Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SEGMENT',
            DATE_START => '2006-04-05',
            DATE_END => '2006-04-09'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Luczniczka Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-04-27',
            DATE_END => '2012-04-29'
          } 
        }
      },
    }
  },

  'Pomerania Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SEGMENT',
            DATE_START => '2009-12-03',
            DATE_END => '2009-12-03'
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
            DATE_START => '2010-10-09',
            DATE_END => '2010-10-09'
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
            DATE_START => '2011-10-06',
            DATE_END => '2011-10-06'
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
            major => 'SEGMENT',
            DATE_START => '2013-12-07',
            DATE_END => '2013-12-07'
          } 
        }
      },
      '2014' =>
      {
        CITY => 'Gdansk',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-10-26',
            DATE_END => '2014-10-26'
          } 
        }
      },
    }
  },

  'Sigismund Bell Krakow',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Krakow Congress',
        ORDINAL => 3,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-03-29',
            DATE_END => '2014-03-29'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-03-29',
            DATE_END => '2014-03-29'
          } 
        }
      },
    }
  },

  'SPS Trophy',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # http://www.czaja.pzbs.pl/wyniki/2014/sps/W-loj2.html
        CITY => 'Lojdy',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-05-16',
            DATE_END => '2014-05-17'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2014-05-16',
            DATE_END => '2014-05-17'
          } 
        }
      },
      '2015' =>
      {
        # http://czaja.pzbs.pl/wyniki/2015/sps/15lojdy.html
        CITY => 'Lojdy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-15',
            DATE_END => '2015-05-16'
          } 
        }
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/sps/W-spscup.html
        CITY => 'Lojdy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-06-03',
            DATE_END => '2016-06-04'
          } 
        }
      },
    }
  },

  'Staszek Wybranowski Memorial',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb2.html
        ORDINAL => 8,
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
          } 
        }
      },
    }
  },

  'Warsaw Online Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # https://wyniki.pzbs.pl/2013/130530zlot/W-13zlotmax1.html
      '2013' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
    }
  },

  'Wronie Summer Teams',
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
        CITY => 'Wronie',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-14'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-14',
            DATE_END => '2010-08-14'
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
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-04'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-05'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-05'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-05',
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
