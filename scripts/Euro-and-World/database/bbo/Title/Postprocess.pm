#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Title::Postprocess;

our @ISA = qw(Exporter);
our @EXPORT = qw(post_process);

use lib '.';


sub ordinalize
{
  my ($value) = @_;

  my $last = substr($value, -1);

  if ($last == 1)
  {
    return $value . 'st';
  }
  elsif ($last == 2)
  {
    return $value . 'nd';
  }
  elsif ($last == 3)
  {
    return $value . 'rd';
  }
  else
  {
    return $value . 'th';
  }
}


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
  return unless $token1->category() eq 'SINGLETON' &&
    $token1->field() eq 'ITERATOR';

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
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'AMBIGUOUS'))
    {
      $chain->complete_if_last_is(0, 'DESTROY');
    }
    elsif ($cat eq 'SINGLETON' &&
        ($field eq 'ITERATOR' &&
        $token->value() eq 'Match'))
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
    print "YYY ", $token0->field(), ", ", $token1->field(), "\n";
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


sub post_process
{
  my ($chains) = @_;

  post_process_first_numeral($chains);
  post_process_last_iterator($chains);
  post_process_last_numeral($chains);
  post_process_stand_alone_singles($chains);
  post_process_sandwiched_singles($chains);
  post_process_stand_alone_doubles($chains);

}

1;
