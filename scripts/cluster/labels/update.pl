#!perl

use strict;
use warnings;
use v5.10;

# perl update.pl grep-string full-name partner-name.
# 
# Modifies the names file:
# - Takes all lines where the partner contains partner-name.
# - Takes the line when the player greps to grep-string /i.
#   Skips if the player is already in the form of full-name.
#   (Case-insensive but an equal-comparison).
# - Replaces the player with full-name.
# - Makes a backup copy of the names file.

my $names_file = 'copy.txt';
my $bak_file = 'names_full.bak';

if ($#ARGV != 2)
{
  print "Usage: perl update.pl grep-str full-str partner-str\n";
  exit;
}

my $grep_str = $ARGV[0];
my $full_str = $ARGV[1];
my $pard_str = $ARGV[2];

my @PLAYERS;
read_lin_players($names_file);

my %PDB;
read_player_DB("players.txt");

rename $names_file, $bak_file or die "Can't rename";

open my $fn, '>', $names_file or die "Can't write";

for my $lin (0 .. $#PLAYERS)
{
  next unless defined $PLAYERS[$lin];

  my @players = split /,/, $PLAYERS[$lin];

  if ($#players == -1)
  {
    print $fn "$lin $PLAYERS[$lin]\n";
    next;
  }

  die "Not 4 or 8 players in $lin ($#players): $PLAYERS[$lin]"
    unless ($#players == 3 || $#players == 7);

  my $found_flag = 0;
  my $modified_line = '';

  for my $p (0 .. $#players)
  {
    next unless defined $players[$p];
    my $player = $players[$p];

    next if (
      $player eq '' ||
      $player eq 'North' ||
      $player eq 'East' ||
      $player eq 'South' ||
      $player eq 'West' ||
      $player eq 'Multiple');
    
    next unless $player =~ /$grep_str/i;
    next if defined $PDB{$player};
    
    my $pardno;
    if ($p == 0 || $p == 1 || $p == 4 || $p == 5)
    {
      $pardno = $p + 2;
    }
    else
    {
      $pardno = $p - 2;
    }

    next if $player eq $full_str; # Don't fix a good entry

    my $pard = $players[$pardno];
    next if $pard eq $full_str; # Don't partner yourself
    next unless lc($pard) eq lc($pard_str);

    # Fix the player.
    $found_flag = 1;
    $players[$p] = $full_str;

    $modified_line = join(',', @players);
  }

  if ($found_flag)
  {
    print $fn "$lin $modified_line\n";
  }
  else
  {
    print $fn "$lin $PLAYERS[$lin]\n";
  }
}

close $fn;

# Show the updated partner list.

@PLAYERS = ();
read_lin_players($names_file);

my %partners;

for my $lin (0 .. $#PLAYERS)
{
  next unless defined $PLAYERS[$lin];

  my @players = split /,/, $PLAYERS[$lin];

  next unless $#players >= 0;
  die "Not 4 or 8 players in $lin ($#players): $PLAYERS[$lin]"
    unless ($#players == 3 || $#players == 7);

  for my $p (0 .. $#players)
  {
    next unless defined $players[$p];
    my $player = $players[$p];

    next if (
      $player eq '' ||
      $player eq 'North' ||
      $player eq 'East' ||
      $player eq 'South' ||
      $player eq 'West' ||
      $player eq 'Multiple');
    
    my $pardno;
    if ($p == 0 || $p == 1 || $p == 4 || $p == 5)
    {
      $pardno = $p + 2;
    }
    else
    {
      $pardno = $p - 2;
    }

    my $pard = $players[$pardno];
    next if $pard eq $player; # Don't partner yourself
    next unless lc($pard) eq lc($pard_str);

    $partners{$player}++;
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




