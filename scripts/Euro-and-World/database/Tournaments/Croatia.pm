#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Croatia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_CROATIA =
(
  'Samobor Bridge Meeting' =>
  {
    ORGANIZATION => 'CrBF',
    COUNTRY => 'Croatia',
    CITY => 'Samobor',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-05-29',
        DATE_END => '2005-05-31'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-27',
        DATE_END => '2006-05-28'
      },
    }
  }

);

my %TOURNAMENTS_CROATIA =
(
  'Atlantic Trade Bridge Cup' => 
  {
    ORGANIZATION => 'CrBF',
    COUNTRY => 'Croatia',
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
        # https://stara.pzbs.pl/opatija/OPMPOT5.html
        CITY => 'Opatija',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-26',
            DATE_END => '2007-05-26'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          } 
        }
      },
      '2008' =>
      {
        CITY => 'Opatija',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-05-24',
            DATE_END => '2008-05-24'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-05-25',
            DATE_END => '2008-05-25'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-25',
            DATE_END => '2008-05-25'
          } 
        }
      },
    }
  },

  'Samobor Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-05-29',
            DATE_END => '2005-05-29'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-30',
            DATE_END => '2005-05-30'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-31',
            DATE_END => '2005-05-31'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-05-27',
            DATE_END => '2006-05-28'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
        }
      },
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CROATIA, \%TOURNAMENTS_CROATIA, 'Croatia');
}

1;
