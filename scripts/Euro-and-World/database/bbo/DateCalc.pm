#!perl

package DateCalc;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

# Can work with YYYY-MM-DD.
my $daysec = 24 * 3600;

use Time::Piece;

use overload '<' => \&compare_lt;

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_by_field
{
  my ($self, $str) = @_;
  $self->{BASE} = Time::Piece->strptime($str, "%Y-%m-%d");
}


sub compare_lt
{
  my ($self, $other) = @_;
  return $self->{BASE} < $other->{BASE};
}


sub distance
{
  my ($self, $lower, $upper) = @_;

  my $lowerT = Time::Piece->strptime($lower, "%Y-%m-%d");
  my $upperT = Time::Piece->strptime($upper, "%Y-%m-%d");

  if ($self->{BASE} < $lowerT)
  {
    return ($lowerT - $self->{BASE}) / $daysec;
  }
  elsif ($self->{BASE} > $upperT)
  {
    return ($self->{BASE} - $upperT) / $daysec;
  }
  else
  {
    return 0;
  }
}


1;
