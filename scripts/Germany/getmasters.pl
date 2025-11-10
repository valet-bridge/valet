#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

# Doesn't work

my $prefix = 'https://ergebnisse.bridge-verband.de/index.php?turid=46110&site=3&kl=0&';
my $sprefix = 'masters2025';

my $fetch = 'showboardsteam.php';

for my $d (0 .. 3)
{
  for my $bd (1 .. 24)
  {
    my $ext = "durch=$d&arg=$bd";
    my $ext2 = "d" . $d . "_bd_" . $bd . ".html";
    my $name = $prefix . $ext;
    say $name;

    my $ff = File::Fetch->new(uri => $name); 
    my $where = $ff->fetch(to => $sprefix);
    if (! $where)
    {
      die $ff->error;
    }

    my $fn = $ff->file;
    rename "$sprefix/$fn", "$sprefix/$ext2";
  }
}

