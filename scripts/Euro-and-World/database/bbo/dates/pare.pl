#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Pare down the times that were found.

die "perl pare.pl file" unless $#ARGV == 0;
my $file = shift;

my $bbono;
my %times;

open my $fh, '<', $file or die "Cannot read file: $!";

while (my $line = <$fh>) 
{
  chomp $line;
  $line =~ s/\/$//;

  if ($line =~ /^(\d+)$/)
  {
    $bbono = $1;
  }
  elsif ($line ne '')
  {
    if ($line =~ /^(\d\d\d\d)-(\d\d)-(\d\d)T.*/)
    {
      my ($year, $month, $day) = ($1, $2, $3);
      next if $year < 1990;
      next if ($bbono < 50000 && $year > 2022);

      my $date = "$year-$month-$day";
      $times{$date} = 1;
    }
  }
  elsif (%times)
  {
    print "BBONO $bbono\n";
    for my $entry (sort keys %times)
    {
      print "DATE_TEXT $entry\n";
    }
    print "\n";
    %times = ();
  }
}

close $fh;

