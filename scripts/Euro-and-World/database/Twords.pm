#!perl

package Twords;

use strict;
use warnings;
use Exporter;
use v5.10;

my @TOURNAMENT_WORDS_LIST = 
(
  'Championship', 
  'Cup',
  'Trophy',
  'League',
  'Olympiad',
  'Open',
  'Tournament',
  'Trials', 
  'Super',
  'Super League',
  'Welcome'
);

my %TOURNAMENT_WORDS = map { $_ => 1} @TOURNAMENT_WORDS_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $TOURNAMENT_WORDS{$text} ? 1 : 0;
}

1;
