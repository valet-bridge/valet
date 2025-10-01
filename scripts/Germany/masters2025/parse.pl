#!/usr/bin/perl

use strict;
use warnings;
use JSON;

if ($#ARGV != 0)
{
  print "Usage: perl parse.pl record.json\n";
  exit;
}

# Special Felix case.
my $special_number = 0;
my $special_name = 'Felix VON ARMIN';
my $special_dbv = 19986;

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
    if ($dbv == $special_number)
    {
      $pairs[$pairno][$playerno]{name} = $special_name;
      $pairs[$pairno][$playerno]{dbv} = $special_dbv;
    }
    else
    {
      $pairs[$pairno][$playerno]{name} = $pair->{Spieler}[$playerno]{Name};
      $pairs[$pairno][$playerno]{dbv} = $pair->{Spieler}[$playerno]{DBVNr};
    }

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
      my $player_n = $pair_ns->[0]{dbv};
      my $player_s = $pair_ns->[1]{dbv};

      my $pair_ew = $pairs[$wres->{PNrO}];
      my $player_e = $pair_ew->[0]{dbv};
      my $player_w = $pair_ew->[1]{dbv};

      $player_n = $special_dbv if $player_n == $special_number;
      $player_s = $special_dbv if $player_s == $special_number;
      $player_e = $special_dbv if $player_e == $special_number;
      $player_w = $special_dbv if $player_w == $special_number;

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
