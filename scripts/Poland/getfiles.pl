#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

# 2011/12
my $prefix = 'http://www.pzbs.pl/wyniki/liga/liga2011-12/ekstraklasa/rr/';
my $dprefix = 'rr';
my $sprefix = 'liga1112';

# 2012/13
# my $prefix = 'http://www.pzbs.pl/wyniki/liga/liga2012-13/ekstraklasa/';
# my $dprefix = 'eks1213';
# my $sprefix = 'liga1213';

# 2013/14
# my $prefix = 'http://mczaja.w.interiowo.pl/liga1314/e1314/';
# my dprefix = 'rr';
# my $sprefix = 'liga1314';

# 2014/15
# my $prefix = 'http://www.pzbs.pl/wyniki/liga/liga2014-15/ekstraklasa/';
# my $dprefix = 'eks1415';
# my $sprefix = 'liga1415';


my $fetch = 'vugraph_linfetch.php';

for my $r (1 .. 15)
{
  for my $t (1 .. 8)
  {
    for my $s (1 .. 2)
    {
      my $download = $dprefix . "${r}t${t}-${s}.html";
      my $name = $prefix . $download;
      say $name;

      my $ff = File::Fetch->new(uri => $name); 
      my $where = $ff->fetch(to => $sprefix) or die $ff->error;

      rename "$sprefix/$fetch", "$sprefix/$download";
    }
  }
}

