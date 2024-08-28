#!perl

package DateEst;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';


sub new
{
  my $class = shift;
  my $self = bless {}, $class;

  $self->read_dates_added('dates/dates.txt');
  $self->read_estimated_dates('dates/estmonth.txt');
  $self->read_dates_manual('dates/hardwired.txt');
  return $self;
}


sub read_dates_added
{
  my ($self, $fname, $dates) = @_;
  open my $fh, '<', $fname or die "Cannot read name $!";

  while (my $line = <$fh>)
  {
    if ($line !~ /^\s*(\d+)\s+(\d+)\s+(.*)$/)
    {
      die "Bad format: $line";
    }

    my ($seqno, $bbono, $date) = ($1, $2, $3);
    $self->{ADDED}{$bbono} = $date;
  }
}


sub read_estimated_dates
{
  my ($self, $fname, $est_dates) = @_;
  open my $fh, '<', $fname or die "Cannot read name $!";

  while (my $line = <$fh>)
  {
    if ($line !~ /^(\d\d\d\d-\d\d)\s+(\d+)\s+(\d+)$/)
    {
      die "Bad format: $line";
    }

    my ($yyyymm, $lo, $hi) = ($1, $2, $3);
    $self->{RANGES}{$yyyymm} = [$lo, $hi];
  }
}


sub read_dates_manual
{
  my ($self, $fname, $dates) = @_;
  open my $fh, '<', $fname or die "Cannot read name $!";

  while (my $line = <$fh>)
  {
    if ($line !~ /^(\d+)\s+(.*)$/)
    {
      die "Bad format: $line";
    }

    my ($bbono, $date) = ($1, $2);
    $self->{MANUAL}{$bbono} = $date;
  }
}



sub check_estimated_dates
{
  my ($self, $bbono) = @_;

  for my $key (keys %{$self->{RANGES}})
  {
    my $pair = $self->{RANGES}{$key};
    if ($bbono >= $pair->[0] && $bbono <= $pair->[1])
    {
      # Here we can return the $key if we want the format YYYY-DD.
      # But let's actually guess a date.
      while ($bbono >= 1 && ! exists $self->{ADDED}{$bbono})
      {
        $bbono--;
      }

      if (exists $self->{ADDED}{$bbono})
      {
        return $self->{ADDED}{$bbono} 
      }
      else
      {
        return 0;
      }
    }
  }
  return 0;
}


sub estimate_time_field
{
  my ($self, $bbono) = @_;

  if (exists $self->{ADDED}{$bbono})
  {
    return "DATE_ADDED " . $self->{ADDED}{$bbono} . "\n";
  }
  elsif (my $date = $self->check_estimated_dates($bbono))
  {
    return "DATE_ADDED " . $date . "\n";
  }
  if (exists $self->{MANUAL}{$bbono})
  {
    return "DATE_ADDED " . $self->{MANUAL}{$bbono} . "\n";
  }
  else
  {
    print "TTT No date added for $bbono";
    return '';
  }
}


1;
