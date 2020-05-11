#!perl

use strict;
use warnings;
use v5.10;

# Turn US-style CSV into German-style CSV

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;

    $line =~ s/,/;/g;
    $line =~ s/\./,/g;
    $line =~ s/Dr,/Dr./g;
    say $line;
  }
  close $fh;
}

exit;

