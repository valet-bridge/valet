#!perl

package Form;

use strict;
use warnings;
use Exporter;
use v5.10;

my %FORM = (
  Individual => "Individual",
  Teams => "Teams",
  "BAM Teams" => "Teams",
  "Pairs" => "Pairs",
  "IMP Pairs" => "Pairs",
  "Swiss Pairs" => "Pairs"
  );


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


sub code
{
  my ($self, $text) = @_;
  return $FORM{$text};
}


1;
