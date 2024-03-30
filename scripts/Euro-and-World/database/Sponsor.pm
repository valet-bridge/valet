#!perl

package Sponsor;

use strict;
use warnings;
use Exporter;
use v5.10;

my @SPONSOR_LIST = 
(
  'FX Securities',
  'Jet Immo',
  'KWS',
  'L&Y Law',
  'MULTICOMS',
  'Solakoglu',
  'SportAccord',
  'Vito'
);

my %SPONSORS = map { $_ => 1} @SPONSOR_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $SPONSORS{$text} ? 1 : 0;
}


1;
