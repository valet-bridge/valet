#!perl

package Indiv;

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
  GENDER_MIXED => 2,
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

  if ($key =~ /^PLAYER$/)
  {
    my $pname = $value;
    $pname =~ tr/\xA0/ /;
    $pname =~ s/\s+/ /g;

    # Put the name into the standard format.
    $pname = Util::reverse_name($pname);

    $self->{name} = $pname;
  }
  elsif ($key =~ /^ID$/)
  {
    $self->{id} = $value;
  }
  elsif ($key =~ /^COUNTRY$/)
  {
    $self->{country} = $value;
  }
  else
  {
    die "Unknown key $key";
  }
}


sub check_basics
{
  my ($self, $players, $errstr) = @_;

  die "$errstr: Individual lacks ID" unless defined $self->{id};
  die "$errstr: Individual lacks name" unless defined $self->{name};

  my $name = $self->{name};
  if (! $players->has_name($name))
  {
    die "$errstr: " .
      "Individual $name does not match a name in the player list";
  }

  my $id = $players->name_to_id($name);
  if ($id != $self->{id})
  {
    die "$errstr: Player $name, ID $id does not match $self->{id}";
  }

  next unless defined $self->{country};
  my $c = $self->{country};

  if ($c ne '-' && ! $players->player_has_country($self->{id}, $c))
  {
    die "$errstr: Individual $name, ID $id: Country $c does not match";
  }
}


sub fill_player_map
{
  my ($self, $player_map_ref, $restriction, $indiv_no) = @_;

  return unless defined $self->{id};
  push @{$player_map_ref->{$self->{id}}{$restriction}}, $indiv_no;
}


sub analyze_gender
{
  my ($self, $players, $errstr) = @_;

  my $gender = $players->id_to_gender($self->{id});

  if ($gender eq 'M')
  {
    $self->{possible_gender} = GENDER_OPEN;
  }
  elsif ($gender eq 'F')
  {
    $self->{possible_gender} = GENDER_OPEN | GENDER_WOMEN;
  }
  elsif ($gender eq '?')
  {
    $self->{possible_gender} = GENDER_OPEN | GENDER_WOMEN | GENDER_UNKNOWN;
  }
  else
  {
    die "$errstr: Unknown gender $gender";
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
  else
  {
    die "Individual $gender_restriction not recognized";
  }
}


sub str
{
  my ($self, $players) = @_;
  my $str = sprintf("%s %5d  %s\n",
      $players->id_to_gender($self->{id}),
      $self->{id},
      $self->{name});
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
