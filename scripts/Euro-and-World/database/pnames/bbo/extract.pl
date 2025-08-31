#!/usr/bin/perl
use strict;
use warnings;

# Read words from the first file into a hash for quick lookup
my %target_words;
open my $words_fh, '<', 'manual.txt' or die "Cannot open manual.txt: $!";
while (<$words_fh>) {
    chomp;
    $target_words{lc($_)} = 1;
}
close $words_fh;

# Process the second file
open my $entries_fh, '<', 'open3a' or die "Cannot open open3a: $!";
my $lno = 0;
while (my $line1 = <$entries_fh>) {
    chomp $line1;
    my $line2 = <$entries_fh>; chomp $line2;
    my $line3 = <$entries_fh>; chomp $line3;
    my $line4 = <$entries_fh>; chomp $line4;
    $lno += 4;

    if ($line4 ne '')
    {
      print "FORMAT1 $lno\n";
      next;
    }

    # Split line into words
    my @parts = split /[-\s,\.@\/]/, $line3;
    if ($#parts != 1)
    {
      # print "FORMAT2 $lno\n";
      next;
    }

    my $second_word = lc($parts[1]);

    if ($target_words{$second_word}) {
      print "$line1\n";
      print "$line2\n";
      print "$line3\n";
      print "$line4\n";
    }
}
close $entries_fh;

