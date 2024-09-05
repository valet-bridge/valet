#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Chile;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# TODO Results missing.
# https://fcb.cl/
# https://fcb.cl/uncategorized/seleccion-libre-2024/
# https://fcb.cl/resultados/2022-12-03l.htm
# https://fcb.cl/resultados/2022-12-10.htm
# There is an archive, but how to search?

my %MEETS_CHILE =
(
);

my %TOURNAMENTS_CHILE =
(
  'Chilean Cup' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2012-11-29',
            DATE_END => '2012-12-03'
          } 
        }
      },

      '2013' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-08-03',
            DATE_END => '2013-08-04'
          } 
        }
      }
    }
  },

  'Chilean Invitational Teams' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-02',
            DATE_END => '2011-04-02'
          } 
        }
      },
    }
  },

  'Chilean Open Pairs' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-12-09',
            DATE_END => '2013-12-12'
          } 
        }
      }
    }
  },

  'Chilean Open Teams' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-21'
          } 
        }
      }
    }
  },

  'Chilean Open Trials' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SEGMENT',
            DATE_START => '2010-11-20',
            DATE_END => '2010-11-21'
          } 
        }
      },

      '2011' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-10'
          } 
        }
      },

      '2012' =>
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-17'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-17',
            DATE_END => '2012-06-18'
          } 
        }
      }
    }
  },

  'Chilean Senior Teams' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-15'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-13',
            DATE_END => '2013-04-15'
          } 
        }
      }
    }
  },

  'Chilean Women Teams' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2013' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-10-20',
            DATE_END => '2013-10-21'
          } 
        }
      }
    }
  },

  'Chilean Women Trials' =>
  {
    ORGANIZATION => 'FCB',
    COUNTRY => 'Chile',
    ORIGIN => 'National',
    ZONE => 'South America',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-10-09',
            DATE_END => '2011-10-10'
          } 
        }
      },

      '2012' =>
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'SEGMENT',
            DATE_START => '2012-06-16',
            DATE_END => '2012-06-18'
          } 
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CHILE, \%TOURNAMENTS_CHILE, 'Chile');
}

1;
