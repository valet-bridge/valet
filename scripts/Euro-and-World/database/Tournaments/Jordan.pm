#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Jordan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Some names here:
# https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=jbf&pid=table_competitions_201

my %GLOBAL = (
  ORGANIZATION => 'JBA',
  COUNTRY => 'Jordan',
  ZONE => 'Africa',
);

my %MEETS_JORDAN =
(
  'Jordan Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2011' =>
      {
        ORDINAL => 30,
        YEAR => 2011,
        DATE_START => '2011-12-01',
        DATE_END => '2011-12-04'
      },
      '2013' =>
      {
        ORDINAL => 32,
        YEAR => 2013,
        DATE_START => '2013-11-06',
        DATE_END => '2013-11-10'
      },
      '2014' =>
      {
        ORDINAL => 33,
        CITY => 'Amman',
        YEAR => 2014,
        DATE_START => '2014-11-04',
        DATE_END => '2014-11-09'
      },
      '2015' =>
      {
        ORDINAL => 34,
        CITY => 'Amman',
        YEAR => 2015,
        DATE_START => '2015-11-04',
        DATE_END => '2015-11-11'
      },
      '2016' =>
      {
        ORDINAL => 35,
        YEAR => 2016,
        CITY => 'Amman',
        DATE_START => '2016-10-19',
        DATE_END => '2016-10-23'
      },
      '2018' =>
      {
        ORDINAL => 37,
        YEAR => 2018,
        CITY => 'Amman',
        DATE_START => '2018-10-17',
        DATE_END => '2018-10-21'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/annual-jordan-international-bridge-festival-2019
        ORDINAL => 38,
        YEAR => 2019,
        CITY => 'Amman',
        DATE_START => '2019-10-16',
        DATE_END => '2019-10-16'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/annual-jordan-international-bridge-festival-2022
        YEAR => 2022,
        DATE_START => '2022-09-28',
        DATE_END => '2022-10-03'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/annual-jordan-international-bridge-festival-2023
        YEAR => 2023,
        DATE_START => '2023-09-27',
        DATE_END => '2023-10-02'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/annual-jordan-international-bridge-festival-2024
        YEAR => 2024,
        DATE_START => '2024-09-25',
        DATE_END => '2024-09-30'
      },
    }
  },

  'Jordan Spring Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2015A' =>
      {
        YEAR => 2015,
        DATE_START => '2015-05-03',
        DATE_END => '2015-05-06'
      },
      '2015B' =>
      {
        YEAR => 2015,
        DATE_START => '2015-05-19',
        DATE_END => '2015-05-26'
      },
      '2016' =>
      {
        YEAR => 2016,
        DATE_START => '2016-04-04',
        DATE_END => '2016-04-05'
      },
    }
  },
);

my %TOURNAMENTS_JORDAN =
(
  'Jordan Mixed Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-11-08',
            DATE_END => '2014-11-09'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-11-07',
            DATE_END => '2015-11-11'
          } 
        }
      },
    }
  },

  'Jordan Open Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'SESSION',
            DATE_START => '2011-12-01',
            DATE_END => '2011-12-02'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-11-06',
            DATE_END => '2013-11-08'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-11-05',
            DATE_END => '2014-11-07'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-11-04',
            DATE_END => '2015-11-07'
          } 
        }
      },
    }
  },

  'Jordan Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Jordan Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-03',
            DATE_END => '2011-12-04'
          } 
        }
      },
    }
  },

  'Jordan Spring Mixed Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        MEET => 'Jordan Spring Festival',
        MEET_TAG => '2015A',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-05-05',
            DATE_END => '2015-05-06'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Jordan Spring Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-04-05',
            DATE_END => '2016-04-05'
          } 
        }
      },
    }
  },

  'Jordan Spring Open Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015A' =>
      {
        MEET => 'Jordan Spring Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-05-03',
            DATE_END => '2015-05-04'
          },
        }
      },
      '2015B' =>
      {
        # Something to do with BFAME starting 2015-05-27?
        MEET => 'Jordan Spring Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-19',
            DATE_END => '2015-05-21'
          },
          'C1' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-26',
            DATE_END => '2015-05-26'
          },
        }
      },
      '2016' =>
      {
        MEET => 'Jordan Spring Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-04-04',
            DATE_END => '2016-04-04'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_JORDAN, \%TOURNAMENTS_JORDAN, 'Jordan');
}

1;
