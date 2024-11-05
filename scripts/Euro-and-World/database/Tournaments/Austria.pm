#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Austria;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_AUSTRIA =
(
);

my %TOURNAMENTS_AUSTRIA =
(
  'Austrian Open Teams' => 
  {
    ORGANIZATION => 'ÖBV',
    COUNTRY => 'Austria',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-02'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-02'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            DATE_START => '2015-05-02',
            DATE_END => '2015-05-03'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-05-03',
            DATE_END => '2015-05-03'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_AUSTRIA, \%TOURNAMENTS_AUSTRIA, 'Austria');
}

1;
