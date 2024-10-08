#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Nordic;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_NORDIC =
(
  'Nordic Junior Championship',
  {
    ORGANIZATION => 'NBU',
    ORIGIN => 'International',
    ZONE => 'Europe',
    AGE => 'U26',
    GENDER => 'Open',

    EDITIONS => 
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-04-09',
        DATE_END => '2009-04-12'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-04-03',
        DATE_END => '2010-04-04'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-21',
        DATE_END => '2011-04-23'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-07',
        DATE_END => '2012-04-08'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-03-28',
        DATE_END => '2013-03-31'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-04-04',
        DATE_END => '2015-04-06'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-03-26',
        DATE_END => '2016-03-27'
      },
    }
  },

  'Nordic Team Championship',
  {
    ORGANIZATION => 'NBU',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS => 
    {
      '2005' =>
      {
        ORDINAL => 29,
        CITY => 'Vingsted',
        COUNTRY => 'Denmark',
        YEAR => 2005,
        DATE_START => '2005-07-01', # Estimated
        DATE_END => '2005-07-04'
      },
      '2007' =>
      {
        ORDINAL => 30,
        YEAR => 2007,
        DATE_START => '2007-06-05',
        DATE_END => '2007-06-09'
      },
      '2009' =>
      {
        ORDINAL => 31,
        YEAR => 2009,
        CITY => 'Turussa',
        COUNTRY => 'Finland',
        DATE_START => '2009-06-05',
        DATE_END => '2009-06-07'
      },
      '2011' =>
      {
        ORDINAL => 32,
        YEAR => 2011,
        DATE_START => '2011-05-27',
        DATE_END => '2011-05-29'
      },
      '2013' =>
      {
        # https://csbnews.org/iceland-nordic-teams-championships-2013/
        ORDINAL => 33,
        YEAR => 2013,
        CITY => 'Keflavik',
        COUNTRY => 'Iceland',
        DATE_START => '2013-05-24',
        DATE_END => '2013-05-26'
      },
      '2015' =>
      {
        ORDINAL => 34,
        YEAR => 2015,
        DATE_START => '2015-05-21',
        DATE_END => '2015-05-24'
      },
      '2017' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=21886
        ORDINAL => 35,
        YEAR => 2017,
        CITY => 'Horsens',
        COUNTRY => 'Denmark',
        DATE_START => '2017-06-02',
        DATE_END => '2017-06-04'
      },
      '2019' =>
      {
        # https://kvangraven.no/historikk/nordic-championship-2019/
        ORDINAL => 36,
        YEAR => 2019,
        CITY => 'Kristiansand',
        COUNTRY => 'Norway',
        DATE_START => '2019-06-07',
        DATE_END => '2019-06-09'
      },
      '2021' =>
      {
        # https://www2.bridge.dk/Default.aspx?ID=25470
        ORDINAL => 37,
        YEAR => 2021,
        CITY => 'Online',
        DATE_START => '2021-05-29',
        DATE_END => '2021-05-30'
      },
      '2023' =>
      {
        # https://www.svenskbridge.se/nm-2023/info
        ORDINAL => 38,
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
    ORGANIZATION => 'NBU',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # https://www.bridge.dk/turn/nordic_cup06/
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            CITY => 'Rottneros',
            DATE_START => '2006-05-19',
            DATE_END => '2006-05-21'
          } 
        }
      },
      '2008' =>
      {
        # https://arkiv.svenskbridge.se/e107_plugins/league/season.php?action=view&id=352
        ORDINAL => 12,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            CITY => 'Rottneros',
            DATE_START => '2008-05-23',
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
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
            DATE_START => '2016-03-26',
            DATE_END => '2016-03-27'
          } 
        }
      },
    }
  },

  'Nordic Junior Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',

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
            DATE_START => '2005-07-01',
            DATE_END => '2005-07-04'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-09',
            DATE_END => '2009-04-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-04-21',
            DATE_END => '2011-04-24'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-31'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Nordic Junior Championship',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-04-04',
            DATE_END => '2015-04-06'
          } 
        }
      },
    }
  },

  'Nordic Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
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
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-24'
          } 
        }
      },
    }
  },

  'Nordic Security Pro-Am Pairs',
  {
    ORGANIZATION => 'NBU',
    ORIGIN => 'International',
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
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-21'
          } 
        }
      },
    }
  },

  'Nordic Women Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
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
            DATE_START => '2013-05-24',
            DATE_END => '2013-05-26'
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
