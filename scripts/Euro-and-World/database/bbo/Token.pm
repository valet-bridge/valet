#!perl

package Token;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';
use Cookbook;
use Separators;

# A Token has some basic information about its origin:
# - text is (close to) the text snippet that gave rise to it,
#   but some substitutions have already been made.
# - position_first and position_last are the indices in the
#   list of text parts from which the token were derived.
#   These are mostly maintained to make sure we don't mess up
#   the order, but they are probably not needed in the end.
#
# Other than that, there are several categories of tokens, CATEGORY:
# - ITERATOR.  This one has the most variation.  A quite complete
#   version might be "Round 2 B of 7", but a token can be augmented
#   from a relatively basic version such as "2" by adding new
#   information.
# - COUNTER.  This is like an ITERATOR without the FIELD.
# - SINGLETON.  This mostly corresponds with a field that directly
#   describes a tournament/entry and that only has one value.
#   For example, "2012-07-04" might be a DATE.  Nowhere is in
#   the text input is DATE mentioned.
# - SEPARATOR.  In the most basic case, this is a single character
#   such as a space or a comma, but it can also be multiple
#   separators that have been combined, or it can be a virtual
#   separator as in "round1".
# - AMBIGUOUS.  Some text snippet could be more than one thing,
#   and it takes context to make a guess.  An example is "J"
#   (a group or "Juniors") or "v" (Roman five, or "vs.", or
#   perhaps just a letter).
# - KILL.  This just means that the token is marked for removal,
#   mostly because it's extraneous or perhaps not recognized.
# - UNKNOWN.
#
# A token may also have a FIELD.
# - An ITERATOR has the name of the iterator, such as "Round".
# - A SINGLETON has the name, such as "Date".
# - A SEPARATOR has "COMMA" etc., but also "COMPOSITE" and
#   "VIRTUAL".
# - AMBIGUOUS has an empty field.
# - KILL doesn't really have a field.
#
# A token may also have a VALUE.
#
# An ITERATOR has up to three components called "BASE", "OF" and "TO".
# so in "Round 1-2 of 7" 1 is the base, 2 the "to", and 7 the "of".
# Each component may or may not have these value fields filled:
# - NUMERAL
# - LETTER
# - NUMERAL_LETTER
# - RELATIVE (this means that it is "first" or "last")
#
# The ITERATOR is the most complex category, as it needs to grow
# when contextual data is added.
#
# Other categories may have a single VALUE field.


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub set_origin
{
  my ($self, $number, $text) = @_;
  $self->{position_first} = $number;
  $self->{position_last} = $number;
  $self->{text} = $text;
}


sub copy_origin_from
{
  my ($self, $from) = @_;
  $self->{position_first} = $from->{position_first};
  $self->{position_last} = $from->{position_last};
  $self->{text} = $from->{text};
}


sub set_iterator_field
{
  my ($self, $field) = @_;
  die "Not an iterator" 
    if (exists $self->{CATEGORY} && $self->{CATEGORY} ne 'ITERATOR');
  $self->{CATEGORY} = 'ITERATOR';
  $self->{FIELD} = $field;
}


sub reset_iterator_field
{
  my ($self, $field) = @_;
  $self->{CATEGORY} = 'ITERATOR';
  $self->{FIELD} = $field;
  delete $self->{VALUE} if exists $self->{VALUE};
}


sub set_numeral_counter
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'COUNTER';
  $self->{FIELD} = 'NUMERAL';
  $self->{VALUE} = $value;
}


sub set_ordinal_counter
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'COUNTER';
  $self->{FIELD} = 'ORDINAL';
  $self->{VALUE} = $value;
}


sub set_roman_counter
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'COUNTER';
  $self->{FIELD} = 'ROMAN';
  $self->{VALUE} = $value;
}


sub set_letter_counter
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'COUNTER';
  $self->{FIELD} = 'LETTER';
  $self->{VALUE} = $value;
}


sub merge_counters
{
  my ($self, $sep, $token2) = @_;
  die "Not a counter" unless $self->{CATEGORY} eq 'COUNTER';
  die "Not a counter" unless $token2->{CATEGORY} eq 'COUNTER';

  if ($self->{FIELD} eq 'NUMERAL' &&
      $token2->{FIELD} eq 'LETTER')
  {
    $self->{FIELD} = 'NL';
    $self->{VALUE} .= $token2->{VALUE};
  }
  elsif ($self->{FIELD} eq 'LETTER' &&
      $token2->{FIELD} eq 'NUMERAL')
  {
    $self->{FIELD} = 'L';
    $self->{VALUE} .= $token2->{VALUE};
  }
  elsif (($self->{FIELD} eq 'NUMERAL' &&
      $token2->{FIELD} eq 'NUMERAL') ||
      ($self->{FIELD} eq 'ROMAN' &&
      $token2->{FIELD} eq 'ROMAN'))
  {
    if ($sep eq '/' || $sep eq '_' || $sep eq 'of')
    {
      $self->{FIELD} = 'N_OF_N';
      $self->{VALUE} .= ' of ' . $token2->{VALUE};
    }
    elsif ($sep eq ':')
    {
      # Something like 7-1 where we don't know their names.
      $self->{FIELD} = 'MAJOR_MINOR';
      $self->{VALUE} .= '+' . $token2->{VALUE};
    }
    elsif ($sep eq '-')
    {
      if ($self->{VALUE} <= $token2->{VALUE})
      {
        # Heuristic, may not be true.  Could also be e.g. 'of'.
        $self->{FIELD} = 'N_TO_N';
        $self->{VALUE} .= '-' . $token2->{VALUE};
      }
      else
      {
        # Something like 7-1 where we don't know their names.
        $self->{FIELD} = 'MAJOR_MINOR';
        $self->{VALUE} .= '+' . $token2->{VALUE};
      }
    }
    else
    {
      die;
    }
  }
  elsif ($self->{FIELD} eq 'NL' &&
      $token2->{FIELD} eq 'NUMERAL')
  {
    if ($sep eq '/' || $sep eq '_' || $sep eq 'of')
    {
      $self->{FIELD} = 'NL_OF_N';
      $self->{VALUE} .= ' of ' . $token2->{VALUE};
    }
    else
    {
      die;
    }
  }
  elsif ($self->{FIELD} eq 'NUMERAL' &&
      $token2->{FIELD} eq 'NL')
  {
    if ($sep eq '/' || $sep eq '_' || $sep eq 'of')
    {
      $self->{FIELD} = 'NL_OF_N';

      # Break apart the 'NL'.
      $token2->{VALUE} =~ /^(\d+)(\w)$/;
      $self->{VALUE} .= $2 . ' of ' . $1;
    }
    elsif ($sep eq ':')
    {
      # Something like 10:1A.
      $self->{FIELD} = 'MAJOR_MINOR';
      $self->{VALUE} .= '+' . $token2->{VALUE};
    }
    elsif ($sep eq '-')
    {
      # Break apart the 'NL'.
      $token2->{VALUE} =~ /^(\d+)(\w)$/;
      my ($n, $l) = ($1, $2);

      if ($self->{VALUE} <= $n)
      {
        # Heuristic, may not be true.  Could also be e.g. 'of'.
        $self->{FIELD} = 'NL_TO_N';
        $self->{VALUE} .= $l . ' to ' . $n;
      }
      else
      {
        # Something like 7-1 where we don't know their names.
        $self->{FIELD} = 'MAJOR_MINOR';
        $self->{VALUE} .= '+' . $token2->{VALUE};
      }
    }
    else
    {
      die;
    }
  }
  elsif ($self->{FIELD} eq 'ORDINAL' &&
      ($token2->{FIELD} eq 'NUMERAL' ||
       $token2->{FIELD} eq 'ORDINAL'))
  {
    $self->{FIELD} = 'N_OF_N';
    $self->{VALUE} .= ' of ' . $token2->{VALUE};
  }
  elsif ($self->{FIELD} eq 'NUMERAL' &&
      $token2->{FIELD} eq 'N_OF_N')
  {
    $self->{FIELD} = 'N_TO_N_OF_N';
    $self->{VALUE} .= '-' . $token2->{VALUE};
  }
  elsif ($self->{FIELD} eq 'LETTER' &&
      $token2->{FIELD} eq 'N_OF_N')
  {
    $self->{FIELD} = 'NL_OF_N';

    # Break apart the 'of'.
    $token2->{VALUE} =~ /^(\d+) of (\d+)$/;
    $self->{VALUE} = $1 . $self->{VALUE} . ' of ' . $2;
  }
  elsif ($self->{FIELD} eq 'N_TO_N' &&
      $token2->{FIELD} eq 'NUMERAL')
  {
    $self->{FIELD} = 'N_TO_N_OF_N';
    $self->{VALUE} .= ' of ' . $token2->{VALUE};
  }
  else
  {
    die;
  }
}


sub set_singleton
{
  my ($self, $field, $value) = @_;
  $self->{CATEGORY} = 'SINGLETON';
  $self->{FIELD} = $field;
  $self->{VALUE} = $value;
}


sub set_ambiguous
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'AMBIGUOUS';
  $self->{VALUE} = $value;
}


sub set_separator
{
  my ($self, $field) = @_;
  die "Not a separator: $field" unless exists $SEPARATORS{$field};
  $self->{CATEGORY} = 'SEPARATOR';
  $self->{FIELD} = $SEPARATORS{$field};
}


sub set_kill
{
  my ($self, $value) = @_;
  $self->{CATEGORY} = 'KILL';
  $self->{VALUE} = $value;
}


sub set_unknown
{
  my ($self, $text) = @_;
  $self->{CATEGORY} = 'UNKNOWN';
  $self->{VALUE} = $text;
}


sub merge_origin
{
  my ($self, $token2) = @_;

  $self->{text} .= $token2->{text};
  $self->{position_last} = $token2->{position_last};

  if ($self->{CATEGORY} eq 'SEPARATOR' &&
      $token2->{CATEGORY} eq 'SEPARATOR')
  {
    # Special case.
    $self->{FIELD} |= $token2->{FIELD};
  }
}


sub match_aspect
{
  my ($self, $hash, $aspect) = @_;

  if (exists $hash->{$aspect})
  {
    for my $cand (@{$hash->{$aspect}})
    {
      if ($cand eq 'undef')
      {
        return (! defined $self->{$aspect});
      }
      elsif (! defined $self->{$aspect})
      {
        return 0;
      }
      elsif ($cand eq $self->{$aspect})
      {
        return 1;
      }
    }
    # Nothing matched.
    return 0;
  }
  else
  {
    # Nothing to match.
    return 1;
  }
}


sub match
{
  my ($self, $hash) = @_;

  # $hash may have fields CATEGORY, FIELD and VALUE, each of which
  # is a list.
  # If set, the list elements may be 'undef' which means that 
  # the corresponding token field must not be defined.

  return 0 unless $self->match_aspect($hash, 'CATEGORY');
  return 0 unless $self->match_aspect($hash, 'FIELD');
  return 0 unless $self->match_aspect($hash, 'VALUE');
  return 1;
}


sub category
{
  my ($self) = @_;
  die "No category" unless exists $self->{CATEGORY};
  return $self->{CATEGORY};
}


sub field
{
  my ($self) = @_;
  die "No field" unless exists $self->{FIELD};
  return $self->{FIELD};
}


sub value
{
  my ($self) = @_;
  die "No value" unless exists $self->{VALUE};
  return $self->{VALUE};
}


sub text
{
  my ($self) = @_;
  die "No text" unless exists $self->{text};
  return $self->{text};
}


sub str_full
{
  my ($self) = @_;
  if ($self->{position_first} eq $self->{position_last})
  {
    return "($self->{position_first}: $self->{text})";
  }
  else
  {
    return 
      "($self->{position_first}-$self->{position_last}: $self->{text})";
  }
}


sub str_iterator
{
  my ($self) = @_;

  die "Haven't learned str_iterator yet";
}


sub str_counter
{
  my ($self) = @_;

  die "Haven't learned str_counter yet";
}


sub str_singleton
{
  my ($self) = @_;

  my $field = $self->{FIELD};
  my $value = $self->{VALUE};

  die "No field" unless defined $field;
  die "No value" unless defined $value;
  die "Bad field $field" unless exists $SINGLETONS{$field};

  return "$SINGLETONS{$field} $value";
}


sub str_separator
{
  my ($self) = @_;

  my $field = $self->{FIELD};
  die "No field" unless defined $field;
  return "SEPARATOR $field";
}


sub str_kill
{
  my ($self) = @_;

  my $value = $self->{VALUE};
  die "No value" unless defined $value;
  return "KILL $value";
}


sub str_unknown
{
  my ($self) = @_;

  my $value = $self->{VALUE};
  die "No value" unless defined $value;
  return "UNKNOWN $value";
}


sub str
{
  my ($self, $full_flag) = @_;

  my $category = $self->{CATEGORY};
  die "No category" unless defined $category;

  my $str;
  if ($category eq 'ITERATOR')
  {
    $str = str_iterator();
  }
  elsif ($category eq 'COUNTER')
  {
    $str = str_iterator();
  }
  elsif ($category eq 'SINGLETON')
  {
    $str = str_singleton();
  }
  elsif ($category eq 'AMBIGUOUS')
  {
    $str = str_ambiguous();
  }
  elsif ($category eq 'SEPARATOR')
  {
    $str = str_separator();
  }
  elsif ($category eq 'KILL')
  {
    $str = str_kill();
  }
  elsif ($category eq 'UNKNOWN')
  {
    $str = str_unknowns();
  }
  else
  {
    die "Unknown category $category";
  }

  $str .= ' ' . str_full() if $full_flag;
  return $str . "\n";
}


1;
