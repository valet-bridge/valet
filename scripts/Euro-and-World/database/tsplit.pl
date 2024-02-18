#!perl

use strict;
use warnings;
use v5.10;

# Split a tournaments.txt-like file into one file per tournament

die "perl tsplit.pl file.txt dir" unless $#ARGV == 1;

my $tfile = $ARGV[0];
my $dir = $ARGV[1];

open my $fh, '<', $tfile or die "Cannot read $tfile: $!";

my $line;
my $tourn_id = '';
my $tourn_string = '';
my $title_just_seen = 0;

while ($line = <$fh>)
{
  if ($line =~ /^TITLE /)
  {
    if ($tourn_string ne '')
    {
      write_tournament($tourn_id, $tourn_string);
    }

    $tourn_string = $line;
    $tourn_id = '';
    $title_just_seen = 1;
  }
  else
  {
    if ($title_just_seen && $line =~ /^ID (\d+)$/)
    {
      $tourn_id = $1;
    }

    $tourn_string .= $line;
    $title_just_seen = 0;
  }
}

if ($tourn_string ne '')
{
  write_tournament($tourn_id, $tourn_string);
}

close $fh;


sub write_tournament
{
  my ($tourn_id, $tourn_string) = @_;
  die "No tournament ID" if $tourn_id eq '';

  open my $fo, '>',  "$dir/$tourn_id" or 
    die "Cannot write tournament ID $tourn_id";

  print $fo $tourn_string;

  close $fo;
}

