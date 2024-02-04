#!perl

package Organizer;

use strict;
use warnings;
use Exporter;
use v5.10;

my @ORGANIZER_LIST = qw(EBL WBF EOC IOC BFAME CSB);

my %ORGANIZERS;
$ORGANIZERS{$_} = 1 for @ORGANIZER_LIST;


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
