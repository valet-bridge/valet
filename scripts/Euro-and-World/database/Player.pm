#!perl

package Player;

use strict;
use warnings;
use Exporter;
use v5.10;

use Util;

use Country;
our $country;

my $SINGLE = 0; # One value
my $EARLIEST = 1; # Numerical value, want the earliest one
my $LATEST = 2; # Numerical value, want the latest one
my $LIST = 3;

my %FIELDS = (
  NAME => $SINGLE,
  NAME_PREFERRED => $SINGLE,
  NAME_DEPRECATED => $LIST,

  BIRTH_EXACT => $SINGLE,
  BIRTH_EARLIEST => $EARLIEST,
  BIRTH_LATEST => $LATEST,

  DEATH_EXACT => $SINGLE,
  DEATH_EARLIEST => $EARLIEST,
  DEATH_LATEST => $LATEST,

  COUNTRY => $SINGLE,
  COUNTRY_DEPRECATED => $LIST,

  EBL => $SINGLE,
  EBL_DEPRECATED => $LIST,

  WBF => $SINGLE,
  WBF_DEPRECATED => $LIST,

  GENDER => $SINGLE
);


my @ORDER = qw(
  NAME NAME_PREFERRED NAME_DEPRECATED
  BIRTH_EXACT BIRTH_EARLIEST BIRTH_LATEST
  DEATH_EXACT DEATH_EARLIEST DEATH_LATEST
  COUNTRY COUNTRY_DEPRECATED
  EBL EBL_DEPRECATED
  WBF WBF_DEPRECATED);


sub new
{
  my $class = shift;

  $country = Country->new() if ! defined $country;

  return bless {}, $class;
}


sub check_years
{
  my ($self, $lead) = @_;

  my $earliest = $lead . '_EARLIEST';
  my $latest = $lead . '_LATEST';
  my $exact = $lead . '_EXACT';

  if (defined $self->{$exact})
  {
    # Check earliest and latest if present, and then delete them.

    if (defined $self->{$earliest})
    {
      # So 1990 and >= 1988.
      if ($self->{$exact} < $self->{$earliest})
      {
        die "Player: $earliest ($self->{$earliest}) >  " .
          "$exact ($self->{$exact})";
      }
      delete $self->{$earliest};
    }

    if (defined $self->{$latest})
    {
      if ($self->{$exact} > $self->{$latest})
      {
        die "Player: $latest ($self->{$latest}) <  " .
          "$exact ($self->{$exact})";
      }
      delete $self->{$latest};
    }
    return;
  }

  return unless defined $self->{$earliest} && defined $self->{$latest};

  # Check that earliest <= latest.
  if ($self->{$earliest} > $self->{$latest})
  {
    die "Player: $earliest ($self->{$earliest}) > " .
      "$latest ($self->{$latest})";
  }

  # If earliest == latest, make an exact value.
  if ($self->{$earliest} == $self->{$latest})
  {
    $self->{$exact} = $self->{$earliest};
    delete $self->{$earliest};
    delete $self->{$latest};
  }
}


sub set_field
{
  my ($self, $field, $value) = @_;

  if (! defined $FIELDS{$field})
  {
    # Tolerate but ignore TOURNAMENT fields.
    return if $field eq 'TOURNAMENT';

    die "Player: Unknown field $field";
  }

  if (! defined $self->{$field}[0])
  {
    if (($field eq 'BIRTH_EARLIEST' || $field eq 'BIRTH_LATEST') &&
        defined $self->{BIRTH_EXACT})
    {
      # We already know.
      return;
    }

    if (($field eq 'DEATH_EARLIEST' || $field eq 'DEATH_LATEST') &&
        defined $self->{DEATH_EXACT})
    {
      # We already know.
      return;
    }

    if ($field =~ /NAME/)
    {
      my $v = $value;
      $v =~ s/\s+/ /g;
      $self->{$field}[0] = Util::reverse_name($v);
    }
    else
    {
      $self->{$field}[0] = $value;
    }

    return;
  }

  my $ftype = $FIELDS{$field};

  if ($ftype == $SINGLE)
  {
    if ($self->{$field}[0] ne $value)
    {
      die "Player: Won't overwrite single-value field $field with $value";
    }
  }
  elsif ($ftype == $EARLIEST)
  {
    # Say that we get two different data points on a person
    # Born >= 1990 and born >= 1992.  We want to keep <= 1992.

    if ($value > $self->{$field}[0])
    {
      $self->{$field}[0] = $value;
    }
  }
  elsif ($ftype == $LATEST)
  {
    # Say that we get two different data points on a person
    # Born <= 1960 and born <= 1962.  We want to keep <= 1960.

    if ($value < $self->{$field}[0])
    {
      $self->{$field}[0] = $value;
    }
  }
  elsif ($ftype == $LIST)
  {
    my $cvalue = $value;
    if ($field eq 'NAME_DEPRECATED')
    {
      $cvalue =~ s/\s+/ /g;
      $cvalue = Util::reverse_name($cvalue);
    }

    for my $entry (@{$self->{$field}})
    {
      return if $entry eq $cvalue;
    }
    push @{$self->{$field}}, $cvalue;
  }
  else
  {
    die "Player: Unknown field type (internal error)";
  }

  check_years($self, 'BIRTH');
  check_years($self, 'DEATH');
}


sub has_name
{
  my ($self, $name) = @_;

  my $cname = Util::reverse_name($name);

  for my $field (qw(NAME NAME_PREFERRED NAME_DEPRECATED))
  {
    for my $entry (@{$self->{$field}})
    {
      return 1 if $entry eq $cname;
    }
  }
  return 0;
}


sub expand_name_hash
{
  my ($self, $name_hash_ref, $id) = @_;

  for my $field (qw(NAME NAME_PREFERRED NAME_DEPRECATED))
  {
    for my $entry (@{$self->{$field}})
    {
      $name_hash_ref->{$entry} = $id;
    }
  }
}


sub name
{
  my ($self) = @_;

  for my $field (qw(NAME_PREFERRED NAME NAME_DEPRECATED))
  {
    for my $entry (@{$self->{$field}})
    {
      return $entry;
    }
  }

  die "No name found";
}


sub has_country
{
  my ($self, $cname) = @_;

  for my $field (qw(COUNTRY COUNTRY_DEPRECATED))
  {
    for my $entry (@{$self->{$field}})
    {
      return 1 if $country->equal($entry, $cname);
    }
  }
  return 0;
}


sub gender
{
  my ($self) = @_;
  return $self->{GENDER}[0];
}


sub check_names
{
  my ($self, $errstr) = @_;
  my %names;
  for my $field (qw(NAME_PREFERRED NAME NAME_DEPRECATED))
  {
    for my $entry (@{$self->{$field}})
    {
      my $n = Util::reverse_name($entry);
      if (defined $names{$n})
      {
        warn "$errstr: Duplication involving $n";
      }
      $names{$n} = 1;
    }
  }
}


sub str
{
  my ($self) = @_;

  my $str = '';
  for my $field (@ORDER)
  {
    next unless defined $self->{$field};
    for my $value (@{$self->{$field}})
    {
      $str .= "$field $value\n";
    }
  }
  return $str;
}


1;
