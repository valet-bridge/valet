#!perl

package Event::Preprocess;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(pre_process);


sub pre_process
{
  my ($chains) = @_;

  # At this point there is a single chain.
  # It's easier to solve some issues here.

  return;
}

1;
