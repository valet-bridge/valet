#!perl

use strict;
use warnings;
use v5.10;

# Useful for downloading Merlin files in alternative URL format.

use File::Fetch;

my $prefix = 'http://www.german-bridge-trophy.de/turnierergebnisse/showboardsteam.php?';
my $sprefix = 'trophy2019';

my $fetch = 'showboardsteam.php';

my$base = 11148;
for my $k (11153 .. 11160)
{
  for my $d (5 .. 7)
  {
    for my $bd (1 .. 8)
    {
      my $ext = "Klasse=$k&Durch=$d&Bdnr=$bd&Paar=0";
      my $ext2 = "k" . ($k-$base) . "_d" . $d . "_bd_" . $bd . ".html";
      my $name = $prefix . $ext;
      say $name;

      my $ff = File::Fetch->new(uri => $name); 
      my $where = $ff->fetch(to => $sprefix) or die $ff->error;

      rename "$sprefix/$fetch", "$sprefix/$ext2";
    }
  }
}

