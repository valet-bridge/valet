#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use v5.10;

use lib '.';
use Distributions;
use List::Util qw(max);

# Start from names file.
# Extracts a player's partners.

if ($#ARGV != 0)
{
  print "Usage: perl suggest.pl fantoni\n";
  exit;
}

my $gstr = $ARGV[0];

my @PLAYERS;
read_lin_players("names_full.txt");

my %PDB;
read_player_DB("players.txt");

my %partners;

for my $lin (0 .. $#PLAYERS)
{
  next unless defined $PLAYERS[$lin];

  my @players = split /,/, $PLAYERS[$lin];

  for my $p (0 .. $#players)
  {
    next if (
      ! defined $players[$p] ||
      $players[$p] eq '' ||
      $players[$p] eq 'North' ||
      $players[$p] eq 'East' ||
      $players[$p] eq 'South' ||
      $players[$p] eq 'West' ||
      $players[$p] eq 'Multiple');
    
    my $player = $players[$p];
    next unless $player =~ /$gstr/i;
    
    my $pardno;
    if ($p == 0 || $p == 1)
    {
      $pardno = $p + 2;
    }
    elsif ($p == 2 || $p == 3)
    {
      $pardno = $p - 2;
    }
    elsif ($p == 4 || $p == 5)
    {
      $pardno = $p + 2;
    }
    elsif ($p == 6 || $p == 7)
    {
      $pardno = $p - 2;
    }

    my $pard = $players[$pardno];
    next if $pard eq $players[$p]; # Don't partner yourself

    $partners{$pard}++;
  }
}

foreach my $k (sort {$partners{$b} <=> $partners{$a}} keys %partners)
{
  printf("%6d  %s\n", $partners{$k}, $k);
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


sub read_player_DB
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
    my @fields = split /,/, $line;
    my %parse;
    for my $field (@fields)
    {
      my @subs = split /:/, $field;
      $parse{$subs[0]} = $subs[1]
    }

    my $pname = $parse{'DB'};
    for my $p (keys %parse)
    {
      next if $p eq 'DB';
      $PDB{$pname}{$p} = $parse{$p};
    }
  }
  close $fp;
}

