#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Event::Ematch;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_repeats);

# BBOVG numbers for which special event occurrences are OK.

my @EMATCH = qw(
    827   

);


sub set_ematch
{
  my ($ematch) = @_;

  for my $e (@EMATCH)
  {
    $ematch->{$e} = 1;
  }
}

1;
