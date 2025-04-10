#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Faroe;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GLOBAL = (
  ORGANIZATION => 'FaBF',
  COUNTRY => 'Faroe Islands',
  ZONE => 'Europe',
);

my %MEETS_FAROE =
(
  'Tórshavn Bridge Festival' =>
  {
    %GLOBAL,
    ORIGIN => 'Transnational',
    CITY => 'Tórshavn',

    EDITIONS => 
    {
      '2019' =>
      {
        YEAR => 2019,
        DATE_START => '2019-03-08',
        DATE_END => '2019-03-09'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-03-06',
        DATE_END => '2020-03-07'
      },
      '2022' =>
      {
        YEAR => 2022,
        DATE_START => '2022-03-11',
        DATE_END => '2022-03-12'
      },
    }
  },
);

my %TOURNAMENTS_FAROE =
(
  'Faroese Open Teams' => 
  {
    ORGANIZATION => 'FaBF',
    COUNTRY => 'Faroe Islands',
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
          'C0' => 
          {
            YEAR => 2012,
            major => 'HALF',
            DATE_START => '2012-04-19',
            DATE_END => '2012-04-19'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'HALF',
            DATE_START => '2012-04-21',
            DATE_END => '2012-04-21'
          } 
        }
      },
    }
  },

  'Tórshavn Open Pairs' => 
  {
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2019' =>
      {
        MEET => 'Tórshavn Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            major => 'SESSION|SEGMENT',
            DATE_START => '2019-03-08',
            DATE_END => '2019-03-09'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Tórshavn Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            major => 'SESSION|SECTION',
            DATE_START => '2020-03-06',
            DATE_END => '2020-03-07'
          },
        }
      },
      '2022' =>
      {
        MEET => 'Tórshavn Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            major => 'SESSION|SEGMENT',
            DATE_START => '2022-03-11',
            DATE_END => '2022-03-12'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_FAROE, \%TOURNAMENTS_FAROE, 'Faroe Islands');
}

1;
