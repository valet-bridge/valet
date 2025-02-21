#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::NewZealand;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Centre Island Open Teams',
  'New Zealand Inter-Provincial Open Teams',
  'New Zealand Mixed Trials',
  'New Zealand Open Teams',
  'New Zealand Open Trials',
  'New Zealand Women Trials',
);

my %MULTI_TYPOS =
(
  'Centre Island Open Teams' => ['ci teams'],
  'New Zealand Inter-Provincial Open Teams' => [
    'nz interprovincial',
    'nz interprovincials',
    'nz ips',
    'nz ip imtermidiate',
    'new zealand inter provincials'],
  'New Zealand Mixed Trials' => [
    'nz mixed trial',
    'nz mixed trials'],
  'New Zealand Open Teams' => ['nz teams'],
  'New Zealand Open Trials' => [
    'nz opentrial',
    'nzopen trials',
    'nz open trial',
    'nz open team trial'],
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
