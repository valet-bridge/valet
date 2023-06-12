#!perl

package Plausibles;

use strict;
use warnings;
use Exporter;
use v5.10;

# Recognizing plausible contracts, declarers, leads, tricks and scores.

our @ISA = qw(Exporter);
our @EXPORT = qw(%CONTRACTS %DECLARERS %LEADS @TRICKS @SCORES init_plausibles);

our(%CONTRACTS, %DECLARERS, %LEADS, @TRICKS, @SCORES);

sub init_plausibles
{
  init_contracts();
  init_declarers();
  init_leads();
  init_tricks();
  init_scores();
}


sub init_contracts
{
  # This excludes pass.
  for my $level (1 .. 7)
  {
    for my $denom (qw(N S H D C))
    {
      for my $dbl ('', 'x', 'xx', 'X', 'XX', '*', '**')
      {
        my $contract = "$level$denom$dbl";
        $CONTRACTS{$contract} = 1;
      }
    }
  }
}


sub init_declarers
{
  for my $decl (qw(N E S W))
  {
    $DECLARERS{$decl} = 1;
  }
}


sub init_leads
{
  for my $suit (qw(S H D C))
  {
    for my $card (qw(2 3 4 5 6 7 8 9 10 T J Q K A))
    {
      my $lead = "$suit$card";
      $LEADS{$lead} = 1;
    }
  }
}


sub init_tricks
{
  for my $tricks (0 .. 13)
  {
    # 0, really but hard to tell apart from a score,
    # and maybe not so frequent.  Let's see if this becomes a problem.
    $TRICKS[$tricks] = 1;
  }
}


sub init_scores
{
  my @down_nv = qw(50 100 150 200 250 300 350 400 450 500 550 600 650);
  my @down_nv_dbl  = qw(800 1100 1400 1700 2000 2300 2600 2900 3200 3500);
  my @down_nv_rdbl = qw(600 1000 1600 2200 2800 3400 4000 4600 5200 5800
    6400 7000);

  $SCORES[$_] = 1 for @down_nv;
  $SCORES[$_] = 1 for @down_nv_dbl;
  $SCORES[$_] = 1 for @down_nv_rdbl;

  my @down_v = qw(700 900 1200 1300);
  my @down_v_dbl = qw(3800);
  my @down_v_rdbl = qw(7600);

  $SCORES[$_] = 1 for @down_v;
  $SCORES[$_] = 1 for @down_v_dbl;
  $SCORES[$_] = 1 for @down_v_rdbl;

  my @one_minor = qw(70 90 110 130 170 190
    140 240 340 440 540 640 740
    230 430 630 830 1030 1230 1430
    940 1140 1340
    1830 2230 2630);

  my @one_major = qw(80 140 260 
    160 360 460 560 660 760
    520 720 920 1120 1320 1520 1720
    960 1160 1360
    1920 2320 2720 3120);

  my @one_NT = qw(120 180 210 240 270
    280 380 480 580 680 780
    560 760 960 1160 1360 1560 1760
    980 1180 1380
    1960 2360 2760 3160);

  $SCORES[$_] = 1 for @one_minor;
  $SCORES[$_] = 1 for @one_major;
  $SCORES[$_] = 1 for @one_NT;

  my @two_major = qw(470 570 670 770 870 970
    640 840 1040 1240 1440 1640
    670 870 1070 1270 1470 1670
    2040 2440 2840);

  my @two_NT = qw(490 590 690 790 890 990
    680 880 1080 1280 1480 1680
    690 890 1090 1290 1490 1690
    2080 2480 2880);

  $SCORES[$_] = 1 for @two_major;
  $SCORES[$_] = 1 for @two_NT;

  my @three_major = qw(530 630 730 830 930
    1130 1330 1530
    2160 2560);

  my @three_NT = qw(430 520
    630 660 690 720
    750 850 950
    1150 1350 1550
    1800);

  $SCORES[$_] = 1 for @three_major;
  $SCORES[$_] = 1 for @three_NT;

  my @four_minor = qw(710 710
    910 1110 1310
    1320 1720 2120);

  my @four_major = qw(420 450 480 510
    620 680 710
    2280);

  my @four_NT = qw(610 710 810 910
    1010 1210 1410
    1120 1520);

  $SCORES[$_] = 1 for @four_minor;
  $SCORES[$_] = 1 for @four_major;
  $SCORES[$_] = 1 for @four_NT;

  my @five_major = qw(850 1050 1250);

  my @five_NT = qw(670 770 870
    1040 1240 1440
    870 1070 1270
    1240 1640);

  $SCORES[$_] = 1 for @five_major;
  $SCORES[$_] = 1 for @five_NT;

  my @six_minor = qw(920 940 1090 1190
    1380 1580 1370 1390
    1540 1740);

  my @six_major = qw(980 1010 1430 1460
    1620 1820 1660 1860
    2070 2470);

  my @six_NT = qw(990 1020 1660 1860 1680 1880 2070 2470);

  $SCORES[$_] = 1 for @six_minor;
  $SCORES[$_] = 1 for @six_major;
  $SCORES[$_] = 1 for @six_NT;

  my @seven_minor = qw(1630 2140 1960 2330 2660);

  my @seven_major = qw(1510 1770 2240 2210 2470 2940);

  my @seven_NT = qw(1520 1790 2280 2220 2490 2980);

  $SCORES[$_] = 1 for @seven_minor;
  $SCORES[$_] = 1 for @seven_major;
  $SCORES[$_] = 1 for @seven_NT;
}


1;
