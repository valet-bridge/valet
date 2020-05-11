#!perl

use strict;
use warnings;
use v5.10;

# Gets names from individual score lines (2014).

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /TITLE/;

    # my @a = split /\<[^>]*\>/, $line;
    my @a = split "'", $line;
    my $na = $#a;

    for my $i (0 .. $na)
    {
      if ($a[$i] eq ',TITLE,')
      {
        my $pair = $a[$i-1];
        my $l = $a[$i+2];
        $l =~ /UnTip\(\);\>(\d+)/;
        my $pno = $1;

        my @players = split ' - ', $pair;
        say $players[0];
        say $players[1];
      }
    }
  }
  close $fh;
}

exit;

