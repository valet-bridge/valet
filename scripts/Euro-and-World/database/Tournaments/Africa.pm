#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Africa;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_AFRICA =
(
  'African Zonal Championships' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',

    EDITIONS => 
    {
      # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=abf&pid=display_page7
      '2005' =>
      {
        YEAR => 2005,
        CITY => 'Casablanca',
        COUNTRY => 'Morocco',
        DATE_START => '2005-05-09',
        DATE_END => '2005-05-15'
      },
      '2007' =>
      {
        YEAR => 2007,
        CITY => 'Mombassa',
        COUNTRY => 'Kenya',
        DATE_START => '2007-04-09',
        DATE_END => '2007-04-14'
      },
      '2009' =>
      {
        YEAR => 2009,
        CITY => 'Sharm el Sheikh',
        COUNTRY => 'Egypt',
        DATE_START => '2009-05-31',
        DATE_END => '2009-06-03'
      },
      '2011' =>
      {
        YEAR => 2011,
        CITY => 'Hammamet',
        COUNTRY => 'Tunisia',
        DATE_START => '2011-06-18',
        DATE_END => '2011-06-23'
      },
      '2013' =>
      {
        YEAR => 2013,
        CITY => 'Saint-Denis',
        COUNTRY => 'Réunion',
        DATE_START => '2013-05-05',
        DATE_END => '2013-05-11'
      },
      '2015' =>
      {
        YEAR => 2015,
        CITY => 'Sharm el Sheikh',
        COUNTRY => 'Egypt',
        DATE_START => '2015-05-08',
        DATE_END => '2015-05-13'
      },
    }
  },

  'Fes Festival' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    CITY => 'Fes',
    COUNTRY => 'Morocco',
    ZONE => 'Africa',

    EDITIONS => 
    {
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-03-12',
        DATE_END => '2010-03-12'
      },
    }
  },
);

my %TOURNAMENTS_AFRICA =
(
  'African Zonal Open Teams' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-05-09',
            DATE_END => '2005-05-15'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-04-14',
            DATE_END => '2007-04-14'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-05-31',
            DATE_END => '2009-06-03'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-06-18',
            DATE_END => '2011-06-23'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-05-05',
            DATE_END => '2013-05-11'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-08',
            DATE_END => '2015-05-13'
          } 
        }
      },
    }
  },

  'African Zonal Senior Teams' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-04-14',
            DATE_END => '2007-04-14'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-06-18',
            DATE_END => '2011-06-23'
          } 
        }
      },
    }
  },

  'African Zonal Women Teams' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-04-14',
            DATE_END => '2007-04-14'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'MATCH',
            DATE_START => '2009-05-31',
            DATE_END => '2009-06-03'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-05-05',
            DATE_END => '2013-05-11'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'African Zonal Championships',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-08',
            DATE_END => '2015-05-13'
          } 
        }
      },
    }
  },

  'Morocco Open Pairs' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Fes Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-03-12',
            DATE_END => '2010-03-14'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Fes Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-13',
            DATE_END => '2011-03-13'
          } 
        }
      },
    }
  },

  'Morocco Patton Teams' =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    FORM => 'Teams',
    SCORING => 'Patton',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        MEET => 'Fes Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-03-17',
            DATE_END => '2010-03-17'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Fes Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-03-16',
            DATE_END => '2011-03-17'
          } 
        }
      },
    }
  },

  "Pigg's Peak All Africa" =>
  {
    ORGANIZATION => 'AfBF',
    ORIGIN => 'International',
    ZONE => 'Africa',
    CITY => 'Piggs Peak',
    COUNTRY => 'South Africa',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          } 
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_AFRICA, \%TOURNAMENTS_AFRICA, 'Africa');
}

1;
