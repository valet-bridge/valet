#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::UK;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_UK =
(
);

my %TOURNAMENTS_UK =
(
  'British Gold Cup' => 
  {
    # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_Gold%20Cup%20Roll%20of%20Honour.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2007%20Gold%20Cup%20Finals.htm
      '2003' =>
      {
        ORDINAL => 66,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2003,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2003-12-13',
            DATE_END => '2003-12-14'
          },
        }
      },
      '2004' =>
      {
        ORDINAL => 67,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            STAGE => 'Final',
            DATE_START => '2004-12-12',
            DATE_END => '2004-12-12'
          },
        }
      },
      '2005' =>
      {
        ORDINAL => 68,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            DATE_START => '2005-12-10',
            DATE_END => '2005-12-11'
          },
        }
      },
      '2006' =>
      {
        ORDINAL => 69,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-12-09',
            DATE_END => '2006-12-10'
          },
        }
      },
      '2007' =>
      {
        ORDINAL => 70,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-12-09',
            DATE_END => '2007-12-09'
          },
        }
      },
      '2008' =>
      {
        ORDINAL => 71,
        CITY => 'Peebles',
        COUNTRY => 'Scotland',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-12-14',
            DATE_END => '2008-12-14'
          },
        }
      },
      '2009' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2009%20Gold%20Cup%20Finals.htm
        ORDINAL => 72,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SET',
            DATE_START => '2009-12-12',
            DATE_END => '2009-12-12'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SET',
            DATE_START => '2009-12-13',
            DATE_END => '2009-12-13'
          },
        }
      },
      '2010' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2010%20Gold%20Cup%20Finals.htm
        ORDINAL => 73,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2010-12-11',
            DATE_END => '2010-12-11'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2010-12-12',
            DATE_END => '2010-12-12'
          },
        }
      },
      '2011' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2011%20Gold%20Cup%20Final%20Stages.htm
        ORDINAL => 74,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2011-12-10',
            DATE_END => '2011-12-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2011-12-11',
            DATE_END => '2011-12-11'
          },
        }
      },
      '2012' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2012%20QF%20Results.htm
        ORDINAL => 75,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2012-12-08',
            DATE_END => '2012-12-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2012-12-09',
            DATE_END => '2012-12-09'
          },
        }
      },
      '2013' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2013%20Gold%20Cup%20%20Finals.pdf
        ORDINAL => 76,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2013-12-14',
            DATE_END => '2013-12-14'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2013-12-15',
            DATE_END => '2013-12-15'
          },
        }
      },
      '2014' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2014%20God%20Cup%20finals.htm
        ORDINAL => 77,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2014-12-14',
            DATE_END => '2014-12-14'
          },
        }
      },
      '2015' =>
      {
        # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_2015%20Gold%20Cup%20Finals.pdf
        ORDINAL => 78,
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2015-12-12',
            DATE_END => '2015-12-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2015-12-13',
            DATE_END => '2015-12-13'
          },
        }
      },
      '2017' =>
      {
        # https://www.ebu.co.uk/results/645
        ORDINAL => 80,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2017,
            DATE_START => '2017-10-07',
            DATE_END => '2017-10-08'
          },
        }
      },
      '2018' =>
      {
        # https://www.ebu.co.uk/results/708
        ORDINAL => 81,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2018,
            DATE_START => '2018-10-13',
            DATE_END => '2018-10-14'
          },
        }
      },
      '2019' =>
      {
        # https://www.ebu.co.uk/results/765
        ORDINAL => 82,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2019,
            DATE_START => '2019-10-12',
            DATE_END => '2019-10-13'
          },
        }
      },
      '2020' =>
      {
        # https://www.ebu.co.uk/results/1025
        ORDINAL => 83,
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-12-05',
            DATE_END => '2020-12-06'
          },
        }
      },
      '2021' =>
      {
        # https://www.ebu.co.uk/results/1026
        ORDINAL => 84,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-10-09',
            DATE_END => '2021-10-10'
          },
        }
      },
      '2022' =>
      {
        # https://www.ebu.co.uk/results/975
        ORDINAL => 85,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-10-08',
            DATE_END => '2022-10-09'
          },
        }
      },
      '2023' =>
      {
        # https://www.ebu.co.uk/results/1301
        ORDINAL => 86,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-10-07',
            DATE_END => '2023-10-08'
          },
        }
      },
      '2024' =>
      {
        # https://www.ebu.co.uk/results/1468
        ORDINAL => 87,
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-10-05',
            DATE_END => '2024-10-06'
          },
        }
      },
    }
  },

  'Camrose Trophy' => 
  {
    # https://www.bridgewebs.com/bgb/Camrose%20Winners.htm
    # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_Past%20Camrose%20Teams.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2002-03' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2002,
            major => 'MATCH',
            DATE_START => '2002-11-30',
            DATE_END => '2002-12-01'
          },
          'C1' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-01-02',
            DATE_END => '2003-01-02'
          },
          'C2' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-01-11',
            DATE_END => '2003-01-12'
          },
          'C3' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-02-01',
            DATE_END => '2003-02-02'
          },
          'C4' => 
          {
            YEAR => 2003,
            major => 'MATCH',
            DATE_START => '2003-02-22',
            DATE_END => '2003-02-23'
          },
        }
      },
      '2003-04' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2003,
            major => 'ROUND',
            DATE_START => '2003-12-06',
            DATE_END => '2003-12-07'
          },
          'C1' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-01-10',
            DATE_END => '2004-01-11'
          },
          'C2' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-02-07',
            DATE_END => '2004-02-08'
          },
          'C3' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-02-21',
            DATE_END => '2004-02-22'
          },
          'C4' => 
          {
            YEAR => 2004,
            major => 'ROUND',
            DATE_START => '2004-03-06',
            DATE_END => '2004-03-07'
          },
        }
      },
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            DATE_START => '2005-01-11',
            DATE_END => '2005-01-20'
          },
          'C1' => 
          {
            YEAR => 2005,
            major => 'ROUND',
            DATE_START => '2005-03-06',
            DATE_END => '2005-03-07'
          },
          'C2' => 
          {
            YEAR => 2005,
            DATE_START => '2005-03-14',
            DATE_END => '2005-03-17'
          },
          'C3' => 
          {
            YEAR => 2005,
            DATE_START => '2005-03-25',
            DATE_END => '2005-03-28'
          },
        }
      },
      '2006' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-01-07',
            DATE_END => '2006-01-08'
          },
          'C1' => 
          {
            YEAR => 2006,
            major => 'ROUND',
            DATE_START => '2006-03-03',
            DATE_END => '2006-03-05'
          },
        }
      },
      '2007' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            DATE_START => '2007-01-05',
            DATE_END => '2007-01-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2007-03-04',
            DATE_END => '2007-03-04'
          },
        }
      },
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2008-01-12',
            DATE_END => '2008-01-13'
          },
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
            minor => 'SEGMENT',
            DATE_START => '2009-03-06',
            DATE_END => '2009-03-08'
          }
        }
      },
      '2010' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            DATE_START => '2010-01-08',
            DATE_END => '2010-01-10'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2010-03-05',
            DATE_END => '2010-03-07'
          } 
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
            minor => 'SEGMENT',
            DATE_START => '2011-01-07',
            DATE_END => '2011-01-09'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2011-03-04',
            DATE_END => '2011-03-06'
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
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-01-06',
            DATE_END => '2012-01-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2012-03-02',
            DATE_END => '2012-03-04'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2013-01-04',
            DATE_END => '2013-01-06'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2013-03-01',
            DATE_END => '2013-03-03'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2014-01-10',
            DATE_END => '2014-01-12'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2014-03-07',
            DATE_END => '2014-03-09'
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
            DATE_START => '2015-01-09',
            DATE_END => '2015-01-11'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-01-22',
            DATE_END => '2015-01-25'
          },
          'C2' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2015-03-06',
            DATE_END => '2015-03-08'
          } 
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2016-01-08',
            DATE_END => '2016-01-10'
          },
          'C1' => 
          {
            YEAR => 2016,
            DATE_START => '2016-03-04',
            DATE_END => '2016-03-06'
          } 
        }
      },
    }
  },

  'English Open Trials' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-01-16',
            DATE_END => '2006-01-19'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SET',
            DATE_START => '2006-02-19',
            DATE_END => '2006-02-19'
          },
        }
      },
      '2006B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'STANZA',
            DATE_START => '2006-09-11',
            DATE_END => '2006-09-11'
          },
          'C1' => 
          {
            YEAR => 2006,
            major => 'STANZA',
            DATE_START => '2006-10-14',
            DATE_END => '2006-10-15'
          },
        }
      },
      '2007A' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-09-16',
            DATE_END => '2007-09-16'
          },
          'C1' => 
          {
            YEAR => 2007,
            major => 'MATCH',
            DATE_START => '2007-10-31',
            DATE_END => '2007-10-31'
          },
        }
      },
      '2007B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SET',
            DATE_START => '2007-11-25',
            DATE_END => '2007-11-25'
          },
        }
      },
      '2008A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
          },
        }
      },
      '2008B' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'ROUND',
            DATE_START => '2008-08-27',
            DATE_END => '2008-08-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-08-28',
            DATE_END => '2008-08-28'
          },
        }
      }
    }
  },

  'English Premier League' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    COUNTRY => 'England',
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
            major => 'MATCH',
            DATE_START => '2008-09-10',
            DATE_END => '2008-09-10'
          },
          'C1' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-08'
          },
          'C2' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-11-23',
            DATE_END => '2008-11-23'
          },
        }
      },
      '2009' =>
      {
        # https://www.ebu.co.uk/results/283
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2009-10-03',
            DATE_END => '2009-10-04'
          },
          'C1' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2009-10-24',
            DATE_END => '2009-10-24'
          },
          'C2' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2009-10-31',
            DATE_END => '2009-11-01'
          },
          'C3' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2009-11-13',
            DATE_END => '2009-11-15'
          },
        }
      },
      '2010' =>
      {
        # https://www.ebu.co.uk/results/224
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2010-09-11',
            DATE_END => '2010-09-12'
          },
          'C1' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2010-09-25',
            DATE_END => '2010-09-26'
          },
          'C2' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2010-11-13',
            DATE_END => '2010-11-14'
          },
        }
      },
      '2011' =>
      {
        # https://www.ebu.co.uk/results/166
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2011-09-24',
            DATE_END => '2011-09-25'
          },
          'C1' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2011-09-30',
            DATE_END => '2011-10-02'
          },
          'C2' => 
          {
            YEAR => 2011,
            major => 'MATCH',
            minor => 'SET',
            DATE_START => '2011-11-11',
            DATE_END => '2011-11-13'
          },
        }
      },
      '2012' =>
      {
        # https://www.ebu.co.uk/results/105
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            major => 'MATCH',
            minor => 'SET',
            DATE_START => '2012-09-22',
            DATE_END => '2012-09-23'
          },
          'C1' => 
          {
            YEAR => 2012,
            major => 'STANZA',
            DATE_START => '2012-10-27',
            DATE_END => '2012-10-28'
          },
          'C2' => 
          {
            YEAR => 2012,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2012-11-09',
            DATE_END => '2012-11-11'
          },
        }
      },
      '2013' =>
      {
        # https://www.ebu.co.uk/results/5
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            major => 'MATCH',
            DATE_START => '2013-10-12',
            DATE_END => '2013-10-13'
          },
          'C1' => 
          {
            YEAR => 2013,
            major => 'MATCH',
            DATE_START => '2013-11-08',
            DATE_END => '2013-11-10'
          },
        }
      },
      '2014' =>
      {
        # https://www.ebu.co.uk/results/48
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-09-20',
            DATE_END => '2014-09-21'
          },
          'C1' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2014-09-27',
            DATE_END => '2014-09-28'
          },
          'C2' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-11-07',
            DATE_END => '2014-11-09'
          },
        }
      },
      '2015' =>
      {
        # https://www.ebu.co.uk/results/428
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-09-12',
            DATE_END => '2015-09-13'
          },
          'C1' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-10-31',
            DATE_END => '2015-11-01'
          },
          'C2' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-11-06',
            DATE_END => '2015-11-07'
          },
        }
      },
    }
  },

  'English Senior Trials' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

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
            DATE_START => '2004-09-05',
            DATE_END => '2004-09-05'
          },
        }
      },
      '2012' =>
      {
        # https://www.ebu.co.uk/results/100
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            major => 'MATCH',
            DATE_START => '2012-12-15',
            DATE_END => '2012-12-16'
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
            major => 'MATCH',
            DATE_START => '2013-12-20',
            DATE_END => '2013-12-22'
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
            major => 'SEGMENT',
            DATE_START => '2014-01-04',
            DATE_END => '2014-01-05'
          },
        }
      },
      '2014B' =>
      {
        # https://www.ebu.co.uk/results/162
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-12-18',
            DATE_END => '2014-12-21'
          },
        }
      },
      '2015' =>
      {
        # https://www.ebu.co.uk/results/453
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2015-12-18',
            DATE_END => '2015-12-20'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2016-02-05',
            DATE_END => '2016-02-07'
          },
        }
      }
    }
  },

  'English U28 Trials' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'U28',

    EDITIONS =>
    {
      '2008' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
          },
        }
      }
    }
  },

  'English Women Teams' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2012' =>
      {
        # https://www.ebu.co.uk/results/116
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SET',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2012-09-02',
            DATE_END => '2012-09-02'
          },
        }
      }
    }
  },

  'English Women Trials' => 
  {
    ORGANIZATION => 'EBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    GENDER => 'Women',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            major => 'STANZA',
            DATE_START => '2006-10-17',
            DATE_END => '2006-10-17'
          },
          'C1' => 
          {
            YEAR => 2006,
            major => 'STANZA',
            DATE_START => '2006-11-13',
            DATE_END => '2006-11-13'
          },
        }
      },
      '2008' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-02-12',
            DATE_END => '2008-02-12'
          },
        }
      },
      '2009' =>
      {
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            DATE_START => '2009-01-05',
            DATE_END => '2009-01-05'
          },
        }
      },
      '2010' =>
      {
        # https://www.ebu.co.uk/results/277
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-01-22',
            DATE_END => '2010-01-24'
          },
        }
      },
      '2011' =>
      {
        # https://www.ebu.co.uk/results/217
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2011,
            DATE_START => '2011-01-21',
            DATE_END => '2011-01-23'
          },
        }
      },
      '2012' =>
      {
        # https://www.ebu.co.uk/results/155
        FORM => 'Pairs',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2012,
            DATE_START => '2012-01-13',
            DATE_END => '2012-01-15'
          },
        }
      },
      '2013' =>
      {
        # https://www.ebu.co.uk/results/94
        FORM => 'Pairs',
        SCORING => 'MP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            DATE_START => '2013-01-25',
            DATE_END => '2013-01-27'
          },
        }
      },
      '2014' =>
      {
        # https://www.ebu.co.uk/results/17
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            DATE_START => '2014-01-24',
            DATE_END => '2014-01-26'
          },
        }
      },
      '2015' =>
      {
        # https://www.ebu.co.uk/results/235
        FORM => 'Pairs',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            DATE_START => '2015-01-23',
            DATE_END => '2015-01-25'
          },
        }
      },
      '2016' =>
      {
        # https://www.ebu.co.uk/results/461
        FORM => 'Teams',
        SCORING => 'IMP',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            DATE_START => '2016-01-22',
            DATE_END => '2016-01-24'
          },
        }
      }
    }
  },

  'Junior Camrose' => 
  {
    # https://www.bridgewebs.com/bgb/Junior%20Camrose%20Winners.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Juniors',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'MATCH',
            DATE_START => '2006-02-19',
            DATE_END => '2006-02-19'
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
            major => 'MATCH',
            DATE_START => '2007-02-24',
            DATE_END => '2007-02-24'
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
            major => 'MATCH',
            DATE_START => '2008-03-03',
            DATE_END => '2008-03-03'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            DATE_START => '2009-02-21',
            DATE_END => '2009-02-22'
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
            major => 'MATCH',
            DATE_START => '2010-02-20',
            DATE_END => '2010-02-21'
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
            major => 'SESSION',
            DATE_START => '2011-02-19',
            DATE_END => '2011-02-20'
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
            major => 'MATCH',
            DATE_START => '2012-02-18',
            DATE_END => '2012-02-19'
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
            major => 'ROUND',
            minor => 'SET',
            DATE_START => '2013-02-16',
            DATE_END => '2013-02-17'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-02-22',
            DATE_END => '2014-02-23'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-02-21',
            DATE_END => '2015-02-22'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            DATE_START => '2016-02-19',
            DATE_END => '2016-02-21'
          },
        }
      },
    }
  },

  'Lady Milne Trophy' => 
  {
    # https://www.bridgewebs.com/bgb/Lady%20Milne%20Winners.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Women',
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
            major => 'MATCH',
            DATE_START => '2004-04-18',
            DATE_END => '2004-04-18'
          },
        }
      },
      '2005' =>
      {
        # https://www.ebu.co.uk/results/582
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            major => 'MATCH',
            DATE_START => '2005-04-15',
            DATE_END => '2005-04-17'
          },
        }
      },
      '2006' =>
      {
        # https://www.ebu.co.uk/results/513
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            major => 'MATCH',
            DATE_START => '2006-04-01',
            DATE_END => '2006-04-03'
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
            major => 'MATCH',
            DATE_START => '2007-04-14',
            DATE_END => '2007-04-16'
          },
        }
      },
      '2008' =>
      {
        # https://www.ebu.co.uk/results/363
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            major => 'MATCH',
            DATE_START => '2008-04-12',
            DATE_END => '2008-04-14'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2009-04-17',
            DATE_END => '2009-04-19'
          },
        }
      },
      '2010' =>
      {
        # https://www.ebu.co.uk/results/277
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            DATE_START => '2010-04-17',
            DATE_END => '2010-04-18'
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
            minor => 'MATCH',
            DATE_START => '2011-04-15',
            DATE_END => '2011-04-17'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2012-04-13',
            DATE_END => '2012-04-15'
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
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2013-04-12',
            DATE_END => '2013-04-14'
          },
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
            minor => 'MATCH',
            DATE_START => '2014-04-11',
            DATE_END => '2014-04-13'
          },
        }
      },
      '2015' =>
      {
        # https://www.ebu.co.uk/results/353
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'ROUND',
            minor => 'STANZA',
            DATE_START => '2015-04-17',
            DATE_END => '2015-04-19'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'MATCH',
            minor => 'STANZA',
            DATE_START => '2016-04-15',
            DATE_END => '2016-04-17'
          },
        }
      },
    }
  },

  'Lederer Memorial Trophy' => 
  {
    # https://lederertrophy.com/previous-winners/
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
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2004,
            major => 'MATCH',
            DATE_START => '2004-10-16',
            DATE_END => '2004-10-17'
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
            major => 'MATCH',
            DATE_START => '2005-10-16',
            DATE_END => '2005-10-17'
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
            major => 'MATCH',
            DATE_START => '2006-10-31',
            DATE_END => '2006-10-31'
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
            major => 'MATCH',
            DATE_START => '2007-10-22',
            DATE_END => '2007-10-22'
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
            major => 'MATCH',
            DATE_START => '2008-11-05',
            DATE_END => '2008-11-05'
          },
        }
      },
      '2009' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2009,
            major => 'MATCH',
            DATE_START => '2009-10-17',
            DATE_END => '2009-10-18'
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
            major => 'MATCH',
            DATE_START => '2010-10-30',
            DATE_END => '2010-10-31'
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
            major => 'MATCH',
            DATE_START => '2011-11-19',
            DATE_END => '2011-11-20'
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
            major => 'MATCH',
            DATE_START => '2012-09-29',
            DATE_END => '2012-09-30'
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
            major => 'MATCH',
            DATE_START => '2013-10-26',
            DATE_END => '2013-10-27'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-02-28',
            DATE_END => '2015-03-01'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'MATCH',
            DATE_START => '2016-02-27',
            DATE_END => '2016-02-28'
          },
        }
      },
    }
  },

  'Scottish Cup' => 
  {
    # https://www.sbu.org.uk/results/archived-results
    ORGANIZATION => 'SBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    COUNTRY => 'Scotland',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2006' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            DATE_START => '2006-05-06',
            DATE_END => '2006-05-06'
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
            major => 'QUARTER',
            DATE_START => '2007-05-30',
            DATE_END => '2007-05-30'
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
            major => 'STANZA',
            DATE_START => '2008-05-21',
            DATE_END => '2008-05-21'
          },
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
            DATE_START => '2009-05-16',
            DATE_END => '2009-05-16'
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
            major => 'STANZA',
            DATE_START => '2010-05-15',
            DATE_END => '2010-05-15'
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
            major => 'STANZA',
            DATE_START => '2011-05-14',
            DATE_END => '2011-05-14'
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
            major => 'STANZA',
            DATE_START => '2012-05-12',
            DATE_END => '2012-05-12'
          },
        }
      },
      '2013A' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2013-05-11',
            DATE_END => '2013-05-11'
          },
        }
      },
      '2013B' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-12-14',
            DATE_END => '2013-12-14'
          },
        }
      },
      '2014-15' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-12-09',
            DATE_END => '2014-12-09'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-12-13',
            DATE_END => '2014-12-13'
          },
          'C2' => 
          {
            # Not sure what this is.
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-01',
            DATE_END => '2015-02-01'
          },
        }
      }
    }
  },

  'Scottish National League' => 
  {
    # https://www.sbu.org.uk/results/archived-results
    ORGANIZATION => 'SBU',
    ORIGIN => 'Interclub',
    ZONE => 'Europe',
    COUNTRY => 'Scotland',
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
          'SINGLE' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2013-08-24',
            DATE_END => '2013-08-24'
          },
        }
      }
    }
  },

  'Spring Foursomes' => 
  {
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
        # https://www.ebu.co.uk/results/576
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-05-02',
            DATE_END => '2005-05-03'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-03',
            DATE_END => '2005-05-03'
          },
        }
      },
      '2006' =>
      {
        # https://www.ebu.co.uk/results/505
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-04-28',
            DATE_END => '2006-05-02'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-05-02',
            DATE_END => '2006-05-02'
          },
        }
      },
      '2007' =>
      {
        # https://www.ebu.co.uk/results/413
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-05-04',
            DATE_END => '2007-05-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-05-08',
            DATE_END => '2007-05-08'
          },
        }
      },
      '2008' =>
      {
        # https://www.ebu.co.uk/results/637
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SET',
            DATE_START => '2008-05-02',
            DATE_END => '2008-05-06'
          },
        }
      },
      '2009' =>
      {
        # https://www.ebu.co.uk/results/314
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-05-01',
            DATE_END => '2009-05-05'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-05-05',
            DATE_END => '2009-05-05'
          },
        }
      },
      '2010' =>
      {
        # https://www.ebu.co.uk/results/256
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2010,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-04-30',
            DATE_END => '2010-05-04'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-05-04',
            DATE_END => '2010-05-04'
          },
        }
      },
      '2011' =>
      {
        # https://www.ebu.co.uk/results/202
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-04-29',
            DATE_END => '2011-05-03'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-05-03',
            DATE_END => '2011-05-03'
          },
        }
      },
      '2012' =>
      {
        # https://www.ebu.co.uk/results/135
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SET',
            DATE_START => '2012-05-04',
            DATE_END => '2012-05-08'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2012-05-08',
            DATE_END => '2012-05-08'
          },
        }
      },
      '2013' =>
      {
        # https://www.ebu.co.uk/results/63
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-05-03',
            DATE_END => '2013-05-07'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-05-07',
            DATE_END => '2013-05-07'
          },
        }
      },
      '2014' =>
      {
        # https://www.ebu.co.uk/results/30
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2014-05-02',
            DATE_END => '2014-05-05'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2014-05-06',
            DATE_END => '2014-05-06'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2014-05-06',
            DATE_END => '2014-05-06'
          },
        }
      },
      '2015' =>
      {
        # https://www.ebu.co.uk/results/361
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2015-05-01',
            DATE_END => '2015-05-05'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2015-05-05',
            DATE_END => '2015-05-05'
          },
        }
      },
      '2016' =>
      {
        # https://www.ebu.co.uk/results/492
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2016,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2016-04-29',
            DATE_END => '2016-05-02'
          },
          'C1' => 
          {
            YEAR => 2016,
            STAGE => 'Semifinal',
            major => 'STANZA',
            DATE_START => '2016-05-03',
            DATE_END => '2016-05-03'
          },
          'C2' => 
          {
            YEAR => 2016,
            STAGE => 'Final',
            major => 'STANZA',
            DATE_START => '2016-05-03',
            DATE_END => '2016-05-03'
          },
        }
      },
    }
  },

  'Teltscher Trophy' => 
  {
    # https://www.bridgewebs.com/bgb/Past%20Teltscher%20Trophy%20Winners.htm
    # https://www.sbu.org.uk/international/international-news/international-hall-of-fame/history/senior-camrose-teams
    # https://www.bridgewebs.com/cgi-bin/bwor/bw.cgi?club=bgb&pid=docs_Past%20Teltscher%20Trophy%20Teams.htm
    ORIGIN => 'International',
    ZONE => 'Europe',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Seniors',

    EDITIONS =>
    {
      '2010' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            major => 'SESSION',
            DATE_START => '2010-05-28',
            DATE_END => '2010-05-30'
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
            major => 'MATCH',
            DATE_START => '2012-05-18',
            DATE_END => '2012-05-20'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'MATCH',
            DATE_START => '2014-05-16',
            DATE_END => '2014-05-18'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'MATCH',
            DATE_START => '2015-05-15',
            DATE_END => '2015-05-17'
          },
        }
      },
      '2016' =>
      {
        CITY => 'Edinburgh',
        COUNTRY => 'Scotland',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2016-05-20',
            DATE_END => '2016-05-22'
          },
        }
      },
      # 2017 Belfast
      # 2018 Wales
      # 2019 Edinburgh
      '2020' =>
      {
        # https://bridgeresults.org/o/2020_teltscher_trophy/2020_teltscher_trophyr.asp
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2020,
            DATE_START => '2020-05-15',
            DATE_END => '2021-05-17'
          },
        }
      },
      '2021' =>
      {
        # https://www.ebu.co.uk/results/807
        CITY => 'Online',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2021,
            DATE_START => '2021-04-16',
            DATE_END => '2021-04-18'
          },
        }
      },
      '2022' =>
      {
        # https://www.ebu.co.uk/internationals/team/senior/teltscher-trophy-2022
        CITY => 'Belfast',
        COUNTRY => 'Northern Ireland',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2022,
            DATE_START => '2022-05-20',
            DATE_END => '2022-05-22'
          },
        }
      },
      '2023' =>
      {
        # https://www.ebu.co.uk/internationals/team/senior/teltscher-trophy-2023
        CITY => 'Newport',
        COUNTRY => 'Wales',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2023,
            DATE_START => '2023-05-19',
            DATE_END => '2023-05-21'
          },
        }
      },
      '2024' =>
      {
        # https://www.ebu.co.uk/internationals/team/senior/teltscher-trophy-2024
        CITY => 'Stirling',
        COUNTRY => 'Scotland',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2024,
            DATE_START => '2024-05-17',
            DATE_END => '2024-05-19'
          },
        }
      },
    }
  },

  'TGR Auction Pairs' => 
  {
    # https://www.bridgewebs.com/tgrs/
    ORIGIN => 'International',
    ZONE => 'Europe',
    COUNTRY => 'England',
    FORM => 'Pairs',
    SCORING => 'MP',
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
            major => 'SESSION',
            DATE_START => '2010-01-17',
            DATE_END => '2010-01-17'
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
            major => 'SESSION',
            DATE_START => '2011-01-15',
            DATE_END => '2011-01-16'
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
            major => 'SESSION',
            DATE_START => '2012-01-14',
            DATE_END => '2012-01-15'
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
            major => 'SESSION',
            DATE_START => '2013-01-12',
            DATE_END => '2013-01-13'
          },
        }
      },
      '2014' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2014,
            major => 'SESSION',
            DATE_START => '2014-01-11',
            DATE_END => '2014-01-12'
          },
        }
      },
      '2015' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2015,
            major => 'SESSION',
            DATE_START => '2015-01-10',
            DATE_END => '2015-01-11'
          },
        }
      },
      '2016' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2016,
            major => 'SESSION',
            DATE_START => '2016-01-09',
            DATE_END => '2016-01-10'
          },
        }
      }
    }
  },

  'TGR Auction Teams' => 
  {
    # https://www.bridgewebs.com/tgrs/
    ORIGIN => 'International',
    ZONE => 'Europe',
    COUNTRY => 'England',
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
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2011-09-03',
            DATE_END => '2011-09-03'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-04',
            DATE_END => '2011-09-04'
          },
        }
      }
    }
  },

  'TGR Super League' => 
  {
    # https://www.bridgewebs.com/tgrs/
    ORIGIN => 'Regional',
    ZONE => 'Europe',
    COUNTRY => 'England',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2009-10' =>
      {
        CHAPTERS =>
        {
          'C00' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            minor => 'HALF',
            DATE_START => '2009-09-16',
            DATE_END => '2009-09-16'
          },
          'C01' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-09-30',
            DATE_END => '2009-09-30'
          },
          'C02' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-10-07',
            DATE_END => '2009-10-07'
          },
          'C03' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-10-07',
            DATE_START => '2009-10-14',
            DATE_END => '2009-10-14'
          },
          'C04' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-10-28',
            DATE_END => '2009-10-28'
          },
          'C05' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-04',
            DATE_END => '2009-11-04'
          },
          'C06' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-10',
            DATE_END => '2009-11-11'
          },
          'C07' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-11-18',
            DATE_END => '2009-11-18'
          },
          'C08' => 
          {
            YEAR => 2009,
            major => 'ROUND',
            DATE_START => '2009-12-09',
            DATE_END => '2009-12-09'
          },
          'C09' => 
          {
            YEAR => 2010,
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2010-01-20',
            DATE_END => '2010-01-20'
          },
          'C10' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-01-27',
            DATE_END => '2010-01-27'
          },
          'C11' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-02-03',
            DATE_END => '2010-02-03'
          },
          'C12' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-02-17',
            DATE_END => '2010-02-17'
          },
          'C13' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-03-03',
            DATE_END => '2010-03-03'
          },
          'C14' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-03-24',
            DATE_END => '2010-03-24'
          },
          'C15' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-04-14',
            DATE_END => '2010-04-14'
          },
          'C16' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-04-28',
            DATE_END => '2010-04-28'
          },
          'C17' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-05-12',
            DATE_END => '2010-05-12'
          },
        }
      },
      '2010-11' =>
      {
        CHAPTERS =>
        {
          'C00' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-09-15',
            DATE_END => '2010-09-15'
          },
          'C01' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-09-22',
            DATE_END => '2010-09-22'
          },
          'C02' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            minor => 'SEGMENT',
            DATE_START => '2010-09-29',
            DATE_END => '2010-09-29'
          },
          'C03' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-10-27',
            DATE_END => '2010-10-27'
          },
          'C04' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-03',
            DATE_END => '2010-11-03'
          },
          'C05' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-10',
            DATE_END => '2010-11-10'
          },
          'C06' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-11-17',
            DATE_END => '2010-11-17'
          },
          'C07' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-12-01',
            DATE_END => '2010-12-01'
          },
          'C08' => 
          {
            YEAR => 2010,
            major => 'ROUND',
            DATE_START => '2010-12-15',
            DATE_END => '2010-12-15'
          },
          'C09' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-02-09',
            DATE_END => '2011-02-09'
          },
          'C10' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-02-23',
            DATE_END => '2011-02-23'
          },
          'C11' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-03-02',
            DATE_END => '2011-03-02'
          },
          'C12' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-03-16',
            DATE_END => '2011-03-16'
          },
          'C13' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-03-23',
            DATE_END => '2011-03-23'
          },
          'C14' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-06',
            DATE_END => '2011-04-06'
          },
          'C15' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-04-27',
            DATE_END => '2011-04-27'
          },
          'C16' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-05-11',
            DATE_END => '2011-05-11'
          },
          'C17' => 
          {
            YEAR => 2011,
            major => 'ROUND',
            DATE_START => '2011-06-01',
            DATE_END => '2011-06-01'
          },
          'C18' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            DATE_START => '2011-06-08',
            DATE_END => '2011-06-08'
          },
        }
      }
    }
  },

  'Welsh Invitational Pairs' => 
  {
    # https://www.bridgewebs.com/tgrs/
    ORGANIZATION => 'WBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    COUNTRY => 'Scotland',
    FORM => 'Pairs',
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
            major => 'ROUND',
            DATE_START => '2009-09-20',
            DATE_END => '2009-09-20'
          },
        }
      }
    }
  },

  'Welsh Open Trials' => 
  {
    # https://welshbridgeunion.org/archive-test
    ORGANIZATION => 'WBU',
    ORIGIN => 'National',
    ZONE => 'Europe',
    COUNTRY => 'Scotland',
    FORM => 'Pairs',
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
            SCORING => 'MP',
            major => 'MATCH',
            DATE_START => '2011-10-15',
            DATE_END => '2011-10-16'
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
            SCORING => 'IMP',
            major => 'ROUND',
            DATE_START => '2012-10-20',
            DATE_END => '2012-10-21'
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
            SCORING => 'MP',
            major => 'MATCH',
            DATE_START => '2013-10-19',
            DATE_END => '2013-10-20'
          },
        }
      }
    }
  },

  'Young Chelsea Knock-out' => 
  {
    # https://www.bridgewebs.com/cgi-bin/bwoq/bw.cgi?club=youngchelsea&pid=display_page12
    ORIGIN => 'Regional',
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
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-07-16',
            DATE_END => '2008-07-16'
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
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-01-03',
            DATE_END => '2010-01-03'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-09-19',
            DATE_END => '2010-09-19'
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
            DATE_START => '2011-08-07',
            DATE_END => '2011-08-07'
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
            DATE_START => '2012-08-05',
            DATE_END => '2012-08-05'
          },
        }
      }
    },
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_UK, \%TOURNAMENTS_UK, 'United Kingdom');
}

1;
