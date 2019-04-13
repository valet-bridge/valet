#!perl

use strict;
use warnings;
use v5.10;

# Useful for downloading Merlin files.

use File::Fetch;

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp493/';
# my $dprefix = '09_01_10_liga_bdz_';
# my $sprefix = 'liga2009';

# The earlier years only had 1+2+2 leagues (3 in total).
# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp881/';
# my $dprefix = '10_01_09_liga_bdz_';
# my $sprefix = 'liga2010';

# Missing 4-8-2nd half and 5-8-2nd half!
# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp1527/';
# my $dprefix = '11_01_15_team_bdz_';
# my $sprefix = 'liga2011';

# Missing 3-2-21!
# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp2327/';
# my $dprefix = '12_01_14_tur_bdz_';
# my $sprefix = 'liga2012';

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp2616/';
# my $dprefix = '13_01_19_liga_bdz_';
# my $sprefix = 'liga2013';

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp3203/';
# my $dprefix = '15_01_24_liga_bdz_';
# my $sprefix = 'liga2015';

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp3522/';
# my $dprefix = '16_01_23_team_bdz_';
# my $sprefix = 'liga2016';

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp3758/';
# my $dprefix = '17_01_28_team_bdz_';
# my $sprefix = 'liga2017';

my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp4001/';
my $dprefix = '18_01_20_team_bdz_';
my $sprefix = 'liga2018';

# my $prefix = 'http://www.bridge-verband.de/images/uploads/ftp4308/';
# my $dprefix = '19_01_19_team_bdz_';
# my $sprefix = 'liga2019';

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

