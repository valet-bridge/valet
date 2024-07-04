#!perl

package Event::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(study_event);

use lib '.';
use lib '..';

use Separators;
use Token;
use Util;

use Event::Despace;
use Event::Cookbook;

my @TAG_ORDER = qw(
  DESTROY
  ITERATOR
  STAGE
  AGE
  ORGANIZATION
  SCORING
);

our $histo_event;


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
  my ($tags, $values, $texts) = @_;

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
    for my $i (reverse 0 .. $#$values)
    {
      my $value = $values->[$i];
      my $fix = $FIX_HASH{$value};
      next if defined $fix->{VALUE};

      if ($value =~ $FRONT_REGEX)
      {
        my ($front, $back) = ($1, $2);

        # If letter-letter, then not lower-lower.
        next if ($back =~ /^[a-z]/ && $front =~ /[a-z]$/);
        next if ($back =~ /^[A-Z]/ && $front =~ /[A-Z]$/);
        next if $value eq 'MatchPoint';

        splice(@$tags, $i, 0, (0) x 2);
        splice(@$values, $i, 0, ('') x 2);
        splice(@$texts, $i, 0, ('') x 2);

        $tags->[$i] = 0;
        $values->[$i] = $front;
        $texts->[$i] = $front;

        $tags->[$i+1] = 'SEPARATOR';
        $values->[$i+1] = '|';
        $texts->[$i+1] = '';

        $tags->[$i+2] = 0;
        $values->[$i+2] = $back;
        $texts->[$i+2] = $back;

        $hit = 1;
        last;
      }

      next if $hit;

      if ($value =~ $BACK_REGEX)
      {
        my ($front, $back) = ($1, $2);
        if ($back =~ /^[a-z]/ && $front =~ /[a-z]$/ &&
            $front ne '2e')
        {
          # If letter-letter, then not lower-lower.
          next;
        }
        next if ($back =~ /^[A-Z]/ && $front =~ /[A-Z]$/);

        splice(@$tags, $i, 0, (0) x 2);
        splice(@$values, $i, 0, ('') x 2);
        splice(@$texts, $i, 0, ('') x 2);

        $tags->[$i] = 0;
        $values->[$i] = $front;
        $texts->[$i] = $front;

        $tags->[$i+1] = 'SEPARATOR';
        $values->[$i+1] = '|';
        $texts->[$i+1] = '';

        $tags->[$i+2] = 0;
        $values->[$i+2] = $back;
        $texts->[$i+2] = $back;

        $hit = 1;
        last;
      }
    }
  }
}


sub split_on_digit_groups
{
  my ($tags, $values, $texts) = @_;

  for my $i (reverse 0 .. $#$values)
  {
    my $value = $values->[$i];

    # We want these coupled tightly, as the separator should be virtual.
    next if ($value =~ /^[A-F]\d+$/ || $value =~ /^\d+[A-F]$/);

    $value =~s/#(\d)/$1/g;
    $value =~ s/(\d)([a-zA-Z])/$1 $2/g;
    $value =~ s/([a-zA-Z])(\d)/$1 $2/g;
    $value =~ s/(\d)\s+th/$1th /gi;
    $value =~ s/(\d)\s+rth/$1rth /gi;
    $value =~ s/(\d)\s+nd/$1nd /gi;
    $value =~ s/(\d)\s+rd/$1rd /gi; # TODO One regex?
    $value =~ s/(\d)\s+st(?=\b|_)/$1st /gi; # Either \b or _
    $value =~ s/(\d)\s+er/$1th /gi;
    $value =~ s/(\d)\s+eme/$1th /gi;

    $value =~ s/n°(\d)/ $1/gi;
    $value =~ s/(\d)ª/${1}th /gi;
    $value =~ s/(\d)°/${1}th /gi;
    $values->[$i] = $value;
  }
}


sub split_on_pre_group
{
  my ($tags, $values, $texts, $value, $pos) = @_;

  if ($value =~ $PRE_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);

    my $fix = $FIX_HASH{lc($front)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $front";
    }

    $value =~ s/$front$back/$front $back/;
    $values->[$pos] = $value;

    # splice(@$tags, $pos, 0, (0) x 2);
    # splice(@$values, $pos, 0, ('') x 2);
    # splice(@$texts, $pos, 0, ('') x 2);

    # my $fix = $FIX_HASH{lc($front)};
    # if (! defined $fix->{VALUE})
    # {
      # die "No value for $front";
    # }

    # $tags->[$pos] = $fix->{CATEGORY};
    # $values->[$pos] = $fix->{VALUE};
    # $texts->[$pos] = $front;

    # $tags->[$pos+1] = 'SEPARATOR';
    # $values->[$pos+1] = '|';
    # $texts->[$pos+1] = '';

    # $tags->[$pos+2] = 0;
    # $values->[$pos+2] = $back;
    # $texts->[$pos+2] = $back;

    return 1;
  }
  return 0;
}


sub split_on_post_group
{
  my ($tags, $values, $texts, $value, $pos) = @_;

  if ($value =~ $POST_GROUP_REGEX)
  {
    my ($front, $back) = ($1, $2);

    splice(@$tags, $pos, 0, (0) x 2);
    splice(@$values, $pos, 0, ('') x 2);
    splice(@$texts, $pos, 0, ('') x 2);

    my $fix = $FIX_HASH{lc($back)};
    if (! defined $fix->{VALUE})
    {
      die "No value for $back";
    }

    $tags->[$pos] = 0;
    $values->[$pos] = ($front eq 'W' ? 'Women' : 'Open');
    $texts->[$pos] = $value;

    $tags->[$pos+1] = 'SEPARATOR';
    $values->[$pos+1] = '|';
    $texts->[$pos+1] = $value;

    $tags->[$pos+2] = 0;
    $values->[$pos+2] = $fix->{VALUE};
    $texts->[$pos+2] = $value;

    return 1;
  }

  return 0;
}


sub split_on_tournament_group
{
  my ($tags, $values, $texts) = @_;

  # A number of words are commonly followed by A or B.
  
  for my $i (reverse 0 .. $#$values)
  {
    my $value = $values->[$i];

    next if split_on_pre_group($tags, $values, $texts, $value, $i);

    next if split_on_post_group($tags, $values, $texts, $value, $i);

    # Kludge.
    if ($value eq 'OR')
    {
      splice(@$tags, $i, 0, (0) x 2);
      splice(@$values, $i, 0, ('') x 2);
      splice(@$texts, $i, 0, ('') x 2);

      $tags->[$i] = 0;
      $values->[$i] = 'Open';
      $texts->[$i] = 'OR';

      $tags->[$i+1] = 'SEPARATOR';
      $values->[$i+1] = '|';
      $texts->[$i+1] = '';

      $tags->[$i+2] = 0;
      $values->[$i+2] = 'Room';
      $texts->[$i+2] = 'OR';
    }
    elsif ($value eq 'or')
    {
      $tags->[$i] = 0;
      $values->[$i] = 'Of'; # Typically a typo
      $texts->[$i] = 'or';
    }
    elsif ($value eq 'FO')
    {
      splice(@$tags, $i, 0, (0) x 2);
      splice(@$values, $i, 0, ('') x 2);
      splice(@$texts, $i, 0, ('') x 2);

      $tags->[$i] = 0;
      $values->[$i] = 'Final';
      $texts->[$i] = 'FO';

      $tags->[$i+1] = 'SEPARATOR';
      $values->[$i+1] = '|';
      $texts->[$i+1] = '';

      $tags->[$i+2] = 0;
      $values->[$i+2] = 'Open';
      $texts->[$i+2] = 'FO';
    }
    elsif ($value eq 'OF') # Probably
    {
      splice(@$tags, $i, 0, (0) x 2);
      splice(@$values, $i, 0, ('') x 2);
      splice(@$texts, $i, 0, ('') x 2);

      $tags->[$i] = 0;
      $values->[$i] = 'Open';
      $texts->[$i] = 'OF';

      $tags->[$i+1] = 'SEPARATOR';
      $values->[$i+1] = '|';
      $texts->[$i+1] = '';

      $tags->[$i+2] = 0;
      $values->[$i+2] = 'Final';
      $texts->[$i+2] = 'OF';
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


sub is_lettered_number
{
  my ($part, $token, $chain) = @_;

  my ($number, $letter);
  if ($part =~ /^(\d+)([A-F])$/)
  {
    ($number, $letter) = ($1, $2);
  }
  elsif ($part =~ /^([A-F])(\d+)$/)
  {
    ($number, $letter) = ($2, $1);
  }
  else
  {
    return 0;
  }

  $token->set_general('COUNTER', 'NL', $number . $letter);
  return 1;
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

  my ($whole, $part, $result, $i, $chain, $unsolved_flag) = @_;

  return if title_specific_hashes_new($whole, \@TAG_ORDER, 
    $i, $part, 1, $chain, $main::histo_event, 'EVENT_');

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
  return 0 if is_lettered_number($part, $token);

  print "UNKNOWN $part\n";
  $$unsolved_flag = 1;

  $token->set_unknown($part);
  return 0;
}


sub study
{
  my ($whole, $chunk, $result, $chain, $histo, $unknowns) = @_;

  if ($chunk->{BBONO} >= 4790 && $chunk->{BBONO} <= 4860 &&
      $chunk->{TITLE} =~ /^Buffet/)
  {
    # I think we can discard these.  I don't understand what they mean.
    return;
  }

  my $dtext = despace($chunk->{EVENT});
  my $utext = unteam($dtext, $result);
  my $ctext = split_on_capitals_new($utext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates_new($ctext, \@tags, \@values, \@texts, 0);

  # Extract a date in certain formats.
  # my $date = '';
  # my $mashed = undate($text, \$date);

  # Separate words that run into each other.
  # split_on_known_words(\@tags, \@values, \@texts);

  # Split on groups of digits.
  split_on_digit_groups(\@tags, \@values, \@texts);

  # Split some known words + A or B at the end.
  split_on_tournament_group(\@tags, \@values, \@texts);

  split_on_multi_new($whole, \@TAG_ORDER, 1, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/([\s+\-\+._:;"\/\(\)\|])/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  # Make a semantic, studied version of the event.

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a hit.
      if ($tags[$i] eq 'SEPARATOR')
      {
        my $token = Token->new();
        $token->set_origin($i, $values[$i]);
        if (! Separators::set_token($values[$i], $token))
        {
          die "Not a separator after all?";
        }
        $chain->append($token);
      }
      else
      {
        $chain->append_general('SINGLETON', $tags[$i], $values[$i],
          $texts[$i], $i);
      }
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $value (@a)
      {
        study_part($whole, $value, $result, $i, $chain, \$unsolved_flag);
      }
    }
  }

  # Merge on digit runs (3-4-5-6-7).
  merge_on_digit_runs($chain);

  if ($unsolved_flag)
  {
    $$unknowns++;
    print "WWW $chunk->{BBONO}: $chunk->{EVENT}\n" if $chain->last() > 0;
    print "\n";
  }

  # if ($date ne '')
  # {
    # my $token = Token->new();
    # $token->set_origin($#parts+1, $date);
    # $token->set_singleton('DATE', $date);
    # $chain->append($token);
  # }
}

1;
