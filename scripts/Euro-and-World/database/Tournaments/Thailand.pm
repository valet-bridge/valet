#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Thailand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://results.cblt.or.th/history/

my %GLOBAL = (
  ORGANIZATION => 'CBLT',
  COUNTRY => 'Thailand',
  ZONE => 'South East Asia'
);

my %MEETS_THAILAND =
(
  'Bangkok Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Bangkok',
    ZONE => 'South East Asia',

    EDITIONS => 
    {
      '2013' =>
      {
        SPONSOR => 'Metropolitan Electricity Authority',
        YEAR => 2013,
        DATE_START => '2013-01-30',
        DATE_END => '2013-02-03'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-04-05',
        DATE_END => '2014-04-09'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-04-05',
        DATE_END => '2017-04-09'
      },
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-03-30',
        DATE_END => '2019-04-03'
      },
    }
  },

  'Thailand Championship' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    ZONE => 'South East Asia',

    EDITIONS => 
    {
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-10-09',
        DATE_END => '2016-10-09'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-11-11',
        DATE_END => '2017-11-12'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-09-17',
        DATE_END => '2022-09-18'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-09-02',
        DATE_END => '2023-09-04'
      },
      '2024' =>
      {
        YEAR => 2024,
        DATE_START => '2024-11-02',
        DATE_END => '2024-11-03'
      },
    }
  },

  'Thailand National Games' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    ZONE => 'South East Asia',

    EDITIONS => 
    {
      '2014' =>
      {
        MEET_ORDINAL => 43,
        CITY => 'Nakhon Ratchasima',
        YEAR => 2014,
        DATE_START => '2014-12-09',
        DATE_END => '2014-12-19'
      },
      '2015' =>
      {
        MEET_ORDINAL => 44,
        CITY => 'Nakhon Sawan',
        YEAR => 2015,
        DATE_START => '2015-12-12',
        DATE_END => '2015-12-21'
      },
      '2017' =>
      {
        MEET_ORDINAL => 45,
        CITY => 'Songkhla',
        YEAR => 2017,
        DATE_START => '2017-06-20',
        DATE_END => '2017-06-30'
      },
      '2018' =>
      {
        MEET_ORDINAL => 46,
        CITY => 'Chiang Rai',
        YEAR => 2018,
        DATE_START => '2018-11-18',
        DATE_END => '2018-11-28'
      },
      '2022' =>
      {
        # https://results.cblt.or.th/tour/8/
        ORDINAL => 47,
        YEAR => 2022,
        DATE_START => '2022-03-17',
        DATE_END => '2022-03-26'
      },
      '2023' =>
      {
        # https://results.cblt.or.th/tour/33/
        ORDINAL => 48,
        CITY => 'Kanchanaburi',
        YEAR => 2023,
        DATE_START => '2023-08-13',
        DATE_END => '2023-08-21'
      },
      '2024' =>
      {
        # https://results.cblt.or.th/tour/63/
        ORDINAL => 49,
        CITY => 'Chanthaburi',
        YEAR => 2024,
        DATE_START => '2024-12-09',
        DATE_END => '2024-12-17'
      },
    }
  },

  'Thailand National Youth Games' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET_ORDINAL => 33,
        YEAR => 2017,
        DATE_START => '2017-03-19',
        DATE_END => '2017-03-21'
      },
      '2018' =>
      {
        MEET_ORDINAL => 34,
        YEAR => 2018,
        DATE_START => '2018-03-22',
        DATE_END => '2018-03-25'
      },
      '2019' =>
      {
        MEET_ORDINAL => 35,
        YEAR => 2019,
        DATE_START => '2019-05-15',
        DATE_END => '2019-05-18'
      },
      '2022' =>
      {
        MEET_ORDINAL => 37,
        YEAR => 2022,
        DATE_START => '2022-08-01',
        DATE_END => '2022-08-04'
      },
      '2023' =>
      {
        MEET_ORDINAL => 38,
        YEAR => 2023,
        DATE_START => '2023-03-28',
        DATE_END => '2023-03-31'
      },
      '2024' =>
      {
        MEET_ORDINAL => 39,
        YEAR => 2024,
        DATE_START => '2024-03-26',
        DATE_END => '2024-03-29'
      },
    }
  },

  'Thailand University Games' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2017' =>
      {
        ORDINAL => 44,
        YEAR => 2017,
        DATE_START => '2017-02-24',
        DATE_END => '2017-02-24'
      },
      '2018' =>
      {
        ORDINAL => 45,
        YEAR => 2018,
        DATE_START => '2018-01-23',
        DATE_END => '2018-01-26'
      },
      '2019' =>
      {
        ORDINAL => 46,
        YEAR => 2019,
        DATE_START => '2019-01-12',
        DATE_END => '2019-01-16'
      },
      '2020' =>
      {
        ORDINAL => 47,
        YEAR => 2020,
        DATE_START => '2020-01-13',
        DATE_END => '2020-01-17'
      },
      '2022' =>
      {
        # TODO What is this?
        YEAR => 2022,
        DATE_START => '2022-03-21',
        DATE_END => '2022-03-22'
      },
      '2023' =>
      {
        ORDINAL => 48,
        YEAR => 2023,
        DATE_START => '2023-01-24',
        DATE_END => '2023-01-27'
      },
      '2024' =>
      {
        ORDINAL => 49,
        YEAR => 2024,
        DATE_START => '2024-01-31',
        DATE_END => '2024-02-02'
      },
    }
  },

);

my %TOURNAMENTS_THAILAND =
(
  'Bangkok Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Bangkok Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-01-31',
            DATE_END => '2013-02-02'
          },
          'C1' =>
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-02-03',
            DATE_END => '2013-02-03'
          },
          'C2' =>
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-03',
            DATE_END => '2013-02-03'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Bangkok Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-04-06',
            DATE_END => '2014-04-08'
          },
          'C1' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-04-09',
            DATE_END => '2014-04-09'
          },
          'C2' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-04-09',
            DATE_END => '2014-04-09'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Bangkok Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2017,
            DATE_START => '2017-04-06',
            DATE_END => '2017-04-09'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Bangkok Bridge Festival',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-03-31',
            DATE_END => '2019-04-03'
          },
        }
      },
    }
  },

  'Thailand Junior Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'U26',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2017,
            DATE_START => '2017-03-19',
            DATE_END => '2017-03-21'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            DATE_START => '2018-03-22',
            DATE_END => '2018-03-23'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-15',
            DATE_END => '2019-05-18'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-08-01',
            DATE_END => '2022-08-04'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-03-28',
            DATE_END => '2023-03-31'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-26',
            DATE_END => '2024-03-29'
          },
        }
      },
    }
  },

  'Thailand Junior Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U26',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2017,
            DATE_START => '2017-03-19',
            DATE_END => '2017-03-21'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            DATE_START => '2018-03-22',
            DATE_END => '2018-03-25'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-15',
            DATE_END => '2019-05-18'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-08-01',
            DATE_END => '2022-08-04'
          },
        }
      },
      '2023A' =>
      {
        MEET => 'Thailand National Youth Games',
        MEET_TAG => 2023,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-03-28',
            DATE_END => '2023-03-31'
          },
        }
      },
      '2023B' =>
      {
        MEET => 'Thailand Championship',
        MEET_TAG => 2023,
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-09-02',
            DATE_END => '2023-09-02'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-26',
            DATE_END => '2024-03-29'
          },
        }
      },
    }
  },

  'Thailand Junior Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U26',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2017,
            DATE_START => '2017-03-19',
            DATE_END => '2017-03-21'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            DATE_START => '2018-03-22',
            DATE_END => '2018-03-25'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2019,
            DATE_START => '2019-05-15',
            DATE_END => '2019-05-18'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-08-01',
            DATE_END => '2022-08-04'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-03-28',
            DATE_END => '2023-03-31'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand National Youth Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2024,
            DATE_START => '2024-03-26',
            DATE_END => '2024-03-29'
          },
        }
      },
    }
  },

  'Thailand Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-14'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-06-24',
            DATE_END => '2017-06-26'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-11-20',
            DATE_END => '2018-11-22'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-03-19',
            DATE_END => '2022-03-20'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-16',
            DATE_END => '2023-08-18'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-12',
            DATE_END => '2024-12-14'
          },
        }
      },
    }
  },

  'Thailand Open Team Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-03-10',
            DATE_END => '2019-03-10'
          },
        }
      },
    }
  },

  'Thailand Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C1' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-15',
            DATE_END => '2014-12-15'
          },
          'C2' =>
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-16',
            DATE_END => '2014-12-16'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Thailand Championship',
        MEET_TAG => '2016',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2016,
            DATE_START => '2016-10-09',
            DATE_END => '2016-10-09'
          },
        }
      },
      '2017A' =>
      {
        MEET => 'Thailand National Games',
        MEET_TAG => 2017,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-06-24',
            DATE_END => '2017-06-28'
          },
        }
      },
      '2017B' =>
      {
        MEET => 'Thailand Championship',
        MEET_TAG => 2017,
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-11-11',
            DATE_END => '2017-11-12'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-11-20',
            DATE_END => '2018-11-24'
          },
        }
      },
      '2022A' =>
      {
        MEET => 'Thailand National Games',
        MEET_TAG => '2022',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-03-21',
            DATE_END => '2022-03-22'
          },
        }
      },
      '2022B' =>
      {
        # https://results.cblt.or.th/tour/14/
        MEET => 'Thailand Championship',
        MEET_TAG => '2022',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-09-17',
            DATE_END => '2022-09-18'
          },
        }
      },
      '2023A' =>
      {
        MEET => 'Thailand National Games',
        MEET_TAG => '2023',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-16',
            DATE_END => '2023-08-20'
          },
        }
      },
      '2023B' =>
      {
        MEET => 'Thailand Championship',
        MEET_TAG => '2023',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2023,
            DATE_START => '2023-09-02',
            DATE_END => '2023-09-04'
          },
        }
      },
      '2024A' =>
      {
        MEET => 'Thailand Championship',
        MEET_TAG => '2024',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2024,
            DATE_START => '2024-11-02',
            DATE_END => '2024-11-03'
          },
        }
      },
      '2024B' =>
      {
        MEET => 'Thailand National Games',
        MEET_TAG => '2024',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-14',
            DATE_END => '2024-12-16'
          },
        }
      },
    }
  },

  'Thailand University Mixed Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2017' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-02-24',
            DATE_END => '2017-02-24'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-01-23',
            DATE_END => '2018-01-24'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-01-12',
            DATE_END => '2019-01-16'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-01-13',
            DATE_END => '2020-01-14'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-01-24',
            DATE_END => '2023-01-25'
          },
        }
      },
    }
  },

  'Thailand University Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-01-25',
            DATE_END => '2018-01-26'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-01-14',
            DATE_END => '2019-01-16'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-01-15',
            DATE_END => '2020-01-17'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-03-21',
            DATE_END => '2022-03-22'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-01-25',
            DATE_END => '2023-01-27'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-01-31',
            DATE_END => '2024-02-02'
          },
        }
      },
    }
  },

  'Thailand University Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'U31',

    EDITIONS =>
    {
      '2018' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-01-25',
            DATE_END => '2018-01-26'
          },
        }
      },
      '2019' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-01-14',
            DATE_END => '2019-01-16'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2020,
            DATE_START => '2020-01-15',
            DATE_END => '2020-01-17'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            DATE_START => '2022-03-21',
            DATE_END => '2022-03-22'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-01-25',
            DATE_END => '2023-01-27'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand University Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-01-31',
            DATE_END => '2024-02-02'
          },
        }
      },
    }
  },

  'Thailand Women Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-15',
            DATE_END => '2014-12-15'
          },
        }
      },
      '2017' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            DATE_START => '2017-06-24',
            DATE_END => '2017-06-26'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            DATE_START => '2018-11-20',
            DATE_END => '2018-11-24'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2022,
            DATE_START => '2022-03-21',
            DATE_END => '2022-03-22'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            DATE_START => '2023-08-18',
            DATE_END => '2023-08-20'
          },
        }
      },
      '2024' =>
      {
        MEET => 'Thailand National Games',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-12-14',
            DATE_END => '2024-12-16'
          },
        }
      },
    }
  },

  'Thailand Youth Games Mixed Teams' =>
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

  'Thailand Youth Games Open Teams' =>
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

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_THAILAND, \%TOURNAMENTS_THAILAND, 'Thailand');
}

1;
