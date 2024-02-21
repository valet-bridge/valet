#!perl

use strict;
use warnings;
use v5.10;

use lib '..';
use Read;
use Players;
use Country;
use Restriction;

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

my @combined;
read_combined($comb_file, $players, \@tournament_headers, \@combined);

check_from_names(\@tournament_headers, \@name_tournaments, \@combined);
exit;

# my $select = 10009;
# print_teams_tournament(\%{$tournaments[$select]}, $select,
  # \%{$name_tournaments[$select]});

# my $select = 10014;
# print_pairs_tournament(\%{$tournaments[$select]}, $select,
  # \%{$name_tournaments[$select]});

exit;


sub check_from_names
{
  my ($tourn_headers_ref, $from_names_ref, $comb_ref) = @_;

  for my $tno (1 .. $#$from_names_ref)
  {
    next unless defined $from_names_ref->[$tno];

    if (! defined $comb_ref->[$tno])
    {
      print "Tournament $tno not present in comb\n";
      next;
    }

    $comb_ref->[$tno]->check_non_uniques($players, "Tournament $tno");

    $comb_ref->[$tno]->check_against_name_data(
      \%{$from_names_ref->[$tno]}, $players, "Tournament $tno");
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

