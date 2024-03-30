#!perl

package Memorial;

use strict;
use warnings;
use Exporter;
use v5.10;

my @MEMORIAL_LIST = 
(
  'Maharaja Holkar',
  'Mohan Sicka'
);

my %MEMORIAL = map { $_ => 1} @MEMORIAL_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $MEMORIAL{$text} ? 1 : 0;
}


1;
