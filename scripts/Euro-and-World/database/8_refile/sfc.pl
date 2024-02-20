#!perl

use strict;
use warnings;
use v5.10;

use lib '..';
use Players;
use Country;
use Restriction;

use lib '../7_women';
use Read;

use TeamT;

# Check single-factor consistencies of fields.

die "perl sfc.pl" unless $#ARGV == -1;

my $names_file = 'ebl.txt';
my $comb_file = 'combined.txt';
my $tourn_file = 'tournaments.txt';

my $players = Players->new();
my $country = Country->new();
my $restriction = Restriction->new();

my @tournament_headers;
read_tournament_headers($tourn_file, \@tournament_headers);

my (@name_players, @name_tournaments);
read_names_into_players($names_file, \@tournament_headers,
  $players, \@name_tournaments);

my @combined_entries;
read_combined_new($comb_file, \@tournament_headers, \@combined_entries);

my @combined_structured;
read_combined_in_chunks($comb_file, $players, 
  \@tournament_headers, \@combined_structured);

my @comb_tournaments;
my @tournaments;
check_combined(\@tournament_headers, 
  \@combined_entries, \@comb_tournaments, \@tournaments);

check_from_names(\@tournament_headers,
  \@name_tournaments, \@combined_entries, \@combined_structured);
exit;

# my $select = 10009;
# print_teams_tournament(\%{$tournaments[$select]}, $select,
  # \%{$name_tournaments[$select]});

# my $select = 10014;
# print_pairs_tournament(\%{$tournaments[$select]}, $select,
  # \%{$name_tournaments[$select]});

exit;


sub check_combined
{
  my ($tourn_headers_ref, $comb_ref, $clean_ref) = @_;

  for my $tno (1 .. $#$comb_ref)
  {
    next unless defined $comb_ref->[$tno];

    my $team_flag = $tourn_headers_ref->[$tno]->is_teams();

    # Could be a pair or a team
    my @id_list;
    for my $hash_str (sort keys %{$comb_ref->[$tno]})
    {
      # Could just be pairs, or a number of teams.

      if ($team_flag)
      {
        for my $player (@{$comb_ref->[$tno]{$hash_str}})
        {
          next unless exists $player->{id};
          push @id_list, $player->{id};
        }
      }
      else
      {
        for my $unit (@{$comb_ref->[$tno]{$hash_str}})
        {
          next unless defined $unit;

        for my $player (@$unit)
        {
          if (exists $player->{restriction})
          {
            my $r = $player->{restriction};
            if (! $tourn_headers_ref->[$tno]->restriction_compatible($r))
            {
              print $tourn_headers_ref->[$tno]->str(), "\n";
              print "restriction $r\n";
              warn "Restriction mismatch";
            }
          }

          next unless exists $player->{id};
          my $id = $player->{id};

          if (! exists $player->{name})
          {
            print "Tournament $tno\n";
            print "Player ID $id\n";
            die "No name in combined file";
          }

          my $name = $player->{name};
          if (! $players->has_name($name))
          {
            print "Tournament $tno\n";
            print "Player ID $id\n";
            print "Player name .$name.\n";
            die "Does not match a name in the player list";
          }

          next unless exists $player->{country};
          my $c = $player->{country};

          if ($c eq '-')
          {
            delete $player->{country};
          }
          elsif (! $country->valid($c))
          {
            print "Tournament $tno\n";
            print "Player ID $id\n";
            print "Country $c\n";
            die "Not a country";
          }

          if (! $players->player_has_country($id, $c))
          {
            next if $c eq '-'; # TODO For now
            print "Tournament $tno\n";
            print "Player ID $id\n";
            print "Player name $name\n";
            print "Country $c\n\n";
            warn "Does not match a country in the player list";
          }
          push @id_list, $id;
        }

        }
      }
    }

    @id_list = sort {$a <=>$b} @id_list;

    $clean_ref->[$tno] = [ @id_list ];
  }
}


sub check_from_names
{
  my ($tourn_headers_ref, $from_names_ref, $from_comb_ref, $comb_ref) = @_;

  for my $tno (1 .. $#$from_names_ref)
  {
    next unless defined $from_names_ref->[$tno];

    if (! defined $from_comb_ref->[$tno])
    {
      print "Tournament $tno not present in comb\n";
      next;
    }

    my $team_flag = $tourn_headers_ref->[$tno]->is_teams();
    my $pair_flag = $tourn_headers_ref->[$tno]->is_pairs();

    if ($team_flag)
    {
      $comb_ref->[$tno]->check_against_name_data(
        \%{$from_names_ref->[$tno]}, "Tournament $tno");
    }
    else
    {
if ($tno == 21)
{
  # print "HERE\n";
}
      if ($pair_flag)
      {
        $comb_ref->[$tno]->check_non_uniques(
          $players, "Tournament $tno");

        $comb_ref->[$tno]->check_against_name_data(
          \%{$from_names_ref->[$tno]}, $players, "Tournament $tno");
      }

      # Build player map
      my @from_comb;
      for my $pair_no (0 .. @{$from_comb_ref->[$tno]{pairs}})
      {
        for my $pl (@{$from_comb_ref->[$tno]{pairs}[$pair_no]})
        {
          next unless defined $pl->{id};
          $from_comb[$pl->{id}] = $pair_no;
        }
      }

      for my $pair_no (0 .. @{$from_names_ref->[$tno]{pairs}})
      {
        my %numbers_comb;
        for my $id (@{$from_names_ref->[$tno]{pairs}[$pair_no]})
        {
          next if $id eq '-1'; # Sloppy -- why does this arise?

          if (defined $from_comb[$id])
          {
            $numbers_comb{$from_comb[$id]}++;
          }
          else
          {
            $numbers_comb{'-1'}++;
          }
        }

        if (! summarize_pair_histo(\%numbers_comb))
        {
          print "Tournament $tno\n";
          print "Pair number $pair_no\n";
          for my $id (@{$from_names_ref->[$tno]{pairs}[$pair_no]})
          {
            if (defined $from_comb[$id])
            {
              print "  $id $from_comb[$id], ",
                $players->id_to_name($id), "\n";
            }
            else
            {
              print "  $id missing, ",
                $players->id_to_name($id), "\n";
            }
          }
          print "\n";
        }
      }
    }
  }
}


sub summarize_pair_histo
{
  my ($hist_ref) = @_;

  my @keys = keys %$hist_ref;
  if ($#keys == 0)
  {
    if ($keys[0] eq '-1')
    {
      print "All players missing\n";
      return 0;
    }
    else
    {
      return 1;
    }
  }
  elsif ($#keys == 1)
  {
    if ($keys[0] eq '-1' || $keys[1] eq '-1')
    {
      # Happens so often that we don't flag it.
      return 1;
    }
    else
    {
      print "Two corresponding units\n";
      return 0;
    }
  }
  elsif ($#keys == -1)
  {
    # Again sloppy
    return 1;
  }
  else
  {
    print "Several corresponding units\n";
    return 0;
  }
}


sub summarize_team_histo
{
  my ($hist_ref) = @_;

  my @keys = keys %$hist_ref;
  if ($#keys == 0)
  {
    if ($keys[0] eq '-1')
    {
      print "All players missing\n";
      return 0;
    }
    else
    {
      return 1;
    }
  }
  elsif ($#keys == 1)
  {
    if ($keys[0] eq '-1' || $keys[1] eq '-1')
    {
      print "At least one player missing\n";
    }
    else
    {
      print "Two corresponding units\n";
    }
    return 0;
  }
  else
  {
    print "Several corresponding units\n";
    return 0;
  }
}


sub print_teams_tournament
{
  my ($tournament_header_ref, $tid, $tourn_data_ref) = @_;

  print "TITLE ", $tournament_header_ref->{TITLE}, "\n";
  print "ID ", $tid, "\n";
  print "DETAILS CHECKTHIS!\n\n";

  for my $tname (sort keys %$tourn_data_ref)
  {
    print "NAME ", $tname, "\n";
    print "RESTRICTION Juniors series\n";
    # print "RESTRICTION CHECKTHIS!\n";

    my $no = 0;
    for my $pid (@{$tourn_data_ref->{$tname}})
    {
      print "PLAYER$no ", $players->id_to_name($pid), "\n";
      print "ID$no $pid\n";
      print "FUNCTION$no player\n";
      $no++;
    }
    print "\n";
  }
}


sub print_pairs_tournament
{
  my ($tournament_header_ref, $tid, $tourn_data_ref) = @_;

  print "TITLE ", $tournament_header_ref->{TITLE}, "\n";
  print "ID ", $tid, "\n";
  print "DETAILS CHECKTHIS!\n\n";

  for my $pair (@{$tourn_data_ref->{pairs}})
  {
    my $no = 1;
    for my $pid (@$pair)
    {
      print "PLAYER$no ", $players->id_to_name($pid), "\n";
      print "ID$no $pid\n";
      $no++;
    }
    print "\n";
  }
}

