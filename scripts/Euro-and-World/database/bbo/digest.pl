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

if ($entryT->bbono() eq 711)
{
  # print "HERE\n";
}

  my ($edition, $chapter) = 
    $parseT->get_edition_and_chapter($tname, $entryT->field('DATE_ADDED'));

  next if $edition eq '';
  
  print "EDITION $edition\n";
  print "CHAPTER $chapter\n";
  print $entryT->str();
  $num_matches++;
  $hist_matches{$tname}++;
}

close $fh;

for my $key (sort keys %hist_matches)
{
  printf("%-30s %4d\n", $key, $hist_matches{$key});
}

print '-' x 35 . "\n";
printf("%-30s %4d\n", "Number of matches", $num_matches);

