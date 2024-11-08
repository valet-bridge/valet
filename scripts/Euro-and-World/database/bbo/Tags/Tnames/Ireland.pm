#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Ireland;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Irish Invitational Pairs',
  'Irish Open Trials',
  'Full Tilt Irish Bridge Masters',
);

my %MULTI_TYPOS =
(
  'Irish Invitational Pairs' => [
    'ireland invitational pairs',
    'irish invitational matchpoints'],
  'Irish Open Trials' => [
    'ibu trials',
    'ireland trials',
    'ireland camrose trials',
    'ireland lady milne trials',
    'irish bridge union trials',
    'irish bridge union open trials',
    'irish camrose trials',
    'irish trials'],
);

my %SINGLE_TYPOS =
(
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos, $gsingle_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }

  while (my ($key, $value) = each %SINGLE_TYPOS)
  {
    @{$gsingle_typos->{$key}} = @$value;
  }
}

1;
