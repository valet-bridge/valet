#!perl

package Team::Postprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(post_process);


sub post_process_split_two
{
  my ($chains, $chain) = @_;

  my $chain2 = Chain->new();
  $chain->copy_from(1, $chain2);
  $chain->truncate_directly_before(1);
  $chain->complete_if_last_is(0, 'COMPLETE');
  $chain2->complete_if_last_is(0, 'COMPLETE');
  splice(@$chains, 1 + $#$chains, 0, $chain2);
}


sub post_process_single_numeral
{
  my ($chains) = @_;

  # Check for a last chain with only a numeral.
  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'OPEN' && $chain->last() == 0;

    my $token0 = $chain->check_out(0);
    my $field0 = $token0->field();

    if ($token0->category() eq 'COUNTER' &&
        ($field0 eq 'NUMERAL' || $field0 eq 'ROMAN') &&
        $token0->value() < 10)
    {
      # Get rid of the stray numeral.
      $chain->complete_if_last_is(0, 'KILLED');
    }
    elsif ($token0->category() eq 'COUNTER' &&
        $field0 eq 'LETTER' &&
        ($token0->value() ge 'A' && $token0->value() le 'C'))
    {
      # Get rid of the stray A-C.
      $chain->complete_if_last_is(0, 'KILLED');
    }
  }
}


sub post_process_double_with_numeral
{
  my ($chains) = @_;

  # Check for a last chain with something followed by numeral.
  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'OPEN' && $chain->last() == 1;

    my $token0 = $chain->check_out(0);
    my $token1 = $chain->check_out(1);

    my $field0 = $token0->field();

    if ($token0->category() eq 'SINGLETON' &&
        ($field0 eq 'LOCALITY') &&
        $token1->category() eq 'COUNTER' &&
        $token1->field() eq 'NUMERAL' &&
        $token1->value() < 10)
    {
      # Get rid of the stray numeral, e.g. 'Heimdal 1'.
      $chain->truncate_directly_before(1);
      $chain->complete_if_last_is(0, 'COMPLETE');
      return;
    }
  }
}


sub post_process
{
  my ($chains) = @_;

  post_process_single_numeral($chains);
  post_process_double_with_numeral($chains);
}

1;
