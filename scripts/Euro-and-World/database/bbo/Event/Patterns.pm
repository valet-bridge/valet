#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Event::Patterns;

our @ISA = qw(Exporter);
our @EXPORT = qw(process_patterns @RMATCH);

use lib '../..';

use Month;
my $month = Month->new();


sub process_general
{
  # Nothing to do.
}


sub process_date
{
  # 13 December 2004.
  my ($chain, $match) = @_;

  my $month_val = $chain->value($match+2);
  die "$month_val not a month" unless $month->valid($month_val);

  my $day = $chain->value($match);
  $day = '0' . $day if $day < 10;

  my $str = $chain->value($match+4) . '-' . 
    $month->number($month_val) . '-' . 
    $day;

  my $token = $chain->check_out($match);
  $token->set_singleton('DATE', $str);
}


sub process_day_month
{
  # 13 December.
  my ($chain, $match) = @_;

  my $month_val = $chain->value($match+2);
  die "$month_val not a month" unless $month->valid($month_val);

  my $day = $chain->value($match);
  $day = '0' . $day if $day < 10;

  my $str = $month->number($month_val) . '-' . $day;

  my $token = $chain->check_out($match);
  $token->set_singleton('MONTH_DAY', $str);
}


sub process_month_year
{
  # December 2004.
  my ($chain, $match) = @_;

  my $month_val = $chain->value($match);
  die "$month_val not a month" unless $month->valid($month_val);

  my $str = $chain->value($match+2) . '-' . $month->number($month_val);

  my $token = $chain->check_out($match);
  $token->set_singleton('YEAR_MONTH', $str);
}


sub process_swap
{
  my ($chain, $match) = @_;
  $chain->swap($match, $match+2);
}


sub process_merge_02
{
  # R 3A
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('', $chain->check_out($match+2));
}


sub process_merge_0of2
{
  # 7_9, 7/9
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('of', $chain->check_out($match+2));
}


sub process_merge_0colon2
{
  # 6:1
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters(':', $chain->check_out($match+2));
}


sub process_merge_0of4
{
  # 7 of 9, 7th of 9
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('of', $chain->check_out($match+4));
}


sub process_merge_0sep2
{
  # 19-21.  Use the native separator.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);

  my $sep_field = $chain->field($match+1);
  my $sep;
  if ($sep_field == 0x1)
  {
    $sep = ' ';
  }
  elsif ($sep_field == 0x10)
  {
    $sep = '-';
  }
  elsif ($sep_field == 0x20)
  {
    $sep = '_';
  }
  else
  {
    die "Unknown separator field in this context: $sep_field";
  }

  $token->merge_counters($sep, $chain->check_out($match+2));
}


sub process_merge_0dash4
{
  # 19-21 with a particle.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  $token->merge_counters('-', $chain->check_out($match+4));
}


sub process_merge_2dash4
{
  # Boards 19-21.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match+2);
  $token->merge_counters('-', $chain->check_out($match+4));
}


sub process_kill
{
}


sub process_r_counter
{
  # R counter.
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  my $letter = uc($token->value());

  if ($letter eq 'R')
  {
    $token->reset_iterator_field('ROUND');
  }
  elsif ($letter eq 'T')
  {
    $token->reset_iterator_field('TABLE');
  }
  else
  {
    die "Unexpected letter $letter";
  }
}


sub process_og_front
{
  # Exactly the entry 'Open' or 'G' for Girls.
  # Take it to mean open gender, open age / juniors.
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  my $letter = uc($token->value());

  if ($letter eq 'O')
  {
    $token->set_singleton('GENDER', 'Open');
  }
  else
  {
    $token->set_singleton('GENDER', 'Women');
  }

  my $token2 = Token->new();
  $token2->copy_origin_from($token);
  $token2->set_separator('VIRTUAL');
  $chain->insert_at(1, $token2);

  my $token3 = Token->new();
  $token3->copy_origin_from($token);

  if ($letter eq 'O')
  {
    $token3->set_singleton('AGE', 'Open');
  }
  elsif ($letter eq 'G')
  {
    $token3->set_singleton('AGE', 'Juniors');
  }
  else
  {
    die "Unknown OG";
  }

  $chain->insert_at(2, $token3);
}


sub process_letter_exact
{
  my ($chain, $match) = @_;

  my $token = $chain->check_out(0);
  my $letter = uc($token->value());

  if ($letter eq 'J')
  {
    $token->set_singleton('AGE', 'Juniors');
  }
  elsif ($letter eq 'Y')
  {
    $token->set_singleton('AGE', 'Youngsters');
  }
  elsif ($letter eq 'K')
  {
    $token->set_singleton('AGE', 'Kids');
  }
  elsif ($letter eq 'W')
  {
    $token->set_singleton('GENDER', 'Women');
  }
  else
  {
    die "Unexpected letter $letter";
  }
}


sub process_letter_counter_exact
{
  # R 3
  my ($chain, $match) = @_;

  my $token = $chain->check_out($match);
  my $letter = uc($token->value());

  if ($letter eq 'R')
  {
    $token->reset_iterator_field('ROUND');
  }
  else
  {
    $token->reset_iterator_field($letter);
  }
}


sub process_patterns
{
  # sep_flag is 1 if there are alternating separators,
  # 0 otherwise.

  my ($reductions, $chains, $sep_flag, $rstats) = @_;

  my $rno = 0;
  for my $reduction (@$reductions)
  {
    my $plen = $#{$reduction->{PATTERN}};
    my $chain_no = 0;

    while ($chain_no <= $#$chains)
    {
      my $chain = $chains->[$chain_no];

      while ($chain->status() eq 'OPEN' &&
        (my $match = $chain->match(
          $reduction->{PATTERN}, 
          $reduction->{ANCHOR})) >= 0)
      {
        $rstats->[$rno]++;
        $reduction->{METHOD}->($chain, $match);

        my $cstatus;
        if ($reduction->{METHOD} eq \&process_kill)
        {
          $cstatus = 'KILLED';
        }
        else
        {
          $cstatus = 'COMPLETE';
        }

        if ($reduction->{KEEP_LAST} < $plen)
        {
          $chain->collapse_elements(
            $match + $reduction->{KEEP_LAST}, 
            $match + $plen);

          $chain->delete(
            $match + $reduction->{KEEP_LAST} + 1, 
            $match + $plen);
        }

        # This is probably the same as match == 0.
        $chain->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) if
          $reduction->{COMPLETION};

        if ($reduction->{SPLIT_BACK} && 
            $match + $reduction->{KEEP_LAST} < $chain->last())
        {
          my $chain2;
          if ($sep_flag)
          {
            $chain2 = $chain->split_on(
              $match + $reduction->{KEEP_LAST} + 2);

            $chain2->complete_if_last_is(0, 'COMPLETE');
          }
          else
          {
            $chain2 = $chain->split_directly_on(
              $match + $reduction->{KEEP_LAST} + 1);
          }

          $chain->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) if
            $reduction->{COMPLETION};
          splice(@$chains, $chain_no+1, 0, $chain2);
        }

        if ($reduction->{SPLIT_FRONT} && $match > 0)
        {
          my $chain2;
          if ($sep_flag)
          {
            $chain2 = $chain->split_on($match);
            $chain->complete_if_last_is(0, 'COMPLETE');
          }
          else
          {
            $chain2 = $chain->split_directly_on($match);
          }

          $chain2->complete_if_last_is($reduction->{KEEP_LAST}, $cstatus) 
            if $reduction->{COMPLETION};
          splice(@$chains, $chain_no+1, 0, $chain2);
        }
      }
      $chain_no++;
    }
    $rno++;
  }
}

1;
