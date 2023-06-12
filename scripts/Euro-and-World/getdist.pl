#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

use lib '.';
use Tourneys;

# perl getdist4.pl 592

init_tourneys();

# Parse command line.
die "Need a tournament number" unless $#ARGV == 0;
my $tno = shift;

die "Not a known tournament number" unless defined $MAP[$tno];

# Look up the tournament parameters.
my $site = $MAP[$tno][0];
my $tag = $MAP[$tno][1];
my $dir = $MAP[$tno][2];
my $group = $MAP[$tno][3];

# Read the scores file associated with this tournament.
# my $fname = "$dir/scores$group.txt";
my $fname = "$dir/$group/scores.txt";
open my $fh, "<$fname" or die "Can't open file $fname";
my %tag_array;
read_board_tags();
close $fh;

my $qstr = 'Boardacross.asp?qboard=';
my $tourney = $site . $ANCHORS{$tag} . $qstr;
my $out = "$dir/$group/Hands/";


for my $key1 (sort keys %tag_array) # Round
{
  for my $key2 (sort keys %{$tag_array{$key1}}) # Board
  {
    my $ext = sprintf("%03d.%02d..$tno", $key2, $key1);
    my $f = $tourney . $ext;

    say "$f";

    # Then get the hand file.

    my $ff = File::Fetch->new(uri => $f); 
    my $where = $ff->fetch(to => $out) or die $ff->error;
    rename $where, "$out$ext.txt";
  }
}


sub read_board_tags
{
  my $line;
  while ($line = <$fh>)
  {
    $line =~ s///g;
    chomp $line;
    $line =~ /^(\d+)\|(\d+)/;
    $tag_array{$1}{$2}++;
  }
}
