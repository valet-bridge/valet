#!perl
use strict;
use warnings;

my $file = 'turk';
my $lno = 0;
open(my $fh, "<", $file) or die "Cannot open $file: $!";
while (my $line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  my $line1 = $line;

  $line = <$fh>;
  chomp $line;
  $line =~ s///g;
  my $line2 = $line;

  $line = <$fh>;
  chomp $line;
  $line =~ s///g;
  my $line3 = $line;

  $line = <$fh>;
  chomp $line;
  $line =~ s///g;
  my $line4 = $line;

  $lno += 4;

  if ($line4 !~ /^\s*$/)
  {
    die "$lno: $line4";
  }

  print "$line3\n";
}
close $fh;

