#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Brazil;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

# https://www.bridge.esp.br/historico.php, a bit spotty

my %GLOBAL = (
  ORGANIZATION => 'FBB',
  COUNTRY => 'Brazil',
  ZONE => 'South America',
);

my %MEETS_BRAZIL =
(
  'Brazilian Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2004' =>
      {
        YEAR => 2004,
        DATE_START => '2004-08-07',
        DATE_END => '2004-08-09'
      },
      '2005' =>
      {
        YEAR => 2005,
        DATE_START => '2005-03-26',
        DATE_END => '2005-03-26'
      },
      '2006' =>
      {
        YEAR => 2006,
        DATE_START => '2006-04-16',
        DATE_END => '2006-04-17'
      },
      '2007' =>
      {
        YEAR => 2007,
        DATE_START => '2007-04-16',
        DATE_END => '2007-04-16'
      },
      '2008' =>
      {
        YEAR => 2008,
        DATE_START => '2008-04-02',
        DATE_END => '2008-04-02'
      },
      '2009' =>
      {
        YEAR => 2009,
        DATE_START => '2009-04-10',
        DATE_END => '2009-04-12'
      },
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-04-23',
        DATE_END => '2011-04-23'
      },
      '2012' =>
      {
        YEAR => 2012,
        DATE_START => '2012-04-05',
        DATE_END => '2012-04-07'
      },
      '2013' =>
      {
        YEAR => 2013,
        DATE_START => '2013-03-28',
        DATE_END => '2013-03-30'
      },
      '2016' =>
      {
        # Link
        YEAR => 2016,
        DATE_START => '2016-03-21',
        DATE_END => '2016-03-27'
      },
      '2017' =>
      {
        YEAR => 2017,
        DATE_START => '2017-01-26',
        DATE_END => '2017-01-29'
      },
      '2018' =>
      {
        YEAR => 2018,
        DATE_START => '2018-11-01',
        DATE_END => '2018-11-01'
      },
      '2020' =>
      {
        YEAR => 2020,
        DATE_START => '2020-01-23',
        DATE_END => '2020-01-25'
      },
      '2023' =>
      {
        YEAR => 2023,
        DATE_START => '2023-01-23',
        DATE_END => '2023-01-24'
      },
      '2024A' =>
      {
        YEAR => 2024,
        DATE_START => '2024-01-22',
        DATE_END => '2024-01-24'
      },
      '2024B' =>
      {
        YEAR => 2024,
        DATE_START => '2024-05-27',
        DATE_END => '2024-05-29'
      },
    }
  },

  'Buzios Festival',
  {
    %GLOBAL,
    ORIGIN => 'National',

    EDITIONS => 
    {
      '2011' =>
      {
        YEAR => 2011,
        DATE_START => '2011-08-20',
        DATE_END => '2011-08-20'
      },
    }
  },
);

my %TOURNAMENTS_BRAZIL =
(
  'Brazilian Mixed Trials' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            DATE_START => '2024-06-02',
            DATE_END => '2024-06-02'
          },
        }
      },
    }
  },

  'Brazilian Open Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-09-10',
            DATE_END => '2004-09-10'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-09-11',
            DATE_END => '2004-09-11'
          } 
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-18',
            DATE_END => '2005-09-18'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-12'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-12'
          } 
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-09-11',
            DATE_END => '2007-09-11'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-11',
            DATE_END => '2007-09-11'
          } 
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-10-16',
            DATE_END => '2009-10-17'
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
            STAGE => 'Final',
            MOVEMENT => 'Round-robin',
            major => 'SEGMENT',
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-10'
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
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-09'
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
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-11',
            DATE_END => '2014-09-12'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-13',
            DATE_END => '2014-09-13'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-07'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-11-03',
            DATE_END => '2016-11-05'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-09-15',
            DATE_END => '2017-09-16'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-08',
            DATE_END => '2018-11-10'
          } 
        }
      },
      '2022' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-10-10',
            DATE_END => '2022-10-15'
          } 
        }
      },
      '2023' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-26',
            DATE_END => '2023-10-28'
          } 
        }
      },
      '2024' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-09-12',
            DATE_END => '2024-09-14'
          } 
        }
      },
    }
  },

  'Brazilian Open Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2004,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2004-08-07',
            DATE_END => '2004-08-07'
          },
          'C1' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-08-08',
            DATE_END => '2004-08-09'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-26'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-03-26',
            DATE_END => '2005-03-26'
          } 
        }
      },
      '2006' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT|ROUND',
            DATE_START => '2006-04-16',
            DATE_END => '2006-04-17'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-04-16',
            DATE_END => '2006-04-17'
          } 
        }
      },
      '2007' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-04-02',
            DATE_END => '2008-04-02'
          } 
        }
      },
      '2009' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-04-10',
            DATE_END => '2009-04-10'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2009-04-11',
            DATE_END => '2009-04-12'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-04-23',
            DATE_END => '2011-04-23'
          } 
        }
      },
      '2012' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-04-05',
            DATE_END => '2012-04-06'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-04-06',
            DATE_END => '2012-04-07'
          } 
        }
      },
      '2013' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2013-03-28',
            DATE_END => '2013-03-29'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-03-29',
            DATE_END => '2013-03-30'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Brazilian Trials',

        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-03-21',
            DATE_END => '2016-03-23'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Quarterfinal',
            groupon => 'AUTO',
            major => 'SEGMENT',
            DATE_START => '2016-03-23',
            DATE_END => '2016-03-24'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-03-24',
            DATE_END => '2016-03-25'
          },
          'C3' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-27'
          } 
        }
      },
      '2017' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-01-26',
            DATE_END => '2017-01-29'
          },
        }
      },
      '2018' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2018,
            DATE_START => '2018-11-01',
            DATE_END => '2018-11-01'
          },
        }
      },
      '2020' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2020,
            DATE_START => '2020-01-23',
            DATE_END => '2020-01-25'
          },
        }
      },
      '2023' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2023,
            DATE_START => '2023-01-23',
            DATE_END => '2023-01-24'
          },
        }
      },
      '2024A' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-01-22',
            DATE_END => '2024-01-24'
          },
        }
      },
      '2024B' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-27',
            DATE_END => '2024-05-29'
          },
        }
      },
    }
  },

  'Brazilian Senior Trials',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            DATE_START => '2007-05-05',
            DATE_END => '2007-05-05'
          } 
        }
      },
    }
  },

  'Brazilian Women Trials',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2007' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-04-16',
            DATE_END => '2007-04-16'
          } 
        }
      },
      '2016' =>
      {
        MEET => 'Brazilian Trials',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-03-25',
            DATE_END => '2016-03-27'
          } 
        }
      },
    }
  },

  'Buzios Open Teams',
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2011' =>
      {
        MEET => 'Buzios Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-08-20',
            DATE_END => '2011-08-20'
          } 
        }
      },
    }
  },

  'Rio de Janeiro Open Teams',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            major => 'SEGMENT',
            DATE_START => '2004-09-05',
            DATE_END => '2004-09-05'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-30',
            DATE_END => '2009-07-01'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-07-01',
            DATE_END => '2009-07-01'
          } 
        }
      },
    }
  },

  'Rio de Janeiro Christmas Individual',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Individual',
    SCORING => 'MP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            DATE_START => '2009-12-17',
            DATE_END => '2009-12-17'
          } 
        }
      },
    }
  },

  'Roberto Taunay Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'SEGMENT',
            DATE_START => '2009-11-10',
            DATE_END => '2009-11-10'
          } 
        }
      },
    }
  },

  'Sao Paulo Cup',
  {
    %GLOBAL,
    ORIGIN => 'National',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-11-14',
            DATE_END => '2004-11-16'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-17',
            DATE_END => '2005-12-17'
          },
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          },
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-10-29',
            DATE_END => '2010-10-30'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-10-08',
            DATE_END => '2011-10-09'
          },
        }
      },
      '2012' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          },
        }
      },
      '2013' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-23'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-11-29',
            DATE_END => '2014-11-29'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-06',
            DATE_END => '2014-12-06'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-12-05',
            DATE_END => '2015-12-05'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            DATE_START => '2016-09-28',
            DATE_END => '2016-10-02'
          },
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2017,
            DATE_START => '2017-11-18',
            DATE_END => '2017-11-19'
          },
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-07',
            DATE_END => '2019-12-07'
          },
          'C1' => 
          {
            YEAR => 2019,
            DATE_START => '2019-12-11',
            DATE_END => '2019-12-11'
          },
        }
      },
    }
  },

  'Sao Paulo State Championship',
  {
    %GLOBAL,
    ORIGIN => 'Regional',
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2004-06-21',
            DATE_END => '2004-06-21'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-06-27',
            DATE_END => '2005-06-27'
          } 
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-07-03',
            DATE_END => '2006-07-03'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-08-27',
            DATE_END => '2007-08-27'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-19',
            DATE_END => '2009-06-21'
          } 
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-06-18',
            DATE_END => '2010-06-20'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-03',
            DATE_END => '2011-06-05'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-06-23',
            DATE_END => '2012-06-24'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-18',
            DATE_END => '2013-05-19'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-06-11',
            DATE_END => '2014-06-15'
          } 
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-06-03',
            DATE_END => '2015-06-10'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-06-13',
            DATE_END => '2015-06-14'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'SEGMENT|ROUND',
            DATE_START => '2016-05-22',
            DATE_END => '2016-05-22'
          } 
        }
      },
      '2017' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-06-10',
            DATE_END => '2017-06-14'
          } 
        }
      },
      '2018' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-06-16',
            DATE_END => '2018-06-18'
          } 
        }
      },
      '2019' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-05-15',
            DATE_END => '2019-05-16'
          } 
        }
      },
    }
  },

  'Sao Paulo Summer Open Teams' =>
  {
    %GLOBAL,
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2018' =>
      {
        CHAPTERS =>
        {
          'C0' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-04',
            DATE_END => '2018-02-04'
          },
          'C1' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-07',
            DATE_END => '2018-02-07'
          },
          'C2' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-17',
            DATE_END => '2018-02-17'
          },
          'C3' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-21',
            DATE_END => '2018-02-21'
          },
          'C4' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-24',
            DATE_END => '2018-02-24'
          },
          'C5' =>
          {
            YEAR => 2018,
            DATE_START => '2018-02-28',
            DATE_END => '2018-02-28'
          },
          'C6' =>
          {
            YEAR => 2018,
            DATE_START => '2018-03-03',
            DATE_END => '2018-03-03'
          },
        }
      },
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_BRAZIL, \%TOURNAMENTS_BRAZIL, 'Brazil');
}

1;
