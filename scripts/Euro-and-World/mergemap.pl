#!perl

use strict;
use warnings;
use v5.10;

use File::Copy;

# perl mergemap.pl 2005-World
# Reads the map.txt file, looks in the corresponding directories,
# copies and renames the corresponding PBN files into this top
# directory (e.g. Men, Seniors and Women are combined).
# Creates an overall score file with renumbered/renamed rounds.

# Parse command line.
die "Need a directory" unless $#ARGV == 0;
my $map_dir = shift;
my $map_file = "$map_dir/map.txt";

open my $fh, "<$map_file" or die "Can't open file $map_file";
my (@headers, @round_map, @reverse_map);
read_round_map();
close $fh;

# Read the map file into names of PBN files
my @dirs;
my @pbn_files;
make_pbn_names(\@dirs, \@pbn_files);

# Make the PBN directory in the top directory.
my $newPBN = "$map_dir/PBN";
mkdir $newPBN unless -e $newPBN;

# Copy the first non-zero one in the map into the top directory.
for my $mergeno (0 .. $#round_map)
{
  # Find the first non-zero number in the line.
  my $first_nonzero = 0;
  for my $dirno (1 .. $#{$round_map[$mergeno]})
  {
    if ($round_map[$mergeno][$dirno] ne '0')
    {
      $first_nonzero = $dirno;
      last;
    }
  }

  die "No non-zero entry in line $mergeno" unless $first_nonzero;

  # Figure out the name of the original file.
  my $orig = $dirs[$first_nonzero] . "/" . 
    $pbn_files[$first_nonzero]{$round_map[$mergeno][$first_nonzero]};

  my $newname = $map_dir . "/PBN/round" .
    $round_map[$mergeno][0] . ".pbn";

  copy($orig, $newname);
}

# Merge the score files.
my $newscores = "$map_dir/scores.txt";
my $tmpfile = "/tmp/mm$$";
open my $fr, ">$tmpfile" or die "Can't open file $tmpfile";

# It can happen (2007-Open-Euro, Mixed Swiss) that an entire round
# is skipped because there are no distributions, even though there
# are scores.
my %skips;

for my $dirno (1 .. $#headers)
{
  my $oldscore = $map_dir . "/" . $headers[$dirno] . "/scores.txt";
  open my $fo, "<$oldscore" or die "Can't open file $oldscore";
  while (my $line = <$fo>)
  {
    $line =~ s///g;
    chomp $line;
    $line =~ /^([^|]+)/;
    my $oldround = $1;

    if (! defined $reverse_map[$dirno]{$oldround})
    {
      if (! defined $skips{$oldround})
      {
        warn "Skipping round $oldround";
        $skips{$oldround} = 1;
      }
      next;
    }
    my $newround = $reverse_map[$dirno]{$oldround};
    my $newscore = $line;
    $newscore =~ s/^$oldround/$newround/;

    print $fr "$newscore\n";
  }

  close $fo;
}

close $fr;

system("sort -n $tmpfile > $newscores");
unlink($tmpfile);


sub read_round_map
{
  my $line = <$fh>;
  $line =~ s///g;
  chomp $line;

  @headers = split(',', $line);
  die "Merged column expected" unless $headers[0] eq 'Merged';

  my $no = 0;
  while ($line = <$fh>)
  {
    $line =~ s///g;
    chomp $line;

    @{$round_map[$no]} = split(',', $line);

    for my $i (1 .. $#{$round_map[$no]})
    {
      $reverse_map[$i]{$round_map[$no][$i]} = $round_map[$no][0];
    }

    $no++;
  }
}


sub make_pbn_names
{
  my ($dirs_ref, $names_ref) = @_;
  for my $dirno (1 .. $#headers)
  {
    my $dirname = "$map_dir/$headers[$dirno]/PBN";
    $dirs_ref->[$dirno] = $dirname;

    opendir my $dir, $dirname or die "Cannot open directory $dirname: $!";
    for my $fname (readdir $dir)
    {
      if ($fname =~ /^round(.+).pbn$/)
      {
        $names_ref->[$dirno]{$1} = $fname;
      }
    }
    closedir $dir;
  }
}

