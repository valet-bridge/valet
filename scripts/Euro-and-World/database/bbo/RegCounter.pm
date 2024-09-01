#!perl

package RegCounter;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

my @FIELDS = qw(PHASE MATCH ROUND SESSION QUARTER HALF SEGMENT TABLE);

my %FIELD_MAP;
$FIELD_MAP{$FIELDS[$_]} = $_ for (0 .. $#FIELDS);


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

    if ($value =~ /^\d+$/)
    {
      $self->{COUNTER}{$field}{SIMPLE}++;
    }
    elsif ($value =~ /^\d+ of (\d+)$/)
    {
      my $end = $1;
      $self->{COUNTER}{$field}{OF}++;
      $self->{COUNTER}{$field}{ENDS}{$end}++;
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
    $self->{ANALYSIS}{FORM} = 'EMPTY';
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
      $self->{OF}[$i] = 0;
    }
    elsif (my $of_end = has_of_structure($self->{COUNTER}{$field}{ENDS}))
    {
      $self->{OF}[$i] = $of_end;
    }
    else
    {
      print "WARN: Contradictory OF structure for '$field'\n";
    }
  }
}


sub str_analysis
{
  my ($self) = @_;

  return "No counters at all\n" unless defined $self->{NUM_FIELDS};
  my $num_fields = $self->{NUM_FIELDS};

  my $s = "Number of fields: $num_fields\n";
  for my $i (0 .. $num_fields-1)
  {
    $s .= "FIELD $i: " . $self->{ANALYSIS}[$i];
    if ($self->{OF}[$i])
    {
      $s .= " (of " . $self->{OF}[$i] . ")";
    }
    $s .= "\n";
  }
  return $s;
}


1;
