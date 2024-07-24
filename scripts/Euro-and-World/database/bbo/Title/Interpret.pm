#!perl

package Title::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret deteam);

use lib './Connections';

use Connections::Matrix;
use Title::Tmatch;
use Util;

my @ACCEPT_FIELDS = qw(AGE CITY CLUB COUNTRY DATE DATE_START DATE_END
  DAY FORM FLIGHT GENDER GROUP LOCALITY MATCH MEET MONTH MOVEMENT 
  NATIONALITY ORGANIZATION ORIGIN PERSON QUARTER REGION SCORING SECTION 
  SEGMENT SERIES SESSION SPONSOR STAGE STANZA TIME TNAME TWORD 
  UNIVERSITY WEEK WEEKDAY WEEKEND YEAR ZONE);

my @KILL_FIELDS = qw(ROOM);

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;
my %KILL = map { $_ => 1 } @KILL_FIELDS;


# BBOVG numbers for which special occurrences are OK.
my %TITLE_MATCHES_ROUND;
my %TITLE_MATCHES_SCORING;
my %TITLE_MATCHES_INTUIT;

sub init_hashes
{
  Title::Tmatch::set_tmatch_round(\%TITLE_MATCHES_ROUND);
  Title::Tmatch::set_tmatch_scoring(\%TITLE_MATCHES_SCORING);
  Title::Tmatch::set_tmatch_intuit(\%TITLE_MATCHES_INTUIT);
}


sub post_process_single
{
  my ($chains, $scoring, $bbono) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if ($field0 eq 'ROUND' &&
      exists $TITLE_MATCHES_ROUND{$bbono})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($field0 eq 'SCORING')
    {
      my $full = $token0->value();
      my $short = scoring_full_to_short($full);
      if ($short ne $$scoring)
      {
        if (exists $TITLE_MATCHES_SCORING{$bbono})
        {
          $$scoring = $short;
        }
        elsif (! exists $TITLE_MATCHES_INTUIT{$bbono})
        {
          warn "$bbono: Got $full -> $short, expected $$scoring";
        }
      }

      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif (exists $ACCEPT{$field0})
    {
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif (exists $KILL{$field0})
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


# Fields that appear in title teams.

my %TEAM_FIELDS = 
(
  AGE => 1,
  CAPTAIN => 1,
  CITY => 1,
  COUNTRY => 1,
  GENDER => 1,
  REGION => 1,
  SPONSOR => 1
);


sub field_found_in
{
  my ($value, $field, $list) = @_;

  return 0 unless exists $list->{$field};
  for my $entry (@{$list->{$field}})
  {
    return 1 if $value eq lc($entry);
  }
  return 0;
}


sub post_process_title_teams
{
  my ($chains, $teams, $bbono) = @_;

  my %matches = (TEAM1 => 0, TEAM2 => 0);
  my %counts = (TEAM1 => 0, TEAM2 => 0);
  my $captain_no = 1;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED' || $chain->status() eq 'EXPLAINED';

    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      my $field = $token->field();
      if ($field =~ /^(TEAM\d)_(.*)$/)
      {
        my ($team, $main) = ($1, $2);
        $counts{$team}++;
        for my $t (qw(TEAM1 TEAM2))
        {
          $matches{$t}++ if 
            field_found_in(lc($token->value()), $main, $teams->{$t});
        }
      }
      elsif ($field eq 'CAPTAIN')
      {
        $counts{'TEAM' . $captain_no}++;
        $captain_no++;
        for my $t (qw(TEAM1 TEAM2))
        {
          $matches{$t}++ if 
            field_found_in(lc($token->value()), 'CAPTAIN', $teams->{$t});
        }
      }
    }
  }

  return unless $counts{TEAM1} > 0 || $counts{TEAM2} > 0;

  # Something like 'Open' can occur multiple times.
  if (($matches{TEAM1} >= $counts{TEAM1} &&
       $matches{TEAM2} >= $counts{TEAM2})  ||
      ($matches{TEAM1} >= $counts{TEAM2} &&
       $matches{TEAM2} >= $counts{TEAM1}))
  {
    # Perfect matches.
    for my $chain (@$chains)
    {
      next if $chain->status() eq 'KILLED' || 
        $chain->status() eq 'EXPLAINED';

      my $token = $chain->check_out(0);
      my $field = $token->field();
      next unless $field =~ /^(TEAM\d)_(.*)$/ || $field eq 'CAPTAIN';

      $chain->complete_if_last_is($chain->last(), 'KILLED');
    }
  }
}


sub post_process_captains
{
  my ($chains, $teams, $bbono) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED' || $chain->status() eq 'EXPLAINED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    if ($token->field() eq 'CAPTAIN')
    {
      my $value = $token->value();
      if ($value eq 'Angelini' || $value eq 'Assael' ||
          $value eq 'Carlos Ferreira' || $value eq 'Evgueni Gladysh' ||
          $value eq 'Prashant Desai' || $value eq 'Rui Pinto')
      {
        $token->set_general('SINGLETON', 'PERSON', $value);
        $chain->complete_if_last_is($chain->last(), 'EXPLAINED');
      }
    }
  }
}


sub interpret
{
  my ($whole, $chains, $scoring, $bbono) = @_;

  post_process_single($chains, $scoring, $bbono);
}


sub deteam
{
  my ($chains, $teams, $bbono) = @_;

  post_process_title_teams($chains, $teams, $bbono);
  post_process_captains($chains, $bbono);
}

1;
