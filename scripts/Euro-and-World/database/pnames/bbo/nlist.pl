#!perl
use strict;
use warnings;

my $file = 'first.txt';

my %first;

open my $fh, '<', $file or die "Can't read $file: $!";
while (my $line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  next if $line =~ /^\s*$/;

  if ($line =~ /\s+/)
  {
    warn "SPACE $line";
    next;
  }

  $first{lc($line)} = 1;
}
close $fh;

for my $name (sort keys %first)
{
  print "$name\n";
}
