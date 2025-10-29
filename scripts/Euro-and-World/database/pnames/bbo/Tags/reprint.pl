#!perl
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';

use lib '.';
use lib '..';

use Manip;
use WholeBBO;

my %CATALOG = (
  FIRSTFIRST => 'FirstFirst',
  FIRSTMID => 'FirstMid',
  FIRSTBBO => 'FirstBBO',
  FIRSTCOMB => 'FirstComb',
  LASTLAST => 'LastLast',
  LASTMID => 'LastMid',
  LASTBBO => 'LastBBO',
  LASTCOMB => 'LastComb'
);

if ($#ARGV != 0)
{
  print "Usage: perl reprint.pl FIRSTFIRST > code.pl\n";
  exit;
}

my $tag = shift;

die "$tag is not a recognized tag" unless exists $CATALOG{$tag};

my $whole = WholeBBO->new();
$whole->init_hashes;

my $hash = $whole->peek_list($tag);

reprint($hash, $CATALOG{$tag});


