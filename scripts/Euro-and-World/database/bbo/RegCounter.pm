#!perl

package RegCounter;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

my $DEBUG_COUNTERS = 1;


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub register_auto
{
  my ($self, $entry, $chapter, $tname) = @_;

  my $concat1 = lc($entry->concat_team('TEAM1'));
  my $concat2 = lc($entry->concat_team('TEAM2'));
  my ($concat_lo, $concat_hi);
  if ($concat1 le $concat2)
  {
    $concat_lo = $concat1;
    $concat_hi = $concat2;
  }
  else
  {
    $concat_lo = $concat2;
    $concat_hi = $concat1;
  }

  push @{$self->{AUTOSYMM}{$concat1}{$concat2}}, $entry;
  push @{$self->{AUTOSYMM}{$concat2}{$concat1}}, $entry;

  push @{$self->{AUTO}{$concat1}{$concat2}}, $entry;
}


sub register_groups
{
  my ($self, $entry, $chapter, $counters, $tname) = @_;
  
  my $groupon = $chapter->{groupon};
  if (exists $counters->{$groupon})
  {
    my $gvalue = $counters->{$groupon};
    push @{$self->{GROUPS}{$gvalue}}, $entry;

    for my $team (qw(TEAM1 TEAM2))
    {
      my $concat = lc($entry->concat_team($team));
      next if $concat eq '';

      # This can lead to overwrites which we accept as long as
      # groups are later found.  For example, Buffett Cup has
      # Europe in multiple places, but if they all have correct
      # groups, it is OK.
      $self->{TEAM_TO_GROUP}{$concat} = $gvalue;
    }
  }
  else
  {
    push @{$self->{GROUPS}{none}}, $entry;
  }
}


sub register
{
  my ($self, $entry, $chapter, $tname) = @_;

  my $bbono = $entry->bbono();
  my $counters = $entry->get_counter_ref();
  while (my ($field, $value) = each %$counters)
  {
    $self->{BBOHIST}{$bbono}{$field}++;
    $self->{BBOCOUNT}{$bbono}++;
    $self->{COUNTER}{$field}{COUNT}++;

    # Basically just take the leading number.
    # This is also what gets sorted on.

    if ($value =~ /^\d+$/ || $value eq 'last')
    {
      $self->{COUNTER}{$field}{SIMPLE}++;
    }
    elsif ($value =~ /^\d+ of (\d+)$/ ||
        $value =~ /^\d+-\d+ of (\d+)$/)
    {
      my $end = $1;
      $self->{COUNTER}{$field}{OF}++;
      $self->{COUNTER}{$field}{ENDS}{$end}++;
    }
    elsif ($value =~ /^\d+-\d+$/)
    {
      $self->{COUNTER}{$field}{SIMPLE}++;
    }
    elsif ($value =~ /^\d+[A-Da-d]$/)
    {
      $self->{COUNTER}{$field}{SIMPLE}++;
    }
    elsif ($field eq 'GROUP' && $value =~ /^[A-Ka-k]$/)
    {
      # But have to 'ignore' or 'groupon' GROUP then.
      $self->{COUNTER}{$field}{SIMPLE}++;
    }
    else
    {
      warn "$bbono: Haven't learned $value";
    }
  }

  if (exists $chapter->{groupon})
  {
    if ($chapter->{groupon} eq 'AUTO')
    {
      $self->register_auto($entry, $chapter, $tname);
    }
    else
    {
      $self->register_groups($entry, $chapter, $counters, $tname);
      $entry->delete_counter($chapter->{groupon});
    }
  }

  if ($entry->chapter_field('STAGE') ne '' &&
    ! exists $chapter->{STAGE})
  {
    warn "$bbono, $tname: STAGE not in chapter";
  }

  if ($entry->chapter_field('MOVEMENT') ne '' &&
    ! exists $chapter->{MOVEMENT})
  {
    warn "$bbono, $tname: MOVEMENT not in chapter";
  }
}


sub has_of_structure
{
  # Not a class method.
  my ($hash) = @_;

  my $num = scalar keys %$hash;
  return 0 if $num != 1;

  for my $key (keys %$hash)
  {
    # The first and only one.
    return $key;
  }
}


sub make_pre_map
{
  # Not really a class function.
  my ($self, $chapter_header, $pre_map) = @_;

  if (exists $chapter_header->{ignore})
  {
    my @a = split /\|/, $chapter_header->{ignore};
    for my $ignore (@a)
    {
      $pre_map->{$ignore} = 'IGNORE';
    }
  }

  for my $f (qw(major minor))
  {
    next unless exists $chapter_header->{$f};
    my @a = split /\|/, $chapter_header->{$f};
    next unless $#a > 0;
    for my $i (1 .. $#a)
    {
      $pre_map->{$a[$i]} = $a[0];
    }

    $chapter_header->{$f} = $a[0];
  }
}


sub analyze
{
  my ($self, $header, $chapter) = @_;

  my $num_bbo_fields = 0;
  for my $field (keys %{$self->{COUNTER}})
  {
    $self->{ANALYSIS}[$num_bbo_fields] = $field;

    if (! exists $self->{COUNTER}{$field}{OF})
    {
      $self->{OF}{$field} = 0;
    }
    elsif (my $of_end = has_of_structure($self->{COUNTER}{$field}{ENDS}))
    {
      $self->{OF}{$field} = $of_end;
    }
    else
    {
      print "WARNING: Contradictory OF structure for '$field'\n";
    }

    $num_bbo_fields++;
  }

  $self->{NUM_FIELDS} = $num_bbo_fields;

  my $num_chapter_fields = 0;
  $num_chapter_fields++ if exists $chapter->{major};
  $num_chapter_fields++ if exists $chapter->{minor};
  $num_chapter_fields++ if (exists $chapter->{groupon} &&
    $chapter->{groupon} ne 'AUTO');

  if ($num_bbo_fields != $num_chapter_fields && $DEBUG_COUNTERS)
  {
    warn "\n\nWARN $num_bbo_fields BBO, $num_chapter_fields chapter";
    warn $header->{TOURNAMENT_NAME};
    warn $header->{YEAR};
    warn "major $chapter->{major}" if exists $chapter->{major};
    warn "minor $chapter->{minor}" if exists $chapter->{minor};
    warn "groupon $chapter->{groupon}" if exists $chapter->{groupon};
    warn $self->str_analysis();
    for my $bbono (sort keys %{$self->{BBOCOUNT}})
    {
      warn "  BBONO $bbono";
    }
    warn "---";
  }
}


sub get_assigned_fields
{
  my ($self, $entry) = @_;

  if (! exists $entry->{major})
  {
    $self->{ASSIGNED_FIELDS} = 0;
    return;
  }
  $self->{ASSIGNED}[0] = $entry->{major};

  if (! exists $entry->{minor})
  {
    $self->{ASSIGNED_FIELDS} = 1;
    return;
  }

  $self->{ASSIGNED_FIELDS} = 2;
  $self->{ASSIGNED}[1] = $entry->{minor};
}


sub fix_of
{
  my ($self, $chapter_header, $map, $list) = @_;

  $self->get_assigned_fields($chapter_header);
  my $error = 0;
  for my $entry (@$list)
  {
    if ($entry->fix_of($self->{ASSIGNED}, $self->{OF}))
    {
      $error = 1;
    }
  }

  warn '---' if $error;
}


sub regroup
{
  my ($self) = @_;

  for my $i (reverse 0 .. $#{$self->{GROUPS}{none}})
  {
    my $none = $self->{GROUPS}{none}[$i];

    my $concat1 = lc($none->concat_team('TEAM1'));
    my $concat2 = lc($none->concat_team('TEAM2'));

    my $group1 = $self->{TEAM_TO_GROUP}{$concat1} // '';
    my $group2 = $self->{TEAM_TO_GROUP}{$concat2} // '';

    if ($group1 eq $group2 && $group1 ne '')
    {
      push @{$self->{GROUPS}{$group1}}, $none;
      splice(@{$self->{GROUPS}{none}}, $i, 1);
    }
    elsif ($group1 ne '' && $group2 eq '')
    {
      push @{$self->{GROUPS}{$group1}}, $none;
      splice(@{$self->{GROUPS}{none}}, $i, 1);
    }
    elsif ($group1 eq '' && $group2 ne '')
    {
      push @{$self->{GROUPS}{$group2}}, $none;
      splice(@{$self->{GROUPS}{none}}, $i, 1);
    }
    else
    {
      warn $none->bbono() . " groups: $concat1: $group1, $concat2: $group2";

      for my $key (sort keys %{$self->{TEAM_TO_GROUP}})
      {
        warn "  $key: " . $self->{TEAM_TO_GROUP}{$key};
      }
    }
  }

  if (exists $self->{GROUPS}{none} &&
      $#{$self->{GROUPS}{none}} == -1)
  {
    delete $self->{GROUPS}{none};
  }

  return $self->{GROUPS};
}


sub autogroup
{
  my ($self) = @_;

  # Check $self->{AUTOSYMM}, pairs of teams only.
  for my $concat1 (sort keys %{$self->{AUTOSYMM}})
  {
    my $ref1 = $self->{AUTOSYMM}{$concat1};
    if (scalar keys %$ref1 != 1)
    {
      for my $concat2 (sort keys %$ref1)
      {
        for my $entry (@{$ref1->{$concat2}})
        {
          warn $entry->bbono() . ": AUTOGROUP $concat1, $concat2";
        }
      }
      warn "---";
    }
  }

  my %flat;
  for my $concat1 (sort keys %{$self->{AUTO}})
  {
    my $ref1 = $self->{AUTO}{$concat1};
    for my $concat2 (keys %$ref1)
    {
      # There is only ever one.
      push @{$flat{$concat1 . $concat2}}, 
        @{$self->{AUTO}{$concat1}{$concat2}};
    }
  }

  return \%flat;
}


sub sort_counters
{
  my ($self, $list) = @_;

  @$list = sort
  {
    $a->spaceship($b, $self->{ASSIGNED});
  }
  @$list;
}


sub str_analysis
{
  my ($self) = @_;

  return "No counters at all\n" unless exists $self->{NUM_FIELDS};
  my $num_fields = $self->{NUM_FIELDS};

  my $s = "ANALYSIS:\n";
  $s .= "Number of fields: $num_fields\n";
  for my $i (0 .. $num_fields-1)
  {
    my $field = $self->{ANALYSIS}[$i];
    $s .= "FIELD $i count " . $self->{COUNTER}{$field}{COUNT} .  ": $field";
    if ($self->{OF}{$field})
    {
      $s .= " (of " . $self->{OF}{$field} . ")";
    }
    $s .= "\n";
  }
  return $s;
}


1;
