#!perl

use strict;
use warnings;
use v5.10;

# Count the number of players for each tournament index in the WBF files.
# Also count the number for the EBL results.  The purpose is to identify
# files (teams, women, open) that have been mis-classified, or where
# there are otherwise large discrepancies.

die "perl count.pl" unless $#ARGV == -1;

my $teams_file = 'wteams.txt';
my $pairs_file = 'wpairs.txt';
my $indiv_file = 'windiv.txt';

my @files;
$files[0] = $teams_file;
$files[1] = $pairs_file;
$files[2] = $indiv_file;

my $ebl_file =  '../3_highs/ebl.txt';

open my $fe, '<', $ebl_file or die "Cannot read $ebl_file: $!";

my @ebl_counts;

while (my $line = <$fe>)
{
  chomp $line;

  next unless $line =~/^TOURNAMENT (\d+)/;
  $ebl_counts[$1]++;
}

close $fe;

my @wbf_counts;

for my $fno (0 .. 2)
{
  open my $fw, '<', $files[$fno] or die "Cannot read $files[$fno]: $!";

  my $id;
  my $title_just_seen = 0;

  while (my $line = <$fw>)
  {
    chomp $line;

    if ($title_just_seen && $line =~ /^ID (\d+)/)
    {
      $id = $1;
    }
    elsif ($line =~ /^PLAYER/)
    {
      $wbf_counts[$id]++;
    }

    if ($line =~ /^TITLE/)
    {
      $title_just_seen = 1;
    }
    else
    {
      $title_just_seen = 0;
    }
  }

  close $fw;
}

for my $wno (1 .. $#wbf_counts)
{
  if (! defined $wbf_counts[$wno])
  {
    if (defined $ebl_counts[$wno])
    {
      print "$wno\n";
      # printf("%6d %6s %6d\n",
        # $wno, '-', $ebl_counts[$wno]);
    }
  }
  # elsif (defined $ebl_counts[$wno])
  # {
    # printf("%6d %6d %6d\n",
      # $wno, $wbf_counts[$wno], $ebl_counts[$wno]);
  # }
  # else
  # {
    # printf("%6d %6d %6s\n",
      # $wno, $wbf_counts[$wno], '-');
  # }
}
