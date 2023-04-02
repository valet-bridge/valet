#!perl 
use strict;
use warnings;
use v5.10;

# perl score2ext.pl scores.txt
# Makes a list of the form ddd.dd, where the triple is the round
# (zero-padded) and the double is the board.  For example:
# 001.02 (Round 1 Board 2), avoiding duplicated.

my $fname = shift;
open my $fh, "<$fname" or die "Can't open file $fname";
my $line;
my %array;
while ($line = <$fh>)
{
  $line =~ s///g;
  chomp $line;
  $line =~ /^(\d+)\|(\d+)/;
  $array{$1}{$2}++;
}

for my $key1 (sort keys %array)
{
  for my $key2 (sort keys %{$array{$key1}})
  {
    printf("%03d.%02d\n", $key1, $key2);
  }
}
