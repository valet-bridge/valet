#!perl

package Gender;

use strict;
use warnings;
use Exporter;
use v5.10;

my @GENDER_LIST = qw(Open Women Mixed Multiple);

my %GENDERS = map { $_ => 1} @GENDER_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $GENDERS{$text} ? 1 : 0;
}

1;
