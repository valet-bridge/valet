#!perl

package Allies;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';
use Players;

# In a team, the allies are the team mates.
# In a pair, it is partner.

sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub set_by_list
{
  my ($self, $list_ref, $restriction, $team_name, $skip_index) = @_;
  $self->{restriction} = $restriction;
  $self->{team_name} = $team_name;

  for my $i (0 .. $#$list_ref)
  {
    next if $i == $skip_index;
    push @{$self->{ebl_list}}, $list_ref->[$i];
  }
}


sub str
{
  my ($self, $players) = @_;

  if ($#{$self->{ebl_list}} == -1)
  {
    return $self->{restriction} . '|N/A';
  }
  else
  {
    return $self->{restriction} . '|' .
      join(', ', map { $players->id_to_name($_) } @{$self->{ebl_list}});
  }
}


1;
