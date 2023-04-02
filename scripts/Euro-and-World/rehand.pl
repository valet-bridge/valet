#!perl

use strict;
use warnings;

require './recore.pl';

# perl rehand.pl hands1.txt high|low > hands1a.txt
#
# Renumbers hands into either 1-15 or 16-30.

my $file = shift;
my $flag = shift;

my $high_flag;
if ($flag eq 'high')
{
  $high_flag = 1;
}
elsif ($flag eq 'low')
{
  $high_flag = 0;
}
else
{
  die "flag $flag";
}

my @boards;
open my $fh, "<$file" or die "Can't open $file: $!";
while (my $line = <$fh>)
{
  if ($line =~ /\[Board "(\d+)"]/)
  {
    push @boards, $1;
  }
}
close $fh;

my @maps;
translate(\@boards, $high_flag, \@maps);

# plist(\@boards, "Boards");
# plist(\@maps, $flag);

my @blocks;

open my $fh2, "<$file" or die "Can't open $file: $!";
while (my $line = <$fh2>)
{
  chomp $line;
  if ($line =~ /\[Board "(\d+)"]/)
  {
    my $b = $1;
    next if $maps[$b] == 0;

    while ($line = <$fh2>)
    {
      chomp $line;
      last if $line =~ /^\s*$/;
      push @{$blocks[$maps[$b]]}, $line;
    }
  }
}
close $fh;

for my $bno (0 .. $#blocks)
{
  next unless defined $blocks[$bno];

  print "[Board \"$bno\"]\n";
  for my $l (@{$blocks[$bno]})
  {
    print "$l\n";
  }
  print "\n";
}

sub plist
{
  my ($rref, $text) = @_;

  print "$text\n";
  for my $i (0 .. $#$rref)
  {
    next unless defined $rref->[$i];
    print "$i $rref->[$i]\n";
  }
  print "\n";
}
