#!perl

package Scoring::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';


our @ISA = qw(Exporter);
our @EXPORT = qw(study);


sub study
{
  my ($text, $result, $bbono) = @_;

  return unless defined $text;

  if ($text eq 'I')
  {
    $result->{SCORING} = 'IMPs';
  }
  elsif ($text eq 'P')
  {
    $result->{SCORING} = 'Pairs';
  }
  elsif ($text eq 'B')
  {
    $result->{SCORING} = 'BAM';
  }
  else
  {
    die "$bbono: Unknown scoring $text";
  }
}


1;
