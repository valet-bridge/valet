#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Belgium;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Belgian Open Pairs',
  'Belgian Open Teams',
  'Belgian Open Trials',
  'Belisol Invitational Pairs',
);

my %MULTI_TYPOS =
(
  'Belgian Open Pairs' => ['belgian open paris'],
  'Belgian Open Teams' => [
    'belgian team',
    'belgian team championship', 
    'belgian teams', 
    'belgium championship',
    'belgian open team',
    'belgium open teams'], 
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
