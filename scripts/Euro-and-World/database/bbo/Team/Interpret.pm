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
use Connections::Matrix;

my @ACCEPT_FIELDS = qw(AGE BOT CAPTAIN CITY CLUB COUNTRY FIRST
  FORM FUN GENDER LOCALITY NATIONALITY ORGANIZATION OTHER
  REGION SPONSOR UNIVERSITY ZONE);

my %ACCEPT = map { $_ => 1 } @ACCEPT_FIELDS;


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
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($field0 eq 'MEET' && $token0->value() eq 'Festival')
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


sub find_field_in_chains
{
  my ($chains, $tag) = @_;

  my $found = 0;
  my $value;

  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq $tag;

    return $token->value();
    last;
  }

  return 0;
}


sub post_process_abbr
{
  my ($whole, $chains) = @_;

  for my $cno (0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next if $chain->status() eq 'KILLED';
    next unless $chain->last() == 0;

    my $token = $chain->check_out(0);
    my $field = $token->field();
    next unless $field eq 'ABBR';

    my $city;
    if (! ($city = find_field_in_chains($chains, 'CITY')))
    {
      print "MATRIX No city\n";
      return;
    }

    my $club_list = Connections::Matrix::get_city_club_list($city);
    if (! defined $club_list)
    {
      print "MATRIX No club list for $city\n";
    }
    elsif ($#$club_list > 0)
    {
      print "MATRIX Multiple clubs in $city: ",
        join ', ', @$club_list, "\n";
    }
    else
    {
      print "MATRIX Matching $city to ", $club_list->[0], "\n";
    }
    return;
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


sub interpret
{
  my ($whole, $chains, $scoring) = @_;

  post_process_single($chains);
  post_process_abbr($whole, $chains);
  eliminate_scoring($chains, $scoring);
}

1;
