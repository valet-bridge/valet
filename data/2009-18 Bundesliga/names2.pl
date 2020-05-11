#!perl

use strict;
use warnings;
use v5.10;

# Works on old Merlin Butler files.

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /^<tr align/;

    my @a = split /\<[^>]*\>/, $line;
    my $l = $a[8];

    my @p = split ' - ', $l;
    say $p[0];
    say $p[1];
  }
  close $fh;
}

exit;

