#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meets::Supra;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Buffett Cup',
  'Cavendish Invitational',
  'Channel Trophy',
  'Neighbor Challenge'
);

my %MULTI_TYPOS =
(
  'Buffett Cup' => [
    'bufett cup',
    'buffet cup', 
    'buffett cups'], 
  'Channel Trophy' => ['channel trpohy'],
  'Neighbor Challenge' => ['neighbour challenge'],
);

my %SINGLE_TYPOS =
(
  "Buffett Cup" => ['buffett', 'buffet'],
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
