#!perl

use strict;
use warnings;
use v5.10;

for my $fname (@ARGV)
{
  open my $fh, "<$fname" or die "Can't open $fname";

  my $prevnames = "";
  my @cumul;
  reset_cumul(\@cumul);

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    $line =~ s///g;

    $line =~ /^([^;]+)/;
    my $names = $1;

    my @fields = split ';', $line;
    if ($#fields == 11)
    {
      $fields[13] = $fields[11];
      $fields[11] = 0.;
      $fields[12] = 0.;
    }
    elsif ($#fields != 13)
    {
      die "Odd field length in line .$line.";
    }

    if ($names ne $prevnames)
    {
      if ($prevnames ne "")
      {
        print_line($prevnames, \@cumul);
	reset_cumul(\@cumul);
      }
      $prevnames = $names;
    }

    for my $i (1 .. 6)
    {
      $cumul[$i] += $fields[$i];
    }

    for my $i (7 .. 13)
    {
      $fields[$i] =~ s/,/./;
      $cumul[$i] += $fields[1] * $fields[$i];
    }
  }
  print_line($prevnames, \@cumul);
  close $fh;
}

exit;


sub print_line
{
  my($names, $cref) = @_;

  for my $i (7 .. 13)
  {
    $cref->[$i] /= $cref->[1];
  }

  my $out = $names;
  for my $i (1 .. 6)
  {
    $out .= ";" . $cref->[$i];
  }
  for my $i (7 .. 13)
  {
    $out .= sprintf(";%.2f", $cref->[$i]);
  }
  $out =~ s/\./,/g;

  print $out . "\n";
}


sub reset_cumul
{
  my ($cref) = @_;
  $cref->[0] = "";
  for my $i (1 .. 13)
  {
    $cref->[$i] = 0.;
  }
}
