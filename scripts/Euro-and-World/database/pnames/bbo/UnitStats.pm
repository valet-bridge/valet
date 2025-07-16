#!perl

package UnitStats;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub add
{
  my ($self, $units) = @_;

  my $len = $units->last() + 1;
  $self->{LEN}[$len]{COUNT}++;

  for my $index (0 .. $units->last())
  {
    my $cat = $units->category($index);
    if ($cat eq 'WORD' || $cat eq 'HIGHWORD')
    {
      $self->{LEN}[$len]{WORD}++;
    }
    elsif ($cat eq 'PUNCTUATION')
    {
      $self->{LEN}[$len]{PUNCTUATION}++;
    }
    else
    {
      $self->{LEN}[$len]{REST}++;
    }
  }

  if ($units->is_complete())
  {
    $self->{LEN}[$len]{COMPLETE}++;
  }
}


sub print
{
  my ($self) = @_;

  printf("%4s %10s %10s %10s %10s %10s\n",
    "len", "COUNT", "REST", "WORD", "PUNCT", "COMPLETE");

  my $sum = 0;
  my $sumprod = 0;

  for my $len (0 .. $#{$self->{LEN}})
  {
    printf("%4d %10d %10d %10d %10d %10d\n",
      $len,
      $self->{LEN}[$len]{COUNT} // 0,
      $self->{LEN}[$len]{REST} // 0,
      $self->{LEN}[$len]{WORD} // 0,
      $self->{LEN}[$len]{PUNCTUATION} // 0,
      $self->{LEN}[$len]{COMPLETE} // 0);
    
    my $count = $self->{LEN}[$len]{COUNT} // 0;
    $sum += $count;
    $sumprod += $len * $count;
  }

  printf("\nAverage %8.2f\n\n", $sumprod / $sum);
}


1;
