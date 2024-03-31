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


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub set
{
  my $self = shift;
  my $num_args = @_;

  if ($num_args == 2 && $_[0] eq 'SINGLETON')
  {
    my $elem = $_[1];
    die "No singleton $elem->{CATEGORY}" unless 
      exists $SINGLETON{$elem->{CATEGORY}};

    $self->{TYPE} = 'SINGLETON';
    $self->{CATEGORY} = $elem->{CATEGORY};
    $self->{VALUE} = $elem->{VALUE};

    $self->{text} = $elem->{text};
    $self->{position_first} = $elem->{position_first};
    $self->{position_last} = $elem->{position_last};
  }
  elsif ($num_args == 4 && $_[0] eq 'COUNTER_SINGLE_OF')
  {
    # ('COUNTER_SINGLE_OF', $elem, $value, $of).

    my $elem = $_[1];
    die "No iterator $elem->{CATEGORY}" unless 
      $elem->{CATEGORY} eq 'ITERATOR';
    die "No iterator type $elem->{VALUE}" unless 
      exists $ITERATOR{$elem->{VALUE}};

    $self->{TYPE} = 'COUNTER';
    $self->{SUB_TYPE} = 'SINGLE_OF';
    $self->{CATEGORY} = $elem->{VALUE};
    $self->{ITERATOR_VALUE} = $_[2];
    $self->{ITERATOR_OF} = $_[3];

    $self->{text} = $elem->{text};
    $self->{position_first} = $elem->{position_first};
    $self->{position_last} = $elem->{position_last};
  }
  else
  {
    die "Don't know how to set this";
  }
}


sub str
{
  my $self = shift;

  die "No type" unless exists $self->{TYPE};
  if ($self->{TYPE} eq 'SINGLETON')
  {
    return $self->{CATEGORY} . ' ' . $self->{VALUE} . "\n";
  }
  elsif ($self->{TYPE} eq 'COUNTER' &&
      $self->{SUB_TYPE} eq 'SINGLE_OF')
  {
    return $self->{CATEGORY} . ' ' . 
      $self->{ITERATOR_VALUE} . ' of ' .
      $self->{ITERATOR_OF} .  "\n";
  }
  else
  {
    die "Don't know how to str this";
  }
}


sub str_full
{
  my $self = shift;

  die "No type" unless exists $self->{TYPE};
  if ($self->{TYPE} eq 'SINGLETON')
  {
    my $str = $self->{CATEGORY} . ' ' . $self->{VALUE} . '(pos ';
    if ($self->{position_first} eq $self->{position_last})
    {
      $str .= $self->{position_first};
    }
    else
    {
      $str .= $self->{position_first} . '-' . $self->{position_last};
    }
    $str .= ', orig ' . $self->{text} . ")\n";
    return $str;
  }
  else
  {
    die "Don't know how to str this";
  }
}



1;
