#!perl

package Pair;

use strict;
use warnings;
use Exporter;
use v5.10;

use Players;
use Util;

use constant
{
  GENDER_OPEN => 1,
  GENDER_WOMEN => 2,
  GENDER_MIXED => 4,
  GENDER_UNKNOWN => 8
};


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub add_key_value
{
  my ($self, $key, $value) = @_;

  if ($key =~ /^PLAYER(\d)$/)
  {
    my ($pcount, $pname) = ($1, $value);
    $pname =~ tr/\xA0/ /;
    $pname =~ s/\s+/ /g;

    # Put the name into the standard format.
    $pname = Util::reverse_name($pname);

    $self->{players}[$pcount]{name} = $pname;
  }
  elsif ($key =~ /^ID(\d)$/)
  {
    my ($pcount, $pid) = ($1, $value);
    $self->{players}[$pcount]{id} = $pid;
  }
  elsif ($key =~ /^COUNTRY(\d)$/)
  {
    my ($pcount, $country) = ($1, $value);
    $self->{players}[$pcount]{country} = $country;
  }
  else
  {
    die "Unknown key $key";
  }
}


sub check_basics
{
  my ($self, $players, $errstr) = @_;

  my $active = 0;
  for my $pentry (@{$self->{players}})
  {
    next unless defined $pentry;
    $active++;

    if (! defined $pentry->{name} || ! defined $pentry->{id})
    {
      die "$errstr: Team player lacks at least one of name and ID";
    }

    my $name = $pentry->{name};
    if (! $players->has_name($name))
    {
      die "$errstr: " .
        "Player $name does not match a name in the player list";
    }

    my $id = $players->name_to_id($name);
    if ($id != $pentry->{id})
    {
      die "$errstr: Player $name, ID $id does not match $pentry->{id}";
    }

    next unless defined $pentry->{country};
    my $c = $pentry->{country};

    if ($c ne '-' && ! $players->player_has_country($pentry->{id}, $c))
    {
      die "$errstr: Player $name, ID $id: Country $c does not match";
    }
  }

  if ($active < 1 || $active > 2)
  {
    print "$errstr: $active players in pair\n";
  }
}


sub make_gender_histogram
{
  my ($self, $players, $histo_ref) = @_;

  $histo_ref->{$_} = 0 for qw(M F ?);

  for my $pentry (@{$self->{players}})
  {
    next unless defined $pentry;
    $histo_ref->{$players->id_to_gender($pentry->{id})}++;
  }
}


sub fill_player_map
{
  my ($self, $player_map_ref, $restriction, $pair_no) = @_;

  for my $pentry (@{$self->{players}})
  {
    # There can be multiple teams for one player if the event
    # combined several series into one web page.
    next unless defined $pentry;
    push @{$player_map_ref->{$pentry->{id}}{$restriction}}, $pair_no;
  }
}


sub analyze_gender
{
  my ($self, $players, $errstr) = @_;

  my %gender_histo;
  $self->make_gender_histogram($players, \%gender_histo);

  $self->{possible_gender} = GENDER_OPEN;

  if ($gender_histo{M} == 0)
  {
    $self->{possible_gender} |= GENDER_WOMEN;
  }
  elsif ($gender_histo{M} == 1 && $gender_histo{F} == 1)
  {
    $self->{possible_gender} |= GENDER_MIXED;
  }

  if ($gender_histo{'?'} > 0)
  {
    $self->{possible_gender} |= GENDER_UNKNOWN;
  }
}


sub check_gender
{
  my ($self, $team_restriction) = @_;

  # Bit of a kludge to put both restrictions into a string
  my @a = split '-', $team_restriction;
  die "$team_restriction not recognized" unless $#a == 2;
  my $gender_restriction = $a[0];

  if ($gender_restriction eq 'Open' ||
      $gender_restriction eq 'None')
  {
    return 1;
  }
  elsif ($gender_restriction eq 'Women')
  {
    return (($self->{possible_gender} & GENDER_WOMEN) ? 1 : 0);
  }
  elsif ($gender_restriction eq 'Mixed')
  {
    return (($self->{possible_gender} & GENDER_MIXED) ? 1 : 0);
  }
  else
  {
    die "$gender_restriction not recognized";
  }
}


sub size
{
  my ($self) = @_;

  my $c = 0;
  for my $pentry (@{$self->{players}})
  {
    $c++ if defined $pentry;
  }
  return $c;
}



sub str
{
  my ($self, $players) = @_;
  my $str = '';
  for my $pentry (@{$self->{players}})
  {
    next unless defined $pentry;
    $str .= sprintf("%s %5d  %s\n",
      $players->id_to_gender($pentry->{id}),
      $pentry->{id},
      $pentry->{name});
  }
  return $str;
}


sub str_gender
{
  my ($self) = @_;
  my $str = '';
  $str .= 'O' if $self->{possible_gender} & GENDER_OPEN;
  $str .= 'W' if $self->{possible_gender} & GENDER_WOMEN;
  $str .= 'M' if $self->{possible_gender} & GENDER_MIXED;
  $str .= '?' if $self->{possible_gender} & GENDER_UNKNOWN;
  return $str;
}

1;
