#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Egypt;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# Some names here:
# https://www.egyptbridge.org/results

my %MEETS_EGYPT =
(
  'Cairo Bridge Festival' =>
  {
    ORGANIZATION => 'EgBF',
    COUNTRY => 'Egypt',
    ORIGIN => 'National',
    ZONE => 'African Zone',

    EDITIONS =>
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-02-25',
        DATE_END => '2009-02-25'
      },
    }
  },
);

my %TOURNAMENTS_EGYPT =
(
  'Cairo Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        MEET => 'Cairo Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-02-25',
            DATE_END => '2009-02-25'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-02-25',
            DATE_END => '2009-02-25'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-25',
            DATE_END => '2009-02-25'
          } 
        }
      },
    }
  },

  'Egyptian Cup' => 
  {
    ORGANIZATION => 'EgBF',
    COUNTRY => 'Egypt',
    ORIGIN => 'National',
    ZONE => 'African Zone',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-03-27',
            DATE_END => '2009-03-27',
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
            DATE_START => '2015-04-30',
            DATE_END => '2015-05-01'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-02'
          } 
        }
      },
    }
  },

  'Egyptian League' => 
  {
    ORGANIZATION => 'EgBF',
    COUNTRY => 'Egypt',
    ORIGIN => 'National',
    ZONE => 'African Zone',
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
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-01-22',
            DATE_END => '2008-01-22'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
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
            DATE_START => '2015-02-19',
            DATE_END => '2015-02-20'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-20',
            DATE_END => '2015-02-21'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_EGYPT, \%TOURNAMENTS_EGYPT, 'Egypt');
}

1;
