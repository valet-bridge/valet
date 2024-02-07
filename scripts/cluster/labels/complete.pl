#!perl

use strict;
use warnings;
use v5.10;

# Suggest edits of the complete names file, like suggest.pl
# but for the whole file at once.
# 

if ($#ARGV >= 0)
{
  print "Usage: perl complete.pl\n";
  exit;
}

my $names_file = 'names_full.txt';
my $bak_file = 'names_full.bak';

my @PLAYERS;
read_lin_players($names_file);

my %PDB;
read_player_DB("players.txt");

my $PLAYER_SKIP = 0;
my $PLAYER_FOUND = 1;
my $PLAYER_MISSED = 2;

my @PARD_NO = qw(2 3 0 1 6 7 4 5);

my (%good_good, %good_bad);
my (%gg_count, %gb_count);

for my $lin (0 .. $#PLAYERS)
{
  next unless defined $PLAYERS[$lin];

  my @players = split /,/, $PLAYERS[$lin];

  if ($#players == -1)
  {
    # print "$lin $PLAYERS[$lin]\n";
    next;
  }

  die "Not 4 or 8 players in $lin ($#players): $PLAYERS[$lin]"
    unless ($#players == 3 || $#players == 7);

  my @player_data;

  for my $p (0 .. $#players)
  {
    if (! defined $players[$p])
    {
      $player_data[$p] = $PLAYER_SKIP;
      next;
    }

    my $player = $players[$p];

    if (
      $player eq '' ||
      $player eq 'North' ||
      $player eq 'East' ||
      $player eq 'South' ||
      $player eq 'West' ||
      $player eq 'Multiple')
    {
      $player_data[$p]{type} = $PLAYER_SKIP;
      next;
    }
    
    if (defined $PDB{$player})
    {
      $player_data[$p] = $PLAYER_FOUND;
    }
    else
    {
      $player_data[$p] = $PLAYER_MISSED;
    }
  }

  for my $p (0 .. $#players)
  {
    next unless $player_data[$p] == $PLAYER_FOUND;

    my $pard_no = $PARD_NO[$p];
    next if $player_data[$pard_no] == $PLAYER_SKIP;

    if ($player_data[$pard_no] == $PLAYER_FOUND)
    {
      $good_good{$players[$p]}{$players[$pard_no]}++;
      $gg_count{$players[$p]}++;
    }
    else
    {
      $good_bad{$players[$p]}{$players[$pard_no]}++;
      $gb_count{$players[$p]}++;
    }
  }
}


foreach my $k (sort {$good_good{$b} <=> $good_good{$a}} keys %good_good)
{
  next unless defined $gb_count{$k};

  print("# PLAYER $k:\n");
  print_hash(\%{$good_good{$k}}, '*');
  print("#\n");
  print_hash(\%{$good_bad{$k}}, ' ');
  print("#\n");
  print_suggest(\%{$good_good{$k}}, $k);
  print("\n");
}


sub print_hash
{
  my ($gref, $ident) = @_;

  foreach my $k (sort {$gref->{$b} <=> $gref->{$a}} keys %$gref)
  {
    printf("# %s %6d %s\n", $ident, $gref->{$k}, $k);
  }
}

sub print_suggest
{
  my ($gref, $orig) = @_;

  foreach my $k (sort {$gref->{$b} <=> $gref->{$a}} keys %$gref)
  {
    printf("\"%s\" \"%s\"\n", $k, $orig);
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




