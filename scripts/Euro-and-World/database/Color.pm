#!perl

package Color;

use strict;
use warnings;
use Exporter;
use v5.10;

my @COLOR_LIST = qw(Red White);

my %COLORS = map { $_ => 1} @COLOR_LIST;

sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $COLORS{$text} ? 1 : 0;
}

1;
