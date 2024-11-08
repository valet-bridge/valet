#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Russia;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'BKBT Teams',
  'Moscow Sunday Times Pairs',
  'Moscow Sunday Times Teams',
  'NN Cup',
  'Russian IMSA Cup',
  'Russian Open Teams',
  'Russian Premier League',
  'Slava Cup',
);

my %MULTI_TYPOS =
(
  'BKBT Teams' => ['bkbt match'],
  'NN Cup' => [
    'goulyash by e. gladysh',
    'goulyash by e_gladysh',
    'nn-cup'],
  'Russian IMSA Cup' => ['imsa cup'],
  'Russian Open Teams' => [
    'russian teams championship',
    'russian team championship'],
  'Russian Premier League' => ['russian premiere league'],
  'Slava Cup' => [
    'cup slava', 
    'salava cup'],
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
