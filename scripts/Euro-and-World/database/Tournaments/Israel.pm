#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Israel;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://main.bridge.co.il/results/archive/12

my %MEETS_ISRAEL =
(
);

my %TOURNAMENTS_ISRAEL =
(
  'Israel Cup',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-28'
          } 
        }
      },
    }
  },

  'Israel Juniors Pairs',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          # No link
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          # No link
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2009-12-26',
            DATE_END => '2009-12-26'
          } 
        }
      },
    }
  },

  'Israel Juniors Trials',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-05-05',
            DATE_END => '2005-05-05'
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
            DATE_START => '2011-02-05',
            DATE_END => '2011-02-05'
          } 
        }
      },
    }
  },

  'Israel IMP Pairs',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
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
            major => 'ROUND',
            DATE_START => '2007-05-31',
            DATE_END => '2007-05-31'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-03-28',
            DATE_END => '2009-03-28'
          } 
        }
      },
    }
  },

  'Israel Open Pairs',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2005-06-04',
            DATE_END => '2005-06-04'
          } 
        }
      },
      '2008' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
          } 
        }
      },
      '2010' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2010-06-05',
            DATE_END => '2010-06-05'
          } 
        }
      },
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-14'
          } 
        }
      },
      '2012' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2012-05-19',
            DATE_END => '2012-05-19'
          } 
        }
      },
      '2013' =>
      {
        # https://main.bridge.co.il/uploads/files/2858gmar-al-2013.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2013-06-01',
            DATE_END => '2013-06-01'
          } 
        }
      },
      '2014' =>
      {
        # https://www.bridge.co.il/results/2014/94-2014-ga-fr.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2014-07-05',
            DATE_END => '2014-07-05'
          } 
        }
      },
      '2015' =>
      {
        # https://www.bridge.co.il/results/2015/ga2015h.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2015-06-20',
            DATE_END => '2015-06-20'
          } 
        }
      },
      '2016' =>
      {
        # https://www.bridge.co.il/results/2016/94-ga2016.htm
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SESSION',
            DATE_START => '2016-05-21',
            DATE_END => '2016-05-21'
          } 
        }
      },
    }
  },

  'Israel Open Teams',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-01-16',
            DATE_END => '2006-01-16'
          } 
        }
      },
      '2008' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-01-22',
            DATE_END => '2008-01-22'
          } 
        }
      },
      '2009' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-01-05',
            DATE_END => '2009-01-05'
          } 
        }
      },
      '2010A' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-01',
            DATE_END => '2010-01-02'
          } 
        }
      },
      '2010B' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-25',
            DATE_END => '2010-12-25'
          } 
        }
      },
      '2011' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-31',
            DATE_END => '2011-12-31'
          } 
        }
      },
      '2012' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-22',
            DATE_END => '2012-12-22'
          } 
        }
      },
      '2013' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-28',
            DATE_END => '2013-12-28'
          } 
        }
      },
      '2015A' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-10'
          } 
        }
      },
      '2015B' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-12',
            DATE_END => '2015-12-12'
          } 
        }
      },
    }
  },

  'Israel Open Trials',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-05-01',
            DATE_END => '2006-05-01'
          } 
        }
      },
      '2009' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-08-13',
            DATE_END => '2009-08-15'
          } 
        }
      },
      '2012' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-03'
          } 
        }
      },
      '2015A' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-08',
            DATE_END => '2015-05-10'
          } 
        }
      },
      '2015B' =>
      {
        # Link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-12-26',
            DATE_END => '2015-12-26'
          } 
        }
      },
    }
  },

  'Israel School Trials',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U18',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-01-16',
            DATE_END => '2010-01-16'
          } 
        }
      },
    }
  },

  'Israel Women Pairs',
  {
    ORGANIZATION => 'IBF',
    COUNTRY => 'Israel',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2015' =>
      {
        # No link
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-07-21',
            DATE_END => '2015-07-21'
          } 
        }
      },
    }
  },

);

sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_ISRAEL, \%TOURNAMENTS_ISRAEL, 'Israel');
}

1;
