#!perl

package Year;

use strict;
use warnings;
use Exporter;
use v5.10;

use lib '.';
use Age;
our $age;

my @FIELD_LIST = qw(EARLIEST LATEST EXACT);

my %FIELDS = map { $_ => 1 } @FIELD_LIST;


sub new
{
  my $class = shift;

  $age = Age->new() if ! defined $age;

  return bless {}, $class;
}


sub add_earliest
{
  my ($self, $value) = @_;

  # This is the constraint of a junior player, e.g. >= 1990.

  if (defined $self->{EXACT})
  {
    return ($value <= $self->{EXACT});
  }

  if (defined $self->{EARLIEST})
  {
    return 1 if $value <= $self->{EARLIEST};
    if (! defined $self->{LATEST} || $value < $self->{LATEST})
    {
      $self->{EARLIEST} = $value;
      return 1;
    }
    elsif ($value > $self->{LATEST})
    {
      return 0;
    }
    else
    {
      $self->{EXACT} = $value;
      delete $self->{EARLIEST};
      delete $self->{LATEST};
      return 1;
    }
  }
  elsif (defined $self->{LATEST})
  {
    return 0 if $value > $self->{LATEST};
    if ($value < $self->{LATEST})
    {
      $self->{EARLIEST} = $value;
      return 1;
    }
    else
    {
      $self->{EXACT} = $value;
      delete $self->{EARLIEST};
      delete $self->{LATEST};
      return 1;
    }
  }
  else
  {
    $self->{EARLIEST} = $value;
    return 1;
  }
}


sub add_latest
{
  my ($self, $value) = @_;

  # This is the constraint of a senior player, e.g. <= 1960.

  if (defined $self->{EXACT})
  {
    return ($value >= $self->{EXACT});
  }

  if (defined $self->{LATEST})
  {
    return 1 if $value >= $self->{LATEST};
    if (! defined $self->{EARLIEST} || $value < $self->{EARLIEST})
    {
      $self->{LATEST} = $value;
      return 1;
    }
    elsif ($value < $self->{EARLIEST})
    {
      return 0;
    }
    else
    {
      $self->{EXACT} = $value;
      delete $self->{EARLIEST};
      delete $self->{LATEST};
      return 1;
    }
  }
  elsif (defined $self->{EARLIEST})
  {
    return 0 if $value < $self->{EARLIEST};
    if ($value > $self->{EARLIEST})
    {
      $self->{LATEST} = $value;
      return 1;
    }
    else
    {
      $self->{EXACT} = $value;
      delete $self->{EARLIEST};
      delete $self->{LATEST};
      return 1;
    }
  }
  else
  {
    $self->{LATEST} = $value;
    return 1;
  }
}


sub add_exact
{
  my ($self, $value) = @_;

  if (defined $self->{EXACT})
  {
    return ($value == $self->{EXACT});
  }

  if (defined $self->{EARLIEST})
  {
    return 0 if $value < $self->{EARLIEST};
    if (defined $self->{LATEST})
    {
      return 0 if $value > $self->{LATEST};
      delete $self->{LATEST};
    }

    $self->{EXACT} = $value;
    delete $self->{EARLIEST};
    return 1;
  }
  elsif (defined $self->{LATEST})
  {
    return 0 if $value > $self->{LATEST};
    $self->{EXACT} = $value;
    delete $self->{LATEST};
    return 1;
  }
  else
  {
    $self->{EXACT} = $value;
    return 1;
  }
}


sub add
{
  my ($self, $field, $value) = @_;

  die "Unknown year field $field" unless defined $FIELDS{$field};

  if ($field eq 'EARLIEST')
  {
    return $self->add_earliest($value);
  }
  elsif ($field eq 'LATEST')
  {
    return $self->add_latest($value);
  }
  else
  {
    return $self->add_exact($value);
  }
}


sub add_by_year
{
  my ($self, $year, $restriction, $prefix) = @_;

  my ($field, $value);
  if ($age->make_constraint($year, $restriction, \$field, \$value))
  {
    if (! $self->add($field, $value))
    {
      print $self->str($prefix);
      print "Attempted to add year $year, restriction $restriction\n";
      return 0;
    }
  }
  return 1;
}


sub str
{
  my ($self, $prefix) = @_;
  if (defined $self->{EXACT})
  {
    return "${prefix}_EXACT $self->{EXACT}\n";
  }

  my $str = '';
  if (defined $self->{EARLIEST})
  {
    $str .= "${prefix}_EARLIEST $self->{EARLIEST}\n";
  }
  if (defined $self->{LATEST})
  {
    $str .= "${prefix}_LATEST $self->{LATEST}\n";
  }
  return $str;
}


1;
