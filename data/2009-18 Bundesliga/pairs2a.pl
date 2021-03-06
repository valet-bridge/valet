#!perl

use strict;
use warnings;
use v5.10;

# Works on old Merlin Butler files.

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  $fname =~ /butler(\d+)/;
  my $offset = 2000 * ($1 - 1);

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /^<tr align/;

    my @a = split /\<[^>]*\>/, $line;
    my $l = $a[8];
    my $pair = $a[6] + $offset;

    my @p = split ' - ', $l;

    say "$pair|$p[0]|$p[1]";
  }
  close $fh;
}

exit;

