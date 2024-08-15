#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use File::Find;
# use URI::Find;
use URI::Find::Schemeless;

# Parse the lin files for URL's.

die "perl url.pl [bbono]" unless $#ARGV <= 0;

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

  my %urls;
  while (my $line = <$fh>) 
  {
    chomp $line;
    my @segments = split /\|/, $line;

    foreach my $segment (@segments) 
    {
      # Use URI::Find to extract URLs
      my $finder = URI::Find::Schemeless->new(sub {
        my ($uri) = @_;
        $uri =~ s/\/$//;
        $urls{$uri} = 1;
      });
      $finder->find(\$segment);
    }
  }
  close $fh;

  # Print out the URLs if any were found
  if (%urls) 
  {
    $base =~ /^(\d+).lin/;
    print "$1\n";
    print "$_\n" for sort keys %urls;
    print "\n";
  }
}
