#!perl

package TeamT;

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


sub add_from_chunk
{
  my ($self, $chunk_ref, $players_ref, $errstr) = @_;

  die "Team has no name" unless defined $chunk_ref->{NAME};
  my $team_name = $chunk_ref->{NAME};

  my $team_restriction = (defined $chunk_ref->{RESTRICTION} ?
    $chunk_ref->{RESTRICTION} : 'Unstated');

  die "Name already seen" if defined $self->{$team_restriction}{$team_name};

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    if ($key =~ /^PLAYER(\d)$/)
    {
      my ($pcount, $pname) = ($1, $chunk_ref->{$key});
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

      $self->{$team_restriction}{$team_name}[$pcount]{name} = $pname;
      $self->{$team_restriction}{$team_name}[$pcount]{country} = $country
        unless $country eq '';
    }
    elsif ($key =~ /^ID(\d)$/)
    {
      my ($pcount, $pid) = ($1, $chunk_ref->{$key});
      $self->{$team_restriction}{$team_name}[$pcount]{id} = $pid;
    }
    elsif ($key =~ /^COUNTRY(\d)$/)
    {
      my ($pcount, $country) = ($1, $chunk_ref->{$key});
      $self->{$team_restriction}{$team_name}[$pcount]{country} = $country;
    }
    elsif ($key =~ /^FUNCTION(\d)$/)
    {
      # We actually ignore this, as all the entries are players.
      my $fnc = $chunk_ref->{$key};
      $fnc =~ s/^\s+|\s+$//;
      die "ID $self->{id}: Unknown function $fnc" unless
        ($fnc eq 'player' || lc($fnc) eq 'pc');
    }
    else
    {
      die "Unknown key $key";
    }
  }

  $self->check_team(\@{$self->{$team_restriction}{$team_name}},
    $players_ref, $team_name, $errstr);
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


sub check_team
{
  my ($self, $team_ref, $players, $team_name, $errstr) = @_;

  my $active = 0;
  for my $pno (0 .. $#$team_ref)
  {
    next unless defined $team_ref->[$pno];
    $active++;

    if (! defined $team_ref->[$pno]{name} ||
        ! defined $team_ref->[$pno]{id})
    {
      die "$errstr, $team_name: " . 
        "Team player lacks at least one of name and ID";
    }

    my $name = $team_ref->[$pno]{name};
    if (! $players->has_name($name))
    {
      die "$errstr, $team_name: " .
        "Player $name does not match a name in the player list";
    }

    my $id = $players->name_to_id($name);
    if ($id != $team_ref->[$pno]{id})
    {
      die "$errstr, $team_name: " .
        "Player $name, ID $id does not match $team_ref->[$pno]{id}";
    }

    next unless defined $team_ref->[$pno]{country};
    my $c = $team_ref->[$pno]{country};

    if ($c ne '-' &&
        ! $players->player_has_country($team_ref->[$pno]{id}, $c))
    {
      die "$errstr, $team_name: " .
        "Player $name, ID $id: Country $c does not match";
    }
  }

  if ($active == 0 || $active > 8)
  {
    print "$errstr $team_name: $active players on team\n";
  }
}

1;
