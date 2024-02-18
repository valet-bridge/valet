#!perl

package PairT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Pair;
use Players;
use Util;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub get_pair_restriction
{
  my ($self, $tourn_header, $chunk_restriction, $errstr) = @_;

  my $unit_restriction = (defined $chunk_restriction ?
    $chunk_restriction : 'None');

  my $pair_gender_restriction = $tourn_header->restrict_gender(
    $unit_restriction, $errstr);
    
  my $pair_age_restriction = $tourn_header->restrict_age(
    $unit_restriction, $errstr);

  my $pair_stage_restriction = $tourn_header->restrict_stage(
    $unit_restriction, $errstr);

  my $pair_restriction = 
    $pair_gender_restriction . '-' .
    $pair_age_restriction . '-' .
    $pair_stage_restriction;

  return $pair_restriction;
}


sub add_from_chunk
{
  my ($self, $tourn_header, $chunk_ref, $players_ref, $errstr) = @_;

  my $pair_restriction = $self->get_pair_restriction(
    $tourn_header, $chunk_ref->{RESTRICTION}, $errstr);
    
  push @{$self->{$pair_restriction}}, Pair->new();
  my $pair_no = $#{$self->{$pair_restriction}}, Pair->new();

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    $self->{$pair_restriction}[$pair_no]->add_key_value(
      $key, $chunk_ref->{$key});
  }

  $self->{$pair_restriction}[$pair_no]->check_basics(
    $players_ref, "$errstr, $pair_no");

  $self->{$pair_restriction}[$pair_no]->fill_player_map(
    \%{$self->{_players}}, $pair_no);
  
  $self->{$pair_restriction}[$pair_no]->analyze_gender(
    $players_ref, $errstr);
  
  if (! $self->{$pair_restriction}[$pair_no]->check_gender(
    $pair_restriction))
  {
    print "$errstr, $pair_no: Pair gender mismatch\n";
    print "Restriction $pair_restriction\n";
    print "Profile ",
      $self->{$pair_restriction}[$pair_no]->str_gender(), "\n";
    print $self->{$pair_restriction}[$pair_no]->str($players_ref), 
      "\n";
  }
}


sub check_non_uniques
{
  my ($self, $players, $errstr) = @_;

  my $str = '';
  for my $ebl (sort keys %{$self->{_players}})
  {
    my $num = $#{$self->{_players}{$ebl}};
    if ($num >= 1)
    {
      $str .= $ebl . ", " . $players->id_to_name($ebl) .
        " (" . ($num+1) . " occurrences)\n";
    }
  }

  if ($str ne '')
  {
    print "$errstr:\n$str\n";
  }
}


sub check_against_name_data
{
  my ($self, $name_data_ref, $players, $errstr) = @_;

  for my $name_pair_no (0 .. $#{$name_data_ref->{pairs}})
  {
    my $active = 0;
    my $minus_ones = 0; # Only one player of a pair may be given
    my %tourn_pairs;

    for my $ebl (@{$name_data_ref->{pairs}[$name_pair_no]})
    {
      if ($ebl == -1)
      {
        $minus_ones++;
        next;
      }

      $active++;
      if (defined $self->{_players}{$ebl})
      {
        for my $tourn_pair_no (@{$self->{_players}{$ebl}})
        {
          $tourn_pairs{$tourn_pair_no}++;
        }
      }
      else
      {
        print "$errstr, pair number $name_pair_no:\n";
        print "Player ", $players->id_to_name($ebl),
          " (EBL $ebl) missing from tournament\n\n";
        next;
      }
    }

    if ($minus_ones >= 2)
    {
      print "$errstr, pair number $name_pair_no:\n";
      print "Both players missing\n\n";
      next;
    }

    my $num = 0;
    my $tourn_hit;
    for my $tourn_pair_no (sort keys %tourn_pairs)
    {
      if ($tourn_pairs{$tourn_pair_no} == $active)
      {
        $num++;
        $tourn_hit = $tourn_pair_no;
      }
    }

    next if $num == 1;
    if ($num == 0)
    {
      print "$errstr, pair number $name_pair_no:\n";
      print "No pair covers all player data\n";
    }
    else
    {
      print "$errstr, pair number $name_pair_no:\n";
      print "$num pairs cover all player data\n";
    }

    print $self->str_ebl_pair(
      $name_data_ref->{pairs}[$name_pair_no],
      $players);
  }
}


sub str_ebl_pair
{
  my ($self, $ebl_list_ref, $players) = @_;

  my $str = '';
  for my $ebl (@$ebl_list_ref)
  {
    if ($ebl == -1)
    {
      $str .= "  (missing)\n";
    }
    else
    {
      $str .= "  $ebl, " . $players->id_to_name($ebl) . "\n";
    }
  }
  $str .= "\n";
}


1;
