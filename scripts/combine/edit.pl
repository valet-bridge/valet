#!perl

use strict;
use warnings;
use v5.10;

my @order = qw(1 3 2 4 6 5 7 8 10 9 12 11 13);

for my $fname (@ARGV)
{
  open my $fh, "<$fname" or die "Can't open $fname";

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    next if ($line =~ /^Players/);
    next if ($line =~ /^\s*$/);

    $line =~ s///g;
    $line =~ s/^(.+) - ([^;]+)//;
    my $p1 = $1;
    my $p2 = $2;

    capitalize(\$p1);
    capitalize(\$p2);

    if ($p1 le $p2)
    {
      say "$p1 - $p2$line";
    }
    else
    {
      my @fields = split ';', $line;
      if ($#fields == 11)
      {
        $fields[13] = $fields[11];
        $fields[11] = 0.;
        $fields[12] = 0.;
      }
      elsif ($#fields != 13)
      {
        die "Wrong field length in line .$line.";
      }

      my $out = "$p2 - $p1";
      for my $i (0 .. 12)
      {
        $out .= ";" . $fields[$order[$i]];
      }
      print $out . "\n";
    }
  }
  close $fh;
}

exit;


sub capitalize
{
  my ($vref) = @_;

  my $copy = $$vref;
  $copy =~ /^(\w+) /;
  my $word1 = $1;
  return if ($word1 eq uc($word1));

  $copy =~ s/^(.+) (\S+)$/\U$2\E $1/;
  $$vref = $copy;
}

