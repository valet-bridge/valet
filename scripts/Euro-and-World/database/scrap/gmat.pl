#!perl

use strict;
use warnings;
use v5.10;

use lib '.';
use Read;

# Make some gender matrix statistics.

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

# For each player
#   Loop over name entries and over tournament entries
#   Count whether it is an O, W or M tournament
#   Note whether it is an M, F or ? player
# In the end, make a matrix
#
# For each tournament
#   Count the number of O, W and M players

my @player_counts;
my @tourn_counts;
my @tourn_gender;

for my $tno (1 .. $#tournaments)
{
  next unless defined $tournaments[$tno];
  $tourn_counts[$tno]{M} = 0;
  $tourn_counts[$tno]{F} = 0;
  $tourn_counts[$tno]{'?'} = 0;

  my $tgender;
  if ($tournaments[$tno]{RESTRICTION_GENDER} eq 'Open')
  {
    $tgender = 'Open';
  }
  elsif ($tournaments[$tno]{RESTRICTION_GENDER} eq 'Women')
  {
    $tgender = 'Women';
  }
  elsif ($tournaments[$tno]{RESTRICTION_GENDER} eq 'Mixed')
  {
    $tgender = 'Mixed';
  }
  elsif ($tournaments[$tno]{RESTRICTION_GENDER} eq 'Multiple')
  {
    $tgender = 'Open';
  }
  else
  {
    print "$tno: Tournament gender restriction unknown\n";
  }
  $tourn_gender[$tno] = $tgender;

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

      $player_counts[$pno]{$tgender}++;
      $tourn_counts[$tno]{$gender}++;
    }
  }

  # This will double-count a bunch of entries
  if (defined $name_tournaments[$tno])
  {
    for my $pno (@{$name_tournaments[$tno]})
    {
      my $gender = $name_players[$pno]{GENDER}[0];

      $player_counts[$pno]{$tgender}++;
      $tourn_counts[$tno]{$gender}++;
    }
  }
}

# Make player histogram

my %phist;
for my $profile (qw(OWM OW OM WM O W M none))
{
  for my $pl (qw(M F ?))
  {
    $phist{$profile}{$pl} = 0;
  }
}

for my $pno (1 .. $#player_counts)
{
  next unless defined $player_counts[$pno];
  my $profile = '';
  $profile .= 'O' if 
    (defined $player_counts[$pno]{Open} && $player_counts[$pno]{Open} > 0
    ||
    defined $player_counts[$pno]{Multiple} && $player_counts[$pno]{Multiple} > 0);

  $profile .= 'W' if 
    defined $player_counts[$pno]{Women} && $player_counts[$pno]{Women} > 0;
  $profile .= 'M' if 
    defined $player_counts[$pno]{Mixed} && $player_counts[$pno]{Mixed} > 0;
  $profile = 'none' if $profile eq '';

  my $gender = $name_players[$pno]{GENDER}[0];

  $phist{$profile}{$gender}++;
}


print "Player matrix\n\n";
printf("%8s%6s%6s%6s\n", "", "M", "F", "?");

for my $profile (qw(OWM OW OM WM O W M none))
{
  printf("%8s%6d%6d%6d\n", $profile,
    $phist{$profile}{M},
    $phist{$profile}{F},
    $phist{$profile}{'?'});
}

print "\n";

# Print tournament data

print "Tournament data\n\n";
printf("%6s  %6s  %6s%6s%6s\n", "ID", "Gender", "M", "F", "?");

for my $tno (1 .. $#tournaments)
{
  next unless defined $tournaments[$tno];

  my $sum = 
    $tourn_counts[$tno]{M} +
    $tourn_counts[$tno]{F} +
    $tourn_counts[$tno]{'?'};

  next unless $sum > 0;

  my $percent = $tourn_counts[$tno]{F} /
    ($tourn_counts[$tno]{M} +
    $tourn_counts[$tno]{F});

  my $guess;
  if ($percent > 0.8)
  {
    $guess = "Women";
  }
  elsif ($percent > 0.4 && $percent < 0.6)
  {
    $guess = "Mixed";
  }
  else
  {
    $guess = "";
  }

  if ($tourn_gender[$tno] eq 'Women' && $percent > 0.999)
  {
    next;
  }

  printf("%6d  %6s  %6d%6d%6d  %s\n",
    $tno,
    $tourn_gender[$tno],
    $tourn_counts[$tno]{M},
    $tourn_counts[$tno]{F},
    $tourn_counts[$tno]{'?'},
    $guess);
}
