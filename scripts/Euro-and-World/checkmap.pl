#!perl

use strict;
use warnings;
use v5.10;

# perl checkmap.pl 2005-World
# Reads the map.txt file, looks in the corresponding directories,
# validates that corresponding PBN files are subsets of the 
# first non-zero column.  The Merged column is ignored here.

# Parse command line.
die "Need a directory" unless $#ARGV == 0;
my $map_dir = shift;
my $map_file = "$map_dir/map.txt";

open my $fh, "<$map_file" or die "Can't open file $map_file";
my (@headers, @round_map);
read_round_map();
close $fh;

# Read the map file into names of PBN files
my @dirs;
my @pbn_files;
make_pbn_names(\@dirs, \@pbn_files);

# Loop over each line in the round map
my @contents;
read_PBN_contents(\@contents);

# Check the contents of PBN files as specified in the map.
for my $mergeno (0 .. $#round_map)
{
  # Find the first non-zero number in the line.
  my $first_nonzero = 0;
  for my $dirno (1 .. $#{$round_map[$mergeno]})
  {
    if ($round_map[$mergeno][$dirno])
    {
      $first_nonzero = $dirno;
      last;
    }
  }

  die "No non-zero entry in line $mergeno" unless $first_nonzero;

  for my $dirno ($first_nonzero+1 .. $#{$round_map[$mergeno]})
  {
    next unless $round_map[$mergeno][$dirno];
    if (! pbn_contained(\@{$contents[$mergeno][$first_nonzero]}, 
      \@{$contents[$mergeno][$dirno]}))
    {
      print "mergeno $mergeno, first_nonzero $first_nonzero, dirno $dirno\n";
      print "round_map ", join ',', @{$round_map[$mergeno]}, "\n";
      die "$headers[$dirno] not contained in $headers[$first_nonzero]";
    }
  }
}

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
      if ($fname =~ /^round(\d+).pbn$/)
      {
        $names_ref->[$dirno][$1] = $fname;
      }
    }
    closedir $dir;
  }
}


sub read_PBN_contents
{
  my $contents_ref = pop;
  for my $mergeno (0 .. $#round_map)
  {
    for my $dirno (1 .. $#{$round_map[$mergeno]})
    {
      my $refno = $round_map[$mergeno][$dirno];
      next if $refno eq '0';

      my $fname = "$map_dir/$headers[$dirno]/PBN/round$refno.pbn";
      open my $fh, $fname or die "Cannot open PBN file $fname: $!";

      my ($board, $dealer, $vul, $deal);
      while (my $line = <$fh>)
      {
        $line =~ s///g;
        chomp $line;
        next if $line eq '';

        if ($line =~ /^\[Board "(\d+)"\]/)
        {
          $board = $1;
        }
        elsif ($line =~ /^\[Dealer "(.+)"\]/)
        {
          $dealer = $1;
        }
        elsif ($line =~ /^\[Vulnerable "(.+)"\]/)
        {
          $vul = $1;
        }
        elsif ($line =~ /^\[Deal "(.+)"\]/)
        {
          $deal = $1;
  
          $contents_ref->[$mergeno][$dirno][$board]{dealer} = $dealer;
          $contents_ref->[$mergeno][$dirno][$board]{vul} = $vul;
          $contents_ref->[$mergeno][$dirno][$board]{deal} = $deal;
        }
        else
        {
          die "Odd PBN line '$line'";
        }
      }
    }
  }
}


sub pbn_contained
{
  my ($ref1, $ref2) = @_;

  for my $bno (1 .. $#$ref2)
  {
    next unless defined $ref2->[$bno];
    if (! defined $ref1->[$bno])
    {
      print "Board number $bno not contained in reference\n";
      return 0;
    }

    for my $tag (qw(dealer vul deal))
    {
      if ($ref1->[$bno]{$tag} ne $ref2->[$bno]{$tag})
      {
        print "Tag $tag: $ref1->[$bno]{$tag} vs $ref2->[$bno]{$tag}\n";
        return 0;
      }
    }
  }
  return 1;
}
