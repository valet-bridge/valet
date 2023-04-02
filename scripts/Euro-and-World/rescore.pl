#!perl

use strict;
use warnings;

require './recore.pl';

# perl rescore.pl hands1.txt scores1.txt high|low > scores1a.txt
#
# Renumbers scores into either board numbers 1-15 or 16-30.

my $hfile = shift;
my $sfile = shift;
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

# Get hand numbers

my @boards;
open my $fh, "<$hfile" or die "Can't open $hfile: $!";
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

open my $fh2, "<$sfile" or die "Can't open $sfile: $!";
while (my $line = <$fh2>)
{
  chomp $line;
  $line =~ /^\d+\|(\d+)/;
  my $b = $1;
  next if $maps[$b] == 0;
  my $m = $maps[$b];

  $line =~ s/^(\d+)\|(\d+)\|(.*)/$1\|$m\|$3/;

  print "$line\n";
}
close $fh;

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
