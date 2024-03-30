#!perl

package Weekday;

use strict;
use warnings;
use Exporter;
use v5.10;

my @WEEKDAY_LIST = qw(Monday Tuesday Wednesday Thursday Friday
  Saturday Sunday);

my %WEEKDAY = map { $_ => 1} @WEEKDAY_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $WEEKDAY{$text} ? 1 : 0;
}


1;
