#!perl

package IndivT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Indiv;
use Players;
use Util;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub add_from_chunk
{
  my ($self, $tourn_header, $chunk_ref, $players, $errstr) = @_;

  my $indiv_restriction = Util::get_unit_restriction(
    $tourn_header, $chunk_ref->{RESTRICTION}, $errstr);
    
  push @{$self->{$indiv_restriction}}, Indiv->new();
  my $indiv_no = $#{$self->{$indiv_restriction}};

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    $self->{$indiv_restriction}[$indiv_no]->add_key_value(
      $key, $chunk_ref->{$key});
  }

  $self->{$indiv_restriction}[$indiv_no]->check_basics(
    $players, "$errstr, $indiv_no");

  $self->{$indiv_restriction}[$indiv_no]->fill_player_map(
    \%{$self->{_players}}, $indiv_restriction, $indiv_no);
  
  $self->{$indiv_restriction}[$indiv_no]->analyze_gender(
    $players, $errstr);
  
  if (! $self->{$indiv_restriction}[$indiv_no]->check_gender(
    $indiv_restriction))
  {
    print "$errstr, $indiv_no: Individual gender mismatch\n";
    print "Restriction $indiv_restriction\n";
    print "Profile ",
      $self->{$indiv_restriction}[$indiv_no]->str_gender(), "\n";
    print $self->{$indiv_restriction}[$indiv_no]->str($players), "\n";
  }

  my $year = $tourn_header->year();
  if (! $self->{$indiv_restriction}[$indiv_no]->check_and_update_age(
    $year, $indiv_restriction, $players))
  {
    print "$errstr, $indiv_no: Individual age mismatch\n";
    print "Restriction: $indiv_restriction\n";
    print "Year: $year\n";
    print $self->{$indiv_restriction}[$indiv_no]->str($players), "\n";
  }
}


sub check_non_uniques
{
  my ($self, $players, $errstr) = @_;
  Util::check_non_uniques(\%{$self->{_players}}, $players, $errstr);
}


sub make_indiv_histo
{
  my ($self, $ebl, $players, $tourn_indiv_ref, $errstr) = @_; 

  return 0 if $ebl == -1;

  my $hit = 0;
  for my $restriction (keys %{$self->{_players}{$ebl}})
  {
    $hit++;
    for my $tourn_indiv_no (@{$self->{_players}{$ebl}{$restriction}})
    {
      $tourn_indiv_ref->{$restriction}{$tourn_indiv_no}++;
    }
  }

  if (! $hit)
  {
    print "$errstr: Individual ", $players->id_to_name($ebl),
      " (EBL $ebl) missing from tournament\n\n";
  }

  return 1;
}


sub check_against_name_data
{
  my ($self, $name_data_ref, $players, $errstr) = @_;

  for my $name_indiv_no (0 .. $#{$name_data_ref->{indiv}})
  {
    my %tourn_indiv;

    if (! $self->make_indiv_histo(
      $name_data_ref->{pairs}[$name_indiv_no],
      $players, \%tourn_indiv, $errstr))
    {
      print "$errstr, individual number $name_indiv_no:\n";
      print "Players missing\n\n";
      next;
    }
  }
}


sub str_ebl_indiv
{
  my ($self, $ebl, $players) = @_;

  my $str = '';
  if ($ebl == -1)
  {
    $str .= "  (missing)\n";
  }
  else
  {
    $str .= "  $ebl, " . $players->id_to_name($ebl) . "\n";
  }
  $str .= "\n";
}


sub fill_player_matrix
{
  my ($self, $tno, $player_matrix_ref) = @_;

  for my $restriction (keys %$self)
  {
    next if $restriction eq '_players';
    for my $indiv (@{$self->{$restriction}})
    {
      $indiv->fill_player_matrix(
        $tno, $restriction, '', $player_matrix_ref);
    }
  }
}


sub str_gender_stats_new
{
  my ($self, $players) = @_;

  my %counts;
  for my $restriction (keys %$self)
  {
    next if $restriction eq '_players';
    for my $indiv (@{$self->{$restriction}})
    {
      $indiv->update_gender_count(\%{$counts{$restriction}});
    }
  }

  return Util::count_to_tourn_stats(\%counts);
}


sub str
{
  my ($self, $players) = @_;
  my $str = '';
  for my $restriction (sort keys %$self)
  {
    next if $restriction eq '_players';
    for my $indiv (@{$self->{$restriction}})
    {
      $str .= $indiv->str($players) . "\n";
    }
  }
  return $str;
}


1;
