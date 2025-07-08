#!perl

package Butil;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(categorize);

sub categorize
{
  my ($whole, $tag_order, $text, $category, $value) = @_;

  for my $tag (@$tag_order)
  {
    my $fix = $whole->get_single($tag, lc($text));
    if (defined $fix->{CATEGORY})
    {
      $$category = $fix->{CATEGORY};
      $$value = $fix->{VALUE};
      return;
    }
  }

  my $ascii = ($text =~ tr/\x00-\x7E//);
  my $total = length($text);
  my $high = $total - $ascii;

  if ($high == 0)
  {
    # All ASCII.
    $$category = 'WORD';
    $$value = $text;
  }
  else
  {
    $$category = 'HIGH_WORD';
    $$value = $text;
  }
}

1;
