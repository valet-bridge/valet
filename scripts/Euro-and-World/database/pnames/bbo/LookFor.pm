#!perl

package LookFor;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(look_for_opening look_for_bigrams);

my %BIGRAMS = (
  Benjamin  => { 'ACOL' => [ 'BASES', 'Benjamin ACOL' ] },
  Convenient => { 'minor' => [ 'BASES', 'Convenient Minor' ] },
  Standard => { 
    'American' => [ 'BASES', 'Standard American' ],
    'Carding' => [ 'CARDING', 'Standard Carding' ] },
  Reverse => { 
    'Bergen' => [ 'BERGEN', 'Reverse Bergen' ],
    'Cappelletti' => [ 'COMPETITIVE', 'Reverse Cappelletti' ] },
  Bergen => { 'Raise' => [ 'BERGEN', 'Bergen Raise' ] },
);


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


sub look_for_bigrams
{
  my ($units, $chain_stats) = @_;

  my $first_pos = $units->find_next_substantial(0);
  return if $first_pos < 0;

  my $first_value = $units->value($first_pos);

  while (1) 
  {
    my $second_pos = $units->find_next_substantial($first_pos + 1);
    last if $second_pos < 0;

    my $second_value = $units->value($second_pos);

    if (exists $BIGRAMS{$first_value} && 
        exists $BIGRAMS{$first_value}{$second_value}) 
    {
      print "MATCHING $first_value $second_value\n";
      my ($category, $value) = 
        @{ $BIGRAMS{$first_value}{$second_value} };

      $units->collapse($first_pos, $second_pos, $category, $value, 
        $chain_stats);

      $first_pos = $units->find_next_substantial($second_pos + 1);
      last if $first_pos < 0;
      $first_value = $units->value($first_pos);
    } 
    else 
    {
      # No match: shift window forward
      $first_pos = $second_pos;
      $first_value = $second_value;
    }
  }
}


1;
