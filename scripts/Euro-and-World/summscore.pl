#!perl

use strict;
use warnings;
use v5.10;

# perl getdist4.pl scores.txt
# Summarize the score file

# Parse command line.
die "Need a scores files" unless $#ARGV == 0;
my $sfile = shift;

open my $fh, "<$sfile" or die "Can't open file $sfile";
my (%boards, %scores);
read_tags();
close $fh;

printf("%4s  %4s  %6s  %6s\n", "Rd", "Bds", "Scores", "Per bd");

my ($rounds, $boardno, $scoreno);

for my $key (sort keys %boards) # Round
{
  my $b = 0;
  for my $key2 (keys %{$boards{$key}})
  {
    $b++;
  }

  printf("%4s  %4d  %6d  %6.2f\n", 
    $key, $b, $scores{$key}, $scores{$key} / $b);
  
  $rounds++;
  $boardno += $b;
  $scoreno += $scores{$key};
}

print "-" x 26, "\n";
printf("%4d  %4d  %6d\n", 
  $rounds, $boardno, $scoreno);


sub read_tags
{
  my $line;
  while ($line = <$fh>)
  {
    $line =~ s///g;
    chomp $line;
    $line =~ /^([^|]+)\|([^|]+)/;
    $boards{$1}{$2}++;
    $scores{$1}++;
  }
}
