#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use v5.10;

use lib '.';
use Distributions;
use List::Util qw(max);

# Statistics of the lin names file.

if ($#ARGV != 0)
{
  print "Usage: perl statnames.pl names_full.txt\n";
  exit;
}

my $sfile = $ARGV[0];

my @PLAYERS;
read_lin_players($sfile);

my %PDB;
# read_player_DB("players.txt");
read_simple_player_file("pnames.txt");

my (%hits_final, %hits_unresolved);
my $num_hits_final = 0;
my $num_hits_unresolved = 0;

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
    if (defined $PDB{$player})
    {
      $hits_final{$player}++;
      $num_hits_final++;
    }
    else
    {
      $hits_unresolved{$player}++;
      $num_hits_unresolved++;
    }
  }
}

foreach my $k (sort {$hits_final{$b} <=> $hits_final{$a}} 
  keys %hits_final)
{
  printf("%6d  %s\n", $hits_final{$k}, $k);
}
print "-" x 30, "\n";
printf("%6d\n\n", $num_hits_final);

foreach my $k (sort {$hits_unresolved{$b} <=> $hits_unresolved{$a}} 
  keys %hits_unresolved)
{
  printf("%6d  %s\n", $hits_unresolved{$k}, $k);
}
print "-" x 30, "\n";
printf("%6d\n\n", $num_hits_unresolved);



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


sub read_simple_player_file
{
  my $fname = pop;
  open my $fp, '<', $fname or return; # File doesn't have to exist

  while (my $line = <$fp>)
  {
    chomp $line;
    $line =~ s///g;
    next if ($line =~ /^#/);
    next if ($line =~ /^\s*$/);

    if ($line !~ /^(\d+)\s+(.*)/)
    {
      print "$line\n";
    }
    $PDB{$2} = $1;
  }
  close $fp;
}
