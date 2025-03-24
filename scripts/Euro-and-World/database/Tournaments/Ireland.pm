#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Ireland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'IBU',
  COUNTRY => 'Ireland',
  ZONE => 'Europe',
);


# TODO Cities are a guess.
# TODO There are no links to actual results.
# https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=cbai&pid=display_home
# doesn't have a search function, and seems to stop in 2022.
# https://www.fob.ie/national/
# seems random.

my %MEETS_IRELAND =
(
);

my %TOURNAMENTS_IRELAND =
(
  'Egan Trophy' =>
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
            DATE_START => '2019-05-25',
            DATE_END => '2019-05-26'
          },
        }
      },
    }
  },

  'Full Tilt Irish Bridge Masters' =>
  {
    COUNTRY => 'Ireland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CITY => 'Galway',
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
      }
    }
  },

  'Irish Invitational Pairs' =>
  {
    ORGANIZATION => 'IBU',
    COUNTRY => 'Ireland',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        # https://www.fob.ie/national/invitational-premier-pairs-championship/
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-04-08',
            DATE_END => '2016-04-08'
          },
          'C1' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-05-27',
            DATE_END => '2016-05-27'
          },
          'C2' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-06-10',
            DATE_END => '2016-06-10'
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
            DATE_START => '2017-10-06',
            DATE_END => '2017-10-08'
          },
        }
      },
    }
  },

  'Irish Open Trials' =>
  {
    ORGANIZATION => 'CBAI',
    COUNTRY => 'Ireland',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            DATE_START => '2012-11-24',
            DATE_END => '2012-11-25'
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
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2013-10-05',
            DATE_END => '2013-10-06'
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
            DATE_START => '2014-01-17',
            DATE_END => '2014-01-18'
          } ,
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19'
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
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-12',
            DATE_END => '2015-09-13'
          } 
        }
      },

      '2016A' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          } 
        }
      },
      '2016B' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-10-14',
            DATE_END => '2016-10-16'
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
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-28'
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
            DATE_START => '2019-10-26',
            DATE_END => '2019-10-28'
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
            DATE_START => '2023-02-05',
            DATE_END => '2023-02-05'
          } 
        }
      }
    }
  },

  'Irish Premier Pairs' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            DATE_START => '2017-10-06',
            DATE_END => '2017-10-06'
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
            DATE_START => '2018-11-09',
            DATE_END => '2018-11-11'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            DATE_START => '2019-11-22',
            DATE_END => '2019-11-24'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_IRELAND, \%TOURNAMENTS_IRELAND, 'Ireland');
}

1;
