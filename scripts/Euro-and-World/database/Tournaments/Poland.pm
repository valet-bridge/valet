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

my %MEETS_POLAND =
(
  'Baltic Congress' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2010' =>
      {
        # https://bridge.gda.pl/kongres/10/k_baltycki10.htm
        ORDINAL => 50,
        YEAR => 2010,
        CITY => 'Sopot',
        DATE_START => '2010-07-14',
        DATE_END => '2010-07-25'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/baltycki/
        ORDINAL => 51,
        YEAR => 2011,
        CITY => 'Sopot',
        DATE_START => '2011-07-21',
        DATE_END => '2011-07-31'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/baltycki/
        ORDINAL => 52,
        YEAR => 2012,
        CITY => 'Sopot',
        DATE_START => '2012-07-26',
        DATE_END => '2012-08-05'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/baltycki/
        ORDINAL => 53,
        YEAR => 2013,
        CITY => 'Sopot',
        DATE_START => '2013-07-19',
        DATE_END => '2013-07-27'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/baltycki/
        ORDINAL => 54,
        YEAR => 2014,
        CITY => 'Sopot',
        DATE_START => '2014-07-18',
        DATE_END => '2014-07-26'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/baltycki/
        ORDINAL => 55,
        YEAR => 2015,
        CITY => 'Sopot',
        DATE_START => '2015-07-17',
        DATE_END => '2015-07-25'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/baltycki/
        ORDINAL => 56,
        YEAR => 2016,
        CITY => 'Sopot',
        DATE_START => '2016-07-22',
        DATE_END => '2016-07-30'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/baltycki/
        ORDINAL => 57,
        YEAR => 2017,
        CITY => 'Sopot',
        DATE_START => '2017-08-04',
        DATE_END => '2017-08-12'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/baltycki/
        ORDINAL => 58,
        YEAR => 2018,
        CITY => 'Sopot',
        DATE_START => '2018-08-03',
        DATE_END => '2018-08-11'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/baltycki/
        ORDINAL => 59,
        YEAR => 2019,
        CITY => 'Sopot',
        DATE_START => '2019-08-02',
        DATE_END => '2019-08-10'
      },
      '2021' =>
      {
        # https://wyniki.pzbs.pl/2021/baltycki/
        ORDINAL => 60,
        YEAR => 2021,
        CITY => 'Sopot',
        DATE_START => '2021-08-06',
        DATE_END => '2021-08-14'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/baltycki/
        ORDINAL => 61,
        YEAR => 2022,
        CITY => 'Sopot',
        DATE_START => '2022-07-15',
        DATE_END => '2022-07-23'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/baltycki/
        ORDINAL => 62,
        YEAR => 2023,
        CITY => 'Sopot',
        DATE_START => '2023-07-28',
        DATE_END => '2023-08-03'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/baltycki/
        ORDINAL => 63,
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
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Szczyrk',
    ORIGIN => 'National',
    ZONE => 'Europe',

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
        ORDINAL => 1,
        YEAR => 2013,
        DATE_START => '2013-11-08',
        DATE_END => '2013-11-11'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/02szczyrk/W-14szgpp.html
        ORDINAL => 2,
        YEAR => 2014,
        DATE_START => '2014-02-03',
        DATE_END => '2014-02-08'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/01szczyrk/W-15szgpp.html
        ORDINAL => 3,
        YEAR => 2015,
        DATE_START => '2015-02-09',
        DATE_END => '2015-02-15'
      },
      '2016' =>
      {
        # https://www.pzbs.pl/wyniki/kadra/2016/jun/szlem.html
        ORDINAL => 4,
        YEAR => 2016,
        DATE_START => '2016-02-15',
        DATE_END => '2016-02-21'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/01szczyrk/szlem.html
        ORDINAL => 5,
        YEAR => 2017,
        DATE_START => '2017-02-06',
        DATE_END => '2017-02-12'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/01szczyrk/
        ORDINAL => 6,
        YEAR => 2018,
        DATE_START => '2018-02-02',
        DATE_END => '2018-02-04'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/szczyrk/
        ORDINAL => 7,
        YEAR => 2019,
        DATE_START => '2019-01-11',
        DATE_END => '2019-01-13'
      },
    }
  },

  'Boleslawiec Festival' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Boleslawiec',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2009' =>
      {
        # ?
        ORDINAL => 18,
        YEAR => 2009,
        DATE_START => '2009-09-18',
        DATE_END => '2009-09-20'
      },
      '2010' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyniki2010/471-19-boleslawiecka-trzydniowka-wyniki
        ORDINAL => 19,
        YEAR => 2010,
        DATE_START => '2010-10-01',
        DATE_END => '2010-10-03'
      },
      '2011' =>
      {
        # https://wyniki.pzbs.pl/2011/110916boles/program.htm
        ORDINAL => 20,
        YEAR => 2011,
        DATE_START => '2011-09-16',
        DATE_END => '2011-09-18'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/0920-boles/program.htm
        ORDINAL => 21,
        YEAR => 2012,
        DATE_START => '2012-09-21',
        DATE_END => '2012-09-23'
      },
      '2013' =>
      {
        # ?
        ORDINAL => 22,
        YEAR => 2013,
        DATE_START => '2013-10-04',
        DATE_END => '2013-10-06'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/13boles/program.htm
        ORDINAL => 23,
        YEAR => 2014,
        DATE_START => '2014-09-25',
        DATE_END => '2014-09-28'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/14boleslawiec/program.htm
        ORDINAL => 24,
        YEAR => 2015,
        DATE_START => '2015-09-17',
        DATE_END => '2015-09-20'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/15boles/program.htm
        ORDINAL => 25,
        YEAR => 2016,
        DATE_START => '2016-09-22',
        DATE_END => '2016-09-25'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/1718boles/program.htm
        ORDINAL => 26,
        YEAR => 2017,
        DATE_START => '2017-09-22',
        DATE_END => '2017-09-24'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp1819/boles/program.htm
        ORDINAL => 27,
        YEAR => 2018,
        DATE_START => '2018-09-20',
        DATE_END => '2018-09-23'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp1920/01boles/program.htm
        ORDINAL => 28,
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
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Krakow',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/gpp/05bydgoszcz/W-bydgpp.html
        ORDINAL => 49,
        YEAR => 2012,
        DATE_START => '2012-03-23', # Dates are a guess
        DATE_END => '2012-03-25'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/03krakow/13kwgpp.html
        YEAR => 2013,
        DATE_START => '2014-03-22', # Dates are a guess
        DATE_END => '2014-03-24'
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
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Bydgoszcz',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      # 2006: No date found:
      # https://stara.pzbs.pl/wyniki/2006/krajowe/gpp2006/06bydg/luczniczka2006.htm

      '2007' =>
      {
        # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/11Bydgoszcz/LUCZ/LUCZ.html
        ORDINAL => 44,
        YEAR => 2007,
        DATE_START => '2007-07-15', # Probably more days
        DATE_END => '2007-07-15'
      },
      '2009' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/gpp/07bydgoszcz/luczniczka2009.html
        ORDINAL => 46,
        YEAR => 2009,
        DATE_START => '2009-06-05',
        DATE_END => '2009-06-07'
      },
      '2010' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyniki2010/222-47-ogolnopolski-kongres-brydzowy-luczniczka-wyniki
        ORDINAL => 47,
        YEAR => 2010,
        DATE_START => '2010-06-26',
        DATE_END => '2010-06-28'
      },
      '2011' =>
      {
        # http://kpzbs.host4u.pl/wyniki/GP2011/Luczniczka/luczniczka.html
        ORDINAL => 48,
        YEAR => 2011,
        DATE_START => '2011-06-10',
        DATE_END => '2011-06-12'
      },
      '2012' =>
      {
        # https://wyniki.pzbs.pl/2012/gpp/05bydgoszcz/W-bydgpp.html
        ORDINAL => 49,
        YEAR => 2012,
        DATE_START => '2012-04-27', # Guess
        DATE_END => '2012-04-29'
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/_gpp/08bydgoszcz/gp.html
        ORDINAL => 50,
        YEAR => 2013,
        DATE_START => '2013-06-14',
        DATE_END => '2013-06-16'
      },
      '2014' =>
      {
        # http://www.kpzbs.host4u.pl/wyniki/2014/luczniczka/luczniczka2014.html
        ORDINAL => 51,
        YEAR => 2014,
        DATE_START => '2014-03-14',
        DATE_END => '2014-03-16'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/04bydgoszcz/
        ORDINAL => 52,
        YEAR => 2014,
        DATE_START => '2015-03-27',
        DATE_END => '2015-03-29'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/06bydgoszcz/
        ORDINAL => 53,
        YEAR => 2016,
        DATE_START => '2016-05-13',
        DATE_END => '2016-05-15'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/06bydgoszcz/
        ORDINAL => 54,
        YEAR => 2017,
        DATE_START => '2017-05-12',
        DATE_END => '2017-05-14'
      },
      '2018' =>
      {
        # http://kpzbs.host4u.pl/wyniki/2018/Luczniczka/Luczniczka2018.html
        ORDINAL => 55,
        YEAR => 2018,
        DATE_START => '2018-07-27',
        DATE_END => '2018-07-29'
      },
      '2019' =>
      {
        # http://kpzbs.host4u.pl/wyniki/2019/Luczniczka/Luczniczka2019.html
        ORDINAL => 56,
        YEAR => 2019,
        DATE_START => '2019-07-19',
        DATE_END => '2019-07-21'
      },
      '2023' =>
      {
        # http://kpzbs.host4u.pl/zaproszenia/2023/luczniczka59.html
        ORDINAL => 59,
        YEAR => 2023,
        DATE_START => '2023-04-14',
        DATE_END => '2023-04-16'
      },
      '2024' =>
      {
        # http://kpzbs.host4u.pl/zaproszenia/2024/luczniczka60.html
        ORDINAL => 60,
        YEAR => 2024,
        DATE_START => '2024-07-19',
        DATE_END => '2024-07-21'
      },
    }
  },

  'Polish Championships' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    CITY => 'Poznan',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2013-05-02', # Probably more days
        DATE_END => '2013-05-05'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-04-30',
        DATE_END => '2013-05-04'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-04-30',
        DATE_END => '2015-05-04'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-30',
        DATE_END => '2016-05-03'
      },
    }
  },

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
        # https://stara.pzbs.pl/wyniki/2006/arajowe/poznanski06/poznanski2006.htm
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
      '2007' =>
      {
        # No link
        ORDINAL => 50,
        YEAR => 2007,
        DATE_START => '2007-07-06',
        DATE_END => '2007-07-15'
      },
      '2008' =>
      {
        # No link
        ORDINAL => 51,
        YEAR => 2008,
        DATE_START => '2008-07-04',
        DATE_END => '2008-07-13'
      },
      '2009' =>
      {
        # No link
        ORDINAL => 52,
        YEAR => 2009,
        DATE_START => '2009-07-03',
        DATE_END => '2009-07-11'
      },
      '2010' =>
      {
        # https://wyniki.pzbs.pl/2010/slawa/
        ORDINAL => 53,
        YEAR => 2010,
        DATE_START => '2010-07-02',
        DATE_END => '2010-07-11'
      },
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

  'Wroclaw Meeting' =>
  {
    # Also "Blue Ribbon of the Oder"
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2008' =>
      {
        # Link on https://stara.pzbs.pl/imprezy/kal08.html
        ORDINAL => 29,
        CITY => 'Wroclaw',
        YEAR => 2008,
        DATE_START => '2008-05-09',
        DATE_END => '2008-05-11'
      },
      '2009' =>
      {
        # https://stara.pzbs.pl/imprezy/OTP/2009/bwodry2009.html
        ORDINAL => 30,
        CITY => 'Wroclaw',
        YEAR => 2009,
        DATE_START => '2009-05-08',
        DATE_END => '2009-05-10'
      },
      '2010' =>
      {
        # https://michzimny.pl/bridge/2010/wroclaw/
        ORDINAL => 31,
        CITY => 'Wroclaw',
        YEAR => 2010,
        DATE_START => '2010-05-07',
        DATE_END => '2010-05-09'
      },
      '2011' =>
      {
        # https://michzimny.pl/bridge/2011/wroclaw/
        ORDINAL => 32,
        CITY => 'Wroclaw',
        YEAR => 2011,
        DATE_START => '2011-05-06',
        DATE_END => '2011-05-08'
      },
      '2012' =>
      {
        # https://michzimny.pl/bridge/2012/wroclaw/
        ORDINAL => 33,
        CITY => 'Wroclaw',
        YEAR => 2012,
        DATE_START => '2012-05-25',
        DATE_END => '2012-05-27'
      },
      '2013' =>
      {
        # https://michzimny.pl/bridge/2013/wroclaw/
        ORDINAL => 34,
        CITY => 'Wroclaw',
        YEAR => 2013,
        DATE_START => '2013-05-24',
        DATE_END => '2013-05-26'
      },
      '2014' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/07wroclaw/
        ORDINAL => 35,
        CITY => 'Wroclaw',
        YEAR => 2015,
        DATE_START => '2014-05-23',
        DATE_END => '2014-05-25'
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/07wroclaw/
        ORDINAL => 36,
        CITY => 'Wroclaw',
        YEAR => 2015,
        DATE_START => '2015-05-22',
        DATE_END => '2015-05-24'
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/_gpp/07wroclaw/
        ORDINAL => 37,
        CITY => 'Wroclaw',
        YEAR => 2016,
        DATE_START => '2016-05-20',
        DATE_END => '2016-05-22'
      },
      '2017' =>
      {
        # https://wyniki.pzbs.pl/2017/gpp/07wroclaw/
        ORDINAL => 38,
        CITY => 'Wroclaw',
        YEAR => 2017,
        DATE_START => '2017-05-26',
        DATE_END => '2017-05-28'
      },
      '2018' =>
      {
        # https://wyniki.pzbs.pl/2018/gpp/wroclaw/
        ORDINAL => 39,
        CITY => 'Wroclaw',
        YEAR => 2018,
        DATE_START => '2018-05-18',
        DATE_END => '2018-05-20'
      },
      '2019' =>
      {
        # https://wyniki.pzbs.pl/2019/gpp/wroclaw/
        ORDINAL => 40,
        CITY => 'Wroclaw',
        YEAR => 2019,
        DATE_START => '2019-05-24',
        DATE_END => '2019-05-26'
      },
      '2022' =>
      {
        # https://wyniki.pzbs.pl/2022/wroclaw/
        ORDINAL => 41,
        CITY => 'Wroclaw',
        YEAR => 2022,
        DATE_START => '2022-05-20',
        DATE_END => '2022-05-22'
      },
      '2023' =>
      {
        # https://wyniki.pzbs.pl/2023/wroclaw/
        ORDINAL => 42,
        CITY => 'Wroclaw',
        YEAR => 2023,
        DATE_START => '2023-05-12',
        DATE_END => '2023-05-14'
      },
      '2024' =>
      {
        # https://wyniki.pzbs.pl/2024/wroclaw/
        ORDINAL => 43,
        CITY => 'Wroclaw',
        YEAR => 2024,
        DATE_START => '2024-05-17',
        DATE_END => '2024-05-19'
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

);

my %TOURNAMENTS_POLAND =
(
  'Andrzej Wilkosz Memorial Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2014-03-30',
            DATE_END => '2014-03-30'
          } 
        }
      },
    }
  },

  # 'Friendly Match',
  # {
    # ORGANIZATION => 'PZBS',
    # COUNTRY => 'Poland',
    # ORIGIN => 'National',
    # ZONE => 'Europe',
    # FORM => 'Teams',
    # SCORING => 'IMP',
    # GENDER => 'Open',
    # AGE => 'Open',

    # EDITIONS =>
    # {
      # '2016' =>
      # {
        # CHAPTERS =>
        # {
          # MEET => 'Zulawski Congress',
          # 'SINGLE' => 
          # {
            # YEAR => 2016,
            # DATE_START => '2016-03-03',
            # DATE_END => '2016-03-03'
          # } 
        # }
      # },
    # }
  # },

  'Grand Prix of Poland Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
      '2005A' =>
      {
        # https://stara.pzbs.pl/komunikaty/r2005/reg_gppt2005.htm
        CITY => 'Warsaw',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-09-06',
            DATE_END => '2005-09-06'
          } 
        }
      },
      '2006A' =>
      {
        CITY => 'Warsaw',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-12-15',
            DATE_END => '2006-12-17'
          } 
        }
      },
      '2007A' =>
      {
        CHAPTERS =>
        {
          # https://stara.pzbs.pl/wyniki/2007/krajowe/gpp/05lodz/3/3.html
          CITY => 'Lodz',
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-04-15',
            DATE_END => '2007-04-15'
          } 
        }
      },
      '2007B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-12-14',
            DATE_END => '2007-12-16'
          } 
        }
      },
      '2008A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            DATE_START => '2008-12-19',
            DATE_END => '2008-12-21'
          } 
        }
      },
      '2009A' =>
      {
        CITY => 'Saw',
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
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-09-20',
            DATE_END => '2009-09-20'
          } 
        }
      },
      '2009D' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/gpp/gppp2009final/www/el.html
        CITY => 'Starachowice',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-12-18',
            DATE_END => '2009-12-20'
          } 
        }
      },
      '2010A' =>
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
      '2010B' =>
      {
        CHAPTERS =>
        {
          # https://michzimny.pl/bridge/2010/pila/W-gp.html
          CITY => 'Pila',
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-03-06',
            DATE_END => '2010-03-07'
          } 
        }
      },
      '2010C' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-06-03',
            DATE_END => '2010-06-06'
          } 
        }
      },
      '2010D' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-10-03',
            DATE_END => '2010-10-03'
          } 
        }
      },
      '2010E' =>
      {
        # https://wyniki.pzbs.pl/2010/_gpp/final/f.html
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-12-17',
            DATE_END => '2010-12-19'
          } 
        }
      },
      '2011A' =>
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
      '2011B' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-01',
            DATE_END => '2011-05-01'
          } 
        }
      },
      '2011C' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-18',
            DATE_END => '2011-09-18'
          } 
        }
      },
      '2011D' =>
      {
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
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            CITY => 'Krakow',
            DATE_START => '2012-03-25',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2012C' =>
      {
        MEET => 'Wroclaw Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          } 
        }
      },
      '2012D' =>
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
      '2012E' =>
      {
        CITY => 'Pulawy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-16'
          } 
        }
      },
      '2012F' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-23',
            DATE_END => '2012-09-23'
          } 
        }
      },
      '2012G' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-16'
          } 
        }
      },
      '2012H' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-12-18',
            DATE_END => '2012-12-17'
          } 
        }
      },
      '2013A' =>
      {
        CHAPTERS =>
        {
          MEET => 'Zulawski Congress',
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-10',
            DATE_END => '2013-03-10'
          } 
        }
      },
      '2013B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            CITY => 'Krakow',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-24'
          } 
        }
      },
      '2013C' =>
      {
        MEET => 'Wroclaw Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-05-26',
            DATE_END => '2013-05-26'
          } 
        }
      },
      '2013D' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-06-02',
            DATE_END => '2013-06-02'
          } 
        }
      },
      '2013E' =>
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
      '2013F' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            CITY => 'Sopot',
            DATE_START => '2013-07-21',
            DATE_END => '2013-07-21'
          } 
        }
      },
      '2013G' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-06',
            DATE_END => '2013-10-06'
          } 
        }
      },
      '2013H' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            CITY => 'Krakow',
            DATE_START => '2013-11-24',
            DATE_END => '2013-11-24'
          } 
        }
      },
      '2013I' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-13',
            DATE_END => '2013-12-15'
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
        CHAPTERS =>
        {
          CITY => 'Bydgoszcz',
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-03-16',
            DATE_END => '2014-03-16'
          } 
        }
      },
      '2014C' =>
      {
        CHAPTERS =>
        {
          CITY => 'Krakow',
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-03-30',
            DATE_END => '2014-03-30'
          } 
        }
      },
      '2014D' =>
      {
        MEET => 'Wroclaw Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-25',
            DATE_END => '2014-05-25'
          } 
        }
      },
      '2014E' =>
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
      '2014F' =>
      {
        CITY => 'Sopot',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-20',
            DATE_END => '2014-07-20'
          } 
        }
      },
      '2014G' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-28',
            DATE_END => '2014-09-28'
          } 
        }
      },
      '2014H' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-19',
            DATE_END => '2014-12-21'
          } 
        }
      },
      '2015A' =>
      {
        CHAPTERS =>
        {
          CITY => 'Szczyrk',
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-14',
            DATE_END => '2015-02-14'
          } 
        }
      },
      '2015B' =>
      {
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-22',
            DATE_END => '2015-03-22'
          } 
        }
      },
      '2015C' =>
      {
        CHAPTERS =>
        {
          CITY => 'Bydgoszcz',
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-28'
          } 
        }
      },
      '2015D' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-20',
            DATE_END => '2015-09-20'
          } 
        }
      },
      '2015E' =>
      {
        # https://wyniki.pzbs.pl/2015/_gpp/fin/15gppfin2.html
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-12-11',
            DATE_END => '2015-12-13'
          } 
        }
      },
      '2016A' =>
      {
        CHAPTERS =>
        {
          CITY => 'Szczyrk',
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-20'
          } 
        }
      },
      '2016B' =>
      {
        MEET => 'Luczniczka Meeting',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-15',
            DATE_END => '2016-05-15'
          } 
        }
      },
      '2016C' =>
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
        MEET => 'Poznan Congress',

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
      '2009B' =>
      {
        CHAPTERS =>
        {
          CITY => 'Staszic',
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-03-08',
            DATE_END => '2009-03-08'
          } 
        }
      },
      '2009C' =>
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
      '2012A' =>
      {
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          } 
        }
      },
      '2012B' =>
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
      '2013A' =>
      {
        MEET => 'Zulawski Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-08',
            DATE_END => '2013-03-09'
          } 
        }
      },
      '2013B' =>
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
      '2013C' =>
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
      '2013D' =>
      {
        MEET => 'Baltic Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-22',
            DATE_END => '2013-07-26'
          } 
        }
      },
      '2013E' =>
      {
        MEET => 'Boleslawiec Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          } 
        }
      },
      '2013F' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-19',
            DATE_END => '2013-12-21'
          } 
        }
      },
      '2014A' =>
      {
        # 
        CITY => 'Bydgoszcz',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-03-14',
            DATE_END => '2014-03-15'
          } 
        }
      },
      '2014B' =>
      {
        # https://wyniki.pzbs.pl/2014/_gpp/07wroclaw/t/fleaderb.html?1401096198
        CITY => 'Wroclaw',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-24',
            DATE_END => '2014-05-24'
          } 
        }
      },
      '2015A' =>
      {
        MEET => 'Krakow Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-21',
            DATE_END => '2015-03-21'
          } 
        }
      },
      '2015B' =>
      {
        CITY => 'Bydgoszcz',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-03-29',
            DATE_END => '2015-03-29'
          } 
        }
      },
      '2016A' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-06'
          } 
        }
      },
      '2016B' =>
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

  'Pomerania Cup',
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
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
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
            DATE_START => '2013-12-07',
            DATE_END => '2013-12-07'
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
            DATE_START => '2014-10-26',
            DATE_END => '2014-10-26'
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
      '2009' =>
      {
        # https://stara.pzbs.pl/wyniki/2009/krajowe/wielkoszewska2009/TT-08-11/index.html

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
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
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        # https://www.pzbs.pl/wyniki-archiwum/wyn2014

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-22'
          } 
        }
      },
    }
  },

  'Krakow Spring Teams',
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
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-23',
            DATE_END => '2013-03-23'
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
      '2011' =>
      {
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-03',
            DATE_END => '2011-05-03'
          } 
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
        MEET => 'Warsaw Grand Prix',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-26',
            DATE_END => '2006-08-26'
          } 
        }
      },
      '2007' =>
      {
        # https://www.warsbrydz.pl/GPW2006/support/program.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-26',
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
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'U18',

    EDITIONS =>
    {
      '2013a' =>
      {
        # https://www.pzbs.pl/wyniki-mlodziezowe
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            SCORING => 'BAM',
            DATE_START => '2013-04-11',
            DATE_END => '2013-04-12'
          } 
        }
      },
      '2013b' =>
      {
        # https://www.pzbs.pl/wyniki-mlodziezowe
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            SCORING => 'IMP',
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
    ORIGIN => 'Company',
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
            DATE_START => '2014-10-22',
            DATE_END => '2014-10-22'
          },
          'C01' => 
          {
            YEAR => 2014,
            DATE_START => '2014-10-29',
            DATE_END => '2014-10-29'
          },
          'C02' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-05',
            DATE_END => '2014-11-05'
          },
          'C03' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-12',
            DATE_END => '2014-11-12'
          },
          'C04' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-19',
            DATE_END => '2014-11-19'
          },
          'C05' => 
          {
            YEAR => 2014,
            DATE_START => '2014-11-26',
            DATE_END => '2014-11-26'
          },
          'C06' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-03',
            DATE_END => '2014-12-03'
          },
          'C07' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-10',
            DATE_END => '2014-12-10'
          },
          'C08' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-17',
            DATE_END => '2014-12-17'
          },
          'C09' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-07',
            DATE_END => '2015-01-07'
          },
          'C10' => 
          {
            YEAR => 2015,
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
    ORIGIN => 'Company',
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
            DATE_START => '2014-11-17',
            DATE_END => '2014-11-17'
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
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U18',

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
            DATE_START => '2013-04-11',
            DATE_END => '2013-04-14'
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
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-09',
            DATE_END => '2009-05-10'
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
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-12'
          } 
        }
      },
      '2013' =>
      {
        # https://wyniki.pzbs.pl/2013/mppimp/W-impfin.html

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
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
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-21'
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
    FORM => 'Individual',
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
            DATE_START => '2010-03-27',
            DATE_END => '2010-03-27'
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
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-22'
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
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-20'
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
            DATE_START => '2012-04-09',
            DATE_END => '2012-04-12'
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
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb2m.html
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
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
            DATE_START => '2012-05-01',
            DATE_END => '2012-05-01'
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
            DATE_START => '2014-05-01',
            DATE_END => '2014-05-02'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/mpp/W-mxtf.html
        MEET => 'Polish Championships',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-30',
            DATE_END => '2015-05-01'
          } 
        }
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-openf2.html
        MEET => 'Polish Championships',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-04-30',
            DATE_END => '2016-05-01'
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
            DATE_START => '2007-04-27',
            DATE_END => '2007-04-29'
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
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-10',
            DATE_END => '2007-06-10'
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
            DATE_START => '2009-06-14',
            DATE_END => '2009-06-14'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-19'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Baltic Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-07-19',
            DATE_END => '2010-07-21'
          } 
        }
      },
      '2012A' =>
      {
        MEET => 'Polish Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-02',
            DATE_END => '2012-05-05'
          } 
        }
      },
      '2012B' =>
      {
        MEET => 'Baltic Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-07-30',
            DATE_END => '2012-07-30'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Polish Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-30',
            DATE_END => '2013-05-03'
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
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-12-11',
            DATE_END => '2014-12-13'
          } 
        }
      },
      '2015A' =>
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
      '2015B' =>
      {
        CHAPTERS =>
        {
          # https://wyniki.pzbs.pl/2015/_gpp/team/15gptofrunda1.html
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-12-17',
            DATE_END => '2015-12-19'
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
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
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
            DATE_START => '2005-05-28',
            DATE_END => '2005-05-31'
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
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          },
          'C1' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-06'
          },
          'C2' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
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
            DATE_START => '2008-01-27',
            DATE_END => '2008-01-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C2' => 
          {
            YEAR => 2008,
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
            DATE_START => '2014-01-16',
            DATE_END => '2014-01-19'
          },
          'C1' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-21',
            DATE_END => '2014-02-22'
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
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Polish Championships',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
          } 
        }
      },
      '2009A' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2009/W-cz1.html
        MEET => 'Poznan Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-11',
            DATE_END => '2009-06-11'
          } 
        }
      },
      '2009B' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2009/W-cz1.html
        MEET => 'Poznan Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-06-12',
            DATE_END => '2009-06-12'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Zulawski Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-21',
            DATE_END => '2010-02-21'
          } 
        }
      },
      '2011' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb1.html
        MEET => 'Poznan Congress',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
          } 
        }
      },
      '2015' =>
      {
        # https://wyniki.pzbs.pl/2015/mpp/W-mxtf.html
        MEET => 'Polish Championships',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-03'
          } 
        }
      },
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-openf2.html
        MEET => 'Polish Championships',

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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-19'
          } 
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
            DATE_START => '2015-09-18',
            DATE_END => '2015-09-19'
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
      '2006-07' =>
      {
        # https://stara.pzbs.pl/liga/liga2006_7/pierwsza/1liga20067.htm

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            DATE_START => '2007-06-06',
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
            DATE_START => '2010-05-01',
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
            DATE_START => '2010-10-22',
            DATE_END => '2010-10-24'
          },
          'C1' => 
          {
            YEAR => 2011,
            DATE_START => '2011-01-07',
            DATE_END => '2011-01-09'
          },
          'C2' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
          },
          'C3' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-19',
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
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          },
          'C3' => 
          {
            YEAR => 2012,
            DATE_START => '2012-03-03',
            DATE_END => '2012-03-03'
          },
          'C4' => 
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
            DATE_END => '2013-01-06'
          },
          'C2' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-09',
            DATE_END => '2013-03-10'
          },
          'C3' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-05',
            DATE_END => '2013-04-05'
          },
          'C4' => 
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
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-08'
          },
          'C3' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-11',
            DATE_END => '2014-04-12'
          },
          'C4' => 
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
            CITY => 'Wroclaw',
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
            DATE_START => '2015-02-07',
            DATE_END => '2015-02-08'
          },
          'C3' => 
          {
            YEAR => 2015,
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-21'
          },
          'C4' => 
          {
            YEAR => 2015,
            DATE_START => '2015-06-17',
            DATE_END => '2015-06-20'
          },
          'C5' => 
          {
            YEAR => 2015,
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
            CITY => 'Wroclaw',
            YEAR => 2015,
            DATE_START => '2015-10-16',
            DATE_END => '2015-10-18'
          },
          'C1' => 
          {
            CITY => 'Warsaw',
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
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-05-18',
            DATE_END => '2014-05-18'
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
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-02-15',
            DATE_END => '2014-02-16'
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
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-06-12',
            DATE_END => '2010-06-13'
          } 
        }
      },
    }
  },

  'Polish U16 Pairs',
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_END => '2012-05-20'
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
            DATE_START => '2014-04-12',
            DATE_END => '2014-04-13'
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
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U25',

    EDITIONS =>
    {
      '2016' =>
      {
        # https://wyniki.pzbs.pl/2016/mpp/W-u25.html
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-01',
            DATE_END => '2016-05-02'
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
    GENDER => 'Women',
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
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-28'
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
            DATE_START => '2006-04-05',
            DATE_END => '2006-04-09'
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
            DATE_START => '2012-04-27',
            DATE_END => '2012-04-29'
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
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
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
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-02'
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
            DATE_START => '2012-06-02',
            DATE_END => '2012-06-02'
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
      '2011' =>
      {
        # https://s3.eu-central-1.amazonaws.com/kongres.brydz.wlkp.pl/wyniki2011/W-sb2.html
        MEET => 'Poznan Congress',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
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
      '2013' =>
      {
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
