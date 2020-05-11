#!perl

use strict;
use warnings;
use v5.10;

# Copy in player names into unnamed BoardDetails file.

# perl fixBAM.pl [home|away] N S E W

my %players;
$players{SH} = "HEIN Soren";
$players{ME} = "ELLERBECK Max";
$players{MS} = "SCHNEIDER Michael";
$players{GS} = "SMYKALLA Gisela";

my $goodlines = 183;
my $skips = 16;

my $template = "<a href=11111>&nbsp;XXX&nbsp;</a>";
my $tag = "XXX";


# Parse command line.

die "Not the right number of args" unless $#ARGV == 5;

my $fname = shift @ARGV;
open my $fh, "<$fname" or die "Can't open $fname";

my $room = shift @ARGV;
die "$room is not a room" unless ($room eq 'home' || $room eq 'away');

my @ptags;
for my $i (1 .. 4)
{
  my $n = shift @ARGV; # N, S, E, W
  die "$n is not a name" unless defined $players{$n};
  push @ptags, $n;
}


# Fiddle the names.

my ($north_open, $east_open, $south_open, $west_open);
my ($north_closed, $east_closed, $south_closed, $west_closed);

if ($room eq 'home')
{
  $north_open = $players{$ptags[0]};
  $west_open = "NN";
  $south_open = $players{$ptags[1]};
  $east_open = "NN";

  $north_closed = "NN";
  $west_closed = $players{$ptags[3]};
  $south_closed = "NN";
  $east_closed = $players{$ptags[2]};
}
else
{
  $north_closed = $players{$ptags[0]};
  $west_closed = "NN";
  $south_closed = $players{$ptags[1]};
  $east_closed = "NN";

  $north_open = "NN";
  $west_open = $players{$ptags[3]};
  $south_open = "NN";
  $east_open = $players{$ptags[2]};
}


# Make output.

my $ftmp = "/tmp/t.asp";
open my $ft, ">$ftmp" or die "Can't open $ftmp";

my $line;
for my $i (1 .. $goodlines)
{
  $line = <$fh>;
  chomp $line;
  print $ft "$line\n";
}

dump_piece("pieces/piece1.txt", $ft);
dump_name($north_open, $ft);

dump_piece("pieces/piece2.txt", $ft);
dump_name($north_closed, $ft);

dump_piece("pieces/piece3.txt", $ft);
dump_name($west_open, $ft);

dump_piece("pieces/piece4.txt", $ft);
dump_name($east_open, $ft);

dump_piece("pieces/piece5.txt", $ft);
dump_name($west_closed, $ft);

dump_piece("pieces/piece6.txt", $ft);
dump_name($east_closed, $ft);

dump_piece("pieces/piece7.txt", $ft);
dump_name($south_open, $ft);

dump_piece("pieces/piece8.txt", $ft);
dump_name($south_closed, $ft);

dump_piece("pieces/piece9.txt", $ft);


for my $i (1 .. $skips)
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


sub dump_piece
{
  my ($n, $ft) = @_;
  open my $f, $n or die "Can't open $n";
  while ($line = <$f>)
  {
    chomp $line;
    print $ft "$line\n";
  }
  close $f;
}

sub dump_name
{
  my ($n, $ft) = @_;

  my $name = $template;
  $name =~ s/$tag/$n/;
  print $ft "$name\n";
}
