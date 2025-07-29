#!perl

package Manual::TargetedWords;

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
    chomp $line;
    $self->{LIST}{$line} = 1;
  }
  close $fh;
}


sub lookup
{
  my ($self, $word) = @_;

  return exists $self->{LIST}{lc($word)};
}

1;
