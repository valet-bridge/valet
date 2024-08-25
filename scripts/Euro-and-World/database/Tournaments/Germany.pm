#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Germany;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %GERMANY =
(
  'Bonn Nations Cup' => 
  {
    ORGANIZATION => 'BC Bonn',
    COUNTRY => 'Germany',
    CITY => 'Bonn',
    ORIGIN => 'National',
    ZONE => 'Europe',

    'Bonn Nations Cup' =>
    {
      FORM => 'Teams',
      SCORING => 'IMP',
      GENDER => 'Open',
      AGE => 'Open',

      EDITIONS =>
      {
        '2004' =>
        {
          ORDINAL => '19th',
          CHAPTERS => [
          {
            YEAR => 2004,
            DATE_START => '2004-05-19',
            DATE_END => '2004-05-20'
          } ]
        },

        '2005' =>
        {
          ORDINAL => '20th',
          CHAPTERS => [
          {
            YEAR => 2005,
            DATE_START => '2005-05-04',
            DATE_END => '2005-05-05'
          } ]
        },

        '2006' =>
        {
          ORDINAL => '21st',
          CHAPTERS => [
          {
            YEAR => 2006,
            DATE_START => '2006-05-24',
            DATE_END => '2006-05-25'
          } ]
        },

        '2007' =>
        {
          ORDINAL => '22nd',
          CHAPTERS => [
          {
            YEAR => 2007,
            DATE_START => '2007-05-16',
            DATE_END => '2007-05-17'
          } ]
        },

        '2008' =>
        {
          ORDINAL => '23rd',
          CHAPTERS => [
          {
            YEAR => 2008,
            DATE_START => '2008-04-30',
            DATE_END => '2008-05-01'
          } ]
        },

        '2009' =>
        {
          ORDINAL => '24th',
          CHAPTERS => [
          {
            YEAR => 2009,
            DATE_START => '2009-05-20',
            DATE_END => '2009-05-21'
          } ]
        },

        '2010' =>
        {
          ORDINAL => '25th',
          CHAPTERS => [
          {
            YEAR => 2010,
            DATE_START => '2010-05-12',
            DATE_END => '2010-05-13'
          } ]
        },

        '2011' =>
        {
          ORDINAL => '26th',
          CHAPTERS => [
          {
            YEAR => 2011,
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-02'
          } ]
        },

        '2012' =>
        {
          ORDINAL => '27th',
          CHAPTERS => [
          {
            YEAR => 2012,
            DATE_START => '2012-05-16',
            DATE_END => '2012-05-17'
          } ]
        }
      }
    }
  },

  # 'Dr. Heinz von Rotteck Pokal',
  # 'German Bundesliga',
  # 'German Club Cup',
  # 'German Open Pairs',
  # 'German Open Teams',
  # 'German Open Trials',
  # 'German Team Championship',
  # 'German Team Trophy',
  # 'German Women Pairs',
  # "Gro's Supercup",
  # 'König Ludwig Cup',
);


sub set_links
{
  my ($method) = @_;

  $method->(\%GERMANY, 'Germany');
}

1;
