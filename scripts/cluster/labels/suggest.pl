#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use v5.10;

use lib '.';
use Distributions;
use List::Util qw(max);

# Start from names file.
# Suggest edits based on a grep string and a full name.

if ($#ARGV != 1 && $#ARGV != 2)
{
  print "Usage: perl suggest.pl fantoni \"FANTONI Fulvio\" [\"NUNES Claudio\"]\n";
  exit;
}

my $gstr = $ARGV[0];
my $full = $ARGV[1];

my ($pard_flag, $valid_pard);
if ($#ARGV == 1)
{
  $pard_flag = 0;
  $valid_pard = '';
}
else
{
  $pard_flag = 1;
  $valid_pard = $ARGV[2];
}

my @PLAYERS;
read_lin_players("names_full.txt");

my %PDB;
read_player_DB("players.txt");

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
    next if defined $PDB{$player};
    
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
    next if $pard eq $full; # Don't partner yourself
    next if $players[$p] eq $full; # Already OK

    if (! $pard_flag || $pard eq $valid_pard)
    {
      $players[$p] = $full;
      print "SUGGEST $lin ", join(',', @players), "\n";
    }

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

