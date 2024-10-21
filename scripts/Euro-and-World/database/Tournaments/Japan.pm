#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tournaments::Japan;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_links);

my %MEETS_JAPAN =
(
  'Yokohama Bridge Festival' =>
  {
    ORGANIZATION => 'JCBL',
    COUNTRY => 'Japan',
    ORIGIN => 'National',
    ZONE => 'Asia',

    EDITIONS => 
    {
      '2001' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/6th/tabid/235/Default.aspx
        ORDINAL => 6,
        YEAR => 2001,
        DATE_START => '2001-02-07',
        DATE_END => '2001-02-11'
      },
      '2005' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/10th/tabid/231/Default.aspx
        ORDINAL => 10,
        YEAR => 2005,
        DATE_START => '2005-02-08',
        DATE_END => '2005-02-13'
      },
      '2006' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/11th/tabid/230/Default.aspx
        ORDINAL => 11,
        YEAR => 2006,
        DATE_START => '2006-02-07',
        DATE_END => '2006-02-12'
      },
      '2007' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/12th/tabid/229/Default.aspx
        ORDINAL => 12,
        YEAR => 2007,
        DATE_START => '2007-02-07',
        DATE_END => '2007-02-12'
      },
      '2008' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/13th/tabid/228/Default.aspx
        ORDINAL => 13,
        YEAR => 2008,
        DATE_START => '2008-02-06',
        DATE_END => '2008-02-11'
      },
      '2009' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/14th/tabid/227/Default.aspx
        ORDINAL => 14,
        YEAR => 2009,
        DATE_START => '2009-02-10',
        DATE_END => '2009-02-15'
      },
      '2010' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/15th/tabid/226/Default.aspx
        ORDINAL => 15,
        YEAR => 2010,
        DATE_START => '2010-02-09',
        DATE_END => '2010-02-14'
      },
      '2011' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/16th/tabid/225/Default.aspx
        ORDINAL => 16,
        YEAR => 2011,
        DATE_START => '2011-02-08',
        DATE_END => '2011-02-13'
      },
      '2012' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/16th/tabid/225/Default.aspx
        ORDINAL => 17,
        YEAR => 2012,
        DATE_START => '2012-02-07',
        DATE_END => '2012-02-12'
      },
      '2013' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/18th/tabid/1125/Default.aspx
        ORDINAL => 18,
        YEAR => 2013,
        DATE_START => '2013-04-16',
        DATE_END => '2013-04-21'
      },
      '2014' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/19th/tabid/1190/Default.aspx
        ORDINAL => 19,
        YEAR => 2014,
        DATE_START => '2014-02-11',
        DATE_END => '2014-02-16'
      },
      '2015' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/20th/tabid/1191/Default.aspx
        ORDINAL => 20,
        YEAR => 2015,
        DATE_START => '2015-02-10',
        DATE_END => '2015-02-15'
      },
      '2017' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/past/21st/tabid/1429/Default.aspx
        ORDINAL => 21,
        YEAR => 2017,
        DATE_START => '2017-02-07',
        DATE_END => '2017-02-12'
      },
      '2019' =>
      {
        # https://www.jcbl.or.jp/home/English/bf/22nd/tabid/1574/Default.aspx
        ORDINAL => 22,
        YEAR => 2019,
        DATE_START => '2019-02-19',
        DATE_END => '2019-02-24'
      },
    }
  }
);

my %TOURNAMENTS_JAPAN =
(
  'Japanese District KO Teams' => 
  {
    ORGANIZATION => 'JCBL',
    COUNTRY => 'Japan',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'SEGMENT',
            DATE_START => '2006-05-28',
            DATE_END => '2006-05-28'
          } 
        }
      },
    }
  },

  'Japanese Open Trials' => 
  {
    ORGANIZATION => 'JCBL',
    COUNTRY => 'Japan',
    ORIGIN => 'National',
    ZONE => 'Asia',
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
            major => 'MATCH',
            DATE_START => '2006-03-08',
            DATE_END => '2006-03-12'
          } 
        }
      },
    }
  },

  'Kanto Teams' => 
  {
    ORGANIZATION => 'JCBL',
    COUNTRY => 'Japan',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-05-15',
            DATE_END => '2005-05-15'
          } 
        }
      },
    }
  },

  'NEC Cup' => 
  {
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2001' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2001,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2001-02-08',
            DATE_END => '2001-02-08'
          },
          'C1' => 
          {
            YEAR => 2001,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2001-02-09',
            DATE_END => '2001-02-09'
          },
          'C2' => 
          {
            YEAR => 2001,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2001-02-10',
            DATE_END => '2001-02-10'
          },
          'C3' => 
          {
            YEAR => 2001,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2001-02-11',
            DATE_END => '2001-02-11'
          } 
        }
      },
      '2005' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Round-robin',
            major => 'ROUND',
            DATE_START => '2005-02-08',
            DATE_END => '2005-02-09'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2005-02-10',
            DATE_END => '2005-02-10'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-02-11',
            DATE_END => '2005-02-11'
          },
          'C3' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-02-12',
            DATE_END => '2005-02-12'
          },
        }
      },
      '2006' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2006,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2006-02-07',
            DATE_END => '2006-02-08'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2006-02-09',
            DATE_END => '2006-02-09'
          },
          'C2' => 
          {
            YEAR => 2006,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2006-02-10',
            DATE_END => '2006-02-10'
          },
          'C3' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-02-11',
            DATE_END => '2006-02-11'
          },
        }
      },
      '2007' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2007,
            STAGE => 'Round-robin',
            major => 'MATCH',
            DATE_START => '2007-02-08',
            DATE_END => '2007-02-08'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2007-02-09',
            DATE_END => '2007-02-09'
          },
          'C2' => 
          {
            YEAR => 2007,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2007-02-10',
            DATE_END => '2007-02-10'
          },
          'C3' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-02-11',
            DATE_END => '2007-02-11'
          } 
        }
      },
      '2008' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2008,
            STAGE => 'Round-robin',
            major => 'MATCH',
            DATE_START => '2008-02-07',
            DATE_END => '2008-02-07'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2008-02-08',
            DATE_END => '2008-02-08'
          },
          'C2' => 
          {
            YEAR => 2008,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2008-02-09',
            DATE_END => '2008-02-09'
          },
          'C3' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-02-10',
            DATE_END => '2008-02-10'
          },
        }
      },
      '2009' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2009,
            STAGE => 'Qualifying',
            major => 'MATCH',
            DATE_START => '2009-02-12',
            DATE_END => '2009-02-12'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2009-02-12',
            DATE_END => '2009-02-12'
          },
          'C2' => 
          {
            YEAR => 2009,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2009-02-13',
            DATE_END => '2009-02-13'
          },
          'C3' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-02-13',
            DATE_END => '2009-02-14'
          },
        }
      },
      '2010' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'SINGLE' => 
          {
            YEAR => 2010,
            DATE_START => '2010-02-08',
            DATE_END => '2010-02-13'
          } 
        }
      },
      '2011' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2011,
            STAGE => 'Qualifying',
            major => 'MATCH',
            DATE_START => '2011-02-07',
            DATE_END => '2011-02-10'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2011-02-10',
            DATE_END => '2011-02-11'
          },
          'C2' => 
          {
            YEAR => 2011,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-11'
          },
          'C3' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-02-11',
            DATE_END => '2011-02-12'
          },
        }
      },
      '2012' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2012,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2012-02-06',
            DATE_END => '2012-02-09'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-09',
            DATE_END => '2012-02-09'
          },
          'C2' => 
          {
            YEAR => 2012,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-10'
          },
          'C3' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-02-10',
            DATE_END => '2012-02-11'
          },
        }
      },
      '2013' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2013,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2013-04-16',
            DATE_END => '2013-04-18'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-19',
            DATE_END => '2013-04-19'
          },
          'C2' => 
          {
            YEAR => 2013,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2013-04-19',
            DATE_END => '2013-04-19'
          },
          'C3' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-04-20',
            DATE_END => '2013-04-20'
          } 
        }
      },
      '2014' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2014,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2014-02-11',
            DATE_END => '2014-02-13'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-14'
          },
          'C2' => 
          {
            YEAR => 2014,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-02-14',
            DATE_END => '2014-02-14'
          },
          'C3' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-02-15',
            DATE_END => '2014-02-15'
          },
        }
      },
      '2015' =>
      {
        MEET => 'Yokohama Bridge Festival',
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2015,
            STAGE => 'Qualifying',
            major => 'ROUND',
            DATE_START => '2015-02-10',
            DATE_END => '2015-02-12'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Quarterfinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-13'
          },
          'C2' => 
          {
            YEAR => 2015,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2015-02-13',
            DATE_END => '2015-02-13'
          },
          'C3' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-02-14',
            DATE_END => '2015-02-14'
          },
        }
      },
    }
  },

  'Prince Takamatsu Cup' => 
  {
    ORGANIZATION => 'JCBL',
    COUNTRY => 'Japan',
    ORIGIN => 'National',
    ZONE => 'Asia',
    FORM => 'Teams',
    SCORING => 'IMP',
    GENDER => 'Open',
    AGE => 'Open',

    EDITIONS =>
    {
      '2005' =>
      {
        CHAPTERS =>
        {
          'C0' => 
          {
            YEAR => 2005,
            STAGE => 'Qualifying',
            major => 'MATCH',
            minor => 'SEGMENT',
            DATE_START => '2005-09-23',
            DATE_END => '2005-09-23'
          },
          'C1' => 
          {
            YEAR => 2005,
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2005-09-24',
            DATE_END => '2005-09-24'
          },
          'C2' => 
          {
            YEAR => 2005,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2005-09-25',
            DATE_END => '2005-09-25'
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
            DATE_START => '2006-10-04',
            DATE_END => '2006-10-04'
          },
          'C1' => 
          {
            YEAR => 2006,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2006-10-04',
            DATE_END => '2006-10-04'
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
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
          },
          'C1' => 
          {
            YEAR => 2007,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2007-09-29',
            DATE_END => '2007-09-29'
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
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
          },
          'C1' => 
          {
            YEAR => 2008,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2008-09-27',
            DATE_END => '2008-09-27'
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
            DATE_START => '2009-09-26',
            DATE_END => '2009-09-27'
          },
          'C1' => 
          {
            YEAR => 2009,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2009-09-27',
            DATE_END => '2009-09-27'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2010-09-25',
            DATE_END => '2010-09-26'
          },
          'C1' => 
          {
            YEAR => 2010,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2010-09-26',
            DATE_END => '2010-09-26'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2011-09-24',
            DATE_END => '2011-09-25'
          },
          'C1' => 
          {
            YEAR => 2011,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2011-09-25',
            DATE_END => '2011-09-25'
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
            DATE_START => '2012-09-23',
            DATE_END => '2012-09-23'
          },
          'C1' => 
          {
            YEAR => 2012,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2012-09-23',
            DATE_END => '2012-09-23'
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
            DATE_START => '2013-09-22',
            DATE_END => '2013-09-22'
          },
          'C1' => 
          {
            YEAR => 2013,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2013-09-22',
            DATE_END => '2013-09-22'
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
            STAGE => 'Semifinal',
            major => 'SEGMENT',
            DATE_START => '2014-09-21',
            DATE_END => '2014-09-21'
          },
          'C1' => 
          {
            YEAR => 2014,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2014-09-21',
            DATE_END => '2014-09-21'
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
            DATE_START => '2015-09-23',
            DATE_END => '2015-09-23'
          },
          'C1' => 
          {
            YEAR => 2015,
            STAGE => 'Final',
            major => 'SEGMENT',
            DATE_START => '2015-09-23',
            DATE_END => '2015-09-23'
          } 
        }
      },

      # https://bridgescanner.com/event/takamatsunomiya-memorial-cup-2020
      # https://bridgescanner.com/event/takamatsunomiya-memorial-cup-2021
      # https://bridgescanner.com/event/takamatsunomiya-memorial-cup-2022
      # https://bridgescanner.com/event/takamatsunomiya-memorial-cup-2023
    }
  },

);


sub set_links
{
  my ($method) = @_;

  $method->(\%MEETS_JAPAN, \%TOURNAMENTS_JAPAN, 'Japan');
}

1;
