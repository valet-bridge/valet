#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Date::Extract;

# Parse the lin files heuristically for times.

die "perl times.pl [bbono]" unless $#ARGV <= 0;

my $debug_flag = 0;
my $debug_bbono;
if ($#ARGV == 0)
{
  $debug_flag = 1;
  $debug_bbono = $ARGV[0];
}

my $dir = '../../../../../../../bboD/';
opendir my $dh, $dir or die "Cannot open directory $dir: $!";
my @entries = readdir($dh);
closedir $dh;

for my $entry (@entries)
{
  next unless $entry =~ /\d\d\d\d\d\d/;
  opendir my $dh2, "$dir/$entry" or die "Cannot open directory $entry $!";
  my @lin_files = grep { /\.lin$/ } readdir($dh2);
  closedir $dh2;

  foreach my $file (@lin_files) 
  {
    process_lin_file("$dir/$entry/$file", $file);
  }
  
}


sub process_lin_file 
{
  my ($file_path, $base) = @_;

  open my $fh, '<', $file_path or die "Cannot open file $file_path: $!";

  my %dates;
  while (my $line = <$fh>) 
  {
    chomp $line;
    my @segments = split /\|/, $line;

    foreach my $segment (@segments) 
    {
      my $extractor = Date::Extract->new();
      my @dlist = $extractor->extract($segment);
      next unless @dlist;
      foreach my $date (@dlist)
      {
        next unless defined $date;
        $dates{$date} = 1;
      }
    }
  }
  close $fh;

  # Print out the dates if any were found
  if (%dates) 
  {
    $base =~ /^(\d+).lin/;
    print "$1\n";
    print "$_\n" for sort keys %dates;
    print "\n";
  }
}
