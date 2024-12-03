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
    ORIGIN => 'National',
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
        YEAR => 2014,
        DATE_START => '2014-12-13',
        DATE_END => '2014-12-16'
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
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_THAILAND, \%TOURNAMENTS_THAILAND, 'Thailand');
}

1;
