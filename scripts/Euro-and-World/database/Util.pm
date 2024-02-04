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
  for $i (0 .. $#a)
  {
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
    
  $index = $#a if ! $flag;

  my $reversed_name = $a[$index];
  for my $j ($index+1 .. $#a)
  {
    $reversed_name .= " " . $a[$j];
  }

  for my $j (0 .. $index-1)
  {
    $reversed_name .= " " . $a[$j];
  }

  return $reversed_name;
}

1;
