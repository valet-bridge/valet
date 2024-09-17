#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Spain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# The Spanish results seem to be paywalled or not searchable.
# https://www.aebridge.com/es

my %MEETS_SPAIN =
(
  'Meet name' =>
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS => 
    {
      '2015' =>
      {
        # Link
        YEAR => 2000,
        CITY => 'Hamilton',
        DATE_START => '2000-01-01',
        DATE_END => '2000-01-01'
      },
    }
  }
);

my %TOURNAMENTS_SPAIN =
(
  'Spanish Central Zone Teams',
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2016' =>
      {
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-06-10',
            DATE_END => '2016-06-12'
          } 
        }
      },
    }
  },

  'Spanish Mixed Teams',
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
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
            DATE_START => '2016-01-17',
            DATE_END => '2016-01-17'
          } 
        }
      },
    }
  },

  'Spanish Open Teams',
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            major => 'ROUND',
            DATE_START => '2008-12-12',
            DATE_END => '2008-12-14'
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-12-11',
            DATE_END => '2009-12-13'
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
            major => 'ROUND',
            DATE_START => '2010-12-10',
            DATE_END => '2010-12-12'
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
            major => 'ROUND',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-12-15',
            DATE_END => '2011-12-17'
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
            major => 'ROUND',
            DATE_START => '2012-12-10',
            DATE_END => '2012-12-11'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-12-14',
            DATE_END => '2012-12-16'
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
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-22'
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
            DATE_START => '2014-12-20',
            DATE_END => '2014-12-21'
          } 
        }
      },
    }
  },

  'Spanish Open Trials',
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-05-06',
            DATE_END => '2016-05-08'
          } 
        }
      },
    }
  },

  'Spanish Senior Trials',
  {
    ORGANIZATION => 'AEB',
    COUNTRY => 'Spain',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2016' =>
      {
        CITY => 'Madrid',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-18',
            DATE_END => '2016-03-20'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SPAIN, \%TOURNAMENTS_SPAIN, 'Spain');
}

1;
