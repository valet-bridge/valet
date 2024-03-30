#!perl

package Movement;

use strict;
use warnings;
use Exporter;
use v5.10;

my @MOVEMENT_LIST = 
(
  "Barometer", # Not really a movement
  "Danish",
  "Goulash", # Not really a movement
  "Monrad",
  "Swiss",
  "Triangle"
);

my %MOVEMENT = map { $_ => 1} @MOVEMENT_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $MOVEMENT{$text} ? 1 : 0;
}


1;
