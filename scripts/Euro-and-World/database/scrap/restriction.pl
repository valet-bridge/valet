#!perl

use strict;
use warnings;
use v5.10;

# Check that the RESTRICTION is always the same within a 
# teams tournament.  Output the condensed data.

die "perl restriction.pl" unless $#ARGV == -1;

my $teams_file = 'wteams.txt';

my @restrictions = (
  [ "Girls series", "U26", "Women" ],
  [ "Juniors series", "U26", "Open" ],
  [ "Juniors Swiss series", "U26", "Open" ],
  [ "Juniors B-A-M series", "U26", "Open" ],

  [ "Youngsters series", "U21", "Open" ],

  [ "Kids series", "U16", "Open" ],

  [ "All series", "Open", "Open" ],
  [ "Open series", "Open", "Open" ],
  [ "Transnational Open series", "Open", "Open" ],
  [ "Bermuda Bowl series", "Open", "Open" ],
  [ "Rosenblum Cup series", "Open", "Open" ],
  [ "Rosenblum series", "Open", "Open" ],
  [ "Rand Cup series", "Open", "Open" ],
  [ "Transnational Teams series", "Open", "Open" ],
  [ "Open Olympiad series", "Open", "Open" ],
  [ "Olympiad series", "Open", "Open" ],
  [ "Transnational Teams (BB) series", "Open", "Open" ],

  [ "Senior Bowl series", "Senior", "Open" ],
  [ "Seniors series", "Senior", "Open" ],

  [ "Venice Cup series", "Open", "Women" ],
  [ "McConnell Cup series", "Open", "Women" ],
  [ "McConnell series", "Open", "Women" ],
  [ "Women series", "Open", "Women" ],

  [ "Mixed series", "Open", "Mixed" ],
  [ "Mixed Teams series", "Open", "Mixed" ],
  [ "Transnational Mixed series", "Open", "Mixed" ],
  [ "Transnational Mixed Teams series", "Open", "Mixed" ]
);

my %rhash;
for my $r (@restrictions)
{
  $rhash{$r->[0]} = 1;
}


open my $fw, '<', $teams_file or die "Cannot read $teams_file: $!";

my $title;
my $id;
my $details;
my $restriction = '';

while (my $line = <$fw>)
{
  chomp $line;

  if ($line =~ /^TITLE (\d+)/)
  {
    $title = $1;
    $restriction = '';
  }
  elsif ($line =~ /^ID (\d+)/)
  {
    $id = $1;
  }
  elsif ($line =~ /^DETAILS (\d+)/)
  {
    $details = $1;
  }
  elsif ($line =~ /^RESTRICTION (.*)/)
  {
    if ($restriction eq '')
    {
      $restriction = $1;
      if (! defined $rhash{$restriction})
      {
        print "Unknown: $restriction\n";
      }
    }
    elsif ($restriction ne $1)
    {
      print "$id\n";
      # print "$id: Different restrictions $1, $restriction\n";
      $restriction = $1;
      if (! defined $rhash{$restriction})
      {
        print "Unknown: $restriction\n";
      }
    }
  }
}

close $fw;
