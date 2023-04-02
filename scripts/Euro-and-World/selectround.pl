#!perl

use strict;
use warnings;
use v5.10;

# Select one round from a score file.

use File::Fetch;

# perl selectround.pl 1 2005-World/Open/scores.txt > scores1.txt

# Round to select for output.
my $round = shift;

my $fname = shift;
open my $fh, "<$fname" or die "Can't open file $fname $!";

while (my $line = <$fh>)
{
  $line =~ s///g;
  chomp $line;
  next if $line =~ /^#/;

  $line =~ /^(\d+)/;
  next unless $1 == $round;
  say $line;
}

close $fh;
