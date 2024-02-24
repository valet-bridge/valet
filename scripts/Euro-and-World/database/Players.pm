#!perl

package Players;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';
use Player;

sub new
{
  return bless {}, shift;
}


sub add
{
  my ($self, $id, $record_ref) = @_;

  if (defined $self->{players}[$id])
  {
    die "Players: Attempting to set player $id again";
  }

  $self->{players}[$id] = Player->new();
  my $p = $self->{players}[$id];

  for my $field (keys %$record_ref)
  {
    for my $value (@{$record_ref->{$field}})
    {
      $p->set_field($field, $value);
    }
  }

  $p->expand_name_hash(\%{$self->{names}}, $id);
}


sub has_name
{
  my ($self, $name) = @_;

  return defined $self->{names}{$name} ? 1 : 0;
}


sub name_to_id
{
  my ($self, $name) = @_;

  if (! defined $self->{names}{$name})
  {
    die "Players: Can't find name $name";
  }

  return $self->{names}{$name};
}


sub id_to_name
{
  my ($self, $id) = @_;

  if (! defined $self->{players}[$id])
  {
    die "Players: ID $id not found";
  }
  return $self->{players}[$id]->name();
}


sub id_to_gender
{
  my ($self, $id) = @_;

  if (! defined $self->{players}[$id])
  {
    die "Players: ID $id not found";
  }
  return $self->{players}[$id]->gender();
}


sub player_has_country
{
  my ($self, $id, $cname) = @_;

  if (! defined $self->{players}[$id])
  {
    die "Players: Don't have ID $id";
  }

  return $self->{players}[$id]->has_country($cname);
}


sub check_names
{
  my ($self) = @_;

  for my $id (0 .. $#{$self->{players}})
  {
    next unless defined $self->{players}[$id];
    $self->{players}[$id]->check_names($id);
  }
}


sub str_ebl_list
{
  my ($self, $ebl_list_ref) = @_;

  my $str = '';
  for my $ebl (@$ebl_list_ref)
  {
    if ($ebl == -1)
    {
      $str .= "  (missing)\n";
    }
    else
    {
      $str .= "  $ebl, " . $self->id_to_name($ebl) . "\n";
    }
  }
  $str .= "\n";
  return $str;
}


sub str
{
  my ($self) = @_;

  my $str = '';

  for my $id (0 .. $#{$self->{players}})
  {
    next unless defined $self->{players}[$id];
    $str .= $self->{players}[$id]->str() . "\n";
  }
  return $str;
}


sub str_player_matrix
{
  my ($self, $tournament_headers_ref, $time_sorted_ref,
    $player_matrix_ref, $players) = @_;

  my $str = '';
  my @histo;

  for my $id (0 .. $#{$self->{players}})
  {
    next unless defined $self->{players}[$id];
    $str .= $self->{players}[$id]->str();

    my $entries = 0;
    for my $elem (@$time_sorted_ref)
    {
      my $tno = $elem->{id};
      next unless defined $player_matrix_ref->[$id]{$tno};

      for my $allies (@{$player_matrix_ref->[$id]{$tno}})
      {
        $str .= $tournament_headers_ref->[$tno]->str_line() . '|' .
          $allies->str($players) . "\n";
        $entries++;
      }
    }
    $str .= "\n";
    $histo[$entries]++;
  }

  # for my $entry (0 .. $#histo)
  # {
    # if (defined $histo[$entry])
    # {
      # $str .= sprintf("%3d %5d\n", $entry, $histo[$entry]);
    # }
  # }
  # $str .= "\n";
  return $str;
}


1;
