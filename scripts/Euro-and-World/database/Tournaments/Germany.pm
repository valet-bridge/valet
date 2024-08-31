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
          'SINGLE' =>
          {
            YEAR => 2004,
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
          'SINGLE' =>
          {
            YEAR => 2005,
            DATE_START => '2005-05-04',
            DATE_END => '2005-05-05'
          } 
        }
      },

      '2006' =>
      {
        ORDINAL => '21st',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2006,
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
          'SINGLE' =>
          {
            YEAR => 2007,
            DATE_START => '2007-05-16',
            DATE_END => '2007-05-17'
          } 
        }
      },

      '2008' =>
      {
        ORDINAL => '23rd',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2008,
            DATE_START => '2008-04-30',
            DATE_END => '2008-05-01'
          } 
        }
      },

      '2009' =>
      {
        ORDINAL => '24th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2009,
            DATE_START => '2009-05-20',
            DATE_END => '2009-05-21'
          } 
        }
      },

      '2010' =>
      {
        ORDINAL => '25th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2010,
            DATE_START => '2010-05-12',
            DATE_END => '2010-05-13'
          } 
        }
      },

      '2011' =>
      {
        ORDINAL => '26th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2011,
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-02'
          } 
        }
      },

      '2012' =>
      {
        ORDINAL => '27th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2012,
            DATE_START => '2012-05-16',
            DATE_END => '2012-05-17'
          } 
        }
      }
    }
  },

  'Dr. Heinz von Rotteck Pokal' =>
  {
    ORGANIZATION => 'DBV',
    COUNTRY => 'Germany',
    ORIGIN => 'National',
    FORM => 'Teams',
    SCORING => 'Pairs',
    GENDER => 'Open',
    AGE => 'Open',
 
    EDITIONS =>
    {
      '2009' => 
      {
        ORDINAL => '6th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2009,
            CITY => 'Bad Nauheim',
            DATE_START => '2009-11-21',
            DATE_END => '2009-11-22'
          } 
        }
      },

      '2011' => 
      {
        ORDINAL => '8th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2011,
            CITY => 'Darmstadt',
            DATE_START => '2011-11-12',
            DATE_END => '2011-11-13'
          } 
        }
      },

      '2012' => 
      {
        ORDINAL => '9th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2012,
            CITY => 'Darmstadt',
            DATE_START => '2012-11-10',
            DATE_END => '2012-11-11'
          } 
        }
      },

      '2013' => 
      {
        ORDINAL => '10th',
        CHAPTERS => 
        {
          'SINGLE' =>
          {
            YEAR => 2013,
            CITY => 'Darmstadt',
            DATE_START => '2013-11-09',
            DATE_END => '2013-11-10'
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
        CHAPTERS => 
        {
          YEAR => 2013,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2013-01-19',
            DATE_END => '2013-01-20',
            WEEKEND => 1
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17',
            WEEKEND => 2
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2013-03-02',
            DATE_END => '2013-03-03',
            WEEKEND => 3
          } 
        }
      },

      '2014' => 
      {
        CHAPTERS => 
        {
          YEAR => 2014,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2014-01-18',
            DATE_END => '2014-01-19',
            WEEKEND => 1
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2014-03-15',
            DATE_END => '2014-03-16',
            WEEKEND => 2
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2014-04-05',
            DATE_END => '2014-04-06',
            WEEKEND => 3
          } 
        }
      },

      '2015' => 
      {
        CHAPTERS => 
        {
          YEAR => 2015,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2015-01-24',
            DATE_END => '2015-01-25',
            WEEKEND => 1
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2015-03-07',
            DATE_END => '2015-03-08',
            WEEKEND => 2
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2015-04-25',
            DATE_END => '2015-04-26',
            WEEKEND => 3
          } 
        }
      },

      '2016' => 
      {
        CHAPTERS => 
        {
          YEAR => 2016,
          CITY => 'Kassel',

          'WEEKEND 1' =>
          {
            DATE_START => '2016-01-23',
            DATE_END => '2016-01-24',
            WEEKEND => 1
          },
          'WEEKEND 2' =>
          {
            DATE_START => '2016-02-20',
            DATE_END => '2016-02-21',
            WEEKEND => 2
          },
          'WEEKEND 3' =>
          {
            DATE_START => '2016-03-05',
            DATE_END => '2016-03-06',
            WEEKEND => 3
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
          'SINGLE' => 
          {
            YEAR => 2005,
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
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
            CITY => 'Düsseldorf',
            DATE_START => '2006-12-02',
            DATE_END => '2006-12-03'
          } 
        }
      },

      '2008' => 
      {
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2086,
            CITY => 'Bonn',
            DATE_START => '2008-11-15',
            DATE_END => '2008-11-16'
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
            CITY => 'Kassel',
            DATE_START => '2009-11-28',
            DATE_END => '2009-11-29'
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
            CITY => 'Kassel',
            DATE_START => '2010-11-27',
            DATE_END => '2010-11-28'
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
            CITY => 'Bonn',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-11'
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
            CITY => 'Kassel',
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-09'
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
            CITY => 'Kassel',
            DATE_START => '2013-11-23',
            DATE_END => '2013-11-24'
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
            CITY => 'Darmstadt',
            DATE_START => '2014-11-22',
            DATE_END => '2014-11-23'
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
            CITY => 'Darmstadt',
            DATE_START => '2015-11-21',
            DATE_END => '2015-11-22'
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
        ORDINAL => '8th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-20',
            DATE_END => '2014-08-21'
          } 
        }
      },

      '2015' => 
      {
        ORDINAL => '9th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-15',
            DATE_END => '2015-08-16'
          } 
        }
      },

      '2016' => 
      {
        ORDINAL => '10th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-20',
            DATE_END => '2016-08-21'
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
            DATE_END => '2003-10-08'
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
            WEEKEND => 1
          },
          'WEEKEND 2' => 
          {
            DATE_START => '2012-03-09',
            DATE_END => '2012-03-11',
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
            WEEKEND => 1
          },
          'WEEKEND 2' => 
          {
            DATE_START => '2016-03-12',
            DATE_END => '2016-03-13',
            WEEKEND => 2
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
        ORDINAL => '58th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            CITY => 'Kassel',
            DATE_START => '2006-05-05',
            DATE_END => '2006-05-07'
          } 
        }
      },

      '2009' => 
      {
        ORDINAL => '61st',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            CITY => 'Kassel',
            DATE_START => '2009-06-05',
            DATE_END => '2009-06-07'
          } 
        }
      },

      '2011' => 
      {
        ORDINAL => '64th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            CITY => 'Kassel',
            DATE_START => '2011-09-09',
            DATE_END => '2011-09-11'
          } 
        }
      },

      '2013' => 
      {
        ORDINAL => '66th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-08-16',
            DATE_END => '2013-08-18'
          } 
        }
      },

      '2014' => 
      {
        ORDINAL => '67th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-08-22',
            DATE_END => '2014-08-24'
          } 
        }
      },

      '2015' => 
      {
        ORDINAL => '68th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-08-21',
            DATE_END => '2015-08-23'
          } 
        }
      },

      '2016' => 
      {
        ORDINAL => '69th',
        MEET => 'German Championship Week',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-08-26',
            DATE_END => '2016-08-28'
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
        ORDINAL => '1st',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            CITY => 'Bonn',
            DATE_START => '2010-05-14',
            DATE_END => '2010-05-16'
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
            CITY => 'Bonn',
            DATE_START => '2011-06-03',
            DATE_END => '2011-06-05'
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
            CITY => 'Bonn',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-20'
          } 
        }
      },

      '2013' => 
      {
        ORDINAL => '4th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            CITY => 'Bonn',
            DATE_START => '2013-05-08',
            DATE_END => '2013-05-10'
          } 
        }
      },

      '2014' => 
      {
        ORDINAL => '5th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            CITY => 'Berlin',
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-04'
          } 
        }
      },

      '2015' => 
      {
        ORDINAL => '6th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            CITY => 'Berlin',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-03'
          } 
        }
      },

      '2016' => 
      {
        ORDINAL => '7th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            CITY => 'Berlin',
            DATE_START => '2016-04-29',
            DATE_END => '2016-05-01'
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
        ORDINAL => '57th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            CITY => 'Darmstadt',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-07-20',
            DATE_END => '2013-07-21'
          } 
        }
      },

      '2014' => 
      {
        ORDINAL => '5th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2014,
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
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-05-23',
            DATE_END => '2015-05-25'
          } 
        }
      },

      '2016' => 
      {
        ORDINAL => '7th',
        CHAPTERS => 
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-05-14',
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
