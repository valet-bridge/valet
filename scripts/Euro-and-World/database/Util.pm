#!perl

package Util;

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
  reverse_name 
  count_to_tourn_stats
  get_unit_restriction
  check_non_uniques
  histo_to_collisions
  str_collisions);

sub reverse_name
{
  my @a = split /\s+/, pop;
  my $i = 0;
  my $flag = 0;
  my $index;

  # The last word may be of the form (n), which stays at the end.
  my $last_real = ($a[-1] =~ /^\(\d\)$/ ? -1 + $#a : $#a);

  for $i (0 .. $last_real)
  {
    # Find the first (real) upper-case word
    my $n = $a[$i];
    my $l = length $n;
    if ($n eq uc($n) && 
        $n ne '-' &&
        ($l >= 3 || ($l == 2 && substr($n, 1, 1) ne '.')))

    {
      $flag = 1;
      $index = $i;
      last;
    }
  }
    
  $index = $last_real if ! $flag;

  my $reversed_name = $a[$index];
  for my $j ($index+1 .. $last_real)
  {
    $reversed_name .= " " . $a[$j];
  }

  for my $j (0 .. $index-1)
  {
    $reversed_name .= " " . $a[$j];
  }

  if ($last_real != $#a)
  {
    $reversed_name .= ' ' . $a[-1];
  }

  return $reversed_name;
}


sub count_to_tourn_stats
{
  my ($cref) = @_;

  my $hdr .= sprintf("%-24s", "");
  for my $g (qw(S O M W ?))
  {
    $hdr .= sprintf("%5s", $g);
  }
  $hdr .= "\n";

  my $str = '';
  for my $restriction (sort keys %$cref)
  {
    if ($restriction =~ /^Women/)
    {
      next if $cref->{$restriction}{S} == $cref->{$restriction}{W};
    }
    elsif ($restriction =~ /^Mixed/)
    {
      next if $cref->{$restriction}{S} == $cref->{$restriction}{M};
    }
    elsif ($restriction =~ /^Open/ || $restriction =~ /^None/)
    {
      if ((! defined $cref->{$restriction}{M} ||
          $cref->{$restriction}{M} / $cref->{$restriction}{S} < 0.5) &&
          (! defined $cref->{$restriction}{W} ||
          $cref->{$restriction}{W} / $cref->{$restriction}{S} < 0.5))
      {
        # Unlikely to be Open in error.
        next;
      }
    }
    elsif ($cref->{$restriction}{S} < 8)
    {
      # Not enough statistics.
      next;
    }

    $str .= sprintf("%-24s", $restriction);
    for my $g (qw(S O M W ?))
    {
      $str .= sprintf("%5d", $cref->{$restriction}{$g} || 0);
    }
    $str .= "\n";
  }

  if ($str eq '')
  {
    return '';
  }
  else
  {
    return $hdr . $str;
  }
}


sub get_unit_restriction
{
  my ($tourn_header, $chunk_restriction, $errstr) = @_;

  # Used by TeamT, PairT and IndivT to merge the overall tournament
  # restriction with any unit-level restriction (team, pair, individual).

  my $unit_restriction = (defined $chunk_restriction ?
    $chunk_restriction : 'None');

  my $unit_gender_restriction = $tourn_header->restrict_gender(
    $unit_restriction, $errstr);

  my $unit_age_restriction = $tourn_header->restrict_age(
    $unit_restriction, $errstr);

  my $unit_stage_restriction = $tourn_header->restrict_stage(
    $unit_restriction, $errstr);

  my $concat =
    $unit_gender_restriction . '-' .
    $unit_age_restriction . '-' .
    $unit_stage_restriction;

  return $tourn_header->simplify_restriction($concat);
}


sub check_non_uniques
{
  my ($unit_hash_ref, $players, $errstr) = @_;

  # Used by the tournament types to check for duplicated players.

  my $str = '';
  for my $ebl (sort keys %$unit_hash_ref)
  {
    for my $restriction (keys %{$unit_hash_ref->{$ebl}})
    {
      my $num = $#{$unit_hash_ref->{$ebl}{$restriction}};
      if ($num >= 1)
      {
        $str .= $ebl . ", " . $players->id_to_name($ebl) .
          " (" . ($num+1) . " occurrences in $restriction)\n";
      }
    }
  }

  if ($str ne '')
  {
    print "$errstr:\n$str\n";
  }
}


sub histo_to_collisions
{
  my ($histo_ref, $active, $hits_ref, $highest_ref) = @_;

  # Used by TeamT and PairT.

  for my $restriction (keys %$histo_ref)
  {
    for my $unit_id (sort keys %{$histo_ref->{$restriction}})
    {
      if ($histo_ref->{$restriction}{$unit_id} == $active)
      {
        $hits_ref->{$restriction}++;
        if ($hits_ref->{$restriction} > $$highest_ref)
        {
          $$highest_ref = $hits_ref->{$restriction};
        }
      }
    }
  }
}


sub str_collisions
{
  my ($histo_ref) = @_;

  for my $restriction (keys %$histo_ref)
  {
    if ($histo_ref->{$restriction} > 1)
    {
      print "$restriction: ", $histo_ref->{$restriction}, " times\n";
    }
  }
}


1;
