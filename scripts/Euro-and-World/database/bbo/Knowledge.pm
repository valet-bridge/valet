#!perl

package Knowledge;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

my $KDEBUG = 0;

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub restage
{
  my ($field, $value) = @_;
  if ($field ne 'STAGE')
  {
    return $field;
  }
  elsif ($value eq 'Round-robin' || $value eq 'Knock-out')
  {
    return 'MOVEMENT';
  }
  else
  {
    return $field;
  }
}


sub replace
{
  my ($self, $field, $old, $new) = @_;
  delete $self->{HASH}{$field}{$old};
  $self->{HASH}{$field}{$new} = 1;
  $self->{LIST}{$field}[0] = $new;

}


sub rework_stage
{
  my ($self, $value, $bbono) = @_;

  if ($#{$self->{LIST}{STAGE}} > 0)
  {
    warn "$bbono: Already more than one STAGE\n";
    return;
  }

  my $old = $self->{LIST}{STAGE}[0];
  
  if ($old eq 'Final' &&
      ($value eq 'Bronze' || $value eq 'Quarterfinal' || $value eq 'Semifinal'))
  {
    # Final/Bronze just becomes Bronze etc.
    $self->replace('STAGE', $old, $value);
    return;
  }

  if ($value eq 'Final' &&
      ($old eq 'Bronze' || $old eq 'Quarterfinal' || $old eq 'Semifinal'))
  {
    # Discard Final.
    return;
  }

  if ($value eq 'Playoff')
  {
    # Discard Playoff.
    return;
  }

  if ($old eq 'Playoff')
  {
    $self->replace('STAGE', $old, $value);
  }
}


sub rework_scoring
{
  my ($self, $value, $bbono) = @_;

  if ($#{$self->{LIST}{SCORING}} > 0)
  {
    warn "$bbono: Already more than one SCORING\n";
    return;
  }

  my $old = $self->{LIST}{SCORING}[0];

  if (($old eq 'B' || $old eq 'I') && $value eq 'Patton')
  {
    # Keep the new one.
    $self->replace('SCORING', $old, $value);
  }
  elsif (($old eq 'IMP' || $old eq 'Patton') && 
    $value eq 'I')
  {
    # Keep IMP.
  }
  elsif (($old eq 'BAM' || $old eq 'Patton') && $value eq 'B')
  {
    # Keep BAM/Patton.
  }
  elsif ($value eq 'P' &&
      $old eq 'IMP' &&
      $#{$self->{LIST}{FORM}} == 0 &&
      $self->{LIST}{FORM}[0] eq 'Pairs')
  {
    # IMP Pairs, apparently.
  }
  else
  {
    warn "$bbono: SCORING $old vs $value\n";
  }
}


sub add_field
{
  my ($self, $field, $value, $bbono) = @_;

  my $field_internal = restage($field, $value);

  return if exists $self->{HASH}{$field_internal} &&
    exists $self->{HASH}{$field_internal}{$value};
  
  if (! exists $self->{HASH}{$field_internal})
  {
    $self->{HASH}{$field_internal}{$value} = 1;
    push @{$self->{LIST}{$field_internal}}, $value;
    return;
  }

  if ($field_internal eq 'STAGE')
  {
    $self->rework_stage($value, $bbono);
  }
  elsif ($field_internal eq 'SCORING')
  {
    $self->rework_scoring($value, $bbono);
  }
  else
  {
    print "$bbono CONFLICT: More than one of $field\n" if $KDEBUG;
  }
}


sub add_explained_chains
{
  my ($self, $chains, $bbono) = @_;
  for my $chain (@$chains)
  {
    next unless $chain->status() eq 'EXPLAINED';

    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      $self->add_field($token->field(), $token->value(), $bbono);
    }
  }
}


sub get_field
{
  my ($self, $field, $bbono) = @_;

  if (! exists $self->{HASH}{$field})
  {
    return '';
  }

  if ($#{$self->{LIST}{$field}} > 0)
  {
    warn 'More than one option';
  }

  return $self->{LIST}{$field}[0];
}


1;
