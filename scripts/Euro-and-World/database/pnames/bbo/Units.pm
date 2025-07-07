#!perl

package Units;

# This is a bit like a chain, but not as rigidly defined.

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw();


my %CERTAIN_WORDS =
(
  BASES => 1,
  OPENINGS => 1,
  CONSTRUCTIVE => 1,
  COMPETITIVE => 1,
  BLACKWOOD => 1,
  BERGEN => 1,
  MISC => 1,
  KEYCARD => 1,
  STAYMAN => 1,
  CARDING => 1,
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  $self->{UNITS} = [];
  return $self;
}


sub last
{
  my ($self, $index) = @_;
  return $#{$self->{UNITS}};
}


sub category
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $#{$self->{UNITS}};
  return $self->{UNITS}[$index]{CATEGORY};
}


sub value
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $#{$self->{UNITS}};
  return $self->{UNITS}[$index]{VALUE};
}


sub push
{
  my ($self, $category, $text, $value, $pos, $chain_stats) = @_;

  push @{$self->{UNITS}}, 
    { CATEGORY => $category, TEXT => $text, VALUE => $value, POS => $pos };

  if ($category eq 'WORD')
  {
    $chain_stats->{WORDS}{$value}++;
  }
  elsif ($category eq 'HIGH_WORD')
  {
    $chain_stats->{HIGH_WORDS}{$value}++;
  }
  else
  {
    $chain_stats->{CATEGORIES}{$category}++;
  }
}


sub decrement_stats
{
  # Not a class method.
  my ($old_category, $old_value, $chain_stats) = @_;

  if ($old_category eq 'WORD')
  {
    $chain_stats->{WORDS}{$old_value}--;
  }
  elsif ($old_category eq 'HIGH_WORD')
  {
    $chain_stats->{HIGH_WORDS}{$old_value}--;
  }
  else
  {
    $chain_stats->{CATEGORIES}{$old_category}--;
  }
}


sub reslot
{
  my ($self, $index, $new_category, $new_value, $chain_stats) = @_;

  my $new_text = '';
  my $unit = $self->{UNITS}[$index];
  my $category = $unit->{CATEGORY};
  my $value = $unit->{VALUE};

  decrement_stats($category, $value, $chain_stats);

  $chain_stats->{CATEGORIES}{$new_category}++;
  $self->{UNITS}[$index]{CATEGORY} = $new_category;
  $self->{UNITS}[$index]{VALUE} = $new_value;
}


sub collapse
{
  my ($self, $lower, $upper, $new_category, $new_value, $chain_stats) = @_;

  my $new_text = '';
  for my $no ($lower .. $upper)
  {
    my $unit = $self->{UNITS}[$no];
    my $category = $unit->{CATEGORY};
    my $value = $unit->{VALUE};
    $new_text .= $unit->{TEXT};

    decrement_stats($category, $value, $chain_stats);
  }

  $chain_stats->{CATEGORIES}{$new_category}++;
  $self->{UNITS}[$lower]{CATEGORY} = $new_category;
  $self->{UNITS}[$lower]{VALUE} = $new_value;
  $self->{UNITS}[$lower]{TEXT} = $new_text;

  return if $lower == $upper;

  $self->{UNITS}[$lower]{POS} = 
    $self->{UNITS}[$lower]{POS} . " to " . 
    $self->{UNITS}[$upper]{POS};

  splice(@{$self->{UNITS}}, $lower+1, $upper - $lower);
}


sub str_core_range
{
  my ($self, $uno_lower, $uno_upper) = @_;

  my $u0 = ($uno_lower < 0 ? 0 : $uno_lower);

  my $len = $#{$self->{UNITS}};
  my $u1 = ($uno_upper > $len ? $len : $uno_upper);

  my $merge = '';
  for my $no ($u0 .. $u1)
  {
    $merge .= $self->{UNITS}[$no]{TEXT};
  }

  my $d0 = ($u0 == 0 ? '|' : '.');
  my $d1 = ($u1 == $#{$self->{UNITS}} ? '|' : '.');
  return "$d0$merge$d1";
}


sub print_range
{
  my ($self, $uno_lower, $uno_upper, $text) = @_;
  print "$text: " .  $self->str_core_range( $uno_lower, $uno_upper) . "\n";
}


sub print_context
{
  my ($self, $uno_lower, $uno_upper, $text) = @_;

  my $str = $self->str_core_range($uno_lower, $uno_upper);

  my $prev = $self->find_previous_unmatched($uno_lower-1);
  my $sprev = '';
  if ($prev >= 0)
  {
    $sprev = $self->{UNITS}[$prev]{VALUE};
  }
  else
  {
    $prev = $self->find_previous_substantial($uno_lower-1);
    if ($prev >= 0)
    {
      $sprev = $self->{UNITS}[$prev]{VALUE} . ' § ';
    }
  }

  my $foll = $self->find_next_unmatched($uno_upper+1);
  my $sfoll = '';
  if ($foll >= 0)
  {
    $sfoll = $self->{SELF}[$foll]{VALUE};
  }
  else
  {
    $foll = $self->find_next_substantial($uno_upper+1);
    if ($foll >= 0)
    {
      $sfoll = ' § ' . $self->{UNITS}[$foll]{VALUE};
    }
  }

  print "$text: $sprev $str $sfoll\n";
}


sub find_first_equal_anywhere
{
  my ($self, $category, $value) = @_;

  for my $no (0 .. $#{$self->{UNITS}})
  {
    if ($self->{UNITS}[$no]{CATEGORY} eq $category &&
        $self->{UNITS}[$no]{VALUE} eq $value)
    {
      return $no;
    }
  }

  return -1;
}


sub find_first_equal_forward
{
  my ($self, $start, $category, $value, $positives) = @_;

  for my $no ($start .. $#{$self->{UNITS}})
  {
    my $unit = $self->{UNITS}[$no];
    my $cat = $unit->{CATEGORY};
    my $val = $unit->{VALUE};

    if ($cat eq $category)
    {
      return ($val eq $value ? $no : -1);
    }
    elsif ($cat eq 'WORD')
    {
      return (exists $positives->{lc($val)} ? $no : -1);
    }
    elsif ($cat ne 'PUNCTUATION')
    {
      # Contradiction.
      return -1;
    }
  }

  # Reached the end.
  return -2;
}


sub find_first_equal_backward
{
  my ($self, $start, $category, $value, $positives) = @_;

  for my $no (reverse 0 .. $start)
  {
    my $unit = $self->{UNITS}[$no];
    my $cat = $unit->{CATEGORY};
    my $val = $unit->{VALUE};

    if ($cat eq $category)
    {
      return ($val eq $value ? $no : -1);
    }
    elsif ($cat eq 'WORD')
    {
      return (exists $positives->{lc($val)} ? $no : -1);
    }
    elsif ($cat ne 'PUNCTUATION')
    {
      # Contradiction.
      return -1;
    }
  }

  # Reached the end.
  return -2;
}


sub find_first_range_forward
{
  my ($self, $start, $category, $lower, $upper) = @_;

  for my $no ($start .. $#{$self->{UNITS}})
  {
    my $unit = $self->{UNITS}[$no];
    my $cat = $unit->{CATEGORY};
    my $val = $unit->{VALUE};

    if ($cat eq 'WORD')
    {
      return -1 unless ($val eq 'to' || $val eq 'a');
    }
    elsif ($cat eq 'HIGH_WORD')
    {
      return -1 unless ($val eq 'à');
    }
    elsif ($cat eq $category)
    {
      return ($val >= $lower && $val <= $upper ? $no : -1);
    }
    elsif ($cat ne 'PUNCTUATION')
    {
      # Contradiction.
      return -1;
    }
  }

  # Reached the end.
  return -2;
}


sub find_next_unmatched
{
  my ($self, $start) = @_;

  for my $no ($start .. $#{$self->{UNITS}})
  {
    my $unit = $self->{UNITS}[$no];
    my $cat = $unit->{CATEGORY};

    if ($cat eq 'WORD' || $cat eq 'HIGH_WORD')
    {
      return $no;
    }
    elsif ($cat ne 'PUNCTUATION')
    {
      return -1;
    }
  }
  return -1;
}


sub find_previous_unmatched
{
  my ($self, $start) = @_;

  for my $no (reverse 0 .. $start)
  {
    my $unit = $self->{UNITS}[$no];
    my $cat = $unit->{CATEGORY};

    if ($cat eq 'WORD' || $cat eq 'HIGH_WORD')
    {
      return $no;
    }
    elsif ($cat ne 'PUNCTUATION')
    {
      return -1;
    }
  }
  return -1;
}


sub find_next_substantial
{
  my ($self, $start) = @_;

  for my $no ($start .. $#{$self->{UNITS}})
  {
    return $no unless $self->{UNITS}[$no]{CATEGORY} eq 'PUNCTUATION';
  }
  return -1;
}


sub find_previous_substantial
{
  my ($self, $start) = @_;

  for my $no (reverse 0 .. $start)
  {
    return $no unless $self->{UNITS}[$no]{CATEGORY} eq 'PUNCTUATION';
  }
  return -1;
}


sub find_one_or_two_forward
{
  my ($self, $start, $category, $value,
    $hash_one_word, $hash_two_words) = @_;

  # Often looking for NT, hence the name.
  my $nt = $self->find_first_equal_forward($start,
    $category, $value, $hash_one_word);

  if ($nt == -2)
  {
    return -1;
  }
  elsif ($nt >= 0)
  {
    return $nt;
  }

  # Also look for certain two-component matches.
  my $first = $self->find_next_unmatched($start);
  return -1 if $first == -1;

  my $value1 = $self->{UNITS}[$first]{VALUE};
  return -1 unless exists $hash_two_words->{$value1};

  my $second = $self->find_next_unmatched($first+1);
  return -1 if $second == -1;

  my $value2 = $self->{UNITS}[$first]{VALUE};
  return -1 unless exists $hash_two_words->{$value1}{$value2};

  return $second;
}


sub find_one_or_two_backward
{
  my ($self, $start, $category, $value,
    $hash_one_word, $hash_two_words) = @_;

  # Often looking for NT, hence the name.
  my $nt = $self->find_first_equal_backward($start,
    $category, $value, $hash_one_word);

  return $nt if $nt >= 0;

  # Also look for two-component matches.
  my $first = $self->find_previous_unmatched($start);
  return -1 if $first == -1;

  my $value1 = $self->{UNITS}[$first]{VALUE};
  return -1 unless exists $hash_two_words->{$value1};

  my $second = $self->find_previous_unmatched($first-1);
  return -1 if $second == -1;

  my $value2 = $self->{UNIT}[$first]{VALUE};
  return -1 unless exists $hash_two_words->{$value1}{$value2};

  return $second;
}


sub nice_lower_neighbor
{
  my ($self, $lower) = @_;

  my $prev = $self->find_previous_substantial($lower-1);

  return 1 if $prev < 0; # Nothing meaningful in front
  return 1 if exists $CERTAIN_WORDS{$self->{UNITS}[$prev]{CATEGORY}};

  return 0;
}


sub nice_upper_neighbor
{
  my ($self, $upper) = @_;

  my $next = $self->find_next_substantial($upper+1);

  return 1 if $next < 0; # Nothing meaningful following
  return 1 if exists $CERTAIN_WORDS{$self->{UNITS}[$next]{CATEGORY}};

  return 0;
}


sub nice_neighbors
{
  my ($self, $lower, $upper) = @_;

  return 
    $self->nice_lower_neighbor($lower) &&
    $self->nice_upper_neighbor($upper);
}


sub get_number_streaks
{
  my ($self, $streaks) = @_;

  my $streak_no = 0;
  my $streak_flag = 0;

  my $i = 0;
  my $len = $#{$self->{UNITS}};
  while ($i <= $len)
  {
    my $s = $self->find_next_substantial($i);
    return if $s < 0;

    my $cat = $self->{UNITS}[$s]{CATEGORY};
    if ($cat eq 'INT_SMALL' || $cat eq 'INT_MEDIUM' ||
        $cat eq 'INT_LARGE' || $cat eq 'INT_TEXTISH')
    {
      $streak_flag = 1;
      CORE::push @{$streaks->[$streak_no]}, $s;
    }
    elsif ($streak_flag)
    {
      $streak_flag = 0;
      $streak_no++;
    }
    $i = $s+1;
  }
}

1;
