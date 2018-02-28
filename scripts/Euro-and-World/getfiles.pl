#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

my $rounds = 50;
my $sprefix1 = '2018-Open/BAMFA1/Rounds';
my $sprefix2 = '2018-Open/BAMFA1/Matches';
my $tno = 1493;
my $tourney1 = 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';

# World Mind Games
# ----------------
#
# 2012: 949-952, 953-955?
# 'http://www.worldbridge.org/Repository/tourn/Lille.12/microSite/Results/';
#
# 2008: 694-697, 698-700
# 'http://www.worldbridge.org/Repository/tourn/Beijing.08/Asp/';

# Bermuda Bowl and Venice Cup
# ---------------------------
#
# 2005: 527, 528
# 'http://www.worldbridge.org/Repository/tourn/Estoril.05/Asp/';
# Also lower-case Boarddetails
#
# 2007: 607, 608
# 'http://www.worldbridge.org/Repository/tourn/Shanghai.07/Asp/';
#
# 2009: 782, 783
# 'http://www.worldbridge.org/Repository/tourn/SaoPaulo.09/Asp/';
#
# 2011: 881, 882
# 'http://www.worldbridge.org/Repository/tourn/Veldhoven.11/microSite/Results/';
#
# 2013: 980, 981
# 'http://www.worldbridge.org/Repository/tourn/Bali.13/Asp/';
#
# 2015: 1130, 1131
# 'http://www.worldbridge.org/Repository/tourn/chennai.15/MicroSiteAsp/';

# European Championships
# ----------------------
#
# 2006: 552, 553
# 'http://www.eurobridge.org/Repository/competitions/06Warsaw/asp/';
# Boarddetails, not BoardDetails (lower case d)
#
# 2008: 677, 678, 675
# 'http://www.eurobridge.org/Repository/competitions/08Pau/Asp/';
#
# 2010: 819, 820, 817
# 'http://www.eurobridge.org/Repository/competitions/10Ostend/microSite/Asp/';
#
# 2012: 916, 917, 914
# 'http://www.eurobridge.org/Repository/competitions/12Dublin/microSite/Asp/';
#
# 2014: 1023, 1024, 1021
# 'http://www.eurobridge.org/Repository/competitions/14Opatija/microSite/Asp/';
#
# 2018: 1480
# 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';


my $fetch1 = "$sprefix1/RoundTeams.asp";
my $boarddetails = "BoardDetails.asp";
my $fetch2 = "$sprefix2/$boarddetails";
my $tourney2 = "RoundTeams.asp?qtournid=$tno&qroundno=";
my $prefix = "$tourney1$tourney2";

for my $r (26 .. $rounds)
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

