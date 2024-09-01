#!perl

package RegCounter;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use lib '..';

my @FIELDS = qw(HALF MATCH PHASE QUARTER ROUND SCORING SEGMENT);

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

  return if $top_count == 0;

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

  my $form;
  my $major = '';
  my $minor = '';
  if ($top_no == 2)
  {
    $form = 'MAJOR_MINOR';
    $major = $occur[0]{FIELD};
    $minor = $occur[1]{FIELD};
  }
  elsif ($top_no == 1)
  {
    $form = 'MAJOR';
    $major = $occur[0]{FIELD};
  }
  else
  {
    warn "No clear picture";
  }

  $self->{ANALYSIS}{FORM} = $form;
  $self->{ANALYSIS}{MAJOR} = $major;
  $self->{ANALYSIS}{MINOR} = $minor;
}


sub str_analysis
{
  my ($self) = @_;

  return "No counters at all\n" unless defined $self->{ANALYSIS}{FORM};
  my $form = $self->{ANALYSIS}{FORM};

  my $s = "Form $form\n";
  if ($form eq 'MAJOR_MINOR')
  {
    $s .= "MAJOR " . $self->{ANALYSIS}{MAJOR} . "\n";
    $s .= "MINOR " . $self->{ANALYSIS}{MINOR} . "\n";
  }
  elsif ($form eq 'MAJOR')
  {
    $s .= "MAJOR " . $self->{ANALYSIS}{MAJOR} . "\n";
  }
  return $s;
}


1;
