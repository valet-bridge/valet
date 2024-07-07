#!perl

package Team::Preprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(pre_process);


sub make_record
{
  my ($chains, $record) = @_;

  for my $chain (@$chains)
  {
    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      my $field = $token->field();

      push @{$record->{$field}}, $token->value();
    }
  }
}


sub pre_process_abbr
{
  # Destroy Bridge Club if there is also Sporting Club.

  my ($chains, $record) = @_;

  my $chain = $chains->[0];
  return unless $chain->last() >= 1;
  return unless (exists $record->{ABBR} && $#{$record->{ABBR}} == 1);

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    if ($token->field() eq 'ABBR' &&
        $token->value() eq 'Bridge Club')
    {
      $token->set_singleton('DESTROY', 'Bridge Club');
    }
  }
}


sub pre_process_orange
{
  # Turn Orange White into Netherlands White.

  my ($chains, $record) = @_;

  my $chain = $chains->[0];
  return unless $chain->last() >= 1;
  return unless (exists $record->{COLOR} && $#{$record->{COLOR}} == 1);

  my $token = $chain->check_out(0);
  if (lc($token->value()) eq 'orange')
  {
    $token->set_singleton('COUNTRY', 'Netherlands');
  }
}


sub pre_process_two_numerals
{
  # Destroy two numerals

  my ($chains, $record) = @_;

  my $chain = $chains->[0];
  return unless $chain->last() >= 1;
  return unless (exists $record->{NUMERAL} && $#{$record->{NUMERAL}} == 1);

  for my $i (0 .. $chain->last())
  {
    my $token = $chain->check_out($i);
    if ($token->field() eq 'NUMERAL')
    {
      $token->set_singleton('DESTROY', $token->value());
    }
  }
}


sub pre_process
{
  my ($chains) = @_;

  # At this point there is a single chain.
  my %record;
  make_record($chains, \%record);

  pre_process_abbr($chains, \%record);
  pre_process_orange($chains, \%record);
  pre_process_two_numerals($chains, \%record);
}

1;
