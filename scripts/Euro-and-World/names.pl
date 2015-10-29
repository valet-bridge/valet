#!perl

use strict;
use warnings;
use v5.10;

my $players_seen = 0;

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;

    if ($line =~ /people.person.asp/ || $line =~ /personpopup/)
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

