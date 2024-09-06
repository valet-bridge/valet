#!perl

package RegCounter;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

my @FIELDS = qw(PHASE MATCH ROUND SESSION SECTION QUARTER HALF 
  SEGMENT TABLE);

my %FIELD_MAP;
$FIELD_MAP{$FIELDS[$_]} = $_ for (0 .. $#FIELDS);

# (given_field, present_field)
my %CONFUSION_MATRIX;
$CONFUSION_MATRIX{ROUND}{MATCH} = 1;
$CONFUSION_MATRIX{ROUND}{SEGMENT} = 1;
$CONFUSION_MATRIX{ROUND}{SESSION} = 1;
$CONFUSION_MATRIX{SEGMENT}{ROUND} = 1;
$CONFUSION_MATRIX{SEGMENT}{SESSION} = 1;
$CONFUSION_MATRIX{SEGMENT}{HALF} = 1;
$CONFUSION_MATRIX{SESSION}{SECTION} = 1;


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub register
{
  my ($self, $entry) = @_;

  for my $field (@FIELDS)
  {
    my $value = $entry->field($field);
    next unless $value ne '';

    my $bbono = $entry->bbono();

    $self->{BBOHIST}{$bbono}{$field}++;
    $self->{BBOCOUNT}{$bbono}++;
    $self->{COUNTER}{$field}{COUNT}++;

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
    else
    {
      warn "Haven't learned $value";
    }
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


sub analyze
{
  my ($self) = @_;

  my @hist;
  for my $bbono (keys %{$self->{BBOCOUNT}})
  {
    $hist[$self->{BBOCOUNT}{$bbono}]++;
  }

  # Find the number of fields per BBONO that occurs most.
  my $top_count = 0;
  my $top_no;
  for my $i (0 .. $#hist)
  {
    next unless exists $hist[$i];
    if ($hist[$i] > $top_count)
    {
      $top_count = $hist[$i];
      $top_no = $i;
    }
  }

  if ($top_count == 0)
  {
    $self->{FORM} = 'EMPTY';
    return;
  }

  # Rank the fields by occurrence.
  my @occur;
  my $fno = 0;
  for my $field (@FIELDS)
  {
    $occur[$fno]{FIELD} = $field;
    $occur[$fno]{COUNT} = 0;
    $fno++;
  }

  for my $field (keys %{$self->{COUNTER}})
  {
    $occur[$FIELD_MAP{$field}]{COUNT} += $self->{COUNTER}{$field}{COUNT};
  }

  @occur = sort { $b->{COUNT} <=> $a->{COUNT} } @occur;

  # Keep only the enough for the most frequent number of counters.
  die "Top number $top_no" unless ($top_no >= 0 && $top_no < 4);
  $self->{NUM_FIELDS} = $top_no;
  return if $top_no == 0;

  splice(@occur, $top_no); 

  # Re-sort by hierarchical order.
  @occur = sort { $FIELD_MAP{$a->{FIELD}} <=> 
      $FIELD_MAP{$b->{FIELD}} } @occur;

  for my $i (0 .. $top_no-1)
  {
    my $field = $occur[$i]{FIELD};
    $self->{ANALYSIS}[$i] = $field;

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
  }
}


sub get_assigned_fields
{
  my ($self, $entry) = @_;

  my $v1 = $entry->number('major');
  if ($v1 eq '')
  {
    $self->{ASSIGNED_FIELDS} = 0;
  }
  else
  {
    $self->{ASSIGNED}[0] = $v1;

    my $v2 = $entry->number('minor');
    if ($v2 eq '')
    {
      $self->{ASSIGNED_FIELDS} = 1;
    }
    else
    {
      $self->{ASSIGNED_FIELDS} = 2;
      $self->{ASSIGNED}[1] = $v2;
    }
    # TODO Maybe there should be a third assigned level possible.
  }
}


sub align
{
  my ($self, $entry) = @_;

  # Look for pre-assigned counter names and match them up with
  # the ones we discovered ourselves.
  
  $self->get_assigned_fields($entry);
  return unless $self->{ASSIGNED_FIELDS} > 0;

  if (exists $self->{FORM} && $self->{FORM} eq 'EMPTY')
  {
    print "WARNING: Expecting some counter fields\n";
    return;
  }

  # $self->{FIELD_MAP}: Maps fields actually present to actions.

  # Note the fields from the analysis.
  for my $i (0 .. $#{$self->{ANALYSIS}})
  {
    my $field = $self->{ANALYSIS}[$i];
    $self->{ANALYSIS_FIELDS}{$field} = 1;
  }

  # For every given field, look for exact matches.
  for my $i (0 .. $self->{ASSIGNED_FIELDS}-1)
  {
    my $field = $self->{ASSIGNED}[$i];
    if (exists $self->{COUNTER}{$field})
    {
      $self->{FIELD_MAP}{$field} = $field;
    }

    # Take it out from unmatched analysis fields.
    if (exists $self->{ANALYSIS_FIELDS}{$field})
    {
      delete $self->{ANALYSIS_FIELDS}{$field};
    }
  }

  # Try to guess about unmatched, given fields.
  for my $i (0 .. $self->{ASSIGNED_FIELDS}-1)
  {
    my $given_field = $self->{ASSIGNED}[$i];
    next if exists $self->{FIELD_MAP}{$given_field};

    for my $analysis_field (keys %{$self->{ANALYSIS_FIELDS}})
    {
      if (exists $CONFUSION_MATRIX{$given_field}{$analysis_field})
      {
        $self->{FIELD_MAP}{$analysis_field} = $given_field;
        delete $self->{ANALYSIS_FIELDS}{$analysis_field};
      }
    }
  }

  # Look at any present, unmatched fields.
  for my $present_field (keys %{$self->{COUNTER}})
  {
    next if exists $self->{FIELD_MAP}{$present_field};

    my @confusion_list;
    for my $i (0 .. $self->{ASSIGNED_FIELDS}-1)
    {
      my $given_field = $self->{ASSIGNED}[$i];
      if (exists $CONFUSION_MATRIX{$given_field}{$present_field})
      {
        push @confusion_list, $given_field;
      }
    }

    if ($#confusion_list == -1)
    {
      if ($present_field eq 'TABLE' || $present_field eq 'PHASE')
      {
        # Permit it.
        $self->{FIELD_MAP}{$present_field} = $present_field;
      }
      else
      {
        # Not storing a match.
        print "WARNING: Deleting unmatched field $present_field\n";
        $self->{FIELD_MAP}{$present_field} = 'TO_DELETE';
      }
    }
    elsif ($#confusion_list > 0)
    {
      print "WARNING: More than one match for unmatched field $present_field\n";
      $self->{FIELD_MAP}{$present_field} = 'TO_DELETE';
    }
    else
    {
      $self->{FIELD_MAP}{$present_field} = $confusion_list[0];
    }
  }
}


sub fix_counters
{
  my ($self, $list) = @_;

  for my $entry (@$list)
  {
    $entry->fix_counters($self->{FIELD_MAP}, $self->{OF});
  }
}


sub sort_counters
{
  my ($self, $list) = @_;

  return unless exists $self->{ASSIGNED};

  @$list = sort
  {
    $a->spaceship($b, $self->{ASSIGNED});
  }
  @$list;
}


sub str_field_map
{
  my ($self) = @_;

  my $flag = 0;
  my $s = '';
  for my $field (keys %{$self->{FIELD_MAP}})
  {
    if ($self->{FIELD_MAP}{$field} ne $field)
    {
      $s .= "Mapping $field to " . $self->{FIELD_MAP}{$field} . "\n";
      $flag = 1;
    }
  }
  $s .= "\n" if $flag;
  return $s;
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
    $s .= "FIELD $i: $field";
    if ($self->{OF}{$field})
    {
      $s .= " (of " . $self->{OF}{$field} . ")";
    }
    $s .= "\n";
  }
  return $s;
}


1;
