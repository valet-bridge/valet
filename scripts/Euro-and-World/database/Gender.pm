#!perl

package Gender;

use strict;
use warnings;
use Exporter;
use v5.10;

my @GENDER_LIST = qw(Open Men Women Mixed Multiple);

my %GENDERS = map { $_ => 1} @GENDER_LIST;

my %GENDERS_LC = map { lc($_) => 1} @GENDER_LIST;


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


sub valid_lc
{
  my ($self, $text) = @_;
  return exists $GENDERS_LC{lc($text)} ? 1 : 0;
}

1;
