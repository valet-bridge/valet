#!perl

use strict;
use warnings;
use v5.10;

# Useful for names that we have inserted ourselves.

my $players_seen = 0;

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;

    # This is how we recognize them...
    if ($line =~ /href=11111/)
    {
      die "Too many players" if ($players_seen == 8);
      $line =~ s/\<[^>]*\>//g;
      $line =~ s/\&nbsp;//g;
      $line =~ s/^\s*//;
      $line =~ s/\s*$//;

      say $line;
    }
    break if ($players_seen == 8);
  }
  close $fh;
}

exit;

