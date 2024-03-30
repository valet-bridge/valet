#!perl

package Origin;

use strict;
use warnings;
use Exporter;
use v5.10;

my @ORIGIN_LIST = 
(
  "World",
  "Province",
  "Region",
  "City",
  "Club",
  "University",
  "Transnational",
  "Invitational",
  "Proam"
);

my %ORIGIN = map { $_ => 1} @ORIGIN_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $ORIGIN{$text} ? 1 : 0;
}


1;
