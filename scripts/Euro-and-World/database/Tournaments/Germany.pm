#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Germany;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_GERMANY =
(
  'German Championship Week' =>
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',

    EDITIONS =>
    {
      '2013' =>
      {
        ORDINAL => '1st',
        YEAR => 2013,
        CITY => 'Berlin',
        DATE_START => '2014-08-10',
        DATE_END => '2014-08-18'
      },

      '2014' =>
      {
        ORDINAL => '2nd',
        YEAR => 2014,
        CITY => 'Berlin',
        DATE_START => '2014-08-16',
        DATE_END => '2014-08-24'
      },

      '2015' =>
      {
        ORDINAL => '3rd',
        YEAR => 2015,
        CITY => 'Berlin',
        DATE_START => '2014-08-15',
        DATE_END => '2014-08-23'
      },

      '2016' =>
      {
        ORDINAL => '4th',
        YEAR => 2016,
        CITY => 'Berlin',
        DATE_START => '2014-08-20',
        DATE_END => '2014-08-28'
      }
    }
  }
);

my %TOURNAMENTS_GERMANY =
(
  'Bonn Nations Cup' =>
  {
    ORGANIZATION => 'BC Bonn',
    COUNTRY => 'Germany',
    CITY => 'Bonn',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2004' =>
      {
        ORDINAL => '19th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2004,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2004-05-19',
            DATE_END => '2004-05-20'
          },
          'C1' =>
          {
            YEAR => 2004,
            STAGE => => 'Final',
            major => 'HALF',
            DATE_START => '2004-05-19',
            DATE_END => '2004-05-20'
          } 
        }
      },

      '2005' =>
      {
        ORDINAL => '20th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-05-04',
            DATE_END => '2005-05-05'
          },
          'C1' =>
          {
            YEAR => 2005,
            STAGE => => 'Final',
            DATE_START => '2005-05-05',
            DATE_END => '2005-05-05'
          } 
        }
      },

      '2006' =>
      {
        ORDINAL => '21st',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2006-05-24',
            DATE_END => '2006-05-25'
          },
          'C1' =>
          {
            YEAR => 2006,
            STAGE => 'Consolation',
            major => 'ROUND',
            MOVEMENT => 'Swiss',
            DATE_START => '2006-05-24',
            DATE_END => '2006-05-25'
          },
          'C2' =>
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-24',
            DATE_END => '2006-05-25'
          } 
        }
      },

      '2007' =>
      {
        ORDINAL => '22nd',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2007-05-16',
            DATE_END => '2007-05-17'
          },
          'C1' =>
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-17',
            DATE_END => '2007-05-17'
          } 
        }
      },

      '2008' =>
      {
        ORDINAL => '23rd',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2008-04-30',
            DATE_END => '2008-05-01'
          },
          'C1' =>
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-05-01',
            DATE_END => '2008-05-01'
          } 
        }
      },

      '2009' =>
      {
        ORDINAL => '24th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2009,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2009-05-20',
            DATE_END => '2009-05-21'
          },
          'C1' =>
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-21',
            DATE_END => '2009-05-21'
          } 
        }
      },

      '2010' =>
      {
        ORDINAL => '25th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2010,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2010-05-12',
            DATE_END => '2010-05-13'
          },
          'C1' =>
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-13',
            DATE_END => '2010-05-13'
          } 
        }
      },

      '2011' =>
      {
        ORDINAL => '26th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2011,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-02'
          },
          'C1' =>
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-06-02',
            DATE_END => '2011-06-02'
          } 
        }
      },

      '2012' =>
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=222&site=0&kl=0
        ORDINAL => '27th',
        CHAPTERS => 
        {
          'C0' =>
          {
            YEAR => 2012,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-16',
            DATE_END => '2012-05-17'
          },
          'C1' =>
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-05-17',
            DATE_END => '2012-05-17'
          } 
        }
      }
    }
  },

  'German Bundesliga' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'Interclub',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      '2013' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=315&site=0&kl=0
        ORDINAL => 27,

        CHAPTERS => 
        {
          YEAR => 2013,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03',
            WEEKEND => 3,
            STAGE => 'Round-robin'
          } 
        }
      },

      '2014' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=687&submit=Anzeigen
        ORDINAL => 28,

        CHAPTERS => 
        {
          YEAR => 2014,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19',
            WEEKEND => 1,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16',
            WEEKEND => 2,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-06',
            WEEKEND => 3,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          } 
        }
      },

      '2015' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1143&site=0&kl=0
        ORDINAL => 29,

        CHAPTERS => 
        {
          YEAR => 2015,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-25',
            WEEKEND => 1,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-08',
            WEEKEND => 2,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-26',
            WEEKEND => 3,
            STAGE => 'Round-robin',
            major => 'ROUND',
            minor => 'SEGMENT'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=14602&site=0&kl=0
        ORDINAL => 30,

        CHAPTERS => 
        {
          YEAR => 2016,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-24',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-21',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=13842&site=0&kl=0
        ORDINAL => 31,

        CHAPTERS => 
        {
          YEAR => 2017,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2017-01-28',
            DATE_END => '2017-01-29',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2017-02-18',
            DATE_END => '2017-02-19',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2017-03-11',
            DATE_END => '2017-03-12',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=8827&submit=Anzeigen
        ORDINAL => 32,

        CHAPTERS => 
        {
          YEAR => 2018,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2018-01-20',
            DATE_END => '2018-01-21',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2018-02-10',
            DATE_END => '2018-02-11',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2018-04-14',
            DATE_END => '2018-04-15',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=9737&site=0&kl=0
        ORDINAL => 33,

        CHAPTERS => 
        {
          YEAR => 2019,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2019-01-19',
            DATE_END => '2019-01-20',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2019-03-16',
            DATE_END => '2019-03-17',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2019-04-06',
            DATE_END => '2019-04-07',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2020' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=16553&site=0&kl=0
        ORDINAL => 34,

        CHAPTERS => 
        {
          YEAR => 2020,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2020-01-11',
            DATE_END => '2020-01-12',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2020-02-22',
            DATE_END => '2020-02-23',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2021-10-09', # Covid
            DATE_END => '2021-10-10',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2022' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=19017&submit=Anzeigen
        ORDINAL => 35,

        CHAPTERS => 
        {
          YEAR => 2022,
          CITY => 'Niedernhausen',

          'WEEKEND 1' =>
          {
            DATE_START => '2022-02-05',
            DATE_END => '2022-02-06',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2022-02-26',
            DATE_END => '2022-02-27',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2022-03-05',
            DATE_END => '2022-03-06',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2023' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=22923&site=0&kl=0
        ORDINAL => 36,

        CHAPTERS => 
        {
          YEAR => 2023,
          CITY => 'Niedernhausen',

          'WEEKEND 1' =>
          {
            DATE_START => '2023-02-11',
            DATE_END => '2023-02-12',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2023-03-11',
            DATE_END => '2023-03-12',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2023-04-15',
            DATE_END => '2023-04-16',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      },

      '2024' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=29362&submit=Anzeigen
        ORDINAL => 37,

        CHAPTERS => 
        {
          YEAR => 2024,
          CITY => 'Niedernhausen',

          'WEEKEND 1' =>
          {
            DATE_START => '2024-01-20',
            DATE_END => '2024-01-21',
            WEEKEND => 1,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2024-02-17',
            DATE_END => '2024-02-18',
            WEEKEND => 2,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2024-03-09',
            DATE_END => '2024-03-10',
            WEEKEND => 3,
            major => 'ROUND',
            minor => 'SEGMENT',
            STAGE => 'Round-robin'
          } 
        }
      }
    }
  },

  'German Club Cup' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'Interclub',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      # Approximate dates for 2005, and no location
      '2005' => 
      {
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          } 
        }
      },

      '2006' => 
      {
        # https://ergebnisse.bridge-verband.de/error.html?errtype=1&auswcl=0&auswtid=16740
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2006,
            CITY => 'Düsseldorf',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-12-02',
            DATE_END => '2006-12-03'
          },
          'C1' => 
          {
            YEAR => 2006,
            CITY => 'Düsseldorf',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-12-02',
            DATE_END => '2006-12-03'
          } 
        }
      },

      '2008' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15954&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2008,
            CITY => 'Bonn',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-11-15',
            DATE_END => '2008-11-16'
          },
          'C1' => 
          {
            YEAR => 2008,
            CITY => 'Bonn',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-11-15',
            DATE_END => '2008-11-16'
          } 
        }
      },

      '2009' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15953&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-11-28',
            DATE_END => '2009-11-29'
          },
          'C1' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-11-28',
            DATE_END => '2009-11-29'
          } 
        }
      },

      '2010' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=27254&submit=Anzeigen
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-28'
          },
          'C1' => 
          {
            YEAR => 2010,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-28'
          } 
        }
      },

      '2011' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=148&submit=Anzeigen
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            CITY => 'Bonn',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
          },
          'C1' => 
          {
            YEAR => 2011,
            CITY => 'Bonn',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
          } 
        }
      },

      '2012' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=301&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-09'
          } 
        }
      },

      '2013' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=603&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-24'
          },
          'C1' => 
          {
            YEAR => 2013,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-24'
          } 
        }
      },

      '2014' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1048&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            CITY => 'Darmstadt',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            CITY => 'Darmstadt',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
          } 
        }
      },

      '2015' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1996&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            CITY => 'Darmstadt',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          },
          'C1' => 
          {
            YEAR => 2015,
            CITY => 'Darmstadt',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=3591&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2016-11-19',
            DATE_END => '2016-11-20'
          },
          'C1' => 
          {
            YEAR => 2016,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2016-11-19',
            DATE_END => '2016-11-20'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=5671&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2017-11-18',
            DATE_END => '2017-11-19'
          },
          'C1' => 
          {
            YEAR => 2017,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2017-11-18',
            DATE_END => '2017-11-19'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=8486&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          },
          'C1' => 
          {
            YEAR => 2018,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2018-11-17',
            DATE_END => '2018-11-18'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=12105&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2019-11-16',
            DATE_END => '2019-11-17'
          },
          'C1' => 
          {
            YEAR => 2019,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2019-11-16',
            DATE_END => '2019-11-17'
          } 
        }
      },

      '2023' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=28517&site=0&kl=0
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            CITY => 'Niedernhausen',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2023-12-02',
            DATE_END => '2023-12-03'
          },
          'C1' => 
          {
            YEAR => 2023,
            CITY => 'Niedernhausen',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2023-12-02',
            DATE_END => '2023-12-03'
          } 
        }
      },

      '2024' => 
      {
        # 
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            CITY => 'Wetzlar',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2024-12-06',
            DATE_END => '2024-12-08'
          },
          'C1' => 
          {
            YEAR => 2024,
            CITY => 'Wetzlar',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2024-12-06',
            DATE_END => '2024-12-08'
          } 
        }
      }
    }
  },

  'German Mixed Teams' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Mixed',
    AGE => 'Open',

    EDITIONS =>
    {
      '2014' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=842&site=0&kl=0
        ORDINAL => '8th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-21'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-21',
            DATE_END => '2014-08-21'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-21',
            DATE_END => '2014-08-21'
          } 
        }
      },

      '2015' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1689&site=0&kl=0
        ORDINAL => '9th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-16',
            MOVEMENT => 'Swiss',
            major => 'ROUND'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=3180&site=0&kl=0
        ORDINAL => '10th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-08-20',
            DATE_END => '2016-08-20'
          },
          'C1' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-21',
            DATE_END => '2016-08-21'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=5039&site=0&kl=0
        ORDINAL => '11th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2017-08-16',
            DATE_END => '2017-08-18'
          },
          'C1' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-08-16',
            DATE_END => '2017-08-18'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=7444&site=0&kl=0
        ORDINAL => '12th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2018-07-22',
            DATE_END => '2018-07-23'
          },
          'C1' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-07-22',
            DATE_END => '2018-07-23'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=10947&site=0&kl=0
        ORDINAL => '13th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2019-08-26',
            DATE_END => '2019-08-27'
          },
          'C1' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-08-26',
            DATE_END => '2019-08-27'
          } 
        }
      },

      '2021' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15504&site=0&kl=0
        ORDINAL => '14th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2021,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2021-08-14', # Estimated
            DATE_END => '2021-08-15'
          },
          'C1' => 
          {
            YEAR => 2021,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2021-08-14',
            DATE_END => '2021-08-15'
          } 
        }
      },

      '2022' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=19971&site=0&kl=0
        ORDINAL => '15th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2022-08-04',
            DATE_END => '2022-08-05'
          },
          'C1' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-08-04',
            DATE_END => '2022-08-05'
          } 
        }
      },

      '2023' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=24659&site=0&kl=0
        ORDINAL => '16th',
        CITY => 'Wetzlar',

        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2023-04-18',
            DATE_END => '2023-04-19'
          },
          'C1' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-04-18',
            DATE_END => '2023-04-19'
          } 
        }
      },

      '2024' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=32025&site=0&kl=0
        ORDINAL => '17th',
        CITY => 'Wetzlar',

        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2024-05-09',
            DATE_END => '2024-05-10'
          },
          'C1' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-05-09',
            DATE_END => '2024-05-10'
          } 
        }
      }
    }
  },

  'German Open Pairs' =>
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      '2009' => 
      {
        ORDINAL => '6th',
        CITY => 'Bad Nauheim',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2009,
            major => 'SESSION',
            DATE_START => '2009-11-21',
            DATE_END => '2009-11-22'
          } 
        }
      },

      '2011' => 
      {
        ORDINAL => '8th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2011,
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-13'
          } 
        }
      },

      '2012' => 
      {
        ORDINAL => '9th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2012,
            major => 'SESSION',
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          } 
        }
      },

      '2013' => 
      {
        ORDINAL => '10th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2013,
            major => 'SESSION',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
          } 
        }
      },

      '2014' => 
      {
        ORDINAL => '11th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-11-01',
            DATE_END => '2014-11-02'
          } 
        }
      },

      '2015' => 
      {
        ORDINAL => '12th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15858&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '73rd',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-08-24',
            DATE_END => '2016-08-25'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=5040&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '74th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2017,
            major => 'SESSION',
            DATE_START => '2017-08-24',
            DATE_END => '2017-08-25'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=7502&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '75th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2018,
            major => 'SESSION',
            DATE_START => '2018-08-28',
            DATE_END => '2018-08-29'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=10950&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '76th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2019,
            major => 'SESSION',
            DATE_START => '2019-08-31',
            DATE_END => '2019-09-01'
          } 
        }
      },

      '2021' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15544&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '77th',
        CITY => 'Darmstadt',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2021,
            major => 'SESSION',
            DATE_START => '2021-08-18', # Estimated
            DATE_END => '2021-09-19'
          } 
        }
      },

      '2022' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=19721&site=0&kl=0
        ORDINAL => '78th',
        CITY => 'Würzburg',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2022,
            major => 'SESSION',
            DATE_START => '2022-04-23',
            DATE_END => '2022-04-24'
          } 
        }
      },

      '2023' => 
      {
        # None.
        ORDINAL => '79th',
        CITY => 'Würzburg',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2023,
            major => 'SESSION',
            DATE_START => '2023-07-15',
            DATE_END => '2023-07-16'
          } 
        }
      },

      '2024' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=32883&site=0&kl=0
        ORDINAL => '80th',
        CITY => 'Wetzlar',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2024,
            major => 'SESSION',
            DATE_START => '2024-06-15',
            DATE_END => '2024-06-15'
          } 
        }
      }
    }
  },

  'German Open Teams' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',
 
    # Numbering seems messed up:
    # https://www.bridge-verband.de/aktuelles/news/dbv/09_04_2018_64_offene_deutsche_team_meisterschaft_2011
    # Here I go with the numbers as in the .lin files.
    # Perhaps 2006 was really the 59th, etc.

    EDITIONS =>
    {
      '2006' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=16696&site=0&kl=0
        ORDINAL => '58th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2006,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-05-05',
            DATE_END => '2006-05-07'
          },
          'C1' => 
          {
            YEAR => 2006,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-05',
            DATE_END => '2006-05-07'
          } 
        }
      },

      '2009' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15986&site=0&kl=0
        ORDINAL => '61st',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-06'
          },
          'C1' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-06-06',
            DATE_END => '2009-06-07'
          },
          'C2' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-06-07',
            DATE_END => '2009-06-07'
          } 
        }
      },

      '2011' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=121&site=0&kl=0
        ORDINAL => '63rd',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            CITY => 'Kassel',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            CITY => 'Kassel',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-10',
            DATE_END => '2011-09-11'
          },
          'C2' => 
          {
            YEAR => 2011,
            CITY => 'Kassel',
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-11',
            DATE_END => '2011-09-11'
          } 
        }
      },

      '2013' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=121&site=0&kl=0
        ORDINAL => '65th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-08-16',
            DATE_END => '2013-08-17'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-08-17',
            DATE_END => '2013-08-18'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-08-18',
            DATE_END => '2013-08-18'
          } 
        }
      },

      '2014' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=843&site=0&kl=0
        ORDINAL => '66th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-23'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-08-23',
            DATE_END => '2014-08-24'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-08-24',
            DATE_END => '2014-08-24'
          } 
        }
      },

      '2015' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1706&site=0&kl=0
        ORDINAL => '67th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-23',
            MOVEMENT => 'Swiss',
            major => 'ROUND'
          },
          'C1' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-22',
            DATE_END => '2015-08-23',
            STAGE => 'Semifinal',
            major => 'SEGMENT'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=3210&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '69th', # Or 68th -- not clear
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-08-26',
            DATE_END => '2016-08-27'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-08-27',
            DATE_END => '2016-08-28'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=13841&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '69th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2017-08-26',
            DATE_END => '2017-08-27'
          },
          'C1' => 
          {
            YEAR => 2017,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-08-27',
            DATE_END => '2017-08-28'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=8830&site=0&kl=0
        ORDINAL => '70th',
        CITY => 'Kassel',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2018,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2018-06-01',
            DATE_END => '2018-06-03'
          },
          'C1' => 
          {
            YEAR => 2018,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-06-01',
            DATE_END => '2018-06-03'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=11140&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '71st',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2019-08-31',
            DATE_END => '2019-09-01'
          },
          'C1' => 
          {
            YEAR => 2019,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-08-31',
            DATE_END => '2019-09-01'
          } 
        }
      },

      '2021' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=15580&site=0&kl=0
        MEET => 'German Championship Week',
        ORDINAL => '72nd',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2021,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2021-08-20', # Estimated
            DATE_END => '2021-08-21'
          },
          'C1' => 
          {
            YEAR => 2021,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2021-08-20',
            DATE_END => '2021-08-21'
          } 
        }
      },

      '2022' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=20873&site=0&kl=0
        ORDINAL => '73rd',
        CITY => 'Bamberg',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2022,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2022-10-01',
            DATE_END => '2022-10-03'
          },
          'C1' => 
          {
            YEAR => 2022,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2022-10-01',
            DATE_END => '2022-10-03'
          } 
        }
      },

      '2023' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=24381&site=0&kl=0
        ORDINAL => '74th',
        CITY => 'Niedernhausen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2023,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2023-04-29',
            DATE_END => '2023-05-01'
          },
          'C1' => 
          {
            YEAR => 2023,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2023-04-29',
            DATE_END => '2023-05-01'
          } 
        }
      },

      '2024' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=31334&site=0&kl=0
        ORDINAL => '75th',
        CITY => 'Niedernhausen',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2024,
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2024-04-12',
            DATE_END => '2024-04-14'
          },
          'C1' => 
          {
            YEAR => 2024,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2024-04-12',
            DATE_END => '2024-04-14'
          } 
        }
      }
    }
  },

  'German Open Trials' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      '2003' => 
      {
        YEAR => 2003,
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            DATE_START => '2003-10-07',
            DATE_END => '2003-10-08',
            major => 'ROUND'
          }
        }
      },

      '2012' => 
      {
        YEAR => 2012,
        CITY => '',
        CHAPTERS => 
        {
          'WEEKEND 1' => 
          {
            DATE_START => '2012-01-20',
            DATE_END => '2012-01-22',
            STAGE => 'Round-robin',
            major => 'ROUND',
            WEEKEND => 1
          },
          'C1' => 
          {
            DATE_START => '2012-03-09',
            DATE_END => '2012-03-10',
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            WEEKEND => 2
          },
          'C2' => 
          {
            DATE_START => '2012-03-10',
            DATE_END => '2012-03-11',
            STAGE => 'Final',
            major => 'SEGMENT',
            WEEKEND => 2
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
            CITY => '',
            major => 'ROUND',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-16'
          } 
        }
      },

      '2016' => 
      {
        CHAPTERS => 
        {
          YEAR => 2016,
          CITY => '',
          'WEEKEND 1' => 
          {
            DATE_START => '2016-02-27',
            DATE_END => '2016-02-28',
            major => 'ROUND',
            WEEKEND => 1
          },
          'WEEKEND 2' => 
          {
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-13',
            major => 'ROUND',
            WEEKEND => 2,
            STAGE => 'Final'
          } 
        }
      }
    }
  },

  'German Team Trophy' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'International',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      '2010' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=41&submit=Anzeigen
        ORDINAL => '1st',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2010,
            CITY => 'Bonn',
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2010-05-14',
            DATE_END => '2010-05-14'
          },
          'C1' => 
          {
            YEAR => 2010,
            CITY => 'Bonn',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2010-05-14',
            DATE_END => '2010-05-16'
          } 
        }
      },

      '2011' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=84&site=0&kl=0
        ORDINAL => '2nd',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2011,
            CITY => 'Bonn',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2011-06-03',
            DATE_END => '2011-06-03'
          },
          'C1' => 
          {
            YEAR => 2011,
            CITY => 'Bonn',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2011-06-03',
            DATE_END => '2011-06-05'
          } 
        }
      },

      '2012' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=221&site=0&kl=0
        ORDINAL => '3rd',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2012,
            CITY => 'Bonn',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-18'
          },
          'C1' => 
          {
            YEAR => 2012,
            CITY => 'Bonn',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-20'
          } 
        }
      },

      '2013' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=373&site=0&kl=0
        ORDINAL => '4th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            CITY => 'Bonn',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2013-05-08',
            DATE_END => '2013-05-08'
          },
          'C1' => 
          {
            YEAR => 2013,
            CITY => 'Bonn',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2013-05-09',
            DATE_END => '2013-05-10'
          } 
        }
      },

      '2014' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=704&site=0&kl=0
        ORDINAL => '5th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-02'
          },
          'C1' => 
          {
            YEAR => 2014,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-04'
          } 
        }
      },

      '2015' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=1398&site=0&kl=0
        ORDINAL => '6th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-01'
          },
          'C1' => 
          {
            YEAR => 2015,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-03'
          } 
        }
      },

      '2016' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=2657&site=0&kl=0
        ORDINAL => '7th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-04-29',
            DATE_END => '2016-04-29'
          },
          'C1' => 
          {
            YEAR => 2016,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2016-04-29',
            DATE_END => '2016-05-01'
          } 
        }
      },

      '2017' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=4416&site=0&kl=0
        ORDINAL => '8th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2017-04-29',
            DATE_END => '2017-05-01'
          },
          'C1' => 
          {
            YEAR => 2017,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2017-04-29',
            DATE_END => '2017-05-01'
          } 
        }
      },

      '2018' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=6873&site=0&kl=0
        ORDINAL => '9th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2017,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2018-04-29',
            DATE_END => '2018-05-01'
          },
          'C1' => 
          {
            YEAR => 2017,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2018-04-29',
            DATE_END => '2018-05-01'
          } 
        }
      },

      '2019' => 
      {
        # https://ergebnisse.bridge-verband.de/index.php?turid=9900&site=0&kl=0
        ORDINAL => '10th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2019,
            CITY => 'Berlin',
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2019-04-26',
            DATE_END => '2019-04-28'
          },
          'C1' => 
          {
            YEAR => 2019,
            CITY => 'Berlin',
            MOVEMENT => 'Swiss',
            major => 'ROUND',
            DATE_START => '2019-04-26',
            DATE_END => '2019-04-28'
          } 
        }
      }
    }
  },

  'German Women Pairs' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Pairs',
    SCORING => 'MP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      # https://ergebnisse.bridge-verband.de/index.php?turid=9900&site=0&kl=0
      '2011' => {
        ORDINAL => '56th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            CITY => 'Darmstadt',
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-13'
          } 
        }
      },

      '2012' => {
        # https://ergebnisse.bridge-verband.de/index.php?turid=288&site=0&kl=0
        ORDINAL => '57th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            CITY => 'Darmstadt',
            major => 'SESSION',
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          } 
        }
      }
    }
  },

  "Gro's Supercup" => 
  {
    ORGANIZATION => 'Kultcamp Rieneck',
    COUNTRY => 'Germany',
    CITY => 'Rieneck',
    ORIGIN => 'Invitational',
    ZONE => 'Europe',
    FORM => 'Pairs',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2010' => 
      {
        ORDINAL => '1st',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-08-28',
            DATE_END => '2010-08-29'
          } 
        }
      },

      '2011' => 
      {
        ORDINAL => '2nd',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-08-27',
            DATE_END => '2011-08-28'
          } 
        }
      },

      '2012' => 
      {
        ORDINAL => '3rd',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-08-25',
            DATE_END => '2012-08-26'
          } 
        }
      },

      '2013' => 
      {
        ORDINAL => '4th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            DATE_START => '2013-07-20',
            DATE_END => '2013-07-20'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            DATE_START => '2013-07-21',
            DATE_END => '2013-07-21'
          } 
        }
      },

      '2014' => 
      {
        ORDINAL => '5th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2014-06-14',
            DATE_END => '2014-06-15'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            DATE_START => '2014-06-14',
            DATE_END => '2014-06-15'
          } 
        }
      },

      '2015' => 
      {
        ORDINAL => '6th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2015-05-23',
            DATE_END => '2015-05-24'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            DATE_START => '2015-05-25',
            DATE_END => '2015-05-25'
          } 
        }
      },

      '2016' => 
      {
        ORDINAL => '7th',
        CHAPTERS => 
        {
          'C0' => 
          {
            YEAR => 2016,
            STAGE => 'Qualifying',
            major => 'SESSION',
            DATE_START => '2016-05-14',
            DATE_END => '2016-05-15'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            DATE_START => '2016-05-16',
            DATE_END => '2016-05-16'
          } 
        }
      }
    }
  },

  'König Ludwig Nationen Cup' => 
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009' =>
      {
        ORDINAL => '2nd',
        CITY => 'Bad Griesbach',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            DATE_START => '2009-04-24',
            DATE_END => '2009-04-26'
          } 
        }
      }
    }
  }
);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_GERMANY, \%TOURNAMENTS_GERMANY, 'Germany');
}

1;
