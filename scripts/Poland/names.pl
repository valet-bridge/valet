#!perl

use strict;
use warnings;
use v5.10;


for my $fname (@ARGV)
{
  open my $fh, "<$fname" or die "Can't open $fname";
  my $line = <$fh>;
  close $fh;

  chomp $line;
  
  # Suit symbols
  $line =~ s/\<img alt="(\w)[^>]*\>/\u$1/g;

  # Doubles
  $line =~ s/\&times;/X/g;

  # Get some newlines at the end of the table lines
  $line =~ s/\<\/tr\>/\n/g;

  # Get some spaces in each cell
  $line =~ s/\<\/td\>/ /g;

  # Get rid of all other <>'s.
  $line =~ s/\<[^>]*\>//g;

  # Make sure each cell holds something
  $line =~ s/\&nbsp;/ _Z_ /g;
  $line =~ s/\&ndash;/ _Z_ /g;

  my @array = split "\n", $line;
  my $state = 0;
  my $counter = 0;
  my $delay = '';

  for my $l (@array)
  {
    chomp $l;
    $l =~ s/^\s*//g;
    next if ($l =~ /^\s*$/);
    next if ($l =~ /^\s*_Z_\s*$/);

    if ($state == 0)
    {
      $state = 1 if ($l =~ /CLOSED/ || $l =~ /ZAMKN/);
    }
    elsif ($state == 1)
    {
      last if ($l =~ /^contr/ || $l =~ /^kontr/);

      my @elems = split /_Z_/, $l;
      print_names($elems[0]);
      print_names($elems[1]);
    }
  }
}


sub print_names
{
  my($text) = @_;

  my @list = split /[:-]/, $text;
  $list[2] =~ s/\s+$//;
  say "$list[1]";
  say "$list[2]";

}
