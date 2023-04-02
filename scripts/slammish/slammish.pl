#!perl

use strict;
use warnings;

# perl slammish.pl tableau.txt ../../data/2016-Euro/Men/hands
# Generates a pruned tableau file and two hand files for 
# bidding exercises.

my $tabfile = shift;
my $handdir = shift;

open my $ft, "<$tabfile" or die "Can't open $tabfile: $!";

my ($round, $board, $slammish);

my $cumall = 0.;
my $cumallsq = 0.;
my $numall = 0.;
my $cumslammish = 0.;
my $cumslammishsq = 0.;
my $numslammish = 0.;

# Make a list of slammish (board, round) pairs.

my @slammish_list;

while (my $line = <$ft>)
{
  chomp $line;

  next unless $line =~ /^BOARD (\d+)\|(\d+)\s*$/;
  $round = $1;
  $board = $2;

  # Skip one line
  $line = <$ft>;
  $line = <$ft>;

  $slammish = ($line =~ /^Slammish\s*$/);

  if ($slammish)
  {
    # Skip three lines.
    $line = <$ft>;
    $line = <$ft>;
    $line = <$ft>;
    $line = <$ft>;

    my @ns = split /\s+/, $line;
    die "Not a NS line" unless ($#ns == 5 && $ns[0] eq 'NS');

    my $nscount = 0;
    for my $n (1 .. 5)
    {
      $nscount += $ns[$n] if ($ns[$n] ne '-');
    }

    $line = <$ft>;

    my @ew = split /\s+/, $line;
    die "Not an EW line" unless ($#ew == 5 && $ew[0] eq 'EW');

    my $ewcount = 0;
    for my $n (1 .. 5)
    {
      $ewcount += $ew[$n] if ($ew[$n] ne '-');
    }

    if ($ewcount > $nscount)
    {
      # Kludge: Store EW boards as negative board numbers.
      $board = -$board;
    }

    push @{$slammish_list[$round]}, $board;
  }

  my $num = 0;
  my $sum = 0;
  my $sumsq = 0;

  while ($line = <$ft>)
  {
    if ($line =~ /^DECLARER/)
    {
      # Skip table header
      $line = <$ft>;
      while ($line = <$ft>)
      {
        chomp $line;
        last if ($line =~ /^\s*$/);

        my @a = split /\s+/, $line;
        my $n = $#a;
        my $count = $a[$n-3];
        my $value = $a[$n-1]; # The bidding score

        $num += $count;
        $sum += $count * abs($value);
        $sumsq += $count * $value * $value;
      }
    }
    elsif ($line =~ /^DEFENDER/)
    {
      # printf "%3d %3d: %8.2f %8.2f %4s\n",
        # $round, $board, $sum / $num, sqrt($sumsq) / $num, $slammish;

      $cumall += $sum / $num;
      $cumallsq += sqrt($sumsq / $num);
      $numall++;

      if ($slammish)
      {
        $cumslammish += $sum / $num;
        $cumslammishsq += sqrt($sumsq / $num);
        $numslammish++;
      }

      last;
    }
  }
}

close $ft;

# print "\n\n";
printf("%7s: %8.2f %8.2f %8.2f avg\n",
  "All", $cumall / $numall, $cumallsq / $numall, $cumallsq);
printf("%7s: %8.2f %8.2f %8.2f avg\n\n",
  "Slam", $cumslammish / $numslammish, $cumslammishsq / $numslammish,
    $cumslammishsq);

printf("Percentage of hands %8.2f\n", 100. * $numslammish / $numall);
printf("Percentage of sum   %8.2f\n", 100. * $cumslammish / $cumall);
printf("Percentage of sumsq %8.2f\n\n", 100. * $cumslammishsq / $cumallsq);

# Read the slammish PBN hands and make exercise lists.

my $NE_file = "player1.txt";
my $SW_file = "player2.txt";

open my $f1, ">$NE_file" or die "Can't open $NE_file: $!";
open my $f2, ">$SW_file" or die "Can't open $SW_file: $!";

for $round (0 .. $#slammish_list)
{
  next if $#{$slammish_list[$round]} == -1;

  my $file = "$handdir/hands/round$round.pbn";
  open my $fh, "<$file" or die "Cannot open $file: $!";

  while (my $line = <$fh>)
  {
    chomp $line;
    next unless $line =~ /^\[Board "(\d+)"\]/;
    $board = $1;

    $line = <$fh>;
    die unless $line =~ /^\[Dealer "(.)"\]/;
    my $dealer = $1;

    $line = <$fh>;
    die unless $line =~ /^\[Vulnerable "(.*)"\]/;
    my $vul = $1;

    $line = <$fh>;
    die unless $line =~ /^\[Deal "(.*)"\]/;
    my $deal = $1;

    my $found = 0;
    my $ew_flag = 0;
    for my $n (@{$slammish_list[$round]})
    {
      if ($n == $board)
      {
        $found = 1;
        last;
      }
      if ($n == -$board)
      {
        $found = 1;
        $ew_flag = 1;
        last;
      }
    }

    next unless $found;

    my @a = split /\s+/, $deal;
    die "Doesn't look like my own PBN" unless $a[0] =~ /^N:/;
    $a[0] = substr $a[0], 2;

    printf $f1 "Round  %d\n", $round;
    printf $f1 "Board  %d\n", $board;
    printf $f1 "Dealer %s\n", $dealer;
    printf $f1 "Vul    %s\n\n", $vul;

    if ($ew_flag)
    {
      print $f1 prettyhand("East", $a[1]);
    }
    else
    {
      print $f1 prettyhand("North", $a[0]);
    }
    print $f1 "----------\n\n";

    printf $f2 "Round  %d\n", $round;
    printf $f2 "Board  %d\n", abs($board);
    printf $f2 "Dealer %s\n", $dealer;
    printf $f2 "Vul    %s\n\n", $vul;

    if ($ew_flag)
    {
      print $f2 prettyhand("West", $a[3]);
    }
    else
    {
      print $f2 prettyhand("South", $a[2]);
    }
    print $f2 "----------\n\n";
  }

  close $fh;
}


close $NE_file;
close $SW_file;


sub prettyhand
{
  my ($player, $text) = @_;

  my $s = "$player\n\n";

  my @a = split /\./, $text, -4;
  die "Not a hand: $text" unless $#a == 3;

  $s .= 
    $a[0] . "\n" .
    $a[1] . "\n" .
    $a[2] . "\n" .
    $a[3] . "\n\n";

  return $s;
}
