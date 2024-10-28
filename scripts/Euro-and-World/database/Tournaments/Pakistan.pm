#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Pakistan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_PAKISTAN =
(
);

my %TOURNAMENTS_PAKISTAN =
(
  'Pakistan Day Open Teams' => 
  {
    ORGANIZATION => 'PBF',
    COUNTRY => 'Pakistan',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-03-22',
            DATE_END => '2014-03-23'
          } 
        }
      },
    }
  },

  'Pakistan Open Trials' => 
  {
    ORGANIZATION => 'PBF',
    COUNTRY => 'Pakistan',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-03-21',
            DATE_END => '2009-03-22'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-03-23',
            DATE_END => '2009-03-23'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-23',
            DATE_END => '2009-03-24'
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
            major => 'SEGMENT',
            DATE_START => '2010-05-04',
            DATE_END => '2010-05-04'
          } 
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-03-14',
            DATE_END => '2011-03-14'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-03-15',
            DATE_END => '2011-03-15'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-25',
            DATE_END => '2012-03-26'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-26',
            DATE_END => '2012-03-27'
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
            major => 'SEGMENT',
            DATE_START => '2013-03-03',
            DATE_END => '2013-03-04'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_PAKISTAN, \%TOURNAMENTS_PAKISTAN, 'Pakistan');
}

1;
