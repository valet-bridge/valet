#!perl

package Caps::CapSplit;

# Tries to split a string on its capitalization.

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(split_on_caps);

use lib '.';

use Caps::Names;


sub split_on_caps
{
  my ($text, $splits) = @_;

  return unless (
      $text =~ /[a-z]{2,}[A-Z]/ &&
      $text =~ /^[a-zA-Z]/ &&
      $text !~ /^[a-z][A-Z]/);

  return Caps::Names::split($text, $splits);
}

1;
