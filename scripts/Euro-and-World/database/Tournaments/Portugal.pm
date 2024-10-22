#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Portugal;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_PORTUGAL =
(
  'Madeira International Festival' =>
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'International',
    ZONE => 'Europe',

    EDITIONS =>
    {
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-11-06',
        DATE_END => '2009-11-08'
      },
      '2010' =>
      {
        YEAR => 2010,
        DATE_START => '2010-11-05',
        DATE_END => '2010-11-07'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-11-08',
        DATE_END => '2013-11-10'
      },
      '2014' =>
      {
        YEAR => 2014,
        DATE_START => '2014-11-07',
        DATE_END => '2014-11-09'
      },
      '2015' =>
      {
        YEAR => 2015,
        DATE_START => '2015-11-06',
        DATE_END => '2015-11-08'
      },
      '2019' =>
      {
        # https://bridgescanner.com/event/madeira-international-bridge-open-2019
        YEAR => 2019,
        DATE_START => '2019-10-31',
        DATE_END => '2019-11-11'
      },
      '2020' =>
      {
        # https://bridgescanner.com/event/madeira-international-bridge-open-2020
        YEAR => 2020,
        DATE_START => '2020-10-29',
        DATE_END => '2020-11-09'
      },
      '2022' =>
      {
        # https://bridgescanner.com/event/madeira-international-bridge-open-2022
        YEAR => 2022,
        DATE_START => '2022-11-07',
        DATE_END => '2022-11-13'
      },
      '2023' =>
      {
        # https://bridgescanner.com/event/madeira-international-bridge-open-2023
        YEAR => 2023,
        DATE_START => '2023-11-06',
        DATE_END => '2023-11-13'
      },
      '2024' =>
      {
        # https://bridgescanner.com/event/madeira-international-bridge-open-2024
        YEAR => 2024,
        DATE_START => '2024-11-04',
        DATE_END => '2024-11-11'
      },
    }
  }

);

my %TOURNAMENTS_PORTUGAL =
(
  'Madeira Open Teams',
  {
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2004-11-14',
            DATE_END => '2004-11-14'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2005-11-14',
            DATE_END => '2005-11-14'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-11-06',
            DATE_END => '2009-11-08'
          } 
        }
      },
      '2010' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-11-05',
            DATE_END => '2010-11-07'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-11-08',
            DATE_END => '2013-11-10'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-11-07',
            DATE_END => '2014-11-09'
          } 
        }
      },
      '2015' =>
      {
        MEET => 'Madeira International Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-11-07',
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-08'
          } 
        }
      },
    }
  },

  'Portuguese Grand Prix',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    CITY => 'Estoril',
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
            DATE_START => '2004-04-28',
            DATE_END => '2004-04-28'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2005-04-20',
            DATE_END => '2005-04-22'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2007-04-24',
            DATE_END => '2007-04-24'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2008-05-04',
            DATE_END => '2008-05-04'
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
            STAGE => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2009-04-14',
            DATE_END => '2009-04-16'
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
            major => 'ROUND',
            DATE_START => '2012-04-24',
            DATE_END => '2012-04-26'
          } 
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-04-22',
            DATE_END => '2014-04-24'
          } 
        }
      },
      '2015' =>
      {
        # https://fpbridge.pt/_wp/wp-content/uploads/2015/08/2015-Festival-Estoril-Pares-Final.pdf
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-19',
            DATE_END => '2015-05-21'
          } 
        }
      },
      '2016' =>
      {
        # https://fpbridge.pt/_wp/wp-content/uploads/2016/05/2016-Grande-Pr%C3%A9mio-Portugal-Equipas.pdf
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-24',
            DATE_END => '2016-05-27'
          } 
        }
      },
    }
  },

  'Portuguese IMP Pairs',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-10-24',
            DATE_END => '2014-10-26'
          } 
        }
      },
    }
  },

  'Portuguese Open Teams',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
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
            # Estimated.
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-05',
            DATE_END => '2008-12-07'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-16',
            DATE_END => '2009-10-18'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-12-04',
            DATE_END => '2009-12-06'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-19',
            DATE_END => '2010-11-21'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Knock-out',
            major => 'SEGMENT',
            DATE_START => '2010-12-03',
            DATE_END => '2010-12-04'
          },
          'C2' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-12-04',
            DATE_END => '2010-12-05'
          },
        }
      },
      '2011' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-11-18',
            DATE_END => '2011-11-20'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-02',
            DATE_END => '2011-12-03'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-03',
            DATE_END => '2011-12-03'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-04',
            DATE_END => '2011-12-04'
          },
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'PHASE',
            minor => 'ROUND',
            DATE_START => '2012-11-17',
            DATE_END => '2012-11-18'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-11-30',
            DATE_END => '2012-12-01'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-01',
            DATE_END => '2012-12-02'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-02',
            DATE_END => '2012-12-02'
          },
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'ROUND',
            DATE_START => '2013-10-25',
            DATE_END => '2013-10-27'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-22',
            DATE_END => '2013-11-23'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
          },
          'C3' => 
          {
            YEAR => 2013,
            DATE_START => '2013-11-24',
            DATE_END => '2013-11-24'
          },
        }
      },
      '2014A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            DATE_START => '2014-05-30',
            DATE_END => '2014-06-01'
          } 
        }
      },
      '2014B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-22'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-22'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-11-23',
            DATE_END => '2014-11-23'
          } 
        }
      },
      '2015A' =>
      {
        # https://fpbridge.pt/_wp/wp-content/uploads/2015/07/CN-Equipas-Open-2015-Apuramento.pdf
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            DATE_START => '2015-05-29',
            DATE_END => '2015-05-31'
          } 
        }
      },
      '2015B' =>
      {
        # https://fpbridge.pt/_wp/wp-content/uploads/2015/07/CN-Equipas-Open-2015-Final.pdf
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          } 
        }
      },
      '2016' =>
      {
        # https://fpbridge.pt/_wp/wp-content/uploads/2016/05/Classifica%C3%A7%C3%A3o-Final.pdf
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-05-06',
            DATE_END => '2016-05-08'
          } 
        }
      },
    }
  },

  'Portuguese Open Trials',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        # These days are surely wrong.
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-03-20',
            DATE_END => '2008-03-20'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-04-16',
            DATE_END => '2008-04-16'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-02-19',
            DATE_END => '2010-02-21'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-05',
            DATE_END => '2010-03-07'
          },
          'C2' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-03-19',
            DATE_END => '2010-03-21'
          },
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
            DATE_START => '2011-10-14',
            DATE_END => '2011-10-16'
          },
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-01-20',
            DATE_END => '2012-01-22'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            DATE_START => '2012-02-03',
            DATE_END => '2012-02-05'
          } 
        }
      },
    }
  },

  'Portuguese Northern Regional Open Teams',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
          } 
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-02-27',
            DATE_END => '2009-02-28'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'ROUND',
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-06'
          } 
        }
      },
    }
  },

  'Rui Pinto Cup',
  {
    ORGANIZATION => 'FPB',
    COUNTRY => 'Portugal',
    ORIGIN => 'National',
    ZONE => 'Europe',
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
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            DATE_START => '2011-10-29',
            DATE_END => '2011-10-29'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-10-29',
            DATE_END => '2011-10-29'
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
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-29'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-29'
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
            DATE_START => '2013-11-02',
            DATE_END => '2013-11-02'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-02',
            DATE_END => '2013-11-03'
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
            STAGE => 'Semifinal',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-27'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-27'
          } 
        }
      },
    }
  },


);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_PORTUGAL, \%TOURNAMENTS_PORTUGAL, 'Portugal');
}

1;
