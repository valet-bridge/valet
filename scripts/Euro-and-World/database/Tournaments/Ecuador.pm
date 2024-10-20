#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Ecuador;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_ECUADOR =
(
);

my %TOURNAMENTS_ECUADOR =
(
  'Ecuador Open Teams' => 
  {
    ORGANIZATION => 'FEB',
    COUNTRY => 'Ecuador',
    ORIGIN => 'National',
    ZONE => 'South America',
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
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-04',
            DATE_END => '2012-02-05'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ECUADOR, \%TOURNAMENTS_ECUADOR, 'Ecuador');
}

1;
