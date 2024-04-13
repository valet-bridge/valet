#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

package Chains;

use lib '.';
use lib '..';

use Tchar;
use Separators;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  process_event
  post_process_event
  %CATEGORIES);

use Age;
use City;
use Country;
use Date;
use Form;
use Gender;
use Memorial;
use Movement;
use Organizer;
use Origin;
use Scoring;
use Sponsor;
use Stage;
use Tname;
use Twords;
use Weekday;

our %CATEGORIES;
$CATEGORIES{AGE} = Age->new();
$CATEGORIES{CITY} = City->new();
$CATEGORIES{COUNTRY} = Country->new();
$CATEGORIES{DATE} = Date->new();
$CATEGORIES{FORM} = Form->new();
$CATEGORIES{GENDER} = Gender->new();
$CATEGORIES{MEMORIAL} = Memorial->new();
$CATEGORIES{MOVEMENT} = Movement->new();
$CATEGORIES{ORGANIZER} = Organizer->new();
$CATEGORIES{ORIGIN} = Origin->new();
$CATEGORIES{SCORING} = Scoring->new();
$CATEGORIES{SPONSOR} = Sponsor->new();
$CATEGORIES{STAGE} = Stage->new();
$CATEGORIES{TNAME} = Tname->new();
$CATEGORIES{TOURNAMENT} = Twords->new();
$CATEGORIES{WEEKDAY} = Weekday->new();


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
      next unless $chain->category($index) eq 'KILL';

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
        BASE_NUMBER => $chain->value($index),
        BASE_LETTER => $chain->value($index+2));
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
        $chain->complete_if_last_is(0, 'COMPLETE');

        my $field = $chain->field($index);
        my $obj = $CATEGORIES{$field};
        next unless defined $obj;

        if (! $obj->valid($chain->value($index)))
        {
          die "No SINGLETON $field, " . $chain->value->($index);
        }

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
        $chain_no++;
        last;
      }
    }
    $chain_no++;
  }
}


sub process_event
{
  my ($chains) = @_;

  split_on_kill($chains);
  merge_counter_on_virtual($chains);
  split_on_singleton($chains);
  split_on_dash_space($chains);
  split_on_most_parens($chains);
  split_on_some_iters($chains);
}


sub synthetic_singleton
{
  my ($solved_ref, $elem, $category, $die_flag) = @_;

  if (exists $solved_ref->{$category})
  {
    die "Already $category?" if $die_flag;
    return;
  }

  $elem->{CATEGORY} = $category;

  $solved_ref->{$category} = Tchar->new();
  $solved_ref->{$category}->set('SINGLETON', $elem);
}


sub fix_some_singletons_manually
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    if ($#$chain == 0)
    {
      my $elem = $chain->[0];
      my $cat = $elem->{CATEGORY};
      my $value = $elem->{VALUE};

      if (($cat eq 'TOURNAMENT' && $value eq 'Open') ||
          ($cat eq 'LETTER' && $value eq 'O'))
      {
        $elem->{VALUE} = 'Open';

        # This should mean no gender nor age restriction.
        synthetic_singleton($solved_ref, $elem, 'AGE', 0);
        synthetic_singleton($solved_ref, $elem, 'GENDER', 0);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'TOURNAMENT')
      {
        if ($value ne 'Super')
        {
          synthetic_singleton($solved_ref, $elem, 'TOURNAMENT', 1);
        }

        splice(@$chain, 0);
      }
      elsif ($cat eq 'GROUP' || $cat eq 'BOARDS')
      {
        splice(@$chain, 0);
      }
      elsif ($cat eq 'GENDER' || $cat eq 'TEMPORAL')
      {
        synthetic_singleton($solved_ref, $elem, $cat, 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'W')
      {
        $elem->{VALUE} = 'Women';
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'J')
      {
        $elem->{VALUE} = 'Juniors';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'Y')
      {
        $elem->{VALUE} = 'Youngsters';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value eq 'K')
      {
        $elem->{VALUE} = 'Kids';
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);

        splice(@$chain, 0);
      }
      elsif ($chain_no == 0 && $cat eq 'LETTER' && $value eq 'G')
      {
        $elem->{VALUE} = 'Juniors';
        synthetic_singleton($solved_ref, $elem, 'AGE', 0);

        $elem->{VALUE} = 'Women';
        synthetic_singleton($solved_ref, $elem, 'GENDER', 0);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'LETTER' && $value =~ /^[A-Ha-h]$/)
      {
        # This should mean no group.
        synthetic_singleton($solved_ref, $elem, 'GROUP', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'ROMAN' && ($value == 1 || $value == 5))
      {
        # Tends to be a leftover from A v B.
        # Not sure about I, but it's rare.

        splice(@$chain, 0);
      }
      elsif ($cat eq 'YEAR')
      {
        synthetic_singleton($solved_ref, $elem, 'YEAR', 1);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'PARTICLE' && 
          ($elem->{text} eq 'OF' || $elem->{text} eq 'FO'))
      {
        # Tends to be OF for Open Final.

        $elem->{VALUE} = 'Open';

        # This should mean no gender nor age restriction.
        synthetic_singleton($solved_ref, $elem, 'AGE', 1);
        synthetic_singleton($solved_ref, $elem, 'GENDER', 1);

        die "Already $cat?" if exists $solved_ref->{Final};

        $elem->{CATEGORY} = 'ITERATOR';
        $elem->{VALUE} = 'Final';
        $solved_ref->{Final} = Tchar->new();
        $solved_ref->{Final}->set('COUNTER_NONE', $elem);

        splice(@$chain, 0);
      }
      elsif ($cat eq 'PARTICLE' && $value eq 'vs')
      {
        # Delete
        splice(@$chain, 0);
      }
    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub fix_some_tripletons_manually
{
  my ($chains_ref, $solved_ref) = @_;

  my $chain_no = 0;
  my $chain_max = -1 + scalar keys %$chains_ref;

  do
  {
    my $chain = $chains_ref->{$chain_no};
    if ($#$chain == 2)
    {
      my $elem0 = $chain->[0];
      my $elem1 = $chain->[1];
      my $elem2 = $chain->[2];

      if ($elem0->{CATEGORY} eq 'NUMERAL' &&
          $elem2->{CATEGORY} eq 'LETTER')
      {
        # 2 B: Treat this as a generic counter with two values.

        my $category = 'Generic';
        die "Already $category?" if exists $solved_ref->{$category};

        $elem0->{CATEGORY} = $category;

        $solved_ref->{$category} = Tchar->new();
        $solved_ref->{$category}->set('COUNTER_DOUBLE', $elem0,
          $elem0->{VALUE}, $elem2->{VALUE});

        splice(@$chain, 0);
      }
      elsif ($elem0->{CATEGORY} eq 'LETTER' &&
          $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # B 2.

        my $category = 'Generic';
        die "Already $category?" if exists $solved_ref->{$category};

        $elem0->{CATEGORY} = $category;

        $solved_ref->{$category} = Tchar->new();
        $solved_ref->{$category}->set('COUNTER_DOUBLE', $elem0,
          $elem2->{VALUE}, $elem0->{VALUE});

        splice(@$chain, 0);
      }
      elsif ($elem0->{CATEGORY} eq 'MONTH' &&
             $elem2->{CATEGORY} eq 'YEAR')
      {
        # YEAR_MONTH
        # About 5 cases
        print "XXX2\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ORDINAL' &&
             $elem2->{CATEGORY} eq 'ORDINAL')
      {
        # 5th eighth, so generic counter 5 of 8.
        # About 26 cases
        print "XXX3\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem1->{CATEGORY} eq 'SEPARATOR' &&
             $elem1->{text} =~ /_/ &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 2 _ 2, so generic counter 2 of 2.
        # About 84 cases
        print "XXX4\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem1->{CATEGORY} eq 'SEPARATOR' &&
             $elem1->{VALUE} eq 'COLON' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 5:2, so round 5 segment 2.
        # About 250 cases
        print "XXX5\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 140
        print "XXX6\n";
      }
      elsif ($elem0->{CATEGORY} eq 'TOURNAMENT' &&
             $elem2->{CATEGORY} eq 'NUMERAL')
      {
        # 86
        print "XXX7\n";
      }
      elsif ($elem0->{CATEGORY} eq 'NUMERAL' &&
             $elem2->{CATEGORY} eq 'TOURNAMENT')
      {
        # 4
        print "XXX7a\n";
      }
      elsif ($elem0->{CATEGORY} eq 'TOURNAMENT' &&
             $elem2->{CATEGORY} eq 'ITERATOR')
      {
        # 26
        print "XXX8\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'TOURNAMENT')
      {
        # 36
        print "XXX9\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'ITERATOR')
      {
        # 79
        print "XXX10\n";
      }
      elsif ($elem0->{CATEGORY} eq 'ITERATOR' &&
             $elem2->{CATEGORY} eq 'LETTER')
      {
        # 292
        print "XXX11\n";
      }


    }
    $chain_no++;
  }
  while ($chain_no <= $chain_max);
}


sub post_process_event
{
  my ($chains_ref, $solved_ref) = @_;
  
  # More manual processing of some short chains.

  fix_some_singletons_manually($chains_ref, $solved_ref);
  fix_some_tripletons_manually($chains_ref, $solved_ref);
}

1;
