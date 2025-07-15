#!perl

package LookFor;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(look_for_opening);


sub look_for_opening
{
  my ($units, $denom, $name, $lower, $upper, $hash, $chain_stats) = @_;

  my $index = 0;
  while ($index <= $units->last())
  {
    my $pos = $units->force_first_equal_forward($index,
      'DENOMINATIONS', $denom, $hash);
    return if $pos < 0;
    if ($pos == 0)
    {
      $index = $pos + 1;
      next;
    }

    my $level_pos = $units->find_first_cat_backward(
      $pos-1, 'INT_SMALL', {});
    if ($level_pos < 0)
    {
      $index = $pos + 1;
      next;
    }

    my $level = $units->value($level_pos);
    if ($level >= $lower && $level <= $upper)
    {
      my $opening = "OPENING_${level}${name}";
      $units->collapse($level_pos, $pos, $opening, '', $chain_stats);
      $index = $level_pos + 1;
    }
    else
    {
      $index = $pos + 1;
    }
  }
}


1;
