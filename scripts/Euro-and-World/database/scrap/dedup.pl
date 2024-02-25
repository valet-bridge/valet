#!perl

use strict;
use warnings;
use v5.10;

# There are high, duplicated tournament numbers > = 10,000.
# Renumber these and make a correspondence table.
# The ebl.txt file still needs to be renumbered!

die "perl dedup.pl" unless $#ARGV == -1;

my $tourn_file = 'uniques.txt';

my $renumbered_file = 'renumbered2.txt';
my $dedup_file = 'dedup2.txt';

open my $ft, '<', $tourn_file or 
  die "Cannot open $tourn_file for reading: $!";

open my $fr, '>', $renumbered_file or 
  die "Cannot open $renumbered_file for writing: $!";

open my $fd, '>', $dedup_file or 
  die "Cannot open $dedup_file for writing: $!";

my %high_by_name;

while (my $line = <$ft>)
{
  chomp $line;

  next if $line =~ /^\s*$/ || $line =~ /^#/;
  
  if ($line !~ /^TOURNAMENT (.*)$/)
  {
    die "Not a tournament line: $line";
  }

  my @a = split /\|/, $1;

  if ($a[0] < 10000)
  {
    print $fr "$line\n";
    next;
  }

  my ($tno, $year, $place, $name) = ($a[0], $a[1], $a[2], $a[3]);

  if (defined $high_by_name{$name})
  {
    if ($high_by_name{$name}{year} ne $year)
    {
      die "$line: Year mismatch $year vs $high_by_name{$name}{year}";
    }

    if ($high_by_name{$name}{place} ne $place)
    {
      die "$line: Place mismatch $place vs $high_by_name{$name}{place}";
    }

    # print "$tno is a duplicate of ", $high_By_name{$name}{no}, "\n";
  }

  push @{$high_by_name{$name}{no}}, $tno;
  $high_by_name{$name}{year} = $year;
  $high_by_name{$name}{place} = $place;
}

close $ft;

my $running = 10000;
for my $name (sort keys %high_by_name)
{
  for my $no (sort @{$high_by_name{$name}{no}})
  {
    print $fd "$no $running\n";
  }

  print $fr "TOURNAMENT ",
    $running, '|',
    $high_by_name{$name}{year}, '|',
    $high_by_name{$name}{place}, '|',
    $name,
    "\n";

  $running++;
}

close $fr;
close $fd;

exit;

