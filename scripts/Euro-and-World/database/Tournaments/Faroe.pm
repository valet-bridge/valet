#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Faroe;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_FAROE =
(
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

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_FAROE, \%TOURNAMENTS_FAROE, 'Faroe Islands');
}

1;
