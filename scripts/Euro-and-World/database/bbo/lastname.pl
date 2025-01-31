#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Check whether words match EBL name file.

die "perl lastname.pl file" unless ($#ARGV == 0);
my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot read file: $!";

my $ebl = '/home/s.hein/ebl.txt';
my %map;
open my $fe, '<', $ebl or die "Cannot read EBL: $!";
while (my $line = <$fe>)
{
  next unless $line =~ /^NAME (.+)$/;
  my $name = $1;
  my @a = split / /, $name;
  for my $word (@a)
  {
    $map{lc($word)}{lc($name)}++;
  }
}

my $lno = 0;

while (my $line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  if ($line =~ /UUU value (\w+)$/)
  {
    my $word = lc($1);
    if (exists $map{$word})
    {
      print "$word\n";
      for my $name (sort keys %{$map{$word}})
      {
        print "$name\n";
      }
      print "\n";
    }
    else
    {
      # print "$word: No match\n\n";
    }
  }
}

close $fh;
