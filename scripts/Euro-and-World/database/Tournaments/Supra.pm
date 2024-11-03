#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Supra;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_SUPRA =
(
  'Cavendish Invitational' =>
  {
    ORIGIN => 'Invitational',

    EDITIONS =>
    {
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
      '2009' =>
      {
        ORDINAL => 35,
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
        DATE_END => '2010-05-06'
      },
      '2011' =>
      {
        CITY => 'Las Vegas',
        COUNTRY => 'USA',
        YEAR => 2011,
        DATE_START => '2011-05-04',
        DATE_END => '2011-05-05'
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
    }
  }
);

my %TOURNAMENTS_SUPRA =
(
  'XBuffett Cup' =>
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'Interprovince',
    ZONE => 'South Pacific',
    FORM => 'Teams',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012A' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-10',
            DATE_END => '2012-09-11'
          } 
        }
      },
      '2012B' =>
      {
        SCORING => 'BAM',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-12',
            DATE_END => '2012-09-13'
          } 
        }
      },
    }
  },

  'Cavendish Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
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
        SCORING => 'MP',
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
            DATE_START => '2011-05-06',
            DATE_END => '2011-05-08'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Cavendish Invitational',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-10-17',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-24',
            DATE_END => '2013-10-24'
          } 
        }
      },
    }
  },

  'XSpring Nationals' =>
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
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-04-27',
            DATE_END => '2013-04-28'
          } 
        }
      },
    }
  },

  'XNeighbor Challenge' =>
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'Interprovince',
    ZONE => 'South Pacific',
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
            DATE_START => '2013-04-27',
            DATE_END => '2013-04-28'
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
            DATE_START => '2014-04-25',
            DATE_END => '2014-04-27'
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
            DATE_START => '2015-03-28',
            DATE_END => '2015-03-29'
          } 
        }
      },
    }
  },

  # --- "DONE" ---

  'Bermuda Triangle Cup' =>
  {
    ORGANIZATION => 'PZBS',
    COUNTRY => 'Poland',
    ORIGIN => 'International',
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
            DATE_START => '2007-04-22',
            DATE_END => '2007-04-22'
          } 
        }
      },
    }
  },

  'BKBT Teams' =>
  {
    # Unclear
    ORGANIZATION => 'RBL',
    COUNTRY => 'Russia',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-02-03',
            DATE_END => '2005-02-04'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-02-05',
            DATE_END => '2005-02-05'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-02-07',
            DATE_END => '2005-02-07'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-02-08',
            DATE_END => '2005-02-08'
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-10-21',
            DATE_END => '2013-10-25'
          } 
        }
      },
    }
  },

  'Channel Trophy' =>
  {
    # https://www.ebu.co.uk/internationals/junior-channel-trophy
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2007' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            DATE_START => '2007-12-21',
            DATE_END => '2007-12-23'
          } 
        }
      },
      '2008' =>
      {
        CITY => 'London',
        COUNTRY => 'England',
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
      '2011' =>
      {
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
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
        CITY => 'London',
        COUNTRY => 'England',
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
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
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
        CITY => 'London',
        COUNTRY => 'England',
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
        CITY => 'Lille',
        COUNTRY => 'France',
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
        CITY => 'Utrecht',
        COUNTRY => 'Netherlands',
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
        CITY => 'Leuven',
        COUNTRY => 'Belgium',
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
        CITY => 'Lille',
        COUNTRY => 'France',
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
        CITY => 'London',
        COUNTRY => 'England',
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
        CHAPTERS =>
        {
          ORDINAL => 11,
          CITY => 'Shanghai',
          COUNTRY => 'China',

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
        CHAPTERS =>
        {
          ORDINAL => 12,
          CITY => 'Las Vegas',
          COUNTRY => 'USA',

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

  'NYSA Euroregion Nations Cup' =>
  {
    ORGANIZATION => 'NZB',
    COUNTRY => 'New Zealand',
    ORIGIN => 'Interprovince',
    ZONE => 'South Pacific',
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
            STAGE => 'Round-robin',
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
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-05'
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

  'Shield of Thoisy' =>
  {
    ORIGIN => 'International',
    CITY => 'Thoisy',
    COUNTRY => 'France',
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
            major => 'STANZA',
            DATE_START => '2013-08-23',
            DATE_END => '2013-08-25'
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

  'Yeh Bros Pairs Cup' =>
  {
    ORIGIN => 'Invitational',
    ZONE => 'Southeast Asia',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CITY => 'Broadbeach Island',
        COUNTRY => 'Australia',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-03-02',
            DATE_END => '2009-03-02'
          },
        }
      },
    }
  },

  'Yeh Bros Cup' =>
  {
    ORIGIN => 'Invitational',
    ZONE => 'Southeast Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        # Not present in data
        CITY => 'Beijing',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            DATE_START => '2004-04-23',
            DATE_END => '2004-04-25'
          } 
        }
      },
      '2006' =>
      {
        CITY => 'Kaohsiung',
        COUNTRY => 'Taiwan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2006-03-18',
            DATE_END => '2006-03-18'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-03-18',
            DATE_END => '2006-03-19'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-03-19',
            DATE_END => '2006-03-19'
          } 
        }
      },
      '2007' =>
      {
        CITY => 'Shenzhen',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2007-03-01',
            DATE_END => '2007-03-02'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2007-03-03',
            DATE_END => '2007-03-04'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-03-04',
            DATE_END => '2007-03-04'
          } 
        }
      },
      '2008' =>
      {
        CITY => 'Kaohsiung',
        COUNTRY => 'Taiwan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2008-02-13',
            DATE_END => '2008-02-15'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            minor => 'HALF',
            DATE_START => '2008-02-16',
            DATE_END => '2008-02-16'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-02-17',
            DATE_END => '2008-02-17'
          } 
        }
      },
      '2009' =>
      {
        CITY => 'Broadbeach Island',
        COUNTRY => 'Australia',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2009-02-25',
            DATE_END => '2009-02-27'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Knock-out',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2009-02-27',
            DATE_END => '2009-03-01'
          },
          'C2' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Triangle',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2009-02-28',
            DATE_END => '2009-03-01'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Bronze',
            major => 'SEGMENT',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-02'
          },
          'C4' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-01',
            DATE_END => '2009-03-02'
          } 
        }
      },
      '2011' =>
      {
        CITY => 'Wuxi',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-19'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-04-19',
            DATE_END => '2011-04-21'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-19',
            DATE_END => '2011-04-21'
          } 
        }
      },
      '2013' =>
      {
        CITY => 'Yokohama',
        COUNTRY => 'Japan',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-04-22',
            DATE_END => '2013-04-23'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-25'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Playoff',
            major => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-26'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-23',
            DATE_END => '2013-04-26'
          } 
        }
      },
      '2015' =>
      {
        CITY => 'Shanghai',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-04-08',
            DATE_END => '2015-04-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Knock-out',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-04-10',
            DATE_END => '2015-04-11'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-04-12',
            DATE_END => '2015-04-12'
          } 
        }
      },
      '2017' =>
      {
        CITY => 'Tokyo',
        COUNTRY => 'Japan',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-07-03',
            DATE_END => '2017-07-03'
          } 
        }
      },
      '2018' =>
      {
        CITY => 'Beijing',
        COUNTRY => 'China',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-07-01',
            DATE_END => '2018-07-05'
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
