#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::France;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'FFB',
  COUNTRY => 'France',
  ZONE => 'Europe',
);

my %MEETS_FRANCE =
(
  'Festival de la Baule' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'La Baule-Escoublac',

    EDITIONS => 
    {
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-08-21',
        DATE_END => '2018-08-21'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-08-17',
        DATE_END => '2021-08-17'
      },
      '2023' =>
      {
        MEET_ORDINAL => 72,
        YEAR => 2023,
        DATE_START => '2023-08-15',
        DATE_END => '2023-08-15'
      },
    }
  },

  'Mondial de Deauville' =>
  {
    # https://festival-international-bridge-deauville.com/#

    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Deauville',

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
        SPONSOR => 'Jet Immo',
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
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-07-23',
        DATE_END => '2017-07-25'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-07-24',
        DATE_END => '2018-07-25'
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
        DATE_START => '2022-06-21',
        DATE_END => '2022-06-29'
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
  'Baule Patton Teams',
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Festival de la Baule',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2018-08-21',
            DATE_END => '2018-08-21'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-08-21',
            DATE_END => '2018-08-21'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-08-21',
            DATE_END => '2018-08-21'
          },
        }
      },
      '2021' =>
      {
        MEET => 'Festival de la Baule',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2021-08-17',
            DATE_END => '2021-08-17'
          },
          'C1' => 
          {
            YEAR => 2021,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2021-08-17',
            DATE_END => '2021-08-17'
          },
          'C2' => 
          {
            YEAR => 2021,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2021-08-17',
            DATE_END => '2021-08-17'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Festival de la Baule',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-08-15',
            DATE_END => '2023-08-15'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-08-15',
            DATE_END => '2023-08-15'
          },
          'C2' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-08-15',
            DATE_END => '2023-08-15'
          },
        }
      },
    }
  },
  'Biarritz Hiver',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        SPONSOR => 'Lavazza',
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
            ignore => 'TABLE',
            DATE_START => '2016-07-30',
            DATE_END => '2016-07-30'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            DATE_START => '2017-07-23',
            DATE_END => '2017-07-23'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            MOVEMENT => 'Barometer',
            DATE_START => '2022-06-21',
            DATE_END => '2022-06-21'
          },
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
            major => 'SESSION|ROUND',
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
      '2017' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2017-07-24',
            DATE_END => '2017-07-25'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-07-24',
            DATE_END => '2018-07-25'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            DATE_START => '2019-07-25',
            DATE_END => '2019-07-25'
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
            STAGE => 'Final',
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2013-07-19',
            DATE_END => '2013-07-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'SESSION|ROUND',
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
      '2019' =>
      {
        MEET => 'Mondial de Deauville',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'SESSION',
            DATE_START => '2019-07-23',
            DATE_END => '2019-07-23'
          } 
        }
      },
    }
  },

  'French Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'HALF',
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
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2016-12-17',
            DATE_END => '2016-12-17'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-12-17',
            DATE_END => '2016-12-17'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-12-18',
            DATE_END => '2016-12-18'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-12-18',
            DATE_END => '2016-12-18'
          },
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2017-12-16',
            DATE_END => '2017-12-16'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-12-16',
            DATE_END => '2017-12-17'
          },
          'C2' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-12-17',
            DATE_END => '2017-12-17'
          },
        }
      },
      '2018' =>
      {
        ORDINAL => 8,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2018-12-15',
            DATE_END => '2018-12-15'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-16',
            DATE_END => '2018-12-16'
          },
          'C2' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-16',
            DATE_END => '2018-12-16'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-12-21',
            DATE_END => '2019-12-21'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-12-22',
            DATE_END => '2019-12-22'
          },
          'C2' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-12-22',
            DATE_END => '2019-12-22'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2022-10-22',
            DATE_END => '2022-10-22'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-10-22',
            DATE_END => '2022-10-23'
          },
          'C2' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-10-23',
            DATE_END => '2022-10-23'
          },
          'D0' => 
          {
            YEAR => 2022,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2022-12-17',
            DATE_END => '2022-12-17'
          },
          'D1' => 
          {
            YEAR => 2022,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2022-12-17',
            DATE_END => '2022-12-17'
          },
          'D2' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-12-18',
            DATE_END => '2022-12-18'
          },
          'D3' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-12-18',
            DATE_END => '2022-12-18'
          },
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Rof16',
            major => 'SEGMENT',
            DATE_START => '2023-12-16',
            DATE_END => '2023-12-16'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-16',
            DATE_END => '2023-12-16'
          },
          'C2' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-16',
            DATE_END => '2023-12-17'
          },
          'C3' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-12-17',
            DATE_END => '2023-12-18'
          },
        }
      },
    }
  },

  'French First Division',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-30'
          },
          'C2' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-10-20',
            DATE_END => '2012-10-21'
          },
          'C3' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          },
          'C4' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            MOVEMENT => 'Round-robin',
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
            MOVEMENT => 'Round-robin',
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
            MOVEMENT => 'Round-robin',
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
      '2016-17' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'ROUND|MATCH',
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-25'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-10-01',
            DATE_END => '2016-10-02'
          },
          'C2' => 
          {
            YEAR => 2016,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2016-10-15',
            DATE_END => '2016-10-16'
          },
          'C3' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-10-22',
            DATE_END => '2016-10-23'
          },
          'C4' => 
          {
            YEAR => 2017,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-01-27',
            DATE_END => '2017-01-27'
          },
          'C5' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-01-28',
            DATE_END => '2017-01-29'
          }
        }
      },
      '2017' =>
      {
        # This is not really First Division.
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            ignore => 'SEGMENT',
            DATE_START => '2017-05-13',
            DATE_END => '2017-05-14'
          },
        }
      },
      '2017-18' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2017-09-16',
            DATE_END => '2017-09-17'
          },
          'C1' => 
          {
            YEAR => 2017,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2017-10-07',
            DATE_END => '2017-10-08'
          },
          'C2' => 
          {
            YEAR => 2017,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2017-10-21',
            DATE_END => '2017-10-22'
          },
          'C3' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-11-04',
            DATE_END => '2017-11-05'
          },
          'C4' => 
          {
            YEAR => 2017,
            major => 'ROUND',
            DATE_START => '2017-12-16',
            DATE_END => '2017-12-16'
          },
          'C5' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-01-19',
            DATE_END => '2018-01-19'
          },
          'C6' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-21'
          }
        }
      },
      '2018-19' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-09-15',
            DATE_END => '2018-09-16'
          },
          'C1' => 
          {
            YEAR => 2018,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2018-10-13',
            DATE_END => '2018-10-14'
          },
          'C2' => 
          {
            YEAR => 2018,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2018-10-20',
            DATE_END => '2018-10-21'
          },
          'C3' => 
          {
            YEAR => 2019,
            major => 'ROUND|MATCH',
            minor => 'SEGMENT|SESSION',
            DATE_START => '2019-01-19',
            DATE_END => '2019-01-20'
          },
          'C4' => 
          {
            YEAR => 2019,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-04-20',
            DATE_END => '2019-04-20'
          },
          'C5' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2019-04-21',
            DATE_END => '2019-04-22'
          }
        }
      },
      '2019-20' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2019-09-07',
            DATE_END => '2019-09-08'
          },
          'C1' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-10-05',
            DATE_END => '2019-10-06'
          },
          'C2' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2019-10-19',
            DATE_END => '2019-10-20'
          },
          'C3' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2019-11-09',
            DATE_END => '2019-11-10'
          },
          'C4' => 
          {
            YEAR => 2020,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2020-01-17',
            DATE_END => '2020-01-17'
          },
          'C5' => 
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2020-01-18',
            DATE_END => '2020-01-19'
          }
        }
      },
      '2021-22' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            major => 'ROUND|SEGMENT',
            ignore => 'SESSION',
            DATE_START => '2021-10-02',
            DATE_END => '2021-10-03'
          },
          'C1' => 
          {
            YEAR => 2021,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2021-10-16',
            DATE_END => '2021-10-17'
          },
          'C2' => 
          {
            YEAR => 2021,
            major => 'ROUND',
            DATE_START => '2021-11-06',
            DATE_END => '2021-11-07'
          },
          'C3' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2022-01-14',
            DATE_END => '2022-01-14'
          },
          'C4' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2022-01-15',
            DATE_END => '2022-01-16'
          }
        }
      },
      '2022-23' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-09-24',
            DATE_END => '2022-09-25'
          },
          'C1' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2022-10-01',
            DATE_END => '2022-10-02'
          },
          'C2' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-10-15',
            DATE_END => '2022-10-16'
          },
          'C3' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-11-05',
            DATE_END => '2022-11-06'
          },
          'C4' => 
          {
            YEAR => 2023,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-01-13',
            DATE_END => '2023-01-13'
          },
          'C5' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-01-14',
            DATE_END => '2023-01-15'
          }
        }
      },
      '2023-24' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2023-09-16',
            DATE_END => '2023-09-17'
          },
          'C1' => 
          {
            YEAR => 2023,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2023-09-30',
            DATE_END => '2023-10-01'
          },
          'C2' => 
          {
            YEAR => 2023,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2023-10-21',
            DATE_END => '2023-10-22'
          },
          'C3' => 
          {
            YEAR => 2023,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2023-11-04',
            DATE_END => '2023-11-05'
          },
          'C4' => 
          {
            YEAR => 2024,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-01-12',
            DATE_END => '2024-01-12'
          },
          'C5' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2024-01-13',
            DATE_END => '2024-01-14'
          }
        }
      },
      '2024' =>
      {
        # This is not really First Division.
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-09-14',
            DATE_END => '2024-09-15'
          },
        }
      },
    }
  },

  'French Intercircle',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

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
    %GLOBAL,
    ORIGIN => 'National',
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
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Final',
            major => 'ROUND|SESSION',
            DATE_START => '2024-05-25',
            DATE_END => '2024-05-26'
          } 
        }
      },
    }
  },

  'French Mixed Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-12-18',
            DATE_END => '2018-12-19'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-12-20',
            DATE_END => '2018-12-21'
          },
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2020-02-11',
            DATE_END => '2020-02-12'
          },
          'C1' => 
          {
            YEAR => 2020,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2020-02-13',
            DATE_END => '2020-02-14'
          },
          'C2' => 
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2020-02-17',
            DATE_END => '2020-02-18'
          },
        }
      },
    }
  },

  'French Open Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
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
            MOVEMENT => 'Round-robin',
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
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-09-08',
            DATE_END => '2015-09-10'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-09-16',
            DATE_END => '2015-09-18'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-02-03',
            DATE_END => '2018-02-04'
          },
        }
      },
      '2019A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND|SESSION',
            ignore => 'PHASE',
            DATE_START => '2019-02-11',
            DATE_END => '2019-02-15'
          },
        }
      },
      '2019B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND|MATCH',
            DATE_START => '2019-10-25',
            DATE_END => '2019-10-27'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-01-28',
            DATE_END => '2022-01-31'
          },
        }
      }
    },
  },

  'French Senior Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND|MATCH',
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
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-01-26',
            DATE_END => '2016-01-27'
          },
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-03-06',
            DATE_END => '2018-03-07'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2022,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2022-05-19',
            DATE_END => '2022-05-20'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2022-05-21',
            DATE_END => '2022-05-22'
          },
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            major => 'ROUND',
            DATE_START => '2024-03-18',
            DATE_END => '2024-03-19'
          },
        }
      },
    }
  },

  'French U26 Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            major => 'ROUND',
            DATE_START => '2023-10-13',
            DATE_END => '2023-10-16'
          },
        }
      },
    }
  },

  'French U31 Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U31',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2020-09-25',
            DATE_END => '2020-09-26'
          },
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'ROUND',
            DATE_START => '2022-12-10',
            DATE_END => '2022-12-11'
          },
        }
      },
    }
  },

  'French Women Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            MOVEMENT => 'Round-robin',
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
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND|MATCH',
            DATE_START => '2017-10-30',
            DATE_END => '2017-11-02'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            major => 'ROUND',
            DATE_START => '2018-02-09',
            DATE_END => '2018-02-11'
          },
          'C1' => 
          {
            YEAR => 2018,
            major => 'ROUND|SEGMENT',
            DATE_START => '2018-03-16',
            DATE_END => '2018-03-18'
          },
          'C2' => 
          {
            YEAR => 2018,
            major => 'ROUND|SEGMENT',
            DATE_START => '2018-03-30',
            DATE_END => '2018-04-01'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2022-05-21',
            DATE_END => '2022-05-21'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            major => 'SEGMENT|ROUND',
            DATE_START => '2024-03-16',
            DATE_END => '2024-03-17'
          } 
        }
      },
    }
  },

  'French U28 Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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

  'Mike Dennery Pairs Cup',
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            MOVEMENT => 'Barometer',
            major => 'SESSION',
            DATE_START => '2020-03-12',
            DATE_END => '2020-03-12'
          },
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
            major => 'SEGMENT|STANZA',
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
