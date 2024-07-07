#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Clean;

our @ISA = qw(Exporter);
our @EXPORT = qw(clean_teams);


sub fix_some_parentheses
{
  my ($whole, $team_ref) = @_;

  return unless $$team_ref =~ /\((.*)\)/;
  my $t = $1;

  my $fix = $whole->get_single('AGE', lc($t));
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  $fix = $whole->get_single('GENDER', lc($t));
  if (defined $fix->{CATEGORY})
  {
    $$team_ref =~ s/\($t\)/($fix->{VALUE})/;
    return;
  }

  if ($t eq 'O')
  {
    $$team_ref = 'Open';
  }
  elsif ($t eq 'W')
  {
    $$team_ref = 'Women';
  }
  elsif ($t eq 'S')
  {
    $$team_ref = 'Seniors';
  }
  elsif ($t eq 'L')
  {
    $$team_ref = 'Ladies';
  }
  elsif ($t eq 'J')
  {
    $$team_ref = 'Juniors';
  }
}


sub clean_team
{
  my ($whole, $team) = @_;
  $team =~ s/\(\d+\)\s*$//; # (69)
  $team =~ s/^\s+|\s+$//g; # Leading and trailing space

  # Fix some parentheses with age and gender.
  fix_some_parentheses($whole, \$team);

  # my $fix = $FIX_HASH{lc($team)};
  my $fix = $whole->get_single('COUNTRY', lc($team));
  # if (defined $fix && $fix->{CATEGORY} eq 'COUNTRY')
  if (exists $fix->{VALUE})
  {
    return $fix->{VALUE};
  }
  elsif ($team =~ /^\s*$/)
  {
    return '';
  }
  else
  {
    return $team;
  }
}


sub clean_teams
{
  my ($whole, $text, $result) = @_;

  return unless defined $text;
  if ($text =~ /(.*) vs\. (.*)/)
  {
    ($result->{TEAM1}, $result->{TEAM2}) = ($1, $2);
    $result->{TEAM1} = clean_team($whole, $result->{TEAM1});
    $result->{TEAM2} = clean_team($whole, $result->{TEAM2});

    # Kludge for event matches.
    $result->{TEAM1} =~ s/\s*- npc$//;
    $result->{TEAM2} =~ s/\s*- npc$//;
  }
  elsif ($text =~ /^\s*$/ || $text =~ /^\s*vs\.\s*$/)
  {
    $result->{TEAM1} = '';
    $result->{TEAM2} = '';
    return;
  }
  else
  {
    die "Can't parse team line $text\n";
  }
}

1;
