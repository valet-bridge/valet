#!perl

use strict;
use warnings;
use v5.10;

# Useful for downloading Merlin files.

use File::Fetch;

# 2019 Bundesliga
my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp4308/';
my $dprefix = '19_01_19_team_bdz_';
my $sprefix = 'liga2019';

my $fetch = 'vugraph_linfetch.php';

for my $k (1 .. 5)
{
  for my $d (1 .. 9)
  {
    for my $bd (1 .. 32)
    {
      my $ext = "k${k}_d${d}_bd_${bd}.html";
      my $download = $dprefix . $ext;
      my $name = $prefix . $download;
      say $name;

      my $ff = File::Fetch->new(uri => $name); 
      my $where = $ff->fetch(to => $sprefix) or die $ff->error;

      rename "$sprefix/$download", "$sprefix/$ext";
    }
  }
}

