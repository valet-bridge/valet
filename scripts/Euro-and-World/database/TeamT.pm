#!perl

package TeamT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Util;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub read_from_lines
{
  my ($self, $tourn_ref, $header_lines_ref, $team_lines_ref) = @_;

  die "Expected 3 header lines" unless $#$header_lines_ref == 2;

  die "Expected TITLE" unless 
    $header_lines_ref->[0] =~ /^TITLE (.*)/;
  $self->{title} = $1;

  die "Expected ID" unless 
    $header_lines_ref->[1] =~ /^ID (\d+)/;
  $self->{id} = $1;

  die "Expected DETAILS" unless 
    $header_lines_ref->[2] =~ /^DETAILS (\d+)/;
  $self->{details} = $1;

  $self->check_header($tourn_ref);

  # TODO Receive the tournament data
  # Check title, details (parse these) against it
  # Get the tournament-level restrictions
  # Check team-level restrictions against it

  my $team_name = '';
  my $team_restriction = '';

  for my $line (@$team_lines_ref)
  {
    if ($line =~ /^NAME (.*)/)
    {
      $team_name = $1;
      die "Tournament $self->{id}: Team $team_name already seen"
        if defined $self->{$team_name};
    }
    elsif ($line =~ /^RESTRICTION (.*)/)
    {
      $self->{restrictions}{$team_name} = $1;
    }
    elsif ($line =~ /^PLAYER(\d) (.*)/)
    {
      my ($pcount, $pname) = ($1, $2);
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
      $pname = reverse_name($pname);

      $self->{teams}{$team_name}[$pcount]{name} = $pname;
      $self->{teams}{$team_name}[$pcount]{country} = $country
        unless $country eq '';
    }
    elsif ($line =~ /^ID(\d) (.*)/)
    {
      my ($pcount, $pid) = ($1, $2);
      $self->{teams}{$team_name}[$pcount]{id} = $pid;
    }
    elsif ($line =~ /^COUNTRY(\d) (.*)/)
    {
      my ($pcount, $country) = ($1, $2);
      $self->{teams}{$team_name}[$pcount]{country} = $country;
    }
    elsif ($line =~ /^FUNCTION(\d) (.*)/)
    {
      # We actually ignore this, as all the entries are players.
      my $fnc = $2;
      $fnc =~ s/^\s+|\s+$//;
      die "ID $self->{id}: Unknown function $fnc" unless
        ($fnc eq 'player' || lc($fnc) eq 'pc');
    }
    elsif ($line !~ /^\s*$/)
    {
      die "Unknown line $line";
    }
  }
}


sub check_header
{
  my ($self, $tourn_ref) = @_;

  die $self->flag_error($tourn_ref) unless 
    defined $tourn_ref->[$self->{id}];

  die $self->flag_error($tourn_ref) unless 
    $self->{title} eq $tourn_ref->[$self->{id}]{TITLE};
    
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
  }
}

1;
