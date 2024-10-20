#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Belarus;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_BELARUS =
(
);

my %TOURNAMENTS_BELARUS =
(
  'Belarusian Open Teams' => 
  {
    ORGANIZATION => 'BCBF',
    COUNTRY => 'Belarus',
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-24'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-24',
            DATE_END => '2012-03-25'
          } 
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-16'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-14',
            DATE_END => '2013-04-14'
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
            major => 'ROUND',
            DATE_START => '2014-01-19',
            DATE_END => '2014-01-19'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-03-22',
            DATE_END => '2014-03-22'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-03-23',
            DATE_END => '2014-03-23'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BELARUS, \%TOURNAMENTS_BELARUS, 'Belarus');
}

1;
