#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Norway;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'NBF',
  COUNTRY => 'Norway',
  ZONE => 'Europe',
);

my %MEETS_NORWAY =
(
  'Norwegian Bridge Festival' =>
  {
    # https://bridgefestival.no/resultater

    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-08-05',
        DATE_END => '2005-08-05'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-08-06',
        DATE_END => '2006-08-09'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-08-05',
        DATE_END => '2007-08-05'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-08-12',
        DATE_END => '2008-08-12'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-08-02',
        DATE_END => '2009-08-09'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-07-31',
        DATE_END => '2010-08-07'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-07-30',
        DATE_END => '2011-08-06'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-08-04',
        DATE_END => '2012-08-11'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-08-03',
        DATE_END => '2013-08-12'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-08-02',
        DATE_END => '2014-08-10'
      },
      '2016' =>
      {
        YEAR => 2016,
        CITY => 'Fredrikstad',
        DATE_START => '2016-07-29',
        DATE_END => '2016-08-07'
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Oslo',
        DATE_START => '2017-08-02',
        DATE_END => '2017-08-13'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-08-03',
        DATE_END => '2018-08-11'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-08-03',
        DATE_END => '2019-08-10'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-08-03',
        DATE_END => '2020-08-08'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-08-01',
        DATE_END => '2021-08-07'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-08-06',
        DATE_END => '2022-08-13'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-08-06',
        DATE_END => '2023-08-12'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-08-02',
        DATE_END => '2024-08-12'
      },
    }
  },

  'Norwegian Championships' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-09-19',
        DATE_END => '2014-09-21'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-09-18',
        DATE_END => '2015-09-20'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-09-23',
        DATE_END => '2016-09-25'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-09-22',
        DATE_END => '2017-09-24'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-09-21',
        DATE_END => '2018-09-23'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-20',
        DATE_END => '2019-09-22'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-09-18',
        DATE_END => '2020-09-20'
      },
      '2021' =>
      {
        YEAR => 2021,
        DATE_START => '2021-10-02',
        DATE_END => '2021-10-03'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-09-23',
        DATE_END => '2022-09-25'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-09-22',
        DATE_END => '2023-09-24'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-09-20',
        DATE_END => '2024-09-22'
      },
    }
  },
);

my %TOURNAMENTS_NORWAY =
(
  'Bergen Grand Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Bergen',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2006-02-01',
            DATE_END => '2006-02-01'
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
            major => 'SEGMENT',
            DATE_START => '2007-01-24',
            DATE_END => '2007-01-24'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'SESSION',
            DATE_START => '2008-01-22',
            DATE_END => '2008-01-22'
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
            major => 'SESSION',
            DATE_START => '2010-01-23',
            DATE_END => '2010-01-24'
          } 
        }
      },
      '2011' =>
      {
        SPONSOR => 'Ragn Sells',
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
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-04-16',
            DATE_END => '2016-04-17'
          } 
        }
      },
    }
  },

  'FX Securities Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    SPONSOR => 'FX Securities',
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
            major => 'SEGMENT',
            DATE_START => '2011-10-15',
            DATE_END => '2011-10-16'
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
            major => 'SEGMENT',
            DATE_START => '2012-10-20',
            DATE_END => '2012-10-21'
          } 
        }
      },
    }
  },

  'Farmen Invitational' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # The dates are rough guesses based on their BBO numbers.
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH|ROUND',
            DATE_START => '2005-05-21',
            DATE_END => '2005-05-23'
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
            major => 'MATCH',
            DATE_START => '2006-05-09',
            DATE_END => '2006-05-09'
          } 
        }
      },
      '2007' =>
      {
        ORDINAL => 4,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Round-robin',
            major => 'MATCH',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          } 
        }
      },
    }
  },

  'FOSS Grand Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    CITY => 'Fredrikstad',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2009-08-29',
            DATE_END => '2009-08-30'
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
            groupon => 'GROUP',
            major => 'SESSION',
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-29'
          } 
        }
      },
      '2011' =>
      {
        # https://www.bridge.no/var/ruter/html/0219/2011-09-04-foss2.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            minor => 'SEGMENT',
            DATE_START => '2011-09-03',
            DATE_END => '2011-09-04'
          } 
        }
      },
      '2012' =>
      {
        # https://www.bridge.no/var/ruter/html/0219/2012-09-09-foss2.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            groupon => 'GROUP',
            major => 'SESSION',
            DATE_START => '2012-09-08',
            DATE_END => '2012-09-09'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0219/2013-09-08-fosssndag.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-09-07',
            DATE_END => '2013-09-08'
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
            major => 'SESSION|ROUND',
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-07'
          } 
        }
      },
    }
  },

  'Gardermoen Airport Hotel Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    LOCALITY => 'Gardermoen',
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
            major => 'ROUND',
            DATE_START => '2011-01-08',
            DATE_END => '2011-01-08'
          } 
        }
      },
    }
  },

  'Gardermoen Airport Hotel Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    LOCALITY => 'Gardermoen',
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
            major => 'MATCH',
            DATE_START => '2011-01-09',
            DATE_END => '2011-01-09'
          } 
        }
      },
    }
  },

  "Jessheim New Year's Pairs" =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Jessheim',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2015-01-02',
            DATE_END => '2015-01-02'
          } 
        }
      },
    }
  },

  "Jessheim New Year's Teams" =>
  {
    %GLOBAL,
    CITY => 'Jessheim',
    ORIGIN => 'Regional',
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
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-01-03',
            DATE_END => '2015-01-04'
          } 
        }
      },
    }
  },

  'Jotun Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-10-14',
            DATE_END => '2017-10-15'
          },
        }
      },
    }
  },

  'Marit Sveaas Open Pairs' =>
  {
    # https://msibt.org/Results

    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-08-05',
            DATE_END => '2016-08-07'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'SESSION',
            DATE_START => '2017-08-04',
            DATE_END => '2017-08-06'
          } 
        }
      },
      '2018' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CITY => 'Oslo',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'SESSION',
            DATE_START => '2018-06-29',
            DATE_END => '2018-07-01'
          } 
        }
      },
      '2019' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CITY => 'Oslo',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'SESSION',
            DATE_START => '2019-07-05',
            DATE_END => '2019-07-07'
          } 
        }
      },
      '2022' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CITY => 'Lillehammer',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'SESSION',
            DATE_START => '2022-05-27',
            DATE_END => '2022-05-29'
          } 
        }
      },
      '2024' =>
      {
        %GLOBAL,
        ORIGIN => 'National',
        CITY => 'Bodø',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            major => 'SESSION',
            DATE_START => '2024-05-24',
            DATE_END => '2024-05-26'
          } 
        }
      },
    }
  },

  'Mo i Rana Ladies Invitational' =>
  {
    %GLOBAL,
    ORIGIN => 'Invitational',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        # https://www.bridge.no/Turneringer/Turneringsresultater/Tidligere-aars-resultater/Resultater-2008-09
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'SESSION',
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          } 
        }
      },
    }
  },

  'Namsos Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SESSION',
            DATE_START => '2011-09-17',
            DATE_END => '2011-09-18'
          } 
        }
      },
    }
  },

  'Norwegian Club Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'ROUND',
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-01'
          } 
        }
      },
      '2020' =>
      {
        REGION => 'Telemark',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            major => 'ROUND',
            DATE_START => '2020-08-29',
            DATE_END => '2020-08-31'
          },
          'C1' => 
          {
            YEAR => 2020,
            major => 'ROUND',
            DATE_START => '2020-09-11',
            DATE_END => '2020-09-11'
          } 
        }
      },
    }
  },

  'Norwegian Club Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Interclub',
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
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2004-05-20',
            DATE_END => '2004-05-23'
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
            major => 'ROUND',
            DATE_START => '2005-05-05',
            DATE_END => '2005-05-07'
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
            major => 'ROUND|MATCH',
            minor => 'HALF',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
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
            STAGE => 'Semifinal',
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-05-20',
            DATE_END => '2009-05-24'
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
            minor => 'HALF|SEGMENT',
            DATE_START => '2010-05-13',
            DATE_END => '2010-05-16'
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
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2011-03-27',
            DATE_END => '2011-03-27'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-06-02',
            DATE_END => '2011-06-05'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-05-25',
            DATE_END => '2012-05-28'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/1611/2013-05-09-11.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-05-09',
            DATE_END => '2013-05-11'
          } 
        }
      },
      '2014' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/nmlag2014.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2014-05-28',
            DATE_END => '2014-05-31'
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
            minor => 'SEGMENT',
            DATE_START => '2015-05-28',
            DATE_END => '2015-05-30'
          } 
        }
      },
      '2016' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/finalenmklubblag2016.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-06-02',
            DATE_END => '2016-06-05'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-30',
            DATE_END => '2019-06-01'
          } 
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-10-15',
            DATE_END => '2020-10-18'
          } 
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-26',
            DATE_END => '2023-05-29'
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
            DATE_START => '2024-05-30',
            DATE_END => '2024-06-02'
          } 
        }
      },
    }
  },

  'Norwegian Corporate Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'Corporate',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            major => 'ROUND',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'Norwegian Mixed Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'SESSION',
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SESSION|SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-08-02',
            DATE_END => '2009-08-03'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-07-31',
            DATE_END => '2010-08-01'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION|SEGMENT',
            DATE_START => '2011-07-30',
            DATE_END => '2011-07-30'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-08-04',
            DATE_END => '2012-08-05'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-04'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-08-02',
            DATE_END => '2014-08-03'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-07-29',
            DATE_END => '2016-07-30'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            major => 'SESSION',
            DATE_START => '2017-08-10',
            DATE_END => '2017-08-11'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            major => 'SESSION',
            DATE_START => '2018-08-04',
            DATE_END => '2018-08-05'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'SESSION',
            DATE_START => '2019-08-03',
            DATE_END => '2019-08-04'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            major => 'SESSION',
            DATE_START => '2020-08-07',
            DATE_END => '2020-08-08'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            major => 'SESSION',
            DATE_START => '2021-08-01',
            DATE_END => '2021-08-01'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'SESSION',
            DATE_START => '2022-08-06',
            DATE_END => '2022-08-07'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            major => 'SESSION',
            DATE_START => '2024-08-03',
            DATE_END => '2024-08-04'
          } 
        }
      },
    }
  },

  'Norwegian Mixed Team Trials' =>
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
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          },
        }
      },
    }
  },

  'Norwegian Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-08-03',
            DATE_END => '2014-08-04'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-07-31',
            DATE_END => '2016-08-01'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-08-12',
            DATE_END => '2017-08-13'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-08-06',
            DATE_END => '2018-08-07'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-08-05',
            DATE_END => '2019-08-07'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2020-08-05',
            DATE_END => '2020-08-06'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2021-08-02',
            DATE_END => '2021-08-03'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-08-08',
            DATE_END => '2022-08-09'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-08-05',
            DATE_END => '2024-08-06'
          } 
        }
      },
    }
  },

  'Norwegian Open IMP Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            DATE_START => '2006-08-08',
            DATE_END => '2006-08-08'
          } 
        }
      },
    }
  },

  'Norwegian Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'SESSION|SEGMENT',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2009-08-05',
            DATE_END => '2009-08-07'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-08-03',
            DATE_END => '2010-08-05'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION|ROUND',
            DATE_START => '2011-08-02',
            DATE_END => '2011-08-04'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION|ROUND',
            DATE_START => '2012-08-07',
            DATE_END => '2012-08-09'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-08-06',
            DATE_END => '2013-08-08'
          } 
        }
      },
      '2014A' =>
      {
        MEET => 'Norwegian Bridge Festival',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            ignore => 'GROUP',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-09'
          } 
        }
      },
      '2014B' =>
      {
        MEET => 'Norwegian Championships',
        MEET_TAG => '2014',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION|SEGMENT',
            DATE_START => '2014-09-19',
            DATE_END => '2014-09-21'
          } 
        }
      },
      '2015' =>
      {
        # No festival in 2015
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-09-18',
            DATE_END => '2015-09-20'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-23',
            DATE_END => '2016-09-25'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-22',
            DATE_END => '2017-09-24'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-09-21',
            DATE_END => '2018-09-23'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-20',
            DATE_END => '2019-09-22'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-09-18',
            DATE_END => '2020-09-20'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-02',
            DATE_END => '2021-10-03'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-09-23',
            DATE_END => '2022-09-25'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-09-22',
            DATE_END => '2023-09-24'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Norwegian Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-09-20',
            DATE_END => '2024-09-22'
          } 
        }
      },
    }
  },

  'Norwegian Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            # Just a guess
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2006-08-06',
            DATE_END => '2006-08-06'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Rof16',
            DATE_START => '2014-08-06',
            DATE_END => '2014-08-06'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            DATE_START => '2014-08-07',
            DATE_END => '2014-08-07'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            DATE_START => '2014-08-07',
            DATE_END => '2014-08-07'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-08-08',
            DATE_END => '2014-08-08'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-01',
            DATE_END => '2016-08-02'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Rof16',
            major => 'ROUND',
            DATE_START => '2016-08-02',
            DATE_END => '2016-08-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-03',
            DATE_END => '2016-08-03'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-03',
            DATE_END => '2016-08-04'
          },
          'C4' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-08-04',
            DATE_END => '2016-08-04'
          }
        }
      },
      '2017A' =>
      {
        MEET_TAG => 2017,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-05-25',
            DATE_END => '2017-05-27'
          },
        }
      },
      '2017B' =>
      {
        MEET => 'Norwegian Bridge Festival',
        MEET_TAG => 2017,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-08-06',
            DATE_END => '2017-08-08'
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
            DATE_START => '2018-05-10',
            DATE_END => '2018-05-13'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-09',
            DATE_END => '2019-08-10'
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
            DATE_START => '2020-09-02',
            DATE_END => '2020-09-06'
          },
        }
      },
      '2021' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            DATE_START => '2021-09-16',
            DATE_END => '2021-09-19'
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
            DATE_START => '2022-05-19',
            DATE_END => '2022-05-22'
          },
        }
      },
    }
  },

  'Norwegian Patton Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2020' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-08-03',
            DATE_END => '2020-08-03'
          },
        }
      },
    }
  },

  'Norwegian Premier League' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004-05' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            major => 'ROUND|SESSION',
            DATE_START => '2004-11-13',
            DATE_END => '2004-11-13'
          },
          'C1' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-02-05',
            DATE_END => '2005-02-06'
          },
          'C2' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-27'
          }
        }
      },
      '2005-06' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'ROUND|SEGMENT',
            DATE_START => '2005-11-14',
            DATE_END => '2005-11-14'
          },
          'C1' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2006-02-07',
            DATE_END => '2006-02-07'
          },
        }
      },
      '2006-07' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
          'C1' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2007-02-11',
            DATE_END => '2007-02-11'
          },
          'C2' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-03-27',
            DATE_END => '2007-03-27'
          } 
        }
      },
      '2007-08' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
          'C1' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          } 
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
            minor => 'SEGMENT',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-02-13',
            DATE_END => '2009-02-15'
          } 
        }
      },
      '2009-10' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2009-10-23',
            DATE_END => '2009-10-25'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-01-07',
            DATE_END => '2010-01-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-12',
            DATE_END => '2010-02-14'
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
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2010-10-22',
            DATE_END => '2010-10-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-11-07',
            DATE_END => '2010-11-07'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-13'
          },
          'C3' => 
          {
            # ?
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-08',
            DATE_END => '2011-04-08'
          } 
        }
      },
      '2011-12' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2011-12
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2011-11-04',
            DATE_END => '2011-11-07'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-02-11',
            DATE_END => '2012-02-12'
          } 
        }
      },
      '2012-13' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2012-13
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-11-02',
            DATE_END => '2012-11-04'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'HALF|SEGMENT',
            DATE_START => '2013-02-09',
            DATE_END => '2013-02-10'
          } 
        }
      },
      '2013-14' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2013-14
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2013-11-01',
            DATE_END => '2013-11-03'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-02-08',
            DATE_END => '2014-02-09'
          } 
        }
      },
      '2014-15' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2014-15
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-11-07',
            DATE_END => '2014-11-09'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-02-07',
            DATE_END => '2015-02-08'
          } 
        }
      },
      '2015-16' =>
      {
        # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar/2015-16
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-02-06',
            DATE_END => '2016-02-07'
          } 
        }
      },

      # https://www.bridge.no/Turneringer/NM-for-klubblag/Tidligere-aar

      '2016-17' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-29',
            DATE_END => '2016-10-30'
          },
          'C1' => 
          {
            YEAR => 2017,
            DATE_START => '2017-02-11',
            DATE_END => '2017-02-12'
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
            DATE_START => '2017-10-28',
            DATE_END => '2017-10-29'
          },
          'C1' => 
          {
            YEAR => 2018,
            DATE_START => '2018-02-10',
            DATE_END => '2018-02-11'
          },
        }
      },
      '2018-19' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-27',
            DATE_END => '2018-10-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            DATE_START => '2019-02-09',
            DATE_END => '2019-02-10'
          },
        }
      },
      '2019-20' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-17',
            DATE_END => '2019-10-17'
          },
          'C1' => 
          {
            YEAR => 2019,
            DATE_START => '2019-11-09',
            DATE_END => '2019-11-10'
          },
          'C2' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-15',
            DATE_END => '2020-02-16'
          },
        }
      },
      '2021-22' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-29',
            DATE_END => '2021-10-31'
          },
          'C1' => 
          {
            YEAR => 2022,
            DATE_START => '2022-04-22',
            DATE_END => '2022-04-24'
          },
        }
      },
      '2023-24' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-27',
            DATE_END => '2023-10-29'
          },
          'C1' => 
          {
            YEAR => 2024,
            DATE_START => '2024-02-02',
            DATE_END => '2024-02-04'
          },
        }
      },
      '2024-25' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-11-15',
            DATE_END => '2024-11-17'
          },
        }
      },
    }
  },

  'Norwegian Senior Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-03-06',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'Norwegian Swiss Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2005-08-05',
            DATE_END => '2005-08-05'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2009-08-03',
            DATE_END => '2009-08-04'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Swiss',
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-08-01',
            DATE_END => '2010-08-02'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'SESSION|SEGMENT',
            DATE_START => '2011-07-31',
            DATE_END => '2011-08-01'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2012-08-05',
            DATE_END => '2012-08-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/9901/2013monradpar.htm
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2013-08-04',
            DATE_END => '2013-08-05'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-08-09',
            DATE_END => '2017-08-10'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-08-07',
            DATE_END => '2018-08-08'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-08-06',
            DATE_END => '2019-08-07'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-08-03',
            DATE_END => '2021-08-04'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-08-09',
            DATE_END => '2022-08-10'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Norwegian Bridge Festival',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-08-06',
            DATE_END => '2024-08-07'
          } 
        }
      },
    }
  },

  'Norwegian Swiss Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Swiss',
            major => 'MATCH',
            DATE_START => '2006-08-09',
            DATE_END => '2006-08-09'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND|SEGMENT',
            DATE_START => '2007-08-05',
            DATE_END => '2007-08-05'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2008-08-12',
            DATE_END => '2008-08-12'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND|SESSION',
            DATE_START => '2009-08-08',
            DATE_END => '2009-08-09'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2010-08-05',
            DATE_END => '2010-08-07'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-08-05',
            DATE_END => '2011-08-06'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-08-10',
            DATE_END => '2012-08-11'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-08-09',
            DATE_END => '2013-08-10'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-08-05',
            DATE_END => '2014-08-06'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2018-08-10',
            DATE_END => '2018-08-11'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2020-08-04',
            DATE_END => '2020-08-05'
          } 
        }
      },
      '2021' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2021-08-06',
            DATE_END => '2021-08-07'
          } 
        }
      },
      '2022' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2022-08-12',
            DATE_END => '2022-08-13'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Norwegian Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2024-08-09',
            DATE_END => '2024-08-10'
          } 
        }
      },
    }
  },

  'Norwegian Swiss Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2000,
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          },
        }
      },
    }
  },

  'Norwegian Team Trials' =>
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'SEGMENT',
            DATE_START => '2004-06-08',
            DATE_END => '2004-06-08'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-05-07',
            DATE_END => '2016-05-08'
          } 
        }
      },
    }
  },

  'Norwegian Women Invitational Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2009-10-31',
            DATE_END => '2009-10-31'
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
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-30'
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
            major => 'SESSION',
            DATE_START => '2011-10-29',
            DATE_END => '2011-10-29'
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-27'
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-26'
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2014-10-25',
            DATE_END => '2014-10-25'
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2015-10-31',
            DATE_END => '2015-10-31'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION|SEGMENT',
            DATE_START => '2016-11-19',
            DATE_END => '2016-11-19'
          } 
        }
      },
    }
  },

  'Norwegian Women Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2014-03-08',
            DATE_END => '2014-03-09'
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
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-26'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06'
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
            major => 'ROUND',
            DATE_START => '2017-03-11',
            DATE_END => '2017-03-12'
          } 
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
            DATE_START => '2018-03-10',
            DATE_END => '2018-03-11'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'ROUND',
            DATE_START => '2019-03-09',
            DATE_END => '2019-03-10'
          } 
        }
      },
      '2020' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            major => 'ROUND',
            DATE_START => '2020-03-07',
            DATE_END => '2020-03-08'
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
            major => 'ROUND',
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-06'
          } 
        }
      },
    }
  },

  'Olrud Easter Mixed Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'SESSION',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          } 
        }
      },
    }
  },

  'Olrud Easter Swiss Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
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
            MOVEMENT => 'Swiss',
            major => 'SESSION',
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
            MOVEMENT => 'Swiss',
            major => 'SESSION',
            DATE_START => '2010-03-27',
            DATE_END => '2010-03-28'
          } 
        }
      },
    }
  },

  'Olrud Easter Swiss Teams' =>
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
            DATE_START => '2005-03-25',
            DATE_END => '2005-03-25'
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
            major => 'MATCH',
            DATE_START => '2006-04-10',
            DATE_END => '2006-04-11'
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
            major => 'ROUND',
            DATE_START => '2007-04-11',
            DATE_END => '2007-04-11'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
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
            major => 'ROUND|MATCH',
            DATE_START => '2009-04-06',
            DATE_END => '2009-04-07'
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
            DATE_START => '2010-03-29',
            DATE_END => '2010-03-30'
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
            major => 'MATCH',
            DATE_START => '2011-04-17',
            DATE_END => '2011-04-18'
          } 
        }
      },
      '2012' =>
      {
        # https://www.bridge.no/var/ruter/html/0124/2012-04-02.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'MATCH|ROUND',
            DATE_START => '2012-04-01',
            DATE_END => '2012-04-02'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0124/2013-03-24.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-03-24',
            DATE_END => '2013-03-25'
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
            major => 'ROUND',
            DATE_START => '2014-04-13',
            DATE_END => '2014-04-14'
          } 
        }
      },
    }
  },

  'Rondane Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-10-09',
            DATE_END => '2010-10-09'
          } 
        }
      },
      '2011' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-08'
          } 
        }
      },
      '2012' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-10-06',
            DATE_END => '2012-10-06'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2013.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-05'
          } 
        }
      },
      '2014' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-10-04',
            DATE_END => '2014-10-04'
          } 
        }
      },
    }
  },

  'Rondane Teams Cup' =>
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
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-10-10',
            DATE_END => '2010-10-10'
          } 
        }
      },
      '2011' =>
      {
        # Link broken
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-09'
          } 
        }
      },
      '2012' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2012.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-10-07',
            DATE_END => '2012-10-07'
          } 
        }
      },
      '2013' =>
      {
        # https://www.bridge.no/var/ruter/html/0535/rc2013lag.htm
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
      '2014' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-10-05',
            DATE_END => '2014-10-05'
          } 
        }
      },
    }
  },

  'Ragn-Sells International Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-01-21',
            DATE_END => '2012-01-22'
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
            major => 'SESSION',
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20'
          } 
        }
      },
    }
  },

  'Rosfjord Swiss Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

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
            minor => 'SEGMENT',
            DATE_START => '2012-04-05',
            DATE_END => '2012-04-05'
          } 
        }
      },
    }
  },

  'Ruter 7 Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SEGMENT',
            DATE_START => '2010-06-19',
            DATE_END => '2010-06-19'
          } 
        }
      },
      '2012' =>
      {
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-05-12',
            DATE_END => '2012-05-12'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-05-13',
            DATE_END => '2012-05-13'
          } 
        }
      },
      '2013' =>
      {
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-02'
          } 
        }
      },
    }
  },

  'Snåsa Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            major => 'ROUND',
            DATE_START => '2011-11-26',
            DATE_END => '2011-11-26'
          } 
        }
      },
    }
  },

  'Telemark Club Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            DATE_START => '2020-09-11',
            DATE_END => '2020-09-11'
          },
        }
      },
    }
  },

  'Trondheim Pairs Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Trondheim',
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2011-05-07',
            DATE_END => '2011-05-07'
          } 
        }
      },
    }
  },

  'Trondheim Teams Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    CITY => 'Trondheim',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

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
            DATE_START => '2011-05-08',
            DATE_END => '2011-05-08'
          } 
        }
      },
    }
  },

  'Vest-Agder Regional Team Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
    REGION => 'Vest Agder',
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
            DATE_START => '2009-12-08',
            DATE_END => '2009-12-08'
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
            major => 'HALF',
            DATE_START => '2010-10-19',
            DATE_END => '2010-10-19'
          } 
        }
      },
      '2012A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-01-13',
            DATE_END => '2012-01-13'
          } 
        }
      },
      '2012B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            DATE_START => '2012-11-21',
            DATE_END => '2012-11-21'
          } 
        }
      },
    }
  },

  'Willy Brown Memorial Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            major => 'SEGMENT',
            DATE_START => '2011-12-03',
            DATE_END => '2011-12-03'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_NORWAY, \%TOURNAMENTS_NORWAY, 'Norway');
}

1;
