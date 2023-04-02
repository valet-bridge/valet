#!perl

use strict;
use warnings;

my $file = shift;

open my $fh, "<$file" or die "Can't open file $file: $!";

# Heaader
my $line = <$fh>;
chomp $line;
print "$line\n";

while (my $line = <$fh>)
{
  chomp $line;

  # The comparisons all have a lot of capital letters in their names.
  my $uppercount = () = $line =~ m/\p{Uppercase}/g;
  next if $uppercount > 3;

  # We are on a German Excel.
  $line =~ s/\./,/g;

  print "$line\n";
}

close $fh;
