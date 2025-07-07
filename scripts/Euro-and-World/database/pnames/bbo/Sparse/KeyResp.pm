#!perl

package Sparse::KeyResp;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(look_for_responses);

use lib '..';
use Units;


sub look_for_responses
{
  my ($units, $integer_counts, $chain_stats) = @_;

  my @streaks;
  $units->get_number_streaks(\@streaks);

  my $count = 0;
  for my $streak (@streaks)
  {
    my $text = '';
    for my $elem (@$streak)
    {
      my $v = $units->value($elem);
      $integer_counts->{$v}++;
      $text .= $v . ' ';
    }
    print "CAND $count: $text\n";
    $count++;
  }

  if ($count)
  {
    $units->print_context(0, $units->last(), 'ORIG');
    print "\n";
  }

}

1;
