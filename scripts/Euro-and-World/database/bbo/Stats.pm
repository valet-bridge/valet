#!perl

package Stats;

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
  my ($self, $chains) = @_;

  $self->{COUNT}[$#$chains+1]++;

  my $open_flag = 0;
  for my $chain (@$chains)
  {
    my $status = $chain->status();
    $self->{LENGTH}[$chain->last()+1]{$status}++;
    $open_flag = 1 if $status eq 'OPEN';
  }
  return $open_flag;
}


sub print_count
{
  my ($self, $header) = @_;

  my $csum = 0;
  my $cprod = 0;
  print "\n$header chain count stats\n\n";
  printf("%6s%10s\n", "", "Count");

  for my $i (0 .. $#{$self->{COUNT}})
  {
    my $h = $self->{COUNT}[$i] || 0;
    printf("%6d%10d\n", $i, $h);
    $csum += $h;
    $cprod += $h * $i;
  }

  print '-' x 16, "\n";
  printf("%6s%10d\n\n", "Sum", $csum);
  printf("%6s%10d\n\n", "Count", $cprod);
}


sub print_length
{
  my ($self, $header) = @_;

  my %csum;
  print "\n$header chain length stats\n\n";
  printf("%6s%10s%10s%10s\n", "", "OPEN", "COMPLETE", "KILLED");

  for my $i (0 .. $#{$self->{LENGTH}})
  {
    my %h;
    for my $key (qw(OPEN COMPLETE KILLED))
    {
      if (exists $self->{LENGTH}[$i]{$key})
      {
        $h{$key} = $self->{LENGTH}[$i]{$key};
      }
      else
      {
        $h{$key} = 0;
      }
      $csum{$key} += $h{$key};
    }
    printf("%6d%10d%10d%10d\n", $i, $h{OPEN}, $h{COMPLETE}, $h{KILLED});
  }

  print '-' x 36, "\n";
  printf("%6s%10d%10d%10d\n\n", "Sum",
    $csum{OPEN}, $csum{COMPLETE}, $csum{KILLED});
}


sub print
{
  my ($self, $header) = @_;
  $self->print_count($header);
  $self->print_length($header);
}

1;
