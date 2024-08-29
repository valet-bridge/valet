#!perl

package DateCalc;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Can work with YYYY-MM-DD.
my $daysec = 365 * 24 * 3600;

use Time::Piece;

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_by_field
{
  my ($self, $str) = @_;
  $self->{BASE} = Time::Piece->strptime($1, "%Y-%m-%d");
}


sub distance
{
  my ($self, $lower, $upper) = @_;

  my $lowerT = Time::Piece->strptime($lower, "%Y-%m-%d");
  my $upperT = Time::Piece->strptime($upper, "%Y-%m-%d");

  if ($lowerT <= $self->{BASE})
  {
    return ($self->{BASE} - $lowerT) / $daysec;
  }
  elsif ($self->{BASE} <= $upperT)
  {
    return ($upperT - $self->{BASE}) / $daysec;
  }
  else
  {
    return 0;
  }
}


1;
