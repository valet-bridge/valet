#!perl

package Age;

use strict;
use warnings;
use Exporter;
use v5.10;

my @AGE_LIST = qw(Open Seniors U31 U26 U21 U16 U13 Multiple);

my %AGES = map { $_ => 1} @AGE_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $AGES{$text} ? 1 : 0;
}


1;
