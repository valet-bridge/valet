#!perl

package Event::Preprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';

use Separators;

our @ISA = qw(Exporter);
our @EXPORT = qw(pre_process);

my @SIMPLE_LIST = qw(NUMERAL ORDINAL LETTER SEPARATOR);
my %SIMPLE_CATEGORIES = map { $_ => 1} @SIMPLE_LIST;


sub split_on_kill
{
  my ($chains) = @_;

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];

    $chain->clean_separators();

    for my $index (0 .. $chain->last())
    {
      next unless $chain->category($index) eq 'KILL' ||
        $chain->field($index) eq 'DESTROY';

      my $chain2 = $chain->kill_on($index);
      if (defined $chain2)
      {
        splice(@$chains, $chain_no+1, 0, $chain2);
        last;
      }
    }
    $chain_no++;
  }
}


sub merge_counter_on_virtual
{
  my ($chains) = @_;

  # Tightly coupled, e.g. "2B" surrounded by non-virtual separators.

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];
    if ($chain->last() < 2)
    {
      $chain_no++;
      next;
    }

    my $index = 0;
    while ($index <= $chain->last()-2)
    {
      if ($chain->category($index) ne 'SINGLETON' ||
          $chain->field($index) ne 'NUMERAL' ||
          $chain->category($index+1) ne 'SEPARATOR' ||
          $chain->field($index+1) != $SEPARATORS{VIRTUAL} ||
          $chain->category($index+2) ne 'SINGLETON' ||
          $chain->field($index+2) ne 'LETTER')
      {
        $index++;
        next;
      }

      if ($index > 0 &&
         ($chain->category($index-1) ne 'SEPARATOR' ||
          $chain->field($index-1) == $SEPARATORS{VIRTUAL}))
      {
        $index++;
        next;
      }

      if ($index < $chain->last()-2 &&
         ($chain->category($index+1) ne 'SEPARATOR' ||
          $chain->field($index+1) == $SEPARATORS{VIRTUAL}))
      {
        $index++;
        next;
      }

      my %hash = (
        NUMBER => $chain->value($index),
        LETTER => $chain->value($index+2));
      my $token = $chain->check_out($index);
      $token->set_counter(\%hash);

      $chain->collapse_elements($index, $index+2);
      $chain->delete($index+1, $index+2);

      $index++;
    }
    $chain_no++;
  }
}


sub split_on_some_iters
{
  my ($chains) = @_;

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];
    if ($chain->status() eq 'OPEN' && $chain->category(0) eq 'ITERATOR')
    {
      my $index = 1;
      while ($index <= $chain->last() &&
          exists $SIMPLE_CATEGORIES{$chain->category($index)})
      {
        $index++;
      }

      if ($index <= $chain->last() &&
          $chain->category($index) eq 'ITERATOR')
      {
        my $chain2 = $chain->split_on($index);
        splice(@$chains, $chain_no+1, 0, $chain2);
      }
    }
    $chain_no++;
  }
}


sub split_on_singleton
{
  my ($chains) = @_;

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];
    if ($chain->status() eq 'OPEN')
    {
      for my $index (0 .. $chain->last())
      {
        next unless $chain->category($index) eq 'SINGLETON';
        next if $chain->field($index) eq 'PARTICLE';
        $chain->complete_if_last_is(0, 'COMPLETE');

        my $field = $chain->field($index);

        if ($chain->last() == 0)
        {
          # Nothing more.
        }
        elsif ($index == 0)
        {
          my $chain2 = $chain->split_on(2);
          $chain->complete_if_last_is(0, 'COMPLETE');
          $chain2->complete_if_last_is(0, 'COMPLETE');
          splice(@$chains, $chain_no+1, 0, $chain2);
        }
        else
        {
          my $chain2 = $chain->split_on($index);
          $chain2->complete_if_last_is(0, 'COMPLETE');
          splice(@$chains, $chain_no+1, 0, $chain2);
        }
        last;
      }
    }
    $chain_no++;
  }
}


sub split_on_dash_space
{
  my ($chains) = @_;

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];
    if ($chain->status() eq 'OPEN')
    {
      for my $index (1 .. $chain->last()-1)
      {
        next unless $chain->category($index) eq 'SEPARATOR';

        my $field = $chain->field($index);
        if (($field & $SEPARATORS{DASH}) &&
            ($field & $SEPARATORS{SPACE}))
        {
          $index++;
          while ($index <= $chain->last() &&
              $chain->category($index) eq 'SEPARATOR')
          {
            $index++;
          }

          die "Should not happen" if $index > $chain->last();

          my $chain2 = $chain->split_on($index);
          $chain2->complete_if_last_is(0, 'COMPLETE');
          splice(@$chains, $chain_no+1, 0, $chain2);
          last;
        }

      }
    }
    $chain_no++;
  }
}


sub split_on_most_parens
{
  my ($chains) = @_;

  my $chain_no = 0;
  while ($chain_no <= $#$chains)
  {
    my $chain = $chains->[$chain_no];
    if ($chain->status() eq 'OPEN')
    {
      for my $index (0 .. $chain->last()-1)
      {
        # Look for '('.
        next unless $chain->category($index) eq 'SEPARATOR';
        next unless $chain->field($index) & $SEPARATORS{LEFT_PAREN};

        # Avoid '(of'.
        my $index2 = $index + 1;
        next if ($chain->category($index2) eq 'SINGLETON' &&
            $chain->field($index2) eq 'PARTICLE' &&
            $chain->value($index2) eq 'Of');

        my $chain2 = $chain->split_on($index+1);
        splice(@$chains, $chain_no+1, 0, $chain2);

        # Look for ')' in the new chain.
        # It would be a bug if we started out with (3) (of 7),
        # as we would find the first and not the second right paren.
        while ($index2 <= $chain2->last() &&
            ($chain2->category($index2) ne 'SEPARATOR' ||
             ($chain2->field($index2) & $SEPARATORS{RIGHT_PAREN}) == 0))
        {
          $index2++;
        }
        last if $index2 > $chain->last();

        my $chain3 = $chain2->split_on($index2+1);
        splice(@$chains, $chain_no+1, 0, $chain3);

        $chain2->complete_if_last_is(0, 'COMPLETE');

        $chain_no++;
        last;
      }
    }
    $chain_no++;
  }
}


sub pre_process
{
  my ($chains) = @_;

  split_on_kill($chains);
  merge_counter_on_virtual($chains);
  split_on_singleton($chains);
  split_on_dash_space($chains);
  split_on_most_parens($chains);
  split_on_some_iters($chains);
}

1;
