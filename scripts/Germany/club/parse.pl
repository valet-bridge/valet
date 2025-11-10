#!/usr/bin/perl

use strict;
use warnings;
use JSON;

if ($#ARGV != 0)
{
  print "Usage: perl parse.pl record.json\n";
  exit;
}

# This was a club tournament from November 6, 2025.
# Claudia did not have DBV numbers for three players,
# and the Butler didn't work.  I edited the JSON to add
# some player numbers, but then the player numbers were
# missing from the boards.

# Kludge due to missing pair names.
my %manual;
@{$manual{198}} = qw(17780 27311);
@{$manual{199}} = qw(14830 17871);

@{$manual{698}} = qw(44279 49359);
@{$manual{699}} = qw(32474 32476);

@{$manual{898}} = qw(27337 49359);
@{$manual{899}} = qw(27337 17898);

@{$manual{398}} = qw(18100 18101);
@{$manual{399}} = qw(50799 27303);

@{$manual{498}} = qw(27365 27363);
@{$manual{499}} = qw(18112 27320);

@{$manual{798}} = qw(18125 80002);
@{$manual{799}} = qw(80003 27322);

@{$manual{598}} = qw(18099 27346);
@{$manual{599}} = qw(48648 42992);

@{$manual{298}} = qw(48469 27459);
@{$manual{299}} = qw(41621 41210);

# Read the JSON file
my $filename = shift;
open my $fh, '<:encoding(UTF-8)', $filename or 
  die "Can't open $filename: $!";
my $json_text = do { local $/; <$fh> };
close $fh;

# Decode the JSON
my $data = decode_json($json_text);


my @pairs;
my %phash;
for my $pair (@{$data->{Klassen}[0]{Spieler}})
{
  my $pairno = $pair->{Startnr};
  for my $playerno (0 .. $#{$pair->{Spieler}})
  {
    my $dbv = $pair->{Spieler}[$playerno]{DBVNr};
    $pairs[$pairno][$playerno]{name} = $pair->{Spieler}[$playerno]{Name};
    $pairs[$pairno][$playerno]{dbv} = $pair->{Spieler}[$playerno]{DBVNr};

    $phash{$pairs[$pairno][$playerno]{dbv}} =
      $pairs[$pairno][$playerno]{name};
  }
}


my $namefile = 'names.txt';
open my $fn, '>:encoding(UTF-8)', $namefile or 
  die "Can't open $namefile $!";

for my $dbv (sort {$a <=> $b} keys %phash)
{
  print $fn ($dbv . '|' . $phash{$dbv} . "\n");
}

close $fn;


my $scorefile = 'scores.txt';
open my $fs, '>:encoding(UTF-8)', $scorefile or 
  die "Can't open $scorefile $!";

my @results;
for my $sess_no (0 .. $#{$data->{Klassen}[0]{Durchgaenge}})
{
  my $session = $data->{Klassen}[0]{Durchgaenge}[$sess_no];
  my $first_board = $session->{Firstboard};

  for my $bno ( 0 .. $#{$session->{Boards}})
  {
    $results[$sess_no][$bno + $first_board]{dealer} =
      $session->{Boards}[$bno]{Teiler};
    $results[$sess_no][$bno + $first_board]{vul} =
      $session->{Boards}[$bno]{Gefahr};

    my $bres = \@{$results[$sess_no][$bno + $first_board]{results}};

    for my $result_no (0 .. $#{$session->{Boards}[$bno]{Results}})
    {
      my $wres = $session->{Boards}[$bno]{Results}[$result_no];
      $bres->[$result_no]{contract} = $wres->{Contract};
      $bres->[$result_no]{lead} = $wres->{Lead};
      $bres->[$result_no]{NS_no} = $wres->{PNrN};
      $bres->[$result_no]{EW_no} = $wres->{PNrO};

      my $s = ($sess_no+1) . '|' . ($bno + $first_board) . '|';

      my $pair_ns = $pairs[$wres->{PNrN}];
      my $player_n = $manual{$wres->{PNrN}}[0];
      my $player_s = $manual{$wres->{PNrN}}[1];
      # my $player_n = $pair_ns->[0]{dbv};
      # my $player_s = $pair_ns->[1]{dbv};

      my $pair_ew = $pairs[$wres->{PNrO}];
      my $player_e = $manual{$wres->{PNrO}}[0];
      my $player_w = $manual{$wres->{PNrO}}[1];
      # my $player_e = $pair_ew->[0]{dbv};
      # my $player_w = $pair_ew->[1]{dbv};

      $s .= $player_n . '|' . $player_e . '|' .
        $player_s . '|' . $player_w . '|';

      my $contract = parse_contract($wres->{Contract});
      next if $contract eq '';

      $s .= $contract . parse_lead($wres->{Lead}) . "\n";

      print $fs $s;
    }
  }
}

close $fs;


sub parse_contract
{
  my $contract = shift;

  my ($decl, $level, $denom, $mult, $rel);

  if ($contract =~ /X/)
  {
    # print "HERE\n";
  }

  if ($contract =~ /^([NSOW]): (\d) !*([A-Z]+) X (.+)$/)
  {
    ($decl, $level, $denom, $mult, $rel) = ($1, $2, $3, 'X', $4);
  }
  elsif ($contract =~ /^([NSOW]): (\d) !*([A-Z]+) XX (.+)$/)
  {
    ($decl, $level, $denom, $mult, $rel) = ($1, $2, $3, 'XX', $4);
  }
  elsif ($contract =~ /^([NSOW]): (\d) !*([A-Z]+) (.+)$/)
  {
    ($decl, $level, $denom, $mult, $rel) = ($1, $2, $3, '', $4);
  }
  elsif ($contract eq 'Pass')
  {
    return 'P|S|';
  }
  elsif ($contract eq '40-% / 60+%' ||
      $contract eq '40-% / 40-%' ||
      $contract eq '60+% / 40-%' ||
      $contract eq '60+% / ---' ||
      $contract eq 'Dg.-Schnitt')
  {
    return '';
  }
  else
  {
    print "contract $contract\n";
    return '';
  }

  if ($rel eq '=')
  {
    $rel = 0;
  }

  if ($denom eq 'SA')
  {
    $denom = 'N';
  }

  if ($decl eq 'O')
  {
    $decl = 'E';
  }

  my $abs = $level + 6 + $rel;

  my $s = "$level$denom$mult|$decl|$abs|";
  return $s;
}


sub parse_lead
{
  my $lead = shift;

  if ($lead eq '')
  {
    return 0;
  }

  if ($lead !~ /^!([SHDC])(.+)$/)
  {
    print "lead $lead\n";
    return '';
  }

  my ($suit, $card) = ($1, $2);

  if ($card eq '10')
  {
    $card = 'T';
  }

  return "$suit$card";
}
