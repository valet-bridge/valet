#!perl

package Title::Preprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(pre_process);


# Fields that are commonly part of team names in title.

my %VS_VALID =
(
  COUNTRY => 1,
  CITY => 1,
  GENDER => 1,
  AGE => 1,
  CAPTAIN => 1
);

my %VS_DESTROY =
(
  DESTROY => 1
);


sub get_vs_extent
{
  my ($chain, $center, $hash, $first, $last) = @_;

  # If the chain does not go all the way to the front, split.
  $$first = $center;
  for my $j (reverse 0 .. $center-1)
  {
    my $token0 = $chain->check_out($j);
    my $cat = $token0->category();
    my $field = $token0->field();
    if ($cat eq 'SINGLETON' && exists $hash->{$field})
    {
      $$first = $j;
    }
    else
    {
      last;
    }
  }

  # If the chain does not go all the way to the back, split.
  $$last = $center;
  for my $j ($center+1 .. $chain->last())
  {
    my $token1 = $chain->check_out($j);
    my $cat = $token1->category();
    my $field = $token1->field();
    if ($cat eq 'SINGLETON' && exists $hash->{$field})
    {
      $$last = $j;
    }
    else
    {
      last;
    }
  }
}


sub process_vs_extent
{
  my ($chains, $chain, $cno, $first, $last, $completion) = @_;

  if ($first > 0)
  {
    my $chain1 = Chain->new();
    $chain->copy_from($first, $chain1);
    $chain->delete($first, $chain->last());
    splice(@$chains, $cno+1, 0, $chain1);

    $chain = $chain1;
    $cno++;
  }

  if ($last < $chain->last())
  {
    my $chain2 = Chain->new();
    $chain->copy_from($last+1, $chain2);
    $chain->delete($last+1, $chain->last());
    splice(@$chains, $cno+1, 0, $chain2);
  }

  $chain->complete_if_last_is($chain->last(), $completion);
}


sub pre_process_vs
{
  my ($chains) = @_;

  my $chain = $chains->[0];
  return unless $chain->last() >= 2;
  my $cno = 0;

  my $token = $chain->check_out(0);
  if ($token->category() eq 'SINGLETON' &&
      $token->field() eq 'PARTICLE' &&
      $token->value() eq 'vs')
  {
    # A leading VS happens a few times.
    my $chain2 = Chain->new();
    $chain->copy_from(1, $chain2);
    $chain->truncate_directly_before(1);
    $chain->complete_if_last_is(0, 'DESTROY');
    splice(@$chains, 1, 0, $chain2);

    $cno = 1;
    $chain = $chain2;
    return unless $chain->last() >= 2;
  }

  for my $i (1 .. -1 + $chain->last())
  {
    my $token = $chain->check_out($i);
    next unless $token->category() eq 'SINGLETON' &&
      $token->field() eq 'PARTICLE' &&
      $token->value() eq 'vs';

    my ($first, $last);
    get_vs_extent($chain, $i, \%VS_VALID, \$first, \$last);

    if ($first < $i && $last > $i)
    {
      process_vs_extent($chains, $chain, $cno, $first, $last, 'COMPLETE');
      last;
    }

    get_vs_extent($chain, $i, \%VS_DESTROY, \$first, \$last);

    if ($first < $i && $last > $i)
    {
      process_vs_extent($chains, $chain, $cno, $first, $last, 'KILLED');
      last;
    }
  }
}


sub pre_process
{
  my ($chains) = @_;

  # At this point there is a single chain.
  # It's easier to solve for the team vs team chain here.

  pre_process_vs($chains);
}

1;
