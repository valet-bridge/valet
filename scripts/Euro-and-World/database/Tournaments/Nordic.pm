#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Nordic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'NBU',
  ZONE => 'Europe',
);

my %MEETS_NORDIC =
(
  'Nordic Junior Championship',
  {
    %GLOBAL,
    ORIGIN => 'International',
    GENDER => 'Open',

    EDITIONS => 
    {
      '2009' =>
      {
        AGE => 'U25',
        YEAR => 2009,
        DATE_START => '2009-04-09',
        DATE_END => '2009-04-12'
      },
      '2010' =>
      {
        AGE => 'U25',
        YEAR => 2010,
        DATE_START => '2010-04-03',
        DATE_END => '2010-04-04'
      },
      '2011' =>
      {
        AGE => 'U25',
        YEAR => 2011,
        DATE_START => '2011-04-21',
        DATE_END => '2011-04-24'
      },
      '2012' =>
      {
        AGE => 'U26',
        YEAR => 2012,
        DATE_START => '2012-04-07',
        DATE_END => '2012-04-08'
      },
      '2013' =>
      {
        AGE => 'U25',
        YEAR => 2013,
        DATE_START => '2013-03-28',
        DATE_END => '2013-03-31'
      },
      '2015' =>
      {
        AGE => 'U25',
        YEAR => 2015,
        DATE_START => '2015-04-04',
        DATE_END => '2015-04-06'
      },
      '2016' =>
      {
        AGE => 'U26',
        YEAR => 2016,
        DATE_START => '2016-03-26',
        DATE_END => '2016-03-27'
      },
      '2017' =>
      {
        AGE => 'U26',
        YEAR => 2017,
        DATE_START => '2017-04-14',
        DATE_END => '2017-04-16'
      },
      '2019' =>
      {
        AGE => 'U26',
        YEAR => 2019,
        DATE_START => '2019-04-19',
        DATE_END => '2019-04-20'
      },
      '2023' =>
      {
        AGE => 'U26',
        YEAR => 2023,
        DATE_START => '2023-05-31',
        DATE_END => '2023-06-01'
      },
    }
  },

  'Nordic Team Championship',
  {
    %GLOBAL,
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS => 
    {
      '2005' =>
      {
        MEET_ORDINAL => 29,
        CITY => 'Vingsted',
        COUNTRY => 'Denmark',
        YEAR => 2005,
        DATE_START => '2005-07-01', # Estimated
        DATE_END => '2005-07-04'
      },
      '2007' =>
      {
        MEET_ORDINAL => 30,
        YEAR => 2007,
        DATE_START => '2007-06-05',
        DATE_END => '2007-06-09'
      },
      '2009' =>
      {
        MEET_ORDINAL => 31,
        YEAR => 2009,
        CITY => 'Turussa',
        COUNTRY => 'Finland',
        DATE_START => '2009-06-05',
        DATE_END => '2009-06-07'
      },
      '2011' =>
      {
        MEET_ORDINAL => 32,
        YEAR => 2011,
        DATE_START => '2011-05-27',
        DATE_END => '2011-05-29'
      },
      '2013' =>
      {
        # https://csbnews.org/iceland-nordic-teams-championships-2013/
        MEET_ORDINAL => 33,
        YEAR => 2013,
        CITY => 'Keflavik',
        COUNTRY => 'Iceland',
        DATE_START => '2013-05-24',
        DATE_END => '2013-05-26'
      },
      '2015' =>
      {
        MEET_ORDINAL => 34,
        YEAR => 2015,
        DATE_START => '2015-05-21',
        DATE_END => '2015-05-24'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-09-24',
        DATE_END => '2016-09-24'
      },
      '2017' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=21886
        MEET_ORDINAL => 35,
        YEAR => 2017,
        CITY => 'Horsens',
        COUNTRY => 'Denmark',
        DATE_START => '2017-06-02',
        DATE_END => '2017-06-04'
      },
      '2019' =>
      {
        # https://kvangraven.no/historikk/nordic-championship-2019/
        MEET_ORDINAL => 36,
        YEAR => 2019,
        CITY => 'Kristiansand',
        COUNTRY => 'Norway',
        DATE_START => '2019-06-07',
        DATE_END => '2019-06-09'
      },
      '2021' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25470
        MEET_ORDINAL => 37,
        YEAR => 2021,
        CITY => 'Online',
        DATE_START => '2021-05-29',
        DATE_END => '2021-05-30'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-05-26',
        DATE_END => '2022-05-29'
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/nm-2023/info
        MEET_ORDINAL => 38,
        YEAR => 2023,
        CITY => 'Örebro',
        COUNTRY => 'Sweden',
        DATE_START => '2023-05-30',
        DATE_END => '2023-06-01'
      },
    }
  },
);

my %TOURNAMENTS_NORDIC =
(
  'Nordic Cup',
  {
    %GLOBAL,
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # https://www.bridge.dk/turn/nordic_cup06/
        CITY => 'Rottneros',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2006-05-19',
            DATE_END => '2006-05-21'
          } 
        }
      },
      '2008' =>
      {
        # https://arkiv.svenskbridge.se/e107_plugins/league/season.php?action=view&id=352
        ORDINAL => 12,
        CITY => 'Rottneros',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2008-05-23',
            DATE_END => '2008-05-23'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2008-05-25',
            DATE_END => '2008-05-25'
          } 
        }
      },
    }
  },

  'Nordic Junior Pairs',
  {
    FORM => 'Pairs',
    SCORING => 'MP',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Nordic Junior Championship',
        ORDINAL => 1,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-04-03',
            DATE_END => '2010-04-04'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION|SEGMENT',
            DATE_START => '2012-04-07',
            DATE_END => '2012-04-08'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-03-26',
            DATE_END => '2016-03-27'
          } 
        }
      },
    }
  },

  'Nordic Junior Teams',
  {
    EDITIONS =>
    {
      '2005' =>
      {
        # TODO Is this one used?
        MEET => 'Nordic Team Championship',
        GENDER => 'Open',
        AGE => 'U26',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-07-01',
            DATE_END => '2005-07-04'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-04-09',
            DATE_END => '2009-04-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-04-21',
            DATE_END => '2011-04-24'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-30'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-30',
            DATE_END => '2013-03-31'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-04-04',
            DATE_END => '2015-04-06'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-04-14',
            DATE_END => '2017-04-16'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-04-19',
            DATE_END => '2019-04-20'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Nordic Junior Championship',
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-31',
            DATE_END => '2023-06-01'
          } 
        }
      },
    }
  },

  'Nordic Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-24'
          },
        }
      },
    }
  },

  'Nordic Open Teams',
  {
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-07-01',
            DATE_END => '2005-07-04'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-07'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-27',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-26'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND|MATCH',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-24'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND|MATCH',
            DATE_START => '2016-09-24',
            DATE_END => '2016-09-24'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND|MATCH',
            DATE_START => '2017-06-02',
            DATE_END => '2017-06-04'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND|MATCH',
            DATE_START => '2019-06-07',
            DATE_END => '2019-06-09'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'ROUND|MATCH',
            DATE_START => '2022-05-26',
            DATE_END => '2022-05-29'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            major => 'ROUND|MATCH',
            DATE_START => '2023-05-30',
            DATE_END => '2023-06-01'
          } 
        }
      },
    }
  },

  'Nordic Security Pro-Am Pairs',
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
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
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-21'
          } 
        }
      },
    }
  },

  'Nordic Women Teams',
  {
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-07-01',
            DATE_END => '2005-07-04'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            minor => 'HALF',
            DATE_START => '2007-06-05',
            DATE_END => '2007-06-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-07'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-27',
            DATE_END => '2011-05-29'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SEGMENT',
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-26'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND|MATCH',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-24'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'ROUND|MATCH',
            DATE_START => '2017-06-02',
            DATE_END => '2017-06-04'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'ROUND|MATCH',
            DATE_START => '2022-05-26',
            DATE_END => '2022-05-29'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Nordic Team Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            major => 'ROUND|MATCH',
            DATE_START => '2023-05-30',
            DATE_END => '2023-06-01'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_NORDIC, \%TOURNAMENTS_NORDIC, 'Nordic');
}

1;
