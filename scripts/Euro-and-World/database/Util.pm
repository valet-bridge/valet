#!perl

package Util;

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(reverse_name);

sub reverse_name
{
  my @a = split /\s+/, pop;
  my $i = 0;
  my $flag = 0;
  my $index;

  # The last word may be of the form (n), which stays at the end.
  my $last_real = ($a[-1] =~ /^\(\d\)$/ ? -1 + $#a : $#a);

  for $i (0 .. $last_real)
  {
    # Find the first (real) upper-case word
    my $n = $a[$i];
    my $l = length $n;
    if ($n eq uc($n) && 
        $n ne '-' &&
        ($l >= 3 || ($l == 2 && substr($n, 1, 1) ne '.')))

    {
      $flag = 1;
      $index = $i;
      last;
    }
  }
    
  $index = $last_real if ! $flag;

  my $reversed_name = $a[$index];
  for my $j ($index+1 .. $last_real)
  {
    $reversed_name .= " " . $a[$j];
  }

  for my $j (0 .. $index-1)
  {
    $reversed_name .= " " . $a[$j];
  }

  if ($last_real != $#a)
  {
    $reversed_name .= ' ' . $a[-1];
  }

  return $reversed_name;
}

1;
