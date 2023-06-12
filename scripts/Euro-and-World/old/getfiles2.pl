#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

my $rounds = 23;
my $sprefix1 = '2018-Euro/RoundsSeniors';
my $sprefix2 = '2018-Euro/MatchesSeniors';
my $tno = 1502;
my $tourney1 = 'http://www.eurobridge.org/Repository/competitions/18Ostend/microSite/Asp/';
# 2018: 1500 Men 33 rounds,
# 1501 Women 23 rounds,
# 1502 Seniors 23 rounds (shifted)
# 'http://www.eurobridge.org/Repository/competitions/18Ostend/microSite/Asp/';


# 2023 Tignes
# my $rounds = 12;
# my $sprefix1 = '2023-Winter/Rounds';
# my $sprefix2 = '2023-Winter/Matches';
# my $tno = 2300;
# my $tourney1 = 'http://db.eurobridge.org/repository/competitions/23tignes/microsite/Asp/';


# my $rounds = 21;
# my $sprefix1 = '2020-Euro/Open/Rounds';
# my $sprefix2 = '2020-Euro/Open/Matches';
# my $tno = 2000;
# my $tourney1 = 'http://db.eurobridge.org/repository/competitions/20monaco/microsite/Asp/';

# Open European
# -------------
# 
# my $rounds = 50;
# my $sprefix1 = '2018-Open/BAMFA1/Rounds';
# my $sprefix2 = '2018-Open/BAMFA1/Matches';
# my $tno = 1493;
# my $tourney1 = 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';

# World Mind Games
# ----------------
#
# 2016: 1250-1252 Men, 1253-1254 Women
# 'http://db.worldbridge.org/Repository/tourn/wroclaw.16/microSite/Asp/';
#
# 2012: 949-952, 953-955?
# 'http://www.worldbridge.org/Repository/tourn/Lille.12/microSite/Results/';
#
# 2008: 694-697, 698-700
# 'http://www.worldbridge.org/Repository/tourn/Beijing.08/Asp/';

# Bermuda Bowl and Venice Cup
# ---------------------------
#
# 2005: 527 Men, 528 Women, 529 Seniors, 21 rounds; 
# 531 (not 530) TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/Estoril.05/Asp/';
# Also lower-case Boarddetails
#
# 2007: 607 Men, 608 Women, 609 Seniors, 21 rounds; 
# 610 TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/Shanghai.07/Asp/';
#
# 2009: 782 Men, 783 Women, 784 Seniors, 21 rounds; 
# 785 TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/SaoPaulo.09/Asp/';
#
# 2011: 881 Men, 882 Women, 883 Seniors, 21 rounds; 
# 884 TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/Veldhoven.11/microSite/Results/';
#
# 2013: 980 Men, 981 Women, 982 Seniors; 983 TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/Bali.13/microSite/Asp/';
#
# 2015: 1130 Men, 1131 Women, 1132 Seniors; 1133 TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/chennai.15/microSite/Asp/';
#
# 2017: 1440 Men, 1441 Women, 1442 Seniors; 1448 (not 1443) TNT 15 rounds
# 'http://www.worldbridge.org/Repository/tourn/lyon.17/microSite/Asp/';
#
# 2019: 1640 Men, 1641 Women, 1642 Seniors, 1643 Mixed, 23 rounds
# 1648 TNT 15 rounds
# 'http://db.worldbridge.org/Repository/tourn/wuhan.19/microSite/Asp/';
#
# 2022: 2200 Men, 2201 Women, 2202 Senior, 2203 Mixed, 23 rounds
# 2208 TNT but only 6 rounds, then suspended
# 'http://www.worldbridge.org/Repository/tourn/salsomaggiore.22/microSite/Asp/';
#

my $EUROCOMP = 'http://www.eurobridge.org/Repository/competitions/';

my %ANCHORS;
$ANCHORS{'06Warsaw'}   = '06Warsaw/asp/';
$ANCHORS{'08Pau'}      = '08Pau/Asp/';
$ANCHORS{'10Ostend'}   = '10Ostend/Asp/';
$ANCHORS{'12Dublin'}   = '12Dublin/microSite/Asp/';
$ANCHORS{'14Opatija'}  = '14Opatija/microSite/Asp/';
$ANCHORS{'16Budapest'} = '16Budapest/microSite/Asp/';
$ANCHORS{'18Ostend'}   = '18Ostend/microSite/Asp/';

my @MAP;
$MAP[552] = { $EUROCOMP, '06Warsaw', '2006-Euro', 'Men', 1, 33, 0 };
$MAP[553] = { $EUROCOMP, '06Warsaw', '2006-Euro', 'Women', 1, 21, 0 };
$MAP[554] = { $EUROCOMP, '06Warsaw', '2006-Euro', 'Seniors', 1, 15, 0 };
$MAP[587] = { $EUROCOMP, '06Warsaw', '2006-Euro', 'SeniorsFA', 1, 7, 0 };
$MAP[588] = { $EUROCOMP, '06Warsaw', '2006-Euro', 'SeniorsFB', 1, 7, 0 };

$MAP[677] = { $EUROCOMP, '08Pau', '2008-Euro', 'MenA', 1, 19, 1 };
$MAP[678] = { $EUROCOMP, '08Pau', '2008-Euro', 'MenB', 1, 19, 1 };
$MAP[675] = { $EUROCOMP, '08Pau', '2008-Euro', 'Women', 1, 25, 1 };
$MAP[676] = { $EUROCOMP, '08Pau', '2008-Euro', 'Seniors', 1, 19, 1 };
$MAP[679] = { $EUROCOMP, '08Pau', '2008-Euro', 'MenFinal', 1, 17, 1 };

# European Championships
# ----------------------
#
# 2006: 552 Men, 553 Women, 554 Seniors
# 'http://www.eurobridge.org/Repository/competitions/06Warsaw/asp/';
# Boarddetails, not BoardDetails (lower case d)
#
# 2008: 677/678 Men A/B 19 rounds, 
# 675 Women 25 rounds,
# 676 Seniors 19 rounds,
# 679 Men Final 17 rounds (rounds shifted to one another)
# 'http://www.eurobridge.org/Repository/competitions/08Pau/Asp/';
#
# 2010: 819/820 Men A/B 19 rounds,
# 817 Women 27 rounds,
# 818 Seniors 23 rounds,
# 821 Men Final rounds 20-28 (rounds shifted to one another)
# 'http://www.eurobridge.org/Repository/competitions/10Ostend/Asp/';
#
# 2012: 916/917 Men A/B 17 rounds, 
# 914 Women 19 rounds,
# 915 Seniors 19 rounds,
# 918 Men Final rounds 18-26 (rounds shifted to one another)
# 'http://www.eurobridge.org/Repository/competitions/12Dublin/microSite/Asp/';
#
# 2014: 1023/1024 Men A/B 17 rounds, 
# 1021 Women 23 rounds,
# 1022 Seniors 12 rounds, 1025 Final A 9 rounds, 1026 Final B 8 rounds,
# 1020 Men Final rounds 18-26
# 'http://www.eurobridge.org/Repository/competitions/14Opatija/microSite/Asp/';
#
# 2016: 1210 Men 37 rounds,
# 1211 Women 23 rounds,
# 1212 Seniors 23 rounds (rounds shifted to one another),
# 'http://www.eurobridge.org/Repository/competitions/16Budapest/microSite/Asp/';
#
# 2018: 1500 Men 33 rounds,
# 1501 Women 23 rounds,
# 1502 Seniors 23 rounds (shifted)
# 'http://www.eurobridge.org/Repository/competitions/18Ostend/microSite/Asp/';
#
#
#
# 2018: 1480
# 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';
#
# 2022: 2220, 29 rounds
# 'http://www.eurobridge.org/Repository/competitions/22Madeira/microSite/Asp/';


my $fetch1 = "$sprefix1/RoundTeams.asp";
my $boarddetails = "BoardDetails.asp";
my $fetch2 = "$sprefix2/$boarddetails";
my $tourney2 = "RoundTeams.asp?qtournid=$tno&qroundno=";
my $prefix = "$tourney1$tourney2";

for my $r (1 .. $rounds)
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

