#!perl

use strict;
use warnings;
use v5.10;

# Label the first file with the origin in the other files.

my $basefile = shift @ARGV;

# Build up a library of origins.

my %origin;
for my $fname (@ARGV)
{
  open my $fh, "<$fname" or die "Can't open $fname";

  my $base = $fname;
  $base =~ s/\..*//;
  $base =~ s/^bl//;

  my $line;
  while ($line = <$fh>)
  {
    chomp $line;
    if ($line =~ /^Players/ || $line =~ /^\s*$/)
    {
    }
    else
    {
      my @a = split ';', $line;
      $origin{$a[0]} = $base;
    }
  }
  close $fh;
}

# Annotate the first file with origins.

open my $fh, "<$basefile" or die "Can't open $basefile";

my $line;
while ($line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  if ($line =~ /^Players/ || $line =~ /^\s*$/)
  {
    say $line;
  }
  else
  {
    my @a = split ';', $line;
    if (! defined $origin{$a[0]})
    {
      die "No match for '$line'";
    }
    print $line . ";" . $origin{$a[0]} . "\n";
  }
}
close $fh;

exit;

