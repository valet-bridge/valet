#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Supra;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://en.wikipedia.org/wiki/List_of_bridge_competitions_and_awards

my %MEETS_SUPRA =
(
  'Buffett Cup' =>
  {
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2006' =>
      {
        CITY => 'Dublin',
        COUNTRY => 'Ireland',
        YEAR => 2006,
        DATE_START => '2006-09-18',
        DATE_END => '2006-09-21'
      },
      '2010' =>
      {
        CITY => 'Cardiff',
        COUNTRY => 'Wales',
        YEAR => 2010,
        DATE_START => '2010-09-13',
        DATE_END => '2010-09-16'
      },
      '2012' =>
      {
        CITY => 'Omaha',
        COUNTRY => 'USA',
        YEAR => 2012,
        DATE_START => '2012-09-10',
        DATE_END => '2012-09-13'
      },
    }
  },

  'Cavendish Invitational' =>
  {
    # TODO Split in Las Vegas and Monaco?
    ORIGIN => 'Invitational',

    EDITIONS =>
    {
      '1997' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 1997,
        DATE_START => '1997-05-10',
        DATE_END => '1997-05-14'
      },
      '1998' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 1998,
        DATE_START => '1998-05-08',
        DATE_END => '1998-05-12'
      },
      '1999' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 1999,
        DATE_START => '1999-05-06',
        DATE_END => '1999-05-10'
      },
      '2000' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2000,
        DATE_START => '2000-05-10',
        DATE_END => '2000-05-14'
      },
      '2001' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2001,
        DATE_START => '2001-05-09',
        DATE_END => '2001-05-13'
      },
      '2003' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2003,
        DATE_START => '2003-05-07',
        DATE_END => '2003-05-11'
      },
      '2004' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2004,
        DATE_START => '2004-05-05',
        DATE_END => '2004-05-09'
      },
      '2005' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2005,
        DATE_START => '2005-05-04',
        DATE_END => '2005-05-08'
      },
      '2006' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2006,
        DATE_START => '2006-05-10',
        DATE_END => '2006-05-14'
      },
      '2007' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2007,
        DATE_START => '2007-05-09',
        DATE_END => '2007-05-13'
      },
      '2008' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2008,
        DATE_START => '2008-05-07',
        DATE_END => '2008-05-11'
      },
      '2009' =>
      {
        MEET_ORDINAL => 35,
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2009,
        DATE_START => '2009-05-06',
        DATE_END => '2009-05-10'
      },
      '2010' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2010,
        DATE_START => '2010-05-05',
        DATE_END => '2010-05-09'
      },
      '2011' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2011,
        DATE_START => '2011-05-04',
        DATE_END => '2011-05-08'
      },
      '2012A' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2012,
        DATE_START => '2012-05-02',
        DATE_END => '2012-05-05'
      },
      '2012B' =>
      {
        CITY => 'Monte Carlo',
        COUNTRY => 'Monaco',
        YEAR => 2012,
        DATE_START => '2012-10-15',
        DATE_END => '2012-10-19'
      },
      '2013' =>
      {
        CITY => 'Monte Carlo',
        COUNTRY => 'Monaco',
        YEAR => 2013,
        DATE_START => '2013-10-21',
        DATE_END => '2013-10-25'
      },
      '2014' =>
      {
        CITY => 'Monte Carlo',
        COUNTRY => 'Monaco',
        YEAR => 2014,
        DATE_START => '2014-09-01',
        DATE_END => '2014-09-06'
      },
      '2015' =>
      {
        CITY => 'Monte Carlo',
        COUNTRY => 'Monaco',
        YEAR => 2015,
        DATE_START => '2015-10-19',
        DATE_END => '2015-10-23'
      },
    }
  },

  'Channel Trophy' =>
  {
    # https://www.ebu.co.uk/internationals/junior-channel-trophy
    ORIGIN => 'International',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2007' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
        YEAR => 2007,
        DATE_START => '2007-12-21',
        DATE_END => '2007-12-23'
      },
      '2008' =>
      {
        CITY => 'London',
        COUNTRY => 'England',
        YEAR => 2008,
        DATE_START => '2008-12-19',
        DATE_END => '2008-12-21'
      },
      '2011' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
        YEAR => 2011,
        DATE_START => '2011-12-16',
        DATE_END => '2011-12-18'
      },
      '2012' =>
      {
        CITY => 'London',
        COUNTRY => 'England',
        YEAR => 2012,
        DATE_START => '2012-12-21',
        DATE_END => '2012-12-23'
      },
      '2015' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
        YEAR => 2015,
        DATE_START => '2015-12-18',
        DATE_END => '2015-12-20'
      },
      '2016' =>
      {
        CITY => 'London',
        COUNTRY => 'England',
        YEAR => 2016,
        DATE_START => '2016-12-16',
        DATE_END => '2016-12-18'
      },
      '2018' =>
      {
        CITY => 'Lille',
        COUNTRY => 'France',
        YEAR => 2018,
        DATE_START => '2018-12-14',
        DATE_END => '2018-12-16'
      },
      '2019' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
        YEAR => 2019,
        DATE_START => '2019-12-20',
        DATE_END => '2019-12-22'
      },
      '2021' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2021
        CITY => 'Leuven',
        COUNTRY => 'Belgium',
        YEAR => 2021,
        DATE_START => '2021-12-17',
        DATE_END => '2021-12-19'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2022
        CITY => 'Lille',
        COUNTRY => 'France',
        YEAR => 2022,
        DATE_START => '2022-12-16',
        DATE_END => '2022-12-18'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2023
        YEAR => 2023,
        DATE_START => '2023-12-15',
        DATE_END => '2023-12-17'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2024
        CITY => 'London',
        COUNTRY => 'England',
        YEAR => 2024,
        DATE_START => '2024-12-13',
        DATE_END => '2024-12-15'
      },
    }
  },

  'Neighbor Challenge' =>
  {
    EDITIONS =>
    {
      '2013' =>
      {
         YEAR => 2013,
         DATE_START => '2013-04-27',
         DATE_END => '2013-04-28'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-04-25',
        DATE_END => '2014-04-27'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-03-28',
        DATE_END => '2015-03-29'
      },
    }
  },
);

my %TOURNAMENTS_SUPRA =
(
  'Buffett Cup Individual' =>
  {
    FORM => 'Individual',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Buffett Cup',
        SCORING => 'BAM',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-09-21',
            DATE_END => '2006-09-21'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Buffett Cup',
        SCORING => 'BAM',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-15',
            DATE_END => '2010-09-16'
          } 
        }
      },
    }
  },

  'Buffett Cup Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Buffett Cup',
        SCORING => 'BAM',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-09-18',
            DATE_END => '2006-09-18'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Buffett Cup',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2010-09-13',
            DATE_END => '2010-09-13'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Buffett Cup',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            minor => 'TABLE',
            DATE_START => '2012-09-10',
            DATE_END => '2012-09-10'
          } 
        }
      },
    }
  },

  'Buffett Cup Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Buffett Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-09-20',
            DATE_END => '2006-09-20'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Buffett Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-14',
            DATE_END => '2010-09-15'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Buffett Cup',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2012-09-11',
            DATE_END => '2012-09-13'
          } 
        }
      },
    }
  },

  'Cavendish Open Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '1997' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1997,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '1997-05-14',
            DATE_END => '1997-05-14'
          } 
        }
      },
      '1998' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 1998,
            major => 'SESSION',
            DATE_START => '1998-05-08',
            DATE_END => '1998-05-08'
          } 
        }
      },
      '1999' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 1999,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '1999-05-10',
            DATE_END => '1999-05-10'
          },
          'C1' => 
          {
            YEAR => 1999,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '1999-05-10',
            DATE_END => '1999-05-10'
          } 
        }
      },
      '2000' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            major => 'SESSION',
            DATE_START => '2000-05-13',
            DATE_END => '2000-05-14'
          } 
        }
      },
      '2001' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            major => 'ROUND',
            DATE_START => '2001-05-09',
            DATE_END => '2001-05-13'
          } 
        }
      },
      '2004' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-05-05',
            DATE_END => '2004-05-09'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2005-05-07',
            DATE_END => '2005-05-08'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-09',
            DATE_END => '2007-05-13'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-05-07',
            DATE_END => '2008-05-11'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-05-08',
            DATE_END => '2009-05-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-05-07',
            DATE_END => '2010-05-09'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-06',
            DATE_END => '2011-05-08'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Cavendish Invitational',
        MEET_TAG => '2012B',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2012-10-17',
            DATE_END => '2012-10-18'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2012-10-18',
            DATE_END => '2012-10-18'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-23',
            DATE_END => '2013-10-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-25'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-09-03',
            DATE_END => '2014-09-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-09-05',
            DATE_END => '2014-09-05'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2015-10-21',
            DATE_END => '2015-10-22'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-10-23',
            DATE_END => '2015-10-23'
          } 
        }
      },
    }
  },

  'Cavendish Teams' =>
  {
    # https://greatbridgelinks.com/gbltour/tournaments-archive/
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            DATE_START => '2000-05-10',
            DATE_END => '2000-05-14'
          } 
        }
      },
      '2001' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2001,
            major => 'ROUND',
            DATE_START => '2001-05-09',
            DATE_END => '2001-05-13'
          } 
        }
      },
      '2003' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2003,
            DATE_START => '2003-05-07',
            DATE_END => '2003-05-11'
          } 
        }
      },
      '2004' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'MATCH',
            DATE_START => '2004-05-05',
            DATE_END => '2004-05-09'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-05-04',
            DATE_END => '2005-05-08'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-05-10',
            DATE_END => '2006-05-14'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-09',
            DATE_END => '2007-05-13'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-05-07',
            DATE_END => '2008-05-11'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-05-06',
            DATE_END => '2009-05-10'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            minor => 'ROUND',
            DATE_START => '2010-05-05',
            DATE_END => '2010-05-06'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-04',
            DATE_END => '2011-05-05'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Cavendish Invitational',
        MEET_TAG => '2012B',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-10-15',
            DATE_END => '2012-10-16'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-10-16',
            DATE_END => '2012-10-16'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-21',
            DATE_END => '2013-10-22'
          },
          'C1' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-10-22',
            DATE_END => '2013-10-22'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-22',
            DATE_END => '2013-10-22'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Cavendish Invitational',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-09-01',
            DATE_END => '2014-09-02'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-02',
            DATE_END => '2014-09-02'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'Cavendish Invitational',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-06'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Cavendish Invitational',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-10-19',
            DATE_END => '2015-10-20'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Consolation',
            major => 'ROUND',
            DATE_START => '2015-10-20',
            DATE_END => '2015-10-20'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-20',
            DATE_END => '2015-10-20'
          } 
        }
      },
    }
  },

  'Cavendish Women Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-23',
            DATE_END => '2013-10-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-25'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-09-03',
            DATE_END => '2014-09-04'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-09-05',
            DATE_END => '2014-09-05'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2015-10-21',
            DATE_END => '2015-10-22'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-10-23',
            DATE_END => '2015-10-23'
          } 
        }
      },
    }
  },

  'Channel Girls Trophy' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Channel Trophy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-12-21',
            DATE_END => '2007-12-23'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Channel Trophy',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'SET',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-20'
          } 
        }
      },
    }
  },

  'Channel Juniors Trophy' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-12-21',
            DATE_END => '2007-12-23'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U25',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            minor => 'MATCH',
            DATE_START => '2008-12-19',
            DATE_END => '2008-12-21'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-18'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'MATCH',
            DATE_START => '2012-12-21',
            DATE_END => '2012-12-23'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'SET',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-20'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-12-16',
            DATE_END => '2016-12-18'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-12-14',
            DATE_END => '2018-12-16'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-20',
            DATE_END => '2019-12-22'
          } 
        }
      },
      '2021' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2021
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-12-17',
            DATE_END => '2021-12-19'
          } 
        }
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2022
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-12-16',
            DATE_END => '2022-12-18'
          } 
        }
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2023
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-12-15',
            DATE_END => '2023-12-17'
          } 
        }
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/channel-trophy-2024
        MEET => 'Channel Trophy',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-12-13',
            DATE_END => '2024-12-15'
          } 
        }
      },
    }
  },

  'Channel Schools Trophy' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'Schools',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2007-12-21',
            DATE_END => '2007-12-23'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U20',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            minor => 'MATCH',
            DATE_START => '2008-12-19',
            DATE_END => '2008-12-21'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U20',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2011-12-16',
            DATE_END => '2011-12-18'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Channel Trophy',
        AGE => 'U20',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'SET',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-20'
          } 
        }
      },
    }
  },

  'Computer World Championship' =>
  {
    # https://bridgebotchampionship.com/home/world-computer-bridge-championship/
    ORIGIN => 'Transnational',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        ORDINAL => 9,
        CITY => 'Estoril',
        COUNTRY => 'Portugal',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-11-09',
            DATE_END => '2005-11-11'
          } 
        }
      },
      '2007' =>
      {
        ORDINAL => 11,
        CITY => 'Shanghai',
        COUNTRY => 'China',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          } 
        }
      },
      '2008' =>
      {
        ORDINAL => 12,
        CITY => 'Las Vegas',
        COUNTRY => 'USA',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-25',
            DATE_END => '2008-07-25'
          } 
        }
      },
    }
  },

  'Neighbor Challenge IMP Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-25',
            DATE_END => '2014-04-27'
          } 
        }
      },
    }
  },

  'Neighbor Challenge Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-04-27',
            DATE_END => '2013-04-28'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-25',
            DATE_END => '2014-04-27'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-29'
          } 
        }
      },
    }
  },

  'Neighbor Challenge Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-25',
            DATE_END => '2014-04-27'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Neighbor Challenge',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-29'
          } 
        }
      },
    }
  },

  'NYSA Euroregion Nations Cup' =>
  {
    ORIGIN => 'Transnational',
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
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-10-03',
            DATE_END => '2013-10-03'
          } 
        }
      },
      '2014' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-09-24',
            DATE_END => '2014-09-24'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-09-25',
            DATE_END => '2014-09-25'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-09-25',
            DATE_END => '2014-09-25'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-17',
            DATE_END => '2015-09-17'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-09-17',
            DATE_END => '2015-09-17'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-09-17',
            DATE_END => '2015-09-17'
          } 
        }
      },
    }
  },

  'Paris Youth Open Teams' =>
  {
    CITY => 'Paris',
    COUNTRY => 'France',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2013' =>
      {
        ORDINAL => 1,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-03'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-04',
            DATE_END => '2013-11-04'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-05',
            DATE_END => '2013-11-05'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 2,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-10-28',
            DATE_END => '2015-10-29'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-10-31',
            DATE_END => '2015-10-31'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          } 
        }
      },
    }
  },

  'Stern-Cornell Trophy' =>
  {
    ORIGIN => 'International',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U25',

    EDITIONS =>
    {
      '2015' =>
      {
        # https://www.abf.com.au/2015-australian-youth-championships-2/
        CITY => 'Canberra',
        COUNTRY => 'Australia',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-01-17',
            DATE_END => '2015-01-17'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SUPRA, \%TOURNAMENTS_SUPRA, 'Supra');
}

1;
