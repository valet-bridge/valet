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
use Caps::Fragments;
use Caps::Cuts;


sub split_on_caps
{
  my ($whole, $tag_list, $text, $splits, $lno) = @_;

  return unless (
      $text =~ /[a-z]{2,}[A-Z]/ &&
      $text =~ /^[a-zA-Z]/ &&
      $text !~ /^[a-z][A-Z]/);

  if (Caps::Names::split($text, $splits))
  {
    return 1;
  }

  if (Caps::Fragments::match($text, $splits))
  {
    return 1;
  }

  if (Caps::Cuts::divide($whole, $tag_list, $text, $splits))
  {
    return 1;
  }

  return 0;
}

1;
