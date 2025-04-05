#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Iceland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'IceBF',
  COUNTRY => 'Iceland',
  ZONE => 'Europe',
);

my %MEETS_ICELAND =
(
  'Northern Lights Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-09-23',
        DATE_END => '2016-09-25'
      },
      '2017' =>
      {
        YEAR => 2017,
        CITY => 'Siglufjordur',
        DATE_START => '2017-10-07',
        DATE_END => '2017-10-08'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-09-15',
        DATE_END => '2018-09-16'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-09-14',
        DATE_END => '2019-09-15'
      },
    }
  },

  'Reykjavik Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Reykjavik',

    EDITIONS =>
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-01-28',
        DATE_END => '2010-01-31'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-01-27',
        DATE_END => '2011-01-30'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-01-26',
        DATE_END => '2012-01-29'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-01-25',
        DATE_END => '2014-01-26'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-01-30',
        DATE_END => '2015-02-01'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-01-29',
        DATE_END => '2016-01-31'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-01-27',
        DATE_END => '2017-01-29'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-01-25',
        DATE_END => '2018-01-28'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-01-31',
        DATE_END => '2019-02-03'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-01-30',
        DATE_END => '2020-02-02'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-01-26',
        DATE_END => '2023-01-29'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-01-25',
        DATE_END => '2024-01-28'
      },
    }
  },
);

my %TOURNAMENTS_ICELAND =
(
  'Gunnars Birgisson Memorial' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        MEET => 'Northern Lights Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-09-03',
            DATE_END => '2022-09-04'
          },
        }
      },
    }
  },

  'Iceland Express Pairs' =>
  {
    FORM => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION|SEGMENT',
            DATE_START => '2010-01-28',
            DATE_END => '2010-01-29'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION|SEGMENT',
            DATE_START => '2011-01-27',
            DATE_END => '2011-01-28'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SESSION|SEGMENT',
            DATE_START => '2012-01-26',
            DATE_END => '2012-01-27'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION|ROUND',
            DATE_START => '2015-01-30',
            DATE_END => '2015-01-30'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION|ROUND',
            DATE_START => '2016-01-29',
            DATE_END => '2016-01-29'
          } 
        }
      },
    }
  },

  'Iceland Express Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND|SEGMENT',
            DATE_START => '2010-01-30',
            DATE_END => '2010-01-31'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SEGMENT',
            DATE_START => '2011-01-29',
            DATE_END => '2011-01-30'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-01-28',
            DATE_END => '2012-01-29'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SEGMENT',
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SEGMENT',
            DATE_START => '2015-01-31',
            DATE_END => '2015-02-01'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2024-01-25',
            DATE_END => '2024-01-28'
          } 
        }
      },
    }
  },

  'Icelandair Open Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SESSION|SEGMENT',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
          } 
        }
      },
    }
  },

  'Icelandair Open Teams' =>
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
            major => 'ROUND',
            DATE_START => '2005-02-24',
            DATE_END => '2005-02-24'
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
            major => 'ROUND',
            DATE_START => '2006-02-19',
            DATE_END => '2006-02-19'
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
            DATE_START => '2007-02-26',
            DATE_END => '2007-02-26'
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
            major => 'ROUND|SEGMENT',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
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
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-01-24',
            DATE_END => '2013-01-27'
          } 
        }
      },
    }
  },

  'Icelandic Cup' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-09-17',
            DATE_END => '2006-09-17'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-16',
            DATE_END => '2007-09-16'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-16',
            DATE_END => '2007-09-16'
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
            DATE_START => '2008-09-14',
            DATE_END => '2008-09-14'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-09-12',
            DATE_END => '2009-09-12'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-13',
            DATE_END => '2009-09-13'
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
            DATE_START => '2010-09-11',
            DATE_END => '2010-09-11'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-09-12',
            DATE_END => '2010-09-12'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-10',
            DATE_END => '2011-09-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-11'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-09-08',
            DATE_END => '2012-09-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-09',
            DATE_END => '2012-09-09'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-09-14',
            DATE_END => '2013-09-14'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-15',
            DATE_END => '2013-09-15'
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
            DATE_START => '2014-09-06',
            DATE_END => '2014-09-06'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-05',
            DATE_END => '2015-09-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-06',
            DATE_END => '2015-09-06'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-08-27',
            DATE_END => '2016-08-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-08-28',
            DATE_END => '2016-08-28'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-02',
            DATE_END => '2017-09-03'
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
            DATE_START => '2018-09-08',
            DATE_END => '2018-09-09'
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
            DATE_START => '2019-09-07',
            DATE_END => '2019-09-08'
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
            DATE_START => '2020-08-29',
            DATE_END => '2020-08-30'
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
            DATE_START => '2021-09-18',
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
            DATE_START => '2022-07-28',
            DATE_END => '2022-07-28'
          },
          'C1' => 
          {
            YEAR => 2022,
            DATE_START => '2022-09-13',
            DATE_END => '2022-09-13'
          },
          'C2' => 
          {
            YEAR => 2022,
            DATE_START => '2022-09-17',
            DATE_END => '2022-09-18'
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
            DATE_START => '2023-09-03',
            DATE_END => '2023-09-03'
          },
          'C1' => 
          {
            YEAR => 2023,
            DATE_START => '2023-09-17',
            DATE_END => '2023-09-17'
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
            DATE_START => '2024-09-22',
            DATE_END => '2024-09-22'
          },
        }
      },
    }
  },

  'Icelandic First Division' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-10-23',
            DATE_END => '2022-10-23'
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
            DATE_START => '2023-10-21',
            DATE_END => '2023-10-22'
          },
          'C1' =>
          {
            YEAR => 2023,
            DATE_START => '2023-11-19',
            DATE_END => '2023-11-19'
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
            DATE_START => '2024-10-20',
            DATE_END => '2024-10-20'
          },
          'C1' =>
          {
            YEAR => 2024,
            DATE_START => '2024-11-24',
            DATE_END => '2024-11-24'
          },
        }
      },
    }
  },

  'Icelandic Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-03-25',
            DATE_END => '2005-03-26'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-26'
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2009-04-23',
            DATE_END => '2009-04-26'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2010-04-22',
            DATE_END => '2010-04-24'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-04-25',
            DATE_END => '2010-04-25'
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
            STAGE => 'Final',
            major => 'ROUND|SEGMENT',
            DATE_START => '2011-04-29',
            DATE_END => '2011-05-01'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-02',
            DATE_END => '2011-05-02'
          } 
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2012-04-19',
            DATE_END => '2012-04-21'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-22',
            DATE_END => '2012-04-22'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2013-04-25',
            DATE_END => '2013-04-27'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-28',
            DATE_END => '2013-04-28'
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
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2014-04-24',
            DATE_END => '2014-04-26'
          },
          'C1' => 
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2015-04-23',
            DATE_END => '2015-04-25'
          },
          'C1' => 
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
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND|SEGMENT',
            DATE_START => '2016-04-21',
            DATE_END => '2016-04-23'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-04-24',
            DATE_END => '2016-04-24'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-04-20',
            DATE_END => '2017-04-23'
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
            DATE_START => '2018-04-19',
            DATE_END => '2018-04-22'
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
            DATE_START => '2019-04-25',
            DATE_END => '2019-04-28'
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
            DATE_START => '2022-04-21',
            DATE_END => '2022-04-24'
          },
        }
      },
      '2023A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-04-01',
            DATE_END => '2023-04-02'
          },
        }
      },
      '2023B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-04-20',
            DATE_END => '2023-04-23'
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
            DATE_START => '2024-03-24',
            DATE_END => '2024-03-24'
          },
          'C1' => 
          {
            YEAR => 2024,
            DATE_START => '2024-04-24',
            DATE_END => '2024-04-28'
          },
        }
      },
    }
  },

  'Northern Lights Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Northern Lights Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-23',
            DATE_END => '2016-09-23'
          } 
        }
      },
    }
  },

  'Northern Lights Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        MEET => 'Northern Lights Bridge Festival',
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
        MEET => 'Northern Lights Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-07',
            DATE_END => '2017-10-08'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Northern Lights Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-09-15',
            DATE_END => '2018-09-16'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Northern Lights Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-09-14',
            DATE_END => '2019-09-15'
          } 
        }
      },
    }
  },

  'Reykjavik Open Pairs' =>
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-01-27',
            DATE_END => '2017-01-27'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-25',
            DATE_END => '2018-01-26'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-01-31',
            DATE_END => '2019-02-01'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-30',
            DATE_END => '2020-02-01'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-26',
            DATE_END => '2023-01-27'
          } 
        }
      },
      '2024' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-01-25',
            DATE_END => '2024-01-26'
          } 
        }
      },
    }
  },

  'Reykjavik Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-01-28',
            DATE_END => '2017-01-29'
          } 
        }
      },
      '2018' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-01-27',
            DATE_END => '2018-01-28'
          } 
        }
      },
      '2019' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-02-02',
            DATE_END => '2019-02-03'
          } 
        }
      },
      '2020' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-02-01',
            DATE_END => '2020-02-02'
          } 
        }
      },
      '2023' =>
      {
        MEET => 'Reykjavik Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-28',
            DATE_END => '2023-01-29'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ICELAND, \%TOURNAMENTS_ICELAND, 'Iceland');
}

1;
