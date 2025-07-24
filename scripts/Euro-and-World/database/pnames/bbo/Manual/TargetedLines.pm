#!perl

package Manual::TargetedLines;

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


sub read_file
{
  # Not a class method.
  my ($self, $fname) = @_;

  open(my $fh, "<$fname") or die "Cannot open $fname: $!";
  my $sno = 0;
  while (my $line = <$fh>)
  {
    $sno++;
    if ($line !~ /^(.+), (\d+), (\d+)$/)
    {
      die "FORMAT $fname, $sno: $line";
    }
    $self->{LIST}{$1}{$2}{$3} = 1;
  }
  close $fh;
}


sub lookup
{
  my ($self, $handle, $instance, $lno) = @_;

  return 0 unless exists $self->{LIST}{$handle};
  my $entry = $self->{LIST}{$handle};

  return 0 unless exists $entry->{$instance};
  my $lines = $entry->{$instance};

  return 0 unless exists $lines->{$lno};

  return 1;
}

1;
