#!perl

use warnings;
use strict;

# Common function for creating a map of original board numbers
# to new board numbers.
# Created on the occasion of the January 2023 training weekend.
#
# Input         Low result              High result
# 1-16          1-15                    16->16, 1->17, ..., 14->30
# 1-20          Ditto                   Ditto
# 17-32         17->1, ..., 31->15      32->16, 17->17, ..., 30->30
#
# The input boards are from various championships.
# We want them renumbered into 15-board segments that occupy
# either 1-15 or 16-30 depending on high_flag.

sub translate
{
  my ($list_ref, $high_flag, $result_ref) = @_;

  # First count whether we have input 1, 2, or 3. 
  my $lows = 0;
  my $highs = 0;
  for my $v (@$list_ref)
  {
    if ($v < 17)
    {
      $lows++;
    }
    else
    {
      $highs++;
    }
  }

  @$result_ref = ();
  my @maps;

  if ($high_flag)
  {
    for my $v (@$list_ref)
    {
      my $mapped = ($v % 16) + 16;
      if ($mapped == 31 || defined $maps[$mapped])
      {
        $result_ref->[$v] = 0;
      }
      else
      {
        $result_ref->[$v] = $mapped;
        $maps[$mapped] = 1;
      }
    }
  }
  else
  {
    for my $v (@$list_ref)
    {
      my $mapped = (($v-1) % 16) + 1;
      if ($mapped == 16 || defined $maps[$mapped])
      {
        $result_ref->[$v] = 0;
      }
      else
      {
        $result_ref->[$v] = $mapped;
        $maps[$mapped] = 1;
      }
    }
  }
}

1;
