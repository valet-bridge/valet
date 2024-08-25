#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';

use ParseT;
use EntryT;

# Parse the raw output of cook.pl
# Recognize and check tournaments

die "perl digest.pl cooked.txt" unless $#ARGV == 0;
my $file = $ARGV[0];

my $parseT = ParseT->new();
$parseT->init_links();

open my $fh, '<', $file or die "Cannot read tfile: $!";

my $num_matches = 0;

my $entryT = EntryT->new();
while ($entryT->read($fh))
{
  next unless $entryT->tname() ne '' &&
      $parseT->is_tname($entryT->tname());
  
  print $entryT->str();
  $num_matches++;
}

close $fh;

print "Number of matches: $num_matches\n";

