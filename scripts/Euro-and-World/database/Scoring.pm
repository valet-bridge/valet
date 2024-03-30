#!perl

package Scoring;

use strict;
use warnings;
use Exporter;
use v5.10;

my @SCORING_LIST = 
(
  "MP",
  "IMP",
  "BAM"
);

my %SCORING = map { $_ => 1} @SCORING_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $SCORING{$text} ? 1 : 0;
}


1;
