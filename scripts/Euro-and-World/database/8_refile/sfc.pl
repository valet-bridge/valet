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

$players->check_names();

my @combined;
read_combined($comb_file, $players, \@tournament_headers, \@combined);

my @time_sorted_tournaments;
time_sort_tournaments(\@tournament_headers, \@time_sorted_tournaments);

my @player_matrix;
tournament_to_player_matrix(\@combined, \@player_matrix);

check_from_names(\@tournament_headers, \@name_tournaments, \@combined);

# 1. Just the players
# print $players->str();

# 2. Player and tournaments
# print $players->str_player_matrix(
  # \@tournament_headers, \@time_sorted_tournaments,
  # \@player_matrix, $players);

# 3. Just the tournament headers
# print_tournament_headers(\@tournament_headers);

# 4. Headers and tournament content
# print_tournament_contents(\@tournament_headers, \@combined);

exit;


sub print_tournament_headers
{
  my ($tournament_headers_ref) = @_;
  for my $header (@$tournament_headers_ref)
  {
    next unless defined $header;
    print $header->str(), "\n";
  }
}


sub print_tournament_contents
{
  my ($tournament_headers_ref, $combined_ref) = @_;
  for my $header (@$tournament_headers_ref)
  {
    next unless defined $header;
    print $header->str(), "\n";
    my $id = $header->id();
    if (! defined $combined_ref->[$id])
    {
      print "UNDEFINED!\n\n";
    }
    else
    {
      print $combined_ref->[$id]->str($players);
    }
  }
}


sub time_sort_tournaments
{
  my ($tournament_headers_ref, $time_sorted_ref) = @_;
  my $tsno = 0;
  for my $header (@$tournament_headers_ref)
  {
    next unless defined $header;
    $time_sorted_ref->[$tsno]{id} = $header->id();
    $time_sorted_ref->[$tsno]{time} = $header->time();
    $tsno++;
  }

  @$time_sorted_ref = sort { $a->{time} cmp $b->{time} } @$time_sorted_ref;
}


sub tournament_to_player_matrix
{
  my ($combined_ref, $player_matrix_ref) = @_;

  for my $tno (0 .. @$combined_ref)
  {
    next unless defined $combined_ref->[$tno];
    $combined_ref->[$tno]->fill_player_matrix($tno, $player_matrix_ref);
  }
}

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

    my $form = $tourn_headers_ref->[$tno]->form();

    $comb_ref->[$tno]->check_non_uniques($players, 
      "$form tournament $tno");

    $comb_ref->[$tno]->check_against_name_data(
      \%{$from_names_ref->[$tno]}, $players, 
      "$form tournament $tno");
  }
}

