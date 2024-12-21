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


my @FIELDS = qw(PHASE FLIGHT GROUP SECTION
  SESSION MATCH ROUND QUARTER HALF 
  SEGMENT SET STANZA PLACE TABLE);

my %FIELD_MAP;
$FIELD_MAP{$FIELDS[$_]} = $_ for (0 .. $#FIELDS);

# (given_field, present_field)
my %CONFUSION_MATRIX;
$CONFUSION_MATRIX{QUARTER}{SEGMENT} = 1;
$CONFUSION_MATRIX{SET}{SEGMENT} = 1;
$CONFUSION_MATRIX{STANZA}{SEGMENT} = 1;
$CONFUSION_MATRIX{MATCH}{ROUND} = 1;
$CONFUSION_MATRIX{ROUND}{MATCH} = 1;
$CONFUSION_MATRIX{ROUND}{SEGMENT} = 1;
$CONFUSION_MATRIX{ROUND}{SESSION} = 1;
$CONFUSION_MATRIX{SEGMENT}{ROUND} = 1;
$CONFUSION_MATRIX{SEGMENT}{MATCH} = 1;
$CONFUSION_MATRIX{SEGMENT}{SESSION} = 1;
$CONFUSION_MATRIX{SEGMENT}{HALF} = 1;
$CONFUSION_MATRIX{SEGMENT}{QUARTER} = 1;
$CONFUSION_MATRIX{SESSION}{SEGMENT} = 1;
$CONFUSION_MATRIX{SESSION}{SECTION} = 1;
$CONFUSION_MATRIX{SESSION}{ROUND} = 1;
$CONFUSION_MATRIX{SESSION}{MATCH} = 1;


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
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
      my $concat = $entry->concat_team($team);

      if (exists $self->{TEAM_TO_GROUP}{$concat})
      {
        if ($self->{TEAM_TO_GROUP}{$concat} ne $gvalue)
        {
          warn $tname . ", " . $entry->bbono() . ": Mismatch $gvalue vs. " .
            $self->{TEAM_TO_GROUP}{$concat};
        }
      }
      else
      {
        $self->{TEAM_TO_GROUP}{$concat} = $gvalue;
      }
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
    else
    {
      warn "$bbono: Haven't learned $value";
    }
  }

  if (exists $chapter->{groupon} && $chapter->{groupon} ne 'AUTO')
  {
    $self->register_groups($entry, $chapter, $counters, $tname);
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


sub get_leading_top_number
{
  my ($self, $top_no) = @_;

  # Find the number of fields per BBONO that occurs the most.
  # Return 0 if there are no fields, 1 otherwise.

  my @hist;
  for my $bbono (keys %{$self->{BBOCOUNT}})
  {
    $hist[$self->{BBOCOUNT}{$bbono}]++;
  }

  my $top_count = 0;
  for my $i (0 .. $#hist)
  {
    next unless exists $hist[$i];
    if ($hist[$i] > $top_count)
    {
      $top_count = $hist[$i];
      $$top_no = $i;
    }
  }

  return ($top_count > 0);


}


sub analyze
{
  my ($self, $header, $chapter) = @_;

  my $top_no;
  if (! $self->get_leading_top_number(\$top_no))
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

  my $first_zero = $#occur + 1;
  for my $i (0 .. $#occur)
  {
    if ($occur[$i]{COUNT} == 0)
    {
      $first_zero = $i;
      splice(@occur, $first_zero); 
      last;
    }
  }

  if ($first_zero > 3)
  {
    for my $bbono (keys %{$self->{BBOCOUNT}})
    {
      warn "BBONO $bbono";
    }
    for my $i (0 ..$#occur)
    {
      warn "$i $occur[$i]{FIELD} $occur[$i]{COUNT}\n";
    }
    die "Top number $first_zero";
  }

  my $num_counters_given = 0;
  $num_counters_given++ if exists $chapter->{major};
  $num_counters_given++ if exists $chapter->{minor};

  if ($first_zero == 0 && $first_zero != $num_counters_given &&
      $DEBUG_COUNTERS)
  {
    warn "\n\nWARN $first_zero tops, $num_counters_given expected";
    warn $header->{TOURNAMENT_NAME};
    warn $header->{YEAR};
    for my $bbono (sort keys %{$self->{BBOCOUNT}})
    {
      warn "  BBONO $bbono";
    }
    warn "---";
  }

  # Keep only the enough for the most frequent number of counters.
  $top_no = $first_zero;
  $self->{NUM_FIELDS} = $top_no;
  return if $top_no == 0;

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

  if ($first_zero != $num_counters_given && $DEBUG_COUNTERS)
  {
    warn "\n\nWARN $first_zero tops, $num_counters_given expected";
    warn $header->{TOURNAMENT_NAME};
    warn $header->{YEAR};
    warn $self->str_analysis();
    for my $bbono (sort keys %{$self->{BBOCOUNT}})
    {
      warn "  BBONO $bbono";
    }
    warn "---";
  }

  return unless $DEBUG_COUNTERS;
  if ($first_zero == $num_counters_given && 
    $num_counters_given == 1)
  {
    if ($self->{ANALYSIS}[0] ne $chapter->{major})
    {
      warn "\n\nWARN $first_zero tops: major mismatch";
      warn $header->{TOURNAMENT_NAME};
      warn $header->{YEAR};
      warn "$self->{ANALYSIS}[0] vs $chapter->{major}";
      warn $self->str_analysis();
      for my $bbono (sort keys %{$self->{BBOCOUNT}})
      {
        warn "  BBONO $bbono";
      }
      warn "---";
    }
  }
  elsif ($first_zero == $num_counters_given && 
      $num_counters_given == 2)
  {
    return if $self->{ANALYSIS}[0] eq $chapter->{major} &&
        $self->{ANALYSIS}[1] eq $chapter->{minor};
    return if $self->{ANALYSIS}[0] eq $chapter->{minor} &&
        $self->{ANALYSIS}[1] eq $chapter->{major};

    warn "\n\nWARN $first_zero tops: major/minor mismatch";
    warn $header->{TOURNAMENT_NAME};
    warn $header->{YEAR};
    warn "$self->{ANALYSIS}[0] vs $chapter->{major}";
    warn "$self->{ANALYSIS}[1] vs $chapter->{minor}";
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


sub align
{
  my ($self, $entry) = @_;

  # Look for pre-assigned counter names and match them up with
  # the ones we discovered ourselves.
  
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


sub fix_counters_new
{
  my ($self, $chapter_header, $map, $list) = @_;

  $self->get_assigned_fields($chapter_header);
  for my $entry (@$list)
  {
    $entry->fix_of($self->{ASSIGNED}, $self->{OF});
  }
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


sub sort_counters_new
{
  my ($self, $entry, $list) = @_;

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
  for my $field (sort keys %{$self->{FIELD_MAP}})
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
