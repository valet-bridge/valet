#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Slovakia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_SLOVAKIA =
(
);

my %TOURNAMENTS_SLOVAKIA =
(
  'Slovakian Open Teams' => 
  {
    ORGANIZATION => 'BZS',
    COUNTRY => 'Slovakia',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-10-08',
            DATE_END => '2004-10-09'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SLOVAKIA, \%TOURNAMENTS_SLOVAKIA, 'Slovakia');
}

1;
