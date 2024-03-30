#!perl

package Form;

use strict;
use warnings;
use Exporter;
use v5.10;

my @FORM_LIST = 
(
  "Teams",
  "Pairs",
  "Individual"
);

my %FORM = map { $_ => 1} @FORM_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $FORM{$text} ? 1 : 0;
}


1;
