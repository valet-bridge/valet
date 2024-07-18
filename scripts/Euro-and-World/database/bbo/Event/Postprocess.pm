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


sub post_process_stand_alone_doubles
{
  my ($chains) = @_;

  for my $chain (@$chains)
  {
    next unless $chain->last() == 2;

    my $token0 = $chain->check_out(0);
    my $token1 = $chain->check_out(1);
    my $token2 = $chain->check_out(2);

    die "Expected separator" unless $token1->category() eq 'SEPARATOR';

    if ($token0->category() eq 'ITERATOR' &&
        $token2->category() eq 'COUNTER')
    {
      if ($token0->field() eq 'AMBIGUOUS')
      {
        $token0->set_general('MARKER', $token0->field(), 
          $token0->value() . ' ' . $token2->value());
      }
      else
      {
        $token0->set_general('MARKER', $token0->field(), $token2->value());
      }
      $chain->delete(1, 2);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($token0->category() eq 'ITERATOR' &&
        $token2->field() eq 'LETTER')
    {
      $token0->set_general('MARKER', $token0->field(), $token2->value());
      $chain->delete(1, 2);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($token0->category() eq 'ITERATOR' &&
           $token0->field() eq 'GROUP' &&
        $token2->category() eq 'AMBIGUOUS')
    {
      $token0->set_general('MARKER', $token0->field(), $token2->value());
      $chain->delete(1, 2);
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
  }
}


sub post_process_disambiguate
{
  my ($chains) = @_;

  my $ccount = $#$chains;
  for my $cno (0 .. $ccount)
  {
    my $chain = $chains->[$cno];
    next unless $chain->last() == 0;
    next unless ($cno == 0 || 
      $chains->[$cno-1]->status() eq 'COMPLETE' ||
      $chains->[$cno-1]->status() eq 'KILLED');
    next unless ($cno == $ccount || 
      $chains->[$cno-1]->status() eq 'COMPLETE' ||
      $chains->[$cno-1]->status() eq 'KILLED');

    my $token0 = $chain->check_out(0);
    next unless $token0->category() eq 'AMBIGUOUS';

    # TODO Should this whole thing be somewhere central?
    # Perhaps also used in Chainify?

    my $letter = $token0->field();
    if ($letter eq 'F')
    {
      $token0->set_general('SINGLETON', 'STAGE', 'Final');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($letter eq 'G')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Juniors');

      # TODO Add a chain instead
      my $token1 = Token->new();
      $token1->copy_origin_from($token0);
      $token1->set_separator('VIRTUAL');
      $chain->append($token1);

      my $token2 = Token->new();
      $token2->copy_origin_from($token0);
      $token2->set_general('SINGLETON', 'GENDER', 'Women');
      $chain->append($token2);
      $chain->complete_if_last_is(2, 'COMPLETE');
    }
    elsif ($letter eq 'J')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Juniors');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($letter eq 'K')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Kids');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($letter eq 'O')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Open');

      # TODO Add a chain instead
      my $token1 = Token->new();
      $token1->copy_origin_from($token0);
      $token1->set_separator('VIRTUAL');
      $chain->append($token1);

      my $token2 = Token->new();
      $token2->copy_origin_from($token0);
      $token2->set_general('SINGLETON', 'GENDER', 'Open');
      $chain->append($token2);
      $chain->complete_if_last_is(2, 'COMPLETE');
    }
    elsif ($letter eq 'P')
    {
      $chain->kill_on(0);
    }
    elsif ($letter eq 'S')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Seniors');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($letter eq 'W')
    {
      $token0->set_general('SINGLETON', 'GENDER', 'Women');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    elsif ($letter eq 'Y')
    {
      $token0->set_general('SINGLETON', 'AGE', 'Youngsters');
      $chain->complete_if_last_is(0, 'COMPLETE');
    }
    else
    {
      die "$letter";
    }
  }
}



sub post_process
{
  my ($chains) = @_;

  post_process_ordinal_nn($chains);
  post_process_stand_alone_doubles($chains);
  post_process_disambiguate($chains);
}

1;
