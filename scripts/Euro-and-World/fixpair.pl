#!perl

use strict;
use warnings;
use v5.10;

# Copy in player names into unnames BoardDetails file.

my $fname = shift @ARGV;
open my $fh, "<$fname" or die "Can't open $fname";

my $type = shift @ARGV;
if ($type ne 'NS' && $type ne 'EW')
{
  die "Unknown type: $type";
}

my $ftmp = "/tmp/t.asp";
open my $ft, ">$ftmp" or die "Can't open $ftmp";

my $line;
for my $i (1 .. 183)
{
  $line = <$fh>;
  chomp $line;
  print $ft "$line\n";
}

my $fsub = ($type eq 'NS' ? "pairNS.asp" : "pairEW.asp");
open my $fa, "<$fsub" or die "Can't open $fsub";

while ($line = <$fa>)
{
  chomp $line;
  print $ft "$line\n";
}
close $fa;

for my $i (184 .. 199)
{
  $line = <$fh>;
}

while ($line = <$fh>)
{
  chomp $line;
  print $ft "$line\n";
}

close $fh;
close $ft;

my $fbak = $fname;
$fbak =~s /\.asp$/.bak/;
rename $fname, $fbak;
rename $ftmp, $fname;

exit;

