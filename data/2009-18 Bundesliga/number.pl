#!perl

use strict;
use warnings;
use v5.10;

my $no = 1;

while (my $line = <>)
{
  chomp $line;
  say "$no|$line";
  $no++;
}

