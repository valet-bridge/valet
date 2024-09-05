#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Ireland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

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
      }
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
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-09-11',
            DATE_END => '2015-09-12'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-01-30',
            DATE_END => '2016-01-31'
          } 
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_IRELAND, \%TOURNAMENTS_IRELAND, 'Ireland');
}

1;
