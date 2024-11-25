#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::CentralAmerica;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'CACBF',
  ORIGIN => 'International',
  ZONE => 'Central America and Caribbean',
);

my %MEETS_CENTRALAMERICA =
(
);

my %TOURNAMENTS_CENTRALAMERICA =
(
  'Central American & Caribbean Open Teams' =>
  {
    # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=cacbf&pid=display_page31

    %GLOBAL,
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
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-05-29',
            DATE_END => '2007-05-29'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-30',
            DATE_END => '2007-05-30'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-30',
            DATE_END => '2007-05-30'
          } 
        }
      },
      '2009' =>
      {
        ORDINAL => 25,
        COUNTRY => 'Guadeloupe',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-28',
            DATE_END => '2009-05-29'
          } 
        }
      },
      '2011' =>
      {
        ORDINAL => 26,
        COUNTRY => 'Cuba',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-27',
            DATE_END => '2011-05-28'
          } 
        }
      },
      '2015' =>
      {
        ORDINAL => 28,
        COUNTRY => 'Barbados',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-21',
            DATE_END => '2015-05-22'
          } 
        }
      },
    }
  },

  'Central American & Caribbean Transnational Teams' =>
  {
    # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=cacbf&pid=display_page31

    %GLOBAL,
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        ORDINAL => 28,
        COUNTRY => 'Barbados',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-05-22',
            DATE_END => '2015-05-22'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CENTRALAMERICA, \%TOURNAMENTS_CENTRALAMERICA, 
    'Central America');
}

1;
