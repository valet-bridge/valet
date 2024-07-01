#!perl

package Util;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(ordinal_to_numeral);


sub ordinal_to_numeral
{
  my $part = pop;
  if
     ($part =~ /^(\d+)th$/i ||
      $part =~ /^(\d+)rth$/i ||
      $part =~ /^(\d+)st$/i ||
      $part =~ /^(\d+)rst$/i ||
      $part =~ /^(\d+)rd$/i ||
      $part =~ /^(\d+)er$/i ||
      $part =~ /^(\d+)e$/i ||
      $part =~ /^(\d+)eme$/i ||
      $part =~ /^(\d+)°$/i ||
      $part =~ /^(\d+)º$/i ||
      $part =~ /^(\d+)ª$/i ||
      $part =~ /^(\d+)nd$/i)
  {
    my $ord = $1;
    if ($ord < 0 || $ord >= 100)
    {
      die "Large ordinal? $ord";
    }
    return $1;
  }
  elsif (lc($part) eq 'first')
  {
    return 1;
  }
  elsif (lc($part) eq 'second')
  {
    return 2;
  }
  else
  {
    return 0;
  }
}


1;
