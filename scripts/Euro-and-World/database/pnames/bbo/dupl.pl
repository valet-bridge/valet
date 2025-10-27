#!perl
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';

use lib '.';
use lib './Tags';

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

if ($#ARGV != 1)
{
  print "Usage: perl dupl.pl FIRSTFIRST FIRSTBBO > code.pl\n";
  exit;
}

my $tag1 = shift;
my $tag2 = shift;

die "$tag1 is not a recognized tag" unless exists $CATALOG{$tag1};
die "$tag2 is not a recognized tag" unless exists $CATALOG{$tag2};

my $whole = WholeBBO->new();
$whole->init_hashes;

my $hash_first = $whole->peek_list($tag1);

my $hash_firstBBO = $whole->peek_list($tag2);

# reprint($hash_firstBBO, $CATALOG{$tag1});

dedup($hash_first, $hash_firstBBO, $CATALOG{$tag1}, $CATALOG{$tag2});

