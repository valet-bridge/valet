#!perl

package Histo;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub incr
{
  my ($self, $tag) = @_;

  $self->{TAGS}{$tag}++;
  $self->{TOTAL}++;
}


sub print
{
  my ($self) = @_;

  for my $tag (sort keys %{$self->{TAGS}})
  {
    printf("%-20s %6d\n", $tag, $self->{TAGS}{$tag});
  }

  print "\n";
  print '-' x 27, "\n";

  printf("%-20s %6d\n\n", 'TOTAL', $self->{TOTAL});
}


1;
