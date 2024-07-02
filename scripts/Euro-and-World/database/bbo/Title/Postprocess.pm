#!perl

package Title::Postprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(post_process);

use lib '.';

use Util;


sub post_process_first_numeral
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED';
    return if $chain->status() eq 'COMPLETE';
    return if $chain->last() > 0;

    my $token = $chain->check_out(0);
    return unless $token->category() eq 'COUNTER';
    return unless $token->field() eq 'NUMERAL';

    # So now we have the first open chain, and it consists
    # of one COUNTER which we turn into an ORDINAL and complete.

    my $value = ordinalize($token->value());
    $token->set_ordinal_counter($value);
    $chain->complete_if_last_is(0, 'COMPLETE');

    return;
  }
}


my %LAST_NUM_DESTROY =
(
  CAPTAIN => 1,
  CITY => 1,
  COUNTRY => 1,
  DESTROY => 1,
  FORM => 1,
  TNAME => 1,
  TWORD => 1,
  YEAR => 1
);

sub post_process_last_numeral
{
  my ($chains) = @_;

  return unless $#$chains >= 1;
  my $chain1 = $chains->[-1];
  return unless $chain1->status() eq 'OPEN';
  return unless $chain1->last() == 0;

  my $token1 = $chain1->check_out(0);
  return unless $token1->category() eq 'COUNTER' &&
    $token1->field() eq 'NUMERAL';

  my $chain0 = $chains->[-2];
  my $token0 = $chain0->check_out($chain0->last());

  if (exists $LAST_NUM_DESTROY{$token0->field()})
  {
    $chain1->complete_if_last_is(0, 'DESTROY');
  }
}


my %NUM_VALID =
(
  AGE => 1,
  GENDER => 1,
  FORM => 1,
  STAGE => 1,
  TNAME => 1,
  TWORD => 1,
  DESTROY => 1
);

sub post_process_last_iterator
{
  my ($chains) = @_;

  # Check whether a lone iterator is preceded by certain tokens,
  # in which case it is destroyed.
  return unless $#$chains >= 1;
  my $chain1 = $chains->[-1];
  return unless $chain1->status() eq 'OPEN';
  return unless $chain1->last() == 0;

  my $token1 = $chain1->check_out(0);
  return unless $token1->category() eq 'ITERATOR';

  my $chain0 = $chains->[-2];
  my $token0 = $chain0->check_out($chain0->last());
  my $cat = $token0->category();
  my $field = $token0->field();

  if ($cat eq 'SINGLETON' && exists $NUM_VALID{$field})
  {
    $chain1->complete_if_last_is(0, 'DESTROY');
  }
  elsif ($chain0->last() == 0 && $cat eq 'COUNTER')
  {
    $chain0->append($token1);
    $chain0->complete_if_last_is(1, 'COMPLETE');
    splice(@$chains, $#$chains, 1);
  }
}


sub post_process_stand_alone_singles
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'OPEN' && $chain->last() == 0;
    my $token = $chain->check_out(0);
    my $cat = $token->category();
    my $field = $token->field();

    if ($cat eq 'COUNTER' && 
        ($field eq 'LETTER' || $field eq 'N_OF_N' || 
         $field eq 'ROMAN'))
    {
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'TIME'))
    {
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($cat eq 'AMBIGUOUS')
    {
      $chain->complete_if_last_is(0, 'DESTROY');
    }
    elsif ($cat eq 'ITERATOR' &&
        lc($token->value()) eq 'match')
    {
      $token->set_singleton('FORM', 'Teams');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
  }
}


my %SANDWICH_LEFT_ORDINAL =
(
  COUNTRY => 1,
  CLUB => 1,
  LETTER => 1
);

my %SANDWICH_RIGHT_ORDINAL =
(
  TNAME => 1,
  TWORD => 1,
  REGION => 1
);

sub post_process_sandwiched_singles
{
  my ($chains) = @_;

  return unless $#$chains >= 2;
  for my $cno (1 .. $#$chains-1)
  {
    my $chain1 = $chains->[$cno];
    next unless $chain1->status() eq 'OPEN';
    next unless $chain1->last() == 0;
    my $token1 = $chain1->check_out(0);
    return unless $token1->category() eq 'COUNTER' &&
      $token1->field() eq 'NUMERAL';

    my $chain0 = $chains->[$cno-1];
    my $token0 = $chain0->check_out($chain0->last());

    my $chain2 = $chains->[$cno+1];
    my $token2 = $chain2->check_out(0);

    if (exists $SANDWICH_LEFT_ORDINAL{$token0->field()} &&
        exists $SANDWICH_RIGHT_ORDINAL{$token2->field()})
    {
      my $value = ordinalize($token1->value());
      $token1->set_ordinal_counter($value);
      $chain1->complete_if_last_is(0, 'COMPLETE');
    }
    else
    {
      $chain1->complete_if_last_is(0, 'DESTROY');
    }
  }
}


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


sub post_process_stand_alone_doubles
{
  my ($chains) = @_;

  # Check for a last chain with two numerals, of which the latter is
  # 1 or 2 and the former is larger.
  my $chain = $chains->[-1];
  return unless $chain->status() eq 'OPEN' && $chain->last() == 1;

  my $token0 = $chain->check_out(0);
  my $token1 = $chain->check_out(1);

  if ($token0->category() eq 'COUNTER' && $token0->field() eq 'NUMERAL')
  {
    if ($token1->category() eq 'COUNTER' && $token1->field() eq 'NUMERAL')
    {
      if ($token0->value() > $token1->value() && $token1->value() < 3)
      {
        post_process_split_two($chains, $chain);
        return;
      }
    }
  }
  elsif ($token0->field() eq 'STAGE' || 
      $token0->field() eq 'TIME')
  {
    post_process_split_two($chains, $chain);
    return;
  }
  else
  {
    # A bit radical.
    $chain->complete_if_last_is(1, 'DESTROY');
  }
}


sub post_process_markers
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'COMPLETE';
    next unless $chain->last() == 1;

    my $token0 = $chain->check_out(0);
    my $token1 = $chain->check_out(1);

    if ($token0->category() eq 'ITERATOR' && 
        $token1->category() eq 'COUNTER')
    {
      $token0->merge_origin($token1);
      $token0->set_general('MARKER', $token0->field(), $token1->value());
      $chain->delete(1, 1);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($token0->category() eq 'COUNTER' && 
        $token1->category() eq 'ITERATOR')
    {
      $token0->merge_origin($token1);
      $token0->set_general('MARKER', $token1->field(), $token0->value());
      $chain->delete(1, 1);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($token0->category() eq 'AMBIGUOUS' && 
        $token1->category() eq 'COUNTER')
    {
      $token0->merge_origin($token1);
      $token0->set_general('MARKER', 'AMBIGUOUS', 
        $token0->value() . ' ' . $token1->value());
      $chain->delete(1, 1);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
  }
}


sub post_process_date_range
{
  my ($chains) = @_;

  for my $cno (reverse 0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next unless $chain->status() eq 'COMPLETE';
    next unless $chain->last() == 2;

    my $token0 = $chain->check_out(0);
    my $token1 = $chain->check_out(1);
    my $token2 = $chain->check_out(2);

    if ($token0->field() eq 'DATE' && 
        $token1->field() eq 'PARTICLE' &&
        $token1->value() eq 'to' &&
        $token2->field() eq 'DATE')
    {
      $token0->set_general('SINGLETON', 'DATE_START', $token0->value());
      $token2->set_general('SINGLETON', 'DATE_END', $token2->value());

      my $chain2 = Chain->new();
      $chain->copy_from(2, $chain2);
      $chain->truncate_directly_before(1);
      $chain->complete_if_last_is(0, 'COMPLETE');
      $chain2->complete_if_last_is(0, 'COMPLETE');
      splice(@$chains, $cno+1, 0, $chain2);
    }
  }
}


sub post_process_vs
{
  my ($chains) = @_;

  for my $cno (reverse 0 .. $#$chains)
  {
    my $chain = $chains->[$cno];
    next unless $chain->status() eq 'COMPLETE';
    next unless $chain->last() >= 2;

    # Find the vs token if it is there.
    my $l = $chain->last();
    my $found = 0;
    my $pno;
    for my $i (1 .. $l-1)
    {
      my $token = $chain->check_out($i);
      if ($token->field() eq 'PARTICLE' &&
          $token->value() eq 'vs')
      {
        $found = 1;
        $pno = $i;
        last;
      }
    }

    next unless $found;

    # Identify the two chains.
    for my $i (0 .. $pno-1)
    {
      my $token = $chain->check_out($i);
      my $tag = 'TEAM1_' . $token->field();
      $token->set_general($token->category(), $tag, $token->value());
    }

    for my $i ($pno+1 .. $l)
    {
      my $token = $chain->check_out($i);
      my $tag = 'TEAM2_' . $token->field();
      $token->set_general($token->category(), $tag, $token->value());
    }

    my $chain1 = Chain->new();
    $chain->copy_from($pno+1, $chain1);
    $chain->truncate_directly_before($pno);
    $chain->complete_if_last_is($pno-1, 'COMPLETE');
    $chain1->complete_if_last_is($l-$pno-1, 'COMPLETE');
    splice(@$chains, $cno+1, 0, $chain1);
  }
}


sub post_process
{
  my ($chains) = @_;

  post_process_first_numeral($chains);
  post_process_last_iterator($chains);
  post_process_last_numeral($chains);
  post_process_stand_alone_singles($chains);
  post_process_sandwiched_singles($chains);
  post_process_stand_alone_doubles($chains);
  post_process_markers($chains);
  post_process_date_range($chains);
  post_process_vs($chains);
}

1;