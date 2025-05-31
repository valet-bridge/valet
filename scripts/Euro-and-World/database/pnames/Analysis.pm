#!perl

package Analysis;

use strict;
use warnings;
use v5.10;

use lib '.';

use constant
{
  INITIAL => 0,
  ALLCAPS => 1,
  CAPITALIZED => 2,
  PARTICLE => 3,
  GENERAL => 4
};

# The first part is the variant, the second one the main name.
my %FIRST_VARIANTS =
(
  Michael => 'Mikhail',
  Rigmore => 'Rigmor',
  Stephan => 'Stefan'
);

my %PARTICLES =
(
  DA => 1,
  DE => 1,
  DEN => 1,
  DER => 1,
  DI => 1,
  EL => 1,
  LA => 1,
  LE => 1,
  VAN => 1
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub remove_counts_and_titles
{
  my ($self, $words) = @_;

  my $i = 0;
  while ($i < @$words)
  {
    my $w = $words->[$i];
    if ($w =~ /^Jr\.*$/)
    {
      $self->{JUNIOR} = 1;
      splice @$words, $i, 1;
    }
    elsif ($w =~ /^Sr\.*$/)
    {
      $self->{SENIOR} = 1;
      splice @$words, $i, 1;
    }
    elsif ($w =~ /^Dr\.*$/)
    {
      $self->{TITLE} = 'Dr.';
      splice @$words, $i, 1;
    }
    elsif ($w =~ /^\((\d)\)$/)
    {
      $self->{COUNTER} = $1;
      splice @$words, $i, 1;
    }
    else
    {
      # Add point to a single letter
      if ($w =~ /^[A-Z]$/)
      {
        $words->[$i] .= '.';
      }
      $i++;
    }
  }

  # TODO Doesn't do titles yet:
  # Count
  # Graf
  # Baron (not Chi-Cheung Baron NG, Asia)
  # Prinzessin, Prince, Prinz (Prince not in African countries)
  # Capt., Maj.
  # Md is Mohammed
}


sub get_capitalization
{
  # Not a class method
  my ($text) = @_;

  return INITIAL if $text =~ /^[A-Z]\.{0,1}$/;
  return ALLCAPS if $text =~ /^[A-Z]+$/;
  return CAPITALIZED if $text =~ /^[A-Z][a-z]+$/;
  return ALLCAPS if $text =~ /^[DOL]'[A-Z]+$/; # D'ANIELLO
  return ALLCAPS if $text =~ /^Ma{0,1}c[A-Z]+$/; # MacMAHON, McDONALD

  if ($text =~ /^([A-Za-z]{2,})-([A-Za-z]{2,})$/)
  {
    # Something like Marie-Claire or ABU-GHAZALEH
    my ($a, $b) = ($1, $2);
    my $c1 = get_capitalization($a);
    my $c2 = get_capitalization($b);
    return $c1 if $c1 == $c2;
  }

  return GENERAL;
}


sub get_particle
{
  # Not a class method
  my ($text) = @_;

  return PARTICLE if exists $PARTICLES{uc($text)};

  return GENERAL;
}


sub add
{
  my ($self, $key, $text, $country) = @_;

  my @words = split /\s+/, $text;

  $self->remove_counts_and_titles(\@words);

  my @caps;
  for my $v (@words)
  {
    push @caps, get_capitalization($v);
  }

  if ($#caps == 1)
  {
    if ($caps[0] == CAPITALIZED && $caps[1] == ALLCAPS)
    {
      $self->add_first($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == CAPITALIZED)
    {
      $self->add_first($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($caps[0] == INITIAL && $caps[1] == ALLCAPS)
    {
      $self->add_first_initial($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == INITIAL)
    {
      $self->add_first_initial($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($words[0] eq '-' || $words[1] eq '-')
    {
      print "$text WWW\n";
      return;
    }
    else
    {
      print "$text ZZZ\n";
      return;
    }
  }

  if ($#caps > 1)
  {
    # Look for last names containing particles.
    my @particles;
    for my $v (@words)
    {
      push @particles, get_particle($v);
    }

    return if $self->add_with_particle($key, \@words, \@caps, \@particles);
  }
    

  print "$text XXX\n";
}


sub add_first
{
  my ($self, $key, $text) = @_;

  if (exists $self->{FIRST_INITIAL})
  {
    die "Don't know how to add $text first when there is an initial";
  }

  if (! exists $self->{FIRST_FULL} &&
      ! exists $self->{FIRST_VARIANT} &&
      ! exists $self->{SHORT})
  {
    # Assume it's a full-form name, even if we know that it could
    # be a variant.
    $self->{FIRST_FULL} = $text;
    return;
  }

  for my $key (qw(FIRST_FULL FIRST_VARIANT FIRST_SHORT))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }


  if (exists $FIRST_VARIANTS{$text})
  {
    if (exists $self->{FIRST_FULL})
    {
      if ($FIRST_VARIANTS{$text} eq $self->{FIRST_FULL})
      {
        die "FIRST_VARIANT: $self->{FIRST_VARIANT} vs $text" 
          if exists $self->{FIRST_VARIANT};

        # It's a variant of FIRST_FULL.
        $self->{FIRST_VARIANT} = $text;
        return;
      }
    }
    elsif (exists $self->{FIRST_VARIANT})
    {
      die "FIRST_VARIANT: $self->{FIRST_VARIANT} vs $text" 
        if ($self->{FIRST_VARIANT} ne $text);
      
      # We already have the variant.
      return;
    }
    else
    {
      # It's a new variant.
      $self->{FIRST_VARIANT} = $text;
      return;
    }
  }
  elsif (exists $self->{FIRST_FULL} &&
    exists $FIRST_VARIANTS{$self->{FIRST_FULL}} &&
    $FIRST_VARIANTS{$self->{FIRST_FULL}} eq $text)
  {
    # We got the variant first and now the full first name.
    $self->{FIRST_VARIANT} = $self->{FIRST_FULL};
    $self->{FIRST_FULL} = $text;
    return;
  }

  # Can use $key
  print "$text: Haven't learned multiple first names yet.\n";
}


sub add_first_initial
{
  my ($self, $key, $text) = @_;

  # This is a stand-alone initial (or initials).
  if (exists $self->{FIRST_INITIAL})
  {
    die "Already have an initial when adding $text";
  }

  if (exists $self->{FIRST_FULL} &&
      exists $self->{FIRST_VARIANT} &&
      exists $self->{SHORT})
  {
    die "Already have a first name when adding initial $text";
  }

  $self->{FIRST_INITIAL} = $text;
}


sub add_last
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{LAST_FULL} &&
      ! exists $self->{LAST_VARIANT} &&
      ! exists $self->{LAST_EARLIER1} &&
      ! exists $self->{LAST_EARLIER2})
  {
    # Assume it's a full-form name.
    $self->{LAST_FULL} = $text;
    return;
  }

  for my $key (qw(LAST_FULL LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }


  print "$text: Haven't learned multiple last names yet.\n";
}


sub add_with_particle
{
  my ($self, $key, $words, $caps, $particles) = @_;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_first = $i;
      last;
    }
  }

  my $p_last = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_last = $i;
      last;
    }
  }

  return 0 unless $p_first <= $p_last;
  return 0 unless $p_first > 0 && $p_last < $len;

  for my $i (0 .. $p_first-1)
  {
    return 0 unless $caps->[$i] eq CAPITALIZED;
  }

  for my $i ($p_last+1 .. $len)
  {
    return 0 unless $caps->[$i] eq ALLCAPS;
  }

  my $first = join(' ', @{$words}[0 .. $p_first-1]);
  my $last = join(' ', @{$words}[$p_first .. $len]);

  $self->add_first($key, $first);
  $self->add_last($key, $last);
  return 1;
}


sub str_full
{
  my ($self) = @_;

  my $s = '';
  # TODO
  return $s;
}


1;
