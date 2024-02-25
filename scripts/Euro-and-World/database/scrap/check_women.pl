#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Read;

# Check the tournament with respect to all-women entrants.

die "perl check_women.pl" unless $#ARGV == -1;

my $names_file = 'ebl.txt';
my $comb_file = 'combined.txt';
my $tourn_file = 'tournaments.txt';

my (@name_players, @name_tournaments);
read_names($names_file, \@name_players, \@name_tournaments);

my @combined_entries;
read_combined($comb_file, \@combined_entries);

my @tournaments;
read_tournaments($tourn_file, \@tournaments);

for my $tno (1 .. $#tournaments)
{
  next unless defined $tournaments[$tno];
  next unless $tournaments[$tno]{RESTRICTION_GENDER} eq 'Women';

  my $gender_M = 0;
  my $gender_F = 0;
  my $gender_Q = 0;

  if (defined $name_tournaments[$tno])
  {
    for my $pno (@{$name_tournaments[$tno]})
    {
      my $gender = $name_players[$pno]{GENDER}[0];
      if ($gender eq 'M')
      {
        $gender_M++;
        print "Player $pno is listed as male  ",
          $name_players[$pno]{NAME}[0], "\n";
      }
      elsif ($gender eq 'F')
      {
        $gender_F++;
      }
      else
      {
        $gender_Q++;
        print "Player $pno is listed as ?  ",
          $name_players[$pno]{NAME}[0], "\n";
      }
    }

    if ($gender_M > 0 || $gender_Q > 0)
    {
      print "Name data $tno\n";
      print "--------------\n\n";

      printf("M %4d\n", $gender_M);
      printf("F %4d\n", $gender_F);
      printf("Q %4d\n", $gender_Q);
    }

    $gender_M = 0;
    $gender_F = 0;
    $gender_Q = 0;
  }

  if (defined $combined_entries[$tno])
  {
    for my $pno (@{$combined_entries[$tno]})
    {
      if (! defined $name_players[$pno])
      {
        print "Player $pno undefined\n";
        next;
      }

      if (! defined $name_players[$pno]{GENDER})
      {
        print "HERE\n";
      }

      my $gender = $name_players[$pno]{GENDER}[0];
      if ($gender eq 'M')
      {
        $gender_M++;
        print "Player $pno is listed as male  ",
          $name_players[$pno]{NAME}[0], "\n";
      }
      elsif ($gender eq 'F')
      {
        $gender_F++;
      }
      else
      {
        $gender_Q++;
        print "Player $pno is listed as ?  ",
          $name_players[$pno]{NAME}[0], "\n";
      }
    }

    if ($gender_M > 0 || $gender_Q > 0)
    {
      print "Tournament data $tno\n";
      print "--------------\n\n";

      printf("M %4d\n", $gender_M);
      printf("F %4d\n", $gender_F);
      printf("Q %4d\n", $gender_Q);
    }
  }
}


