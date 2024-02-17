#!perl

package Team;

use strict;
use warnings;
use Exporter;
use v5.10;

use Players;
use Util;


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
    my $country = '';

    if ($pname =~ /^(.*)\s+\((.*)\)\s*$/)
    {
      # Might be First LAST (Country)
      ($pname, $country) = ($1, $2);
      $self->guess_correct(\$pname, \$country);
    }

    # Put the name into the standard format.
    $pname = Util::reverse_name($pname);

    $self->{players}[$pcount]{name} = $pname;
    $self->{players}[$pcount]{country} = $country unless $country eq '';
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
  elsif ($key =~ /^FUNCTION(\d)$/)
  {
    # We actually ignore this, as all the entries are players.
    my $fnc = $value;
    $fnc =~ s/^\s+|\s+$//;
    die "ID $self->{id}: Unknown function $fnc" unless
      ($fnc eq 'player' || lc($fnc) eq 'pc');
  }
  else
  {
    die "Unknown key $key";
  }
}


sub guess_correct
{
  my ($self, $pname_ref, $country_ref) = @_;

  if ($$country_ref eq 'SOBEL' || $$country_ref eq 'DE')
  {
    # Mega kludge, but WBF uses this format both for some married
    # names and for countries.
    $$country_ref = '';
  }
  elsif ($$country_ref =~ /^\d$/)
  {
    # Could also be of the form (1), which is not really a country,
    # so add it back on.
    $$pname_ref = $$pname_ref . " ($$country_ref)";
    $$country_ref = '';
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

  if ($active == 0 || $active > 8)
  {
    print "$errstr: $active players on team\n";
  }
}


sub check_gender
{
  my ($self, $team_restriction, $team_ref, 
    $players, $team_name, $errstr) = @_;

  # Analyze_gender
  # Can loop over $self->{players}
  #   fill $self->{gender}{M, F, ?}, ++
  #
  # Consistent with
  #   Women: No M
  #   Mixed: |M-F| <= 1 and min(M,F) >= 1
  #
  # Check no ?, output if so
  # Check balanced counts if mixed, output if not
  # I guess a team can be all-male, all-female, mixed-OK or
  # mixed-confusing, or have question marks
  # Some kind of string function that makes a nice stats line
}


sub fill_player_map
{
  my ($self, $player_map_ref, $team_name) = @_;

  for my $pentry (@{$self->{players}})
  {
    # There can be multiple teams for one player if the event
    # combined several series into one web page.
    next unless defined $pentry;
    push @{$player_map_ref->{$pentry->{id}}}, $team_name;
  }
}

1;
