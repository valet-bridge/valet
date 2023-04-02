#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

my $fname = shift;
open my $fh, "<$fname" or die "Can't open file $fname";
my %tag_array;
read_board_tags();
close $fh;

my ($tourney, $tno, $out);

my $qstr = 'Boardacross.asp?qboard=';
my $wroot = 'http://www.worldbridge.org/Repository/tourn/';
my $eroot = 'http://www.eurobridge.org/Repository/competitions/';


if ($fname =~ /2005-World/)
{
  $tourney = $wroot . 'Estoril.05/Asp/' . $qstr;
  $tno = 527;
  $out = '2005-World/Open/Hands/';
}
elsif ($fname =~ /2007-World/)
{
  $tourney = $wroot . 'Shanghai.07/Asp/' . $qstr;
  $tno = 607;
  $out = '2007-World/Open/Hands/';
}
elsif ($fname =~ /2009-World/)
{
  $tourney = $wroot . 'SaoPaulo.09/Asp/' . $qstr;
  $tno = 782;
  $out = '2009-World/Open/Hands/';
}
elsif ($fname =~ /2011-World/)
{
  $tourney = $wroot . 'Veldhoven.11/Microsite/Results/' . $qstr;
  $tno = 881;
  $out = '2011-World/Open/Hands/';
}
elsif ($fname =~ /2013-World/)
{
  $tourney = $wroot . 'Bali.13/Microsite/Asp/' . $qstr;
  $tno = 980;
  $out = '2013-World/Open/Hands/';
}
elsif ($fname =~ /2015-World/)
{
  $tourney = $wroot . 'Chennai.15/Microsite/Asp/' . $qstr;
  $tno = 1130;
  $out = '2015-World/Open/Hands/';
}
elsif ($fname =~ /2017-World/)
{
  $tourney = $wroot . 'Lyon.17/Microsite/Asp/' . $qstr;
  $tno = 1440;
  $out = '2017-World/Open/Hands/';
}
elsif ($fname =~ /2019-World/)
{
  $tourney = $wroot . 'Wuhan.19/Microsite/Asp/' . $qstr;
  $tno = 1640;
  $out = '2019-World/Open/Hands/';
}
elsif ($fname =~ /2022-World/)
{
  $tourney = $wroot . 'Salsomaggiore.22/Microsite/Asp/' . $qstr;
  $tno = 2200;
  $out = '2022-World/Open/Hands/';
}
elsif ($fname =~ /2006-Euro/)
{
  $tourney = $eroot . '06Warsaw/Asp/' . $qstr;
  $tno = 552;
  $out = '2006-Euro/Open/Hands/';
}
elsif ($fname =~ /2008-Euro/)
{
  $tourney = $eroot . '08Pau/Asp/' . $qstr;
  $tno = 677;
  $out = '2008-Euro/Open/Hands/';
}
elsif ($fname =~ /2010-Euro/)
{
  $tourney = $eroot . '10Ostend/Asp/' . $qstr;
  $tno = 819;
  $out = '2010-Euro/Open/Hands/';
}
elsif ($fname =~ /2012-Euro/)
{
  $tourney = $eroot . '12Dublin/microsite/Asp/' . $qstr;
  $tno = 916;
  $out = '2012-Euro/Open/Hands/';
}
elsif ($fname =~ /2014-Euro/)
{
  $tourney = $eroot . '14Opatija/microsite/Asp/' . $qstr;
  $tno = 1023;
  $out = '2014-Euro/Open/Hands/';
}
elsif ($fname =~ /2016-Euro/)
{
  $tourney = $eroot . '16Budapest/microsite/Asp/' . $qstr;
  $tno = 1210;
  $out = '2016-Euro/Open/Hands/';
}
elsif ($fname =~ /2018-Euro/)
{
  $tourney = $eroot . '18Ostend/microsite/Asp/' . $qstr;
  $tno = 1500;
  $out = '2018-Euro/Open/Hands/';
}
elsif ($fname =~ /2022-Euro/)
{
  $tourney = $eroot . '22Madeira/microsite/Asp/' . $qstr;
  $tno = 2220;
  $out = '2022-Euro/Open/Hands/';
}
elsif ($fname =~ /2008-Mind/)
{
  $tourney = $wroot . 'Beijing.08/Asp/' . $qstr;
  $tno = 694;
  $out = '2008-Mind/Open/Hands/';
}
elsif ($fname =~ /2012-Mind/)
{
  $tourney = $wroot . 'Lille.12/microsite/Results/' . $qstr;
  $tno = 949;
  $out = '2012-Mind/Open/Hands/';
}
elsif ($fname =~ /2016-Mind/)
{
  $tourney = $wroot . 'Wroclaw.16/microsite/Asp/' . $qstr;
  $tno = 1250;
  $out = '2016-Mind/Open/Hands/';
}
else
{
  die "$fname not tied to data";
}

for my $key1 (sort keys %tag_array) # Round
{
  for my $key2 (sort keys %{$tag_array{$key1}}) # Board
  {
    my $ext = sprintf("%03d.%02d..$tno", $key2, $key1);
    my $f = $tourney . $ext;

    say "$f";

    # Then get the hand file.

    my $ff = File::Fetch->new(uri => $f); 
    my $where = $ff->fetch(to => $out) or die $ff->error;
    rename $where, "$out$ext.txt";
  }
}


sub read_board_tags
{
  my $line;
  while ($line = <$fh>)
  {
    $line =~ s///g;
    chomp $line;
    $line =~ /^(\d+)\|(\d+)/;
    $tag_array{$1}{$2}++;
  }
}
