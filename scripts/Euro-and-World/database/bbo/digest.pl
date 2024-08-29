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
my %hist_matches;

my $entryT = EntryT->new();
while ($entryT->read($fh))
{
  my $tname = $entryT->field('TITLE_TNAME');
  next if $tname eq '';
  my $edition = $parseT->get_edition($tname, $entryT->field('DATE_ADDED'));
  next if $edition eq '';
  
  print "EDITION $edition\n";
  print $entryT->str();
  $num_matches++;
  $hist_matches{$tname}++;
}

close $fh;

print "Number of matches: $num_matches\n\n";

for my $key (sort keys %hist_matches)
{
  printf("%-30s %4d\n", $key, $hist_matches{$key});
}

