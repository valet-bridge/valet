#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Event::Ematch;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_repeats);

# BBOVG numbers for which en empty 'Round' is permitted (but killed).

my @EMATCH_ROUND = qw(
  17872 17995 26897 35604 35606 35617 35619 35621 35622 35627 35632
  35635 35640 35641 35650 35651 35654 35667 35668 44666 44671 46366
);

my @EMATCH_SEGMENT = qw(
   1280 18310 32489 32490 40394
);

sub set_ematch_round
{
  my ($ematch) = @_;

  for my $e (@EMATCH_ROUND)
  {
    $ematch->{$e} = 1;
  }
}


sub set_ematch_segment
{
  my ($ematch) = @_;

  for my $e (@EMATCH_SEGMENT)
  {
    $ematch->{$e} = 1;
  }
}

1;
