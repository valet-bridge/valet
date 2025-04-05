#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Throw-away script to summarize the output of cook.pl when it only
# flags title words that are not found.

die "perl tsum.pl file" unless ($#ARGV == 0);
my $file = $ARGV[0];

open my $fh, '<', $file or die "Cannot read file: $!";
my %hash;
my $lno = 0;

while (my $line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  next unless $line =~ /^SSS (\d+): (.+)/;
  my ($bbono, $title) = ($1, $2);

  $hash{$title}{COUNT}++;
  push @{$hash{$title}{LIST}}, $bbono;
}

close $fh;

foreach my $title 
(
  sort { $hash{$a}{LIST}[0] <=> $hash{$b}{LIST}[0] } keys %hash
) 
{
  print "$title: @{$hash{$title}{LIST}}\n";
}

