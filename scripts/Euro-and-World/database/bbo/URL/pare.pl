#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use Exclude;

# Pare down the URL's that were found.

die "perl url.pl file" unless $#ARGV == 0;
my $file = shift;

my $bbono;
my %urls;

open my $fh, '<', $file or die "Cannot read file: $!";

while (my $line = <$fh>) 
{
  chomp $line;
  $line =~ s/\/$//;

  if ($line =~ /^(\d+).lin$/)
  {
    $bbono = $1;
  }
  elsif ($line ne '')
  {
    next if excluded($line);
    $urls{$line} = 1;
  }
  elsif (%urls)
  {
    print "BBONO $bbono\n";
    for my $entry (sort keys %urls)
    {
      print "$entry\n";
    }
    print "\n";
    %urls = ();
  }
}

close $fh;

