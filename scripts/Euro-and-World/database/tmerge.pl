#!perl

use strict;
use warnings;
use v5.10;

# Merge individual tournament files in numerical order

die "perl tmerge.pl dir result.txt" unless $#ARGV == 1;

my $dir = $ARGV[0];
my $tfile = $ARGV[1];

my @sorted_files = get_sorted_files($dir);

open my $fh, '>', $tfile or die "Cannot write to $tfile: $!";

my $line;

for my $file (@sorted_files)
{
  my $str = read_file_into_string("$dir/$file");
  print $fh $str;
}

close $fh;


sub get_sorted_files 
{
  my $dir = shift; # The directory to sort files in
    
  opendir(my $dh, $dir) or die "Cannot open directory $dir: $!";
  my @files = readdir($dh);
  closedir($dh);
    
  # Filter out '.' and '..' and any other non-numeric filenames if present
  @files = grep { /^\d+$/ } @files;
    
  # Numerically sort the files
  my @sorted_files = sort { $a <=> $b } @files;
    
  return @sorted_files;
}


sub read_file_into_string 
{
  my $filename = shift; # The name of the file to read

  open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
    
  # Temporarily undefine the input record separator to read the entire file
  local $/ = undef;
  my $file_contents = <$fh>;
    
  close($fh);
    
  return $file_contents;
}

