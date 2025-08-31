#!perl
use strict;
use warnings;

# use lib '..';
# use lib '../..';

# use FirstBBO;
# use LastBBO;

# use FirstFirst;
# use FirstMid;

# use LastMid;
# use LastLast;


# dedup(\@FIRST_MID_NAMES, \@LAST_MID_NAMES, 'BOTH_FIRST', 'BOTH_LAST');
# dedup(\@FIRST_FIRST_NAMES, \@FIRST_MID_NAMES, 'FIRST_FIRST_NAMES', 'FIRST_MID_NAMES');
# dedup(\@LAST_MID_NAMES, \@LAST_LAST_NAMES, 'LAST_MID_NAMES', 'LAST_LAST_NAMES');

# reprint(\@FIRST_BBO, 'FIRST_BBO');

use lib '.';
use lib '..';
use Tags::Fluff;
use Manip;

reprint(\@SINGLE_WORDS, 'SINGLE_WORDS');
