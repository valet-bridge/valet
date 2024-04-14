#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tokenize;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  parse_teams
  unteam
);

use lib '.';
use lib '..';
use Cookbook;
use Token;
use Separators;


sub clean_team
{
  my $team = pop;
  $team =~ s/\s*\(\d+\)\s*$//; # (69)
  $team =~ s/^\s+|\s+$//g; # Leading and trailing space

  my $fix = $FIX_HASH{lc($team)};
  if (defined $fix && $fix->{CATEGORY} eq 'COUNTRY')
  {
    return $fix->{VALUE};
  }
  else
  {
    return $team;
  }
}


sub parse_teams
{
  my ($text, $cref) = @_;

  $text =~ s/\- npc//g;
  $text =~ s/\(npc\)//g;

  if ($text =~ /(.*) vs\. (.*)/)
  {
    my ($team1, $team2) = ($1, $2);
    $cref->{TEAM1} = clean_team($team1);
    $cref->{TEAM2} = clean_team($team2);
  }
  elsif ($text =~ /^\s*$/ || $text =~ /^\s*vs\.\s*$/)
  {
    $cref->{TEAM1} = '';
    $cref->{TEAM2} = '';
  }
  else
  {
    die "Can't parse team line $text\n";
  }
}


sub unteam
{
  my ($text, $team1, $team2) = @_;

  my $res = $text;
  $res =~ s/\Q$team1\E// if defined $team1 && length($team1) > 1;
  $res =~ s/\Q$team2\E// if defined $team2 && length($team2) > 1;
  return $res;
}


1;
