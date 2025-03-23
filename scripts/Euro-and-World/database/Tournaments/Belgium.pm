#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Belgium;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# No good source of old Belgian results.
# https://www.rbbf.be/

my %GLOBAL = (
  ORGANIZATION => 'RBBF',
  COUNTRY => 'Belgium',
  ZONE => 'Europe',
);

my %MEETS_BELGIUM =
(
);

my %TOURNAMENTS_BELGIUM =
(
  'Belgian Open Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2007-05-15',
            DATE_END => '2007-05-15'
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
            major => 'SESSION|SECTION',
            DATE_START => '2009-05-16',
            DATE_END => '2009-05-16'
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
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2011-05-21',
            DATE_END => '2011-05-21'
          } 
        }
      },
    }
  },

  'Belgian Open Teams',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-02-11',
            DATE_END => '2007-02-11'
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
            major => 'SEGMENT',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
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
            major => 'SEGMENT',
            DATE_START => '2010-02-07',
            DATE_END => '2010-02-07'
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2011-02-13',
            DATE_END => '2011-02-13'
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
            major => 'SEGMENT|SESSION',
            DATE_START => '2012-01-15',
            DATE_END => '2012-01-15'
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2013-01-13',
            DATE_END => '2013-01-13'
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
            DATE_START => '2016-01-31',
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2016-12-11',
            DATE_END => '2016-12-11'
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2017-12-10',
            DATE_END => '2017-12-10'
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2019-01-27',
            DATE_END => '2019-01-27'
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2023-02-04',
            DATE_END => '2023-02-05'
          } 
        }
      },
    }
  },

  'Belgian Open Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Final',
            major => 'SEGMENT|SESSION',
            DATE_START => '2012-02-12',
            DATE_END => '2012-02-12'
          } 
        }
      },
    }
  },

  'Belisol Invitational Pairs',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'ROUND|SESSION',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BELGIUM, \%TOURNAMENTS_BELGIUM, 'Belgium');
}

1;
