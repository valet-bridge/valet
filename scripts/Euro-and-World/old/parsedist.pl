#!perl

use strict;
use warnings;
use v5.10;

# Reads a directory of raw html files and extracts the hands in 
# something like PBN.

use File::Fetch;

# perl parsedist.pl 1 2005-World/Open/Hands

# Round to select for output.
my $ROUND = shift;

# 0-based, so the first entry is table 16.
my @VUL = qw(
                 EW 
  None NS   EW   Both 
  NS   EW   Both None 
  EW   Both None NS 
  Both None NS);

my @DEALER = qw(
                 W
  N    E    S    W
  N    E    S    W
  N    E    S    W
  N    E    S);

my $dirname = shift;
opendir my $dir, $dirname or die "Cannot open directory $dirname: $!";
my @files = readdir $dir;
closedir $dir;

for my $file (@files)
{ 
  next if $file =~ /^\.\.?$/;

  $file =~ /(\d+)\.(\d+)/;
  my $board = $1;
  my $round = $2;
  $board =~ s/^0+//;
  $round =~ s/^0+//;
  next unless $round == $ROUND;

  my $fullfile = "$dirname/$file";

  open my $fh, "<$fullfile" or die "Can't open file $fullfile: $!";
  # say "File $fullfile";

  my $line;
  my @hand;
  my $counter = 0;

  while ($line = <$fh>)
  {
    $line =~ s///g;
    chomp $line;

    if ($line =~ /spades/ ||
        $line =~ /hearts/ ||
        $line =~ /diamonds/ ||
        $line =~ /clubs/)
    {
      my $cumul = $line;
      while (($line = <$fh>) !~ /\<\/td\>/)
      {
        $line =~ s///g;
        chomp $line;

        $cumul .= $line;
      }

      $cumul =~ s/\<[^>]*\>//g;
      $cumul =~ s/\s+/ /g;
      $cumul =~ s/\&[^;]*;/|/g;
      $cumul =~ s/\s//g;
      my @a = split(/\|/, $cumul);
      die $cumul unless $#a == 4;

      $a[1] = "" if $a[1] eq "-";
      $a[2] = "" if $a[2] eq "-";
      $a[3] = "" if $a[3] eq "-";
      $a[4] = "" if $a[4] eq "-";

      $hand[$counter][0] = $a[1]; # North
      $hand[$counter][1] = $a[2]; # West
      $hand[$counter][2] = $a[3]; # East
      $hand[$counter][3] = $a[4]; # South
      $counter++;
      last if ($counter == 4);
    }
  }

  # Regular
  # print "$round $board \"N:",
    # join('.', @{$hand[0]}), " ",
    # join('.', @{$hand[1]}), " ",
    # join('.', @{$hand[2]}), " ",
    # join('.', @{$hand[3]}), "\"\n";

  # PBN-like
  # print "XXX $round\n";
  print "[Board \"$board\"]\n";
  print "[Dealer \"", $DEALER[$board % 16], "\"]\n";
  print "[Vulnerable \"", $VUL[$board % 16], "\"]\n";
  print "[Deal \"N:",
    join('.', @{$hand[0]}), " ", # North
    join('.', @{$hand[2]}), " ", # East
    join('.', @{$hand[3]}), " ", # South
    join('.', @{$hand[1]}), "\"]\n\n"; # West

  close $fh;
}

