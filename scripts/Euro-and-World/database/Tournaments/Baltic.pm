#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Baltic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_BALTIC =
(
  'Baltic Cup' =>
  {
    ORGANIZATION => 'LiBA',
    ORIGIN => 'Transnational',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2010' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2010
        YEAR => 2010,
        CITY => 'Riga',
        COUNTRY => 'Latvia',
        DATE_START => '2010-05-15',
        DATE_END => '2010-05-16'
      },
      '2011' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2011
        YEAR => 2011,
        CITY => 'Vilnius',
        COUNTRY => 'Lithuania',
        DATE_START => '2011-04-30',
        DATE_END => '2011-05-02'
      },
      '2012' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2012
        YEAR => 2012,
        COUNTRY => 'Estonia',
        DATE_START => '2012-04-21',
        DATE_END => '2012-04-22'
      },
      '2013' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2013
        YEAR => 2013,
        CITY => 'Riga',
        COUNTRY => 'Latvia',
        DATE_START => '2013-05-11',
        DATE_END => '2013-05-12'
      },
      '2014' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2014
        YEAR => 2014,
        CITY => 'Pärnu',
        COUNTRY => 'Estonia',
        DATE_START => '2014-04-26',
        DATE_END => '2014-04-27'
      },
      '2015' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2015
        YEAR => 2015,
        COUNTRY => 'Finland',
        DATE_START => '2015-04-25',
        DATE_END => '2015-04-26'
      },
      '2016' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2016
        YEAR => 2016,
        CITY => 'Vilnius',
        COUNTRY => 'Lithuania',
        DATE_START => '2016-04-23',
        DATE_END => '2016-04-24'
      },
      '2017' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2017
        YEAR => 2017,
        COUNTRY => 'Estonia',
        DATE_START => '2017-04-22',
        DATE_END => '2017-04-23'
      },
      '2018' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2018
        YEAR => 2018,
        CITY => 'Riga',
        COUNTRY => 'Latvia',
        DATE_START => '2018-04-21',
        DATE_END => '2018-04-22'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2019
        YEAR => 2019,
        CITY => 'Vilnius',
        COUNTRY => 'Lithuania',
        DATE_START => '2019-04-27',
        DATE_END => '2019-04-28'
      },
      '2020' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2020
        YEAR => 2020,
        CITY => 'Online',
        DATE_START => '2020-06-29',
        DATE_END => '2020-07-04'
      },
      '2021' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2021
        YEAR => 2021,
        CITY => 'Online',
        DATE_START => '2021-05-17',
        DATE_END => '2021-05-22'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2022
        YEAR => 2022,
        CITY => 'Tallinn',
        COUNTRY => 'Estonia',
        DATE_START => '2022-04-20',
        DATE_END => '2022-04-21'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/baltic-cup-2023
        YEAR => 2023,
        CITY => 'Vilnius',
        COUNTRY => 'Lithuania',
        DATE_START => '2023-09-20',
        DATE_END => '2023-09-21'
      },
    }
  },

  'Riga Invites to Jurmala' =>
  {
    # https://www.rigainvites.lv/results.php
    ORGANIZATION => 'LaBF',
    ZONE => 'Europe',
    CITY => 'Riga',
    COUNTRY => 'Latvia',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET_ORDINAL => 3,
        YEAR => 2009,
        DATE_START => '2009-08-19',
        DATE_END => '2009-08-23'
      },
      '2010' =>
      {
        MEET_ORDINAL => 4,
        YEAR => 2010,
        DATE_START => '2010-08-18',
        DATE_END => '2010-08-22'
      },
      '2011' =>
      {
        MEET_ORDINAL => 5,
        YEAR => 2011,
        DATE_START => '2011-08-17',
        DATE_END => '2011-08-21'
      },
      '2012' =>
      {
        MEET_ORDINAL => 6,
        YEAR => 2012,
        DATE_START => '2012-08-29',
        DATE_END => '2012-09-01'
      },
      '2013' =>
      {
        MEET_ORDINAL => 7,
        YEAR => 2013,
        DATE_START => '2013-08-21',
        DATE_END => '2013-08-25'
      },
      '2014' =>
      {
        MEET_ORDINAL => 8,
        YEAR => 2014,
        DATE_START => '2014-08-13',
        DATE_END => '2014-08-17'
      },
      '2015' =>
      {
        MEET_ORDINAL => 9,
        YEAR => 2015,
        DATE_START => '2015-08-19',
        DATE_END => '2015-08-23'
      },
      '2016' =>
      {
        MEET_ORDINAL => 10,
        YEAR => 2016,
        DATE_START => '2016-08-17',
        DATE_END => '2016-08-21'
      },
      '2017' =>
      {
        MEET_ORDINAL => 11,
        YEAR => 2017,
        DATE_START => '2017-08-09',
        DATE_END => '2017-08-13'
      },
      '2018' =>
      {
        MEET_ORDINAL => 12,
        YEAR => 2018,
        DATE_START => '2018-08-15',
        DATE_END => '2018-08-19'
      },
      '2019' =>
      {
        MEET_ORDINAL => 13,
        YEAR => 2019,
        DATE_START => '2019-08-14',
        DATE_END => '2019-08-18'
      },
      '2020' =>
      {
        MEET_ORDINAL => 14,
        YEAR => 2020,
        DATE_START => '2020-08-12',
        DATE_END => '2020-08-16'
      },
      '2021' =>
      {
        MEET_ORDINAL => 15,
        YEAR => 2021,
        DATE_START => '2021-08-11',
        DATE_END => '2021-08-15'
      },
      '2022' =>
      {
        MEET_ORDINAL => 16,
        YEAR => 2022,
        DATE_START => '2022-08-10',
        DATE_END => '2022-08-14'
      },
      '2023' =>
      {
        MEET_ORDINAL => 17,
        YEAR => 2023,
        DATE_START => '2023-09-06',
        DATE_END => '2023-09-10'
      },
      '2024' =>
      {
        MEET_ORDINAL => 18,
        YEAR => 2024,
        DATE_START => '2024-08-21',
        DATE_END => '2024-08-25'
      },
    }
  },

  'Tallinn Bridge Festival' =>
  {
    # https://old.bridge.ee/festival/results.php
    ORGANIZATION => 'EstBL',
    ZONE => 'Europe',
    CITY => 'Tallinn',
    COUNTRY => 'Estonia',

    EDITIONS =>
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-05-29',
        DATE_END => '2004-05-29'
      },
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-05-26',
        DATE_END => '2005-05-31'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-26',
        DATE_END => '2006-05-26'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-05-30',
        DATE_END => '2007-05-31'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-06-03',
        DATE_END => '2008-06-03'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-05-28',
        DATE_END => '2009-05-31'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-05-26',
        DATE_END => '2010-05-30'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-05-27',
        DATE_END => '2011-05-29'
      },
      '2012' =>
      {
        # https://old.bridge.ee/festival/5SFG_fest12.htm
        MEET_ORDINAL => 45,
        YEAR => 2012,
        DATE_START => '2012-09-27',
        DATE_END => '2012-09-30'
      },
      '2013' =>
      {
        # https://old.bridge.ee/festival/fest13.htm
        MEET_ORDINAL => 46,
        YEAR => 2013,
        DATE_START => '2013-05-22',
        DATE_END => '2013-05-26'
      },
      '2014' =>
      {
        # https://old.bridge.ee/festival/fest14.htm
        MEET_ORDINAL => 47,
        YEAR => 2014,
        DATE_START => '2014-05-21',
        DATE_END => '2014-05-25'
      },
      '2015' =>
      {
        # https://old.bridge.ee/festival/fest15.htm
        MEET_ORDINAL => 48,
        YEAR => 2015,
        DATE_START => '2015-05-27',
        DATE_END => '2015-05-31'
      },
      '2016' =>
      {
        MEET_ORDINAL => 49,
        YEAR => 2016,
        DATE_START => '2016-05-25',
        DATE_END => '2016-05-29'
      },
      '2017' =>
      {
        MEET_ORDINAL => 50,
        YEAR => 2017,
        DATE_START => '2017-05-25',
        DATE_END => '2017-05-29'
      },
      '2018' =>
      {
        MEET_ORDINAL => 51,
        YEAR => 2018,
        DATE_START => '2018-04-24',
        DATE_END => '2018-04-28'
      },
      '2019' =>
      {
        MEET_ORDINAL => 52,
        YEAR => 2019,
        DATE_START => '2019-05-02',
        DATE_END => '2019-05-05'
      },
      '2022' =>
      {
        MEET_ORDINAL => 53,
        YEAR => 2022,
        DATE_START => '2022-04-20',
        DATE_END => '2022-04-24'
      },
      '2023' =>
      {
        MEET_ORDINAL => 54,
        YEAR => 2023,
        DATE_START => '2023-05-25',
        DATE_END => '2023-05-28'
      },
      '2024' =>
      {
        MEET_ORDINAL => 55,
        YEAR => 2024,
        DATE_START => '2024-05-16',
        DATE_END => '2024-05-19'
      },
    }
  },

  'Vilnius Cup' =>
  {
    ORGANIZATION => 'LiBA',
    ZONE => 'Europe',
    CITY => 'Vilnius',
    COUNTRY => 'Lithuania',

    EDITIONS =>
    {
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-09-29',
        DATE_END => '2005-10-02'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-09-28',
        DATE_END => '2006-10-01'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-09-13',
        DATE_END => '2007-09-16'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-10-01',
        DATE_END => '2009-10-04'
      },
      '2010' =>
      {
        MEET_ORDINAL => 37,
        YEAR => 2010,
        DATE_START => '2010-09-16',
        DATE_END => '2010-09-19'
      },
      '2011' =>
      {
        MEET_ORDINAL => 38,
        YEAR => 2011,
        DATE_START => '2011-09-29',
        DATE_END => '2011-10-02'
      },
      '2012' =>
      {
        MEET_ORDINAL => 39,
        YEAR => 2012,
        DATE_START => '2012-10-25',
        DATE_END => '2012-10-28'
      },
      '2013' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2013
        MEET_ORDINAL => 40,
        YEAR => 2013,
        DATE_START => '2013-08-29',
        DATE_END => '2013-09-01'
      },
      '2014' =>
      {
        MEET_ORDINAL => 41,
        YEAR => 2014,
        DATE_START => '2014-09-18',
        DATE_END => '2014-09-21'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-09-04',
        DATE_END => '2015-09-06'
      },
      # https://wyniki.pzbs.pl/2016/vilnius/16vilqleaderb.html
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-09-15',
        DATE_END => '2017-09-17'
      },
      '2018' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2018
        YEAR => 2018,
        DATE_START => '2018-10-17',
        DATE_END => '2018-10-21'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2019
        YEAR => 2019,
        DATE_START => '2019-10-11',
        DATE_END => '2019-10-15'
      },
      '2020' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2020
        YEAR => 2020,
        DATE_START => '2020-10-23',
        DATE_END => '2020-10-25'
      },
      '2021' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2021
        YEAR => 2021,
        DATE_START => '2021-10-01',
        DATE_END => '2021-10-03'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2022
        YEAR => 2022,
        DATE_START => '2022-09-23',
        DATE_END => '2022-09-25'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2023
        YEAR => 2023,
        DATE_START => '2023-09-22',
        DATE_END => '2023-09-24'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/vilnius-cup-2024
        YEAR => 2024,
        DATE_START => '2024-09-27',
        DATE_END => '2024-09-29'
      },
    }
  }
);

my %TOURNAMENTS_BALTIC =
(
  'Baltic Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Baltic Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-04-30',
            DATE_END => '2011-04-30'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-30',
            DATE_END => '2011-05-01'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-04-30',
            DATE_END => '2011-05-01'
          } 
        }
      },
      '2012' =>
      {
        # This is not Baltic Cup, but something like
        # Baltic Teams Cup.
        # http://bridge.ee/BL/BTC12.htm
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-26',
            DATE_END => '2012-05-26'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-27',
            DATE_END => '2012-05-27'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Baltic Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-12',
            DATE_END => '2013-05-12'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-12',
            DATE_END => '2013-05-12'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Baltic Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-26',
            DATE_END => '2014-04-27'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-04-27',
            DATE_END => '2014-04-27'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-27',
            DATE_END => '2014-04-27'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Baltic Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-25'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-04-26',
            DATE_END => '2015-04-26'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-26',
            DATE_END => '2015-04-26'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Baltic Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-24',
            DATE_END => '2016-04-24'
          } 
        }
      },
    }
  },

  'Estonian Open Pair Trials' =>
  {
    ORGANIZATION => 'LaBF',
    ORIGIN => 'National',
    ZONE => 'Europe',
    COUNTRY => 'Estonia',
    FORM => 'Pairs',
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
            major => 'ROUND|SESSION',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-08'
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
            major => 'ROUND',
            DATE_START => '2015-08-29',
            DATE_END => '2015-08-30'
          } 
        }
      },
    }
  },

  'Estonian Open Teams' =>
  {
    ORGANIZATION => 'EstBL',
    COUNTRY => 'Estonia',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-04-03',
            DATE_END => '2007-04-03'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2009-04-04',
            DATE_END => '2009-04-05'
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
            major => 'ROUND',
            DATE_START => '2010-04-10',
            DATE_END => '2010-04-11'
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
            major => 'ROUND',
            DATE_START => '2011-04-02',
            DATE_END => '2011-04-03'
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2012-03-31',
            DATE_END => '2012-04-01'
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-04-06',
            DATE_END => '2013-04-07'
          } 
        }
      },
    }
  },

  'Estonian-Latvian Open Team Trials' =>
  {
    ORIGIN => 'International',
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
            DATE_START => '2009-08-29',
            DATE_END => '2009-08-30'
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
            DATE_START => '2011-08-27',
            DATE_END => '2011-08-28'
          } 
        }
      },
    }
  },

  'Fortuna Cup' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-05-30',
            DATE_END => '2009-05-31'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-29',
            DATE_END => '2010-05-30'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-05-28',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-27',
            DATE_END => '2016-05-27'
          } 
        }
      },
    }
  },

  'Latvia Invites' =>
  {
    ORGANIZATION => 'LaBF',
    ZONE => 'Europe',
    COUNTRY => 'Latvia',
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
            major => 'ROUND',
            DATE_START => '2014-05-31',
            DATE_END => '2014-06-01'
          } 
        }
      },
    }
  },

  'Lithuanian Open Teams' =>
  {
    ORGANIZATION => 'LiBA',
    COUNTRY => 'Lithuania',
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
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-25',
            DATE_END => '2009-04-25'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-04-26',
            DATE_END => '2009-04-26'
          } 
        }
      },
    }
  },

  'Riga Invitational Pairs' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-08-19',
            DATE_END => '2009-08-19'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-18',
            DATE_END => '2010-08-18'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-17',
            DATE_END => '2011-08-17'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-29',
            DATE_END => '2012-08-31'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-21',
            DATE_END => '2013-08-25'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-14',
            DATE_END => '2014-08-14'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-19',
            DATE_END => '2015-08-19'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-17',
            DATE_END => '2016-08-17'
          } 
        }
      },
    }
  },

  'Riga Open Teams' =>
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            DATE_START => '2009-08-21',
            DATE_END => '2009-08-21'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-08-21',
            DATE_END => '2009-08-21'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            DATE_START => '2010-08-20',
            DATE_END => '2010-08-20'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            DATE_START => '2010-08-20',
            DATE_END => '2010-08-20'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            DATE_START => '2011-08-19',
            DATE_END => '2011-08-19'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-08-19',
            DATE_END => '2011-08-19'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            DATE_START => '2012-08-31',
            DATE_END => '2012-08-31'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-08-31',
            DATE_END => '2012-08-31'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-08-15',
            DATE_END => '2014-08-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-08-15',
            DATE_END => '2014-08-15'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-21'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Riga Invites to Jurmala',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            DATE_START => '2016-08-19',
            DATE_END => '2016-08-19'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-08-19',
            DATE_END => '2016-08-19'
          } 
        }
      },
    }
  },

  'Tallinn Invitational Pairs' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            DATE_START => '2005-05-26',
            DATE_END => '2005-05-26'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-28',
            DATE_END => '2009-05-28'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            DATE_START => '2010-05-27',
            DATE_END => '2010-05-27'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-27',
            DATE_END => '2012-09-27'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-05-22',
            DATE_END => '2014-05-22'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'SESSION|ROUND',
            DATE_START => '2015-05-28',
            DATE_END => '2015-05-29'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Tallinn Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-05-26',
            DATE_END => '2016-05-26'
          },
        }
      },
    }
  },

  'Towns Cup' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-05-29',
            DATE_END => '2004-05-29'
          },
        }
      },
      '2005' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-31',
            DATE_END => '2005-05-31'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-31',
            DATE_END => '2005-05-31'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-05-26',
            DATE_END => '2006-05-26'
          },
        }
      },
      '2007' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-30',
            DATE_END => '2007-05-30'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'HALF',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-06-03',
            DATE_END => '2008-06-03'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-05-29',
            DATE_END => '2009-05-30'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-05-28',
            DATE_END => '2010-05-29'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-27',
            DATE_END => '2011-05-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-28',
            DATE_END => '2011-05-28'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-09-28',
            DATE_END => '2012-09-30'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-05-23',
            DATE_END => '2013-05-25'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-22',
            DATE_END => '2014-05-24'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-29',
            DATE_END => '2015-05-29'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Tallinn Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-26',
            DATE_END => '2016-05-27'
          },
        }
      },
    }
  },

  'Vilnius BAM Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010A' =>
      {
        MEET => 'Vilnius Cup',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-16',
            DATE_END => '2010-09-16'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Vilnius Cup',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND|SEGMENT',
            DATE_START => '2010-09-17',
            DATE_END => '2010-09-18'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND|SEGMENT',
            DATE_START => '2011-09-29',
            DATE_END => '2011-10-01'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Barometer',
            major => 'ROUND',
            DATE_START => '2013-08-29',
            DATE_END => '2013-08-31'
          } 
        }
      },
    }
  },

  'Vilnius Club Pairs' =>
  {
    ORGANIZATION => 'LiBA',
    ORIGIN => 'Interclub',
    CITY => 'Vilnius',
    COUNTRY => 'Lithuania',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-14'
          } 
        }
      },
    }
  },

  'Vilnius IMP Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009A' =>
      {
        MEET => 'Vilnius Cup',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-10-01',
            DATE_END => '2009-10-01'
          } 
        }
      },
      '2009B' =>
      {
        MEET => 'Vilnius Cup',
        MEET_TAG => '2009',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION|SEGMENT',
            DATE_START => '2009-10-03',
            DATE_END => '2009-10-04'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION|ROUND',
            DATE_START => '2011-09-29',
            DATE_END => '2011-09-29'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-10-01',
            DATE_END => '2011-10-01'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-25',
            DATE_END => '2012-10-27'
          } 
        }
      },
    }
  },

  'Vilnius Open Pairs' =>
  {
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Vilnius Cup',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION|SEGMENT',
            DATE_START => '2009-10-01',
            DATE_END => '2009-10-01'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Vilnius Cup',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION|ROUND',
            DATE_START => '2010-09-16',
            DATE_END => '2010-09-16'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Vilnius Cup',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-10-01',
            DATE_END => '2011-10-01'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Vilnius Cup',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION|SEGMENT',
            DATE_START => '2012-10-25',
            DATE_END => '2012-10-27'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Vilnius Cup',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION|SEGMENT',
            DATE_START => '2013-08-29',
            DATE_END => '2013-08-31'
          } 
        }
      },
    }
  },

  'Vilnius Open Teams' =>
  {
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2005-10-02',
            DATE_END => '2005-10-02'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND|SESSION',
            DATE_START => '2006-10-01',
            DATE_END => '2006-10-01'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND|MATCH',
            DATE_START => '2007-09-16',
            DATE_END => '2007-09-16'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND|MATCH',
            DATE_START => '2009-10-01',
            DATE_END => '2009-10-04'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND|MATCH',
            DATE_START => '2010-09-17',
            DATE_END => '2010-09-17'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-09-19',
            DATE_END => '2010-09-19'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-09-19',
            DATE_END => '2010-09-19'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|MATCH',
            DATE_START => '2011-09-30',
            DATE_END => '2011-09-30'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-10-02',
            DATE_END => '2011-10-02'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-02',
            DATE_END => '2011-10-02'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND|MATCH',
            DATE_START => '2012-10-26',
            DATE_END => '2012-10-26'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-10-28',
            DATE_END => '2012-10-28'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-10-28',
            DATE_END => '2012-10-28'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND|MATCH',
            DATE_START => '2013-08-30',
            DATE_END => '2013-08-30'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-01',
            DATE_END => '2013-09-01'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-01',
            DATE_END => '2013-09-01'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND|MATCH',
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-21'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Vilnius Cup',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2015-09-04',
            DATE_END => '2015-09-04'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Consolation',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-06',
            DATE_END => '2015-09-06'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-06',
            DATE_END => '2015-09-06'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BALTIC, \%TOURNAMENTS_BALTIC, 'Baltic');
}

1;
