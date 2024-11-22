#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Try::Tiny;

use lib '.';
use DateCalc;

# Add weekday to certain files.


die "perl cook.pl raw.txt [bbono]" unless ($#ARGV >= 0);

for my $file (@ARGV)
{
  open my $fh, '<', $file or die "Cannot read file: $!";
  my $lno = 0;

  while (my $line = <$fh>)
  {
    chomp $line;
    $line =~ s///g;
    $lno++;

    if ($line =~ /'(\d\d\d\d-\d\d-\d\d)',*\s*$/)
    {
      my $d = $1;
      my $day;

      my $dc = DateCalc->new();
      try
      {
        $day = $dc->day($d);
      }
      catch
      {
        warn "line $lno, $line: Not a date";
      };

      print "$line # $day\n";
    }
    else
    {
      print "$line\n";
    }
  }

  close $fh;
}

