#!perl

package Team::Interpret;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(interpret);

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

    if (($scoring eq 'I' && $value0 eq 'IMP') ||
        ($scoring eq 'P' && $value0 eq 'MP') ||
        ($scoring eq 'B' && $value0 eq 'BAM'))
    {
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


sub interpret
{
  my ($chains, $scoring) = @_;

  post_process_single($chains);
  eliminate_scoring($chains, $scoring);
}

1;
