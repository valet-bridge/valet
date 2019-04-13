#!perl

use strict;
use warnings;
use v5.10;

# Detect cases where a pair is down at least 2.

my %data;
my (@names, %numbers);
for my $dir (@ARGV)
{
  read_names("$dir/names.txt");

  for my $fname (glob("$dir/scores*.txt"))
  {
    next if $fname =~ /scores\./;

    $fname =~ /scores(\d+)\./;
    my $k = $1;
    my $league = get_league($dir, $k);
    
    open my $fh, "<$fname" or die "Can't open $fname";
    my $line;
    while ($line = <$fh>)
    {
      chomp $line;
      my @a = split /\|/, $line;

      next if ($a[6] eq 'P');

      my $target = 6 + substr $a[6], 0, 1;
      my $actual = $a[8];

      my $decl = $a[7];
      my ($p1, $p2);
      if ($decl eq 'N' || $decl eq 'S')
      {
        $p1 = $names[$a[2]];
        $p2 = $names[$a[4]];
      }
      else
      {
        $p1 = $names[$a[3]];
        $p2 = $names[$a[5]];
      }

      my $pair;
      if ($p1 lt $p2)
      {
        $pair = $p1 . " - " . $p2;
      }
      else
      {
        $pair = $p2 . " - " . $p1;
      }

      $data{$pair}[0]++;
      if ( $actual <= $target-2 && $a[6] !~ /X/)
      {
        $data{$pair}[1]++;
      }
    }
    close $fh;
  }
}

for my $pair (sort keys %data)
{
  print "$pair;" . (defined $data{$pair}[1] ? $data{$pair}[1] : 0) . ";$data{$pair}[0]\n";
}

exit;



sub read_names
{
  my ($name) = @_;
  open my $fh, "<$name" or die "Can't open $name";
  my @lines = <$fh>;
  close $fh;

  undef %numbers;
  undef @names;

  for my $i (0 .. $#lines)
  {
    my $line = $lines[$i];
    chomp $line;
    $line =~ s/^M//g;
    my @elems = split /\|/, $line;
    $numbers{$elems[1]} = $elems[0];
    $names[$elems[0]] = $elems[1];
  }
}


sub get_league
{
  my ($dir, $k) = @_;
  my $league;
  if ($dir =~ /2010/)
  {
    if ($k == 1)
    {
      $league = "1";
    }
    elsif ($k == 2)
    {
      $league = "2a";
    }
    else
    {
      $league = "2b";
    }
  }
  else
  {
    if ($k == 1)
    {
      $league = "1";
    }
    elsif ($k == 2)
    {
      $league = "2";
    }
    else
    {
      $league = "3";
      if ($k == 3)
      {
        $league .= "a";
      }
      else
      {
        $league .= ($k == 4 ? "b" : "c");
      }
    }
  }
  return $league;
}
