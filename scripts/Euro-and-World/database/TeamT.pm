#!perl

package TeamT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Team;
use Players;
use Util;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub get_team_restriction
{
  my ($self, $tourn_header, $chunk_restriction, $errstr) = @_;

  my $unit_restriction = (defined $chunk_restriction ?
    $chunk_restriction : 'Open');

  my $team_gender_restriction = $tourn_header->restrict_gender(
    $unit_restriction, $errstr);
    
  my $team_age_restriction = $tourn_header->restrict_age(
    $unit_restriction, $errstr);

  my $team_restriction = $team_gender_restriction . '-' .
    $team_age_restriction;
}


sub add_from_chunk
{
  my ($self, $tourn_header, $chunk_ref, $players_ref, $errstr) = @_;

  die "Team has no name" unless defined $chunk_ref->{NAME};
  my $team_name = $chunk_ref->{NAME};

  my $team_restriction = $self->get_team_restriction(
    $tourn_header, $chunk_ref->{RESTRICTION}, $errstr);
    
  die "Name already seen" 
    if defined $self->{$team_restriction}{$team_name};

  $self->{$team_restriction}{$team_name} = Team->new();

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    $self->{$team_restriction}{$team_name}->add_key_value(
      $key, $chunk_ref->{$key});
  }

  $self->{$team_restriction}{$team_name}->check_basics(
    $players_ref, "$errstr, $team_name");

  $self->{$team_restriction}{$team_name}->fill_player_map(
    \%{$self->{_players}}, $team_name);
}


sub check_gender
{
  my ($self, $team_restriction, $team_ref, 
    $players, $team_name, $errstr) = @_;

  # In loop can count M, F, ?
  # Store the 1D count in self
  # Check no ?, output if so
  # Check balanced counts if mixed, output if not
  # I guess a team can be all-male, all-female, mixed-OK or
  # mixed-confusing, or have question marks
  # Some kind of string function that makes a nice stats line
}


sub check_against_name_data
{
  my ($self, $name_data_ref, $errstr) = @_;

  for my $team_name (sort keys %$name_data_ref)
  {
    my $active = 0;
    my %tourn_teams;

    for my $ebl (@{$name_data_ref->{$team_name}})
    {
      $active++;
      if (defined $self->{_players}{$ebl})
      {
        for my $team_name (@{$self->{_players}{$ebl}})
        {
          $tourn_teams{$team_name}++;
        }
      }
      else
      {
        print "$errstr, $team_name: ",
          "Player ID $ebl missing from tournament\n";
        next;
      }
    }

    my $num = 0;
    my $tourn_hit;
    for my $tourn_team_name (sort keys %tourn_teams)
    {
      if ($tourn_teams{$tourn_team_name} == $active &&
          $self->team_name_compatible($team_name, $tourn_team_name))
      {
        $num++;
        $tourn_hit = $tourn_team_name;
      }
    }

    if ($num == 0)
    {
      print "$errstr, $team_name: No valid team covers all player data\n";
      next;
    }

    if ($num > 1)
    {
      print "$errstr, $team_name: $num teams cover all player data\n";
      next;
    }
  }
}


sub team_name_compatible
{
  my ($self, $team_name, $tourn_hit) = @_;

  return 1 if $team_name eq $tourn_hit;

  for my $restriction (qw(OPEN MIXED WOMEN SENIORS
      JUNIORS YOUNGSTERS GIRLS RAND))
  {
    return 1 if "$team_name $restriction" eq $tourn_hit;
  }

  return 0;
}


1;
