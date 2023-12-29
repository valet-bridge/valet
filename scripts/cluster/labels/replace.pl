#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use v5.10;

use lib '.';
use Distributions;
use List::Util qw(max);

# Start from the output of suggest.pl.
# Implement the changes to the input file.

if ($#ARGV != 0)
{
  print "Usage: perl replace.pl suggest.txt\n";
  exit;
}

my $sfile = $ARGV[0];

my @PLAYERS;
read_lin_players("names_full.txt");

my @SUGGESTS;
read_suggests($sfile);

for my $lin (0 .. $#PLAYERS)
{
  next unless defined $PLAYERS[$lin];
  if (defined $SUGGESTS[$lin])
  {
    print $lin, " ", $SUGGESTS[$lin], "\n";
  }
  else
  {
    print $lin, " ", $PLAYERS[$lin], "\n";
  }
}


sub read_lin_players
{
  my $fname = pop;
  open my $fp, '<', $fname or return; # File doesn't have to exist

  while (my $line = <$fp>)
  {
    chomp $line;
    $line =~ s///g;
    next if ($line =~ /^#/);
    next if ($line =~ /^\s*$/);

    $line =~ /^(\d+)\s+(.*)/;
    
    $PLAYERS[$1] = $2;
  }
  close $fp;
}


sub read_suggests
{
  my $fname = pop;
  open my $fp, '<', $fname or return; # File doesn't have to exist

  while (my $line = <$fp>)
  {
    chomp $line;
    $line =~ s///g;
    next if ($line =~ /^#/);
    next if ($line =~ /^\s*$/);

    $line =~ /^SUGGEST (\d+)\s+(.*)/;
    
    $SUGGESTS[$1] = $2;
  }
  close $fp;
}

