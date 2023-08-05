#!perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';

# Parse two outputs from cluster.py for the board information.
# Calculate statistics on the change (hopefully improvement) in
# the estimation accuracy of the passing frequency.  So the first
# input file may be before a passing table for a specific 
# distribution is included, and the second input file may be after.

if ($#ARGV != 1)
{
  print "Usage: perl delta.pl file1 file2\n";
  exit;
}

my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

my (%store1, %store2);

read_board_file($file1, \%store1);
read_board_file($file2, \%store2);

my %stats;
calc_stats(\%store1, \%store2, \%stats);

printf("%-20s%6d\n", "Number better", $stats{nbetter});
printf("%-20s%6d\n", "Number worse", $stats{nworse});
print "\n";
printf("%-20s%6d\n", "Avg diff before", $stats{avgdiff1});
printf("%-20s%6d\n", "Avg diff after", $stats{avgdiff2});
print "\n";
printf("%-20s%6d\n", "Avg sumsq before", $stats{avgsumsq1});
printf("%-20s%6d\n", "Avg sumsq after", $stats{avgsumsq2});


sub read_board_file
{
  my ($fname, $store_ref) = @_;
  open my $fr, '<', $fname or die "Can't open $fname: $!";

  while (my $line = <$fr>)
  {
    chomp $line;
    $line =~ s///g;

    if ($line =~ /^BOARD/)
    {
      $line =~ /^BOARD\s+(.+)$/;
      my $tag = $1;
      push @{$store_ref->{$tag}{text}}, $line;

      while ($line = <$fr>)
      {
        chomp $line;
        $line =~ s///g;
        if ($line =~ /^actual\s+(.+)/)
        {
          my $actual = $1;
          $store_ref->{$tag}{actual} = $actual;
        }
        elsif ($line =~ /^predicted\s+(.+)/)
        {
          my $pred = $1;
          $store_ref->{$tag}{pred} = $pred;
          last;
        }
        else
        {
          push @{$store_ref->{$tag}{text}}, $line;
        }
      }
    }
  }
}


sub calc_stats
{
  my ($store1_ref, $store2_ref, $stats_ref) = @_;

  my $ndiff = 0;

  for my $key (sort keys %{$store1_ref})
  {
    die unless defined $store2_ref->{$key};

    my $act1 = $store1_ref->{$key}{actual};
    my $act2 = $store2_ref->{$key}{actual};
    my $pred1 = $store1_ref->{$key}{pred};
    my $pred2 = $store2_ref->{$key}{pred};

    next if ($act1 eq $act2 && $pred1 eq $pred2);

    $ndiff++;

    my $olddiff = $pred1 - $act1;
    my $oldabsdiff = abs($olddiff);

    my $newdiff = $pred2 - $act2;
    my $newabsdiff = abs($newdiff);

    if ($newabsdiff < $oldabsdiff)
    {
      $stats_ref->{nbetter}++;
    }
    else
    {
      $stats_ref->{nworse}++;
    }

    $stats_ref->{avgdiff1} += $olddiff;
    $stats_ref->{avgdiff2} += $newdiff;

    $stats_ref->{avgsumsq1} += $olddiff * $olddiff;
    $stats_ref->{avgsumsq2} += $newdiff * $newdiff;
  }

  if ($ndiff == 0)
  {
    die "No differences";
  }

  $stats_ref->{avgdiff1} /= $ndiff;
  $stats_ref->{avgdiff2} /= $ndiff;
  $stats_ref->{avgsumsq1} /= $ndiff;
  $stats_ref->{avgsumsq1} /= $ndiff;

  # Check that the two stores have the same keys.
  for my $key (sort keys %{$store2_ref})
  {
    die unless defined $store1_ref->{$key};
  }
}

