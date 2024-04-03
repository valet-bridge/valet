#!perl

package Tchar;

use strict;
use warnings;
use Exporter;
use v5.10;

# Tournament characteristic.

my @SINGLETON_LIST = qw
(
  AGE
  CITY
  DATE
  COUNTRY
  FORM
  GENDER
  GROUP
  MEMORIAL
  MOVEMENT
  ORGANIZER
  ORIGIN
  SCORING
  SPONSOR
  TEMPORAL
  TNAME
  TOURNAMENT
  WEEKDAY
  YEAR
);

my @ITERATOR_LIST = 
(
  qw(Final Semi-final Semi Quarter-final Quarter Qletter 
  Rof12 Rof16 Rof18 Rof32 Rof64 Rof128
  Knock-out PreQF Playoff Qualifying Consolation Tiebreak
  Berth Place Bronze Half
  Match Segment Set Session Section Stanza Stage Round Tempo Part 
  R S Table Room Boards Weekend Week Group
  Day Top Round-robin Play),
  'Super League', 'Final Round', 'Qualifying Segment', 'Final Segment'
);

my %SINGLETON = map { $_ => 1} @SINGLETON_LIST;

my %ITERATOR = map { $_ => 1} @ITERATOR_LIST;

my %MONTHS = (
  'January' => '01',
  'February' => '02',
  'March' => '03',
  'April' => '04',
  'May' => '05',
  'June' => '06',
  'July' => '07',
  'August' => '08',
  'September' => '09',
  'October' => '10',
  'November' => '11',
  'December' => '12');


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub same
{
  my ($self, $elem) = @_;
  
  return 0 unless scalar keys %$self != scalar keys %$elem;

  for my $key (keys %$elem)
  {
    return 0 unless exists $self->{$key};
    return 0 unless $self->{$key} eq $elem->{$key};
  }
  return 1;
}


sub set_singleton
{
  my ($self, $elem) = @_;

  # ('SINGLETON', $elem).

  die "No singleton $elem->{CATEGORY}" unless 
    exists $SINGLETON{$elem->{CATEGORY}};

  if (exists $self->{TYPE})
  {
    die "Inconsistent singleton" unless $self->same($elem);
  }
  else
  {
    %$self = %$elem;
    $self->{TYPE} = 'SINGLETON';
  }
}


sub set_counter_none
{
  my ($self, $elem) = @_;
}


sub set
{
  my $self = shift;
  my $num_args = @_;

  my $elem = $_[1];

  if ($num_args == 2 && $_[0] eq 'SINGLETON')
  {
    $self->set_singleton($elem);
  }
  elsif ($num_args == 2 && $_[0] eq 'COUNTER_NONE')
  {
    # ('COUNTER_NONE', $elem).
    
    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR';
    die "No iterator type $elem->{VALUE}" unless 
      exists $ITERATOR{$elem->{VALUE}};

    if (exists $self->{TYPE})
    {
      die unless $self->{TYPE} eq 'COUNTER';
      die unless $self->{SUB_TYPE} eq 'EMPTY';
      die unless $self->{CATEGORY} eq $elem->{VALUE};
    }
    else
    {
      $self->{TYPE} = 'COUNTER';
      $self->{SUB_TYPE} = 'EMPTY';
      $self->{CATEGORY} = $elem->{VALUE};
    }
  }
  elsif ($num_args == 3 && $_[0] eq 'COUNTER_SINGLE')
  {
    # ('COUNTER_SINGLE', $elem, value).

    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR' || $elem->{CATEGORY} eq 'TABLE';
    die "No iterator type $elem->{VALUE}" unless 
      exists $ITERATOR{$elem->{VALUE}};

    if (exists $self->{TYPE})
    {
      die unless $self->{TYPE} eq 'COUNTER';
      die unless $self->{SUB_TYPE} eq 'SINGLE';
      die unless $self->{CATEGORY} eq $elem->{VALUE};

      if ($_[2] > $self->{ITERATOR_VALUE})
      {
        $self->{SUB_TYPE} = 'RANGE';
        $self->{ITERATOR_START} = $self->{ITERATOR_VALUE};
        $self->{ITERATOR_END} = $_[2];
        delete $self->{ITERATOR_VALUE};
      }
      else
      {
        die unless $self->{ITERATOR_VALUE} eq $_[2];
      }
    }
    else
    {
      $self->{TYPE} = 'COUNTER';
      $self->{SUB_TYPE} = 'SINGLE';
      $self->{CATEGORY} = $elem->{VALUE};
      $self->{ITERATOR_VALUE} = $_[2];
    }
  }
  elsif ($num_args == 4 && $_[0] eq 'COUNTER_DOUBLE')
  {
    # ('COUNTER_DOUBLE', $elem, value, letter).

    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR' || $elem->{CATEGORY} eq 'Generic';

    die "TYPE already set" if exists $self->{TYPE};

    $self->{TYPE} = 'COUNTER';
    $self->{SUB_TYPE} = 'DOUBLE';
    $self->{CATEGORY} = $elem->{CATEGORY};
    $self->{ITERATOR_VALUE} = $_[2];
    $self->{ITERATOR_LETTER} = $_[3];
  }
  elsif ($num_args == 4 && $_[0] eq 'COUNTER_SINGLE_OF')
  {
    # ('COUNTER_SINGLE_OF', $elem, value, of).

    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR' || $elem->{CATEGORY} eq 'TABLE';
    die "No iterator type $elem->{VALUE}" unless 
      exists $ITERATOR{$elem->{VALUE}};

    if (exists $self->{TYPE})
    {
      die unless $self->{TYPE} eq 'COUNTER';
      die unless $self->{SUB_TYPE} eq 'SINGLE_OF';
      die unless $self->{CATEGORY} eq $elem->{VALUE};
      die unless $self->{ITERATOR_VALUE} eq $_[2];
      die unless $self->{ITERATOR_OF} eq $_[3];
    }
    else
    {
      $self->{TYPE} = 'COUNTER';
      $self->{SUB_TYPE} = 'SINGLE_OF';
      $self->{CATEGORY} = $elem->{VALUE};
      $self->{ITERATOR_VALUE} = $_[2];
      $self->{ITERATOR_OF} = $_[3];
    }
  }
  elsif ($num_args == 3 && $_[0] eq 'COUNTER_GENERIC')
  {
    # ('COUNTER_GENERIC', $elem, value).

    if (exists $self->{TYPE})
    {
      die unless $self->{TYPE} eq 'COUNTER';
      die unless $self->{SUB_TYPE} eq 'SINGLE';
      die unless $self->{CATEGORY} eq 'Generic';
      die unless $self->{ITERATOR_VALUE} eq $_[2];
    }
    else
    {
      $self->{TYPE} = 'COUNTER';
      $self->{SUB_TYPE} = 'SINGLE';
      $self->{CATEGORY} = 'Generic';
      $self->{ITERATOR_VALUE} = $_[2];
    }
  }
  elsif ($num_args == 4 && $_[0] eq 'COUNTER_GENERIC_OF')
  {
    # ('COUNTER_GENERIC_OF', $elem, value, of).

    if (exists $self->{TYPE})
    {
      die unless $self->{TYPE} eq 'COUNTER';
      die unless $self->{SUB_TYPE} eq 'SINGLE_OF';
      die unless $self->{CATEGORY} eq 'Generic';
      die unless $self->{ITERATOR_VALUE} eq $_[2];
      die unless $self->{ITERATOR_OF} eq $_[3];
    }
    else
    {
      $self->{TYPE} = 'COUNTER';
      $self->{SUB_TYPE} = 'SINGLE_OF';
      $self->{CATEGORY} = 'Generic';
      $self->{ITERATOR_VALUE} = $_[2];
      $self->{ITERATOR_OF} = $_[3];
    }
  }
  elsif ($num_args == 5 && $_[0] eq 'DATE')
  {
    # ('DATE', $elem, day, month, year).

    if (exists $self->{TYPE})
    {
      die "DATE already set";
    }

    my $month = $_[3];
    $month = $MONTHS{$month} if exists $MONTHS{$month};

    my $day = $_[2];
    $day = '0' . $day if length($day) == 1;

    $self->{TYPE} = 'DATE';
    $self->{CATEGORY} = 'DATE';
    $self->{VALUE} = "$_[4]-$month-$day";
  }
  else
  {
    die "Don't know how to set this";
  }

  $self->{text} = $elem->{text};
  $self->{position_first} = $elem->{position_first};
  $self->{position_last} = $elem->{position_last};
}


sub str_no_newline
{
  my $self = shift;

  die "No type" unless exists $self->{TYPE};
  if ($self->{TYPE} eq 'SINGLETON')
  {
    return $self->{CATEGORY} . ' ' . $self->{VALUE};
  }
  elsif ($self->{TYPE} eq 'COUNTER')
  {
    if ($self->{SUB_TYPE} eq 'EMPTY')
    {
      return $self->{CATEGORY} . ' (empty)';
    }
    elsif ($self->{SUB_TYPE} eq 'SINGLE')
    {
      return $self->{CATEGORY} . ' ' . 
        $self->{ITERATOR_VALUE};
    }
    elsif ($self->{SUB_TYPE} eq 'DOUBLE')
    {
      return $self->{CATEGORY} . ' ' . 
        $self->{ITERATOR_VALUE} . ' ' .
        $self->{ITERATOR_LETTER};
    }
    elsif ($self->{SUB_TYPE} eq 'RANGE')
    {
      return $self->{CATEGORY} . ' ' . 
        $self->{ITERATOR_START} . '-' .
        $self->{ITERATOR_END};
    }
    elsif ($self->{SUB_TYPE} eq 'SINGLE_OF')
    {
      return $self->{CATEGORY} . ' ' . 
        $self->{ITERATOR_VALUE} . ' of ' .
        $self->{ITERATOR_OF};
    }
    elsif ($self->{SUB_TYPE} eq 'SINGLE')
    {
      return $self->{CATEGORY} . ' ' . 
        $self->{ITERATOR_VALUE};
    }
    else
    {
      die "Don't know how to str this";
    }
  }
  elsif ($self->{TYPE} eq 'DATE')
  {
    return $self->{CATEGORY} . ' ' . 
      $self->{VALUE};
  }
  else
  {
    die "Don't know how to str this";
  }
}


sub str
{
  my $self = shift;

  return $self->str_no_newline() . "\n";
}


sub str_ancillary
{
  my $self = shift;

  my $str = ' (pos ';
  if ($self->{position_first} eq $self->{position_last})
  {
    $str .= $self->{position_first};
  }
  else
  {
    $str .= $self->{position_first} . '-' . $self->{position_last};
  }
  $str .= ', orig ' . $self->{text} . ")";
  return $str;
}


sub str_full
{
  my $self = shift;

  return $self->str_no_newline() . $self->ancillary() . "\n";
}


1;
