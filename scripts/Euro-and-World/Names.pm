#!perl

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT = qw(read_names names_to_numbers);

# Number of "no player".
my $NO_PLAYER = 999;

# Master names file if there is no names.txt in the directory
my $master_file = "./pnames.txt";


sub read_names
{
  my ($fname, $names_ref) = @_;
  my $fh;
  if (! (open $fh, "<$fname"))
  {
    open $fh, "<$master_file" or die "Can't open master $master_file: $!";
  }
  my @lines = <$fh>;
  close $fh;

  for my $i (0 .. $#lines)
  {
    my $line = $lines[$i];
    chomp $line;
    $line =~ s///g;
    my @elems = split /\|/, $line;
    $names_ref->{$elems[1]} = $elems[0];
  }
  return 1;
}


sub names_to_numbers
{
  my ($names_ref, $player_names_ref, $numbers_ref) = @_;

  for my $p (0 .. 7)
  {
    if (defined $names_ref->{$player_names_ref->[$p]{name}})
    {
      $numbers_ref->[$p] = $names_ref->{$player_names_ref->[$p]{name}};
    }
    else
    {
      $numbers_ref->[$p] = $NO_PLAYER;
    }
  }
}

1;


