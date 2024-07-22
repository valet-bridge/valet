#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Tmatch;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_repeats);

# BBOVG numbers for which en empty 'Round' is permitted (but killed).

my @TMATCH_ROUND = qw(
  17872 17995 26897 35604 35606 35617 35619 35621 35622 35627 35632
  35635 35640 35641 35650 35651 35654 35667 35668 44666 44671 46366
);

sub set_tmatch_round
{
  my ($tmatch) = @_;

  for my $t (@TMATCH_ROUND)
  {
    $tmatch->{$t} = 1;
  }
}

1;
