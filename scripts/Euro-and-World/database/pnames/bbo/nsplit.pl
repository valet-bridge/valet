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

  if ($line2 eq $line3)
  {
    next;
  }

  print "$line1\n";
  print "$line2\n";
  print "$line3\n";
  print "$line4\n";
}
close $fh;

