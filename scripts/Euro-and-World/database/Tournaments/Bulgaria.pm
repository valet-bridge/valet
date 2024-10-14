#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Bulgaria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_BULGARIA =
(
  'Albena Bridge Festival' =>
  {
    ORGANIZATION => 'BuBF',
    CITY => 'Albena',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'Transnational',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2008' =>
      {
        # https://www.bridgealbena.org/Albena/results2008.html
        YEAR => 2008,
        DATE_START => '2008-06-17',
        DATE_END => '2008-06-28'
      },
      '2009' =>
      {
        # https://www.bridgealbena.org/Albena/results2009.html
        YEAR => 2009,
        DATE_START => '2009-06-16',
        DATE_END => '2009-06-27'
      },
      '2010' =>
      {
        # https://www.bridgealbena.org/Albena/results2010.html
        YEAR => 2010,
        DATE_START => '2010-06-22',
        DATE_END => '2010-07-03'
      },
      '2011' =>
      {
        # https://www.bridgealbena.org/Albena/results2011.html
        YEAR => 2011,
        DATE_START => '2011-06-21',
        DATE_END => '2011-07-02'
      },
      '2012' =>
      {
        # https://www.bridgealbena.org/Albena/results2012.html
        YEAR => 2012,
        DATE_START => '2012-06-19',
        DATE_END => '2012-06-30'
      },
      '2013' =>
      {
        # https://www.bridgealbena.org/Albena/results2013.html
        YEAR => 2013,
        DATE_START => '2013-06-18',
        DATE_END => '2013-06-29'
      },
      '2014' =>
      {
        # https://www.bridgealbena.org/Albena/results2014.html
        YEAR => 2014,
        DATE_START => '2014-06-24',
        DATE_END => '2014-07-06'
      },
      '2015' =>
      {
        # https://www.bridgealbena.org/Albena/results2015.html
        YEAR => 2015,
        DATE_START => '2015-06-24',
        DATE_END => '2015-07-06'
      },
      '2016' =>
      {
        # https://www.bridgealbena.org/Albena/results2016.html
        YEAR => 2016,
        DATE_START => '2016-06-28',
        DATE_END => '2016-07-10'
      },
      '2017' =>
      {
        # https://www.bridgealbena.org/Albena/results2017.html
        YEAR => 2017,
        DATE_START => '2017-06-27',
        DATE_END => '2017-07-09'
      },
      '2018' =>
      {
        # https://www.bridgealbena.org/Albena/results2018.html
        YEAR => 2018,
        DATE_START => '2018-06-27',
        DATE_END => '2018-07-09'
      },
      '2019' =>
      {
        # https://www.bridgealbena.org/Albena/results2019.html
        YEAR => 2019,
        DATE_START => '2019-06-25',
        DATE_END => '2019-07-07'
      },
      '2020' =>
      {
        # https://www.bridgealbena.org/Albena/results2020.html
        YEAR => 2020,
        DATE_START => '2020-06-23',
        DATE_END => '2020-07-05'
      },
      '2021' =>
      {
        # https://www.bridgealbena.org/Albena/results2021.html
        YEAR => 2021,
        DATE_START => '2021-06-25',
        DATE_END => '2021-07-04'
      },
      '2022' =>
      {
        # https://www.bridgealbena.org/Albena/results2022.html
        YEAR => 2022,
        DATE_START => '2022-06-24',
        DATE_END => '2022-07-03'
      },
      '2023' =>
      {
        # https://www.bridgealbena.org/Albena/results2023.html
        YEAR => 2023,
        DATE_START => '2023-06-30',
        DATE_END => '2023-07-09'
      },
      '2024' =>
      {
        # https://www.bridgealbena.org/Albena/results2024.html
        YEAR => 2024,
        DATE_START => '2024-06-28',
        DATE_END => '2024-07-07'
      },
    }
  }
);

my %TOURNAMENTS_BULGARIA =
(
  'Bulgarian Open Pairs' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2013-01-26',
            DATE_END => '2013-01-27'
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
            DATE_START => '2014-01-25',
            DATE_END => '2014-01-26'
          } 
        }
      },
    }
  },

  'Bulgarian Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
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
            DATE_START => '2009-03-13',
            DATE_END => '2009-03-15'
          },
          'C1' => 
          {
            YEAR => 2009,
            DATE_START => '2009-03-27',
            DATE_END => '2009-03-29'
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
            DATE_START => '2013-02-07',
            DATE_END => '2013-02-10'
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
            DATE_START => '2014-02-06',
            DATE_END => '2014-02-09'
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
            DATE_START => '2015-01-29',
            DATE_END => '2015-02-01'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-02-04',
            DATE_END => '2016-02-07'
          },
        }
      },
    }
  },

  'Bulgarian Open Teams Gabi' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Bulgarian Open Trials' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
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
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-05-22',
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
            DATE_START => '2010-04-11',
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
            DATE_START => '2011-03-26',
            DATE_END => '2011-03-27'
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
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16'
          },
          'C1' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-04',
            DATE_END => '2014-04-06'
          } 
        }
      },
    }
  },

  'Bulgarian Women Trials' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            DATE_START => '2011-03-13',
            DATE_END => '2011-03-13'
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
            DATE_START => '2012-03-18',
            DATE_END => '2012-03-18'
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
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16'
          },
          'C1' => 
          {
            YEAR => 2014,
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-05'
          } 
        }
      },
    }
  },

  'Albena Open Teams' =>
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-06-28',
            DATE_END => '2012-06-30'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-07-04',
            DATE_END => '2014-07-06'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Albena Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-07-08',
            DATE_END => '2016-07-10'
          } 
        }
      },
    }
  },

  'IBF Dobrich' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Karlovo Pairs' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2009-02-27',
            DATE_END => '2009-02-27'
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
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-19'
          } 
        }
      },
    }
  },

  'Karlovo Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2000' =>
      {
        # Link
        MEET => 'Meet name',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2000,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2000-01-01',
            DATE_END => '2000-01-01'
          } 
        }
      },
    }
  },

  'Stara Zagora Open Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
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
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
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
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
          } 
        }
      },
    }
  },

  'Varna Titan Teams' =>
  {
    ORGANIZATION => 'BuBF',
    COUNTRY => 'Bulgaria',
    ORIGIN => 'National',
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
            DATE_START => '2013-08-16',
            DATE_END => '2013-08-16'
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
            DATE_START => '2014-08-15',
            DATE_END => '2014-08-16'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BULGARIA, \%TOURNAMENTS_BULGARIA, 'Bulgaria');
}

1;
