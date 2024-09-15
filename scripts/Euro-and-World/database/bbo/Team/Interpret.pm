#!perl

package Team::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret);

use lib './Connections';
use Util;

use Connections::Matrix;
use Team::Cmatch;

my @ACCEPT_FIELDS = qw(AGE BOT CAPTAIN CITY CLUB COUNTRY FIRST
  FORM FUN GENDER LOCALITY NATIONALITY ORGANIZATION ORIGIN OTHER
  REGION SPONSOR UNIVERSITY ZONE);

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;


# BBOVG numbers for which repeated, but different fields are OK.
my %CLUB_MATCHES;

sub init_hashes
{
  Team::Cmatch::set_cmatch(\%CLUB_MATCHES);
}


sub post_process_single
{
  my ($chains) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if (exists $ACCEPT{$field0})
    {
      $chain->complete_if_last_is(0, 'EXPLAINED');
    }
    elsif ($field0 eq 'COLOR')
    {
      if ($token0->value() eq 'Orange')
      {
        $token0->set_general('SINGLETON', 'COUNTRY', 'Netherlands');
        $chain->complete_if_last_is(0, 'EXPLAINED');
      }
      else
      {
        $chain->complete_if_last_is(0, 'KILLED');
      }
    }
    elsif ($field0 eq 'MEET' && $token0->value() eq 'Festival')
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


sub post_process_abbr
{
  my ($whole, $chains, $bbono) = @_;

  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'ABBR';

    my ($city, $cno_found);
    if (! ($city = find_field_in_chains($chains, 'CITY', \$cno_found)))
    {
      if (find_field_in_chains($chains, 'CLUB', \$cno_found))
      {
        # It's already a club, so skip the extra club indicator.
        $chain->complete_if_last_is(0, 'KILLED');
        return;
      }
      elsif (find_field_in_chains($chains, 'REGION', \$cno_found))
      {
        # TODO Match these as well (add a city).
        print "MATRIX with REGION\n";
        return;
      }
      elsif (find_field_in_chains($chains, 'LOCALITY', \$cno_found))
      {
        # TODO Match these as well (add a city).
        print "MATRIX with LOCALITY\n";
        return;
      }
      elsif (find_field_in_chains($chains, 'UNIVERSITY', \$cno_found))
      {
        # Assume a university is always a club.
        $chain->complete_if_last_is(0, 'KILLED');
        return;
      }
      print "MATRIX No city, region, club or university\n";
      return;
    }

    my $club_list = Connections::Matrix::get_city_club_list($city);
    if (defined $club_list)
    {
      if ($#$club_list > 0)
      {
        print "MATRIX Multiple clubs in $city: ",
          join(', ', @$club_list), "\n";
      }
      elsif (exists $CLUB_MATCHES{$bbono})
      {
        # Change the city to the single club there.
        $token->set_general('SINGLETON', 'CLUB', $club_list->[0]);
        $chain->complete_if_last_is(0, 'EXPLAINED');
        $chains->[$cno_found]->complete_if_last_is(0, 'KILLED');
      }
      else
      {
        print "MATRIX Matching $city to ", $club_list->[0], "\n";
      }
    }
    else
    {
      print "MATRIX No club list\n";
    }
    return;
  }
}


sub post_process_meet
{
  my ($chains, $chains_title, $bbono) = @_;

  # Check for MEET.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'MEET';

    my $value = $token->value();

    my $cno;
    my $meet = find_field_in_chains($chains, 'MEET', \$cno);
    if (! $meet)
    {
      # Move the MEET from here to TITLE.
      $chain->complete_if_last_is(0, 'EXPLAINED');
      push @$chains_title, dclone($chain);
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($value eq $meet)
    {
      # Redundant with TITLE.
      $chain->complete_if_last_is(0, 'KILLED');
    }
    else
    {
      print "$bbono: DIFFER $field, $value vs MEET $meet\n";
    }
  }
}


sub eliminate_scoring
{
  my ($chains, $scoring) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();
    next unless $field0 eq 'SCORING';

    my $value0 = $token0->value();

    if (($$scoring eq 'I' && $value0 eq 'IMP') ||
        ($$scoring eq 'P' && $value0 eq 'MP') ||
        ($$scoring eq 'B' && $value0 eq 'BAM'))
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($$scoring ne 'P' && $value0 eq 'MP')
    {
      # Probably a few errors in data entry.
      $$scoring = 'P';
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


sub post_process_empty
{
  # Not quite sure how this happens.
  my ($chains) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next if $chain->status() ne 'COMPLETE';
    next unless $chain->last() == -1;
      $chain->complete_if_last_is(-1, 'KILLED');
  }
}


sub interpret
{
  my ($whole, $chains, $chains_title, $scoring, $bbono) = @_;

  post_process_single($chains);
  post_process_abbr($whole, $chains, $bbono);
  post_process_meet($chains, $chains_title, $bbono);
  eliminate_scoring($chains, $scoring);
  post_process_empty($chains);
}

1;
