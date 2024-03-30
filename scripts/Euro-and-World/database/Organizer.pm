#!perl

package Organizer;

use strict;
use warnings;
use Exporter;
use v5.10;

my @ORGANIZER_LIST = 
(
  "ABCL",
  "Bridge Base Online",
  "Bridge Club Saint Etoile",
  "CBAI",
  "EBL",
  "Guangdong Bridge Club",
  "Kepri Contract Bridge Association",
  "USBF"
);

my %ORGANIZERS = map { $_ => 1} @ORGANIZER_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $ORGANIZERS{$text} ? 1 : 0;
}


1;
