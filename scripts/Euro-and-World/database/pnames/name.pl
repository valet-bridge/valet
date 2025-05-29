#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib '../bbo';

use ParseT;
use parseEBL;

# Full EBL data: Names and some tournaments the players played in.
my $EBL_FILE = 'full/EBL/names.txt';

# Iteratively improve the naming of players in BBO lin files.
# 
# 1. Read all Tournaments, or the specific country we're investigating.
# 2. Read the full EBL file with names and some tournaments.


die "perl name.pl [COUNTRY]" unless ($#ARGV <= 0);

my $division_flag = 0;
my $debug_division;

if ($#ARGV == 0)
{
  $division_flag = 1;
  $debug_division = $ARGV[1];
}

my @times;

# Read the Tournaments.

my $t0 = time();
# my $parseT = ParseT->new();
# $parseT->init_links($debug_division, $division_flag);
# $times[0] += time() - $t0;

# Read the full EBL name file.
# $t0 = time();
my $parseEBL = ParseEBL->new();
$parseEBL->read($EBL_FILE);
$times[1] += time() - $t0;

printf("parseT  \t%6.2f seconds\n", $times[0]);
printf("parseEBL\t%6.2f seconds\n", $times[1]);

exit;

# my ($tname, $edition, $chapter);
# ($tname, $edition, $chapter) =
  # $parseT->get_edition_and_chapter($meet, $tname, $entryT, 
    # $debug_flag, $division_flag);
