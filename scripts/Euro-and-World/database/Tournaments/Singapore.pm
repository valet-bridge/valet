#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Singapore;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_SINGAPORE =
(
);

my %TOURNAMENTS_SINGAPORE =
(
  'Singapore Open Teams' => 
  {
    ORGANIZATION => 'SCBA',
    COUNTRY => 'Singapore',
    ORIGIN => 'National',
    ZONE => 'Asia Pacific',
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
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          } 
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_SINGAPORE, \%TOURNAMENTS_SINGAPORE, 'Singapore');
}

1;
