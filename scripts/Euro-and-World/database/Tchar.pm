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
  MEMORIAL
  MOVEMENT
  ORGANIZER
  ORIGIN
  SCORING
  SPONSOR
  TNAME
  WEEKDAY
);

my @ITERATOR_LIST = 
(
  qw(Final Semi-final Semi Quarter-final Quarter Rof16
  Knock-out PreQF Playoff
  Berth Match Segment Set Session Section Stanza Stage Round
  Round-robin),
  'Super League'
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


sub set
{
  my $self = shift;
  my $num_args = @_;

  my $elem = $_[1];

  if ($num_args == 2 && $_[0] eq 'SINGLETON')
  {
    # ('SINGLETON', $elem).
    die "No singleton $elem->{CATEGORY}" unless 
      exists $SINGLETON{$elem->{CATEGORY}};

    $self->{TYPE} = 'SINGLETON';
    $self->{CATEGORY} = $elem->{CATEGORY};
    $self->{VALUE} = $elem->{VALUE};
  }
  elsif ($num_args == 4 && $_[0] eq 'COUNTER_SINGLE_OF')
  {
    # ('COUNTER_SINGLE_OF', $elem, value, of).

    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR';
    die "No iterator type $elem->{VALUE}" unless 
      exists $ITERATOR{$elem->{VALUE}};

    $self->{TYPE} = 'COUNTER';
    $self->{SUB_TYPE} = 'SINGLE_OF';
    $self->{CATEGORY} = $elem->{VALUE};
    $self->{ITERATOR_VALUE} = $_[2];
    $self->{ITERATOR_OF} = $_[3];

  }
  elsif ($num_args == 5 && $_[0] eq 'DATE')
  {
    # ('DATE', $elem, day, month, year).

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
  elsif ($self->{TYPE} eq 'COUNTER' &&
      $self->{SUB_TYPE} eq 'SINGLE_OF')
  {
    return $self->{CATEGORY} . ' ' . 
      $self->{ITERATOR_VALUE} . ' of ' .
      $self->{ITERATOR_OF};
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
