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
  ORIGIN => 'National',
  ZONE => 'South East Asia'
);

my %MEETS_THAILAND =
(
  'Bangkok Bridge Festival' =>
  {
    %GLOBAL,
    CITY => 'Bangkok',
    ZONE => 'South East Asia',

    EDITIONS => 
    {
      '2013' =>
      {
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
    ZONE => 'South East Asia',

    EDITIONS => 
    {
      '2014' =>
      {
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
          'SINGLE' =>
          {
            YEAR => 2013,
            DATE_START => '2013-01-31',
            DATE_END => '2013-02-03'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Bangkok Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2014,
            DATE_START => '2014-04-06',
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
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-16'
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
          'SINGLE' =>
          {
            YEAR => 2014,
            DATE_START => '2014-12-13',
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
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-16'
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
