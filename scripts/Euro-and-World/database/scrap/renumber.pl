#!perl

use strict;
use warnings;
use v5.10;

# Following dedup.pl, this renumbers the ebl.txt file.

die "perl renumber.pl" unless $#ARGV == -1;

my $dedup_file = 'dedup2.txt';
my $ebl_file = '../2_genders/ebl.txt';

open my $fd, '<', $dedup_file or die "Cannot read $dedup_file: $!";
open my $fe, '<', $ebl_file or die "Cannot read $ebl_file: $!";

my @dedup;
while (my $line = <$fd>)
{
  chomp $line;
  $line =~ /^(\d+)\s+(\d+)$/;
  $dedup[$1] = $2; # old to new
}
close $fd;

while (my $line = <$fe>)
{
  chomp $line;

  if ($line !~ /^TOURNAMENT (.*)$/)
  {
    print "$line\n";
    next;
  }

  my @a = split /\|/, $1;

  if (defined $dedup[$a[0]])
  {
    $a[0] = $dedup[$a[0]];
  }

  print "TOURNAMENT ", join('|', @a), "\n";
}

close $fe;

exit;

