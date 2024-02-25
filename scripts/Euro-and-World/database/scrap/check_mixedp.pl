#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Read;

# Check the tournament with respect to mixed-pair tournaments.

die "perl check_mixedp.pl" unless $#ARGV == -1;

my $names_file = 'ebl.txt';
my $comb_file = 'combined.txt';
my $tourn_file = 'tournaments.txt';

my (@name_players, @name_tournaments);
read_names($names_file, \@name_players, \@name_tournaments);

my @combined_entries;
read_combined_structured($comb_file, \@combined_entries);

my @tournaments;
read_tournaments($tourn_file, \@tournaments);

for my $tno (1 .. $#tournaments)
{
  next unless defined $tournaments[$tno];
  next unless $tournaments[$tno]{RESTRICTION_GENDER} eq 'Mixed';
  next unless $tournaments[$tno]{FORM} =~ /Pair/;
  next unless defined $combined_entries[$tno];

  for my $pair (@{$combined_entries[$tno]})
  {
    next unless $pair;
    my $pcount = $#$pair;
    my $pstart;
    if ($pcount == 1 &&
        defined $pair->[0]{id} &&
        defined $pair->[1]{id})
    {
      $pstart = 0;
    }
    elsif ($pcount == 2 &&
        (! defined $pair->[0]{id}) &&
        defined $pair->[1]{id} &&
        defined $pair->[2]{id})
    {
      $pstart = 1;
    }
    else
    {
      print "Was expecting a pair\n";
      next;
    }

    my $id0 = $pair->[$pstart]{id};
    my $id1 = $pair->[$pstart+1]{id};

    if (! defined $name_players[$id0]{GENDER} ||
        ! defined $name_players[$id1]{GENDER})
    {
      print "$tno: At least one player with no gender\n";
    }

    my $gender0 = $name_players[$id0]{GENDER}[0];
    my $gender1 = $name_players[$id1]{GENDER}[0];

    if (($gender0 eq 'M' && $gender1 eq 'F') ||
        ($gender0 eq 'F' && $gender1 eq 'M'))
    {
      # All good
      next;
    }

    if ($gender0 eq 'M' && $gender1 eq 'M')
    {
      printf "$tno: Two male players\n";
    }
    elsif ($gender0 eq 'F' && $gender1 eq 'F')
    {
      printf "$tno: Two female players\n";
    }
    elsif (($gender0 eq 'M' && $gender1 eq '?') ||
           ($gender0 eq '?' && $gender1 eq 'M'))
    {
      printf "$tno: One male, one unknown\n";
    }
    elsif (($gender0 eq 'F' && $gender1 eq '?') ||
           ($gender0 eq '?' && $gender1 eq 'F'))
    {
      printf "$tno: One female, one unknown\n";
    }
    else
    {
      printf "$tno: Both genders unknown\n";
    }

    print $id0, ", ", $name_players[$id0]{GENDER}[0], ", ",
      $name_players[$id0]{NAME}[0], "\n";
    print $id1, ", ", $name_players[$id1]{GENDER}[0], ", ",
      $name_players[$id1]{NAME}[0], "\n\n";
  }
}


