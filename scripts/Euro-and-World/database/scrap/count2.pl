#!perl

use strict;
use warnings;
use v5.10;

# Based on the count.pl script in 4_, but we also look for the 
# specific IDs of players.
# Count the number of players for each tournament index in the WBF files.
# Also count the number for the EBL results.

die "perl count.pl" unless $#ARGV == -1;

my $tourn_file = 'combined.txt';
my $names_file = 'ebl.txt';

open my $fn, '<', $names_file or die "Cannot read $names_file $!";

my @players_from_names;
my @players_from_tourn;

my ($name, $id);
my $lno = 0;

while (my $line = <$fn>)
{
  chomp $line;
  $lno++;

  if ($line =~ /^NAME (.*)/)
  {
    $name = $1;
  }
  elsif ($line =~ /^EBL (\d+)/)
  {
    $id = $1;
  }
  elsif ($line =~ /^TOURNAMENT (\d+)/)
  {
    my $tid = $1;
    push @{$players_from_names[$tid]}, [ $name, $id, $lno ];
  }
}

close $fn;

$lno = 0;
my @buffer;

open my $ft, '<', $tourn_file or die "Cannot read $tourn_file: $!";

my $title_just_seen = 0;

while (my $line = <$ft>)
{
  chomp $line;
  $lno++;

  if ($title_just_seen && $line =~ /^ID (\d+)/)
  {
    $id = $1;
  }
  elsif ($line =~ /^PLAYER (.*)/)
  {
    $buffer[0]{player} = $1;
  }
  elsif ($line =~ /^PLAYER(\d) (.*)/)
  {
    $buffer[$1]{player} = $2;
  }
  elsif ($line =~ /^ID (.*)/)
  {
    $buffer[0]{id} = $1;
  }
  elsif ($line =~ /^ID(\d) (.*)/)
  {
    $buffer[$1]{id} = $2;
  }
  elsif ($line =~ /^\s*$/)
  {
    for my $b (0 .. $#buffer)
    {
      next unless defined $buffer[$b];
      push @{$players_from_tourn[$id]}, 
        [ $buffer[$b]{name}, $buffer[$b]{id} ];
    }
  }
  
  if ($line =~ /^TITLE/)
  {
    $title_just_seen = 1;
    @buffer = ();
  }
  else
  {
    $title_just_seen = 0;
  }
}

close $ft;


for my $n (0 .. $#players_from_names)
{
  next unless defined $players_from_names[$n];
  if (! defined $players_from_tourn[$n])
  {
    print "Tournament $n is in names but not in combined\n";
  }
}

for my $n (0 .. $#players_from_tourn)
{
  next unless defined $players_from_tourn[$n];
  if (! defined $players_from_names[$n])
  {
    print "Tournament $n is in combined but not in names\n";
  }
}

my $count_only_names = 0;
my $count_only_tourn = 0;
my $count_overlap = 0;

for my $n (0 .. $#players_from_names)
{
  next unless defined $players_from_names[$n];
  next unless defined $players_from_tourn[$n];

  my (@only_names, @only_tourn, @overlap);

  partition(\@{$players_from_names[$n]},
    \@{$players_from_tourn[$n]},
    \@only_names, \@only_tourn, \@overlap);

  printf("%6d %6d %6d   %6d %6d %6d\n",
    $n,
    1 + $#{$players_from_names[$n]},
    1 + $#{$players_from_tourn[$n]},
    1 + $#only_names,
    1 + $#only_tourn,
    1 + $#overlap
    );

  $count_only_names += 1 + $#only_names;
  $count_only_tourn += 1 + $#only_tourn;
  $count_overlap += 1 + $#overlap;

  # print "\n";
  # print "Tournament number: $n\n\n";
  # if ($#only_names >= 0)
  # {
    # print "Only names:\n\n";
    # for my $m (@only_names)
    # {
      # print "  $m\n",
    # }
    # print "\n";
  # }

  # if ($#only_tourn >= 0)
  # {
    # print "Only tourn\n\n";
    # for my $m (@only_tourn)
    # {
      # print "  $m\n",
    # }
    # print "\n";
  # }

  # last if $n >= 50;
}

print "Count only names: ", $count_only_names, "\n";
print "Count only tourn: ", $count_only_tourn, "\n";
print "Count overlap   : ", $count_overlap, "\n";


sub partition
{
  my ($names_ref, $tourn_ref, $only_names_ref, $only_tourn_ref,
    $overlap_ref) = @_;

  my @scratch;
  for my $n (@$names_ref)
  {
    $scratch[$n->[1]] = 1;
  }

  for my $n (@$tourn_ref)
  {
    if (defined $scratch[$n->[1]])
    {
      $scratch[$n->[1]] = 3;
    }
    else
    {
      $scratch[$n->[1]] = 2;
    }
  }

  for my $s (0 .. $#scratch)
  {
    next unless defined $scratch[$s];
    if ($scratch[$s] == 1)
    {
      push @$only_names_ref, $s;
    }
    elsif ($scratch[$s] == 2)
    {
      push @$only_tourn_ref, $s;
    }
    else
    {
      push @$overlap_ref, $s;
    }
  }
}

