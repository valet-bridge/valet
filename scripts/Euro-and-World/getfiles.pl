#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

use lib '.';
use Tourneys;

# perl getfiles3.pl 592
# where 592 is a tournament number that we know about,
# on either Eurobridge or Worldbridge.
#
# Number 935 requires the ANCHORS entry for Lille.12 to end on
# Results and not on Asp.

init_tourneys();

# Parse command line.
die "Need a tournament number" unless $#ARGV == 0;
my $tno = shift;

die "Not a known tournament number" unless defined $MAP[$tno];

my $site = $MAP[$tno][0];
my $tag = $MAP[$tno][1];
my $dir = $MAP[$tno][2];
my $group = $MAP[$tno][3];
my $round_first = $MAP[$tno][4];
my $round_last = $MAP[$tno][5];
my $spell_flag = $MAP[$tno][6];

my $tourney1 = $site  . $ANCHORS{$tag};
my $sprefix1 = "$dir/$group/Rounds";
my $sprefix2 = "$dir/$group/Matches";


# Open European
# -------------
# 
# my $rounds = 50;
# my $sprefix1 = '2018-Open/BAMFA1/Rounds';
# my $sprefix2 = '2018-Open/BAMFA1/Matches';
# my $tno = 1493;
# my $tourney1 = 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';


my $fetch1 = "$sprefix1/RoundTeams.asp";
my $boarddetails = ($spell_flag ? "BoardDetails.asp" : "Boarddetails.asp");
my $fetch2 = "$sprefix2/$boarddetails";
my $tourney2 = "RoundTeams.asp?qtournid=$tno&qroundno=";
my $prefix = "$tourney1$tourney2";

for my $r ($round_first .. $round_last)
{
  # First get the round overview.
  say "Round $r";

  my $name = $prefix . $r;
  say $name;

  my $res1 = $fetch1;
  $res1 =~ s/Teams/Teams$r/;

  my $ff = File::Fetch->new(uri => $name); 
  my $where = $ff->fetch(to => $sprefix1) or die $ff->error;
  say "fetch1 $fetch1 res1 $res1";
  rename $fetch1, $res1;

  # Then identify the URLs of match results.

  open my $fh, "<$res1" or die "Can't open $res1";
  my $line;
  my $table = 1;

  while ($line = <$fh>)
  {
    chomp $line;
    next if ($line !~ /$boarddetails/);
    next if ($line !~ /qmatchid=(\d+)/);

    my $name2 = $tourney1 . $boarddetails . "?qmatchid=$1";
    say $name2;

    # Then get each of the match files.

    my $res2 = $fetch2;
    $res2 =~ s/[dD]etails/Details-r$r-t$table/;
    $table++;

    $ff = File::Fetch->new(uri => $name2); 
    my $where = $ff->fetch(to => $sprefix2) or die $ff->error;
    say "fetch2 $fetch2 res2 $res2";
    rename $fetch2, $res2;

  }
  close $fh;

}

exit;

