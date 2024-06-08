#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package ScoringBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(study_scoring);


sub study_scoring
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
