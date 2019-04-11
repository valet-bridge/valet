#!perl

use strict;
use warnings;
use v5.10;

for my $fname (@ARGV)
{
  # say "File $fname";
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /^<span id/;

    $line =~ /id=P(\d+)/;
    my $pair = $1;

    $line =~ s/^[^>]*>//;
    $line =~ s/<.*$//;

    my @p = split ' - ', $line;
    say "$pair|$p[0]|$p[1]";
  }
  close $fh;
}

exit;

