#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package EventBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(study_event);

use lib '.';
use lib '..';

use Cookbook;
use Separators;
use Token;


sub undate
{
  my ($text, $date_ref) = @_;

  if ($text =~ /(\d\d\d\d)(\d\d)(\d\d)0(\d)/)
  {
    my ($year, $month, $day, $r) = ($1, $2, $3, $4);
    $$date_ref = "$year-$month-$day";
    $text =~ s/\d\d\d\d\d\d\d\d0\d/Round $r /;
  }
  elsif ($text =~ /(\d\d\d\d-\d\d-\d\d)/)
  {
    $$date_ref = $1;
    $text =~ s/\d\d\d\d-\d\d-\d\d/ /;
  }
  elsif ($text =~ /(\d\d\d\d)\.(\d\d)\.(\d\d)/)
  {
    my ($year, $month, $day) = ($1, $2, $3);
    $$date_ref = "$year-$month-$day";
    $text =~ s/\d\d\d\d\.\d\d\.\d\d/ /;
  }
  elsif ($text =~ /(\d\d\d\d)_(\d\d)_(\d\d)/)
  {
    my ($year, $month, $day) = ($1, $2, $3);
    $$date_ref = "$year-$month-$day";
    $text =~ s/\d\d\d\d_\d\d_\d\d/ /;
  }
  return $text;
}


sub split_on_known_words
{
  my ($list_ref) = @_;

  # Some entries may be mashed together.  It's easier to split them
  # out than to try to recognize them later.
  # As there can be several layers of this, we do it recursively.
  # Not very efficiently implemented: Don't have to reexamine elements
  # that could not be split once.
  
  my $hit = 1;
  my $ctr = 0;
  while ($hit)
  {
    $ctr++;
    $hit = 0;
    for my $i (reverse 0 .. $#$list_ref)
    {
      my $part = $list_ref->[$i];
      my $fix = $FIX_HASH{$part};
      next if defined $fix->{VALUE};

      if ($part =~ $FRONT_REGEX)
      {
        my ($front, $back) = ($1, $2);

        # If letter-letter, then not lower-lower.
        next if ($back =~ /^[a-z]/ && $front =~ /[a-z]$/);
        next if ($back =~ /^[A-Z]/ && $front =~ /[A-Z]$/);
        next if $part eq 'MatchPoint';

        splice(@$list_ref, $i, 0, ('') x 2);
        $list_ref->[$i  ] = $front;
        $list_ref->[$i+1] = '|';
        $list_ref->[$i+2] = $back;
        $hit = 1;
        last;
      }

      next if $hit;

      if ($part =~ $BACK_REGEX)
      {
        my ($front, $back) = ($1, $2);
        if ($back =~ /^[a-z]/ && $front =~ /[a-z]$/ &&
            $front ne '2e')
        {
          # If letter-letter, then not lower-lower.
          next;
        }
        next if ($back =~ /^[A-Z]/ && $front =~ /[A-Z]$/);

        splice(@$list_ref, $i, 0, ('') x 2);
        $list_ref->[$i  ] = $front;
        $list_ref->[$i+1] = '|';
        $list_ref->[$i+2] = $back;
        $hit = 1;
        last;
      }
    }
  }
}


sub split_on_digit_groups
{
  my ($list_ref) = @_;

  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];
    $part =~s/#(\d)/$1/g;

    if ($part =~ /\d/ && $part =~ /[^\d]/ &&
      ! is_small_ordinal($part))
    {
      my @a = grep {$_ ne ''} split /(\d+)/, $part;
      die "No real split: $part" unless $#a > 0;

      if ($#a == 1 && $a[0] =~ /^rof$/i)
      {
        # Don't split Rof128 etc.
        next;
      }
      elsif ($#a == 1 && $a[0] eq 'U' && $a[1] <= 31)
      {
        # Don't split U31 etc.
        next;
      }
      elsif ($#a == 1 && $a[0] eq 'BBO' && $a[1] <= 4)
      {
        # Don't split BBO2 etc.
        next;
      }

      my $add = 2 * $#a;
      splice(@$list_ref, $i, 0, ('') x $add);
      for my $j (0 .. $#a)
      {
        $list_ref->[$i + 2*$j] = $a[$j];
        $list_ref->[$i + 2*$j + 1] = '|' unless $j == $#a;
      }
    }
  }
}


sub split_on_pre_group
{
  my ($list_ref, $part, $i) = @_;

  if ($part =~ $PRE_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);
    splice(@$list_ref, $i, 0, ('') x 2);

    my $fix = $FIX_HASH{lc($front)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $front";
    }

    $list_ref->[$i  ] = $fix->{VALUE};
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $back;
    return 1;
  }
  return 0;
}


sub split_on_post_group
{
  my ($list_ref, $part, $i) = @_;

  if ($part =~ $POST_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);
    splice(@$list_ref, $i, 0, ('') x 2);

    my $fix = $FIX_HASH{lc($back)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $back";
    }

    $list_ref->[$i  ] = ($front eq 'W' ? 'Women' : 'Open');
    $list_ref->[$i+1] = '|';
    $list_ref->[$i+2] = $fix->{VALUE};
    return 1;
  }
  return 0;
}


sub split_on_tournament_group
{
  my ($list_ref) = @_;

  # A number of words are commonly followed by A or B.
  
  for my $i (reverse 0 .. $#$list_ref)
  {
    my $part = $list_ref->[$i];

    next if split_on_pre_group($list_ref, $part, $i);

    next if split_on_post_group($list_ref, $part, $i);

    # Kludge.
    if ($part eq 'OR')
    {
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'Open';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = 'Room';
      
    }
    elsif ($part eq 'or')
    {
      $list_ref->[$i  ] = 'Of'; # Typically a typo
    }
    elsif ($part eq 'FO')
    {
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'Final';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = 'Open';
    }
    elsif ($part eq 'OF') # Probably
    {
      splice(@$list_ref, $i, 0, ('') x 2);
      $list_ref->[$i  ] = 'Open';
      $list_ref->[$i+1] = '|';
      $list_ref->[$i+2] = 'Final';
    }
  }
}


sub is_small_integer
{
  my ($part, $token) = @_;

  # Up to 100
  if ($part =~ /^\d+$/ && $part >= 0 && $part < 100)
  {
    $part =~ s/^0+//; # Remove leading zeroes
    $token->set_numeral_counter($part);
    return 1;
  }
  elsif ($part =~ /^#(\d+)$/ && $1 >= 0 && $1 < 100)
  {
    # #10
    my $n = $1;
    $n =~ s/^0+//; # Remove leading zeroes

    $token->set_numeral_counter($n);
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_small_ordinal
{
  my $part = pop;
  if
     ($part =~ /^(\d+)th$/i ||
      $part =~ /^(\d+)rth$/i ||
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rst$/i ||
      $part =~ /^(\d+)rd$/i ||
      $part =~ /^(\d+)er$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    return $1;
  }
  else
  {
    return 0;
  }
}


sub fix_small_ordinal
{
  my ($part, $token) = @_;
  if (my $ord = is_small_ordinal($part))
  {
    # We don't check whether the ending matches the number.
    if ($ord >= 0 && $ord < 100)
    {
      $ord =~ s/^0+//; # Remove leading zeroes
      # $token->set_singleton('ORDINAL', $ord);
      $token->set_ordinal_counter($ord);
      return 1;
    }
    else
    {
      die "Large ordinal? $part";
    }
  }
  else
  {
    return 0;
  }
}


sub is_letter
{
  my ($part, $token) = @_;

  my $lc = lc($part);
  if ($lc =~ /^[abcdefhuv]$/)
  {
    $token->set_letter_counter($part);
    return 1;
  }
  elsif ($lc =~ /^[a-z]$/)
  {
    $token->set_singleton('LETTER', $part);
    return 1;
  }
  else
  {
    return 0;
  }
}


sub is_year
{
  my ($part, $token) = @_;

  if ($part =~ /^\d\d\d\d$/)
  {
    if ($part >= 1900 && $part <= 2100)
    {
      $token->set_singleton('YEAR', $part);
      return 1;
    }
    else
    {
      die "Not a year? $part";
    }
  }
  else
  {
    return 0;
  }
}


sub merge_on_digit_runs
{
  my ($chain) = @_;

  my $N = 3;
  return unless $chain->last() >= 2*($N-1);

  my ($start_index, $end_index, $current_start, $current_count);
  my $previous = undef;
  my $found = 0;

  for (my $index = 0; $index <= $chain->last(); $index++) 
  {
    my $token = $chain->check_out($index);

    # A separator of space or dash is OK, others are not.
    next if ($token->category() eq 'SEPARATOR' &&
        ($token->field() eq $SEPARATORS{SPACE} || 
         $token->field() eq $SEPARATORS{DASH}));

    if ($token->category() ne 'COUNTER' ||
        $token->field() ne 'NUMERAL')
    {
      # Interrupt the run.
      $previous = undef;
      next;
    }

    # Start a new sequence if needed
    if (! defined $previous || 
        $token->value() != $previous + 1) 
    {
      # Check if a valid sequence has been found and is long enough
      if (defined $previous && 
          defined $current_start && 
          $current_count >= $N && 
          ! $found) 
      {
        $start_index = $current_start;
        $end_index = $index - 1;
        $found = 1;
        last;
      }

      # Start a new sequence
      $current_start = $index;
      $current_count = 1;
    } 
    else 
    {
      # Continue the sequence
      $current_count++;
    }

    # Update previous
    $previous = $token->value();
  }

  # Check for the case where the sequence might end at the last element
  if (! $found && defined $current_start && $current_count >= $N) 
  {
    $start_index = $current_start;
    $end_index = $chain->last();
  }

  return unless defined $start_index;

  # Find the next numbered indices from each side.
  my $left_index = $start_index+1;
  while ($left_index < $end_index &&
      ($chain->category($left_index) ne 'COUNTER' ||
       $chain->field($left_index) ne 'NUMERAL'))
  {
    $left_index++;
  }

  my $right_index = $end_index-1;
  while ($right_index > $start_index &&
      ($chain->category($right_index) ne 'COUNTER' ||
       $chain->field($right_index) ne 'NUMERAL'))
  {
    $right_index--;
  }

  die "Huh?" unless $left_index <= $right_index;

  if ($left_index < $right_index)
  {
    $chain->collapse_elements($left_index, $right_index);
    $chain->delete($left_index+1, $right_index);
  }

  $chain->check_out($left_index)->set_singleton('PARTICLE', 'To');
}


sub study_part
{
  # Returns 1 if it is a kill.

  my ($part, $result, $i, $chain, $unknown_ref) = @_;

  my $token = Token->new();
  $token->set_origin($i, $part);
  $chain->append($token);

  return if Separators::set_token($part, $token);

  my $fix = $FIX_HASH{lc($part)};
  if (defined $fix->{CATEGORY})
  {
    if ($fix->{CATEGORY} eq 'KILL' ||
       ($fix->{CATEGORY} eq 'COUNTRY' &&
       ((exists $result->{TEAM1} && $fix->{VALUE} eq $result->{TEAM1}) ||
        (exists $result->{TEAM2} && $fix->{VALUE} eq $result->{TEAM2}))))
    {
      # It could be that the country name is spelled differently
      # in EVENT and TEAMS.
      $token->set_kill($part);
    }
    elsif ($fix->{CATEGORY} eq 'ITERATOR')
    {
      $token->set_iterator_field($fix->{VALUE});
    }
    elsif ($fix->{CATEGORY} eq 'AGE' &&
        $fix->{VALUE} eq 'Girls')
    {
      # Special case signifying both age and gender.

      $token->set_singleton('AGE', 'Juniors');

      my $token2 = Token->new();
      $token2->set_origin($i, $part);
      $chain->append($token2);
      $token2->set_separator('VIRTUAL');

      my $token3 = Token->new();
      $token3->set_origin($i, $part);
      $chain->append($token3);
      $token3->set_singleton('GENDER', 'Women');
    }
    elsif ($fix->{CATEGORY} eq 'NUMERAL')
    {
      $token->set_numeral_counter($fix->{VALUE});
    }
    elsif ($fix->{CATEGORY} eq 'ORDINAL')
    {
      $token->set_ordinal_counter($fix->{VALUE});
    }
    elsif ($fix->{CATEGORY} eq 'ROMAN')
    {
      $token->set_roman_counter($fix->{VALUE});
    }
    else
    {
      $token->set_singleton($fix->{CATEGORY}, $fix->{VALUE});
    }
    return;
  }

  return 0 if is_small_integer($part, $token);
  return 0 if fix_small_ordinal($part, $token);
  return 0 if is_letter($part, $token);
  return 0 if is_year($part, $token);

  print "UNKNOWN $part\n";
  $$unknown_ref++;

  $token->set_unknown($part);
  return 0;
}


sub study_event
{
  my ($text, $cref, $result, $chain, $unknown_ref) = @_;

  if ($cref->{BBONO} >= 4790 && $cref->{BBONO} <= 4860 &&
      $cref->{TITLE} =~ /^Buffet/)
  {
    # I think we can discard these.  I don't understand what they mean.
    return;
  }

  # Extract a date in certain formats.
  my $date = '';
  my $mashed = undate($text, \$date);

  # Split on separators.
  my @parts = grep {$_ ne ''} split /([.\-\+_:;"\/\(\)]|\s+)/, $mashed;

  # Separate words that run into each other.
  split_on_known_words(\@parts);

  # Split on groups of digits.
  split_on_digit_groups(\@parts);

  # Split some known words + A or B at the end.
  split_on_tournament_group(\@parts);

  # Make a semantic, studied version of the event.

  for my $i (0 .. $#parts)
  {
    study_part($parts[$i], $result, $i, $chain, $unknown_ref);
  }

  # Merge on digit runs (3-4-5-6-7).
  merge_on_digit_runs($chain);

  if ($date ne '')
  {
    my $token = Token->new();
    $token->set_origin($#parts+1, $date);
    $token->set_singleton('DATE', $date);
    $chain->append($token);
  }
}

1;
