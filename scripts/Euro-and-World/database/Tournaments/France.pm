#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::France;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_FRANCE =
(
  'Mondial de Deauville' =>
  {
    # https://festival-international-bridge-deauville.com/#

    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    CITY => 'Deauville',
    ORIGIN => 'Transnational',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-07-17',
        DATE_END => '2009-07-25'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-07-16',
        DATE_END => '2010-07-24'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-07-22',
        DATE_END => '2011-07-30'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-07-16',
        DATE_END => '2012-07-21'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-07-19',
        DATE_END => '2013-07-24'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-07-18',
        DATE_END => '2014-07-26'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-07-17',
        DATE_END => '2015-07-25'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-07-22',
        DATE_END => '2016-07-30'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/festival-mondial-de-bridge-de-deauville-2020
        YEAR => 2019,
        DATE_START => '2019-07-17',
        DATE_END => '2019-07-25'
      },
      '2020' =>
      {
        # https://bridgescanner.com/event/festival-mondial-de-bridge-de-deauville-2020
        YEAR => 2020,
        DATE_START => '2020-07-16',
        DATE_END => '2020-07-26'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/festival-mondial-de-bridge-de-deauville-2022
        YEAR => 2022,
        DATE_START => '2022-07-21',
        DATE_END => '2022-07-29'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/festival-mondial-de-bridge-de-deauville-2023
        YEAR => 2023,
        DATE_START => '2023-07-20',
        DATE_END => '2023-07-29'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/festival-mondial-de-bridge-de-deauville-2024
        YEAR => 2024,
        DATE_START => '2024-07-18',
        DATE_END => '2024-07-25'
      },
    }
  }
);

my %TOURNAMENTS_FRANCE =
(
  'Biarritz Hiver',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

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
            major => 'SESSION',
            DATE_START => '2016-02-26',
            DATE_END => '2016-02-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2016-02-28',
            DATE_END => '2016-02-28'
          } 
        }
      },
    }
  },

  'Deauville Open Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-07-22',
            DATE_END => '2016-07-22'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-07-26',
            DATE_END => '2016-07-26'
          },
          'C2' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          } 
        }
      },
    }
  },

  'Deauville Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-07-17',
            DATE_END => '2009-07-25'
          } 
        }
      },
      '2010A' =>
      {
        MEET => 'Mondial de Deauville',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-07-16',
            DATE_END => '2010-07-16'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-07-20',
            DATE_END => '2010-07-24'
          } 
        }
      },
      '2010B' =>
      {
        MEET => 'Mondial de Deauville',
        MEET_TAG => '2010',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-07-19',
            DATE_END => '2010-07-19'
          } 
        }
      },
      '2011A' =>
      {
        MEET => 'Mondial de Deauville',
        MEET_TAG => '2011',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-07-22',
            DATE_END => '2011-07-22'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-07-30',
            DATE_END => '2011-07-30'
          } 
        }
      },
      '2011B' =>
      {
        MEET => 'Mondial de Deauville',
        MEET_TAG => '2011',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-07-26',
            DATE_END => '2011-07-26'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-07-17',
            DATE_END => '2012-07-21'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-07-22',
            DATE_END => '2013-07-23'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SESSION',
            DATE_START => '2014-07-18',
            DATE_END => '2014-07-26'
          } 
        }
      },
    }
  },

  'Deauville Patton Teams',
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-07-19',
            DATE_END => '2010-07-19'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-07-21',
            DATE_END => '2010-07-21'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-07-25',
            DATE_END => '2011-07-27'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-07-16',
            DATE_END => '2012-07-18'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2013-07-19',
            DATE_END => '2013-07-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-07-22',
            DATE_END => '2013-07-24'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SESSION',
            DATE_START => '2015-07-17',
            DATE_END => '2015-07-17'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SESSION',
            DATE_START => '2015-07-20',
            DATE_END => '2015-07-22'
          },
          'C2' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SESSION',
            DATE_START => '2015-07-25',
            DATE_END => '2015-07-25'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-07-25',
            DATE_END => '2016-07-27'
          } 
        }
      },
    }
  },

  'French Cup',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'MATCH',
            DATE_START => '2005-09-17',
            DATE_END => '2005-09-18'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Rof16',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'HALF',
            DATE_START => '2006-12-17',
            DATE_END => '2006-12-17'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'HALF',
            DATE_START => '2006-12-18',
            DATE_END => '2006-12-18'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2006-12-19',
            DATE_END => '2006-12-19'
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
            STAGE => 'Rof16',
            major => 'SESSION',
            DATE_START => '2008-12-21',
            DATE_END => '2008-12-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-21',
            DATE_END => '2008-12-21'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-21',
            DATE_END => '2008-12-21'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-21',
            DATE_END => '2008-12-21'
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
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-19'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-19'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-12-20',
            DATE_END => '2009-12-20'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-20',
            DATE_END => '2009-12-20'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Rof16',
            major => 'SESSION',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-18'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-18',
            DATE_END => '2010-12-18'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-12-19',
            DATE_END => '2010-12-19'
          },
          'C3' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-19',
            DATE_END => '2010-12-19'
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
            STAGE => 'Rof16',
            DATE_START => '2014-12-20',
            DATE_END => '2014-12-20'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            DATE_START => '2014-12-20',
            DATE_END => '2014-12-20'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-12-21',
            DATE_END => '2014-12-21'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'HALF',
            DATE_START => '2014-12-21',
            DATE_END => '2014-12-21'
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
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2015-09-19',
            DATE_END => '2015-09-20'
          } 
        }
      },
    }
  },

  'French First Division',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006-07' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2006-11-27',
            DATE_END => '2006-11-27'
          },
        }
      },
      '2007-08' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
          },
          'C1' => 
          {
            YEAR => 2007,
            major => 'SEGMENT',
            minor => 'HALF',
            DATE_START => '2007-11-05',
            DATE_END => '2007-11-05'
          },
          'C2' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
        }
      },
      '2008-09' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            minor => 'SESSION',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-02-14',
            DATE_END => '2009-02-14'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-15',
            DATE_END => '2009-02-15'
          },
        }
      },
      '2009-10' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-09-19',
            DATE_END => '2009-09-20'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-12-19',
            DATE_END => '2009-12-20'
          },
          'C2' =>
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-02-06',
            DATE_END => '2010-02-06'
          },
          'C3' =>
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-02-07',
            DATE_END => '2010-02-07'
          }
        }
      },
      '2010-11' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2010-09-04',
            DATE_END => '2010-09-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2010-09-25',
            DATE_END => '2010-09-26'
          },
          'C2' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-31'
          },
          'C3' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            DATE_START => '2010-11-20',
            DATE_END => '2010-11-21'
          },
          'C4' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-01-29',
            DATE_END => '2011-01-29'
          },
          'C5' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-01-30',
            DATE_END => '2011-01-30'
          }
        }
      },
      '2011-12' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'MATCH',
            DATE_START => '2011-09-17',
            DATE_END => '2011-09-18'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-10-01',
            DATE_END => '2011-10-02'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-11-05',
            DATE_END => '2011-11-06'
          },
          'C3' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-11-19',
            DATE_END => '2011-11-20'
          },
          'C4' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'ROUND',
            DATE_START => '2012-01-28',
            DATE_END => '2012-01-28'
          },
          'C5' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2012-01-29',
            DATE_END => '2012-01-30'
          }
        }
      },
      '2012-13' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-15',
            DATE_END => '2012-09-16'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-30'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-10-20',
            DATE_END => '2012-10-21'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-01-25',
            DATE_END => '2013-01-25'
          },
          'C5' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-27'
          }
        }
      },
      '2013-14' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
          },
          'C2' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-27'
          },
          'C3' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-24'
          },
          'C4' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-01-24',
            DATE_END => '2014-01-24'
          },
          'C5' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          }
        }
      },
      '2014-15' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-14'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            minor => 'SESSION',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          },
          'C2' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-11-08',
            DATE_END => '2014-11-09'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          },
          'C4' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-23'
          },
          'C5' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-25'
          }
        }
      },
      '2015-16' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-10-24',
            DATE_END => '2015-10-25'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-11-07',
            DATE_END => '2015-11-08'
          },
          'C2' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-01-29',
            DATE_END => '2016-01-29'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          }
        }
      },
    }
  },

  'French Intercircle',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-01-09',
            DATE_END => '2011-01-09'
          } 
        }
      },
    }
  },

  'French Junior Trials',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-02-26',
            DATE_END => '2005-02-27'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
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
            major => 'SESSION',
            DATE_START => '2009-03-14',
            DATE_END => '2009-03-15'
          } 
        }
      },
    }
  },

  'French Mixed Teams',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            major => 'ROUND',
            DATE_START => '2004-04-18',
            DATE_END => '2004-04-18'
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
            major => 'MATCH',
            DATE_START => '2009-05-02',
            DATE_END => '2009-05-03'
          } 
        }
      },
    }
  },

  'French Open Teams',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
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
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-06-17',
            DATE_END => '2005-06-17'
          } 
        }
      },
    }
  },

  'French Open Trials',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
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
            major => 'SEGMENT',
            DATE_START => '2005-09-24',
            DATE_END => '2005-09-25'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-10-14',
            DATE_END => '2005-10-16'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-09',
            DATE_END => '2005-12-09'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-15',
            DATE_END => '2007-09-15'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-16',
            DATE_END => '2007-09-16'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-16',
            DATE_END => '2007-12-16'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          # Could potentially be two selections, further apart in time.
          'C0' => 
          {
            YEAR => 2008,
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C1' => 
          {
            YEAR => 2008,
            major => 'SEGMENT',
            DATE_START => '2008-04-03',
            DATE_END => '2008-04-03'
          }
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-03-03',
            DATE_END => '2010-03-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-04-03',
            DATE_END => '2010-04-05'
          },
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Rof28',
            major => 'ROUND',
            DATE_START => '2011-09-23',
            DATE_END => '2011-09-25'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Rof16',
            major => 'ROUND',
            DATE_START => '2011-11-14',
            DATE_END => '2011-11-18'
          },
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Rof14',
            major => 'ROUND',
            DATE_START => '2013-11-13',
            DATE_END => '2013-11-17'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-14',
            DATE_END => '2014-04-21'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-09-16',
            DATE_END => '2015-09-18'
          },
        }
      }
    },
  },

  'French Senior Trials',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-04-19',
            DATE_END => '2004-04-19'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-04-23',
            DATE_END => '2005-04-25'
          },
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-04-19',
            DATE_END => '2006-04-19'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-04-22',
            DATE_END => '2006-04-22'
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
            DATE_START => '2008-04-16',
            DATE_END => '2008-04-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-04-17',
            DATE_END => '2008-04-17'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Rof16',
            major => 'ROUND',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-21',
            DATE_END => '2010-04-22'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'SEGMENT',
            DATE_START => '2010-04-27',
            DATE_END => '2010-04-29'
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
            major => 'ROUND',
            DATE_START => '2012-03-08',
            DATE_END => '2012-03-09'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-01-16',
            DATE_END => '2014-01-17'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-01-24',
            DATE_END => '2014-01-24'
          } 
        }
      },
    }
  },

  'French Women Trials',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-04',
            DATE_END => '2010-04-05'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-07',
            DATE_END => '2010-05-09'
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
            major => 'ROUND',
            DATE_START => '2012-04-07',
            DATE_END => '2012-04-08'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-04-19',
            DATE_END => '2014-04-19'
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
            major => 'SEGMENT',
            DATE_START => '2015-08-29',
            DATE_END => '2015-08-30'
          } 
        }
      },
    }
  },

  'French U28 Trials',
  {
    ORGANIZATION => 'FFB',
    COUNTRY => 'France',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U28',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Rof12',
            major => 'ROUND',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
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

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_FRANCE, \%TOURNAMENTS_FRANCE, 'France');
}

1;
