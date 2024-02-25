#!perl

package Player;

use strict;
use warnings;
use Exporter;
use v5.10;

use Util;

use Country;
our $country;

use Year;

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
  COUNTRY COUNTRY_DEPRECATED
  EBL EBL_DEPRECATED
  WBF WBF_DEPRECATED);


sub new
{
  my $class = shift;

  $country = Country->new() if ! defined $country;

  return bless {}, $class;
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
    if ($field =~ /NAME/)
    {
      my $v = $value;
      $v =~ s/\s+/ /g;
      $self->{$field}[0] = Util::reverse_name($v);
    }
    elsif ($field eq 'BIRTH_EARLIEST' || $field eq 'BIRTH_LATEST')
    {
      $self->{BIRTH}[0] = Year->new() unless defined $self->{BIRTH}[0];

      my $bfield = ($field eq 'BIRTH_EARLIEST' ? 'EARLIEST' : 'LATEST');
      if (! $self->{BIRTH}[0]->add($bfield, $value))
      {
        die "Could not add birth information";
      }
    }
    elsif ($field eq 'DEATH_EARLIEST' || $field eq 'DEATH_LATEST')
    {
      $self->{DEATH}[0] = Year->new() unless defined $self->{DEATH}[0];

      my $bfield = ($field eq 'DEATH_EARLIEST' ? 'EARLIEST' : 'LATEST');
      if (! $self->{DEATH}[0]->add($bfield, $value))
      {
        die "Could not add death information";
      }
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
    # Already done.
  }
  elsif ($ftype == $LATEST)
  {
    # Already done.
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


sub check_and_update_age
{
  my ($self, $year, $restriction) = @_;

  $self->{BIRTH}[0] = Year->new() unless defined $self->{BIRTH}[0];
  return $self->{BIRTH}[0]->add_by_year($year, $restriction, 'BIRTH');
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
  $str .= $self->{BIRTH}[0]->str('BIRTH') if defined $self->{BIRTH}[0];
  $str .= $self->{DEATH}[0]->str('DEATH') if defined $self->{DEATH}[0];
  return $str;
}


1;
