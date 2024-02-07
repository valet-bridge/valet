#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use v5.10;

use lib '.';
use Distributions;
use List::Util qw(max);

# Start from suit and dist values as well as sigmoids.
# Skip over data from lin files on a skip list.
# Score each line of the triages.csv file
# - ODDPASS if pass (0) even though p(1L) > 90%
# - ODDPRE if preempt (2) even though p(1L) > 50%
# - ODDONE if 1L (1) even though p(1L) < 10

if ($#ARGV != 0)
{
  print "Usage: perl odds.pl triages.csv\n";
  exit;
}

my $POS_SELECT = 0;

my $file = $ARGV[0];

my (@SUIT_NAMES, @SUIT_VALUES);
read_suit_names("nonines/strongs0_suit");

my (@DIST_NAMES, @DIST_VALUES);
read_dist_names("nonines/strongs0_dist");

my @SIGMOIDS;
read_sigmoids("nonines/strongs0_sigmoid");

my @LINSKIPS;
read_linskips("nonines/linskips");

my @PLAYERS;
read_players("names_full.txt");

my @VULS = qw(none both we they);

open my $fr, '<', $file or die "Can't open $file $!";
while (my $line = <$fr>)
{
  chomp $line;
  $line =~ s///g;

  my @a = split /,/, $line;
  my $pos = $a[1];
  next unless $pos == $POS_SELECT;

  my $src = $a[0];
  my $vul = $a[2];
  my $open = $a[3];
  my $dist = $a[4];
  my $suit1 = $a[5];
  my $suit2 = $a[6];
  my $suit3 = $a[7];
  my $suit4 = $a[8];
  my $bid = $a[9];

  my $strength = $DIST_VALUES[$dist] +
    $SUIT_VALUES[$suit1] +
    $SUIT_VALUES[$suit2] +
    $SUIT_VALUES[$suit3] +
    $SUIT_VALUES[$suit4];

  my $prob_one = calc_sigmoid($vul, $strength);

    # printf("%6.4f %-10s %-4s %s, %s, %s, %s  %6.2f %-4s\n",
      # $prob_one, 
      # $src, 
      # $VULS[$vul],
      # $SUIT_NAMES[$suit1],
      # $SUIT_NAMES[$suit2],
      # $SUIT_NAMES[$suit3],
      # $SUIT_NAMES[$suit4],
      # $strength,
      # $bid);

  my $flag = 0;
  my $text = "";

  if ($prob_one > 0.90 && $open == 0)
  {
    $flag = 1;
    $text = "ODDPASS";
  }
  elsif ($prob_one > 0.50 && $open == 2)
  {
    $flag = 1;
    $text = "ODDPRE";
  }
  elsif ($prob_one < 0.10 && ($open == 1 || $bid =~ /^1/))
  {
    $flag = 1;
    $text = "ODDONE";
  }

  if ($flag)
  {
    $src =~ /^(\d+)-([oc])(\d+)/;
    my ($lin, $room, $board) = ($1, $2, $3);

    my $n1 = -1;
    my $n2 = -1;

    if ($board % 2)
    {
      # Odd board numbers have N-S as dealers.
      if ($room eq 'o')
      {
        if ($POS_SELECT == 0 || $POS_SELECT == 2)
        {
          $n1 = 0;
          $n2 = 2;
        }
        else
        {
          $n1 = 1;
          $n2 = 3;
        }
      }
      else
      {
        if ($POS_SELECT == 0 || $POS_SELECT == 2)
        {
          $n1 = 4;
          $n2 = 6;
        }
        else
        {
          $n1 = 5;
          $n2 = 7;
        }
      }
    }
    else
    {
      # Even board numbers have E-W as dealers.
      if ($room eq 'o')
      {
        if ($POS_SELECT == 0 || $POS_SELECT == 2)
        {
          $n1 = 1;
          $n2 = 3;
        }
        else
        {
          $n1 = 0;
          $n2 = 2;
        }
      }
      else
      {
        if ($POS_SELECT == 0 || $POS_SELECT == 2)
        {
          $n1 = 5;
          $n2 = 7;
        }
        else
        {
          $n1 = 4;
          $n2 = 6;
        }
      }
    }

    if (! defined $PLAYERS[$lin])
    {
      print "Missing $lin\n";
    }

    my @players = split /,/, $PLAYERS[$lin];

    my ($p1, $p2);
    if ($#players >= $n2)
    {
      $p1 = $players[$n1];
      $p2 = $players[$n2];
    }
    elsif ($#players >= $n1)
    {
      $p1 = $players[$n1];
      $p2 = "Unknown";
    }
    else
    {
      $p1 = "Unknown";
      $p2 = "Unknown";
    }

    if ($p1 eq 'North' || $p1 eq 'East' ||
        $p1 eq 'South' || $p1 eq 'West' ||
        $p1 eq '' ||
        $p1 eq 'Multiple')
    {
      $p1 = "Unknown";
    }

    if ($p2 eq 'North' || $p2 eq 'East' ||
        $p2 eq 'South' || $p2 eq 'West' ||
        $p2 eq '' ||
        $p2 eq 'Multiple')
    {
      $p2 = "Unknown";
    }

    my $hcp_sum = hcp($a[5]) + hcp($a[6]) + hcp($a[7]) + hcp($a[8]);


    printf("%-8s %6.4f %-10s %-4s %s, %s, %s, %s  %6.2f %4d %-4s %s\n",
      $text,
      $prob_one, 
      $src, 
      $VULS[$vul],
      $SUIT_NAMES[$suit1],
      $SUIT_NAMES[$suit2],
      $SUIT_NAMES[$suit3],
      $SUIT_NAMES[$suit4],
      $strength,
      $hcp_sum,
      $bid,
      "$p1 - $p2");
  }
}
close $fr;


sub read_suit_names
{
  my $fname = pop;
  open my $fs, '<', $fname or die "Can't open $fname $!";
  while (my $line = <$fs>)
  {
    chomp $line;
    $line =~ s///g;
  
    my @a = split /\s+/, $line;
    my $sno = $a[1];
    my $sname = $a[2];
    $SUIT_NAMES[$sno] = $sname;
    $SUIT_VALUES[$sno] = $a[3];
  }
  close $fs;

  $SUIT_NAMES[0] = '';
}


sub read_dist_names
{
  my $fname = pop;
  open my $fd, '<', $fname or die "Can't open $fname $!";
  while (my $line = <$fd>)
  {
    chomp $line;
    $line =~ s///g;
  
    my @a = split /\s+/, $line;
    my $dno = $a[1];
    my $dname = $a[2];
    $DIST_NAMES[$dno] = $dname;
    $DIST_VALUES[$dno] = $a[3];
  }
  close $fd;
}


sub read_sigmoids
{
  my $fname = pop;
  open my $fs, '<', $fname or die "Can't open $fname $!";
  my $line = <$fs>; # Header
  while (my $line = <$fs>)
  {
    chomp $line;
    $line =~ s///g;
  
    my @a = split /\s+/, $line;
    my $pos = $a[1];
    my $vul = $a[2];
    my $mean = $a[3];
    my $sigma = $a[4];

    if ($pos == $POS_SELECT)
    {
      $SIGMOIDS[$vul][0] = $mean;
      $SIGMOIDS[$vul][1] = $sigma;
    }
  }
  close $fs;
}


sub read_linskips
{
  my $fname = pop;
  open my $fl, '<', $fname or return; # File doesn't have to exist

  while (my $line = <$fl>)
  {
    chomp $line;
    $line =~ s///g;
    next if ($line =~ /^#/);
    next if ($line =~ /^\s*$/);
    
    $LINSKIPS[$line] = 1;
  }
  close $fl;
}


sub read_players
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


sub calc_sigmoid
{
  my ($vul, $strength) = @_;
  return 1. / (1. + exp(-($strength - $SIGMOIDS[$vul][0]) /
    $SIGMOIDS[$vul][1]));
}

sub hcp
{
  my $sno = pop;
  my $sname = $SUIT_NAMES[$sno];
  my $p = 0;
  $p += 4 if $sname =~ /A/;
  $p += 3 if $sname =~ /K/;
  $p += 2 if $sname =~ /Q/;
  $p += 1 if $sname =~ /J/;
  return $p;
}

