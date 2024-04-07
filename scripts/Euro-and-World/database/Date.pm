#!perl

package Date;

use strict;
use warnings;
use Exporter;
use v5.10;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  if ($text =~ /^\d\d\d\d-\d\d-\d\d$/)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}


1;
