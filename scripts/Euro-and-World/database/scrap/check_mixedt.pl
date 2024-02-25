#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Read;

# Check the tournament with respect to mixed-teams tournaments.

die "perl check_mixedt.pl" unless $#ARGV == -1;

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
  next unless $tournaments[$tno]{FORM} =~ /Team/;
  next unless defined $combined_entries[$tno];

  for my $team (@{$combined_entries[$tno]})
  {
    next unless $team;
    my $tcount = $#$team;
    my $tstart = (defined $team->[0]{id} ? 0 : 1);

    my $count_M = 0;
    my $count_F = 0;
    my $count_Q = 0;

    for my $pno ($tstart .. $tcount)
    {
      my $no = $team->[$pno]{id};
      my $gender = $name_players[$no]{GENDER}[0];

      if (! defined $gender)
      {
        print "HERE\n";
      }
      if ($gender eq 'M')
      {
        $count_M++;
      }
      elsif ($gender eq 'F')
      {
        $count_F++;
      }
      else
      {
        $count_Q++;
      }
    }

    my $number = $tcount - $tstart + 1;

    if ($number == 2 || $number == 4 || $number == 6)
    {
      if (2 * $count_M != $number || 2 * $count_F != $number)
      {
        print "$tno: Unbalanced team:\n";
        for my $i ($tstart .. $tcount)
        {
          my $id = $team->[$i]{id};
          print "$id, ", $name_players[$id]{GENDER}[0], ", ",
            $name_players[$id]{NAME}[0], "\n";
        }
        print "\n";
      }
    }
    else
    {
      # print "$tno: Team size $number?\n";
    }
  }
}


