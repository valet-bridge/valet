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
  elsif ($old eq 'MP' && $value eq 'P')
  {
    # Keep MP.
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


sub delete_field
{
  my ($self, $field, $value, $bbono) = @_;

  if (! exists $self->{HASH}{$field} ||
      ! exists $self->{HASH}{$field}{$value})
  {
    die "$bbono delete_field CONFLICT: $field, $value not found";
  }

  my $l = $#{$self->{LIST}{$field}};
  my $hit = 0;
  my $index;
  for my $i (0 .. $l)
  {
    if ($self->{LIST}{$field}[$i] eq $value)
    {
      $hit = 1;
      $index = $i;
      last;
    }
  }

  if (! $hit)
  {
    die "$bbono delete_field ERROR: $field, $value in hash but not in list";
  }

  delete $self->{HASH}{$field}{$value};
  splice(@{$self->{LIST}{$field}}, $index, 1);

  if ($l == 0)
  {
    delete $self->{HASH}{$field};
    delete $self->{LIST}{$field};
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


sub get_iter_mask
{
  my ($self, $bbono) = @_;
  my $mask = '';
  $mask .= ($self->get_field('GROUP', $bbono) ? 1 : 0);
  $mask .= ($self->get_field('ROUND', $bbono) ? 1 : 0);
  $mask .= ($self->get_field('SESSION', $bbono) ? 1 : 0);
  $mask .= ($self->get_field('SEGMENT', $bbono) ? 1 : 0);
  return $mask;
}


sub is_knock_out
{
  my ($self, $bbono) = @_;
  my $movement = $self->get_field('MOVEMENT', $bbono);
  my $stage = $self->get_field('STAGE', $bbono);

  return ($movement eq 'Knock-out' ||
    $stage eq 'Quarterfinal' ||
    $stage eq 'Semifinal' ||
    $stage eq 'Final' ||
    $stage eq 'Playoff')
}


sub str
{
  my ($self, $bbono) = @_;

  my $meet = $self->get_field('MEET', $bbono);
  my $tname = $self->get_field('TNAME', $bbono);
  my $form = $self->get_field('FORM', $bbono);
  my $stage = $self->get_field('STAGE', $bbono);
  my $movement = $self->get_field('MOVEMENT', $bbono);
  my $mask = $self->get_iter_mask($bbono);

  if ($tname eq '')
  {
    $tname = 'MEET ' . $self->get_field('MEET', $bbono);
  }

  return "$bbono, $mask, $tname: $form, $stage, $movement";
}


sub str_csv
{
  my ($self, $sep, $bbono) = @_;

  my $meet = $self->get_field('MEET', $bbono);
  my $tname = $self->get_field('TNAME', $bbono);
  my $form = $self->get_field('FORM', $bbono);
  my $stage = $self->get_field('STAGE', $bbono);
  my $movement = $self->get_field('MOVEMENT', $bbono);
  my $mask = $self->get_iter_mask($bbono);

  my $s = 
    $bbono . $sep .
    $meet . $sep .
    $tname . $sep .
    $form . $sep .
    $stage . $sep .
    $movement . $sep .
    $mask . "\n";

  return $s;
}


1;
