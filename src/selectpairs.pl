#!perl

use strict;
use warnings;

# Select "our" pairs from the complete pair sheets.

my $file = shift;

open my $fh, "<$file" or die "Can't open file $file: $!";

my $state = 0;

while (my $line = <$fh>)
{
  chomp $line;
  if ($state == 0)
  {
    next unless $line =~ /^PAIR /;
    $line =~ s/^PAIR //;

    # The comparisons all have a lot of capital letters in their names.
    my $uppercount = () = $line =~ m/\p{Uppercase}/g;
    next if $uppercount > 3;

    # Looking for lines
    $state = 1;

    print "$line\n";
  }
  elsif ($state == 1)
  {
    if ($line =~ /^PAIR /)
    {
      $line =~ s/^PAIR //;

      my $uppercount = () = $line =~ m/\p{Uppercase}/g;
      if ($uppercount > 3)
      {
        # Ignore this pair
        $state = 0;
      }
      else
      {
        print "$line\n";
      }
    }
    else
    {
      print "$line\n";
    }
  }
}

close $fh;
