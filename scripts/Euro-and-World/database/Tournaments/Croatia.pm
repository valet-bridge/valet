#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Croatia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_CROATIA =
(
  'Pula Bridge Festival' =>
  {
    ORGANIZATION => 'CrBF',
    COUNTRY => 'Croatia',
    CITY => 'Pula',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-09-09',
        DATE_END => '2009-09-09'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-09-08',
        DATE_END => '2010-09-08'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-09-07',
        DATE_END => '2011-09-07'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-09-13',
        DATE_END => '2012-09-13'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-08-31',
        DATE_END => '2013-08-31'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-09-07',
        DATE_END => '2014-09-07'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-09-05',
        DATE_END => '2015-09-09'
      },
    }
  },

  'Samobor Bridge Meeting' =>
  {
    ORGANIZATION => 'CrBF',
    COUNTRY => 'Croatia',
    CITY => 'Samobor',
    ORIGIN => 'National',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-05-22',
        DATE_END => '2004-05-24'
      },
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-05-29',
        DATE_END => '2005-05-31'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-05-27',
        DATE_END => '2006-05-28'
      },
    }
  }

);

my %TOURNAMENTS_CROATIA =
(
  'Atlantic Trade Bridge Cup' => 
  {
    ORGANIZATION => 'CrBF',
    COUNTRY => 'Croatia',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        # https://stara.pzbs.pl/opatija/OPMPOT5.html
        CITY => 'Opatija',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-05-26',
            DATE_END => '2007-05-26'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-27',
            DATE_END => '2007-05-27'
          } 
        }
      },
      '2008' =>
      {
        CITY => 'Opatija',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-05-24',
            DATE_END => '2008-05-24'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-05-25',
            DATE_END => '2008-05-25'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-25',
            DATE_END => '2008-05-25'
          } 
        }
      },
    }
  },

  'Pula Mixed Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-07',
            DATE_END => '2014-09-07'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-06',
            DATE_END => '2015-09-06'
          },
        }
      },
    }
  },

  'Pula Open BAM Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'BAM',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-08',
            DATE_END => '2014-09-08'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-07',
            DATE_END => '2015-09-07'
          },
        }
      },
    }
  },

  'Pula Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            DATE_START => '2006-09-25',
            DATE_END => '2006-09-25'
          },
        }
      },
      '2007' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            DATE_START => '2007-09-20',
            DATE_END => '2007-09-20'
          },
        }
      },
      '2008' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            DATE_START => '2009-09-09',
            DATE_END => '2009-09-10'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            DATE_START => '2010-09-08',
            DATE_END => '2010-09-09'
          },
        }
      },
      '2011' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            DATE_START => '2011-09-07',
            DATE_END => '2011-09-08'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            DATE_START => '2012-09-12',
            DATE_END => '2012-09-13'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            DATE_START => '2013-09-11',
            DATE_END => '2013-09-12'
          },
        }
      },
      '2014' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            DATE_START => '2014-09-10',
            DATE_END => '2014-09-11'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Pula Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-09-09',
            DATE_END => '2015-09-11'
          },
        }
      },
    }
  },

  'Samobor Open Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            DATE_START => '2004-05-22',
            DATE_END => '2004-05-24'
          },
        }
      },
      '2005' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-05-29',
            DATE_END => '2005-05-29'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-30',
            DATE_END => '2005-05-30'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-31',
            DATE_END => '2005-05-31'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2006-05-27',
            DATE_END => '2006-05-28'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          },
        }
      },
    }
  },

  'Samobor Women Teams' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Samobor Bridge Meeting',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            DATE_START => '2004-05-22',
            DATE_END => '2004-05-24'
          },
        }
      },
    }
  },
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_CROATIA, \%TOURNAMENTS_CROATIA, 'Croatia');
}

1;
