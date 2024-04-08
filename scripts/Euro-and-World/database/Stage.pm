#!perl

package Stage;

use strict;
use warnings;
use Exporter;
use v5.10;

my @STAGE_LIST = 
(
  'Qualifying',
  'Round-robin',
  'PreQF',
  'Knock-out',
  'Rof12',
  'Rof16',
  'Rof18',
  'Rof32',
  'Rof64',
  'Rof128',
  'Final',
  'Semi',
  'Semi-final',
  'Quarter-final',
  'Tiebreak',
  'Playoff',
  'Consolation',
  'Bronze',
  'Play'
);

my %STAGES = map { $_ => 1} @STAGE_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $STAGES{$text} ? 1 : 0;
}


1;
