#!perl

package Event::Preprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(pre_process);

use lib '..';
use Separators;


sub pre_process_tightly_bound
{
  my ($chains) = @_;

  return unless $#$chains == 0;
  my $chain = $chains->[0];
  return unless $chain->status() eq 'OPEN';
  my $l = $chain->last();
  return unless $l >= 2;

  # Look for numeral-letter or the other way round with a 
  # virtual separator in between, but not around it.

  for my $pos (reverse 0 .. $chain->last()-2)
  {
    my $token0 = $chain->[$pos];
    my $field0 = $token0->field();
    next unless $field0 eq 'NUMERAL' || $field0 eq 'LETTER';

    my $token1 = $chain->[$pos+1];
    next unless $token1->category() eq 'SEPARATOR' &&
      $token1->field() eq $SEPARATORS{VIRTUAL};

    my $token2 = $chain->[$pos+2];
    my $field2 = $token2->field();
    next unless $field2 eq 'NUMERAL' || $field2 eq 'LETTER';

    if ($pos > 0)
    {
      my $tokenp = $chain->[$pos-1];
      next if $tokenp->category() eq 'SEPARATOR' &&
      $tokenp->field() eq $SEPARATORS{VIRTUAL};
    }

    if ($pos < $l)
    {
      my $tokenn = $chain->[$pos-1];
      next if $tokenn->category() eq 'SEPARATOR' &&
      $tokenn->field() eq $SEPARATORS{VIRTUAL};
    }

    $token0->merge_counters('', $token2);
    $chain->delete($pos+1, $pos+2);
  }
}


sub pre_process
{
  my ($chains) = @_;

  # At this point there is a single chain.
  # It's easier to solve some issues here.

  pre_process_tightly_bound($chains);
}

1;
