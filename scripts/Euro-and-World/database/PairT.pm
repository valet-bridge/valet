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
  my $pair_no = $#{$self->{$pair_restriction}};

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    $self->{$pair_restriction}[$pair_no]->add_key_value(
      $key, $chunk_ref->{$key});
  }

  $self->{$pair_restriction}[$pair_no]->check_basics(
    $players_ref, "$errstr, $pair_no");

  $self->{$pair_restriction}[$pair_no]->fill_player_map(
    \%{$self->{_players}}, $pair_restriction, $pair_no);
  
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
    for my $restriction (keys %{$self->{_players}{$ebl}})
    {
      my $num = $#{$self->{_players}{$ebl}{$restriction}};
      if ($num >= 1)
      {
        $str .= $ebl . ", " . $players->id_to_name($ebl) .
          " (" . ($num+1) . " occurrences in $restriction)\n";
      }
    }
  }

  if ($str ne '')
  {
    print "$errstr:\n$str\n";
  }
}


sub make_pairs_histo
{
  my ($self, $name_pair_ref, $players, 
    $tourn_pairs_ref, $active_ref, $errstr) = @_; 

  # Only one player of a pair may be given.
  # But if both should be missing, we return 0.
  my $minus_ones = 0; 

  $$active_ref = 0;

  for my $ebl (@$name_pair_ref)
  {
    if ($ebl == -1)
    {
      $minus_ones++;
      next;
    }
    $$active_ref++;

    my $hit = 0;
    for my $restriction (keys %{$self->{_players}{$ebl}})
    {
      $hit++;
      for my $tourn_pair_no (@{$self->{_players}{$ebl}{$restriction}})
      {
        $tourn_pairs_ref->{$restriction}{$tourn_pair_no}++;
      }
    }

    if (! $hit)
    {
      print "$errstr: Player ", $players->id_to_name($ebl),
        " (EBL $ebl) missing from tournament\n\n";
    }
  }

  return ($minus_ones < 2);
}


sub check_against_name_data
{
  my ($self, $name_data_ref, $players, $errstr) = @_;

  for my $name_pair_no (0 .. $#{$name_data_ref->{pairs}})
  {
    my $active = 0;
    my %tourn_pairs;

    if (! $self->make_pairs_histo(
      \@{$name_data_ref->{pairs}[$name_pair_no]},
      $players, \%tourn_pairs, \$active, $errstr))
    {
      print "$errstr, pair number $name_pair_no:\n";
      print "Both players missing\n\n";
      next;
    }

    my %num_by_restriction;
    my $highest = 0;

    for my $restriction (keys %tourn_pairs)
    {
      for my $tourn_pair_no (sort keys %{$tourn_pairs{$restriction}})
      {
        if ($tourn_pairs{$restriction}{$tourn_pair_no} == $active)
        {
          $num_by_restriction{$restriction}++;
          if ($num_by_restriction{$restriction} > $highest)
          {
            $highest = $num_by_restriction{$restriction};
          }
        }
      }
    }

    next if $highest == 1;

    print "$errstr, pair number $name_pair_no:\n";
    print $highest == 0 ?
      "No pair covers all player data in any restriction\n" :
      "$highest pairs cover all player data in some restriction\n";

    print $self->str_ebl_pair(
      $name_data_ref->{pairs}[$name_pair_no],
      $players);

    if ($highest > 1)
    {
      for my $restriction (keys %num_by_restriction)
      {
        if ($num_by_restriction{$restriction} > 1)
        {
          print "$restriction: ", $num_by_restriction{$restriction},
            " times\n";
        }
      }
    }
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
