#!perl

package Event::Postprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(post_process);


sub post_process_ordinal_nn
{
  # 4th 7_2
  my ($chains) = @_;

  for my $cno (reverse 0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    return unless $chain->status() eq 'OPEN';
    return unless $chain->last() == 2;

    my $token0 = $chain->check_out(0);
    my $token1 = $chain->check_out(1);
    my $token2 = $chain->check_out(2);

    if ($token0->field() eq 'ORDINAL' &&
        $token1->category() eq 'SEPARATOR' &&
        $token2->field() eq 'MAJOR_MINOR')
    {
      my $chain2 = Chain->new();
      $chain->copy_from(2, $chain2);
      $chain->truncate_directly_before(1);
      $chain->complete_if_last_is(0, 'COMPLETE');
      $chain2->complete_if_last_is(0, 'COMPLETE');
      splice(@$chains, $cno+1, 0, $chain2);
    }
  }
}


sub post_process
{
  my ($chains) = @_;

  post_process_ordinal_nn($chains);
}

1;